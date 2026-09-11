-- Ireland Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search, same standard as every other
-- country built this session (see AUDIT.md). hero_image_url points at
-- the real Cliffs of Moher photo supplied by the client for this
-- hero.
--
-- IMPORTANT SOURCING CAVEAT: official primary sources (ireland.ie,
-- irishimmigration.ie, citizensinformation.ie, enterprise.gov.ie) were
-- not directly fetchable in this session's research pass (confirmed
-- blocked via curl, not just WebFetch) — findings were triangulated
-- from web-search-indexed content that frequently quotes or
-- paraphrases those official pages directly, cross-checked against
-- immigration-law advisory sourcing (IAS, Total Law, Newland Chase,
-- Deloitte Ireland). Several fee and processing-time figures conflict
-- between secondary sources and are marked "Confirmed After
-- Assessment" rather than guessed.
--
-- Ireland's real, distinctive facts:
--   - Ireland is NOT in the Schengen Area — it runs a fully separate
--     national visa system (C for short-stay, D for long-stay), with
--     its own online AVATS portal, its own fee schedule, and its own
--     adjudicating authority (Immigration Service Delivery, under the
--     Department of Justice). A Schengen visa does not admit you to
--     Ireland, and vice versa — a genuinely different starting point
--     from every Schengen country built this session (France, Germany,
--     Italy, Netherlands, Switzerland, Spain).
--   - India is one of only five countries (alongside China, Hong Kong,
--     Nigeria, Pakistan) singled out in Ireland's biometric visa pilot
--     — Indian applicants give all-ten-finger fingerprints and a
--     digital photo in person at VFS for every visa application,
--     unlike most other nationalities applying to Ireland.
--   - Work visas are genuinely two-step and split across two different
--     government departments: the Employment Permit (Critical Skills
--     or General) is granted first by the Department of Enterprise,
--     Trade and Employment, and only then can the applicant apply for
--     the entry visa itself. Holding a permit does not itself
--     authorise travel.
--   - A real, dated 2026 policy change: from 1 June 2026, Ireland
--     removed the right of appeal for most short-stay (C) visa
--     refusals, explicitly to reallocate resources to long-stay (D)
--     visa processing, where appeal rights continue.
--   - Post-study work rights are a distinct, named immigration
--     permission (Stamp 1G, "Third Level Graduate Programme") rather
--     than a separate visa category — non-EU graduates get up to 12
--     months (Honours Bachelor's) or 24 months (Master's/PhD) to stay
--     and work without needing a job offer first.
--
-- country_id 124 = Ireland. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Short-Stay Visit Visa (Type C)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    124, 1, 'IRL-TOUR-IN-01', '2026.09', 'published',
    'Tourism and sightseeing in Ireland for leisure.',
    'India is a visa-required nationality for Ireland. Applicants must show sufficient funds, ties to India, and intent to return. No extension mechanism for tourism — you must leave and reapply for further visits.',
    'Up to 90 days, single visit only (no extension for tourism)',
    'Online application via AVATS, then document submission and biometrics at a VFS Global Visa Application Centre in India',
    1,
    'Officially 20-25 working days from receipt at the Embassy; secondary sources note 4-8 weeks typical, up to 10-12 weeks in peak season (June-August, December-January)',
    'VFS Global centres across India, linked to the Embassy of Ireland, New Delhi',
    'Register and complete the AVATS form online\nPay the government visa fee online via AVATS\nBook a VFS Global appointment\nAttend in person with documents and biometrics (all ten fingerprints plus a digital photo)\nTrack your status online with your acknowledgment number\nReceive a decision by email',
    '/assets/images/visa-heroes/ireland.jpg',
    'Cross-checked immigration-consultancy sourcing (Y-Axis, BTW Visas, Wise) triangulated against ireland.ie/irishimmigration.ie guidance not directly fetchable this session', 'https://www.ireland.ie/', '2026-09-11'
);
SET @ie1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ie1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ie1, 'Core Documents', 'Every traveller needs these.', 1);
SET @ie1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ie1s1, 'Valid Passport', 'Valid 6+ months beyond stay, with blank pages.', 'original', 1, 0, 1, 1),
(@ie1s1, 'Passport-Size Photo (35x45mm, White Background)', NULL, 'original', 1, 0, 1, 2),
(@ie1s1, 'AVATS Summary Sheet', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ie1, 'Travel Documents', 'Confirming your trip plan.', 2);
SET @ie1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ie1s2, 'Return Flight Itinerary', NULL, 'copy', 1, 0, 1, 1),
(@ie1s2, 'Accommodation Proof', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ie1, 'Financial & Ties Documents', 'Evidence of funds and intent to return.', 3);
SET @ie1s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ie1s3, 'Bank Statements (6 Months)', NULL, 'copy', 1, 0, 0, 1),
(@ie1s3, 'Employer Leave-Sanction Letter', NULL, 'original', 1, 0, 0, 2),
(@ie1s3, 'Travel Insurance', NULL, 'copy', 1, 0, 0, 3),
(@ie1s3, 'Proof of Ties to India', 'Property/family documentation.', 'copy', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(124, 1, 60.00, 'EUR', 'Single-Entry Visa Fee', 'EUR 100 for multiple entry. A separate VFS service charge applies on top and was not independently verified this session.', '2026-09-01', NOW(), 'https://www.ireland.ie/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does a Schengen visa let me enter Ireland?', 'No. Ireland is not part of the Schengen Area and runs a fully separate visa system — a Schengen visa does not cover Ireland, and an Irish visa does not cover Schengen.', 124, 1, 1500, 1),
('Do Indian applicants need to give biometrics?', 'Yes — India is one of only five countries in Ireland''s biometric visa pilot, so all ten fingerprints and a digital photo must be given in person at VFS for every application.', 124, 1, 1501, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    124, 2, 'IRL-BUS-IN-02', '2026.09', 'published',
    'Business meetings, negotiations, and contract signing — explicitly capped at working in Ireland for 14 days or less, not a route to paid Irish employment.',
    'Employees/representatives of an Indian company with a genuine business purpose in Ireland.',
    'Typically up to 90 days total stay, with business activity itself limited to 14 days',
    'AVATS online application, then document submission and biometrics at VFS Global',
    1,
    'Roughly 8 weeks reported by secondary sources; ranges 4-12 weeks in peak periods',
    'VFS Global centres across India, linked to the Embassy of Ireland, New Delhi, or Consulate Mumbai',
    'Secure a business invitation/cover letter from your Irish host\nComplete the AVATS form online and pay the fee\nBook a VFS appointment\nAttend in person with documents and biometrics\nReceive a decision by email',
    '/assets/images/visa-heroes/ireland.jpg',
    'Cross-checked visa-consultancy sourcing (Y-Axis, Bankbazaar) triangulated against indianembassydublin.gov.in guidance not directly fetchable this session', 'https://www.ireland.ie/', '2026-09-11'
);
SET @ie2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ie2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ie2, 'Core Documents', 'Every applicant needs these.', 1);
SET @ie2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ie2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ie2s1, 'AVATS Summary Sheet', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ie2, 'Business Sponsorship Documents', 'Evidence of the business relationship.', 2);
SET @ie2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ie2s2, 'Letter of Invitation from Irish Host Company', NULL, 'original', 1, 0, 0, 1),
(@ie2s2, 'Indian Company''s Incorporation/Registration Proof', NULL, 'copy', 1, 0, 0, 2),
(@ie2s2, 'Applicant''s Employment Contract/Salary Slips', NULL, 'copy', 1, 0, 0, 3),
(@ie2s2, 'Detailed Itinerary of Business Meetings', NULL, 'copy', 1, 0, 0, 4),
(@ie2s2, 'NOC from Indian Employer', NULL, 'original', 1, 0, 0, 5);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(124, 2, 60.00, 'EUR', 'Single-Entry Visa Fee', 'EUR 100 for multiple entry — same short-stay fee schedule as Tourist; no separate business-visa fee tier found.', '2026-09-01', NOW(), 'https://www.ireland.ie/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I work in Ireland on a Business Visa?', 'Only in a limited sense — business activity is capped at 14 days and does not authorise paid Irish employment. Longer or salaried work needs an Employment Permit and Work Visa instead.', 124, 2, 1502, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Type D Study Visa (Stamp 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    124, 3, 'IRL-STU-IN-03', '2026.09', 'published',
    'Full-time study in Ireland — a major market given Ireland''s large Indian student population.',
    'Must be enrolled full-time in a course of 1+ year on the Interim List of Eligible Programmes (ILEP) or the TrustEd Ireland list, with adequate funds and genuine intent to study. Registered on arrival as Stamp 2.',
    'Length of course; Stamp 2 renewed annually via IRP registration',
    'AVATS online application (Type D/study visa), then document submission and biometrics at VFS Global — apply at least 3 months before course start',
    1,
    'Typically 4-8 weeks, longer in peak season (May-August)',
    'VFS Global centres across India',
    'Secure an offer letter from an ILEP/TrustEd-listed institution\nPay the required tuition instalment\nComplete the AVATS Type D form\nBook a VFS appointment, submit documents and biometrics\nReceive your visa\nTravel to Ireland and register for your IRP card/Stamp 2 permission after arrival',
    '/assets/images/visa-heroes/ireland.jpg',
    'Cross-checked education-consultancy sourcing (ApplyBoard, Gostudyin) triangulated against irishimmigration.ie/ISD guidance not directly fetchable this session', 'https://www.ireland.ie/', '2026-09-11'
);
SET @ie3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ie3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ie3, 'Core Documents', 'Every applicant needs these.', 1);
SET @ie3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ie3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ie3s1, 'Offer/Acceptance Letter from ILEP/TrustEd-Listed Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ie3, 'Academic & Financial Documents', 'Verifying your study plan and means.', 2);
SET @ie3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ie3s2, 'Proof of English Proficiency (IELTS/Equivalent)', NULL, 'copy', 1, 0, 0, 1),
(@ie3s2, 'Proof of Tuition Payment', 'Minimum EUR 6,000 or full course fee if lower.', 'copy', 1, 0, 0, 2),
(@ie3s2, 'Bank Statements (6 Months, Funds in Applicant''s/Sponsor''s Name)', 'Living-cost benchmark commonly cited around EUR 10,000-12,000/year.', 'copy', 1, 0, 0, 3),
(@ie3s2, 'Private Medical Insurance for Full Stay', NULL, 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(124, 3, 60.00, 'EUR', 'Single-Entry Visa Fee', 'EUR 100 for multiple entry — same government fee schedule as other D visas.', '2026-09-01', NOW(), 'https://www.ireland.ie/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I work after I graduate in Ireland?', 'Yes — non-EU graduates from an eligible institution get Stamp 1G under the Third Level Graduate Programme: up to 12 months (Honours Bachelor''s) or 24 months (Master''s/PhD) to stay and work without needing a job offer first.', 124, 3, 1503, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Type D Employment Visa (via Employment Permit)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    124, 4, 'IRL-WORK-IN-04', '2026.09', 'published',
    'Long-term paid employment in Ireland, via the two-step Employment Permit + entry visa process.',
    'Critical Skills Employment Permit (CSEP): role on the Critical Skills Occupations List, minimum salary EUR 40,904/year (EUR 36,848 for recent graduates), job offer of 2+ years. General Employment Permit (GEP): minimum salary EUR 36,605/year (EUR 32,691 for specific sectors), job offer of 12+ months. Permit holders can change employer after 9 continuous months with their current employer.',
    'Tied to permit validity/employment contract, renewable while employed',
    'Employer applies for a Critical Skills/General Employment Permit via DETE first, then the applicant applies for the D-visa via AVATS',
    1,
    'Employment permit processing is separate from and precedes visa processing; visa stage follows standard D-visa timelines of 4-8+ weeks',
    'DETE online system for the permit; VFS Global centres across India for the visa',
    'Secure a job offer from an Irish employer\nApply for a Critical Skills or General Employment Permit via DETE\nOnce the permit is approved, apply for the D-employment visa via AVATS with the approved permit and employer letter\nAttend VFS for biometrics and document submission\nTravel to Ireland and register your IRP',
    '/assets/images/visa-heroes/ireland.jpg',
    'Cross-checked immigration-law advisory sourcing (Kod Lyons, Total Law, IrishTalents) triangulated against citizensinformation.ie guidance not directly fetchable this session', 'https://www.ireland.ie/', '2026-09-11'
);
SET @ie4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ie4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ie4, 'Core Documents', 'Every applicant needs these.', 1);
SET @ie4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ie4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ie4s1, 'Approved Employment Permit Copy', NULL, 'original', 1, 0, 1, 2),
(@ie4s1, 'Employer Letter Confirming Role/Salary', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ie4, 'Employment Permit Stage Documents', 'Filed by the employer at DETE.', 2);
SET @ie4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ie4s2, 'Full Employment Contract', NULL, 'original', 1, 0, 0, 1),
(@ie4s2, 'Degree/Qualification Certificates (with NARIC Equivalency Where Relevant)', NULL, 'copy', 1, 0, 0, 2),
(@ie4s2, 'Evidence Job Is on the Critical Skills List', 'For CSEP applications.', 'copy', 0, 1, 0, 3),
(@ie4s2, 'Employer''s Company Registration/Tax-Clearance Documents', NULL, 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(124, 4, 1000.00, 'EUR', 'CSEP Employment Permit Fee (90% Refunded If Unsuccessful)', 'GEP fees differ (EUR 500 for a 6-month GEP). Plus an EUR 300 IRP fee on approval, and a separate visa fee of EUR 60/100 (single/multiple). Confirm exact current figures before applying.', '2026-09-01', NOW(), 'https://www.ireland.ie/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does holding an Employment Permit let me travel to Ireland?', 'No — the Employment Permit alone does not authorise travel or entry. Visa-required nationals, including Indians, must separately apply for the D-employment visa via AVATS.', 124, 4, 1504, 1),
('Can I change employer on an Irish work permit?', 'Yes — under the Employment Permits Act 2024, permit holders can change employer after 9 continuous months with their current permit employer.', 124, 4, 1505, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    124, 5, 'IRL-FAM-IN-05', '2026.09', 'published',
    'Visiting family or friends resident in Ireland, up to 90 days.',
    'Any Indian national with a genuine family/friend connection in Ireland who can show accommodation and purpose.',
    'Up to 90 days, no extension for this purpose',
    'AVATS online application, purpose selected as "family/friend visit," then document submission and biometrics at VFS Global',
    1,
    'Same as Tourist — 20-25 working days official target, 4-8+ weeks realistic',
    'VFS Global centres across India, linked to the Embassy of Ireland, New Delhi, or Consulate Mumbai',
    'Ask your host in Ireland for an invitation letter\nComplete the AVATS form online and pay the fee\nBook a VFS appointment\nAttend in person with documents and biometrics\nReceive a decision by email',
    '/assets/images/visa-heroes/ireland.jpg',
    'Cross-checked against irishimmigration.ie''s "Visit family/friend visa" page (via search snippet) triangulated against secondary sourcing', 'https://www.irishimmigration.ie/', '2026-09-11'
);
SET @ie5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ie5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ie5, 'Core Documents', 'Every traveller needs these.', 1);
SET @ie5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ie5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ie5s1, 'Return Travel Booking', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ie5, 'Host & Relationship Documents', 'Evidence of your Ireland-based host.', 2);
SET @ie5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ie5s2, 'Invitation Letter from Host in Ireland', NULL, 'original', 1, 0, 0, 1),
(@ie5s2, 'Host''s Immigration/Residency Status Proof', 'Passport/IRP/Stamp copy.', 'copy', 1, 0, 0, 2),
(@ie5s2, 'Proof of Relationship', 'Birth/marriage certificates.', 'copy', 1, 0, 0, 3),
(@ie5s2, 'Host''s Accommodation Proof', 'Lease/utility bill.', 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(124, 5, 60.00, 'EUR', 'Single-Entry Visa Fee', 'EUR 100 for multiple entry — same short-stay fee schedule as Tourist.', '2026-09-01', NOW(), 'https://www.irishimmigration.ie/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What does my Ireland-based host need to provide?', 'An invitation letter along with proof of their own immigration/residency status in Ireland and proof of their accommodation.', 124, 5, 1506, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    124, 6, 'IRL-TRANS-IN-06', '2026.09', 'published',
    'Passing through an Irish airport en route to a third country.',
    'Airside transit (staying within the airport for a same-day connection through Terminal 2, 04:00-20:00) may not require a full visit visa in some cases. Landside transit — actually passing through Irish border control — requires visa-required nationals, including Indians, to hold a full Visit (C) visa, not a separate lightweight transit visa.',
    'Hours only, duration of layover — or up to 90 days if a full Visit visa is used for landside transit',
    'AVATS online application with transit purpose selected, then document submission and biometrics at VFS Global if a full visa is required',
    1,
    'Standard C-visa processing timelines apply once a full application is required',
    'VFS Global centres across India',
    'Determine whether your transit is airside-only or requires landside entry\nIf airside-only within the permitted window, no visa may be required\nIf leaving the terminal or connecting outside that window, apply via AVATS for a full Visit visa\nAttend VFS for biometrics if a full application is required\nReceive a decision',
    '/assets/images/visa-heroes/ireland.jpg',
    'Cross-checked against irishimmigration.ie''s "Transit (including Transfer Visa) Advice" page (via search snippet) triangulated against secondary sourcing', 'https://www.irishimmigration.ie/', '2026-09-11'
);
SET @ie6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ie6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ie6, 'Core Documents', 'Every traveller needs these.', 1);
SET @ie6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ie6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ie6s1, 'Confirmed Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ie6, 'Full-Visa Documents', 'Only relevant if a full Visit visa is required.', 2);
SET @ie6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ie6s2, 'Visa for Final Destination (If Required There)', NULL, 'copy', 0, 1, 0, 1),
(@ie6s2, 'Proof Both Flight Legs Are Booked Together', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(124, 6, NULL, 'EUR', 'Confirmed After Assessment', 'One secondary source cites EUR 25 for transit specifically, but this is not independently corroborated by an official page — contact us to confirm.', '2026-09-01', NOW(), 'https://www.irishimmigration.ie/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I always need a visa to transit through an Irish airport?', 'Not always — some airside-only same-day connections through Terminal 2 may not require one, but if you need to leave the terminal or pass through landside immigration, a full Visit visa is required.', 124, 6, 1507, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Short-Stay Medical Treatment Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    124, 7, 'IRL-MED-IN-07', '2026.09', 'published',
    'Travelling to Ireland for medical treatment.',
    'Patient (and potentially an accompanying attendant, separately assessed) with genuine medical need and Irish hospital/clinic engagement. Classified under the short-stay C "medical treatment" sub-category.',
    'Up to 90 days, matching treatment duration',
    'AVATS online application, purpose selected as medical treatment, then document submission and biometrics at VFS Global',
    1,
    'Standard C-visa timelines apply; no official fast-track guarantee found for urgent treatment',
    'VFS Global centres across India',
    'Confirm your treatment plan with an Irish hospital/consultant and obtain a confirmation letter\nComplete the AVATS form online and pay the fee\nBook a VFS appointment\nAttend in person with documents and biometrics\nReceive a decision',
    '/assets/images/visa-heroes/ireland.jpg',
    'Cross-checked against irishimmigration.ie''s "Short stay medical treatment visa" page (via search snippet) triangulated against secondary sourcing', 'https://www.irishimmigration.ie/', '2026-09-11'
);
SET @ie7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ie7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ie7, 'Core Documents', 'Every applicant needs these.', 1);
SET @ie7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ie7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ie7s1, 'Return Travel Plan', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ie7, 'Medical Documents', 'Evidence of your treatment plan.', 2);
SET @ie7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ie7s2, 'Letter from Irish Hospital/Consultant Confirming Treatment Plan and Dates', NULL, 'original', 1, 0, 0, 1),
(@ie7s2, 'Medical Reports/Diagnosis from Indian Doctor', NULL, 'copy', 1, 0, 0, 2),
(@ie7s2, 'Proof of Ability to Pay for Treatment', 'Cost estimate plus funds/insurance.', 'copy', 1, 0, 0, 3),
(@ie7s2, 'Attendant''s Relationship Proof', 'If accompanying.', 'copy', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(124, 7, 60.00, 'EUR', 'Single-Entry Visa Fee', 'EUR 100 for multiple entry — no distinct medical-visa fee tier identified.', '2026-09-01', NOW(), 'https://www.irishimmigration.ie/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a fast-track process for urgent medical treatment?', 'No official fast-track guarantee was found — standard C-visa processing timelines apply, though cases may be assessed with urgency in mind on a case-by-case basis.', 124, 7, 1508, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    124, 8, 'IRL-CONF-IN-08', '2026.09', 'published',
    'Attending a conference, symposium, or professional event in Ireland.',
    'Delegate/attendee with a genuine invitation from the organizing body. irishimmigration.ie hosts this as its own named page under "coming to work in Ireland for less than 90 days," sitting at the boundary between visit and short-term-work categories.',
    'Short-stay, matching event duration, within the 90-day C-visa envelope',
    'AVATS online application, purpose selected as conference/event, then document submission and biometrics at VFS Global',
    1,
    'Roughly 8 weeks reported by secondary sources, consistent with general C-visa processing',
    'VFS Global centres across India',
    'Register for the conference and request an invitation letter from the organizer\nComplete the AVATS form online and pay the fee\nBook a VFS appointment\nAttend in person with documents and biometrics\nReceive a decision',
    '/assets/images/visa-heroes/ireland.jpg',
    'Cross-checked against irishimmigration.ie''s "Conference/Event visa" page (via search snippet) triangulated against secondary sourcing', 'https://www.irishimmigration.ie/', '2026-09-11'
);
SET @ie8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ie8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ie8, 'Core Documents', 'Every applicant needs these.', 1);
SET @ie8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ie8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ie8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ie8, 'Sponsorship Documents', 'Evidence of your reason for attending.', 2);
SET @ie8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ie8s2, 'Formal Invitation Letter from Irish Conference Organizer', NULL, 'original', 1, 0, 0, 1),
(@ie8s2, 'Sponsor Letter from Indian Employer', 'If employer-funded.', 'original', 0, 1, 0, 2),
(@ie8s2, 'Proof of Professional Affiliation Relevant to the Conference', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(124, 8, 60.00, 'EUR', 'Single-Entry Visa Fee', 'EUR 100 for multiple entry — same short-stay fee schedule as Tourist.', '2026-09-01', NOW(), 'https://www.irishimmigration.ie/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Are biometrics required for a Conference Visa?', 'Yes — biometrics rules do not appear to carve out exceptions by visa sub-type, so Indian applicants give fingerprints and a photo the same as for any other short-stay visa.', 124, 8, 1509, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    124, 9, 'IRL-SPORT-IN-09', '2026.09', 'published',
    'Short visits to compete in or participate in a sporting event, or longer-term paid engagement in professional sport.',
    'Ireland does not have a standalone "sports visa" for short event visits — these fall under the general short-stay Visit (C) visa. For paid, longer-term engagement (professional athletes, coaches), the relevant instrument is the Sport and Cultural Employment Permit issued by DETE, following the same permit-first, then-D-visa structure as general work visas.',
    'Short visit up to 90 days; Sport and Cultural Employment Permit up to 24 months on first grant, renewable',
    'Short visit: AVATS + VFS. Longer engagement: DETE Sport and Cultural Employment Permit application first, then AVATS D-visa',
    1,
    'Short visit: standard C-visa timelines. Permit route: not independently verified for exact DETE turnaround',
    'VFS Global centres across India (visa stage); DETE online portal (permit stage, if applicable)',
    'For a short event: obtain an event/federation invitation, apply via AVATS, attend VFS for biometrics\nFor longer engagement: secure a Sport and Cultural Employment Permit via DETE first, then apply for the D-visa via AVATS and attend VFS',
    '/assets/images/visa-heroes/ireland.jpg',
    'Cross-checked against enterprise.gov.ie''s "Sport and Cultural Employment Permit" page (via search snippet) triangulated against secondary sourcing', 'https://enterprise.gov.ie/', '2026-09-11'
);
SET @ie9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ie9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ie9, 'Core Documents', 'Every applicant needs these.', 1);
SET @ie9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ie9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ie9s1, 'Event/Tournament Invitation or Federation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ie9, 'Federation & Employment Documents', 'Evidence of your athletic affiliation or contract.', 2);
SET @ie9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ie9s2, 'National Federation No-Objection/Participation Certificate', 'For competitive events.', 'copy', 0, 1, 0, 1),
(@ie9s2, 'Employment Contract', 'For the Sport and Cultural Employment Permit route.', 'original', 0, 1, 0, 2),
(@ie9s2, 'Proof of Professional Sporting Credentials/Rankings', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(124, 9, NULL, 'EUR', 'Confirmed After Assessment', 'Short visit uses the standard EUR 60/100 C-visa fee. The Sport and Cultural Employment Permit fee could not be independently verified this session — contact us to confirm.', '2026-09-01', NOW(), 'https://enterprise.gov.ie/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Sports Visa for Ireland?', 'Not for short event visits — those use the general short-stay Visit visa. Longer, paid engagement uses the Sport and Cultural Employment Permit issued by DETE instead.', 124, 9, 1510, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Join Family Visa (Stamp 3 / Stamp 1G)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    124, 10, 'IRL-DEP-IN-10', '2026.09', 'published',
    'Spouse, civil partner, de facto partner, or dependent child joining a sponsor already legally resident in Ireland.',
    'Legal spouse/civil partner, or a de facto (unmarried) partner able to prove 2+ years of cohabitation; dependent children under 18, or up to 23 if in full-time education. A sponsor who only holds a dependent-type Stamp 3 permission cannot themselves sponsor a family member.',
    'Tied to the sponsor''s permission; must be renewed alongside or before the sponsor''s own status expires',
    'De facto partners of an Irish national need Preclearance via AVATS first; other dependants apply for the D-visa join-family category directly',
    1,
    'Long-stay D-visa/preclearance processing is generally longer and more document-intensive than short-stay C visas; exact current turnaround for India not independently verified',
    'VFS Global centres across India / AVATS',
    'Confirm your sponsor holds an eligible status to sponsor you\nIf joining an Irish national''s de facto partner, apply for Preclearance first\nApply for the D join-family visa via AVATS\nAttend VFS for biometrics and document submission\nTravel to Ireland and register your IRP, receiving Stamp 3 or Stamp 1G where applicable',
    '/assets/images/visa-heroes/ireland.jpg',
    'Cross-checked against irishimmigration.ie''s "Join family visa" and "De facto partner of an Irish national" pages (via search snippets) triangulated against secondary sourcing', 'https://www.irishimmigration.ie/', '2026-09-11'
);
SET @ie10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ie10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ie10, 'Core Documents', 'Every applicant needs these.', 1);
SET @ie10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ie10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ie10s1, 'Marriage/Civil Partnership Certificate or Birth Certificate (for Children)', NULL, 'original', 1, 0, 1, 2),
(@ie10s1, 'Sponsor''s Proof of Status in Ireland', 'IRP/visa copy.', 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ie10, 'Sponsor & Relationship Documents', 'Evidence of your sponsor''s ability to support you.', 2);
SET @ie10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ie10s2, 'Sponsor''s Payslips/Employment Contract/Income Proof', NULL, 'copy', 1, 0, 0, 1),
(@ie10s2, 'Joint Cohabitation Evidence', 'For de facto partners — utility bills, joint lease, joint bank statements over 2 years.', 'copy', 0, 1, 0, 2),
(@ie10s2, 'Preclearance Approval Letter', 'Where required.', 'original', 0, 1, 0, 3),
(@ie10s2, 'Medical Insurance for the Dependant', NULL, 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(124, 10, 60.00, 'EUR', 'Single-Entry Visa Fee', 'EUR 100 for multiple entry — standard D-visa government fee. Whether Preclearance carries a separate fee was not independently confirmed this session.', '2026-09-01', NOW(), 'https://www.irishimmigration.ie/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What immigration status will I be registered under as a dependant?', 'Most dependants are registered as Stamp 3, which does not allow employment. Spouses/partners of General Employment Permit holders and Intra-Corporate Transferee permit holders granted family reunification are instead registered as Stamp 1G, which does allow employment.', 124, 10, 1511, 1),
('Can a Stamp 3 holder sponsor their own family member to join them?', 'No — a person who only holds a dependent-type Stamp 3 permission cannot sponsor a family member themselves, regardless of years spent in Ireland.', 124, 10, 1512, 1);
