-- Hong Kong Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search, same standard as every other
-- country built this session (see AUDIT.md). hero_image_url points at
-- the real Victoria Harbour photo supplied by the client for this
-- hero.
--
-- IMPORTANT SOURCING CAVEAT: official primary sources (immd.gov.hk,
-- gov.hk, discoverhongkong.com, cgihk.gov.in) were not directly
-- fetchable in this session's research pass (blocked at the network
-- egress layer, confirmed domain-wide, not per-site) — findings were
-- triangulated from web-search-indexed content, several of which
-- returned snippets sourced directly from immd.gov.hk pages,
-- cross-checked against immigration-law sourcing (Fragomen, BAL, EY).
--
-- Hong Kong's real, distinctive facts:
--   - India is NOT simply "visa-free" — since 23 January 2017, Indian
--     nationals must complete a mandatory, free, online Pre-Arrival
--     Registration (PAR) before every period of visa-free travel. A
--     successful PAR is valid 6 months, allows multiple visits, each
--     capped at 14 days, and is NOT extendable. This is a fee waiver
--     layered with a hard registration gate, genuinely different from
--     the simpler visa-free/visa-on-arrival systems of Thailand,
--     Vietnam, Malaysia, Japan, and South Korea already researched
--     this session.
--   - No separate visa categories exist for Business, Medical,
--     Conference, or Sports — Hong Kong collapses all of these into a
--     single Visit Visa/Entry Permit framework (the same PAR/visit-
--     visa mechanism used for tourism), differentiated only by
--     supporting documents, stated honestly here rather than inventing
--     distinct processes that don't exist.
--   - No Hong Kong consulate or embassy exists in India at all,
--     because Hong Kong SAR is not a sovereign state — every
--     application goes directly to the Immigration Department in Hong
--     Kong via its online e-Visa system, GovHK portal, or ImmD app.
--   - A newly restructured, tiered fee system (effective 26 February
--     2025) applies to "Specified Schemes" (GEP, Top Talent Pass
--     Scheme, QMAS, and others): a HKD 600 application fee plus a HKD
--     1,300 (over 180 days) or HKD 600 (180 days or less) issuance
--     fee — sitting alongside an older flat HKD 230 fee for ordinary
--     visit visas.
--   - Airport transit is essentially frictionless: Indian nationals
--     who stay airside and never cross into Hong Kong immigration
--     control need no visa and no PAR at all.
--
-- country_id 66 = Hong Kong. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Pre-Arrival Registration (PAR)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    66, 1, 'HKG-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing visits to Hong Kong SAR.',
    'All Indian passport holders with 6+ months passport validity, adequate funds, and an onward/return ticket. Must complete PAR (Pre-Arrival Registration) for stays up to 14 days — this is a mandatory free registration gate, not unconditional visa-free entry.',
    'Up to 14 days per visit, multiple entries within the 6-month PAR validity window; not extendable',
    'Online only — via the GovHK website, ImmD website, or the ImmD Mobile App',
    0,
    'PAR is near-instant to same-session online approval; a formal Visit Visa (for stays beyond 14 days) has no officially published SLA found this session',
    'None applicable — no Hong Kong consulate exists in India; applications go directly to the Immigration Department online',
    'Complete the online PAR form with passport details exactly matching your passport\nUpload your passport photo/data page\nReceive your approval notification slip\nPrint or save the slip\nPresent it at Hong Kong immigration control on arrival, with your passport, return ticket, and proof of funds',
    '/assets/images/visa-heroes/hong-kong.jpg',
    'Cross-checked immd.gov.hk PAR page content (via search snippet) triangulated against visa-consultancy sourcing (Godigit, BTW Visas) not directly fetchable this session', 'https://www.immd.gov.hk/', '2026-09-11'
);
SET @hk1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hk1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hk1, 'Core Documents', 'Every traveller needs these.', 1);
SET @hk1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hk1s1, 'Valid Passport', 'Valid 6+ months.', 'original', 1, 0, 1, 1),
(@hk1s1, 'Passport-Size Photo', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hk1, 'Travel Documents', 'Confirming your trip plan.', 2);
SET @hk1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hk1s2, 'Confirmed Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 1),
(@hk1s2, 'Proof of Accommodation', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hk1, 'Supporting Documents', 'May be requested by immigration on arrival.', 3);
SET @hk1s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hk1s3, 'Bank Statements/Proof of Financial Standing', NULL, 'copy', 1, 0, 0, 1),
(@hk1s3, 'Employer Leave Letter or Proof of Employment', NULL, 'original', 1, 0, 0, 2),
(@hk1s3, 'Travel Itinerary', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(66, 1, 0.00, 'HKD', 'PAR Fee', 'The PAR itself is free. A formal Visit Visa/Entry Permit, needed only for stays beyond 14 days, is reported at HKD 230 per application — not independently verified against the live ImmD Fee Tables page this session.', '2026-09-01', NOW(), 'https://www.immd.gov.hk/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Are Indian citizens visa-free in Hong Kong?', 'Not unconditionally — since 23 January 2017, Indian nationals must complete a mandatory, free, online Pre-Arrival Registration (PAR) before every period of visa-free travel. It''s a fee waiver with a hard registration gate, not automatic visa-free entry.', 66, 1, 1800, 1),
('Can I extend my PAR-based stay?', 'No — PAR is not extendable. It permits multiple visits within its 6-month validity, but each individual stay is capped at 14 days, and a longer stay needs a formal Visit Visa applied for separately.', 66, 1, 1801, 1),
('Where do I submit my Hong Kong visa application?', 'Directly to the Immigration Department in Hong Kong online — there is no Hong Kong consulate or embassy in India, since Hong Kong SAR is not a sovereign state.', 66, 1, 1802, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Same PAR/Visit Visa Framework
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    66, 2, 'HKG-BUS-IN-02', '2026.09', 'published',
    'Short-term business meetings, negotiations, site visits, and market exploration — not paid employment in Hong Kong.',
    'Hong Kong does NOT operate a separate "business visa" instrument for short visits — business travel falls under the same PAR/Visit Visa framework as tourism, differentiated only by supporting documents.',
    'Up to 14 days per visit under PAR; a formal Visit Visa is needed for longer or more frequent business stays',
    'Online PAR (same as tourist), or a formal Visit Visa application to ImmD for stays beyond 14 days',
    0,
    'PAR near-instant; a formal business visit visa was cited by one secondary source as up to 5 working days — unverified, single-source figure',
    'None applicable — direct to the Immigration Department online',
    'Secure an invitation letter from your Hong Kong host company\nComplete the online PAR form\nUpload your supporting business documents\nReceive your approval notification\nPresent it at immigration on arrival',
    '/assets/images/visa-heroes/hong-kong.jpg',
    'Cross-checked visa-consultancy sourcing (BTW Visas, Godigit, RadVisionWorld) triangulated against immd.gov.hk guidance not directly fetchable this session', 'https://www.immd.gov.hk/', '2026-09-11'
);
SET @hk2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hk2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hk2, 'Core Documents', 'Every applicant needs these.', 1);
SET @hk2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hk2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@hk2s1, 'Return Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hk2, 'Business Sponsorship Documents', 'Evidence of your Hong Kong host.', 2);
SET @hk2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hk2s2, 'Invitation Letter from Hong Kong-Based Company', NULL, 'original', 1, 0, 0, 1),
(@hk2s2, 'Indian Employer''s Business Registration Proof', NULL, 'copy', 1, 0, 0, 2),
(@hk2s2, 'Purpose-of-Visit Cover Letter', NULL, 'original', 1, 0, 0, 3),
(@hk2s2, 'Proof of Financial Standing', NULL, 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(66, 2, 0.00, 'HKD', 'PAR Fee', 'Free; a formal visa where needed is HKD 230 — no distinct "business visa fee" exists.', '2026-09-01', NOW(), 'https://www.immd.gov.hk/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Business Visa category for Hong Kong?', 'No — business travel uses the same PAR/Visit Visa framework as tourism. The distinguishing factor is your supporting documents, particularly an invitation letter from your Hong Kong host company.', 66, 2, 1803, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Form ID995A
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    66, 3, 'HKG-STU-IN-03', '2026.09', 'published',
    'Full-time study at a recognised Hong Kong educational institution.',
    'Must hold an unconditional offer of admission from a recognised Hong Kong institution for a full-time course.',
    'Tied to course duration; renewable through the institution each year/term via extension applications',
    'Online, usually coordinated through the institution''s international office, which submits on the student''s behalf to ImmD',
    0,
    'ImmD-sourced guidance suggests roughly 4 weeks after complete documents are received; university international offices advise budgeting 6-8 weeks in peak season',
    'None applicable — applications go via the institution/ImmD directly, not a consulate',
    'Secure your unconditional admission offer\nComplete Form ID995A (Application for Entry for Study in Hong Kong)\nYour institution submits/counter-signs the application to ImmD\nImmD processes and issues approval\nCollect your visa label/e-Visa before travel or on arrival per instructions',
    '/assets/images/visa-heroes/hong-kong.jpg',
    'Cross-checked immd.gov.hk Students/ID995A page content (via search snippet) triangulated against education-consultancy sourcing (Avanse, Yocket) not directly fetchable this session', 'https://www.immd.gov.hk/', '2026-09-11'
);
SET @hk3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hk3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hk3, 'Core Documents', 'Every applicant needs these.', 1);
SET @hk3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hk3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@hk3s1, 'Completed Form ID995A', NULL, 'original', 1, 0, 1, 2),
(@hk3s1, 'Admission Letter', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hk3, 'Financial & Accommodation Documents', 'Verifying your means and living arrangements.', 2);
SET @hk3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hk3s2, 'Proof of Sufficient Funds (Bank Statements/Sponsorship Letters)', 'Covering tuition and living costs.', 'copy', 1, 0, 0, 1),
(@hk3s2, 'Proof of Accommodation', 'Rental agreement/hostel confirmation.', 'copy', 1, 0, 0, 2),
(@hk3s2, 'Academic Transcripts/Certificates', 'Certified translations where required.', 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(66, 3, 330.00, 'HKD', 'Student Visa Fee (Effective 8 September 2025)', 'Reported by a secondary source (an education-loan provider), not independently cross-checked against the ImmD Fee Tables page directly this session.', '2025-09-08', NOW(), 'https://www.immd.gov.hk/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Who submits my student visa application?', 'Usually your institution''s international office, which acts as sponsor and submits on your behalf using Form ID995A — you can also self-file via ImmD''s online system.', 66, 3, 1804, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — General Employment Policy (GEP)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    66, 4, 'HKG-WORK-IN-04', '2026.09', 'published',
    'Employment of skilled professionals with a confirmed Hong Kong employer, where the role requires skills not readily available locally.',
    'Genuine job offer relevant to qualifications, solid educational background or relevant experience, salary/benefits matching local market rate, no adverse immigration/criminal record. GEP is quota-free and not sector-restricted.',
    'Typically an initial visa of up to 2 years, renewable',
    'Online via ImmD''s e-Visa/online application system — employer (sponsor) and employee both complete relevant parts',
    0,
    'ImmD-stated around 4 weeks for a complete application; other sources cite 4-6 weeks',
    'None applicable — direct to ImmD online; no Hong Kong consulate in India',
    'Secure a job offer from a Hong Kong employer\nYour employer/sponsor initiates the GEP application online\nSubmit supporting documents (both employer and employee portions)\nImmD assesses against GEP criteria\nReceive approval-in-principle\nCollect your visa and enter Hong Kong',
    '/assets/images/visa-heroes/hong-kong.jpg',
    'Cross-checked immd.gov.hk GEP page and "New Fee Structure for Specified Schemes" page content (via search snippets) triangulated against immigration-law sourcing (Fragomen, BAL, EY) not directly fetchable this session', 'https://www.immd.gov.hk/', '2026-09-11'
);
SET @hk4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hk4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hk4, 'Core Documents', 'Every applicant needs these.', 1);
SET @hk4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hk4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@hk4s1, 'Employment Offer/Contract', NULL, 'original', 1, 0, 1, 2),
(@hk4s1, 'CV/Resume', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hk4, 'Employer & Qualification Documents', 'Evidence of the role and your background.', 2);
SET @hk4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hk4s2, 'Employer''s Business Registration and Company Profile/Justification Letter', 'Explaining why the role needs this specific candidate.', 'copy', 1, 0, 0, 1),
(@hk4s2, 'Salary and Benefits Details Benchmarked to Market', NULL, 'copy', 1, 0, 0, 2),
(@hk4s2, 'Proof of Specialized Skills/Experience', 'Reference letters, portfolio.', 'copy', 1, 0, 0, 3),
(@hk4s2, 'Educational Certificates', NULL, 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(66, 4, 1900.00, 'HKD', 'GEP Fee (Application + Issuance, >180 Days)', 'Under the Feb 2025 fee restructure: HKD 600 non-refundable application fee plus HKD 1,300 issuance fee (if approved stay exceeds 180 days) or HKD 600 (if 180 days or less).', '2025-02-26', NOW(), 'https://www.immd.gov.hk/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Hong Kong''s work visa quota-limited?', 'No — the General Employment Policy is quota-free and not restricted to specific sectors, unlike some countries'' work-visa systems.', 66, 4, 1805, 1),
('How much does a Hong Kong work visa cost?', 'Under the February 2025 fee restructure for GEP and other "Specified Schemes," expect a HKD 600 application fee plus a HKD 1,300 issuance fee for a stay exceeding 180 days, totalling roughly HKD 1,900.', 66, 4, 1806, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Same PAR/Visit Visa Framework
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    66, 5, 'HKG-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives/family resident in Hong Kong, as distinct from the longer-term Dependant visa for relocating with a working/studying sponsor.',
    'Falls under the same general Visit Visa/PAR framework as tourism — Hong Kong has no distinct "family visit visa" category; the difference is only in supporting documentation.',
    'Up to 14 days under PAR; longer visits require a formal Visit Visa',
    'Online PAR, or a formal Visit Visa application to ImmD',
    0,
    'Same as general Visit Visa — not officially guaranteed by ImmD for standard cases',
    'None applicable — direct to ImmD online',
    'Ask your Hong Kong-based relative for an invitation and relationship proof\nComplete the online PAR form\nUpload your supporting documents\nReceive your approval notification\nPresent it at immigration on arrival',
    '/assets/images/visa-heroes/hong-kong.jpg',
    'Cross-checked visa-consultancy sourcing (Bankbazaar, Godigit) and cgihk.gov.in references triangulated against immd.gov.hk Guidebook ID(E)1004 content not directly fetchable this session', 'https://www.immd.gov.hk/', '2026-09-11'
);
SET @hk5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hk5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hk5, 'Core Documents', 'Every traveller needs these.', 1);
SET @hk5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hk5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@hk5s1, 'Return Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hk5, 'Relationship Documents', 'Evidence of your Hong Kong-based host.', 2);
SET @hk5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hk5s2, 'Proof of Relationship', 'Marriage/birth certificate.', 'copy', 1, 0, 0, 1),
(@hk5s2, 'Invitation Letter from Hong Kong-Based Relative', NULL, 'original', 1, 0, 0, 2),
(@hk5s2, 'Sponsor''s Passport/HKID Copy', NULL, 'copy', 1, 0, 0, 3),
(@hk5s2, 'Sponsor''s Accommodation and Financial Standing Proof', 'Lease/utility bill, bank statements/tax receipts/salary slips.', 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(66, 5, 0.00, 'HKD', 'PAR Fee', 'Free; a formal visa where needed is HKD 230 — same schedule as tourist/business, no separate family-visit fee identified.', '2026-09-01', NOW(), 'https://www.immd.gov.hk/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a distinct Family Visit Visa for Hong Kong?', 'No — it uses the same PAR/Visit Visa framework as tourism, differentiated only by relationship proof and an invitation letter from your host.', 66, 5, 1807, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    66, 6, 'HKG-TRANS-IN-06', '2026.09', 'published',
    'Passing through Hong Kong en route to a third destination.',
    'Indian nationals in direct airside transit who do not leave the airport transit area are exempt from PAR entirely. Those who wish to leave the airport during transit need a completed PAR, same as any other visit, capped at 14 days.',
    'No defined limit for airside-only transit; up to 14 days under PAR if leaving the airport',
    'None needed for airside-only transit; online PAR if leaving the airport transit area',
    0,
    'Not applicable for airside transit; PAR is near-instant if needed',
    'None applicable',
    'Confirm whether you will remain airside for your connection\nIf staying airside, no action is needed beyond normal airline transit procedures\nIf leaving the airport, complete PAR in advance exactly as for a tourist visit',
    '/assets/images/visa-heroes/hong-kong.jpg',
    'Cross-checked immd.gov.hk PAR page content (via search snippet) triangulated against visa-consultancy sourcing (TataAIG, Useteleport) not directly fetchable this session', 'https://www.immd.gov.hk/', '2026-09-11'
);
SET @hk6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hk6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hk6, 'Core Documents', 'Every traveller needs these.', 1);
SET @hk6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hk6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@hk6s1, 'Onward Flight Ticket/Boarding Pass', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hk6, 'If Leaving the Airport', 'Only relevant if you need to exit the transit area.', 2);
SET @hk6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hk6s2, 'Proof of Funds', 'If leaving the airport.', 'copy', 0, 1, 0, 1),
(@hk6s2, 'Proof of Accommodation', 'If leaving the airport.', 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(66, 6, 0.00, 'HKD', 'No Visa Needed for Airside Transit', 'PAR is free if leaving the airport is required. One secondary source cites a specific 48-hour layover threshold, but this could not be verified against an official ImmD source this session.', '2026-09-01', NOW(), 'https://www.immd.gov.hk/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa if I stay in the airport during my Hong Kong layover?', 'No — Indian nationals in direct airside transit who do not leave the airport transit area are fully exempt from both a visa and PAR.', 66, 6, 1808, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — No Dedicated Category
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    66, 7, 'HKG-MED-IN-07', '2026.09', 'published',
    'Travel to Hong Kong to receive medical treatment.',
    'Hong Kong has no dedicated "Medical Visa" category. Medical-treatment travellers use the same general Visit Visa/Entry Permit (and PAR, if the stay is 14 days or less) as tourists, providing medical-specific supporting documents.',
    'Up to 14 days under PAR; a formal Visit Visa (with hospital-backed documentation) is needed for longer treatment/recovery periods',
    'Online PAR (for short stays) or a formal Visit Visa application for longer/complex treatment',
    0,
    'Same as general Visit Visa — no official fast-track guarantee found',
    'None applicable — direct to ImmD online',
    'Confirm your treatment plan with a Hong Kong hospital/clinic\nComplete the online PAR form (or formal Visit Visa application if longer)\nUpload your medical documentation\nReceive your approval notification\nPresent it at immigration on arrival',
    '/assets/images/visa-heroes/hong-kong.jpg',
    'immd.gov.hk visit-visa page (via search snippet) explicitly confirms no dedicated medical visa category was found in retrieved content', 'https://www.immd.gov.hk/', '2026-09-11'
);
SET @hk7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hk7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hk7, 'Core Documents', 'Every traveller needs these.', 1);
SET @hk7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hk7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@hk7s1, 'Return Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hk7, 'Medical Documents', 'Evidence of your treatment plan.', 2);
SET @hk7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hk7s2, 'Hospital/Clinic Appointment Confirmation or Referral Letter', NULL, 'original', 1, 0, 0, 1),
(@hk7s2, 'Treatment Cost Estimate', NULL, 'copy', 1, 0, 0, 2),
(@hk7s2, 'Proof of Funds to Cover Treatment and Stay', NULL, 'copy', 1, 0, 0, 3),
(@hk7s2, 'Medical Records/Diagnosis Summary', NULL, 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(66, 7, 0.00, 'HKD', 'PAR Fee', 'Free; a formal visa where needed is HKD 230 — no separate medical-visa fee found because no separate category exists.', '2026-09-01', NOW(), 'https://www.immd.gov.hk/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Medical Visa for Hong Kong?', 'No — Hong Kong has no distinct Medical Visa category. Medical travellers use the same general Visit Visa/PAR framework as tourists, with hospital documentation as supporting evidence.', 66, 7, 1809, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — No Dedicated Category
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    66, 8, 'HKG-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, trade fairs, exhibitions, and seminars in Hong Kong.',
    'No dedicated "Conference Visa" exists — this is handled as a Business/Visit purpose under the same general Visit Visa/PAR framework.',
    'Up to 14 days under PAR; longer for extended conference programmes requires a formal Visit Visa',
    'Online PAR, or a formal Visit Visa for longer stays',
    0,
    'Same as general Visit Visa',
    'None applicable — direct to ImmD online',
    'Register for the conference and obtain an invitation/registration confirmation\nComplete the online PAR form\nUpload your supporting documents\nReceive your approval notification\nPresent it at immigration on arrival',
    '/assets/images/visa-heroes/hong-kong.jpg',
    'Cross-checked immd.gov.hk visit-visa framework (via search snippet) confirming no dedicated conference-visa category, triangulated against insurance/travel sourcing (Zurich Kotak, Niva Bupa)', 'https://www.immd.gov.hk/', '2026-09-11'
);
SET @hk8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hk8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hk8, 'Core Documents', 'Every applicant needs these.', 1);
SET @hk8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hk8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@hk8s1, 'Return Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hk8, 'Event Documents', 'Evidence of your reason for attending.', 2);
SET @hk8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hk8s2, 'Conference/Event Registration or Invitation from Organizer', NULL, 'original', 1, 0, 0, 1),
(@hk8s2, 'Proof of Employer Sponsorship', 'If company-sponsored attendance.', 'original', 0, 1, 0, 2),
(@hk8s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(66, 8, 0.00, 'HKD', 'PAR Fee', 'Free; a formal visa where needed is HKD 230 — same as business/tourist, no distinct conference fee.', '2026-09-01', NOW(), 'https://www.immd.gov.hk/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Conference Visa for Hong Kong?', 'No — it is handled as a Business/Visit purpose under the same general Visit Visa/PAR framework, with your event registration or invitation as supporting evidence.', 66, 8, 1810, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — No Dedicated Category
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    66, 9, 'HKG-SPORT-IN-09', '2026.09', 'published',
    'Athletes/officials travelling to Hong Kong for competitions, tournaments, or training camps.',
    'No dedicated sports/athlete visa category was found — this falls under the general Visit Visa/PAR framework, same as tourist/business, a confirmed absence rather than an unresearched gap.',
    'Up to 14 days under PAR; a formal Visit Visa is needed for longer tournament/training stays',
    'Online PAR, or a formal Visit Visa',
    0,
    'Same as general Visit Visa',
    'None applicable — direct to ImmD online',
    'Obtain event accreditation/participation confirmation from the organizing sports body\nComplete the online PAR form\nUpload your supporting documents\nReceive your approval notification\nPresent it at immigration on arrival',
    '/assets/images/visa-heroes/hong-kong.jpg',
    'Explicit search for an athlete-specific scheme returned none in either official-source snippets or secondary sourcing — a confirmed absence, stated honestly rather than an invented category', 'https://www.immd.gov.hk/', '2026-09-11'
);
SET @hk9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hk9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hk9, 'Core Documents', 'Every applicant needs these.', 1);
SET @hk9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hk9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@hk9s1, 'Return Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hk9, 'Event & Federation Documents', 'Evidence of your athletic affiliation.', 2);
SET @hk9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hk9s2, 'Event Accreditation/Participation Confirmation', 'From the organizing sports body/federation.', 'original', 1, 0, 0, 1),
(@hk9s2, 'Letter from National Sports Federation', 'If applicable.', 'original', 0, 1, 0, 2),
(@hk9s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(66, 9, 0.00, 'HKD', 'PAR Fee', 'Free; a formal visa where needed is HKD 230.', '2026-09-01', NOW(), 'https://www.immd.gov.hk/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Sports Visa for Hong Kong?', 'No — a specific search for an athlete-related scheme found none, either in official sourcing or independent secondary sources. Athletes use the same general Visit Visa/PAR framework as any other visitor.', 66, 9, 1811, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    66, 10, 'HKG-DEP-IN-10', '2026.09', 'published',
    'Spouse and unmarried dependent children (under 18) joining a sponsor already living/working/studying in Hong Kong under an eligible visa category.',
    'Sponsor must hold an eligible Hong Kong visa (e.g. GEP, other employment, investment, or in some cases student visas per institution policy) and demonstrate financial capacity and suitable accommodation to support dependants.',
    'Tied to the sponsor''s visa validity/renewal cycle',
    'Online — the sponsor and dependant jointly complete their respective parts through ImmD''s online system and sign electronically',
    0,
    'Not independently confirmed this session; likely similar to GEP (around 4-6 weeks) since dependant status is derivative of the sponsor''s category',
    'None applicable — direct to ImmD''s online system',
    'Confirm your sponsor holds an eligible Hong Kong visa\nSponsor and dependant jointly complete the online dependant application\nSubmit proof of relationship and the sponsor''s financial/accommodation proof\nImmD assesses the application\nReceive approval and visa issuance\nTravel to Hong Kong',
    '/assets/images/visa-heroes/hong-kong.jpg',
    'Cross-checked immd.gov.hk Dependants page/Guidebook ID(E)998 content (via search snippet) triangulated against immigration-consultancy sourcing (Woodburn Global, StudyIn.hk) not directly fetchable this session', 'https://www.immd.gov.hk/', '2026-09-11'
);
SET @hk10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hk10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hk10, 'Core Documents', 'Every dependant needs these.', 1);
SET @hk10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hk10s1, 'Dependant''s Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@hk10s1, 'Sponsor''s Passport/HKID Copy', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hk10, 'Relationship & Sponsor Documents', 'Evidence of your sponsor''s status and means.', 2);
SET @hk10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hk10s2, 'Marriage Certificate (Spouse) or Birth Certificate (Children)', NULL, 'original', 1, 0, 0, 1),
(@hk10s2, 'Sponsor''s Proof of Financial Standing', 'Bank statements, tax receipts, employment proof, salary slips.', 'copy', 1, 0, 0, 2),
(@hk10s2, 'Sponsor''s Proof of Hong Kong Accommodation', 'Lease agreement, utility bill.', 'copy', 1, 0, 0, 3),
(@hk10s2, 'Sponsor''s Own Visa/Employment Approval Documents', NULL, 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(66, 10, NULL, 'HKD', 'Confirmed After Assessment', 'One secondary source cites HKD 230 for a standalone dependant application, but it is unclear whether dependants of Specified-Scheme sponsors (e.g. GEP) now pay the newer HKD 600+HKD 600/1,300 structure instead. Contact us to confirm the current fee for your sponsor''s category.', '2026-09-01', NOW(), 'https://www.immd.gov.hk/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Who can sponsor a Dependent Visa in Hong Kong?', 'Someone who holds an eligible Hong Kong visa (such as GEP, other employment, investment, or in some cases a student visa per institution policy) and can demonstrate financial capacity and suitable accommodation to support their dependants.', 66, 10, 1812, 1);
