-- Malaysia Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search, same standard as every other
-- country built this session (see AUDIT.md). hero_image_url points at
-- the real Kuala Lumpur skyline/Petronas Towers photo supplied by the
-- client for this hero.
--
-- Malaysia's real, distinctive facts:
--   - A real, dated visa-free policy: since November 2023, Indian
--     nationals get visa-free entry for stays up to 30 days, extended
--     through 31 December 2026 — covering tourism, business meetings,
--     and social/family visits, but explicitly EXCLUDING work and
--     study, stated honestly rather than assumed to cover everything.
--   - A genuinely universal requirement layered on top: every arriving
--     traveller, regardless of visa-free/eVISA/eNTRI status, must
--     submit the free MDAC (Malaysia Digital Arrival Card) online 3
--     days before arrival.
--   - Two real paid fallback products exist for cases outside the
--     30-day visa-free window: eNTRI (RM20, max 15 days, KLIA/KLIA2
--     entry only, restricted return/transit routing) and eVISA (RM50
--     single-entry/RM100 multiple-entry + RM105 processing, up to 30
--     days, broader route eligibility) — genuinely different products,
--     not the same thing under two names.
--   - Conference and Sports genuinely share ONE real product — the
--     Professional Visit Pass (PVP) — which must be applied for by the
--     sponsoring organizer/body in Malaysia BEFORE entry; the
--     individual cannot self-apply. The PVP document checklist was
--     genuinely simplified from 13 to 6 items in August 2024, a real,
--     dated administrative change.
--   - Work (Employment Pass) carries real, tiered 2026 salary
--     categories (Category I ≥RM20,000/month, Category II
--     RM10,000-19,999, Category III RM5,000-9,999) with a genuine 2026
--     policy change: Category III holders can now sponsor dependents
--     for the first time, previously barred — stated as a real,
--     recent easing rather than assumed to have always been the case.
--   - Medical routes through the real Malaysia Healthcare Travel
--     Council (MHTC), with 2026 specifically designated "Malaysia Year
--     of Medical Tourism (MYMT) 2026," a genuine, current sector
--     initiative.
--
-- country_id 80 = Malaysia. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Visa-Free Entry / eNTRI / eVISA
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    80, 1, 'MYS-TOUR-IN-01', '2026.09', 'published',
    'Leisure travel, sightseeing, and short personal visits to Malaysia.',
    'Since November 2023, Indian nationals get visa-free entry for stays up to 30 days, extended through 31 December 2026 — most tourists need only the free MDAC (Malaysia Digital Arrival Card), submitted online 3 days before arrival. Paid eNTRI or eVISA products are fallback options outside these terms.',
    'Up to 30 days visa-free through 31 December 2026',
    'Free MDAC online submission (visa-free); or paid eNTRI/eVISA for cases outside the visa-free terms',
    0,
    'Biometrics (10 fingerprints + photo) are captured on arrival for all foreign nationals except children under 12, regardless of visa-free/eVISA/eNTRI status',
    'No in-person office visit required — MDAC is entirely online',
    'Submit your free MDAC online, 3 days before arrival\nGather documents against this checklist\nIf your stay exceeds 30 days, apply for the paid eNTRI or eVISA instead\nAttend biometric enrolment on arrival (all travellers except children under 12)\nProceed through immigration',
    '/assets/images/visa-heroes/malaysia.jpg',
    'Malaysian Immigration Department (imi.gov.my) visa-free entry and MDAC guidance for Indian nationals', 'https://www.imi.gov.my/index.php/en/main-services/entry-requirement-into-malaysia-en/', '2026-09-11'
);
SET @my1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@my1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@my1, 'Core Documents', 'Every traveller needs these.', 1);
SET @my1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@my1s1, 'Valid Passport', 'Valid at least 6 months.', 'original', 1, 0, 1, 1),
(@my1s1, 'MDAC (Malaysia Digital Arrival Card)', 'Free, mandatory online submission within 3 days before arrival.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@my1, 'Financial & Travel Documents', 'Evidence of funds and onward travel.', 2);
SET @my1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@my1s2, 'Return/Onward Ticket', NULL, 'copy', 1, 0, 1, 1),
(@my1s2, 'Proof of Funds', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@my1, 'Paid Fallback Documents (If Outside Visa-Free Terms)', 'For eNTRI or eVISA.', 3);
SET @my1s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@my1s3, 'eNTRI or eVISA Application', NULL, 'original', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(80, 1, 0.00, 'MYR', 'No Fee (Visa-Free Entry + Free MDAC)', 'Visa-free entry and the MDAC are both free through 31 December 2026. If outside these terms: eNTRI RM20 (max 15 days) or eVISA RM50/100 + RM105 processing (up to 30 days).', '2026-09-01', NOW(), 'https://www.imi.gov.my/index.php/en/main-services/entry-requirement-into-malaysia-en/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for short visits to Malaysia?', 'No, through 31 December 2026 — visa-free entry for stays up to 30 days is available, covering tourism, business meetings, and social/family visits (but not work or study).', 80, 1, 1310, 1),
('Is the MDAC mandatory even for visa-free travellers?', 'Yes — every traveller, regardless of visa status, must submit the free MDAC online within 3 days before arrival.', 80, 1, 1311, 1),
('What is the difference between eNTRI and eVISA?', 'eNTRI (RM20) allows up to 15 days via KLIA/KLIA2 only with restricted return/transit routing; eVISA (RM50/100 + RM105) allows up to 30 days with broader route eligibility — genuinely different products used when the visa-free terms don''t apply.', 80, 1, 1312, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Visa-Free Entry / eVISA (Business)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    80, 2, 'MYS-BUS-IN-02', '2026.09', 'published',
    'Short business visits — meetings and negotiations — to Malaysia.',
    'Short business visits up to 30 days fall under the same visa-free allowance as tourism. Beyond that, the eVISA business category requires an invitation/sponsorship letter from the Malaysian host company plus a covering letter from the Indian company. No separate "Business Pass" exists for short trips.',
    'Up to 30 days visa-free; eVISA extends to 30 days for cases outside visa-free terms',
    'Free MDAC (visa-free); or eVISA (business category) for longer/specific engagements',
    0,
    'Longer or more complex engagements route through a Visa With Reference (VDR) sponsored by the Malaysian entity',
    'No in-person office visit required',
    'Confirm whether visa-free entry (with MDAC) covers your trip\nIf not, obtain an invitation/sponsorship letter from your Malaysian host company\nGather documents against this checklist\nApply for the eVISA (business category) if required\nSubmit your MDAC before arrival',
    '/assets/images/visa-heroes/malaysia.jpg',
    'Malaysian Immigration Department eVISA business category and VDR guidance', 'https://www.imi.gov.my/index.php/en/visa-with-reference/', '2026-09-11'
);
SET @my2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@my2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@my2, 'Core Documents', 'Every applicant needs these.', 1);
SET @my2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@my2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@my2s1, 'MDAC', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@my2, 'Business Invitation Documents (If Outside Visa-Free Terms)', 'For the eVISA business route.', 2);
SET @my2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@my2s2, 'Invitation/Sponsorship Letter from Malaysian Company', NULL, 'original', 0, 1, 1, 1),
(@my2s2, 'Covering Letter from Indian Company', NULL, 'original', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@my2, 'Financial Documents', 'Evidence of funds.', 3);
SET @my2s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@my2s3, 'Bank Statements', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(80, 2, 155.00, 'MYR', 'eVISA Fee (If Applicable)', 'No fee for visa-free entry; if the eVISA is needed, RM50 (single-entry) or RM100 (multiple-entry) plus RM105 processing (roughly RM155-205 total).', '2026-09-01', NOW(), 'https://www.imi.gov.my/index.php/en/visa-with-reference/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Business Pass for short trips?', 'No — short business visits up to 30 days simply use the same visa-free allowance as tourism, with the eVISA business category as a fallback for longer/specific engagements.', 80, 2, 1313, 1),
('What is a VDR?', 'A Visa With Reference, used for longer or more complex business engagements, sponsored by the Malaysian entity.', 80, 2, 1314, 1),
('Can I do meetings and negotiations without a visa?', 'Yes, for up to 30 days, under the same visa-free entry as tourism, with the free MDAC.', 80, 2, 1315, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Student Pass (via EMGS)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    80, 3, 'MYS-STU-IN-03', '2026.09', 'published',
    'Full-time study at a Malaysian educational institution — NOT covered by visa-free entry.',
    'The Malaysian institution (once offer and deposit are paid) lodges the application with EMGS (Education Malaysia Global Services), which issues an electronic Visa Approval Letter (eVAL), typically in 4-6 weeks. The student then obtains a Single-Entry Visa (SEV) using the eVAL before travel.',
    'Duration of your study program',
    'Institution-lodged with EMGS; student then applies for a Single-Entry Visa using the eVAL',
    1,
    'Mandatory arrival medical screening (X-ray + blood test) at an EMGS-registered clinic within 7 working days; EMGS reports a roughly 90% approval rate',
    'Malaysian Embassy/Consulate/VFS Global, India, for the Single-Entry Visa',
    'Secure admission and pay the required deposit\nInstitution lodges your application with EMGS, receiving your eVAL (4-6 weeks)\nApply for your Single-Entry Visa (SEV) using the eVAL before travel\nAfter arrival: complete mandatory medical screening within 7 working days\nInstitution submits your passport to Immigration for the Student Pass sticker (2-4 more weeks)',
    '/assets/images/visa-heroes/malaysia.jpg',
    'Education Malaysia Global Services (EMGS) Student Pass guidance', 'https://visa.educationmalaysia.gov.my/graduate-pass', '2026-09-11'
);
SET @my3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@my3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@my3, 'Core Documents', 'Every applicant needs these.', 1);
SET @my3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@my3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@my3s1, 'eVAL (Electronic Visa Approval Letter)', 'From EMGS, via your institution.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@my3, 'Academic & Financial Documents', 'Evidence of your admission and funds.', 2);
SET @my3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@my3s2, 'Admission Offer & Deposit Payment Proof', NULL, 'copy', 1, 0, 1, 1),
(@my3s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@my3, 'Post-Arrival Documents', 'Required after arrival.', 3);
SET @my3s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@my3s3, 'Medical Screening Result (X-Ray + Blood Test)', 'At an EMGS-registered clinic, within 7 working days of arrival.', 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(80, 3, 67000.00, 'INR', 'Total Indicative Student Visa Budget', 'Total budget for the full Indian-student process (EMGS lodging, eVAL, SEV, medical screening, Student Pass sticker) runs roughly INR 67,000.', '2026-09-01', NOW(), 'https://visa.educationmalaysia.gov.my/graduate-pass', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does visa-free entry cover studying in Malaysia?', 'No — Student Pass is explicitly excluded from visa-free entry and must go through the full EMGS-lodged process.', 80, 3, 1316, 1),
('What is the eVAL?', 'An electronic Visa Approval Letter issued by EMGS (Education Malaysia Global Services) after your institution lodges your application — typically issued within 4-6 weeks.', 80, 3, 1317, 1),
('Is medical screening required after arrival?', 'Yes — a mandatory X-ray and blood test at an EMGS-registered clinic, within 7 working days of arrival, before your Student Pass sticker is issued.', 80, 3, 1318, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Employment Pass (EP)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    80, 4, 'MYS-WORK-IN-04', '2026.09', 'published',
    'Employer-sponsored employment in Malaysia — NOT covered by visa-free entry.',
    'Requires Malaysian employer sponsorship approved via the Expatriate Services Division (ESD). Three real, tiered salary categories apply as of the 1 June 2026 revision: Category I ≥RM20,000/month, Category II RM10,000-19,999, Category III RM5,000-9,999 (RM7,000-9,999 in manufacturing).',
    'Cumulative duration capped at 10 years for Categories I/II, 5 years for Category III',
    'Employer-sponsored via the ESD (Expatriate Services Division)',
    1,
    'Employers hiring Category II/III staff face additional documentation requirements',
    'Malaysian Embassy/Consulate/VFS Global, India',
    'Employer applies for your Employment Pass via the ESD\nGather documents against this checklist\nSubmit your application and attend biometrics\nDecision once processed\nAfter arrival: complete pass collection and any remaining formalities',
    '/assets/images/visa-heroes/malaysia.jpg',
    'ESD (Expatriate Services Division) Employment Pass fee table and 2026 salary category guidance', 'https://esd.imi.gov.my/portal/expatriates/myxpats/key-services/employment-pass/', '2026-09-11'
);
SET @my4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@my4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@my4, 'Core Documents', 'Every applicant needs these.', 1);
SET @my4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@my4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@my4s1, 'ESD Approval Reference', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@my4, 'Employer Sponsorship Documents', 'Evidence of your role and salary category.', 2);
SET @my4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@my4s2, 'Employment Contract', 'Confirming your salary category (I, II, or III).', 'copy', 1, 0, 1, 1),
(@my4s2, 'Local Succession Plan', 'Required for Category II/III hires.', 'copy', 0, 1, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@my4, 'Qualification Documents', 'Evidence you meet the role''s requirements.', 3);
SET @my4s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@my4s3, 'Educational Credentials & Resume', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(80, 4, 848.00, 'MYR', 'EP Application Fee', 'RM800 (RM848 with 6% SST), plus a separate employer-paid annual foreign-worker levy.', '2026-06-01', NOW(), 'https://esd.imi.gov.my/portal/expatriates/myxpats/key-services/employment-pass/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What are the 2026 Employment Pass salary categories?', 'Category I: RM20,000+/month; Category II: RM10,000-19,999/month; Category III: RM5,000-9,999/month (RM7,000-9,999 in manufacturing) — effective from the 1 June 2026 revision.', 80, 4, 1319, 1),
('How long can I hold an Employment Pass?', 'Cumulative duration is capped at 10 years for Categories I/II, and 5 years for Category III.', 80, 4, 1320, 1),
('Can Category III holders bring dependents?', 'Yes — as of the 1 June 2026 policy, Category III holders can now sponsor dependents for the first time, previously barred entirely.', 80, 4, 1321, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Visa-Free Entry / Social Visit Pass
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    80, 5, 'MYS-FAM-IN-05', '2026.09', 'published',
    'Visiting family members in Malaysia.',
    'Not a distinct product — falls under the general visit framework. Short visits (up to 30 days) use the same visa-free allowance as tourism. Longer or specific-purpose visits use a Social Visit Pass via eVISA, or for extended stays, a sponsor-backed Long-Term Social Visit Pass (LTSVP).',
    'Up to 30 days visa-free; LTSVP for extended sponsor-backed stays',
    'Free MDAC (visa-free); eVISA (social visit category) or LTSVP for longer stays',
    0,
    'LTSVP requires proof of relationship, sponsor ID/address proof, and an invitation letter',
    'No in-person office visit required for visa-free; Malaysian Embassy/Consulate for LTSVP',
    'Confirm whether visa-free entry (with MDAC) covers your visit\nIf not, obtain relationship proof and your Malaysian sponsor''s ID/address proof\nGather documents against this checklist\nApply for the eVISA (social visit) or LTSVP as applicable\nSubmit your MDAC before arrival',
    '/assets/images/visa-heroes/malaysia.jpg',
    'Malaysian Immigration Department Social Visit Pass and LTSVP guidance', 'https://www.imi.gov.my/index.php/en/main-services/entry-requirement-into-malaysia-en/', '2026-09-11'
);
SET @my5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@my5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@my5, 'Core Documents', 'Every applicant needs these.', 1);
SET @my5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@my5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@my5s1, 'MDAC', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@my5, 'LTSVP Documents (For Extended Stays)', 'For sponsor-backed longer visits.', 2);
SET @my5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@my5s2, 'Relationship Proof', NULL, 'copy', 0, 1, 1, 1),
(@my5s2, 'Sponsor''s ID/Address Proof & Invitation Letter', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@my5, 'Application Documents', 'Your formal application.', 3);
SET @my5s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@my5s3, 'Completed eVISA/LTSVP Application', NULL, 'original', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(80, 5, 0.00, 'MYR', 'No Fee (Visa-Free Entry)', 'Free for visits up to 30 days under visa-free entry; eVISA/LTSVP fees apply for longer stays and are confirmed once your specific case is known.', '2026-09-01', NOW(), 'https://www.imi.gov.my/index.php/en/main-services/entry-requirement-into-malaysia-en/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a distinct Family Visit product for Malaysia?', 'No — short family visits simply use the same visa-free allowance as tourism; longer stays use a Social Visit Pass or sponsor-backed LTSVP.', 80, 5, 1322, 1),
('What is the LTSVP?', 'A Long-Term Social Visit Pass for extended family visits, requiring sponsor-backed relationship proof, ID/address proof, and an invitation letter.', 80, 5, 1323, 1),
('Do I need my host''s documents for a short visit?', 'Not for visa-free visits up to 30 days — those documents are only needed for the longer LTSVP route.', 80, 5, 1324, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Visa-Free Transit / Transit Pass
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    80, 6, 'MYS-TRANS-IN-06', '2026.09', 'published',
    'Passing through KLIA/KLIA2 en route to a third country.',
    'Indian travellers transiting through KLIA/KLIA2 with a confirmed onward ticket can transit visa-free for up to 120 hours (5 days) without leaving the transit area. Those needing to clear immigration (e.g. exiting the airport) may apply for a Transit Pass, issued only at KLIA.',
    'Up to 120 hours (5 days) visa-free within the transit area',
    'No application needed for eligible transit; Transit Pass issued at KLIA for those clearing immigration',
    0,
    'Travellers departing/arriving via the Low-Cost Carrier Terminal must hold a valid visa or Transit Pass regardless of layover length',
    'Transit Pass counter, KLIA',
    'Confirm your connection stays within the transit area for up to 120 hours\nEnsure you hold a confirmed onward ticket\nIf you need to clear immigration, apply for a Transit Pass at KLIA\nProceed through the transit zone if eligible',
    '/assets/images/visa-heroes/malaysia.jpg',
    'Malaysian Immigration Department Transit Pass guidance', 'https://www.imi.gov.my/index.php/en/main-services/entry-requirement-into-malaysia-en/', '2026-09-11'
);
SET @my6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@my6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@my6, 'Core Documents', 'Every applicant needs these.', 1);
SET @my6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@my6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@my6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@my6, 'Transit Pass Documents', 'If clearing immigration.', 2);
SET @my6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@my6s2, 'Transit Pass Application (KLIA)', NULL, 'original', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(80, 6, 0.00, 'MYR', 'No Fee for Eligible Transit', 'Free for up to 120 hours (5 days) within the transit area. Travellers via the Low-Cost Carrier Terminal must hold a valid visa or Transit Pass regardless of layover length.', '2026-09-01', NOW(), 'https://www.imi.gov.my/index.php/en/main-services/entry-requirement-into-malaysia-en/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How long can I transit visa-free through Malaysia?', 'Up to 120 hours (5 days) without leaving the transit area, with a confirmed onward ticket.', 80, 6, 1325, 1),
('When do I need a Transit Pass?', 'When you need to clear immigration to exit the airport — the Transit Pass is issued only at KLIA.', 80, 6, 1326, 1),
('Does the Low-Cost Carrier Terminal have different rules?', 'Yes — travellers departing/arriving via that terminal must hold a valid visa or Transit Pass regardless of layover length.', 80, 6, 1327, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — MHTC-Facilitated Medical Visit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    80, 7, 'MYS-MED-IN-07', '2026.09', 'published',
    'Travelling to Malaysia to receive medical treatment.',
    'No fixed "medical visa" fee is published by imi.gov.my — the process runs through the Malaysia Healthcare Travel Council (MHTC). The patient secures treatment confirmation from an MHTC-registered hospital, which issues the invitation/entry-approval letter, covering the patient plus up to 2 companions, for an initial 30-day stay.',
    'Initial 30 days, extendable with hospital confirmation of continued treatment need',
    'MHTC-facilitated, arranged through the treating MHTC-registered hospital',
    0,
    '2026 is designated "Malaysia Year of Medical Tourism (MYMT) 2026," a current sector initiative',
    'Arranged through your treating MHTC-registered hospital',
    'Secure treatment confirmation from an MHTC-registered hospital\nHospital issues your invitation/entry-approval letter to MHTC\nGather documents against this checklist, including for up to 2 companions\nReceive your approval before travel\nExtend with hospital confirmation if treatment continues beyond 30 days',
    '/assets/images/visa-heroes/malaysia.jpg',
    'Malaysia Healthcare Travel Council (MHTC) medical visa guidance', 'https://www.mhtc.org.my/', '2026-09-11'
);
SET @my7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@my7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@my7, 'Core Documents', 'Every applicant needs these.', 1);
SET @my7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@my7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@my7s1, 'MHTC Hospital Invitation/Entry-Approval Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@my7, 'Companion Documents (Up to 2)', 'For accompanying family/friends.', 2);
SET @my7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@my7s2, 'Companion Passport Copies', 'Covered by the same MHTC invitation, up to 2 companions.', 'copy', 0, 1, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@my7, 'Financial Documents', 'Evidence you can pay for treatment.', 3);
SET @my7s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@my7s3, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(80, 7, NULL, 'MYR', 'Confirmed After Assessment', 'No fixed fee is published — the process runs through MHTC and the treating hospital, confirmed once your treatment plan is known.', '2026-09-01', NOW(), 'https://www.mhtc.org.my/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How many companions can accompany me?', 'Up to 2, covered by the same MHTC hospital invitation as the patient.', 80, 7, 1328, 1),
('What is MHTC?', 'The Malaysia Healthcare Travel Council, which facilitates the medical visit process by coordinating with MHTC-registered hospitals to issue invitation/entry-approval letters.', 80, 7, 1329, 1),
('What is significant about 2026 for medical tourism in Malaysia?', '2026 is designated "Malaysia Year of Medical Tourism (MYMT) 2026," a current MHTC sector initiative.', 80, 7, 1330, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Professional Visit Pass (PVP)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    80, 8, 'MYS-CONF-IN-08', '2026.09', 'published',
    'Attending or presenting at a conference or seminar in Malaysia.',
    'Routes through the Professional Visit Pass (PVP), issued by Immigration for meetings, seminar/conference attendance, and exhibitions. Must be applied for by the sponsoring organizer/body in Malaysia BEFORE entry — the individual cannot self-apply. The PVP checklist was simplified from 13 to 6 items in August 2024.',
    'Up to 12 months validity',
    'PVP application, submitted by the sponsoring organizer/body in Malaysia before your entry',
    0,
    'Processing typically runs 7-14 working days',
    'Malaysian Immigration Department, via your sponsoring organizer',
    'Confirm your conference organizer will sponsor your Professional Visit Pass\nGather documents against this checklist for the sponsor to submit\nOrganizer applies for the PVP before your entry\nDecision once processed\nPresent your PVP with your passport on arrival',
    '/assets/images/visa-heroes/malaysia.jpg',
    'Malaysian Immigration Department Professional Visit Pass guidance', 'https://www.imi.gov.my/index.php/en/main-services/pass/professional-visitor-pass/', '2026-09-11'
);
SET @my8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@my8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@my8, 'Core Documents', 'Every applicant needs these.', 1);
SET @my8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@my8s1, 'Passport Copy', NULL, 'copy', 1, 0, 1, 1),
(@my8s1, 'Sponsor Application Letter', 'From your conference organizer.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@my8, 'Event Documents', 'Evidence of the event and your role.', 2);
SET @my8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@my8s2, 'Award/Contract Letter', NULL, 'copy', 1, 0, 1, 1),
(@my8s2, 'MoU (Where Applicable)', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@my8, 'Bond Documents', 'Where required by the sponsor.', 3);
SET @my8s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@my8s3, 'Bond', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(80, 8, NULL, 'MYR', 'Confirmed After Assessment', 'PVP fee is arranged through the sponsoring organizer — confirmed once your specific conference/sponsor details are known.', '2026-09-01', NOW(), 'https://www.imi.gov.my/index.php/en/main-services/pass/professional-visitor-pass/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I apply for the PVP myself?', 'No — it must be applied for by the sponsoring organizer/body in Malaysia before your entry; you cannot self-apply.', 80, 8, 1331, 1),
('Did the PVP documentation get simpler recently?', 'Yes — in August 2024, the checklist was simplified from 13 to 6 items.', 80, 8, 1332, 1),
('How long is the PVP valid?', 'Up to 12 months.', 80, 8, 1333, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Professional Visit Pass (PVP)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    80, 9, 'MYS-SPORT-IN-09', '2026.09', 'published',
    'Competing in a sports event in Malaysia.',
    'Shares the same Professional Visit Pass (PVP) product as Conference — issued by Immigration for sport competitions as well as meetings and exhibitions. Must be applied for by the sponsoring organizer/body in Malaysia BEFORE entry.',
    'Up to 12 months validity',
    'PVP application, submitted by the sponsoring sports federation/organizer in Malaysia before your entry',
    0,
    'Processing typically runs 7-14 working days',
    'Malaysian Immigration Department, via your sponsoring organizer',
    'Confirm your sports federation/organizer will sponsor your Professional Visit Pass\nGather documents against this checklist for the sponsor to submit\nOrganizer applies for the PVP before your entry\nDecision once processed\nPresent your PVP with your passport on arrival',
    '/assets/images/visa-heroes/malaysia.jpg',
    'Malaysian Immigration Department Professional Visit Pass guidance (sports competitions)', 'https://www.imi.gov.my/index.php/en/main-services/pass/professional-visitor-pass/', '2026-09-11'
);
SET @my9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@my9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@my9, 'Core Documents', 'Every applicant needs these.', 1);
SET @my9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@my9s1, 'Passport Copy', NULL, 'copy', 1, 0, 1, 1),
(@my9s1, 'Sponsor Application Letter', 'From your sports federation/organizer.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@my9, 'Event Documents', 'Evidence of your participation.', 2);
SET @my9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@my9s2, 'Award/Contract Letter', NULL, 'copy', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@my9, 'Bond Documents', 'Where required by the sponsor.', 3);
SET @my9s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@my9s3, 'Bond', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(80, 9, NULL, 'MYR', 'Confirmed After Assessment', 'PVP fee is arranged through the sponsoring federation/organizer — confirmed once your specific event/sponsor details are known.', '2026-09-01', NOW(), 'https://www.imi.gov.my/index.php/en/main-services/pass/professional-visitor-pass/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Sports a separate visa product from Conference?', 'No — both share the same Professional Visit Pass (PVP), distinguished by the sponsor type and event documents.', 80, 9, 1334, 1),
('Who sponsors a Sports PVP?', 'The organizing sports federation or event body in Malaysia — you cannot self-apply.', 80, 9, 1335, 1),
('Does this cover exhibitions too?', 'The PVP also covers exhibitions, alongside meetings, conferences, and sport competitions.', 80, 9, 1336, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Dependent Pass (DP)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    80, 10, 'MYS-DEP-IN-10', '2026.09', 'published',
    'Joining a spouse or parent who holds a Malaysian Employment Pass.',
    'The Dependent Pass (DP) covers spouse/children (and, under 2026 rules, in some cases parents/parents-in-law) of an Employment Pass holder. As of 1 June 2026, DP eligibility was extended to EP Category III holders for the first time, previously excluded entirely.',
    'Matches the validity of the sponsor''s Employment Pass',
    'Sponsor (EP holder) obtains a Visa Approval Letter/VDR; dependents enter on a Single-Entry Visa, then get the DP sticker endorsed in Malaysia',
    1,
    'DP eligibility now extends to Category III EP holders, a real, recent 2026 policy change',
    'Malaysian Embassy/Consulate/VFS Global, India, for the Single-Entry Visa; DP endorsement completed in Malaysia',
    'Confirm your sponsor''s EP category is DP-eligible\nSponsor obtains your Visa Approval Letter/VDR\nGather documents against this checklist, including proof of legally registered marriage\nApply for your Single-Entry Visa using the VDR\nGet your DP sticker endorsed once in Malaysia',
    '/assets/images/visa-heroes/malaysia.jpg',
    'ESD Dependent Pass fee table and 2026 Category III eligibility extension guidance', 'https://esd.imi.gov.my/portal/pdf/payment-table-v13.pdf', '2026-09-11'
);
SET @my10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@my10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@my10, 'Core Documents', 'Every applicant needs these.', 1);
SET @my10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@my10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@my10s1, 'Sponsor''s Visa Approval Letter/VDR', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@my10, 'Relationship Documents', 'Evidence of your relationship to the sponsor.', 2);
SET @my10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@my10s2, 'Legally Registered Marriage Certificate', 'For a spouse applicant.', 'copy', 0, 1, 1, 1),
(@my10s2, 'Birth Certificate', 'For a child applicant.', 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@my10, 'Financial & Insurance Documents', 'Evidence of financial capacity and health insurance.', 3);
SET @my10s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@my10s3, 'Proof of Financial Capacity', NULL, 'copy', 1, 0, 0, 1),
(@my10s3, 'Dependent Health Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(80, 10, 477.00, 'MYR', 'Dependent Pass Fee', 'RM450 application (RM477 with SST), plus RM90/year endorsement and RM50 processing.', '2026-06-01', NOW(), 'https://esd.imi.gov.my/portal/pdf/payment-table-v13.pdf', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can all Employment Pass holders sponsor dependents?', 'As of 1 June 2026, yes — this was newly extended to Category III holders, previously excluded entirely.', 80, 10, 1337, 1),
('What does the DP fee include?', 'RM450 application (RM477 with SST), plus a separate RM90/year endorsement fee and RM50 processing fee.', 80, 10, 1338, 1),
('Can parents be sponsored as dependents?', 'Under 2026 rules, in some cases yes — parents/parents-in-law may be eligible, alongside the standard spouse/children categories.', 80, 10, 1339, 1);
