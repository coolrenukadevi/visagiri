-- Portugal Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search, same standard as every other
-- country built this session (see AUDIT.md). hero_image_url points at
-- the real Lisbon Belém Tower photo supplied by the client for this
-- hero.
--
-- IMPORTANT SOURCING CAVEAT: official primary sources (vistos.mne.
-- gov.pt, visa.vfsglobal.com, the Portuguese Embassy's mne.gov.pt
-- subdomains) were not directly fetchable in this session's research
-- pass (blocked at the network egress layer) — findings were
-- triangulated from web-search-indexed content, several of which
-- returned direct excerpts of official VFS checklist PDFs and
-- vistos.mne.gov.pt text, cross-checked against immigration-law
-- sourcing (Fragomen, Global Citizen Solutions, Jobbatical). Fee
-- figures for the D-type national visas conflicted between sources
-- (EUR 90 vs EUR 110) and are marked accordingly.
--
-- Portugal's real, distinctive facts:
--   - Portugal is closing two major, historically Indian-favoured
--     entry pathways within the same few months: the standalone
--     "job-seeker visa" was abolished on 23 October 2025 (all pending
--     appointments cancelled outright), and the informal "manifestação
--     de interesse" route that let people regularize into work status
--     after entering on a tourist visa was permanently terminated
--     (deadline 31 December 2025) under Law 61/2025.
--   - AIMA, which replaced SEF as Portugal's immigration agency in
--     2023, is a live, acknowledged operational bottleneck — claims
--     93%+ backlog resolution by 2026, but independent reporting still
--     describes delays beyond the legal 90-120 working day window for
--     complex cases, stated honestly here as an uncertain, separate
--     timeline after the D-visa stage rather than assumed resolved.
--   - Portugal runs a genuinely separate three-track family-migration
--     system: a short-stay Family/Friend Visit visa, a DF visa for
--     dependents filing simultaneously with a primary D-visa holder
--     (no separate VFS appointment needed), and D6 Family
--     Reunification for joining an already-settled resident, now
--     gated behind a new 2-year minimum sponsor-residency requirement.
--   - Portugal's own VFS documentation explicitly merges Business and
--     Conference into a single checklist, and no dedicated Portugal-
--     specific Sports visa checklist was found — sports travel appears
--     to fall under a general Schengen "other purposes" umbrella,
--     stated honestly here rather than inventing a distinct process.
--   - The Golden Visa survived but no longer accepts any residential
--     or commercial property purchase at all (since October 2023) —
--     it now runs almost exclusively through EUR 500,000+ fund
--     subscriptions, job-creation, or donation routes.
--
-- country_id 140 = Portugal. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Schengen Type C, Tourism
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    140, 1, 'PRT-TOUR-IN-01', '2026.09', 'published',
    'Short-term leisure and sightseeing travel to Portugal and the wider Schengen area.',
    'Any Indian passport holder; no nationality-specific carve-outs beyond standard Schengen financial/insurance/return-intent proof. Reported Indian rejection rate around 16.2%, mainly attributed to insufficient bank balance or missing documents.',
    'Up to 90 days in any 180-day period; no extension in the ordinary sense — a new application is needed for further stays',
    'Mandatory outsourced intake via VFS Global Visa Application Centres in India',
    1,
    'Roughly 10-15 working days typical; can extend to 30-45 days in individual cases',
    'Embassy of Portugal, New Delhi (all India except Goa/Maharashtra/UTs) or Consulate-General of Portugal in Goa (Goa, Maharashtra, Daman & Diu, Dadra & Nagar Haveli)',
    'Book a VFS Global appointment\nComplete the Schengen application form\nSubmit documents and biometrics at VFS\nWait for the consulate to adjudicate your application\nCollect your passport/visa',
    '/assets/images/visa-heroes/portugal.jpg',
    'Cross-checked VFS Global checklist excerpts and vistos.mne.gov.pt guidance (via search snippet) not directly fetchable this session', 'https://vistos.mne.gov.pt/', '2026-09-11'
);
SET @pt1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pt1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pt1, 'Core Documents', 'Every traveller needs these.', 1);
SET @pt1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pt1s1, 'Valid Passport', 'Valid 3+ months beyond intended stay, 2 blank pages.', 'original', 1, 0, 1, 1),
(@pt1s1, 'Schengen Application Form', NULL, 'original', 1, 0, 1, 2),
(@pt1s1, 'Photograph', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pt1, 'Travel Documents', 'Confirming your trip plan.', 2);
SET @pt1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pt1s2, 'Confirmed Round-Trip Flight Itinerary', NULL, 'copy', 1, 0, 1, 1),
(@pt1s2, 'Hotel/Accommodation Booking', NULL, 'copy', 1, 0, 1, 2),
(@pt1s2, 'Travel Medical Insurance (Min. EUR 30,000, Schengen-Wide)', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pt1, 'Financial Documents', 'Evidence of funds and ties to India.', 3);
SET @pt1s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pt1s3, 'Bank Statements (3-6 Months, Branch-Attested)', NULL, 'copy', 1, 0, 0, 1),
(@pt1s3, 'ITR (2 Years)/Form 16', NULL, 'copy', 1, 0, 0, 2),
(@pt1s3, 'Employer NOC/Leave-Sanction Letter', NULL, 'original', 1, 0, 0, 3),
(@pt1s3, 'Day-Wise Trip Itinerary', NULL, 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(140, 1, 90.00, 'EUR', 'Adult Schengen Visa Fee', 'EUR 45 for children 6-11, free under 6 — official EU-wide fee since 11 June 2024. A separate VFS service fee applies on top; exact current INR amount not independently verified this session.', '2026-09-01', NOW(), 'https://vistos.mne.gov.pt/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Which Portuguese office handles my application?', 'It depends on your residence: the Embassy of Portugal, New Delhi, covers all of India except Goa, Maharashtra, and the Union Territories, which are covered by the Consulate-General of Portugal in Goa.', 140, 1, 1600, 1),
('Can I extend my Portugal tourist visa?', 'Not in the ordinary sense — Schengen short-stay visas do not have a standard extension process; a new application is needed for further stays, except for exceptional force-majeure reasons.', 140, 1, 1601, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Schengen Type C, officially combined with Conference
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    140, 2, 'PRT-BUS-IN-02', '2026.09', 'published',
    'Business meetings, negotiations, trade fairs, site visits, and training.',
    'Same general Schengen conditions as Tourist; the sponsoring/host company''s documentation is the differentiator. Portugal''s own VFS documentation explicitly combines Business and Conference into one checklist.',
    'Up to 90 days in any 180-day period',
    'VFS Global Visa Application Centres, same as Tourist',
    1,
    'Embassy states a minimum of 15 calendar days once the file reaches it',
    'Embassy of Portugal, New Delhi, or Consulate-General of Portugal in Goa, per jurisdiction',
    'Secure an invitation letter from your Portuguese host company\nBook a VFS appointment\nSubmit documents and biometrics\nWait for the consulate to adjudicate\nCollect your passport/visa',
    '/assets/images/visa-heroes/portugal.jpg',
    'Cross-checked VFS Global "Checklist for Schengen Visa (Business and Conference)" excerpt not directly fetchable this session', 'https://vistos.mne.gov.pt/', '2026-09-11'
);
SET @pt2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pt2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pt2, 'Core Documents', 'Every applicant needs these.', 1);
SET @pt2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pt2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@pt2s1, 'Travel Medical Insurance (Min. EUR 30,000)', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pt2, 'Business Sponsorship Documents', 'Evidence of your Portuguese host.', 2);
SET @pt2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pt2s2, 'Invitation Letter from Portuguese Host Company', 'Must state meeting schedule, venue, and contact names/phone/email.', 'original', 1, 0, 0, 1),
(@pt2s2, 'Covering Letter from Indian Employer', 'Stating designation, purpose, and itinerary.', 'original', 1, 0, 0, 2),
(@pt2s2, 'ITR (2 Years) + Form 16', NULL, 'copy', 1, 0, 0, 3),
(@pt2s2, 'Bank Statements (3-6 Months, Attested)', NULL, 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(140, 2, 90.00, 'EUR', 'Adult Schengen Visa Fee', 'Same fee schedule as Tourist.', '2026-09-01', NOW(), 'https://vistos.mne.gov.pt/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate visa for attending a conference in Portugal?', 'No — Portugal''s own VFS documentation explicitly combines Business and Conference into a single checklist and application process.', 140, 2, 1602, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — D4 Residence Visa for Studies
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    140, 3, 'PRT-STU-IN-03', '2026.09', 'published',
    'Enrolment in higher education, research programmes (1+ year), or internships/volunteering in Portugal.',
    'Requires confirmed admission/enrolment at a recognized Portuguese institution and proof of means of subsistence (2026 benchmark reported around EUR 920/month, roughly EUR 11,040/year).',
    'D4 entry visa is short-validity (around 4 months, 2 entries); the actual residence permit, matching course length, is issued by AIMA after arrival',
    'VFS Global document submission; a consular interview may be required at the Embassy of Portugal, New Delhi',
    1,
    'Consular decision typically 30-90 days, plus a separate, uncertain 2-5 months for the AIMA residence permit after physical arrival',
    'Embassy of Portugal, New Delhi, or Consulate-General of Portugal in Goa',
    'Secure your admission/enrolment letter\nApply via VFS with the D4 checklist\nAttend an interview if required\nReceive your consular visa\nTravel to Portugal\nRegister with AIMA for your residence permit card',
    '/assets/images/visa-heroes/portugal.jpg',
    'Cross-checked VFS Global D4 checklist excerpt and education-consultancy sourcing not directly fetchable this session', 'https://vistos.mne.gov.pt/', '2026-09-11'
);
SET @pt3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pt3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pt3, 'Core Documents', 'Every applicant needs these.', 1);
SET @pt3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pt3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@pt3s1, 'Admission/Enrolment Letter', NULL, 'original', 1, 0, 1, 2),
(@pt3s1, 'Proof of Accommodation in Portugal', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pt3, 'Academic & Financial Documents', 'Verifying your study plan and means.', 2);
SET @pt3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pt3s2, 'Proof of Means of Subsistence (3 Months'' Bank Statements)', 'Benchmark roughly EUR 920/month.', 'copy', 1, 0, 0, 1),
(@pt3s2, 'Academic Transcripts/Qualification Certificates', NULL, 'copy', 1, 0, 0, 2),
(@pt3s2, 'Scholarship Letter', 'If applicable.', 'original', 0, 1, 0, 3),
(@pt3s2, 'Criminal Record Certificate', NULL, 'original', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(140, 3, NULL, 'EUR', 'Confirmed After Assessment', 'Sources conflict between EUR 90 and a reported rise to EUR 110 in early 2025 — could not confirm against a primary Portuguese government fee page this session. Contact us for the current figure.', '2026-09-01', NOW(), 'https://vistos.mne.gov.pt/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does my student visa cover my whole course automatically?', 'The D4 is only the entry visa. After arrival, you must register with AIMA for the actual residence permit, which matches your course length and is renewable — this AIMA stage carries its own separate, sometimes lengthy timeline.', 140, 3, 1603, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — D1 Subordinate/Employed Work
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    140, 4, 'PRT-WORK-IN-04', '2026.09', 'published',
    'Salaried employment under a Portuguese employer''s contract (D1). Related but distinct tracks: D2 for entrepreneurs/self-employed, D3 for highly qualified professionals/researchers.',
    'Requires a signed employment contract (wage at or above the Portuguese minimum wage, specified duties/hours/start date at least 15 days after application, employer signature notarised). Portugal''s standalone "job-seeker visa" was abolished on 23 October 2025; its replacement "Skilled Job Seeker Visa" was still not operational at consular posts as of this research.',
    'Entry visa validity around 4 months/2 entries; residence permit (1-2 years, renewable) issued by AIMA after arrival',
    'VFS Global submission, consulate adjudication',
    1,
    'Reported around 60 calendar days for D1 (per VFS-sourced checklist text)',
    'Embassy of Portugal, New Delhi, or Consulate-General of Portugal in Goa',
    'Secure a signed employment contract from a Portuguese employer\nApply via VFS with the D1 checklist\nWait for the consular decision\nTravel to Portugal\nRegister with AIMA for your residence permit',
    '/assets/images/visa-heroes/portugal.jpg',
    'Cross-checked VFS Global D1 checklist excerpt and immigration-law sourcing (Anchorless.io, Total.law) not directly fetchable this session', 'https://vistos.mne.gov.pt/', '2026-09-11'
);
SET @pt4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pt4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pt4, 'Core Documents', 'Every applicant needs these.', 1);
SET @pt4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pt4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@pt4s1, 'Signed Employment Contract', NULL, 'original', 1, 0, 1, 2),
(@pt4s1, 'Proof of Accommodation in Portugal', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pt4, 'Employer & Qualification Documents', 'Evidence of your employer and background.', 2);
SET @pt4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pt4s2, 'Employer''s Notarised Signature Certification', NULL, 'original', 1, 0, 0, 1),
(@pt4s2, 'Proof of Employer''s Registration/Tax Status in Portugal', NULL, 'copy', 1, 0, 0, 2),
(@pt4s2, 'Qualification Certificates', 'Required for the D3 highly-qualified track.', 'copy', 0, 1, 0, 3),
(@pt4s2, 'Criminal Record Certificate (India + Any Other Country Resided In Last Year)', NULL, 'original', 1, 0, 0, 4),
(@pt4s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 5);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(140, 4, NULL, 'EUR', 'Confirmed After Assessment', 'One VFS-derived source reports EUR 90; another reports a rise to EUR 110 — this is a genuine conflict not resolved this session. Contact us for the current figure.', '2026-09-01', NOW(), 'https://vistos.mne.gov.pt/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I come to Portugal to look for a job first?', 'Not currently — Portugal''s standalone job-seeker visa was abolished on 23 October 2025, and its planned "Skilled Job Seeker Visa" replacement was still not operational at consular posts as of this research. You need a confirmed job offer to apply for D1/D2/D3.', 140, 4, 1604, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Schengen Type C, Visiting Family/Friends
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    140, 5, 'PRT-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives or friends resident in Portugal (citizens or legal residents).',
    'Standard Schengen conditions plus a qualifying invitation from the host. In-person application only — mail applications are explicitly not accepted.',
    'Up to 90 days in any 180-day period',
    'VFS Global Visa Application Centres',
    1,
    'Roughly 10-15 working days, standard Schengen timeline',
    'Embassy of Portugal, New Delhi, or Consulate-General of Portugal in Goa',
    'Obtain your host''s invitation letter\nBook a VFS appointment\nSubmit documents and biometrics\nWait for the consular decision\nCollect your passport/visa',
    '/assets/images/visa-heroes/portugal.jpg',
    'Cross-checked VFS Global "Checklist for Schengen Visa (Family/Friend Visit)" excerpts not directly fetchable this session', 'https://vistos.mne.gov.pt/', '2026-09-11'
);
SET @pt5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pt5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pt5, 'Core Documents', 'Every traveller needs these.', 1);
SET @pt5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pt5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@pt5s1, 'Travel Medical Insurance', NULL, 'copy', 1, 0, 1, 2),
(@pt5s1, 'Return Flight Booking', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pt5, 'Host Invitation Documents', 'Evidence of your Portugal-based host.', 2);
SET @pt5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pt5s2, 'Invitation Letter from Portugal-Based Host', 'Must state all invitees'' names, stay duration, purpose, and relationship.', 'original', 1, 0, 0, 1),
(@pt5s2, 'Copy of Host''s ID/Passport and Residence Permit (If Not a Portuguese Citizen)', NULL, 'copy', 1, 0, 0, 2),
(@pt5s2, 'Proof of Applicant''s Own Funds/Ties to India', NULL, 'copy', 1, 0, 0, 3),
(@pt5s2, 'Notarized No-Objection Certificate from Non-Travelling Parent', 'For minors.', 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(140, 5, 90.00, 'EUR', 'Adult Schengen Visa Fee', 'Standard Schengen fee schedule.', '2026-09-01', NOW(), 'https://vistos.mne.gov.pt/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I submit my Family Visit application by post?', 'No — Portugal requires in-person submission at VFS Global; mail applications are explicitly not accepted.', 140, 5, 1605, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Schengen Type A, Airport Transit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    140, 6, 'PRT-TRANS-IN-06', '2026.09', 'published',
    'Transiting through the international zone of a Schengen (including Portuguese) airport without entering Schengen territory.',
    'Indian passport holders are NOT on the EU''s common Annex list of nationalities requiring an Airport Transit Visa, nor on Portugal''s own supplementary national list (which adds only Guinea, Senegal, and Uzbekistan). Most Indian travellers connecting through a Schengen/Portuguese airport do not need any transit visa at all, provided they remain airside.',
    'No defined stay for pure airside transit; a full visa''s standard duration applies if actually entering Schengen territory',
    'Not applicable for most Indian transits; standard Schengen visa process applies only if leaving the transit zone for another purpose',
    0,
    'Not applicable for exempt Indian transits',
    'Not applicable for exempt transits; Embassy of Portugal New Delhi/Consulate Goa otherwise',
    'Confirm your connection remains airside within the international transit zone\nIf so, no transit visa is required\nIf you need to actually enter Schengen territory during your layover, apply for the relevant Schengen visa instead',
    '/assets/images/visa-heroes/portugal.jpg',
    'Cross-checked schengenvisainfo.com Airport Transit guidance and comparative Spain/Germany MFA pages, triangulated against Portugal-specific reporting not directly fetchable this session', 'https://vistos.mne.gov.pt/', '2026-09-11'
);
SET @pt6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pt6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pt6, 'Core Documents', 'Every traveller needs these.', 1);
SET @pt6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pt6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@pt6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pt6, 'If a Full Visa Is Needed', 'Only relevant if leaving the transit zone.', 2);
SET @pt6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pt6s2, 'Visa for Final Destination (If Required There)', NULL, 'copy', 0, 1, 0, 1),
(@pt6s2, 'Standard Schengen Documents', 'If entering Schengen territory rather than remaining airside.', 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(140, 6, 0.00, 'EUR', 'No Fee for Exempt Indian Transits', 'Most Indian travellers remaining airside need no visa at all. The standard EUR 90 Schengen fee applies only if a full visa is required for another purpose.', '2026-09-01', NOW(), 'https://vistos.mne.gov.pt/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian travellers need an Airport Transit Visa for Portugal?', 'No — India is not on the EU''s common list or Portugal''s own supplementary list of nationalities requiring an Airport Transit Visa. Most Indian travellers connecting through a Portuguese airport need nothing at all, as long as they stay airside.', 140, 6, 1606, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Schengen Type C, Medical Treatment
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    140, 7, 'PRT-MED-IN-07', '2026.09', 'published',
    'Short-term travel for medical treatment in Portugal.',
    'Must show a confirmed treatment plan at a Portuguese medical institution. Treatment exceeding 90 days requires a long-term/national medical visa instead.',
    'Up to 90 days (short-stay)',
    'VFS Global Visa Application Centres',
    1,
    'Reported roughly 15-30 working days, somewhat longer than Tourist, likely due to medical-document verification',
    'Embassy of Portugal, New Delhi, or Consulate-General of Portugal in Goa',
    'Obtain a hospital appointment confirmation letter\nBook a VFS appointment\nSubmit documents and medical evidence\nWait for the consular decision\nCollect your passport/visa',
    '/assets/images/visa-heroes/portugal.jpg',
    'Cross-checked VFS Global medical-treatment/travel-health-declaration excerpts not directly fetchable this session', 'https://vistos.mne.gov.pt/', '2026-09-11'
);
SET @pt7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pt7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pt7, 'Core Documents', 'Every applicant needs these.', 1);
SET @pt7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pt7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@pt7s1, 'Travel Insurance Covering Medical Evacuation', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pt7, 'Medical Documents', 'Evidence of your treatment plan.', 2);
SET @pt7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pt7s2, 'Official Letter from Portuguese Medical Institution Confirming Treatment Appointment', NULL, 'original', 1, 0, 0, 1),
(@pt7s2, 'Proof of Sufficient Funds to Cover Treatment', NULL, 'copy', 1, 0, 0, 2),
(@pt7s2, 'Medical Records/Referral from Indian Physician', NULL, 'copy', 1, 0, 0, 3),
(@pt7s2, 'Proof of Payment/Deposit for Treatment', 'Where applicable.', 'copy', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(140, 7, 90.00, 'EUR', 'Adult Schengen Visa Fee', 'Standard Schengen fee schedule.', '2026-09-01', NOW(), 'https://vistos.mne.gov.pt/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What if my treatment needs more than 90 days?', 'A short-stay Medical Visa only covers up to 90 days. Treatment expected to take longer requires a long-term/national medical visa instead.', 140, 7, 1607, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Officially merged with Business
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    140, 8, 'PRT-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, seminars, workshops, and trade events in Portugal.',
    'Portugal''s own VFS documentation explicitly combines Business and Conference into a single checklist ("Checklist for Schengen Visa: Business and Conference") — functionally identical to the Business visa.',
    'Up to 90 days in any 180-day period',
    'VFS Global Visa Application Centres',
    1,
    'Roughly 15 working days minimum, same as Business',
    'Embassy of Portugal, New Delhi, or Consulate-General of Portugal in Goa',
    'Register for the conference and obtain an organizer''s invitation/registration confirmation\nBook a VFS appointment\nSubmit documents and biometrics\nWait for the consular decision\nCollect your passport/visa',
    '/assets/images/visa-heroes/portugal.jpg',
    'Cross-checked VFS Global combined Business/Conference checklist excerpts not directly fetchable this session', 'https://vistos.mne.gov.pt/', '2026-09-11'
);
SET @pt8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pt8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pt8, 'Core Documents', 'Every applicant needs these.', 1);
SET @pt8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pt8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@pt8s1, 'Flight/Hotel Bookings', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pt8, 'Event Documents', 'Evidence of your reason for attending.', 2);
SET @pt8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pt8s2, 'Conference Organizer''s Invitation/Registration Confirmation', 'Venue, dates, and programme schedule.', 'original', 1, 0, 0, 1),
(@pt8s2, 'Event Entry Ticket/Registration Proof', NULL, 'copy', 1, 0, 0, 2),
(@pt8s2, 'Employer NOC + Covering Letter', NULL, 'original', 1, 0, 0, 3),
(@pt8s2, 'Bank Statements/ITR', NULL, 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(140, 8, 90.00, 'EUR', 'Adult Schengen Visa Fee', 'Same fee schedule as Business — Portugal does not price Conference separately.', '2026-09-01', NOW(), 'https://vistos.mne.gov.pt/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a Conference Visa a separate product from a Business Visa in Portugal?', 'No — Portugal''s own checklist documentation treats Business and Conference as one combined application, with the same document requirements and fee.', 140, 8, 1608, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — General Schengen "other purposes"
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    140, 9, 'PRT-SPORT-IN-09', '2026.09', 'published',
    'Participation in sporting events/tournaments in Portugal.',
    'No Portugal-specific, dedicated "Sports Visa" checklist PDF was found this session — sports travel appears to be handled under Portugal''s general Schengen "other purposes" umbrella (which also covers cultural, religious, and film-related travel), using the core Schengen checklist plus purpose-specific letters. Stated honestly here rather than assuming an identical dedicated process to other Schengen states.',
    'Up to 90 days in any 180-day period, depending on event length',
    'VFS Global, same general "other purpose" Schengen track',
    1,
    'Standard Schengen timeline of roughly 15 working days, not separately confirmed for Portugal specifically',
    'Embassy of Portugal, New Delhi, or Consulate-General of Portugal in Goa',
    'Obtain a letter from your sports association/federation and from the event organizer\nBook a VFS appointment\nSubmit documents and biometrics\nWait for the consular decision\nCollect your passport/visa',
    '/assets/images/visa-heroes/portugal.jpg',
    'Cross-checked generic Schengen sports-visa guidance not Portugal-VFS-specific — flagged accordingly and not directly fetchable this session', 'https://vistos.mne.gov.pt/', '2026-09-11'
);
SET @pt9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pt9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pt9, 'Core Documents', 'Every applicant needs these.', 1);
SET @pt9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pt9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@pt9s1, 'Flight/Hotel Bookings', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pt9, 'Event & Federation Documents', 'Evidence of your athletic affiliation.', 2);
SET @pt9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pt9s2, 'Letter from Sports Association/Federation', 'Role, tenure, compensation terms, confirmation no local employment will be sought.', 'original', 1, 0, 0, 1),
(@pt9s2, 'Letter from Event Organizers', 'Host details, itinerary, expense arrangements.', 'original', 1, 0, 0, 2),
(@pt9s2, 'Event Entry/Enrolment Confirmation', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(140, 9, 90.00, 'EUR', 'Adult Schengen Visa Fee (Generic)', 'Portugal-specific confirmation not found this session — treated as the standard Schengen fee pending direct verification.', '2026-09-01', NOW(), 'https://vistos.mne.gov.pt/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Sports Visa checklist for Portugal?', 'No dedicated Portugal-specific Sports Visa checklist was found — sports travel is handled under the general Schengen "other purposes" documentation, alongside cultural, religious, and film-related travel.', 140, 9, 1609, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — DF, Accompanying Family Members
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    140, 10, 'PRT-DEP-IN-10', '2026.09', 'published',
    'Spouse/registered partner and dependent minor children accompanying a main D-visa applicant from the outset — distinct from Family Reunification (D6), for joining an already-settled resident.',
    'Dependents apply at the same time as the main applicant''s D-visa, submitting on the same VFS appointment date, with no separate slot needed. Not available with visa categories excluded by rule.',
    'Tied to the main applicant''s visa/residence-permit timeline',
    'VFS Global, filed jointly with the main applicant''s D-visa appointment',
    1,
    'Reported at a standard 60 days, "may be prolonged if necessary" per VFS-sourced text',
    'Same as the main applicant — Embassy of Portugal, New Delhi, or Consulate-General of Portugal in Goa',
    'Main applicant books their VFS slot for their D-visa\nAll dependents submit their applications the same day\nAdjudication proceeds jointly or in parallel\nTravel together, or dependents follow shortly after',
    '/assets/images/visa-heroes/portugal.jpg',
    'Cross-checked VFS Global "DF Checklist" excerpt (Goa consulate version) not directly fetchable this session', 'https://vistos.mne.gov.pt/', '2026-09-11'
);
SET @pt10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pt10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pt10, 'Core Documents', 'Every dependent needs these.', 1);
SET @pt10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pt10s1, 'Dependent''s Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@pt10s1, 'Proof of Relationship', 'Marriage certificate for spouse, birth certificate for children.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pt10, 'Sponsor Documents', 'Evidence of the main applicant''s ability to support you.', 2);
SET @pt10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pt10s2, 'Main Applicant''s Approved/Pending D-Visa Proof', NULL, 'copy', 1, 0, 0, 1),
(@pt10s2, 'Proof of Main Applicant''s Sufficient Income', 'Per-dependent thresholds reported around 30-50% of base income.', 'copy', 1, 0, 0, 2),
(@pt10s2, 'Proof of Adequate Housing in Portugal', NULL, 'copy', 1, 0, 0, 3),
(@pt10s2, 'Criminal Record Certificates for Adult Dependents', NULL, 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(140, 10, NULL, 'EUR', 'Confirmed After Assessment', 'Reported similarly to other D-visas (EUR 90-110 range per applicant) but not independently confirmed on a primary source this session — contact us to confirm.', '2026-09-01', NOW(), 'https://vistos.mne.gov.pt/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How is a Dependent (DF) visa different from Family Reunification (D6)?', 'DF is for family members accompanying a main D-visa applicant from the outset, filed simultaneously on the same VFS appointment. D6 Family Reunification is for joining a sponsor who is already settled in Portugal, and now requires the sponsor to have at least 2 years of residency first.', 140, 10, 1610, 1);
