-- Tanzania Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search. hero_image_url left NULL at
-- authoring time (no photo bundle supplied yet).
--
-- IMPORTANT SOURCING CAVEAT: the primary government sources
-- (visa.immigration.go.tz, www.immigration.go.tz, and
-- www.in.tzembassy.go.tz — Tanzania High Commission, New Delhi) were
-- NOT directly fetchable this session (network egress blocked to those
-- domains). Findings below are triangulated across multiple
-- independent secondary sources returned by web search — travel/visa
-- agencies, regional tourism-industry bodies (e.g. KATA Kenya, ATTA),
-- and other Tanzanian embassy mirror sites (Nigeria, Canada, Malaysia,
-- Washington DC) that republish the same official fee/permit-class
-- tables — and cross-checked for consistency across at least two
-- independent sources wherever possible. Figures that could not be
-- cross-confirmed are explicitly flagged as approximate or
-- "NOT independently confirmed this session" in the relevant notes,
-- fees, and FAQs below (most notably: the Sports category, the exact
-- Transit visa duration, the Referral-visa country list, and Class
-- A/B/C permit fee amounts).
--
-- Tanzania's real, distinctive, dated facts verified this session:
--   - Tanzania made its e-Visa MANDATORY from January 2025, suspending
--     visa-on-arrival for foreign visitors — a genuine, dated policy
--     shift reflected throughout every category below.
--   - Tanzania's own visa-category definitions officially BUNDLE
--     tourism, family visits, conferences, and medical treatment under
--     one single "Ordinary Visa" purpose list (reported ~US$50), while
--     Business is a distinct, separately priced category (~US$250) —
--     mirrored here across Tourist/Family Visit/Medical/Conference.
--   - Zanzibar (semi-autonomous but sharing Tanzania's visa regime)
--     introduced mandatory travel insurance (~US$44 adults / US$22
--     children 3-17, via the Zanzibar Insurance Corporation) from
--     October 2024; mainland Tanzania has since announced a similar
--     mandatory travel-insurance requirement (~US$44, ~62-day
--     validity) for the 2025/26 fiscal year — a genuinely new,
--     currently-rolling-out cost layer distinct from the visa fee
--     itself.
--   - Work authorization runs through Class A (investors/business
--     owners), Class B (expatriate employees), and Class C (students,
--     researchers, volunteers, missionaries, retirees) permits, with
--     Indian nationals reported among the largest expatriate worker
--     groups in Tanzania's manufacturing, trading, and services
--     sectors — and Indian academic/police-clearance documents
--     requiring dual attestation by India's Ministry of External
--     Affairs AND the Tanzania High Commission, New Delhi.
--   - Tanzania has one of the oldest and largest Indian diaspora
--     communities in East Africa: Gujarati trading families settled
--     from as early as the 13th-14th centuries, with a major
--     population inflow after the Sultan of Oman moved his capital to
--     Zanzibar in 1840. Numbering roughly 110,000 at independence in
--     the early 1960s, the community nearly halved after 1960s-70s
--     socialist nationalization pushed many to the UK and Canada; more
--     than 60,000 Tanzanian citizens of Indian descent remain today,
--     concentrated around Dar es Salaam, Zanzibar, Tanga, and other
--     coastal towns. This genuinely shapes Family Visit and Dependent
--     applications, which are reflected below.
--
-- country_id 49 = Tanzania. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical,
-- 8=Conference, 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Ordinary Visa (Single Entry)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    49, 1, 'TZA-TOUR-IN-01', '2026.09', 'published',
    'Leisure, safari, and sightseeing travel to mainland Tanzania and Zanzibar.',
    'Indian passport holders apply for Tanzania''s Ordinary Visa (single entry) via the mandatory e-Visa portal — visa-on-arrival was suspended in January 2025. One e-Visa covers mainland Tanzania and Zanzibar.',
    'Single entry, up to 90 days',
    'Online e-Visa via visa.immigration.go.tz; apply well ahead since visa-on-arrival ended January 2025',
    1,
    'Officially 2-10 business days; secondary sources commonly cite 4-10 working days',
    'Tanzania Immigration Department (online e-Visa); Tanzania High Commission, New Delhi',
    'Create an account on the Tanzania e-Visa portal\nComplete the online Ordinary Visa application form\nUpload passport, photo, and supporting documents\nPay the US$50 fee online\nPrint the e-Visa approval and carry it while travelling',
    '/assets/images/visa-heroes/tanzania.webp',
    'Cross-checked across travel-agency and embassy-mirror secondary sourcing; visa.immigration.go.tz and in.tzembassy.go.tz not directly fetchable this session', 'https://visa.immigration.go.tz/guidelines', '2026-09-17'
);
SET @tza1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tza1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tza1, 'Core Documents', 'Required from every applicant.', 1);
SET @tza1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tza1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@tza1s1, 'Passport-Size Photograph', NULL, 'original', 1, 0, 1, 2),
(@tza1s1, 'e-Visa Approval Printout', NULL, 'copy', 1, 0, 1, 3),
(@tza1s1, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 4);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tza1, 'Supporting Documents', 'Evidence of your travel plans, funds, and required insurance.', 2);
SET @tza1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tza1s2, 'Confirmed Hotel/Safari Booking', NULL, 'copy', 1, 0, 0, 1),
(@tza1s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 2),
(@tza1s2, 'Mandatory Travel Insurance Certificate', 'Required for Zanzibar since Oct 2024 (~US$44); a similar mainland requirement is rolling out for FY2025/26.', 'if_applicable', 0, 1, 0, 3),
(@tza1s2, 'Yellow Fever Vaccination Certificate', 'Commonly requested if arriving from/transiting a yellow-fever-endemic country.', 'if_applicable', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(49, 1, 50.00, 'USD', 'Ordinary Visa (Single Entry) Fee', 'Non-refundable even if denied. Separately, Zanzibar has required mandatory travel insurance (~US$44 adults) since Oct 2024; mainland Tanzania announced a similar requirement for FY2025/26 — confirm current mainland status before travel.', '2026-09-01', NOW(), 'https://visa.immigration.go.tz/guidelines', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Has visa-on-arrival been discontinued for Tanzania?', 'Yes — Tanzania introduced a mandatory e-Visa requirement for all visitors from January 2025, suspending visa-on-arrival. Apply online before you travel.', 49, 1, 4901, 1),
('Do I need a separate visa for Zanzibar?', 'No — one Tanzania e-Visa covers both the mainland and Zanzibar. Zanzibar has separately required mandatory travel insurance (~US$44) since October 2024, and mainland Tanzania has announced a similar requirement.', 49, 1, 4902, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Business Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    49, 2, 'TZA-BUS-IN-02', '2026.09', 'published',
    'Trade negotiations, meetings, and commercial assignments in Tanzania for up to three months.',
    'Indian nationals conducting business, trade, or a professional assignment apply for Tanzania''s dedicated Business Visa via the e-Visa portal — a separate, higher-fee category from the Ordinary Visa, not extendable beyond its validity.',
    'Single or multiple entry, up to 90 days, not extendable',
    'Online e-Visa via visa.immigration.go.tz with host invitation and employer forwarding letter',
    1,
    'Reported at roughly 4-10 working days, similar to the Ordinary Visa track',
    'Tanzania Immigration Department (online e-Visa); Tanzania High Commission, New Delhi',
    'Obtain an invitation letter from your Tanzanian host company\nGather your employer''s forwarding letter and the host''s registration proof\nComplete the online e-Visa application under the Business category\nUpload documents and pay the US$250 fee\nPrint the e-Visa approval before travel',
    '/assets/images/visa-heroes/tanzania.webp',
    'Cross-checked across travel-agency and embassy-mirror secondary sourcing; visa.immigration.go.tz and in.tzembassy.go.tz not directly fetchable this session', 'https://visa.immigration.go.tz/guidelines', '2026-09-17'
);
SET @tza2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tza2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tza2, 'Core Documents', 'Required from every applicant.', 1);
SET @tza2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tza2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@tza2s1, 'Invitation Letter from Tanzanian Host Company', NULL, 'original', 1, 0, 1, 2),
(@tza2s1, 'Host Company Registration/Incorporation Proof', NULL, 'copy', 0, 1, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tza2, 'Supporting Documents', 'Evidence of your own employment and financial responsibility.', 2);
SET @tza2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tza2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@tza2s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 2),
(@tza2s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(49, 2, 250.00, 'USD', 'Business Visa Fee', 'Reported consistently across secondary sourcing referencing the Tanzania High Commission New Delhi fee schedule — five times the Ordinary Visa fee; confirm directly before applying.', '2026-09-01', NOW(), 'https://visa.immigration.go.tz/guidelines', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Why is the Business visa fee so much higher than the Tourist visa?', 'Tanzania treats Business as a distinct visa category (~US$250) from the Ordinary Visa (~US$50) used for tourism, family visits, conferences, and medical treatment. Commercial/trade purposes are priced separately.', 49, 2, 4903, 1),
('Can I extend a Tanzania Business visa if my trip runs long?', 'No — Business visas are issued for a fixed period up to 90 days and are reported as not extendable. You would need to apply for a fresh visa for a later trip.', 49, 2, 4904, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Entry Visa + Class C Student Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    49, 3, 'TZA-STU-IN-03', '2026.09', 'published',
    'Enrolling in a recognized Tanzanian educational institution.',
    'Indian students admitted to a Tanzanian institution enter on an entry/student e-Visa, then must obtain a Class C Student Residence Permit after arrival to legalize their stay — the permit is separate from, and in addition to, the entry visa.',
    'Permit validity tied to the course duration, renewable',
    'Apply for the entry e-Visa online before travel; apply for the Class C Student Permit with Tanzania Immigration after arrival',
    1,
    'Entry e-Visa reported at 4-10 working days; the Class C permit reported at roughly 2-4 weeks after arrival',
    'Tanzania Immigration Department; Class C Student Permit processed in-country after arrival',
    'Secure an admission/acceptance letter from a recognized Tanzanian institution\nApply online for an entry/student e-Visa before travel\nTravel to Tanzania and report to the institution\nApply for the Class C Student Residence Permit with Tanzania Immigration\nPay the permit fee and collect the permit',
    '/assets/images/visa-heroes/tanzania.webp',
    'Cross-checked across travel-agency and immigration-portal secondary sourcing; visa.immigration.go.tz and www.immigration.go.tz not directly fetchable this session', 'https://www.immigration.go.tz/index.php/fees/permit-fees/residence-permit-class-c', '2026-09-17'
);
SET @tza3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tza3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tza3, 'Core Documents', 'Required from every applicant.', 1);
SET @tza3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tza3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@tza3s1, 'Admission/Acceptance Letter from Tanzanian Institution', NULL, 'original', 1, 0, 1, 2),
(@tza3s1, 'Entry/Student e-Visa Approval', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tza3, 'Supporting Documents', 'Evidence of your academic background, funds, and health cover.', 2);
SET @tza3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tza3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@tza3s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2),
(@tza3s2, 'Medical/Health Certificate', NULL, 'if_applicable', 0, 1, 0, 3),
(@tza3s2, 'Guardian Consent (Minors)', NULL, 'if_applicable', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(49, 3, NULL, 'USD', 'Confirmed After Assessment (Class C Student Permit)', 'Class C Student Permit fee reported at roughly US$50-250 depending on course/level, payable after arrival, separate from the entry e-Visa fee — confirm the exact figure per course with the institution/immigration office.', '2026-09-01', NOW(), 'https://www.immigration.go.tz/index.php/fees/permit-fees/residence-permit-class-c', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does the Tanzania student e-Visa alone let me study?', 'No — you also need the Class C Student Residence Permit, applied for with Tanzania Immigration after you arrive. The entry e-Visa alone does not legalize a study stay.', 49, 3, 4905, 1),
('How much does the Class C Student Permit cost?', 'Reported in the roughly US$50-250 range depending on the course/institution — treat this as approximate and confirm the exact fee for your specific program before budgeting.', 49, 3, 4906, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Class A / Class B Work Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    49, 4, 'TZA-WORK-IN-04', '2026.09', 'published',
    'Employment with a Tanzanian employer under a Class A (investor) or Class B (expatriate employee) work permit.',
    'Indian nationals with a confirmed Tanzanian job offer or investment role apply through the sponsoring employer/company for a Class A or Class B work permit via Tanzania''s e-Permit system; academic and police-clearance documents must be attested by India''s Ministry of External Affairs and the Tanzania High Commission, New Delhi.',
    'Permit validity roughly 4-24 months, tied to the employment contract, renewable',
    'Employer/company-driven e-Permit application; applicant typically enters Tanzania first on a Business visa',
    1,
    'Reported at 4-8 weeks for Class A (investors), 4-6 weeks for Class B (expatriate staff); can run longer at peak periods',
    'Tanzania Immigration Department (Labour Commissioner for Class A); Tanzania High Commission, New Delhi for attestation',
    'Secure a job offer or investment role with a Tanzanian employer/company\nEmployer (Class A) or sponsoring organisation (Class B) files the e-Permit application with Tanzania Immigration\nGet Indian academic certificates and police clearance attested by the MEA and the Tanzania High Commission, New Delhi\nEnter Tanzania on a Business visa while the permit is processed\nReceive the Class A/B permit and register locally',
    '/assets/images/visa-heroes/tanzania.webp',
    'Cross-checked across the Tanzania High Commission New Delhi permit page (via search-indexed snippets) and expatriate-employment secondary sourcing; not directly fetchable this session', 'https://www.in.tzembassy.go.tz/index.php/services/residence-and-work-permits-class-a-b-and-c', '2026-09-17'
);
SET @tza4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tza4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tza4, 'Core Documents', 'Required from every applicant.', 1);
SET @tza4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tza4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@tza4s1, 'Employment Contract or Investment Documents', NULL, 'copy', 1, 0, 1, 2),
(@tza4s1, 'e-Permit Application Confirmation', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tza4, 'Supporting Documents', 'Attested credentials and employer-side justification.', 2);
SET @tza4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tza4s2, 'Attested Academic Certificates (MEA + Tanzania High Commission)', NULL, 'original', 1, 0, 0, 1),
(@tza4s2, 'Attested Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2),
(@tza4s2, 'CV/Resume', NULL, 'copy', 1, 0, 0, 3),
(@tza4s2, 'Justification Letter from Employer', NULL, 'original', 1, 0, 0, 4),
(@tza4s2, 'Passport-Size Photographs', NULL, 'original', 1, 0, 0, 5);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(49, 4, NULL, 'USD', 'Confirmed After Assessment (Class A/B Permit)', 'Official Class A/B permit fee schedule was not directly obtainable this session (immigration.go.tz fee pages blocked). Indian nationals are reported among the largest expatriate worker groups in Tanzania''s manufacturing, trading, and services sectors — confirm the current fee with Tanzania Immigration or your employer.', '2026-09-01', NOW(), 'https://www.in.tzembassy.go.tz/index.php/services/residence-and-work-permits-class-a-b-and-c', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What''s the difference between Class A and Class B work permits?', 'Class A is for foreign investors/business owners, with the employer/company applying to the Labour Commissioner. Class B is for expatriate employees hired by a Tanzanian company. Class C covers other residents such as students, researchers, and missionaries.', 49, 4, 4907, 1),
('Can I start working as soon as I land in Tanzania?', 'No — working before your Class A or B permit is approved and issued is a criminal offence in Tanzania that can lead to fines, deportation, and re-entry bans. Most applicants enter first on a Business visa while the permit is processed.', 49, 4, 4908, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Ordinary Visa (Single Entry)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    49, 5, 'TZA-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives or family friends resident in Tanzania, including the long-established Indian-origin community.',
    'Indian nationals visiting family apply for the standard Ordinary Visa — the same single-entry e-Visa category used for tourism, conferences, and medical treatment — with an invitation letter and proof of relationship from the Tanzania-resident host.',
    'Single entry, up to 90 days',
    'Online e-Visa via visa.immigration.go.tz with host invitation letter and relationship proof',
    1,
    'Reported at roughly 4-10 working days, the same track as the Ordinary Visa',
    'Tanzania Immigration Department (online e-Visa); Tanzania High Commission, New Delhi',
    'Obtain an invitation letter from your host/relative resident in Tanzania\nGather documents proving the family relationship\nComplete the online Ordinary Visa application, selecting family visit as purpose\nUpload documents, pay the fee, and print the approval before travel',
    '/assets/images/visa-heroes/tanzania.webp',
    'Cross-checked across travel-agency and embassy-mirror secondary sourcing; visa.immigration.go.tz and in.tzembassy.go.tz not directly fetchable this session', 'https://visa.immigration.go.tz/guidelines', '2026-09-17'
);
SET @tza5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tza5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tza5, 'Core Documents', 'Required from every applicant.', 1);
SET @tza5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tza5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@tza5s1, 'Invitation Letter from Tanzania-Resident Host', NULL, 'original', 1, 0, 1, 2),
(@tza5s1, 'Proof of Relationship (Marriage/Birth Certificates)', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tza5, 'Supporting Documents', 'Evidence of the host''s status and your own means.', 2);
SET @tza5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tza5s2, 'Host''s Residence Permit/Citizenship Copy', NULL, 'copy', 1, 0, 0, 1),
(@tza5s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 2),
(@tza5s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(49, 5, 50.00, 'USD', 'Ordinary Visa (Family Visit) Fee', 'Family Visit is not a separate Tanzanian visa category — it is one of the purposes explicitly covered under the single-entry Ordinary Visa alongside tourism, conferences, and medical treatment.', '2026-09-01', NOW(), 'https://visa.immigration.go.tz/guidelines', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a distinct "Family Visit" visa in Tanzania?', 'No — Tanzania''s Ordinary Visa purpose list officially bundles tourism, family visits, conferences, and medical treatment under one single-entry category (~US$50). There is no separately priced family-visit visa.', 49, 5, 4909, 1),
('Does Tanzania''s historic Indian community make family visits easier?', 'Documentation requirements are the same as any Ordinary Visa applicant, but Tanzania''s over-century-old Indian diaspora (concentrated around Dar es Salaam and Zanzibar, with more than 60,000 Tanzanian citizens of Indian descent) means many Indian applicants are visiting genuinely long-settled relatives rather than recent migrants.', 49, 5, 4910, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Transit Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    49, 6, 'TZA-TRAN-IN-06', '2026.09', 'published',
    'Passing through Tanzania (commonly Dar es Salaam or Zanzibar) en route to another destination.',
    'Indian nationals transiting Tanzania generally require a Transit Visa; sources are inconsistent on exact permitted duration (some cite up to 7 days per entry, others a much shorter same-day window), so confirm your specific itinerary''s requirement before travel.',
    'Short transit window; visa validity commonly reported up to 7 days (14 days for double-entry transit)',
    'Online e-Visa via visa.immigration.go.tz with onward ticket and destination-country visa proof',
    1,
    'Reported alongside standard e-Visa processing, roughly 4-10 working days',
    'Tanzania Immigration Department (online e-Visa); Tanzania High Commission, New Delhi',
    'Confirm whether your routing genuinely requires a Tanzania transit visa for your layover\nGather your onward flight ticket and destination-country visa/entry proof\nComplete the online e-Visa application under the transit category\nUpload documents, pay the US$30 fee, and print the approval before travel',
    '/assets/images/visa-heroes/tanzania.webp',
    'Cross-checked across travel-agency secondary sourcing; visa.immigration.go.tz not directly fetchable this session — exact stay duration flagged as inconsistent across sources', 'https://visa.immigration.go.tz/guidelines', '2026-09-17'
);
SET @tza6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tza6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tza6, 'Core Documents', 'Required if a Transit visa is genuinely needed.', 1);
SET @tza6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tza6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@tza6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2),
(@tza6s1, 'Entry Visa/Proof for Final Destination', NULL, 'if_applicable', 0, 1, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tza6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @tza6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tza6s2, 'Proof of Funds for the Transit Period', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(49, 6, 30.00, 'USD', 'Transit Visa Fee', 'Reported consistently at US$30; secondary sources disagree on maximum stay (up to 7 days per entry vs. reports of a much shorter same-day transit window) — this inconsistency was not resolved this session, confirm before booking a long layover.', '2026-09-01', NOW(), 'https://visa.immigration.go.tz/guidelines', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I skip the Tanzania transit visa for a same-day layover?', 'Not independently confirmed this session — sources disagree on whether a short, same-day airside connection is exempt. Since visa-on-arrival was suspended in January 2025, the safer approach is to secure the e-Visa transit category in advance regardless of layover length.', 49, 6, 4911, 1),
('What documents does the transit visa require beyond the standard set?', 'You need proof of onward travel and, where applicable, evidence you hold or qualify for entry to your final destination country — Tanzania Immigration checks that you have a genuine, funded route out of the country.', 49, 6, 4912, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Ordinary Visa (Single Entry)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    49, 7, 'TZA-MED-IN-07', '2026.09', 'published',
    'Travel to Tanzania for medical treatment.',
    'Indian nationals travelling for treatment apply for the standard Ordinary Visa — Tanzania Immigration''s own purpose list for this single-entry category explicitly names medical treatment alongside tourism, family visits, and conferences.',
    'Single entry, up to 90 days',
    'Online e-Visa via visa.immigration.go.tz with hospital/treatment confirmation',
    1,
    'Reported at roughly 4-10 working days, the same track as the Ordinary Visa',
    'Tanzania Immigration Department (online e-Visa); Tanzania High Commission, New Delhi',
    'Obtain a treatment confirmation/referral letter from the Tanzanian hospital or clinic\nArrange proof of funds for treatment costs\nComplete the online Ordinary Visa application, selecting medical treatment as purpose\nUpload documents, pay the fee, and print the approval before travel',
    '/assets/images/visa-heroes/tanzania.webp',
    'Cross-checked across travel-agency and embassy-mirror secondary sourcing; visa.immigration.go.tz and in.tzembassy.go.tz not directly fetchable this session', 'https://visa.immigration.go.tz/guidelines', '2026-09-17'
);
SET @tza7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tza7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tza7, 'Core Documents', 'Required from every applicant.', 1);
SET @tza7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tza7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@tza7s1, 'Hospital/Clinic Treatment Confirmation Letter', NULL, 'original', 1, 0, 1, 2),
(@tza7s1, 'Medical Records/Referral', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tza7, 'Supporting Documents', 'Additional financial and companion evidence.', 2);
SET @tza7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tza7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 1),
(@tza7s2, 'Attendant''s Passport/Documents', 'If a family member or attendant is accompanying the patient.', 'if_applicable', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(49, 7, 50.00, 'USD', 'Ordinary Visa (Medical Treatment) Fee', 'Same single-entry Ordinary Visa category and fee as Tourist/Family Visit/Conference — Tanzania does not price medical travel separately.', '2026-09-01', NOW(), 'https://visa.immigration.go.tz/guidelines', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Tanzania have a dedicated Medical visa?', 'No — medical treatment is one of the purposes explicitly listed under the same Ordinary Visa (~US$50) used for tourism, family visits, and conferences, rather than a separately priced category.', 49, 7, 4913, 1),
('Is travel insurance mandatory for medical travel to Tanzania?', 'Tanzania introduced mandatory travel insurance for Zanzibar visitors in October 2024 (~US$44) and announced a similar mainland requirement for FY2025/26 — check current status, since it sits alongside, not in place of, any dedicated treatment cover you arrange.', 49, 7, 4914, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Ordinary Visa (Single Entry)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    49, 8, 'TZA-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, congresses, or trade events in Tanzania.',
    'Indian nationals attending a conference apply for the standard Ordinary Visa — Tanzania Immigration''s official purpose list for this category explicitly names conferences alongside tourism, family visits, and medical treatment.',
    'Single entry, up to 90 days',
    'Online e-Visa via visa.immigration.go.tz with conference invitation/registration confirmation',
    1,
    'Reported at roughly 4-10 working days, the same track as the Ordinary Visa',
    'Tanzania Immigration Department (online e-Visa); Tanzania High Commission, New Delhi',
    'Obtain a conference invitation or registration confirmation from the host organizer\nGather proof of accommodation and return travel\nComplete the online Ordinary Visa application, selecting conference as purpose\nUpload documents, pay the fee, and print the approval before travel',
    '/assets/images/visa-heroes/tanzania.webp',
    'Cross-checked across travel-agency and embassy-mirror secondary sourcing; visa.immigration.go.tz and in.tzembassy.go.tz not directly fetchable this session', 'https://visa.immigration.go.tz/guidelines', '2026-09-17'
);
SET @tza8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tza8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tza8, 'Core Documents', 'Required from every applicant.', 1);
SET @tza8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tza8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@tza8s1, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tza8, 'Supporting Documents', 'Additional employer-side and travel evidence.', 2);
SET @tza8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tza8s2, 'Employer Forwarding Letter', NULL, 'if_applicable', 0, 1, 0, 1),
(@tza8s2, 'Confirmed Accommodation Booking', NULL, 'copy', 1, 0, 0, 2),
(@tza8s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(49, 8, 50.00, 'USD', 'Ordinary Visa (Conference) Fee', 'Same single-entry Ordinary Visa category and fee as Tourist/Family Visit/Medical; a Business Visa (~US$250) may instead apply if the trip is a paid commercial/trade assignment rather than conference attendance.', '2026-09-01', NOW(), 'https://visa.immigration.go.tz/guidelines', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('When would a conference trip need the pricier Business visa instead?', 'If your Tanzania trip is genuinely a commercial/trade assignment rather than attending as a delegate, the separate, higher-fee Business Visa category (~US$250) may apply instead — check which purpose best matches your trip.', 49, 8, 4915, 1),
('Do I need an employer forwarding letter for a conference visa?', 'It is commonly requested as supporting evidence of your professional purpose and return intent, even though the Ordinary Visa core document list doesn''t always list it as strictly mandatory — bring one where available.', 49, 8, 4916, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Ordinary or Business Visa (No Dedicated Category)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    49, 9, 'TZA-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff participating in sporting events or tournaments in Tanzania.',
    'Tanzania Immigration does not publish a distinct Sports visa category — participants are expected to apply under the Ordinary Visa (non-paid participation/events) or the Business Visa (paid professional engagements); this session could not independently confirm which applies by default, so confirm with the event organizer or Tanzania Immigration before applying.',
    'Up to 90 days under either the Ordinary Visa or the (non-extendable) Business Visa track',
    'Online e-Visa via visa.immigration.go.tz, category chosen based on whether participation is paid/professional',
    1,
    'Reported at roughly 4-10 working days on either track; confirm with the tournament organizer well ahead of travel',
    'Tanzania Immigration Department (online e-Visa); Tanzania High Commission, New Delhi',
    'Confirm with the event organizer/national sports federation whether your participation is treated as an Ordinary-Visa event or a paid Business-Visa engagement\nObtain a letter from your home sports association/federation confirming your role\nObtain an invitation letter from the host event organizer in Tanzania\nComplete the online e-Visa application under the confirmed category\nUpload documents, pay the applicable fee, and print the approval before travel',
    '/assets/images/visa-heroes/tanzania.webp',
    'NOT independently confirmed this session — no dedicated Sports visa category or fee page was located; content is a best-effort structure based on Tanzania''s published Ordinary/Business visa categories, not a directly verified primary source', 'https://visa.immigration.go.tz/guidelines', '2026-09-17'
);
SET @tza9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tza9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tza9, 'Core Documents', 'Required from every applicant.', 1);
SET @tza9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tza9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@tza9s1, 'Home-Country Sports Association/Federation Letter', 'Confirms your role and, where relevant, no-employment status.', 'original', 1, 0, 1, 2),
(@tza9s1, 'Host Event Organizer Invitation Letter', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tza9, 'Supporting Documents', 'Additional delegation and travel evidence.', 2);
SET @tza9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tza9s2, 'Team/Delegation List', NULL, 'if_applicable', 0, 1, 0, 1),
(@tza9s2, 'Confirmed Accommodation Booking', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(49, 9, NULL, 'USD', 'Confirmed After Assessment (Ordinary or Business Category)', 'NOT independently confirmed this session — no dedicated Sports visa fee was found; likely falls under the Ordinary Visa (~US$50) or Business Visa (~US$250) depending on whether participation is paid. Confirm directly with Tanzania Immigration or the event organizer.', '2026-09-01', NOW(), 'https://visa.immigration.go.tz/guidelines', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Sports visa for Tanzania?', 'Not that could be independently confirmed this session. Tanzania''s published visa categories are Ordinary, Multiple Entry, Business, Transit, Gratis, and Referral; sporting-event participation appears to be handled under Ordinary or Business depending on whether it is paid, but this was not directly verified against a primary source.', 49, 9, 4917, 1),
('What documents should an athlete or official carry regardless of category?', 'A letter from your home sports association/federation confirming your role, and a formal invitation from the host event organizer in Tanzania, in addition to the standard passport and visa documents.', 49, 9, 4918, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Class B Dependant Pass
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    49, 10, 'TZA-DEP-IN-10', '2026.09', 'published',
    'Spouse, minor children, or dependent family members joining an Indian Class A or Class B permit holder in Tanzania.',
    'Family members of an Indian national holding a valid Class A (investor) or Class B (expatriate employee) work/residence permit apply for a Class B Dependant Pass; dependents (spouse, children under 18 or full-time students, and in some cases elderly/infirm parents) are not permitted to work without a separate permit of their own.',
    'Tied to the principal permit holder''s permit validity (roughly 4-24 months), renewable',
    'Principal permit holder/sponsoring employer applies for the Dependant Pass with Tanzania Immigration',
    1,
    'Reported at 4-8 weeks from a complete application; TIC-registered investors'' dependants reportedly process faster',
    'Tanzania Immigration Department; Tanzania High Commission, New Delhi for document attestation',
    'Confirm the principal family member holds a valid Class A or Class B permit\nGather relationship proof (marriage/birth certificates) and proof of financial dependency\nSponsor/employer files the Dependant Pass application with Tanzania Immigration\nGet Indian documents attested by the MEA and the Tanzania High Commission, New Delhi where required\nReceive the Dependant Pass, tied to the principal''s permit validity',
    '/assets/images/visa-heroes/tanzania.webp',
    'Cross-checked across immigration-department and expatriate-family secondary sourcing; www.immigration.go.tz and in.tzembassy.go.tz not directly fetchable this session', 'https://www.immigration.go.tz/index.php/dependent-pass', '2026-09-17'
);
SET @tza10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tza10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tza10, 'Core Documents', 'Required from every applicant.', 1);
SET @tza10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tza10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@tza10s1, 'Proof of Relationship to Principal Permit Holder', NULL, 'copy', 1, 0, 1, 2),
(@tza10s1, 'Principal''s Class A/B Permit Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tza10, 'Supporting Documents', 'Additional attested and financial evidence.', 2);
SET @tza10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tza10s2, 'Attested Marriage/Birth Certificates', NULL, 'original', 1, 0, 0, 1),
(@tza10s2, 'Proof of Financial Dependency', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(49, 10, NULL, 'USD', 'Confirmed After Assessment (Dependant Pass)', 'Official Dependant Pass fee schedule was not directly obtainable this session; processing is reported at 4-8 weeks, broadly aligned with the principal permit holder''s Class A/B timeline — confirm the current fee with Tanzania Immigration or your sponsoring employer.', '2026-09-01', NOW(), 'https://www.immigration.go.tz/index.php/dependent-pass', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my dependents work in Tanzania once they join me?', 'Not automatically — dependants on a Class B Dependant Pass are generally not permitted to work unless they separately apply for and obtain their own work permit.', 49, 10, 4919, 1),
('Does Tanzania''s historic Indian community affect Dependant Pass applications?', 'The documentation requirements are the same for every applicant, but Tanzania''s Indian-origin community — more than 60,000 Tanzanian citizens of Indian descent, concentrated around Dar es Salaam and Zanzibar — means many Class A/B permit holders sponsoring dependants are joining or extending genuinely long-established family and business networks rather than starting from scratch.', 49, 10, 4920, 1);
