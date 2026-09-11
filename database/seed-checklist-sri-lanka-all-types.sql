-- Sri Lanka Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search, same standard as every other
-- country built this session (see AUDIT.md). hero_image_url points at
-- the real Sigiriya rock fortress photo supplied by the client for
-- this hero.
--
-- IMPORTANT SOURCING CAVEAT: official primary sources (eta.gov.lk,
-- immigration.gov.lk, slhcindia.org) were not directly fetchable in
-- this session's research pass (blocked at the network egress layer)
-- — findings were triangulated from web-search-indexed content across
-- travel-industry news (Newswire.lk, VisasNews, Outlook Traveller,
-- Gulf News) and visa-consultancy sourcing, several of which
-- themselves quote official circulars. The free-ETA policy below is
-- especially fast-moving and should be re-verified against eta.gov.lk
-- before being treated as permanent.
--
-- Sri Lanka's real, distinctive facts:
--   - A genuinely volatile, headline-driven ETA fee history: paid ETA
--     -> free pilot for 7 countries incl. India from October 2023 ->
--     expanded free-ETA scheme for 40 countries incl. India from 25
--     May 2026. "Free ETA" is a fee waiver, NOT visa-free travel — the
--     ETA application itself remains mandatory even at zero cost, a
--     distinction stated explicitly rather than assumed.
--   - Several purposes that read as separate visa types on this site
--     are genuinely NOT distinct application tracks under Sri Lanka's
--     own immigration framework — Medical, Sports, and (in effect)
--     Family Visit are all administratively processed as the standard
--     Tourist Visa/ETA, per Sri Lanka's own stated Tourist Visa
--     definition covering "medical treatments," "sport events," and
--     "visiting friends and relatives." This is stated honestly here
--     rather than inventing separate processes that don't exist.
--   - Work and Student visas use a genuinely unusual two-hop process:
--     an Entry Visa endorsed at a Sri Lankan mission in India, travel
--     to Sri Lanka on that, then conversion to a Residence Visa in
--     person at the Department of Immigration HQ in Battaramulla
--     within a fixed window — the ETA system is explicitly unavailable
--     for these categories.
--   - Dependent (spouse) visas carry a real, explicit financial-
--     sustenance formula: a mandated monthly remittance of USD 1,500
--     for the principal applicant plus USD 750 per dependent into an
--     approved Sri Lankan bank account, a level of specificity not
--     common in comparable dependent-visa rules elsewhere researched
--     this session.
--
-- country_id 94 = Sri Lanka. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Free Tourist ETA
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    94, 1, 'LKA-TOUR-IN-01', '2026.09', 'published',
    'Sightseeing, holidaying, visiting friends/relatives, short medical treatment, art/music/dance events, or short-term sports events in Sri Lanka.',
    'All Indian passport holders qualify. As of 25 May 2026, the Tourist ETA is free of charge for Indian nationals under Sri Lanka''s expanded 40-country waiver scheme — a fee waiver, not visa-free travel; the ETA application itself remains mandatory.',
    '30 days, extendable, double-entry',
    'Online ETA via eta.gov.lk (official portal only — many scam look-alike sites exist)',
    0,
    'Typically approved within 24-48 hours',
    'No embassy/consulate visit needed — entirely online',
    'Apply online at eta.gov.lk, selecting the Tourist category\nEnter your personal, passport, and first-accommodation details\nSubmit — no payment is currently required for Indian nationals\nReceive your ETA approval by email, typically within 24-48 hours\nPrint or save your approval letter and present it with your passport on arrival',
    '/assets/images/visa-heroes/sri-lanka.jpg',
    'Cross-checked travel-industry news (Newswire.lk, VisasNews, Outlook Traveller, Gulf News) on the May 2026 free-ETA expansion, triangulated against official guidance not directly fetchable this session', 'https://eta.gov.lk/', '2026-09-11'
);
SET @lk1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lk1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lk1, 'Core Documents', 'Every traveller needs these.', 1);
SET @lk1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lk1s1, 'Valid Passport', 'Valid at least 6 months, with 2 blank pages.', 'original', 1, 0, 1, 1),
(@lk1s1, 'Passport-Style Digital Photo', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lk1, 'Travel Documents', 'Confirming your trip plan.', 2);
SET @lk1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lk1s2, 'Confirmed Return/Onward Ticket', NULL, 'copy', 1, 0, 1, 1),
(@lk1s2, 'ETA Approval Printout', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lk1, 'Supporting Documents', 'May be requested by immigration on arrival.', 3);
SET @lk1s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lk1s3, 'Proof of Accommodation for Full Stay', NULL, 'copy', 1, 0, 0, 1),
(@lk1s3, 'Proof of Sufficient Funds', 'May be requested by immigration officers on arrival.', 'copy', 0, 1, 0, 2),
(@lk1s3, 'Travel/Health Insurance', 'Recommended, not always mandatory.', 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(94, 1, 0.00, 'USD', 'Free ETA (Policy Effective 25 May 2026)', 'Indian nationals pay no ETA fee under the current scheme, reported as part of a one-year grant since its May 2026 gazette — this should be monitored for renewal/reversion around May 2027. Applicants who paid before 25 May 2026 do not receive refunds.', '2026-05-25', NOW(), 'https://eta.gov.lk/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Sri Lanka ETA really free for Indians?', 'Yes, as of 25 May 2026 — but this is a fee waiver, not visa-free entry. You must still complete the ETA application online before travelling; arriving without one is not permitted even though the government charge is currently zero.', 94, 1, 1400, 1),
('Do Medical and Sports visits need a separate visa?', 'No — Sri Lanka''s own Tourist Visa definition explicitly covers short medical treatment and participation in sport events, so these are processed under this same Tourist ETA rather than a distinct application.', 94, 1, 1401, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Business ETA
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    94, 2, 'LKA-BUS-IN-02', '2026.09', 'published',
    'Short business trips — meetings, deal negotiations, stakeholder meetings, and attending training as a business purpose.',
    'Indian business travellers not taking up local employment. A letter of invitation from a Sri Lankan business partner is commonly expected. Free of charge for Indian nationals under the same May 2026 waiver as Tourist.',
    '30 days per entry; single, double, or multiple journey depending on the application',
    'Online ETA (Business category) via eta.gov.lk for short-term visits; longer/complex business visits may go through a Sri Lankan diplomatic mission',
    0,
    'Typically approved within 24-48 hours online',
    'eta.gov.lk, or Sri Lanka High Commission, New Delhi / Deputy High Commissions in Chennai, Mumbai, Bengaluru for non-ETA cases',
    'Secure an invitation letter from your Sri Lankan business host\nApply online at eta.gov.lk, selecting the Business category\nSubmit supporting business documentation if requested\nReceive your ETA approval by email\nPresent it with your passport on arrival',
    '/assets/images/visa-heroes/sri-lanka.jpg',
    'Cross-checked travel-industry news and visa-consultancy sourcing (BTW Visas, ImmigrationLanka) triangulated against official guidance not directly fetchable this session', 'https://eta.gov.lk/', '2026-09-11'
);
SET @lk2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lk2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lk2, 'Core Documents', 'Every applicant needs these.', 1);
SET @lk2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lk2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@lk2s1, 'Confirmed Return Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lk2, 'Business Invitation Documents', 'Evidence of your Sri Lankan host.', 2);
SET @lk2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lk2s2, 'Invitation Letter from Sri Lankan Host Company', NULL, 'original', 1, 0, 0, 1),
(@lk2s2, 'Company Registration/Business ID Proof', NULL, 'copy', 1, 0, 0, 2),
(@lk2s2, 'Letter from Indian Employer Confirming Purpose', NULL, 'original', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(94, 2, 0.00, 'USD', 'Free ETA (Policy Effective 25 May 2026)', 'Free for Indian nationals under the May 2026 waiver; pre-waiver reference rates conflicted between sources (roughly USD 25-30 for SAARC nationals) and no longer apply.', '2026-05-25', NOW(), 'https://eta.gov.lk/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What should my Sri Lankan host''s invitation letter include?', 'Their company details and the purpose of your visit — this strengthens your Business ETA application, though the ETA process itself is online and does not require an embassy visit.', 94, 2, 1402, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Entry Visa + Residence Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    94, 3, 'LKA-STU-IN-03', '2026.09', 'published',
    'Enrollment in a recognized Sri Lankan educational institution for study exceeding 6 months.',
    'Requires a formal admission/acceptance letter from a recognized Sri Lankan institution and demonstrated financial capacity. NOT available via ETA — explicitly excluded from the online tourist/business ETA and visa-on-entry.',
    'Tied to course length; issued/renewed annually as a multiple-entry Residence Visa',
    'Institution applies to Immigration for entry-visa approval, relayed to your nearest Sri Lankan mission for an Entry Visa endorsement',
    1,
    'Estimates range from 1-3 weeks up to 6-12 weeks depending on document completeness — treated as case-by-case',
    'Sri Lanka High Commission, New Delhi, or Deputy High Commissions in Chennai/Mumbai/Bengaluru for the Entry Visa; Department of Immigration & Emigration HQ, Battaramulla, for the in-country conversion',
    'Secure admission from a recognized Sri Lankan institution\nInstitution submits an entry-visa approval request to the Department of Immigration\nReport to your nearest Sri Lankan mission once notified\nObtain your Entry Visa endorsement\nTravel to Sri Lanka\nConvert to a Residence Visa at Immigration HQ within the stipulated window, and renew annually before expiry',
    '/assets/images/visa-heroes/sri-lanka.jpg',
    'Cross-checked education-consultancy sourcing (Akbar Travels, PolicyBazaar, ConsultancyNepal) triangulated against official guidance not directly fetchable this session', 'https://www.immigration.gov.lk/', '2026-09-11'
);
SET @lk3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lk3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lk3, 'Core Documents', 'Every applicant needs these.', 1);
SET @lk3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lk3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@lk3s1, 'Admission/Acceptance Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lk3, 'Financial & Personal Documents', 'Verifying your means and background.', 2);
SET @lk3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lk3s2, 'Proof of Funds/Financial Sponsorship', NULL, 'copy', 1, 0, 0, 1),
(@lk3s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2),
(@lk3s2, 'Medical Clearance', NULL, 'copy', 1, 0, 0, 3),
(@lk3s2, 'Parental Consent/Guardian Documents', 'Required for minors.', 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(94, 3, 20000.00, 'LKR', 'Residence Visa Fee (Per 12-Month Period, Private Institutions)', 'Reported at LKR 10,000/year for government-university students. Figures per the Department of Immigration''s fee schedule as cited by secondary sources — recommend confirming the exact current amount directly against immigration.gov.lk.', '2026-09-01', NOW(), 'https://www.immigration.gov.lk/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I use the Tourist ETA to study in Sri Lanka?', 'No — student visas are explicitly excluded from the ETA system. You need an Entry Visa endorsed at a Sri Lankan mission in India, followed by conversion to a Residence Visa after arrival.', 94, 3, 1403, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Employment Residence Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    94, 4, 'LKA-WORK-IN-04', '2026.09', 'published',
    'Employment with a Sri Lankan company, including Board of Investment (BOI)-registered enterprises.',
    'Requires a job offer/contract from a Sri Lankan employer and verified qualifications. Certain regulated professions (engineers, doctors, pilots, tourism-project staff) need additional professional-body approvals.',
    'Generally issued for 1 year, renewable annually for the contract duration',
    'Two-stage: an Entry Visa recommended by the BOI or the Department of Immigration, then conversion to a Residence Visa within 30 days of arrival',
    1,
    'Variable and case-by-case, depending on BOI recommendation turnaround plus mission processing',
    'Sri Lankan mission in India for the Entry Visa; Department of Immigration & Emigration HQ, Battaramulla, for the Residence Visa conversion; BOI Colombo for the recommendation',
    'Secure your employment offer\nEmployer (if a BOI enterprise) obtains a BOI recommendation via the BOI Visa Management System, or applies directly to Immigration\nObtain your Entry Visa endorsement at a Sri Lankan mission in India\nTravel to Sri Lanka on the Entry Visa\nConvert to a Residence Visa at Immigration HQ within 30 days of arrival\nRenew annually',
    '/assets/images/visa-heroes/sri-lanka.jpg',
    'Cross-checked immigration-law advisory sourcing (BAL, Fragomen, G-P, Playroll) triangulated against official guidance not directly fetchable this session', 'https://www.immigration.gov.lk/', '2026-09-11'
);
SET @lk4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lk4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lk4, 'Core Documents', 'Every applicant needs these.', 1);
SET @lk4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lk4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@lk4s1, 'Employment Offer/Contract Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lk4, 'Employer & Qualification Documents', 'Evidence of sponsorship and your background.', 2);
SET @lk4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lk4s2, 'BOI Recommendation Letter', 'Only if employer is a BOI-registered enterprise.', 'original', 0, 1, 0, 1),
(@lk4s2, 'Employer''s Company & BOI Registration Certificate', NULL, 'copy', 1, 0, 0, 2),
(@lk4s2, 'Professional/Regulatory Body Approval', 'Required for regulated professions.', 'original', 0, 1, 0, 3),
(@lk4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 4),
(@lk4s2, 'Qualification Certificates/Transcripts', NULL, 'copy', 1, 0, 0, 5);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(94, 4, 20000.00, 'LKR', 'Residence Visa Fee (Per 12-Month Period)', 'Department of Immigration residence-visa fee schedule per secondary sources. Any additional BOI processing charges could not be independently verified this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.immigration.gov.lk/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is the two-stage process for a Sri Lanka work visa?', 'You first obtain an Entry Visa endorsed at a Sri Lankan mission in India, travel to Sri Lanka on it, then convert it to a Residence Visa at Immigration HQ within 30 days of arrival.', 94, 4, 1404, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Administratively the Tourist ETA
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    94, 5, 'LKA-FAM-IN-05', '2026.09', 'published',
    'Visiting family or friends resident in Sri Lanka for a short period.',
    'Not a distinct ETA category — Sri Lanka''s own Tourist ETA explicitly covers "visiting friends and relatives," so family visits are administratively processed as the standard Tourist ETA. Stated honestly here rather than implying a separate application exists.',
    '30 days, same extension rules as Tourist',
    'Online Tourist ETA via eta.gov.lk (same portal and category as a general tourist visit)',
    0,
    'Typically approved within 24-48 hours',
    'No embassy/consulate visit needed — entirely online',
    'Apply online at eta.gov.lk, selecting the Tourist category\nEnter your personal, passport, and accommodation details (your host''s address in Sri Lanka)\nSubmit — no payment is currently required for Indian nationals\nReceive your ETA approval by email\nPresent it with your passport on arrival',
    '/assets/images/visa-heroes/sri-lanka.jpg',
    'Cross-checked against Sri Lanka''s own stated Tourist Visa purpose definition, sourced via travel-industry and visa-consultancy reporting not directly fetchable from immigration.gov.lk this session', 'https://eta.gov.lk/', '2026-09-11'
);
SET @lk5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lk5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lk5, 'Core Documents', 'Every traveller needs these.', 1);
SET @lk5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lk5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@lk5s1, 'Confirmed Return Ticket', NULL, 'copy', 1, 0, 1, 2),
(@lk5s1, 'ETA Approval Printout', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lk5, 'Relationship Documents', 'Useful if immigration officers ask, though not formally mandated for the ETA itself.', 2);
SET @lk5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lk5s2, 'Invitation Letter from Host in Sri Lanka', NULL, 'copy', 0, 1, 0, 1),
(@lk5s2, 'Host''s ID/Residence Proof', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(94, 5, 0.00, 'USD', 'Free ETA (Policy Effective 25 May 2026)', 'Covered under the free Tourist ETA waiver for Indian nationals — the same product as the Tourist Visa.', '2026-05-25', NOW(), 'https://eta.gov.lk/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Family Visit Visa for Sri Lanka?', 'Not administratively — visiting friends and relatives is explicitly covered under Sri Lanka''s standard Tourist ETA, the same product used for general tourism.', 94, 5, 1405, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    94, 6, 'LKA-TRANS-IN-06', '2026.09', 'published',
    'Leaving the airport during a layover in Sri Lanka. Not required at all if staying airside and continuing on the same aircraft.',
    'Indian nationals in genuine transit with onward travel documentation.',
    'Up to 48 hours (2 days) from the immigration stamp',
    'Online ETA (Transit category) via eta.gov.lk; an offline/VAC route also exists but is slower',
    0,
    'Online typically 24-48 hours; offline via a Visa Application Centre can take up to 4 business days',
    'eta.gov.lk online; Visa Application Centre for the offline route',
    'Confirm whether you need to leave the airport during your layover\nIf not, no visa is needed at all\nIf yes, complete the ETA transit application with your passport and onward air ticket details\nReceive your approval\nPresent it at immigration on arrival',
    '/assets/images/visa-heroes/sri-lanka.jpg',
    'Cross-checked visa-consultancy sourcing (Akbar Travels, TataAIG) triangulated against official guidance not directly fetchable this session', 'https://eta.gov.lk/', '2026-09-11'
);
SET @lk6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lk6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lk6, 'Core Documents', 'Every traveller needs these.', 1);
SET @lk6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lk6s1, 'Valid Passport', 'Valid at least 6 months.', 'original', 1, 0, 1, 1),
(@lk6s1, 'Onward/Connecting Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lk6, 'Offline Application Documents', 'Only relevant for the VAC route.', 2);
SET @lk6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lk6s2, 'Two Photographs', 'For offline/VAC applications only.', 'original', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(94, 6, 0.00, 'USD', 'Free Transit ETA', 'Multiple sources consistently describe the transit ETA as free — a long-standing feature, independent of the 2026 tourist-fee waiver.', '2026-09-01', NOW(), 'https://eta.gov.lk/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa if I stay in the airport during my Sri Lanka layover?', 'No — if you remain airside and continue on the same aircraft, no visa or ETA is required at all.', 94, 6, 1406, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Administratively the Tourist ETA
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    94, 7, 'LKA-MED-IN-07', '2026.09', 'published',
    'Travel to Sri Lanka for medical treatment.',
    'Sri Lanka''s official Tourist Visa definition explicitly includes "medical treatments" as a valid purpose — no formally distinct Medical Visa category was confirmed this session. Stated honestly here as administratively processed under the Tourist ETA.',
    '30 days under the Tourist ETA; longer treatment may require an extension or a distinct medical residence arrangement',
    'Tourist ETA (eta.gov.lk) for short treatment; longer treatment may require a mission application or an Immigration Department extension',
    0,
    'ETA route typically 24-48 hours; extensions handled separately by the Immigration Department',
    'eta.gov.lk (short-term); Department of Immigration (extensions)',
    'Confirm your treatment plan and get an appointment/admission letter from a Sri Lankan medical facility\nApply online at eta.gov.lk, selecting the Tourist category\nSubmit your documents\nReceive your ETA approval\nFor extended treatment, apply for an extension at the Immigration Department HQ before your initial 30 days lapse',
    '/assets/images/visa-heroes/sri-lanka.jpg',
    'Cross-checked against Sri Lanka''s own stated Tourist Visa purpose definition; direct confirmation of a formally distinct Medical Visa category was not possible this session', 'https://eta.gov.lk/', '2026-09-11'
);
SET @lk7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lk7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lk7, 'Core Documents', 'Every traveller needs these.', 1);
SET @lk7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lk7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@lk7s1, 'Confirmed Return/Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lk7, 'Medical Documents', 'Evidence of your treatment plan.', 2);
SET @lk7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lk7s2, 'Hospital Appointment/Admission Letter', NULL, 'original', 1, 0, 0, 1),
(@lk7s2, 'Medical Reports/Referral Summary', NULL, 'copy', 1, 0, 0, 2),
(@lk7s2, 'Proof of Funds to Cover Treatment', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(94, 7, 0.00, 'USD', 'Free ETA (Policy Effective 25 May 2026)', 'Covered under the free Tourist ETA waiver; a separate extension fee applies if treatment extends the stay beyond the initial ETA period.', '2026-05-25', NOW(), 'https://eta.gov.lk/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a distinct Medical Visa for Sri Lanka?', 'No formally distinct Medical Visa category was confirmed — medical treatment is explicitly covered under the standard Tourist ETA, per Sri Lanka''s own stated Tourist Visa definition.', 94, 7, 1407, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Business ETA Route
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    94, 8, 'LKA-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, seminars, workshops, and meetings in Sri Lanka.',
    'Processed under the Business Purpose ETA/Visa category. Some formal conference-visa requests reportedly require prior approval from the Controller General of Immigration & Emigration before a mission abroad issues an entry visa.',
    'Generally up to 30 days as a Business visa; extension to 90 days reportedly possible in some circumstances, though this figure needs reconfirmation',
    'Business ETA (eta.gov.lk) for short conferences; Sri Lankan mission in India for cases needing Controller General pre-approval',
    0,
    'Online typically 24-48 hours; longer if prior Controller General approval routing is required',
    'eta.gov.lk (Business category); Sri Lankan mission in India for cases needing pre-approval',
    'Register for the conference and request an invitation letter from the organizer\nApply online at eta.gov.lk, selecting the Business category\nSubmit your registration/delegate documentation\nReceive your ETA approval\nFor cases needing prior clearance, the inviting organization requests Controller General approval before your mission-level application',
    '/assets/images/visa-heroes/sri-lanka.jpg',
    'Cross-checked against the Business ETA categorization and Controller General pre-approval mentions in secondary sourcing not directly fetchable from immigration.gov.lk this session', 'https://eta.gov.lk/', '2026-09-11'
);
SET @lk8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lk8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lk8, 'Core Documents', 'Every applicant needs these.', 1);
SET @lk8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lk8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@lk8s1, 'Confirmed Return Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lk8, 'Event Documents', 'Evidence of your reason for attending.', 2);
SET @lk8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lk8s2, 'Conference/Event Invitation Letter', NULL, 'original', 1, 0, 0, 1),
(@lk8s2, 'Proof of Registration/Delegate Status', NULL, 'copy', 1, 0, 0, 2),
(@lk8s2, 'Sponsoring Organization''s Letter', 'Required for the Controller General pre-approval route.', 'original', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(94, 8, 0.00, 'USD', 'Free Business ETA (Policy Effective 25 May 2026)', 'No separately documented conference-visa fee was found — this is inferred from the Business ETA categorization, not an independently confirmed distinct fee.', '2026-05-25', NOW(), 'https://eta.gov.lk/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Conference Visa for Sri Lanka?', 'No distinct conference-visa category exists — it is processed under the Business ETA, with some formal requests needing prior Controller General approval.', 94, 8, 1408, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Administratively the Tourist ETA
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    94, 9, 'LKA-SPORT-IN-09', '2026.09', 'published',
    'Participating in sports events/tournaments in Sri Lanka for a short period.',
    'Explicitly covered under the official Tourist Visa definition ("participate in sport events for a short period of time"), per immigration.gov.lk''s own category description as reproduced in secondary sources — no formally distinct Sports Visa application code exists.',
    '30 days under Tourist Visa terms, extension possible for longer tournaments',
    'Tourist ETA via eta.gov.lk',
    0,
    'Typically approved within 24-48 hours',
    'No embassy/consulate visit needed — entirely online',
    'Apply online at eta.gov.lk, selecting the Tourist category\nEnter your personal, passport, and travel details\nSubmit — no payment is currently required for Indian nationals\nReceive your ETA approval by email\nPresent it with your passport on arrival',
    '/assets/images/visa-heroes/sri-lanka.jpg',
    'Cross-checked against Sri Lanka''s own stated Tourist Visa purpose definition, sourced via secondary reporting not directly fetchable from immigration.gov.lk this session', 'https://eta.gov.lk/', '2026-09-11'
);
SET @lk9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lk9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lk9, 'Core Documents', 'Every traveller needs these.', 1);
SET @lk9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lk9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@lk9s1, 'Confirmed Return Ticket', NULL, 'copy', 1, 0, 1, 2),
(@lk9s1, 'ETA Approval Printout', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lk9, 'Event Documents', 'Useful supporting evidence for immigration.', 2);
SET @lk9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lk9s2, 'Letter from Sports Federation/Organizer', NULL, 'copy', 0, 1, 0, 1),
(@lk9s2, 'National Sports Federation NOC', 'Where applicable.', 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(94, 9, 0.00, 'USD', 'Free ETA (Policy Effective 25 May 2026)', 'Covered under the free Tourist ETA waiver for Indian nationals.', '2026-05-25', NOW(), 'https://eta.gov.lk/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Sports Visa for Sri Lanka?', 'No — participation in short sports events is explicitly covered under the standard Tourist ETA, per Sri Lanka''s own stated Tourist Visa definition.', 94, 9, 1409, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Spouse/Children Residence Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    94, 10, 'LKA-DEP-IN-10', '2026.09', 'published',
    'Enabling a foreign spouse or dependent child to reside with a Sri Lankan citizen or a foreign resident-visa holder.',
    'Spouse of a Sri Lankan citizen: considered only after 6 months of marriage and 3 months of continuous stay in Sri Lanka from date of final arrival. Dependent children generally under 22 years of age. A monthly remittance into a Sri Lankan bank account of USD 1,500 for the principal applicant plus USD 750 per dependent is required for upkeep.',
    'Tied to the principal''s residence visa validity; multiple-entry, renewable annually alongside the principal',
    'Issued only in Colombo by the Department of Immigration & Emigration — not available via ETA',
    1,
    'Not consistently documented across sources — variable/case-by-case',
    'Department of Immigration & Emigration, Colombo/Battaramulla HQ',
    'Principal (Sri Lankan citizen or resident-visa holder) sponsors the application\nSubmit marriage/birth certificates and civil documents\nDemonstrate the required monthly remittance\nSubmit police clearance and medical reports for each family member\nApply in person at Immigration HQ, Colombo\nRenew annually with the principal''s visa',
    '/assets/images/visa-heroes/sri-lanka.jpg',
    'Cross-checked immigration-consultancy sourcing (ImmigrationLanka) triangulated against official guidance not directly fetchable this session', 'https://www.immigration.gov.lk/', '2026-09-11'
);
SET @lk10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lk10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lk10, 'Core Documents', 'Every applicant needs these.', 1);
SET @lk10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lk10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@lk10s1, 'Relationship Proof (Marriage/Birth Certificate — Attested)', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lk10, 'Financial & Personal Documents', 'Evidence of the required remittance and clearances.', 2);
SET @lk10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lk10s2, 'Proof of Required Monthly Remittance', 'USD 1,500 for the principal applicant plus USD 750 per dependent, into an approved Sri Lankan bank account.', 'copy', 1, 0, 0, 1),
(@lk10s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2),
(@lk10s2, 'Medical Reports for Each Family Member', NULL, 'copy', 1, 0, 0, 3),
(@lk10s2, 'Sri Lankan Spouse''s NIC/Passport or Citizenship Certificate Copy', NULL, 'copy', 1, 0, 0, 4),
(@lk10s2, 'Divorce Decree', 'If applicable.', 'copy', 0, 1, 0, 5);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(94, 10, 20000.00, 'LKR', 'Residence Visa Fee (Per 12-Month Period)', 'Same Department of Immigration residence-visa fee schedule cited for Student/Work visas — treat as indicative pending direct confirmation.', '2026-09-01', NOW(), 'https://www.immigration.gov.lk/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How much must be remitted monthly for a Sri Lanka Dependent Visa?', 'USD 1,500 for the principal applicant, plus USD 750 for each additional spouse or dependent child, into an approved Sri Lankan bank account.', 94, 10, 1410, 1),
('How soon after marriage can a spouse apply?', 'Only after 6 months of marriage and 3 months of continuous stay in Sri Lanka from the date of the spouse''s final arrival.', 94, 10, 1411, 1);
