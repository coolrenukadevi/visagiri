-- Thailand Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search, same standard as every other
-- country built this session (see AUDIT.md). hero_image_url points at
-- the real Wat Arun/Bangkok and Thai flag photo supplied by the
-- client for this hero.
--
-- Thailand's real, distinctive facts:
--   - A genuinely TIME-SENSITIVE visa-exemption change: Indian
--     passport holders get 60 days visa-free through 14 September
--     2026 (a scheme running since 2024); effective 15 September 2026
--     (new regulations published 31 August 2026), this drops to 30
--     days, extendable once for a further 30 days (max ~60 days per
--     entry). India stays on the exemption list — it is NOT among the
--     21 nationalities losing visa-free status entirely — just at a
--     reduced duration. This cutoff is stated with its effective date
--     throughout, not presented as a settled, evergreen fact.
--   - ALL arrivals, regardless of visa status, must submit a Thailand
--     Digital Arrival Card (TDAC) online within 72 hours before
--     arrival — a real, universal requirement layered on top of
--     whichever visa/exemption status applies.
--   - Work is a genuine two-step process: a Non-Immigrant "B" visa
--     from the embassy (often preceded by the employer's WP.3
--     pre-approval), THEN, after arrival, a separate Work Permit
--     application via the now fully digital e-workpermit.doe.go.th
--     system (mandatory online since 13 October 2025) — holding the
--     visa without the permit is legal presence but illegal
--     employment, a real and important distinction.
--   - There is no standalone short-stay "medical tourist" visa —
--     most Indian medical travellers simply use the visa-exemption or
--     Tourist Visa; the "O-A" Long Stay visa often marketed alongside
--     medical tourism is actually structured for retirees aged 50+,
--     a genuine mismatch worth stating honestly rather than presenting
--     O-A as Thailand's medical visa.
--   - Transit genuinely has three different paths depending on
--     circumstances: under-12-hour airside connections need nothing;
--     switching Bangkok's two airports uses the standard
--     exemption/e-visa; and a dedicated Transit Visa (800 THB) exists
--     for non-exempt nationalities or specific cases like sports-event
--     participation.
--
-- country_id 98 = Thailand. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Visa Exemption / Tourist Visa (TR)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    98, 1, 'THA-TOUR-IN-01', '2026.09', 'published',
    'Leisure travel, sightseeing, and short personal visits to Thailand.',
    'Most Indian tourists need no visa at all. Visa-exemption gives 60 days through 14 September 2026; from 15 September 2026, this reduces to 30 days, extendable once for a further 30 days (max ~60 days). For longer or multiple-entry stays, an e-visa Tourist Visa (TR) is available. All arrivals must submit a Thailand Digital Arrival Card (TDAC) online within 72 hours before travel, regardless of visa status.',
    '30-60 days visa-free depending on entry date; up to 60 days per entry on a Tourist Visa (TR)',
    'No visa needed for exempt stays (TDAC required online); e-Visa via thaievisa.go.th for longer stays',
    0,
    'A real reduction in visa-free duration takes effect 15 September 2026 — check your entry date against this cutoff before travel',
    'No in-person application needed for exempt stays; e-Visa is fully online for the Tourist Visa (TR)',
    'Confirm whether visa-exemption covers your planned stay length and entry date\nComplete your Thailand Digital Arrival Card (TDAC) online within 72 hours of arrival\nIf a longer/multi-entry stay is needed, apply for the e-Visa Tourist Visa (TR)\nGather documents against this checklist\nReceive your e-Visa approval before travel if applicable',
    '/assets/images/visa-heroes/thailand.jpg',
    'Thai Ministry of Foreign Affairs and thaievisa.go.th visa-exemption and Tourist Visa (TR) guidance', 'https://www.thaievisa.go.th/', '2026-09-11'
);
SET @tt1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tt1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tt1, 'Core Documents', 'Every traveller needs these, visa-exempt or not.', 1);
SET @tt1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tt1s1, 'Valid Passport', 'Valid at least 6 months beyond arrival.', 'original', 1, 0, 1, 1),
(@tt1s1, 'Thailand Digital Arrival Card (TDAC)', 'Completed online within 72 hours before arrival, mandatory for all travellers.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tt1, 'Financial & Travel Documents', 'Evidence of funds and onward travel.', 2);
SET @tt1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tt1s2, 'Return/Onward Ticket', NULL, 'copy', 1, 0, 1, 1),
(@tt1s2, 'Bank Statements', 'May be requested by immigration officers.', 'copy', 0, 1, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tt1, 'e-Visa Documents (For Longer/Multiple-Entry Stays)', 'Only if visa-exemption does not cover your trip.', 3);
SET @tt1s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tt1s3, 'e-Visa Application (thaievisa.go.th)', NULL, 'original', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(98, 1, 3000.00, 'INR', 'Tourist Visa (TR) Single-Entry Fee', 'Visa-exemption itself is free — this fee only applies if you need a Tourist Visa (TR) for a longer or multi-entry stay: INR 3,000 single-entry (3-month validity, 60-day stay) or INR 13,500 multi-entry (6-month validity, unlimited entries, 60 days each).', '2026-09-01', NOW(), 'https://www.thaievisa.go.th/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How many visa-free days do Indians get in Thailand?', '60 days through 14 September 2026; from 15 September 2026, this reduces to 30 days, extendable once for a further 30 days at a Thai immigration office (maximum roughly 60 days total per entry).', 98, 1, 1070, 1),
('What is the TDAC and is it mandatory?', 'The Thailand Digital Arrival Card — a mandatory online submission within 72 hours before arrival for every traveller, regardless of visa or exemption status.', 98, 1, 1071, 1),
('When would I need a Tourist Visa (TR) instead of visa-exemption?', 'If your planned stay exceeds the exemption period, or you need multiple entries — apply for the e-Visa Tourist Visa (TR) in advance.', 98, 1, 1072, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Visa Exemption / Non-Immigrant "B"
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    98, 2, 'THA-BUS-IN-02', '2026.09', 'published',
    'Short business visits — meetings, negotiations, site visits — to Thailand, without local pay.',
    'Short business trips fall under the same visa-exemption window as tourism. Longer or recurring business activity requires a Non-Immigrant Visa "B", which never authorizes paid work by itself — that requires a separate work permit under the Work visa category.',
    'Exempt stays: 30-60 days depending on entry date. Non-Immigrant "B": 3 months (single-entry) or 1 year (multiple-entry)',
    'No visa needed for exempt short trips (TDAC required); Non-Immigrant "B" visa via embassy/consulate for longer stays',
    0,
    'Confirm whether your trip qualifies for visa-exemption before applying for Non-Immigrant "B"',
    'Royal Thai Embassy/Consulate, India, for Non-Immigrant "B" applications',
    'Confirm whether visa-exemption covers your business trip\nComplete your TDAC online within 72 hours of arrival\nIf longer/recurring: obtain an invitation letter and corporate documents from your Thai host company\nGather documents against this checklist\nSubmit your Non-Immigrant "B" application if required',
    '/assets/images/visa-heroes/thailand.jpg',
    'Thai Ministry of Foreign Affairs Non-Immigrant Visa B (Business/Work) guidance', 'https://www.mfa.go.th/en/publicservice/non-immigrant-visa-b-for-business-and-work', '2026-09-11'
);
SET @tt2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tt2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tt2, 'Core Documents', 'Every applicant needs these.', 1);
SET @tt2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tt2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@tt2s1, 'TDAC Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tt2, 'Non-Immigrant "B" Documents (For Longer/Recurring Trips)', 'If visa-exemption does not cover your trip.', 2);
SET @tt2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tt2s2, 'Invitation Letter from Thai Host Company', NULL, 'original', 0, 1, 1, 1),
(@tt2s2, 'Thai Company Corporate Documents', 'Affidavit, shareholder list, financials.', 'copy', 0, 1, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tt2, 'Financial Documents', 'Evidence of funds.', 3);
SET @tt2s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tt2s3, 'Bank Statements', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(98, 2, 2000.00, 'THB', 'Non-Immigrant Visa "B" Fee (Single-Entry)', 'THB 2,000 for single-entry (3-month validity), or THB 5,000 for multiple-entry (1-year validity). Not needed if your trip qualifies for visa-exemption.', '2026-09-01', NOW(), 'https://www.mfa.go.th/en/publicservice/non-immigrant-visa-b-for-business-and-work', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I do paid work on a Business visit?', 'No — even a Non-Immigrant "B" visa never authorizes paid work by itself; that requires a separate work permit.', 98, 2, 1073, 1),
('Do short business trips need a visa at all?', 'Often no — short trips typically fall under the same visa-exemption window as tourism, subject to the same reduced duration from 15 September 2026.', 98, 2, 1074, 1),
('What does a Non-Immigrant "B" require from my Thai host?', 'An invitation letter plus their corporate documents (affidavit, shareholder list, financials).', 98, 2, 1075, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Non-Immigrant Visa "ED"
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    98, 3, 'THA-STU-IN-03', '2026.09', 'published',
    'Full-time study, internship, or training at a Thai educational institution.',
    'A Non-Immigrant Visa "ED" is mandatory — visa-exemption does not cover study. Requires a formal acceptance letter from a recognized Thai institution and proof of at least 50% (often full) tuition payment. Holders must report their address to immigration every 90 days.',
    'Issued for 90 days initially, then extendable in-country up to 1 year at a time',
    'Non-Immigrant Visa "ED" via a Thai Embassy/Consulate, India (New Delhi, Mumbai, Chennai)',
    1,
    'Extensions are handled in-country at a Thai immigration office, alongside mandatory 90-day address reporting',
    'Royal Thai Embassy/Consulate (New Delhi, Mumbai, Chennai)',
    'Secure formal acceptance from a recognized Thai educational institution\nPay at least 50% of tuition (often full payment required)\nGather documents against this checklist\nSubmit your Non-Immigrant "ED" application at the embassy/consulate\nAfter arrival: extend in-country annually and report your address every 90 days',
    '/assets/images/visa-heroes/thailand.jpg',
    'Royal Thai Embassy Non-Immigrant Visa ED (Education) guidance', 'https://www.thaiembassy.at/en/type-of-visa/non-immigrant-visa-ed-education.html', '2026-09-11'
);
SET @tt3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tt3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tt3, 'Core Documents', 'Every applicant needs these.', 1);
SET @tt3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tt3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@tt3s1, 'Formal Acceptance Letter', 'From a recognized Thai educational institution.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tt3, 'Financial Documents', 'Evidence you can fund your studies.', 2);
SET @tt3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tt3s2, 'Tuition Payment Proof', 'At least 50%, often full payment.', 'copy', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tt3, 'Post-Arrival Documents', 'Ongoing compliance requirements.', 3);
SET @tt3s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tt3s3, '90-Day Address Report', 'Mandatory ongoing reporting to Thai immigration.', 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(98, 3, 2000.00, 'THB', 'Non-Immigrant Visa "ED" Fee (Indicative)', 'Fee tracks the general Non-Immigrant single-entry rate; confirm the exact current figure with the embassy/consulate handling your application.', '2026-09-01', NOW(), 'https://www.thaiembassy.at/en/type-of-visa/non-immigrant-visa-ed-education.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does visa-exemption cover studying in Thailand?', 'No — full-time study, internships, or training require a Non-Immigrant Visa "ED", regardless of the length of your program.', 98, 3, 1076, 1),
('How much tuition must I pay before applying?', 'At least 50% of tuition, with many institutions requiring full payment before issuing your acceptance letter.', 98, 3, 1077, 1),
('Do I need to report to immigration regularly?', 'Yes — a mandatory address report every 90 days for the duration of your stay.', 98, 3, 1078, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Non-Immigrant "B" + Work Permit (Two-Step)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    98, 4, 'THA-WORK-IN-04', '2026.09', 'published',
    'Employer-sponsored employment in Thailand, via a genuine two-step visa-then-permit process.',
    'Step 1: Non-Immigrant "B" visa from the embassy, usually preceded by the employer''s WP.3 pre-approval from the Ministry of Labour (1-3 weeks; employer generally needs THB 2 million registered capital and 4 Thai staff per foreign hire). Step 2: after arrival, within 90 days, the employer applies for the actual Work Permit through the mandatory digital e-workpermit.doe.go.th system (online-only since 13 October 2025). The visa alone is legal presence, not legal employment.',
    'Tied to the employment contract; visa and Work Permit renewed together',
    'Employer obtains WP.3 pre-approval; employee applies for Non-Immigrant "B"; employer then applies for the digital Work Permit after arrival',
    1,
    'Holding the visa without the Work Permit means legal presence but illegal employment — both steps are mandatory',
    'Royal Thai Embassy/Consulate, India, for the visa; e-workpermit.doe.go.th for the Work Permit after arrival',
    'Employer obtains WP.3 pre-approval from the Ministry of Labour\nGather documents against this checklist and apply for Non-Immigrant "B" at the embassy\nTravel to Thailand on the Non-Immigrant "B" visa\nEmployer applies for your Work Permit via e-workpermit.doe.go.th within 90 days of arrival\nBoth visa and Work Permit must be renewed together going forward',
    '/assets/images/visa-heroes/thailand.jpg',
    'Thai Ministry of Labour digital Work Permit system (e-workpermit.doe.go.th) and Non-Immigrant Visa B guidance', 'https://demarches-thailande.com/en/visa-thailande/work', '2026-09-11'
);
SET @tt4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tt4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tt4, 'Core Documents', 'Every applicant needs these.', 1);
SET @tt4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tt4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@tt4s1, 'WP.3 Pre-Approval', 'From the Ministry of Labour, obtained by your employer.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tt4, 'Employer Documents', 'Evidence of your sponsoring company.', 2);
SET @tt4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tt4s2, 'Employment Contract', NULL, 'copy', 1, 0, 1, 1),
(@tt4s2, 'Employer''s Registered Capital & Staffing Evidence', 'THB 2 million capital and 4 Thai staff per foreign hire, generally required.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tt4, 'Post-Arrival Documents', 'Required within 90 days of arrival.', 3);
SET @tt4s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tt4s3, 'Digital Work Permit Application', 'Via e-workpermit.doe.go.th, mandatory online since 13 October 2025.', 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(98, 4, 2000.00, 'THB', 'Non-Immigrant Visa "B" Fee', 'THB 2,000 single-entry visa fee; the separate Work Permit fee (via e-workpermit.doe.go.th) is paid after arrival and typically arranged by the employer.', '2026-09-01', NOW(), 'https://demarches-thailande.com/en/visa-thailande/work', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Non-Immigrant "B" visa enough to work legally in Thailand?', 'No — it only grants legal presence. A separate Work Permit application via e-workpermit.doe.go.th, filed within 90 days of arrival, is required for legal employment.', 98, 4, 1079, 1),
('What is WP.3 pre-approval?', 'A Ministry of Labour pre-approval your employer typically obtains before you apply for the Non-Immigrant "B" visa, taking roughly 1-3 weeks.', 98, 4, 1080, 1),
('Is the Work Permit process still paper-based?', 'No — since 13 October 2025, Work Permit applications must go through the fully digital e-workpermit.doe.go.th system.', 98, 4, 1081, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Visa Exemption / Non-Immigrant "O"
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    98, 5, 'THA-FAM-IN-05', '2026.09', 'published',
    'Visiting or living with family in Thailand.',
    'Short visits are covered by the same visa-exemption as tourism (30 days from 15 September 2026, extendable to 60). For longer stays living with a Thai family member, a Non-Immigrant Visa "O" is required — available to spouses of Thai nationals, parents of Thai children, and dependents of certain visa holders.',
    'Exempt stays: 30-60 days depending on entry date. Non-Immigrant "O": 90 days initially, extended annually',
    'No visa needed for exempt short visits (TDAC required); Non-Immigrant "O" via embassy/consulate for longer stays',
    0,
    'Spouse-of-Thai cases are commonly assessed against a roughly THB 400,000 financial benchmark',
    'Royal Thai Embassy/Consulate, India, for Non-Immigrant "O" applications',
    'Confirm whether visa-exemption covers your visit length\nComplete your TDAC online within 72 hours of arrival\nIf living with family longer-term: gather relationship proof and financial evidence\nSubmit your Non-Immigrant "O" application if required\nAfter arrival: extend annually at a Thai immigration office',
    '/assets/images/visa-heroes/thailand.jpg',
    'Thai Ministry of Foreign Affairs Non-Immigrant Visa O (family/spouse) guidance', 'https://emerhub.com/thailand/visas/non-immigrant-o/', '2026-09-11'
);
SET @tt5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tt5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tt5, 'Core Documents', 'Every applicant needs these.', 1);
SET @tt5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tt5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@tt5s1, 'TDAC Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tt5, 'Non-Immigrant "O" Documents (For Longer Stays)', 'If visa-exemption does not cover your stay.', 2);
SET @tt5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tt5s2, 'Relationship Proof', 'Marriage certificate or child''s Thai birth certificate.', 'copy', 0, 1, 1, 1),
(@tt5s2, 'Financial Evidence', 'Commonly assessed against a THB 400,000 benchmark for spouse-of-Thai cases.', 'copy', 0, 1, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tt5, 'Application Documents', 'Your formal application.', 3);
SET @tt5s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tt5s3, 'Completed Application Form', NULL, 'original', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(98, 5, 2000.00, 'THB', 'Non-Immigrant Visa "O" Fee (Single-Entry)', 'THB 2,000 for a single-entry Non-Immigrant "O" visa; not needed if your visit qualifies for visa-exemption.', '2026-09-01', NOW(), 'https://emerhub.com/thailand/visas/non-immigrant-o/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does visa-exemption cover living with family long-term?', 'No — visa-exemption only covers short visits (30-60 days depending on entry date); living with a Thai family member long-term requires a Non-Immigrant Visa "O".', 98, 5, 1082, 1),
('What financial benchmark applies to spouse-of-Thai cases?', 'Commonly a roughly THB 400,000 financial benchmark, though this can vary by embassy/consulate.', 98, 5, 1083, 1),
('How is the Non-Immigrant "O" visa extended?', 'Annually, at a Thai immigration office, once you are in Thailand.', 98, 5, 1084, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Airside Exemption / Dedicated Transit Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    98, 6, 'THA-TRANS-IN-06', '2026.09', 'published',
    'Passing through Thailand en route to a third country.',
    'Genuinely three different paths: passengers staying airside under roughly 12 hours with checked-through baggage and onward tickets need no visa and no TDAC; those clearing immigration to switch between Bangkok''s Suvarnabhumi and Don Mueang airports use the standard visa-exemption or e-visa; a dedicated Transit Visa (800 THB) exists for non-exempt nationalities or specific cases like sports-event participation transiting Thailand.',
    'Airside: no set limit under ~12 hours. Dedicated Transit Visa: 3-month validity, up to 30 days stay',
    'No application for short airside stays; standard exemption/e-visa for airport-switching; dedicated Transit Visa for other cases',
    0,
    'Confirm your specific routing and circumstances before assuming which path applies',
    'Royal Thai Embassy/Consulate, India, for the dedicated Transit Visa',
    'Confirm whether your layover qualifies for the airside exemption\nIf switching airports, use the standard visa-exemption or e-visa\nIf neither applies (e.g. sports-event transit), apply for the dedicated Transit Visa\nGather documents against this checklist\nDecision once processed if a visa application was needed',
    '/assets/images/visa-heroes/thailand.jpg',
    'Royal Thai Embassy transit visa (participation in sports events/competitions) and general transit guidance', 'https://amman.thaiembassy.org/en/publicservice/109366-transit-visa-participation-in-sports-events-competitions', '2026-09-11'
);
SET @tt6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tt6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tt6, 'Core Documents', 'For eligible short airside connections.', 1);
SET @tt6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tt6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@tt6s1, 'Confirmed Onward Ticket with Checked-Through Baggage', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tt6, 'Dedicated Transit Visa Documents', 'If the airside exemption does not apply.', 2);
SET @tt6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tt6s2, 'Purpose-Specific Invitation', 'E.g. sports-event organizer invitation, where applicable.', 'original', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(98, 6, 800.00, 'THB', 'Dedicated Transit Visa Fee', 'THB 800, 3-month validity, up to 30 days stay. Not needed for short airside connections or airport-switching under visa-exemption/e-visa.', '2026-09-01', NOW(), 'https://amman.thaiembassy.org/en/publicservice/109366-transit-visa-participation-in-sports-events-competitions', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa for a short layover in Bangkok?', 'Not if you stay airside under roughly 12 hours with checked-through baggage and onward tickets — no visa or TDAC is needed for that scenario.', 98, 6, 1085, 1),
('What if I need to switch between Bangkok''s two airports?', 'You use the standard visa-exemption or e-visa, not a separate transit product, since you are clearing immigration.', 98, 6, 1086, 1),
('When would I need the dedicated Transit Visa?', 'For non-exempt nationalities, or specific cases like sports-event participation transiting through Thailand.', 98, 6, 1087, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Visa Exemption / Tourist Visa / Non-Immigrant "O"
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    98, 7, 'THA-MED-IN-07', '2026.09', 'published',
    'Travelling to Thailand for medical treatment.',
    'Thailand has no standalone short-stay medical tourist visa — most Indian medical travellers simply use visa-exemption or a Tourist Visa. The "O-A" Long Stay visa often marketed alongside medical tourism is actually structured for retirees aged 50+; genuinely extended treatment for younger patients is typically handled via a case-by-case Non-Immigrant "O" with a hospital appointment letter.',
    'Exempt/Tourist Visa stays: up to 60 days. Non-Immigrant "O" (case-by-case): 90 days initially, extendable',
    'No visa needed for exempt short treatment (TDAC required); Tourist Visa or case-by-case Non-Immigrant "O" for longer treatment',
    0,
    'Confirm which route applies to your specific treatment duration and age before assuming O-A applies',
    'Royal Thai Embassy/Consulate, India, for Non-Immigrant "O" cases',
    'Confirm whether visa-exemption or a Tourist Visa covers your treatment duration\nObtain a hospital appointment/treatment letter\nGather documents against this checklist\nIf treatment is genuinely extended, apply for a case-by-case Non-Immigrant "O"\nDecision once processed if a visa application was needed',
    '/assets/images/visa-heroes/thailand.jpg',
    'Thai medical-visa and Non-Immigrant O-A (Long Stay/Retirement) guidance, cross-checked against medical-tourism sourcing', 'https://www.thaiembassy.at/en/type-of-visa/non-immigrant-visa-o-a-long-stay-retirement-stay-visa-in-english.html', '2026-09-11'
);
SET @tt7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tt7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tt7, 'Core Documents', 'Every applicant needs these.', 1);
SET @tt7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tt7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@tt7s1, 'Hospital Appointment/Treatment Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tt7, 'Extended Treatment Documents (Non-Immigrant "O", Case-by-Case)', 'For genuinely extended treatment.', 2);
SET @tt7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tt7s2, 'Detailed Treatment Plan & Cost Estimate', NULL, 'copy', 0, 1, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tt7, 'Financial Documents', 'Evidence you can pay for treatment.', 3);
SET @tt7s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tt7s3, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(98, 7, NULL, 'THB', 'Confirmed After Assessment', 'Fee depends on whether visa-exemption, a Tourist Visa, or a case-by-case Non-Immigrant "O" applies to your treatment duration — confirmed once your treatment plan and age are known.', '2026-09-01', NOW(), 'https://www.thaiembassy.at/en/type-of-visa/non-immigrant-visa-o-a-long-stay-retirement-stay-visa-in-english.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the O-A visa Thailand''s medical tourism visa?', 'Not really — despite being marketed alongside medical tourism, O-A is actually structured for retirees aged 50+. Genuinely extended treatment for younger patients is handled case-by-case via Non-Immigrant "O".', 98, 7, 1088, 1),
('Do most Indian medical travellers need a special visa?', 'No — most simply use visa-exemption or a standard Tourist Visa for shorter treatment durations.', 98, 7, 1089, 1),
('What does the hospital letter need to cover?', 'Your appointment details and treatment plan, used to support whichever visa route applies to your case.', 98, 7, 1090, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Visa Exemption / Non-Immigrant "B"
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    98, 8, 'THA-CONF-IN-08', '2026.09', 'published',
    'Attending or presenting at a conference or seminar in Thailand.',
    'Short conference attendance is generally covered by the same visa-exemption as short business travel. For sponsored speakers or longer engagements, a Non-Immigrant Visa "B" applies, requiring an official Letter of Invitation from the event organizer specifying dates, venue, and the applicant''s role.',
    'Exempt stays: 30-60 days depending on entry date. Non-Immigrant "B": 3 months (single-entry) or 1 year (multiple-entry)',
    'No visa needed for exempt short attendance (TDAC required); Non-Immigrant "B" for sponsored speakers/longer engagements',
    0,
    'Confirm whether your specific engagement qualifies for visa-exemption before applying for Non-Immigrant "B"',
    'Royal Thai Embassy/Consulate, India, for Non-Immigrant "B" applications',
    'Confirm whether visa-exemption covers your conference attendance\nComplete your TDAC online within 72 hours of arrival\nIf sponsored/longer: obtain an official Letter of Invitation from the organizer\nGather documents against this checklist\nSubmit your Non-Immigrant "B" application if required',
    '/assets/images/visa-heroes/thailand.jpg',
    'Thai Ministry of Foreign Affairs Non-Immigrant Visa B (conference/business) guidance', 'https://www.mfa.go.th/en/publicservice/non-immigrant-visa-b-for-business-and-work', '2026-09-11'
);
SET @tt8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tt8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tt8, 'Core Documents', 'Every applicant needs these.', 1);
SET @tt8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tt8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@tt8s1, 'TDAC Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tt8, 'Non-Immigrant "B" Documents (Sponsored/Longer Engagements)', 'If visa-exemption does not cover your attendance.', 2);
SET @tt8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tt8s2, 'Official Letter of Invitation from Organizer', 'Specifying dates, venue, and your role.', 'original', 0, 1, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tt8, 'Financial Documents', 'Evidence of funds.', 3);
SET @tt8s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tt8s3, 'Bank Statements', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(98, 8, 2000.00, 'THB', 'Non-Immigrant Visa "B" Fee (Single-Entry)', 'Only applies if your conference attendance falls outside visa-exemption — THB 2,000 for single-entry.', '2026-09-01', NOW(), 'https://www.mfa.go.th/en/publicservice/non-immigrant-visa-b-for-business-and-work', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do short conference visits need a visa?', 'Often no — they typically fall under the same visa-exemption as short business travel.', 98, 8, 1091, 1),
('When is a Non-Immigrant "B" needed for a conference?', 'For sponsored speakers or longer engagements, requiring an official Letter of Invitation from the event organizer.', 98, 8, 1092, 1),
('What must the invitation letter specify?', 'The conference dates, venue, and your specific role at the event.', 98, 8, 1093, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Visa Exemption / Dedicated Transit-Sports Visa / Non-Immigrant "O"
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    98, 9, 'THA-SPORT-IN-09', '2026.09', 'published',
    'Competing in or coaching at a sports event in Thailand.',
    'Participants typically enter under standard visa-exemption or the dedicated sports-event Transit Visa, requiring an invitation from the host sports organization/association, cover letter, and travel/accommodation proof. Foreign coaches taking up longer roles must convert to Non-Immigrant "O" using Form TM.86.',
    'Exempt/Transit: matches your event dates. Non-Immigrant "O" (coaches): 90 days initially, extendable',
    'No visa needed for exempt short participation (TDAC required); dedicated Transit Visa or Non-Immigrant "O" for other cases',
    0,
    'Confirm whether your specific role (competitor vs longer-term coach) determines which route applies',
    'Royal Thai Embassy/Consulate, India, for Transit Visa or Non-Immigrant "O" applications',
    'Confirm whether visa-exemption covers your event participation\nObtain an invitation from the host sports organization/association\nGather documents against this checklist\nIf a longer-term coaching role, apply to convert to Non-Immigrant "O" via Form TM.86\nDecision once processed if a visa application was needed',
    '/assets/images/visa-heroes/thailand.jpg',
    'Royal Thai Embassy transit visa (participation in sports events/competitions) guidance', 'https://amman.thaiembassy.org/en/publicservice/109366-transit-visa-participation-in-sports-events-competitions', '2026-09-11'
);
SET @tt9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tt9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tt9, 'Core Documents', 'Every applicant needs these.', 1);
SET @tt9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tt9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@tt9s1, 'Invitation from Host Sports Organization', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tt9, 'Event Documents', 'Evidence of your specific engagement.', 2);
SET @tt9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tt9s2, 'Cover Letter & Travel/Accommodation Proof', NULL, 'copy', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tt9, 'Coach Conversion Documents (Longer-Term Roles Only)', 'For coaches taking longer-term positions.', 3);
SET @tt9s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tt9s3, 'Form TM.86 Conversion to Non-Immigrant "O"', NULL, 'original', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(98, 9, 800.00, 'THB', 'Sports-Event Transit Visa Fee (If Applicable)', 'THB 800 for the dedicated transit visa covering sports-event participation; not needed if your participation qualifies for visa-exemption instead.', '2026-09-01', NOW(), 'https://amman.thaiembassy.org/en/publicservice/109366-transit-visa-participation-in-sports-events-competitions', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What visa do most sports-event participants use?', 'Most enter under standard visa-exemption or the dedicated sports-event Transit Visa, with an invitation from the host sports organization.', 98, 9, 1094, 1),
('What if I am taking a longer-term coaching role?', 'Foreign coaches taking up longer roles must convert to Non-Immigrant "O" using Form TM.86.', 98, 9, 1095, 1),
('Does Thailand have one distinct "Sports Visa"?', 'Not exactly — it is handled via the sports-specific Transit Visa category or, for longer coaching roles, conversion to Non-Immigrant "O".', 98, 9, 1096, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Non-Immigrant "O"
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    98, 10, 'THA-DEP-IN-10', '2026.09', 'published',
    'Accompanying a spouse or parent who holds a principal Non-Immigrant visa in Thailand.',
    'Non-Immigrant Visa "O" covers spouses and children (under 20) of a principal Non-Immigrant visa holder — commonly a Non-Immigrant "B"/work-permit holder. Requires marriage/birth certificates and copies of the sponsor''s visa and work permit, plus financial evidence.',
    'Issued single-entry for 90 days, then extended annually alongside the principal visa holder''s status',
    'Non-Immigrant Visa "O" via a Thai Embassy/Consulate, India',
    1,
    'Extensions are handled in-country annually, alongside the principal visa holder''s own renewal',
    'Royal Thai Embassy/Consulate, India',
    'Confirm the principal Non-Immigrant visa holder''s status\nGather documents against this checklist, including relationship proof\nSubmit your Non-Immigrant "O" application at the embassy/consulate\nAfter arrival: extend annually alongside the principal visa holder',
    '/assets/images/visa-heroes/thailand.jpg',
    'Thai Ministry of Foreign Affairs Non-Immigrant Visa O (family/dependent) guidance', 'https://emerhub.com/thailand/visas/non-immigrant-o/', '2026-09-11'
);
SET @tt10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tt10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tt10, 'Core Documents', 'Every applicant needs these.', 1);
SET @tt10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tt10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@tt10s1, 'Principal Holder''s Visa & Work Permit Copies', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tt10, 'Relationship Documents', 'Evidence of your relationship to the principal holder.', 2);
SET @tt10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tt10s2, 'Marriage Certificate', 'For a spouse applicant.', 'copy', 0, 1, 1, 1),
(@tt10s2, 'Birth Certificate', 'For a child applicant under 20.', 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tt10, 'Financial Documents', 'Evidence of the principal''s support.', 3);
SET @tt10s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tt10s3, 'Principal Holder''s Financial Evidence', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(98, 10, 2000.00, 'THB', 'Non-Immigrant Visa "O" Fee (Single-Entry)', 'THB 2,000, the same as the general Non-Immigrant "O" single-entry rate.', '2026-09-01', NOW(), 'https://emerhub.com/thailand/visas/non-immigrant-o/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Who qualifies as a dependent under this visa?', 'The spouse and children under 20 of a principal Non-Immigrant visa holder, commonly a Non-Immigrant "B"/work-permit holder.', 98, 10, 1097, 1),
('Is the Dependent visa extended separately from the principal holder?', 'It is extended annually alongside the principal visa holder''s own status, not on a fully independent timeline.', 98, 10, 1098, 1),
('What documents prove the family relationship?', 'A marriage certificate for a spouse, or a birth certificate for a child under 20, plus copies of the principal holder''s visa and work permit.', 98, 10, 1099, 1);
