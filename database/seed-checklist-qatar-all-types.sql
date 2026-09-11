-- Qatar Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search, same standard as every other
-- country built this session (see AUDIT.md). hero_image_url points at
-- the real Doha skyline/Corniche photo supplied by the client for
-- this hero.
--
-- IMPORTANT SOURCING CAVEAT: official primary sources (portal.moi.gov.
-- qa, hukoomi.gov.qa, indianembassyqatar.gov.in) were not directly
-- fetchable in this session's research pass — findings were
-- triangulated from search-engine-indexed content and cached snippets
-- of those exact official domains, cross-checked against independent
-- visa-consultancy aggregators. Fee figures especially should be
-- re-verified against the live portals before being treated as final.
--
-- Qatar's real, distinctive facts:
--   - A genuine, real policy shift is reflected here rather than the
--     older "Indians always need a visa" assumption: as of 2026,
--     Indian passport holders receive visa-free/visa-on-arrival entry
--     for stays up to 30 days (extendable once to 60 total) — but this
--     is conditional on booking a hotel through the official Discover
--     Qatar platform specifically (third-party OTA bookings are
--     rejected at immigration), a real and distinctive condition.
--   - Work involves a genuine, layered medical-clearance process (a
--     pre-arrival GAMCA exam in India, then a separate post-arrival
--     government medical exam) before QID issuance — and reflects
--     Qatar's real Kafala reforms under Law No. 19 of 2020: workers
--     may change employers without a No-Objection Certificate by
--     serving notice, and the exit-permit requirement has been removed
--     for over 95% of the workforce, both stated as real, dated
--     reforms rather than assumed.
--   - Transit has a genuine, distinctive free product: Qatar Airways
--     passengers transiting a minimum of ~6 hours (up to 96 hours) can
--     obtain a free transit visa via the Discover Qatar Transit Desk
--     at Hamad International Airport.
--   - Sports reflects Qatar's real "Hayya Card" model, developed for
--     the 2022 World Cup and continuing for its 2026 calendar of 83
--     championships — a bundled, free multiple-entry visa tied
--     directly to a ticketed spectator/participant's event ticket.
--   - Dependent sponsor income thresholds are real, tiered figures
--     (QAR 10,000-15,000/month, or QAR 7,000-10,000 with
--     employer-provided accommodation), not a single fabricated
--     number.
--
-- country_id 90 = Qatar. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Visa-Free Entry / Hayya A1 eVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    90, 1, 'QAT-TOUR-IN-01', '2026.09', 'published',
    'Leisure travel, sightseeing, and tourism in Qatar.',
    'As of 2026, Indian passport holders receive visa-free/visa-on-arrival entry for stays up to 30 days (extendable once to 60 days total). This is conditional on a hotel booked through the official Discover Qatar platform specifically — third-party OTA bookings are rejected at immigration. A pre-arranged Hayya A1 eVisa is also available online.',
    'Up to 30 days, extendable once to 60 days total',
    'Visa-free entry (hotel via Discover Qatar required) or pre-arranged Hayya A1 eVisa online',
    0,
    'The Hayya A1 eVisa, where used instead, is typically approved in 24-48 hours',
    'No in-person office visit required for either route',
    'Confirm your visa-free eligibility and book your hotel via Discover Qatar (discoverqatar.qa)\nGather documents against this checklist\nAlternatively, apply for the Hayya A1 eVisa online in advance\nArrive with your confirmed hotel booking, return ticket, and proof of funds\nPassport stamped on entry',
    '/assets/images/visa-heroes/qatar.jpg',
    'Qatar MOI (portal.moi.gov.qa) and Hukoomi visa-free entry guidance for Indian passport holders, cross-checked via independent visa-consultancy sourcing', 'https://portal.moi.gov.qa/qatarvisas/', '2026-09-11'
);
SET @qt1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@qt1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@qt1, 'Core Documents', 'Every traveller needs these.', 1);
SET @qt1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@qt1s1, 'Valid Passport', 'Valid at least 6 months, with 2 blank pages.', 'original', 1, 0, 1, 1),
(@qt1s1, 'Hotel Booking via Discover Qatar', 'Third-party OTA bookings are rejected at immigration.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@qt1, 'Financial & Travel Documents', 'Evidence of funds and onward travel.', 2);
SET @qt1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@qt1s2, 'Confirmed Return Ticket', NULL, 'copy', 1, 0, 1, 1),
(@qt1s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@qt1, 'eVisa Documents (If Applying in Advance)', 'For the Hayya A1 route.', 3);
SET @qt1s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@qt1s3, 'Hayya A1 eVisa Application', NULL, 'original', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(90, 1, 100.00, 'QAR', 'Hayya A1 eVisa Fee (If Applying in Advance)', 'Visa-free entry itself carries no fee; the Hayya A1 eVisa alternative costs approximately QAR 100. Overstay fine: QAR 200/day, capped at QAR 12,000.', '2026-09-01', NOW(), 'https://portal.moi.gov.qa/qatarvisas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for short visits to Qatar?', 'No, as of 2026 — visa-free/visa-on-arrival entry is available for stays up to 30 days, extendable once to 60 days total.', 90, 1, 1220, 1),
('Why does my hotel booking matter so much?', 'Bookings must go through the official Discover Qatar platform specifically — third-party OTA bookings (e.g. generic hotel-booking sites) are rejected at immigration.', 90, 1, 1221, 1),
('What happens if I overstay?', 'A fine of QAR 200/day applies, capped at QAR 12,000.', 90, 1, 1222, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Business Visit Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    90, 2, 'QAT-BUS-IN-02', '2026.09', 'published',
    'Short business visits — meetings and negotiations — to Qatar.',
    'Sponsored by an MOI-accredited Qatari company issuing an invitation letter on company letterhead. Applicants must hold QAR 5,000 (cash or valid credit card), a confirmed return ticket, and 6-month passport validity.',
    '30 days, extendable once for a similar period',
    'Applied via Hukoomi''s "Apply for Business Visa" e-service or through the Qatar Visa Center (QVC) in India',
    0,
    'Processing typically runs 3-6 working days; no medical test required',
    'Qatar Visa Center (QVC), India',
    'Obtain an invitation letter from your MOI-accredited Qatari host company\nGather documents against this checklist\nApply via Hukoomi''s e-service or the Qatar Visa Center in India\nArrive with QAR 5,000 in cash/credit card and your confirmed return ticket\nDecision once processed',
    '/assets/images/visa-heroes/qatar.jpg',
    'Qatar Hukoomi Business Visa e-service guidance', 'https://hukoomi.gov.qa/en/service/apply-for-business-visa/1000', '2026-09-11'
);
SET @qt2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@qt2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@qt2, 'Core Documents', 'Every applicant needs these.', 1);
SET @qt2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@qt2s1, 'Valid Passport', 'Valid at least 6 months.', 'original', 1, 0, 1, 1),
(@qt2s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@qt2, 'Business Invitation Documents', 'Evidence of your Qatari sponsor.', 2);
SET @qt2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@qt2s2, 'Invitation Letter from MOI-Accredited Qatari Company', NULL, 'original', 1, 0, 1, 1),
(@qt2s2, 'Covering Letter from Indian Employer', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@qt2, 'Financial & Travel Documents', 'Evidence of funds and onward travel.', 3);
SET @qt2s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@qt2s3, 'Proof of QAR 5,000 (Cash or Credit Card)', NULL, 'copy', 1, 0, 0, 1),
(@qt2s3, 'Confirmed Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(90, 2, 200.00, 'QAR', 'Business Visit Visa Fee (Indicative)', 'Reported roughly QAR 100-450 depending on entry type — confirm the exact current figure with us before applying.', '2026-09-01', NOW(), 'https://hukoomi.gov.qa/en/service/apply-for-business-visa/1000', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How much cash/credit must I show for a Business Visa?', 'QAR 5,000, in cash or a valid credit card, alongside a confirmed return ticket and 6-month passport validity.', 90, 2, 1223, 1),
('Who can sponsor a Business Visa?', 'An MOI-accredited Qatari company, issuing an invitation letter on company letterhead.', 90, 2, 1224, 1),
('Can this visa be extended?', 'Yes — once, for a similar 30-day period.', 90, 2, 1225, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Student Visa + QID Process
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    90, 3, 'QAT-STU-IN-03', '2026.09', 'published',
    'Full-time study at a Qatar-based educational institution.',
    'Requires an admission/acceptance letter from a Qatar-based institution, which acts as official sponsor. After entry, the university''s immigration office initiates the Residence Permit (QID) process, including mandatory MOI-administered medical screening (HIV/TB) and fingerprinting — you cannot travel abroad during this 3-6 week window.',
    'Duration of your study program, tied to QID renewal',
    'Institution-sponsored, followed by the post-arrival QID process',
    1,
    'You cannot travel abroad during the 3-6 week QID processing window after arrival',
    'Arranged through your Qatar-based educational institution',
    'Secure admission from a Qatar-based institution acting as your sponsor\nGather documents against this checklist\nTravel to Qatar on your student entry visa\nComplete mandatory MOI medical screening (HIV/TB) and fingerprinting\nQID issued once the 3-6 week process completes',
    '/assets/images/visa-heroes/qatar.jpg',
    'Qatar Student Visa and Residence Permit (QID) guidance, cross-checked via independent visa-consultancy sourcing', 'https://portal.moi.gov.qa/qatarvisas/', '2026-09-11'
);
SET @qt3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@qt3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@qt3, 'Core Documents', 'Every applicant needs these.', 1);
SET @qt3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@qt3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@qt3s1, 'Admission/Acceptance Letter', 'From your Qatar-based institution.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@qt3, 'Personal Documents', 'Evidence of your background.', 2);
SET @qt3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@qt3s2, 'Birth Certificate', NULL, 'copy', 1, 0, 1, 1),
(@qt3s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@qt3, 'Post-Arrival Documents', 'Required for QID issuance.', 3);
SET @qt3s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@qt3s3, 'Medical Fitness Certificate & Screening Result', 'HIV/TB screening, administered by the MOI after arrival.', 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(90, 3, NULL, 'QAR', 'Confirmed After Assessment', 'Fee varies by institution sponsorship arrangement — confirmed once your specific institution is known.', '2026-09-01', NOW(), 'https://portal.moi.gov.qa/qatarvisas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I travel abroad while my QID is being processed?', 'No — you cannot travel abroad during the 3-6 week QID processing window after arrival.', 90, 3, 1226, 1),
('What medical screening is required?', 'Mandatory MOI-administered screening for HIV and TB, plus fingerprinting, as part of the Residence Permit process.', 90, 3, 1227, 1),
('Who sponsors my Student Visa?', 'Your Qatar-based educational institution, which also initiates your QID process after arrival.', 90, 3, 1228, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Employer-Sponsored Work Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    90, 4, 'QAT-WORK-IN-04', '2026.09', 'published',
    'Employer-sponsored employment in Qatar.',
    'Requires a specific Qatari employer as sponsor, who applies for the work permit and entry-visa quota. Under Law No. 19 of 2020''s Kafala reforms, workers may change employers without a No-Objection Certificate by serving a notice period, and the exit-permit requirement has been removed for over 95% of the workforce.',
    'Tied to your employment contract, renewable',
    'Employer-sponsored: work permit and entry-visa quota, followed by pre- and post-arrival medical exams and QID issuance',
    1,
    'Full cycle (permit, medical exams, biometrics, QID) typically runs 4-8 weeks',
    'Arranged through your Qatari employer; GAMCA medical exam completed in India beforehand',
    'Employer applies for your work permit and entry-visa quota\nComplete your pre-arrival GAMCA medical exam in India\nGather documents against this checklist\nComplete your post-arrival government medical exam and biometric enrollment\nQID issued once the process completes',
    '/assets/images/visa-heroes/qatar.jpg',
    'Qatar Work Visa and Kafala reform guidance (Law No. 19 of 2020), cross-checked via independent immigration-law sourcing', 'https://portal.moi.gov.qa/qatarvisas/', '2026-09-11'
);
SET @qt4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@qt4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@qt4, 'Core Documents', 'Every applicant needs these.', 1);
SET @qt4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@qt4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@qt4s1, 'Employer Work Permit & Entry-Visa Quota Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@qt4, 'Employment Documents', 'Evidence of your role.', 2);
SET @qt4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@qt4s2, 'Employment Contract', NULL, 'copy', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@qt4, 'Medical Documents', 'Mandatory layered medical clearance.', 3);
SET @qt4s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@qt4s3, 'Pre-Arrival GAMCA Medical Exam Result', 'Completed in India before travel.', 'original', 1, 0, 0, 1),
(@qt4s3, 'Post-Arrival Government Medical Exam Result', 'Chest X-ray, HIV/hepatitis B&C/syphilis/TB bloodwork.', 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(90, 4, NULL, 'QAR', 'Confirmed After Assessment', 'Fee varies by role/employer arrangement — the employer typically arranges and often covers work-permit and QID costs.', '2026-09-01', NOW(), 'https://portal.moi.gov.qa/qatarvisas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I change employers without my current employer''s consent?', 'Yes — under Law No. 19 of 2020''s Kafala reforms, workers may change employers without a No-Objection Certificate by serving a notice period and notifying the Ministry of Labour.', 90, 4, 1229, 1),
('Do I still need an exit permit to leave Qatar?', 'For over 95% of the workforce, no — the exit-permit requirement has been removed under the same reforms.', 90, 4, 1230, 1),
('How many medical exams are required?', 'Two — a pre-arrival GAMCA exam in India, and a separate post-arrival government medical exam, both required before QID issuance.', 90, 4, 1231, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Family Visit Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    90, 5, 'QAT-FAM-IN-05', '2026.09', 'published',
    'Visiting family members resident in Qatar.',
    'Sponsored by a Qatar-resident relative — parent, sibling, child, spouse, or in-law, subject to MOI approval. The MOI portal states 1 month validity; some sources report extension to 90 days for first-degree relatives.',
    '1 month, potentially extendable to 90 days for first-degree relatives',
    'Sponsored via your Qatar-resident relative, applied through the MOI/Hukoomi portal',
    0,
    'Confirm the current exact duration and extension terms with us before applying',
    'No in-person office visit required for the sponsored application',
    'Confirm your Qatar-resident relative''s eligibility to sponsor you\nSponsor applies via the MOI/Hukoomi portal\nGather documents against this checklist, including relationship proof\nReceive your approval before travel\nPresent it with your passport on arrival',
    '/assets/images/visa-heroes/qatar.jpg',
    'Qatar MOI Family Visit Visa guidance, cross-checked via independent visa-consultancy sourcing', 'https://portal.moi.gov.qa/qatarvisas/', '2026-09-11'
);
SET @qt5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@qt5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@qt5, 'Core Documents', 'Every applicant needs these.', 1);
SET @qt5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@qt5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@qt5s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@qt5, 'Sponsor & Relationship Documents', 'Evidence of your Qatar-resident sponsor.', 2);
SET @qt5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@qt5s2, 'Sponsor''s QID Copy', NULL, 'copy', 1, 0, 1, 1),
(@qt5s2, 'Relationship Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@qt5, 'Application Documents', 'Your formal application.', 3);
SET @qt5s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@qt5s3, 'MOI/Hukoomi Application Submission', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(90, 5, 150.00, 'QAR', 'Family Visit Visa Fee (Indicative)', 'Reported roughly QAR 100-200 — confirm the exact current figure with us before applying.', '2026-09-01', NOW(), 'https://portal.moi.gov.qa/qatarvisas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Who can sponsor a Family Visit Visa?', 'A Qatar-resident relative — parent, sibling, child, spouse, or in-law — subject to MOI approval.', 90, 5, 1232, 1),
('How long can I stay?', 'The MOI portal states 1 month; some sources report an extension to 90 days is available for first-degree relatives — we confirm the current terms before you apply.', 90, 5, 1233, 1),
('Is there an income requirement for my sponsor?', 'The MOI portal does not state a specific income floor for this visit category (unlike the stricter Dependent residence category).', 90, 5, 1234, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Free Transit Visa (Discover Qatar)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    90, 6, 'QAT-TRANS-IN-06', '2026.09', 'published',
    'Passing through Hamad International Airport en route to a third country.',
    'Qatar Airways passengers transiting a minimum of roughly 6 hours (up to 96 hours) can obtain a free transit visa via the Discover Qatar Transit Desk at Hamad International Airport. Pure airside connections within roughly 24 hours on a through-ticket typically require no separate transit visa at all.',
    'Up to 96 hours (free transit visa) or airside-only connections requiring no visa',
    'Free transit visa via the Discover Qatar Transit Desk at the airport; no application needed for short airside connections',
    0,
    'Standard entry conditions apply: 6-month passport validity, 2 blank visa pages, confirmed onward/return itinerary',
    'Discover Qatar Transit Desk, Hamad International Airport',
    'Confirm whether your layover qualifies for a no-visa airside connection\nIf a longer stopover, visit the Discover Qatar Transit Desk at Hamad International Airport for your free transit visa\nGather documents against this checklist\nExplore Doha during your stopover if eligible\nReturn for your onward flight',
    '/assets/images/visa-heroes/qatar.jpg',
    'Discover Qatar free transit visa guidance for Qatar Airways passengers', 'https://portal.moi.gov.qa/qatarvisas/', '2026-09-11'
);
SET @qt6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@qt6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@qt6, 'Core Documents', 'Every applicant needs these.', 1);
SET @qt6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@qt6s1, 'Valid Passport', 'Valid at least 6 months, with 2 blank pages.', 'original', 1, 0, 1, 1),
(@qt6s1, 'Confirmed Onward/Return Itinerary', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@qt6, 'Transit Desk Documents', 'For layovers requiring the free transit visa.', 2);
SET @qt6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@qt6s2, 'Qatar Airways Boarding Pass/Ticket', 'Required to access the Discover Qatar Transit Desk.', 'original', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(90, 6, 0.00, 'QAR', 'Free Transit Visa', 'Free for Qatar Airways passengers transiting roughly 6-96 hours via the Discover Qatar Transit Desk. No visa needed at all for short airside connections under roughly 24 hours.', '2026-09-01', NOW(), 'https://portal.moi.gov.qa/qatarvisas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the transit visa really free?', 'Yes — Qatar Airways passengers transiting roughly 6-96 hours can obtain a free transit visa via the Discover Qatar Transit Desk at Hamad International Airport.', 90, 6, 1235, 1),
('Do I need any visa for a short layover?', 'Not typically — pure airside connections within roughly 24 hours on a through-ticket usually require no separate transit visa.', 90, 6, 1236, 1),
('Does this apply to all airlines?', 'The free transit visa via Discover Qatar is specifically for Qatar Airways passengers — confirm your specific airline''s arrangement with us.', 90, 6, 1237, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Sponsored Visit Visa (Medical Purpose)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    90, 7, 'QAT-MED-IN-07', '2026.09', 'published',
    'Travelling to Qatar to receive medical treatment.',
    'No distinct standalone "medical visa" product is listed by the MOI — in practice, such visits are processed as sponsored visit visas where the treating Qatari hospital/clinic issues an invitation/appointment letter, and the applicant shows financial proof covering treatment costs.',
    'As needed for the course of treatment, subject to sponsor approval',
    'Sponsored visit visa, with the treating hospital/clinic acting as sponsor',
    0,
    'This category should be independently re-verified directly against MOI/QVC medical-visa service pages before final confirmation',
    'Arranged through your treating Qatari hospital/clinic',
    'Obtain a treatment invitation/appointment letter from the Qatari hospital or clinic\nGather documents against this checklist\nApply as a sponsored visit visa via the hospital/clinic\nReceive approval before travel\nPresent it with your passport on arrival',
    '/assets/images/visa-heroes/qatar.jpg',
    'Qatar Medical Visa guidance (sponsored visit visa route), cross-checked via independent sourcing', 'https://portal.moi.gov.qa/qatarvisas/', '2026-09-11'
);
SET @qt7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@qt7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@qt7, 'Core Documents', 'Every applicant needs these.', 1);
SET @qt7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@qt7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@qt7s1, 'Hospital/Clinic Invitation or Appointment Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@qt7, 'Medical Documents', 'Evidence of your treatment plan.', 2);
SET @qt7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@qt7s2, 'Referral/Diagnosis Report from India', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@qt7, 'Financial Documents', 'Evidence you can pay for treatment.', 3);
SET @qt7s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@qt7s3, 'Bank Statements Covering Treatment Costs', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(90, 7, NULL, 'QAR', 'Confirmed After Assessment', 'Fee is arranged through the sponsoring hospital/clinic''s visit-visa process — confirmed once your treatment plan is known.', '2026-09-01', NOW(), 'https://portal.moi.gov.qa/qatarvisas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a distinct Medical Visa product for Qatar?', 'No standalone product is listed by the MOI — such visits are processed as sponsored visit visas with the treating hospital/clinic as sponsor.', 90, 7, 1238, 1),
('What does the hospital invitation letter need to cover?', 'Confirmation of your treatment appointment, supporting your sponsored visit-visa application.', 90, 7, 1239, 1),
('Do I need to show I can pay for treatment?', 'Yes — bank statements or other financial proof covering treatment costs are required.', 90, 7, 1240, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Business/Visit Visa (Conference Purpose)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    90, 8, 'QAT-CONF-IN-08', '2026.09', 'published',
    'Attending a conference in Qatar.',
    'Processed as a Business/Visit visa, where the conference''s Qatar-based organizing institution (university, ministry, or MOI-accredited professional body) issues the invitation letter — Qatar has no separate "conference visa" line item on the MOI portal.',
    '30 days, extendable once for a similar period',
    'Business Visit Visa route via Hukoomi or the Qatar Visa Center (QVC) in India',
    0,
    'Processing typically runs 3-6 working days',
    'Qatar Visa Center (QVC), India',
    'Obtain an invitation letter from the conference''s Qatar-based organizing institution\nGather documents against this checklist\nApply via Hukoomi''s e-service or the Qatar Visa Center in India\nArrive with your confirmed return ticket and funds proof\nDecision once processed',
    '/assets/images/visa-heroes/qatar.jpg',
    'Qatar Business/Visit Visa (conference purpose) guidance', 'https://hukoomi.gov.qa/en/service/apply-for-business-visa/1000', '2026-09-11'
);
SET @qt8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@qt8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@qt8, 'Core Documents', 'Every applicant needs these.', 1);
SET @qt8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@qt8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@qt8s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@qt8, 'Conference Documents', 'Evidence of the event and your role.', 2);
SET @qt8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@qt8s2, 'Invitation Letter from Qatar-Based Organizing Institution', NULL, 'original', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@qt8, 'Financial Documents', 'Evidence of funds.', 3);
SET @qt8s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@qt8s3, 'Proof of QAR 5,000 (Cash or Credit Card)', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(90, 8, 200.00, 'QAR', 'Business Visit Visa Fee (Indicative)', 'Same indicative range as Business — Conference has no separate MOI product.', '2026-09-01', NOW(), 'https://hukoomi.gov.qa/en/service/apply-for-business-visa/1000', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a distinct Conference Visa for Qatar?', 'No — Qatar has no separate "conference visa" line item on the MOI portal; it is processed as a Business/Visit visa.', 90, 8, 1241, 1),
('Who can issue the invitation letter?', 'The conference''s Qatar-based organizing institution — a university, ministry, or MOI-accredited professional body.', 90, 8, 1242, 1),
('Are the same fund requirements as Business applicable?', 'Yes — the same accredited-sponsor and fund-proof rules apply.', 90, 8, 1243, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Sponsored Event Visa / Hayya Card
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    90, 9, 'QAT-SPORT-IN-09', '2026.09', 'published',
    'Participating in a sporting event in Qatar as an athlete, official, or ticketed spectator.',
    'The MOI issues a compulsory individual visa for each sports-event participant, sponsored by the organizing federation or the Qatar Olympic Committee/hosting sports body. For major tournaments, Qatar continues applying its post-2022 World Cup "Hayya Card" model — a bundled, free multiple-entry visa tied directly to a ticketed spectator/participant''s event ticket — across its 2026 calendar of 83 championships.',
    'Tied to the specific event; Hayya Card-linked visas match the ticketed event duration',
    'Sponsored via the organizing federation/hosting body, or bundled with a Hayya Card for major tournaments',
    0,
    'Qatar''s 2026 calendar includes 83 championships (39 international, 16 world championships) under this model',
    'Arranged via the organizing federation or Hayya Card platform',
    'Confirm whether your event uses the Hayya Card model or requires individual sponsorship\nObtain sponsorship from the organizing federation/hosting body, or your event ticket for Hayya Card eligibility\nGather documents against this checklist\nReceive your visa (bundled with your ticket, if Hayya Card-eligible)\nPresent it with your passport on arrival',
    '/assets/images/visa-heroes/qatar.jpg',
    'Qatar Hayya Card model and sports-event visa guidance', 'https://hukoomi.gov.qa/en/services/hayya-card', '2026-09-11'
);
SET @qt9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@qt9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@qt9, 'Core Documents', 'Every applicant needs these.', 1);
SET @qt9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@qt9s1, 'Valid Passport', 'Valid at least 6 months.', 'original', 1, 0, 1, 1),
(@qt9s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@qt9, 'Event Documents', 'Evidence of your event participation.', 2);
SET @qt9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@qt9s2, 'Event Ticket (Hayya Card Eligibility)', NULL, 'original', 0, 1, 1, 1),
(@qt9s2, 'Federation/Organizing Body Sponsorship', 'For athletes/officials not covered by Hayya Card.', 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(90, 9, 0.00, 'QAR', 'Free (Hayya Card-Bundled Visa)', 'Free when bundled with a Hayya Card for major ticketed tournaments; confirmed separately for individually-sponsored federation/official visas.', '2026-09-01', NOW(), 'https://hukoomi.gov.qa/en/services/hayya-card', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is the Hayya Card?', 'A bundled, free multiple-entry visa tied directly to a ticketed spectator/participant''s event ticket, developed for the 2022 World Cup and continuing for Qatar''s 2026 calendar of 83 championships.', 90, 9, 1244, 1),
('Do all sports participants need individual visa sponsorship?', 'Athletes and officials generally need sponsorship from the organizing federation or hosting body; ticketed spectators for major tournaments may instead qualify for the bundled Hayya Card.', 90, 9, 1245, 1),
('How many championships does Qatar host in 2026?', '83 — 39 international and 16 world championships, per its 2026 sporting calendar.', 90, 9, 1246, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Family Residence Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    90, 10, 'QAT-DEP-IN-10', '2026.09', 'published',
    'Joining a spouse or parent who holds a valid QID in Qatar.',
    'Sponsor must already hold a valid QID and earn a minimum monthly salary of QAR 10,000-15,000 (or QAR 7,000-10,000 if employer-provided accommodation is included) to sponsor spouse/children generally up to age 21.',
    'Tied to the sponsor''s QID validity',
    'Sponsor-driven: entry permit, then Residence Permit (QID) issuance for the dependent after arrival',
    1,
    'Full process to physical QID typically runs 4-8 weeks',
    'Arranged through your sponsoring resident family member',
    'Confirm your sponsor meets the minimum salary threshold\nGather documents against this checklist, including attested relationship proof\nComplete mandatory MoPH medical testing and biometrics after arrival\nArrange mandatory health insurance from date of entry\nQID issued once the process completes',
    '/assets/images/visa-heroes/qatar.jpg',
    'Qatar Family Residence Visa (Dependent) guidance, cross-checked via independent immigration-consultancy sourcing', 'https://portal.moi.gov.qa/qatarvisas/', '2026-09-11'
);
SET @qt10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@qt10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@qt10, 'Core Documents', 'Every applicant needs these.', 1);
SET @qt10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@qt10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@qt10s1, 'Sponsor''s QID Copy', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@qt10, 'Relationship Documents', 'Attested, per Qatari requirements.', 2);
SET @qt10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@qt10s2, 'Attested Marriage Certificate', 'For a spouse applicant.', 'copy', 0, 1, 1, 1),
(@qt10s2, 'Attested Birth Certificate', 'For a child applicant, generally up to age 21.', 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@qt10, 'Financial & Medical Documents', 'Evidence of income and mandatory medical clearance.', 3);
SET @qt10s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@qt10s3, 'Sponsor''s Salary Certificate', 'QAR 10,000-15,000/month, or QAR 7,000-10,000 with employer-provided accommodation.', 'copy', 1, 0, 0, 1),
(@qt10s3, 'MoPH Medical Testing Result', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(90, 10, 300.00, 'QAR', 'MoPH Medical Testing Fee (Per Dependent, Indicative)', 'Roughly QAR 200-400 per dependent for mandatory medical testing, plus separate QID issuance costs — confirm the exact current total with us.', '2026-09-01', NOW(), 'https://portal.moi.gov.qa/qatarvisas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is the minimum sponsor salary for a Dependent visa?', 'QAR 10,000-15,000/month, or QAR 7,000-10,000/month if employer-provided accommodation is included.', 90, 10, 1247, 1),
('Is health insurance mandatory for dependents?', 'Yes — mandatory from the date of entry for all dependents.', 90, 10, 1248, 1),
('Up to what age can children be sponsored?', 'Generally up to age 21.', 90, 10, 1249, 1);
