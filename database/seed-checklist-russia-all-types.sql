-- Russia Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search, same standard as Mexico/Singapore/
-- France/Japan/USA/Australia/Canada/Germany/New Zealand (see AUDIT.md).
-- Russia's real, distinctive facts, genuinely different from every
-- other country built so far:
--   - A unified electronic e-Visa (evisa.kdmid.ru) is open to Indian
--     citizens for several purposes — no invitation letter needed, flat
--     USD 52 fee, issued in 4 calendar days. Following an August 2025
--     rule change still in force in 2026, validity runs 120 days from
--     issue with up to 30 days' stay per entry, single-entry only.
--   - The e-Visa does NOT cover every purpose — Work, Student, and most
--     Family/Dependent visas are explicitly excluded and still require
--     a traditional visa with an official invitation letter, a
--     genuinely different legal mechanism from an e-Visa, not just a
--     slower version of it.
--   - Sports is a real differentiator: the e-Visa''s stated eligible
--     purposes explicitly include sporting events, so many sports
--     visits may qualify for the simpler, invitation-free e-Visa route
--     — unlike Conference/Medical, which typically go through the more
--     formal Humanitarian Visa category requiring an invitation.
--   - Family Visit uses a "Private Visa," and since September 2021
--     close relatives of Russian nationals/residents have been eligible
--     for a one-year multiple-entry private visa without the standard
--     90-days-per-180-days cap — a genuinely distinctive, still-current
--     feature.
--   - Transit has a real visa-free allowance: up to 72 hours through
--     Moscow/Sheremetyevo airport with a confirmed onward ticket to a
--     third country, separate from the standard transit visa route.
--   - Work and Student visas require an HIV test certificate — a real,
--     distinctive medical-clearance requirement not present in the
--     other countries built so far.
--   - Fee/duration figures in the wild show genuine disagreement across
--     sources (reflecting the August 2025 rule change); this content
--     states the figures found and their caveats honestly rather than
--     picking one number and presenting it as certain.
--
-- country_id 142 = Russia. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.
--
-- hero_image_url points at the real Moscow/St Basil's Cathedral/Kremlin
-- and Russian flag photo supplied by the client for this hero.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — e-Visa or Traditional Tourist Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    142, 1, 'RUS-TOUR-IN-01', '2026.09', 'published',
    'Leisure travel and sightseeing in Russia.',
    'Most Indian tourists now use the unified e-Visa (evisa.kdmid.ru) — no invitation letter, hotel booking, or tour voucher needed, single-entry, issued in 4 calendar days. Travellers wanting longer or multiple-entry stays instead use the traditional route with a tourist voucher from a licensed Russian tour operator.',
    'e-Visa: up to 30 days per entry, valid 120 days from issue. Traditional: longer/multi-entry options available',
    'e-Visa: fully online, no biometrics. Traditional: via VFS Global with biometrics',
    0,
    'e-Visa processing is commonly 4 calendar days; traditional visa processing varies',
    'e-Visa: online only. Traditional: VFS Global Russia Visa Application Centre, India',
    'Confirm whether the e-Visa or a traditional visa suits your trip length\nFor e-Visa: complete the online application and pay the fee\nFor traditional: obtain a tourist voucher from a licensed Russian tour operator\nGather documents against this checklist\nSubmit your application (online for e-Visa, via VFS for traditional)\nDecision — e-Visa emailed, traditional visa affixed to passport',
    '/assets/images/visa-heroes/russia.jpg',
    'Cross-verified 2026 secondary sourcing on Russia''s unified e-Visa and traditional Tourist Visa (official mid.ru/evisa.kdmid.ru direct access blocked in research)', 'https://evisa.kdmid.ru/', '2026-09-11'
);
SET @rt1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@rt1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rt1, 'Core Documents (e-Visa)', 'Every e-Visa applicant needs these.', 1);
SET @rt1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rt1s1, 'Valid Passport', 'At least 6 months validity, with a blank page.', 'original', 1, 0, 1, 1),
(@rt1s1, 'Digital Passport-Style Photo', 'Uploaded during the online e-Visa application.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rt1, 'Traditional Visa Documents (If Not Using e-Visa)', 'For longer or multiple-entry stays.', 2);
SET @rt1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rt1s2, 'Tourist Voucher/Visa Support Letter', 'From a licensed Russian tour operator or hotel.', 'original', 0, 1, 1, 1),
(@rt1s2, 'Travel Itinerary', NULL, 'original', 0, 1, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rt1, 'Application Documents', 'Your formal application details.', 3);
SET @rt1s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rt1s3, 'Completed Application Form', 'Online for e-Visa; paper form via VFS for traditional.', 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(142, 1, 52.00, 'USD', 'e-Visa Fee', 'e-Visa fee is USD 52 (figures across sources vary slightly, e.g. EUR 50-equivalent quoted elsewhere — we confirm the exact current figure before you apply). Traditional Tourist Visa consular fee runs roughly USD 75 plus VFS service charges.', '2026-09-01', NOW(), 'https://evisa.kdmid.ru/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How long can I stay on the Russia e-Visa?', 'Up to 30 days per entry, with the visa itself valid 120 days from issue, following an August 2025 rule change still in force in 2026 — figures reported elsewhere (e.g. 16-day stays) reflect the older, pre-update rule.', 142, 1, 950, 1),
('Do I need an invitation letter for the e-Visa?', 'No — the e-Visa needs no invitation letter, hotel booking, or tour voucher, unlike the traditional Tourist Visa route.', 142, 1, 951, 1),
('When would I need the traditional Tourist Visa instead?', 'If you want a longer stay or multiple entries than the e-Visa allows — the traditional route requires a tourist voucher from a licensed Russian tour operator.', 142, 1, 952, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — e-Visa or Traditional Business Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    142, 2, 'RUS-BUS-IN-02', '2026.09', 'published',
    'Short business visits — meetings and negotiations — to Russia.',
    'The e-Visa covers business purpose too, on the same no-invitation, single-entry, 30-day terms as Tourist. For multi-entry or longer visas, a traditional Business Visa requires an invitation from a Russian company or the Chamber of Commerce and Industry of the Russian Federation (CCI), which explicitly issues invitations for Indian applicants.',
    'e-Visa: up to 30 days per entry. Traditional: single/double-entry up to 90 days, or multi-entry up to 1 year or 5 years with a qualifying invitation',
    'e-Visa: fully online, no biometrics. Traditional: via VFS Global with biometrics',
    0,
    'A reported simplified India-Russia one-year multiple-entry business visa arrangement is part of an evolving bilateral simplification track — confirm current terms with us',
    'e-Visa: online only. Traditional: VFS Global Russia Visa Application Centre, India',
    'Confirm whether the e-Visa or a traditional multi-entry Business Visa suits your needs\nFor traditional: obtain an invitation from your Russian host company or the CCI\nGather documents against this checklist\nSubmit your application (online for e-Visa, via VFS for traditional)\nAttend biometrics if applying traditionally\nDecision once processed',
    '/assets/images/visa-heroes/russia.jpg',
    'Cross-verified 2026 secondary sourcing on Russia e-Visa and CCI-issued Business Visa invitations', 'https://www.businesstoday.in/nri/visa/story/russia-opens-one-year-multiple-entry-business-visa-for-indians-check-more-details-here-533179-2026-05-25', '2026-09-11'
);
SET @rt2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@rt2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rt2, 'Core Documents (e-Visa)', 'Every e-Visa applicant needs these.', 1);
SET @rt2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rt2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@rt2s1, 'Digital Passport-Style Photo', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rt2, 'Traditional Visa Documents (If Not Using e-Visa)', 'For multi-entry or longer stays.', 2);
SET @rt2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rt2s2, 'Invitation from Russian Company or CCI', NULL, 'original', 0, 1, 1, 1),
(@rt2s2, 'Covering Letter from Indian Employer', NULL, 'original', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rt2, 'Application Documents', 'Your formal application details.', 3);
SET @rt2s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rt2s3, 'Completed Application Form', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(142, 2, 52.00, 'USD', 'e-Visa Fee', 'Same e-Visa fee as Tourist. Traditional multi-entry Business Visas run higher (roughly USD 300/1-year multi-entry) with a qualifying CCI or company invitation.', '2026-09-01', NOW(), 'https://www.businesstoday.in/nri/visa/story/russia-opens-one-year-multiple-entry-business-visa-for-indians-check-more-details-here-533179-2026-05-25', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I use the e-Visa for business trips?', 'Yes — the e-Visa explicitly covers business purpose on the same no-invitation, 30-day terms as Tourist.', 142, 2, 953, 1),
('Who can issue a Business Visa invitation?', 'A Russian host company, or the Chamber of Commerce and Industry of the Russian Federation (CCI), which explicitly issues invitations for Indian applicants.', 142, 2, 954, 1),
('Is there a multi-year Business Visa option?', 'Yes — multi-entry visas of up to 1 year, or up to 5 years with a qualifying invitation and prior visa-usage history, are available through the traditional route.', 142, 2, 955, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Traditional Student Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    142, 3, 'RUS-STU-IN-03', '2026.09', 'published',
    'Full-time study at a Russian educational institution.',
    'Not e-Visa eligible — requires a traditional Student Visa. A mandatory invitation letter is issued by the General Administration for Migration Issues (GUVM) of Russia''s Ministry of Internal Affairs, arranged through your accredited Russian university, before you can apply.',
    'Duration of your study program',
    'Traditional visa via VFS Global, requires prior GUVM invitation through your university',
    1,
    'Processing typically runs 10-20 working days once the GUVM invitation is in hand',
    'VFS Global Russia Visa Application Centre, India',
    'Secure admission and obtain your GUVM invitation through your Russian university\nComplete a required medical certificate and HIV test\nGather documents against this checklist\nSubmit your application via VFS Global\nAttend in-person biometrics\nDecision once processed',
    '/assets/images/visa-heroes/russia.jpg',
    'Cross-verified 2026 secondary sourcing on Russia Student Visa GUVM invitation requirements', 'https://leverageedu.com/learn/russia-student-visa-requirements/', '2026-09-11'
);
SET @rt3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@rt3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rt3, 'Core Documents', 'Every applicant needs these.', 1);
SET @rt3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rt3s1, 'Valid Passport', 'Valid 18 months from entry, with 2 blank pages.', 'original', 1, 0, 1, 1),
(@rt3s1, 'GUVM Invitation Letter', 'Arranged through your accredited Russian university.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rt3, 'Medical Documents', 'Mandatory health clearance.', 2);
SET @rt3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rt3s2, 'HIV Test Certificate', 'Within 3 months of application.', 'original', 1, 0, 1, 1),
(@rt3s2, 'General Medical Certificate', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rt3, 'Financial & Academic Documents', 'Evidence of funds and admission.', 3);
SET @rt3s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rt3s3, 'Proof of Funds for First-Year Tuition & Living Costs', NULL, 'copy', 1, 0, 0, 1),
(@rt3s3, 'University Admission Letter', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(142, 3, 75.00, 'USD', 'Student Visa Consular Fee', 'Approximately USD 75, plus separate VFS Global service charges. Not eligible for the lower-cost e-Visa route.', '2026-09-01', NOW(), 'https://leverageedu.com/learn/russia-student-visa-requirements/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I use the e-Visa to study in Russia?', 'No — Student visas are explicitly excluded from the e-Visa program and require the traditional visa route with a GUVM invitation.', 142, 3, 956, 1),
('Who arranges my GUVM invitation?', 'Your accredited Russian university arranges this invitation through the General Administration for Migration Issues, a required step before you can apply for the visa.', 142, 3, 957, 1),
('Is an HIV test really required?', 'Yes — a negative HIV test certificate within 3 months of application is a genuine, mandatory requirement for Russian Student visas.', 142, 3, 958, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Traditional Work Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    142, 4, 'RUS-WORK-IN-04', '2026.09', 'published',
    'Employer-sponsored employment in Russia.',
    'Not e-Visa eligible — work is explicitly excluded from the e-Visa program. Your Russian employer must first obtain a work permit and official invitation from the Ministry of Internal Affairs before you can apply for the Work Visa at a consulate/VFS in India.',
    'Tied to the employer''s work permit validity',
    'Traditional visa via VFS Global, requires prior employer-obtained work permit and invitation',
    1,
    'End-to-end process (invitation, work permit, visa) typically runs 6-8 weeks',
    'VFS Global Russia Visa Application Centre, India',
    'Employer obtains your work permit and official invitation from the Ministry of Internal Affairs\nComplete a required HIV test and medical certificate\nGather documents against this checklist\nSubmit your application via VFS Global\nAttend in-person biometrics\nDecision once processed',
    '/assets/images/visa-heroes/russia.jpg',
    'Cross-verified 2026 secondary sourcing on Russia Work Visa employer-sponsored process', 'https://terratern.com/blog/russian-work-visa-for-indian-citizens/', '2026-09-11'
);
SET @rt4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@rt4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rt4, 'Core Documents', 'Every applicant needs these.', 1);
SET @rt4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rt4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@rt4s1, 'Employer Work Permit & Invitation', 'From the Ministry of Internal Affairs.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rt4, 'Employment Documents', 'Evidence of your role.', 2);
SET @rt4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rt4s2, 'Employment Contract', NULL, 'copy', 1, 0, 1, 1),
(@rt4s2, 'Credential/Qualification Evidence', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rt4, 'Medical Documents', 'Mandatory health clearance.', 3);
SET @rt4s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rt4s3, 'HIV Test Certificate', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(142, 4, NULL, 'USD', 'Confirmed After Assessment', 'Reported consular fees for Work Visas vary widely by category (roughly USD 90-230 equivalent across sources) — we confirm the exact current fee once your employer''s invitation category is known.', '2026-09-01', NOW(), 'https://terratern.com/blog/russian-work-visa-for-indian-citizens/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I apply for a Work Visa on my own?', 'No — your Russian employer must first obtain a work permit and official invitation from the Ministry of Internal Affairs before you can apply.', 142, 4, 959, 1),
('How long does the full process take?', 'Roughly 6-8 weeks end-to-end, covering the employer''s invitation/permit process and your own visa application.', 142, 4, 960, 1),
('Is a medical test required for Work visas?', 'Yes — an HIV test certificate and general medical certificate are required.', 142, 4, 961, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Private Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    142, 5, 'RUS-FAM-IN-05', '2026.09', 'published',
    'Visiting family members who are Russian citizens or residents.',
    'Uses the Private Visa category, requiring your Russian host relative to obtain an invitation from their local MVD (Ministry of Internal Affairs) office, notarized for close relatives. Since September 2021, close relatives of Russian nationals have been eligible for a one-year multiple-entry private visa without the standard 90-days-per-180-days cap.',
    'Up to 90 days per 180-day period, or up to 1 year multi-entry for close relatives (no 90/180 cap)',
    'Traditional Private Visa via VFS Global, requires prior host-obtained MVD invitation',
    1,
    'Host''s MVD invitation typically takes 2-4 weeks to process in Russia',
    'VFS Global Russia Visa Application Centre, India',
    'Your Russian host relative obtains an invitation from their local MVD office\nGather documents against this checklist, including relationship proof\nSubmit your Private Visa application via VFS Global\nAttend in-person biometrics\nDecision once processed',
    '/assets/images/visa-heroes/russia.jpg',
    'Cross-verified 2026 secondary sourcing on Russia Private Visa and the September 2021 close-relative multi-entry rule', 'https://russiable.com/private-visa-russia-visit-family-friends/', '2026-09-11'
);
SET @rt5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@rt5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rt5, 'Core Documents', 'Every applicant needs these.', 1);
SET @rt5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rt5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@rt5s1, 'MVD Invitation Letter', 'Obtained by your Russian host, notarized for close relatives.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rt5, 'Relationship Documents', 'Evidence of your family relationship.', 2);
SET @rt5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rt5s2, 'Relationship Proof', 'Birth/marriage certificates.', 'copy', 1, 0, 0, 1),
(@rt5s2, 'Host''s Russian Identity/Residency Document', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rt5, 'Application Documents', 'Your formal application.', 3);
SET @rt5s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rt5s3, 'Completed Application Form', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(142, 5, NULL, 'USD', 'Confirmed After Assessment', 'Private Visa fees vary by entry type and duration — the 1-year multiple-entry close-relative option carries different pricing from a standard single-entry Private Visa; we confirm the exact fee once your relationship and trip pattern are known.', '2026-09-01', NOW(), 'https://russiable.com/private-visa-russia-visit-family-friends/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is genuinely different about visiting close relatives in Russia?', 'Since September 2021, close relatives of Russian nationals have been eligible for a one-year multiple-entry private visa without the standard 90-days-per-180-days stay cap — a real, distinctive feature still in force in 2026.', 142, 5, 962, 1),
('Who obtains the invitation for a Family Visit?', 'Your Russian host relative, via their local MVD (Ministry of Internal Affairs) office, notarized for close relatives.', 142, 5, 963, 1),
('Can I use the e-Visa to visit family?', 'Most Family Visit cases are not covered by the e-Visa and require the traditional Private Visa with an MVD invitation.', 142, 5, 964, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Transit Visa / 72-Hour Visa-Free Transit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    142, 6, 'RUS-TRANS-IN-06', '2026.09', 'published',
    'Passing through Russia en route to a third country.',
    'A Transit Visa is required only if you pass through passport control or your layover exceeds 24 hours. Travellers remaining airside under 24 hours need no visa, and there is a specific 72-hour visa-free transit allowance through Moscow/Sheremetyevo airport with a confirmed onward ticket to a third country.',
    'Up to 3 days for a standard air transit visa; up to 72 hours visa-free via Sheremetyevo',
    'Standard transit visa via VFS Global if required; otherwise no application needed for eligible short layovers',
    0,
    'Confirm your specific routing and layover length before assuming a visa is or isn''t needed',
    'VFS Global Russia Visa Application Centre, India (if a visa is required)',
    'Confirm whether your layover qualifies for visa-free transit (under 24 hours airside, or the 72-hour Sheremetyevo allowance)\nIf not, gather documents against this checklist and apply for a standard Transit Visa\nAttend biometrics if applying for a visa\nDecision once processed',
    '/assets/images/visa-heroes/russia.jpg',
    'Cross-verified 2026 secondary sourcing on Russia transit visa rules and the Sheremetyevo 72-hour visa-free allowance', 'https://en.wikipedia.org/wiki/Visa_policy_of_Russia', '2026-09-11'
);
SET @rt6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@rt6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rt6, 'Core Documents', 'For eligible visa-free transit.', 1);
SET @rt6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rt6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@rt6s1, 'Confirmed Onward Ticket to Third Country', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rt6, 'If a Transit Visa Is Required', 'Fall back to a standard transit visa.', 2);
SET @rt6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rt6s2, 'Valid Visa for Destination Country', 'If required.', 'copy', 0, 1, 0, 1),
(@rt6s2, 'Standard Transit Visa Application', NULL, 'original', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(142, 6, NULL, 'USD', 'Confirmed After Assessment', 'No fee applies for eligible visa-free transit under 24 hours airside or the 72-hour Sheremetyevo allowance; a standard consular fee applies only if a full Transit Visa is genuinely required.', '2026-09-01', NOW(), 'https://en.wikipedia.org/wiki/Visa_policy_of_Russia', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I always need a transit visa for Russia?', 'Not necessarily — under 24 hours airside needs no visa, and there is a specific 72-hour visa-free allowance through Moscow/Sheremetyevo airport with a confirmed onward ticket.', 142, 6, 965, 1),
('What if my layover exceeds these windows?', 'You would need a standard Transit Visa, valid for up to 3 days of air transit.', 142, 6, 966, 1),
('Does the e-Visa cover transit?', 'The e-Visa''s stated eligible purposes in the sourcing reviewed do not list transit as a distinct category — transit beyond the visa-free windows typically needs a traditional transit visa.', 142, 6, 967, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Humanitarian Visa (Medical)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    142, 7, 'RUS-MED-IN-07', '2026.09', 'published',
    'Travelling to Russia to receive medical treatment.',
    'Falls under the Humanitarian Visa category. Requires an invitation/certificate from the treating Russian medical institution — typically issued free of charge, in 1-14 days — plus a referral letter from your hospital in India. Accompanying family members can be added to the same invitation using the patient''s reference number.',
    'As needed for the course of treatment, single/double entry up to 3 months, multi-entry up to 1 year',
    'Traditional Humanitarian Visa via VFS Global, requires prior treating-institution invitation',
    1,
    'Invitation processing from the medical institution typically runs 1-14 days',
    'VFS Global Russia Visa Application Centre, India',
    'Obtain an invitation/certificate from the treating Russian medical institution\nObtain a referral letter from your hospital in India\nGather documents against this checklist\nSubmit your Humanitarian Visa application via VFS Global\nAttend biometrics\nDecision once processed',
    '/assets/images/visa-heroes/russia.jpg',
    'Cross-verified 2026 secondary sourcing on Russia Humanitarian/Medical Visa invitation process', 'https://visaguide.world/europe/russia-visa/humanitarian-visa/', '2026-09-11'
);
SET @rt7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@rt7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rt7, 'Core Documents', 'Every applicant needs these.', 1);
SET @rt7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rt7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@rt7s1, 'Treating Institution Invitation/Certificate', 'Typically issued free of charge by the Russian medical institution.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rt7, 'Medical Documents', 'Evidence of your treatment plan.', 2);
SET @rt7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rt7s2, 'Referral Letter from Doctor in India', NULL, 'copy', 1, 0, 1, 1),
(@rt7s2, 'Diagnosis Report', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rt7, 'Family Member Documents (If Accompanying)', 'For family added to the same invitation.', 3);
SET @rt7s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rt7s3, 'Patient''s Invitation Reference Number', 'Used to add accompanying family members to the same invitation.', 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(142, 7, NULL, 'USD', 'Confirmed After Assessment', 'The treating institution''s invitation is typically free; the consular visa fee itself varies by entry type — we confirm the exact fee once your treatment plan and visa duration are known.', '2026-09-01', NOW(), 'https://visaguide.world/europe/russia-visa/humanitarian-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a Medical Visa fee for the hospital invitation?', 'No — invitations for the patient are typically issued free of charge by the treating Russian medical institution, processed in 1-14 days.', 142, 7, 968, 1),
('Can my family accompany me for treatment?', 'Yes — accompanying family members can be added to the same invitation using the patient''s reference number.', 142, 7, 969, 1),
('Is Medical Treatment covered by the e-Visa?', 'Formal medical treatment normally goes through the traditional Humanitarian Visa route for adequate duration and certainty, rather than the e-Visa.', 142, 7, 970, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Humanitarian Visa (Conference)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    142, 8, 'RUS-CONF-IN-08', '2026.09', 'published',
    'Attending a conference or academic/cultural event in Russia.',
    'Generally processed as a Humanitarian Visa (covering academic, cultural, socio-political ties) rather than a standard business visa. Requires a written invitation from the host/organizing body, detailing the organization''s legal name, address, tax ID, registration number, and signatory.',
    'Single/double entry up to 3 months, or multi-entry up to 1 year',
    'Traditional Humanitarian Visa via VFS Global, requires prior organizer invitation',
    1,
    'Some conference travel may alternatively qualify under the e-Visa''s business category depending on activity type — confirm with us',
    'VFS Global Russia Visa Application Centre, India',
    'Obtain a written invitation from the conference organizer with full organizational details\nGather documents against this checklist\nSubmit your Humanitarian Visa application via VFS Global\nAttend biometrics\nDecision once processed',
    '/assets/images/visa-heroes/russia.jpg',
    'Cross-verified 2026 secondary sourcing on Russia Humanitarian Visa (academic/cultural purpose) guidance', 'https://denmark.kdmid.ru/en/consular-functions/visa-application-procedure/ordinary-humanitarian-visa/', '2026-09-11'
);
SET @rt8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@rt8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rt8, 'Core Documents', 'Every applicant needs these.', 1);
SET @rt8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rt8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@rt8s1, 'Organizer Invitation Letter', 'With the host organization''s legal name, address, tax ID (INN), registration number, and signatory.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rt8, 'Conference Documents', 'Evidence of the event.', 2);
SET @rt8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rt8s2, 'Conference Registration/Programme', NULL, 'copy', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rt8, 'Application Documents', 'Your formal application.', 3);
SET @rt8s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rt8s3, 'Completed Application Form', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(142, 8, NULL, 'USD', 'Confirmed After Assessment', 'Humanitarian Visa fees vary by entry type and duration — we confirm the exact fee once your conference details and required visa duration are known.', '2026-09-01', NOW(), 'https://denmark.kdmid.ru/en/consular-functions/visa-application-procedure/ordinary-humanitarian-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Why is Conference a Humanitarian Visa, not a Business Visa?', 'Because it is not directly commercial in nature — academic, cultural, and socio-political events are processed under the Humanitarian Visa category instead.', 142, 8, 971, 1),
('What must the organizer invitation include?', 'The host organization''s legal name, address, tax ID (INN), registration number, and an authorized signatory, alongside your personal and passport details.', 142, 8, 972, 1),
('Could my conference qualify for the e-Visa instead?', 'Possibly, depending on the activity type — some conference travel may qualify under the e-Visa''s business category; confirm your specific case with us.', 142, 8, 973, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — e-Visa (Sporting Events) or Humanitarian Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    142, 9, 'RUS-SPORT-IN-09', '2026.09', 'published',
    'Participating in a sporting event or competition in Russia.',
    'A real differentiator from most other countries built so far: the e-Visa''s stated eligible purposes explicitly include sporting events, so many sports visits may qualify for the simpler, invitation-free e-Visa route. For longer or more formal engagements, the Humanitarian Visa category (which explicitly covers taking part in sports) requires an invitation from the sports federation or organizing committee.',
    'e-Visa: up to 30 days per entry. Humanitarian: single/double entry up to 3 months, or multi-entry up to 1 year',
    'e-Visa: fully online, no biometrics, if eligible. Humanitarian: traditional visa via VFS Global with prior invitation',
    0,
    'Confirm whether your specific event/duration qualifies for the e-Visa before assuming you need a full Humanitarian Visa',
    'e-Visa: online only. Humanitarian: VFS Global Russia Visa Application Centre, India',
    'Confirm whether your event and stay length qualify for the e-Visa''s sporting-event purpose\nIf not, obtain an invitation from your sports federation or the event organizing committee\nGather documents against this checklist\nSubmit your application (online for e-Visa, via VFS for Humanitarian)\nDecision once processed',
    '/assets/images/visa-heroes/russia.jpg',
    'Cross-verified 2026 secondary sourcing on Russia e-Visa eligible purposes and Humanitarian Visa (sports) guidance', 'https://consul.online/en/blog/russia-e-visa-2026-countries-rules-update', '2026-09-11'
);
SET @rt9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@rt9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rt9, 'Core Documents (e-Visa)', 'For eligible short sporting-event visits.', 1);
SET @rt9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rt9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@rt9s1, 'Digital Passport-Style Photo', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rt9, 'Humanitarian Visa Documents (Longer/Formal Engagements)', 'For events or durations beyond e-Visa terms.', 2);
SET @rt9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rt9s2, 'Sports Federation/Organizing Committee Invitation', 'With organizational details, same format as Conference invitations.', 'original', 0, 1, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rt9, 'Event Documents', 'Evidence of your participation.', 3);
SET @rt9s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rt9s3, 'Event Schedule/Entry Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(142, 9, 52.00, 'USD', 'e-Visa Fee (If Eligible)', 'USD 52 if your event qualifies for the e-Visa''s sporting-events purpose; otherwise a Humanitarian Visa fee applies, confirmed once your event/duration is known.', '2026-09-01', NOW(), 'https://consul.online/en/blog/russia-e-visa-2026-countries-rules-update', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I use the e-Visa for a sporting event in Russia?', 'Often yes — the e-Visa''s stated eligible purposes explicitly include sporting events, making this simpler than the invitation-based Humanitarian Visa many other purposes require.', 142, 9, 974, 1),
('When would I need the Humanitarian Visa instead?', 'For longer engagements or events beyond the e-Visa''s 30-day/single-entry terms, requiring an invitation from your sports federation or the organizing committee.', 142, 9, 975, 1),
('What does the sports federation invitation need to include?', 'The same organizational-detail format as Conference invitations — legal name, address, tax ID, registration number, and signatory.', 142, 9, 976, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Accompanying Family Member Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    142, 10, 'RUS-DEP-IN-10', '2026.09', 'published',
    'Accompanying a spouse or parent who holds a Work or Student visa in Russia.',
    'Not e-Visa eligible. Structured as an "Accompanying Family Member" visa tied to the principal visa holder, requiring an invitation from the same employer/organization that sponsored the principal, plus approval from Russia''s General Directorate for Migratory Affairs (GUVM). Eligible dependents are close relatives: spouse, children under 18, and disabled dependents aged 18+.',
    'Matches the validity of the principal visa holder''s permit',
    'Traditional visa via VFS Global, requires prior employer/institution invitation and GUVM approval',
    1,
    'Processing is tied to the principal visa holder''s own sponsorship timeline',
    'VFS Global Russia Visa Application Centre, India',
    'Confirm the principal work/student visa holder''s sponsoring employer or institution\nObtain the accompanying family member invitation and GUVM approval\nGather documents against this checklist, including relationship proof\nSubmit your application via VFS Global\nAttend in-person biometrics\nDecision once processed',
    '/assets/images/visa-heroes/russia.jpg',
    'Cross-verified 2026 secondary sourcing on Russia accompanying family member visa process', 'https://www.visahouse.com/en/information/russian-visa-for-a-family-member/', '2026-09-11'
);
SET @rt10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@rt10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rt10, 'Core Documents', 'Every applicant needs these.', 1);
SET @rt10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rt10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@rt10s1, 'Accompanying Family Member Invitation', 'From the principal holder''s sponsoring employer/institution.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rt10, 'Relationship Documents', 'Evidence of your relationship to the principal holder.', 2);
SET @rt10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rt10s2, 'Marriage Certificate', 'For a spouse applicant.', 'copy', 0, 1, 1, 1),
(@rt10s2, 'Birth Certificate', 'For a child under 18, or a disabled dependent aged 18+.', 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@rt10, 'Approval Documents', 'Mandatory Russian government approval.', 3);
SET @rt10s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@rt10s3, 'GUVM Approval', 'From Russia''s General Directorate for Migratory Affairs.', 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(142, 10, NULL, 'USD', 'Confirmed After Assessment', 'Fee depends on the principal holder''s visa category (Work or Student) and matches that category''s invitation/consular fee structure — confirmed once the principal''s sponsorship is known.', '2026-09-01', NOW(), 'https://www.visahouse.com/en/information/russian-visa-for-a-family-member/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Who is eligible as a dependent for this visa?', 'Close relatives only: a spouse, children under 18, and disabled dependents aged 18 and over.', 142, 10, 977, 1),
('Who issues the dependent''s invitation?', 'The same employer or educational institution that sponsored the principal visa holder, with approval required from Russia''s General Directorate for Migratory Affairs (GUVM).', 142, 10, 978, 1),
('Can I use the e-Visa to join a family member in Russia?', 'No — Dependent visas are not e-Visa eligible and require the traditional Accompanying Family Member process.', 142, 10, 979, 1);
