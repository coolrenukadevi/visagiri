-- Indonesia Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search, same standard as every other
-- country built this session (see AUDIT.md). hero_image_url points at
-- the real Bali Ulun Danu Beratan Temple photo supplied by the client
-- for this hero.
--
-- IMPORTANT SOURCING CAVEAT: official primary sources (evisa.
-- imigrasi.go.id, imigrasi.go.id, kemlu.go.id) were not directly
-- fetchable in this session's research pass (blocked at the network
-- egress layer) — findings were triangulated from web-search-indexed
-- content across visa-consultancy and immigration-law sourcing.
-- Several government-only fee figures (Medical C3, Sports C8/C8A)
-- could not be separated from agency-inclusive pricing and are marked
-- "Confirmed After Assessment" rather than guessed.
--
-- Indonesia's real, distinctive facts:
--   - India is NOT on Indonesia's visa-free list at all, unlike
--     several ASEAN neighbours already researched this session —
--     every Indian traveller needs at least an e-VOA, even as
--     Indonesia cut total visa-free-entry approvals for all eligible
--     nationalities by roughly 87.9% in H1 2026 under a deliberate
--     "selective immigration" policy.
--   - Indonesia switched to a notably granular C-/D-/E- visa-index
--     coding system in 2025 (C1, C2, C3...C22, D1, D2, E23, E31...),
--     more finely split by purpose than most ASEAN neighbours'
--     simpler tourist/business divide — reflected in the reference
--     codes and category names used throughout this checklist.
--   - A real, dated (28 May 2025) mandatory in-person biometric
--     re-registration requirement applies to ANY extension of a
--     C1/e-VOA visa — fingerprints, photo, signature, and a short
--     interview at a local immigration office, a notably stricter
--     enforcement layer than what's documented for several
--     neighbouring countries' extension processes.
--   - A genuine, Bali-specific sub-national tourist tax (IDR 150,000,
--     paid via the official "Love Bali" portal) stacks on top of the
--     national visa fee for anyone entering Bali specifically — a
--     local-government-level charge with no direct equivalent in the
--     other Southeast Asian countries researched this session.
--   - Work visas carry a distinctive recurring monthly levy (DKPTKA,
--     USD 100/month of KITAS validity) paid into a foreign-worker
--     compensation fund, on top of standard visa/KITAS fees — a
--     structurally different cost model from a one-time visa fee.
--
-- country_id 68 = Indonesia. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — e-VOA or C1 e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    68, 1, 'IDN-TOUR-IN-01', '2026.09', 'published',
    'Leisure and tourism travel to Indonesia.',
    'India is NOT on Indonesia''s visa-free list — all Indian travellers need either the e-VOA or a C1 e-Visa. Two routes: e-VOA (30 days, single entry, extendable once to 60 days total) or C1 e-Visa (60 days initial, extendable up to 180 days total).',
    'e-VOA: up to 60 days total (with one extension). C1 e-Visa: up to 180 days total',
    'Online in advance at evisa.imigrasi.go.id, or e-VOA stamped on arrival at eligible airports/seaports',
    0,
    'e-VOA near-instant to 1-3 days; C1 e-Visa around 3-5 business days',
    'No embassy visit needed for pure tourism — online portal or on-arrival VOA counter',
    'Choose your route: e-VOA for a shorter, simpler stay, or the C1 e-Visa for a longer one\nCreate an account at evisa.imigrasi.go.id, verify your email\nUpload your passport bio page and photo\nPay online\nReceive approval, or get the e-VOA stamped on arrival at an eligible airport/seaport',
    '/assets/images/visa-heroes/indonesia.jpg',
    'Cross-checked visa-consultancy sourcing (Wego, BTW Visas, Komodo Resort) triangulated against evisa.imigrasi.go.id guidance not directly fetchable this session', 'https://evisa.imigrasi.go.id/', '2026-09-11'
);
SET @id1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@id1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@id1, 'Core Documents', 'Every traveller needs these.', 1);
SET @id1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@id1s1, 'Valid Passport', 'Valid 6+ months, blank pages.', 'original', 1, 0, 1, 1),
(@id1s1, 'Passport-Size Digital Photo', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@id1, 'Travel Documents', 'Confirming your trip plan.', 2);
SET @id1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@id1s2, 'Proof of Onward/Return Ticket', NULL, 'copy', 1, 0, 1, 1),
(@id1s2, 'Proof of Accommodation', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@id1, 'Financial & Supporting Documents', 'May be requested on entry.', 3);
SET @id1s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@id1s3, 'Proof of Sufficient Funds/Bank Statement', NULL, 'copy', 1, 0, 0, 1),
(@id1s3, 'Detailed Itinerary', NULL, 'copy', 0, 1, 0, 2),
(@id1s3, 'Invitation Letter', 'If staying with a host.', 'original', 0, 1, 0, 3),
(@id1s3, 'Travel Insurance', 'Where requested.', 'copy', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(68, 1, 500000.00, 'IDR', 'e-VOA Fee (30 Days)', 'Roughly USD 31 / INR 2,700-3,000. The C1 e-Visa alternative costs IDR 1,500,000 (roughly USD 100) for 60 days, extendable to 180. Anyone entering Bali specifically also pays a separate one-time Bali Tourism Levy of IDR 150,000 via the official "Love Bali" portal.', '2026-09-01', NOW(), 'https://evisa.imigrasi.go.id/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Are Indian citizens visa-free in Indonesia?', 'No — India is not on Indonesia''s visa-free list. Every Indian traveller needs at least the e-VOA, even for a short tourist visit.', 68, 1, 1700, 1),
('Is there an extra charge for visiting Bali specifically?', 'Yes — a one-time Bali Tourism Levy of IDR 150,000 (about USD 10), paid via the official "Love Bali" portal, applies on top of your national visa fee for anyone entering Bali.', 68, 1, 1701, 1),
('Do I need to appear in person to extend my tourist visa?', 'Yes — since 28 May 2025, any extension of a C1/e-VOA visa requires mandatory in-person biometric registration (fingerprints, photo, signature, and a short interview) at a local immigration office.', 68, 1, 1702, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — C2 Single Entry or D2 Multiple Entry
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    68, 2, 'IDN-BUS-IN-02', '2026.09', 'published',
    'Meetings, negotiations, investment/factory-site visits — explicitly not salaried employment.',
    'Indian nationals invited by an Indonesian company/sponsor for legitimate business activity; no local income allowed. Category C2 (single entry, 60 days, extendable twice to 180 days total) or D2 (multiple entry, valid 1/2/5 years, up to 60 days per visit).',
    'C2: up to 180 days total. D2: up to 60 days per visit, over a 1/2/5-year validity',
    'Online e-visa via evisa.imigrasi.go.id, requiring an Indonesian sponsor company''s invitation',
    0,
    'Reported around 5-7 business days',
    'Online portal; embassy/consulate involvement only in flagged/special cases',
    'Secure an invitation from your Indonesian sponsor company\nApply online at evisa.imigrasi.go.id, choosing C2 or D2\nUpload your sponsor''s documentation\nPay online\nReceive your e-visa',
    '/assets/images/visa-heroes/indonesia.jpg',
    'Cross-checked visa-consultancy sourcing (Let''s Move Indonesia, BTW Visas) triangulated against evisa.imigrasi.go.id guidance not directly fetchable this session', 'https://evisa.imigrasi.go.id/', '2026-09-11'
);
SET @id2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@id2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@id2, 'Core Documents', 'Every applicant needs these.', 1);
SET @id2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@id2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@id2s1, 'Business Invitation/Sponsor Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@id2, 'Sponsor Company Documents', 'Evidence of the Indonesian host company.', 2);
SET @id2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@id2s2, 'Sponsor Company''s Legal Registration & Tax ID (NPWP)', NULL, 'copy', 1, 0, 0, 1),
(@id2s2, 'Applicant''s Bank Statement', NULL, 'copy', 1, 0, 0, 2),
(@id2s2, 'Detailed Business Itinerary', NULL, 'copy', 1, 0, 0, 3),
(@id2s2, 'Company Guarantee Letter', NULL, 'original', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(68, 2, 2000000.00, 'IDR', 'C2 Visa Fee (60 Days)', 'Roughly USD 130. D2 multiple-entry fee varies genuinely by validity tier (1/2/5-year) — contact us for a case-specific quote.', '2026-09-01', NOW(), 'https://evisa.imigrasi.go.id/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What''s the difference between C2 and D2 for business travel?', 'C2 is a single-entry visa valid up to 180 days total. D2 is a multiple-entry visa valid for 1, 2, or 5 years, allowing up to 60 days per visit — better suited to frequent business travellers.', 68, 2, 1703, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — C316 Study Visa / Student KITAS
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    68, 3, 'IDN-STU-IN-03', '2026.09', 'published',
    'Study at an Indonesian institution registered with the Ministry of Education, Culture, Research & Technology.',
    'Must first be accepted by an Indonesian institution and obtain a Study Permit from the Ministry; the institution acts as sponsor/guarantor and files the application on the student''s behalf.',
    'VITAS valid 30 days to enter; Student KITAS thereafter valid up to 2 years, extendable a maximum of 2 times, 2 years each',
    'University submits a sponsorship request to Immigration; student then collects the visa and converts to Student KITAS locally',
    1,
    'Visa stage reported at 5-10 business days; full KITAS process takes longer, not precisely quantified',
    'Indonesian Embassy, New Delhi, or the relevant honorary consulate (Mumbai/Chennai/Kolkata), primarily routed through the sponsoring institution',
    'Secure acceptance from an Indonesian institution\nInstitution requests a Study Permit and files the sponsorship/telex request with Immigration\nCollect your visa\nEnter Indonesia\nConvert to Student KITAS at the local immigration office',
    '/assets/images/visa-heroes/indonesia.jpg',
    'Cross-checked education-consultancy sourcing (Akbar Travels, BINUS Global) triangulated against official guidance not directly fetchable this session', 'https://www.imigrasi.go.id/', '2026-09-11'
);
SET @id3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@id3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@id3, 'Core Documents', 'Every applicant needs these.', 1);
SET @id3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@id3s1, 'Valid Passport', 'At least 2 blank pages.', 'original', 1, 0, 1, 1),
(@id3s1, 'Official Letter of Acceptance from the Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@id3, 'Sponsorship & Financial Documents', 'Verifying your study plan and means.', 2);
SET @id3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@id3s2, 'Proof of Funds (USD 1,500-2,000)', NULL, 'copy', 1, 0, 0, 1),
(@id3s2, 'Ministry of Education/Culture Recommendation Letter', NULL, 'original', 1, 0, 0, 2),
(@id3s2, 'Study Permit Letter', NULL, 'original', 1, 0, 0, 3),
(@id3s2, 'Institutional Sponsor/Guarantee Letter', NULL, 'original', 1, 0, 0, 4),
(@id3s2, 'Academic Transcripts', NULL, 'copy', 1, 0, 0, 5);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(68, 3, NULL, 'USD', 'Confirmed After Assessment', 'One secondary source cites a non-refundable USD 150 visa application fee; KITAS conversion/extension carries additional cost not itemized this session. Contact us for the current figure.', '2026-09-01', NOW(), 'https://www.imigrasi.go.id/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Who files my Indonesian student visa application?', 'Your institution''s international office submits the sponsorship/telex request to the Directorate General of Immigration on your behalf — you then collect the visa and convert it to a Student KITAS after arrival.', 68, 3, 1704, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Working KITAS
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    68, 4, 'IDN-WORK-IN-04', '2026.09', 'published',
    'Paid employment in Indonesia.',
    'Employer must first secure an RPTKA (Foreign Worker Utilization Plan) approval from the Ministry of Manpower. Sponsor must be a registered Indonesian entity — a foreign-owned company (PMA), representative office, or local company. Applicant may not legally work while the KITAS is still processing.',
    'Working KITAS issued for 6 months/1 year/2 years, renewable while employment continues',
    'Multi-stage: employer obtains RPTKA approval, applicant applies for a Telex/VITAS at the Embassy, enters Indonesia, converts to KITAS',
    1,
    'Whole process (RPTKA to visa to KITAS) reported at roughly 10 weeks',
    'Indonesian Embassy, New Delhi, or the relevant honorary consulate, for telex-visa collection',
    'Secure a job offer and have your employer obtain RPTKA/work-permit approval from the Ministry of Manpower\nApply for a Telex/VITAS visa at the Indonesian Embassy/Consulate\nEnter Indonesia on the VITAS\nConvert to Working KITAS at the local immigration office',
    '/assets/images/visa-heroes/indonesia.jpg',
    'Cross-checked immigration-consultancy sourcing (Emerhub, Acclime, AYP Group) triangulated against official guidance not directly fetchable this session', 'https://www.imigrasi.go.id/', '2026-09-11'
);
SET @id4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@id4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@id4, 'Core Documents', 'Every applicant needs these.', 1);
SET @id4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@id4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@id4s1, 'Signed Employment Contract/Offer Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@id4, 'Employer & Qualification Documents', 'Evidence of your sponsor and background.', 2);
SET @id4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@id4s2, 'RPTKA/Work-Permit Approval Documents', NULL, 'copy', 1, 0, 0, 1),
(@id4s2, 'CV/Educational Certificates', NULL, 'copy', 1, 0, 0, 2),
(@id4s2, 'Company''s Business License and NPWP', NULL, 'copy', 1, 0, 0, 3),
(@id4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 4),
(@id4s2, 'Health Certificate', NULL, 'original', 1, 0, 0, 5);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(68, 4, NULL, 'USD', 'Confirmed After Assessment', 'Total cost genuinely variable, reported around USD 1,800-2,200 per employee — dominated by the DKPTKA foreign-worker levy of USD 100/month (USD 1,200 for a 12-month KITAS) plus KITAS/visa fees. Contact us for a case-specific quote.', '2026-09-01', NOW(), 'https://www.imigrasi.go.id/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is the DKPTKA levy?', 'A recurring foreign-worker compensation-fund charge of USD 100 per month of KITAS validity (USD 1,200 for a 1-year permit), paid on top of standard visa/KITAS fees — a distinctive, ongoing cost rather than a one-time visa fee.', 68, 4, 1705, 1),
('Can I start working while my KITAS is still processing?', 'No — you may not legally work in Indonesia until your Working KITAS has been fully processed and issued.', 68, 4, 1706, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — C1 (shared with Tourist)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    68, 5, 'IDN-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives resident in Indonesia for a short visit.',
    'Uses the same Index C1 (Single Entry Visit Visa) as tourism — Indonesia''s C1 category explicitly covers "tourism, family visits, or transit." Longer-term family reunification instead uses the Dependent/Family KITAS.',
    'Up to 60 days initial, extendable to 180 days total, same as C1 Tourist',
    'Online e-visa (C1) via evisa.imigrasi.go.id, requiring an invitation letter from the Indonesia-based family member',
    0,
    'Roughly 3-5 business days, same as standard C1',
    'Online portal; embassy in New Delhi/consulates as an alternative channel',
    'Obtain an invitation letter from your Indonesia-based relative\nApply online at evisa.imigrasi.go.id, selecting C1\nUpload the required documents\nPay online\nReceive your e-visa',
    '/assets/images/visa-heroes/indonesia.jpg',
    'Cross-checked visa-consultancy sourcing triangulated against evisa.imigrasi.go.id guidance not directly fetchable this session', 'https://evisa.imigrasi.go.id/', '2026-09-11'
);
SET @id5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@id5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@id5, 'Core Documents', 'Every traveller needs these.', 1);
SET @id5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@id5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@id5s1, 'Host''s Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@id5, 'Relationship & Sponsor Documents', 'Evidence of your host''s status.', 2);
SET @id5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@id5s2, 'Proof of Family Relationship', 'Birth/marriage certificate.', 'copy', 1, 0, 0, 1),
(@id5s2, 'Host''s Indonesian ID/KITAS Copy', NULL, 'copy', 1, 0, 0, 2),
(@id5s2, 'Host''s Stamped Guarantee/Sponsorship Letter', NULL, 'original', 1, 0, 0, 3),
(@id5s2, 'Financial Guarantee', NULL, 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(68, 5, 1500000.00, 'IDR', 'C1 e-Visa Fee', 'Roughly USD 100 — same fee structure as Tourist C1; the cheaper e-VOA (IDR 500,000) may also apply where eligible.', '2026-09-01', NOW(), 'https://evisa.imigrasi.go.id/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a distinct Family Visit Visa for Indonesia?', 'Not as a separate application — it uses the same C1 category as Tourist, which explicitly covers tourism, family visits, and transit.', 68, 5, 1707, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    68, 6, 'IDN-TRANS-IN-06', '2026.09', 'published',
    'Passing through Indonesia en route to a third country.',
    'No dedicated standalone "transit visa" product exists. Staying airside within the international transit zone needs no visa. Leaving the transit area (overnight, changing airports, re-checking baggage) requires the same e-VOA/e-Visa as a tourist.',
    'No defined stay if remaining airside; the same e-VOA rules (up to 60 days) apply if leaving the transit zone',
    'Same e-VOA online/on-arrival process as tourism, only if leaving the transit zone',
    0,
    'e-VOA: 1-3 days if pre-applied, or instant on arrival',
    'No office visit needed if remaining airside; online e-VOA otherwise',
    'Confirm whether you need to leave the international transit zone\nIf not, no visa is needed at all\nIf yes, apply for the e-VOA the same way as a tourist visit\nPresent it with your passport on arrival',
    '/assets/images/visa-heroes/indonesia.jpg',
    'Cross-checked visa-consultancy sourcing triangulated against evisa.imigrasi.go.id guidance not directly fetchable this session', 'https://evisa.imigrasi.go.id/', '2026-09-11'
);
SET @id6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@id6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@id6, 'Core Documents', 'Every traveller needs these.', 1);
SET @id6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@id6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@id6s1, 'Confirmed Onward Ticket to Third Country', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@id6, 'If Leaving the Transit Zone', 'Only relevant if you need to exit the airport.', 2);
SET @id6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@id6s2, 'Destination Country''s Visa (If Required)', NULL, 'copy', 0, 1, 0, 1),
(@id6s2, 'Proof of Confirmed Connecting Booking', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(68, 6, 500000.00, 'IDR', 'e-VOA Fee (If Leaving the Transit Zone)', 'No fee applies if remaining entirely airside within the international transit zone.', '2026-09-01', NOW(), 'https://evisa.imigrasi.go.id/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Indonesia have a dedicated transit visa?', 'No — there is no standalone transit visa product. Staying airside needs nothing at all; leaving the transit zone requires the standard e-VOA, the same as a short tourist visit.', 68, 6, 1708, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — C3 Medical Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    68, 7, 'IDN-MED-IN-07', '2026.09', 'published',
    'Medical treatment, wellness therapy, or recovery at a registered Indonesian hospital/clinic, including an accompanying family member.',
    'Category C3 (Medical Visa, Single Entry), sponsored by either the treating hospital/clinic or a self-declaration statement from the applicant.',
    '60 days initial, extendable up to 2 times, 60 days each, maximum 180 days total',
    'Online e-visa via evisa.imigrasi.go.id, category C3',
    0,
    'Initial processing time not clearly confirmed this session',
    'Online portal; embassy involvement only in flagged cases',
    'Confirm your treatment plan with a registered Indonesian hospital/clinic\nApply online at evisa.imigrasi.go.id, selecting C3\nUpload your hospital confirmation and supporting documents\nPay online\nReceive your e-visa',
    '/assets/images/visa-heroes/indonesia.jpg',
    'Cross-checked medical-tourism sourcing (Bali Visa Advisor, Empat Pillar Medika) triangulated against official guidance not directly fetchable this session', 'https://evisa.imigrasi.go.id/', '2026-09-11'
);
SET @id7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@id7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@id7, 'Core Documents', 'Every applicant needs these.', 1);
SET @id7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@id7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@id7s1, 'Hospital/Doctor''s Appointment Confirmation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@id7, 'Medical & Financial Documents', 'Evidence of your treatment plan.', 2);
SET @id7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@id7s2, 'Medical Records/Diagnosis Summary', NULL, 'copy', 1, 0, 0, 1),
(@id7s2, 'Hospital''s Letter of Guarantee/Acceptance', NULL, 'original', 1, 0, 0, 2),
(@id7s2, 'Proof of Financial Capacity to Cover Treatment', NULL, 'copy', 1, 0, 0, 3),
(@id7s2, 'Insurance Details', 'If applicable.', 'copy', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(68, 7, NULL, 'IDR', 'Confirmed After Assessment', 'Agency-quoted pricing ranges IDR 2,200,000-3,000,000 (roughly USD 136-186), but the pure government-only fee could not be separated from service charges this session. Contact us for a case-specific quote.', '2026-09-01', NOW(), 'https://evisa.imigrasi.go.id/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can a family member accompany me on a Medical Visa?', 'Yes — the C3 Medical Visa category covers both the patient and an accompanying family member.', 68, 7, 1709, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — C10 / C11
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    68, 8, 'IDN-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, seminars, exhibitions as a participant, speaker, exhibitor, or invited guest.',
    'Indonesia splits this more finely than most neighbours: C2 (Business, covers attending as a participant), C10 (Invited Event Participant — speakers, lecturers, presenters), or C11 (Exhibitions & Conferences Participation — exhibitors).',
    '60 days, extendable, mirroring C2 rules',
    'Online e-visa via evisa.imigrasi.go.id, requiring an official conference/event invitation letter naming the event, dates, venue, and your details',
    0,
    'One agency source quotes C11 as roughly 7-10 business days standard / 3-4 business days express — likely agency SLA tiers rather than confirmed government timelines',
    'Online portal; embassy involvement only in flagged cases',
    'Register for the event and obtain an official invitation letter from the organizer\nApply online at evisa.imigrasi.go.id, selecting C10 or C11 as appropriate\nUpload your supporting documents\nPay online\nReceive your e-visa',
    '/assets/images/visa-heroes/indonesia.jpg',
    'Cross-checked event-visa consultancy sourcing (Flado.id, VisaPro-Indonesia) triangulated against official guidance not directly fetchable this session', 'https://evisa.imigrasi.go.id/', '2026-09-11'
);
SET @id8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@id8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@id8, 'Core Documents', 'Every applicant needs these.', 1);
SET @id8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@id8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@id8s1, 'Official Conference Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@id8, 'Sponsorship Documents', 'Evidence of your reason for attending.', 2);
SET @id8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@id8s2, 'Employer/Sponsor Letter of Support', NULL, 'original', 1, 0, 0, 1),
(@id8s2, 'Conference Registration Confirmation', NULL, 'copy', 1, 0, 0, 2),
(@id8s2, 'Event Organizer''s Guarantee Letter', NULL, 'original', 1, 0, 0, 3),
(@id8s2, 'Proof of Financial Means', NULL, 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(68, 8, NULL, 'IDR', 'Confirmed After Assessment', 'Agency-quoted C11 pricing reported at IDR 3,500,000 (standard) / IDR 5,000,000 (express), likely inclusive of service charges rather than a confirmed pure government fee. Contact us for a case-specific quote.', '2026-09-01', NOW(), 'https://evisa.imigrasi.go.id/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What''s the difference between C10 and C11?', 'C10 covers invited speakers, lecturers, and presenters, while C11 is for exhibitors specifically participating in exhibitions and conferences.', 68, 8, 1710, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — C8 / C8A
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    68, 9, 'IDN-SPORT-IN-09', '2026.09', 'published',
    'Athletes, coaches, referees, or trainers participating in competitions, tournaments, or training camps — strictly non-commercial and event-based.',
    'Category C8/C8A, sponsored by the event organizer or local sports body.',
    '60 days, extendable twice, 60 days each, maximum 180 days total',
    'Online e-visa via evisa.imigrasi.go.id, category C8/C8A',
    0,
    'Initial-visa processing time not clearly confirmed this session — only an extension fee figure was found, not an initial-application timeline',
    'Online portal; embassy involvement only in flagged cases',
    'Obtain an invitation letter from the event organizer/local sports body\nApply online at evisa.imigrasi.go.id, selecting C8/C8A\nUpload your federation/team affiliation documents\nPay online\nReceive your e-visa',
    '/assets/images/visa-heroes/indonesia.jpg',
    'Cross-checked event-visa consultancy sourcing (Bali Visa Advisor) triangulated against official guidance not directly fetchable this session; sports-visa approvals carry a discretionary, security-related dimension (see Al Jazeera, Oct 2025)', 'https://evisa.imigrasi.go.id/', '2026-09-11'
);
SET @id9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@id9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@id9, 'Core Documents', 'Every applicant needs these.', 1);
SET @id9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@id9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@id9s1, 'Invitation Letter from Event Organizer', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@id9, 'Federation & Financial Documents', 'Evidence of your athletic affiliation.', 2);
SET @id9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@id9s2, 'Guarantee Letter from Event/Sponsor', NULL, 'original', 1, 0, 0, 1),
(@id9s2, 'Bank Statement (Min. USD 2,000, Preceding 3 Months)', NULL, 'copy', 1, 0, 0, 2),
(@id9s2, 'Proof of Indonesian Address', NULL, 'copy', 1, 0, 0, 3),
(@id9s2, 'Sports Federation/Team Affiliation Letter', NULL, 'original', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(68, 9, NULL, 'IDR', 'Confirmed After Assessment', 'The initial C8/C8A government visa fee could not be verified this session — only an extension fee (around IDR 2,600,000) was found, which is not the same thing. Contact us for the current initial-application figure.', '2026-09-01', NOW(), 'https://evisa.imigrasi.go.id/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a Sports Visa always approved for athletes?', 'Not automatically — sports-visa approvals in Indonesia carry a discretionary, government-security dimension, as illustrated by a real October 2025 case where Israeli athletes were denied visas for a sporting event.', 68, 9, 1711, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — E31 Family Sponsored KITAS
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    68, 10, 'IDN-DEP-IN-10', '2026.09', 'published',
    'Spouse and children (under 18) joining a primary visa/KITAS holder (worker, investor, retiree, digital nomad, or Second Home Visa holder) for extended residence.',
    'Category E31 series (e.g. E31A for spouse of an Indonesian citizen; broader E31 for dependents of a foreign KITAS/KITAP holder). Sponsor is either the Indonesian citizen spouse or the foreign primary KITAS/KITAP holder; dependents must be spouse or children under 17-18.',
    'Tied to the sponsor''s KITAS validity (commonly 1-2 years), renewable',
    'First obtain a single-entry visa/Telex Vitas to enter Indonesia, then convert it to a Dependent KITAS after arrival at the local immigration office',
    1,
    'Reported at roughly 3-5 weeks',
    'Indonesian Embassy, New Delhi, or relevant honorary consulate, for the initial Telex Vitas',
    'Confirm your sponsor''s eligible status (Indonesian citizen spouse or foreign KITAS/KITAP holder)\nObtain a Telex Vitas to enter Indonesia\nTravel to Indonesia\nConvert to a Dependent KITAS at the local immigration office\nRenew alongside your sponsor''s status',
    '/assets/images/visa-heroes/indonesia.jpg',
    'Cross-checked immigration-consultancy sourcing (Cekindo/InCorp, XPND) triangulated against official guidance not directly fetchable this session', 'https://www.imigrasi.go.id/', '2026-09-11'
);
SET @id10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@id10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@id10, 'Core Documents', 'Every dependent needs these.', 1);
SET @id10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@id10s1, 'Dependent''s Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@id10s1, 'Marriage or Birth Certificate Proving the Relationship', NULL, 'original', 1, 0, 1, 2),
(@id10s1, 'Sponsor''s KITAS/ID Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@id10, 'Sponsor & Financial Documents', 'Evidence of your sponsor''s ability to support you.', 2);
SET @id10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@id10s2, 'Sponsor''s Stamped Guarantee/Sponsorship Letter', 'Affixed with an IDR 10,000 revenue stamp.', 'original', 1, 0, 0, 1),
(@id10s2, 'Indonesian Spouse''s Family Card (Kartu Keluarga)', 'Where applicable.', 'copy', 0, 1, 0, 2),
(@id10s2, 'Sponsor''s Bank Statement (Min. IDR 20 Million)', NULL, 'copy', 1, 0, 0, 3),
(@id10s2, 'Foreign Marriage Certificate, Apostilled & Translated', 'Required for marriages conducted outside Indonesia — by a sworn Indonesian translator.', 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(68, 10, NULL, 'IDR', 'Confirmed After Assessment', 'Initial processing fee reported IDR 2,000,000-3,000,000 (roughly USD 130-200); total all-in cost including agency handling reported as high as IDR 10-20 million — genuinely variable by sponsor type. Contact us for a case-specific quote.', '2026-09-01', NOW(), 'https://www.imigrasi.go.id/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does a foreign marriage certificate need special processing for this visa?', 'Yes — if your marriage was conducted outside Indonesia, the certificate must be apostilled and translated by a sworn Indonesian translator before it will be accepted.', 68, 10, 1712, 1);
