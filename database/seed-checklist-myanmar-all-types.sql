-- Myanmar Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search. hero_image_url left NULL at
-- authoring time, wired to the real supplied photo during the apply
-- step.
--
-- IMPORTANT SOURCING CAVEAT: Myanmar's eVisa portal and immigration
-- ministry sites were not directly fetchable this session (network
-- egress blocked) — findings triangulated from web-search-indexed news
-- and travel-advisory secondary sourcing.
--
-- Myanmar's real, distinctive facts — handled with explicit honesty
-- given the serious ongoing situation in the country:
--   - Myanmar has been in a civil war since the February 2021 military
--     coup, and the current US State Department travel advisory sits at
--     Level 4 ("Do Not Travel") — this file states that context plainly
--     rather than presenting Myanmar as a routine travel destination.
--   - The Visa-on-Arrival (VoA) for Indians was extended as a renewable
--     "trial" arrangement through August 2026 — described as a trial,
--     not a permanent settled policy, since sources characterize it
--     that way.
--   - The India-Myanmar land border Free Movement Regime (FMR), which
--     historically allowed limited border-area movement without a
--     visa, was SUSPENDED in February 2024 and is explicitly NOT a
--     viable visa-equivalent travel route anymore — this is stated
--     clearly to avoid anyone relying on outdated FMR information.
--   - Myanmar has no dedicated Sports or Dependent visa codes; both are
--     routed through the Business visa category in practice, per
--     sources found this session.
--
-- country_id 83 = Myanmar. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — eVisa / Visa on Arrival
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    83, 1, 'MMR-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Myanmar.',
    'Indian passport holders — eVisa or Visa-on-Arrival (VoA), the latter extended for Indians as a renewable trial arrangement through August 2026. IMPORTANT: Myanmar has been in a civil war since the February 2021 coup, and the current US State Department advisory is Level 4 ("Do Not Travel") — travel plans should account for this seriously before any visa logistics.',
    'Single entry, typically 28 days',
    'Apply online via the Myanmar eVisa portal in advance, or use Visa-on-Arrival at eligible entry points under the current trial arrangement',
    0,
    'The VoA trial for Indians runs through August 2026, described as renewable rather than settled — confirm before travel; the India-Myanmar land border Free Movement Regime was suspended Feb 2024 and is not a viable alternative',
    'Embassy of Myanmar, New Delhi, or eVisa portal',
    'Confirm current travel-advisory guidance given the ongoing civil conflict before finalizing any plans\nComplete the eVisa application online, or confirm Visa-on-Arrival eligibility at your entry point\nCarry a valid passport, photograph, and proof of onward travel\nComplete arrival formalities at the port of entry',
    '/assets/images/visa-heroes/myanmar.jpg',
    'Cross-checked against 2024-2026 civil-conflict and travel-advisory reporting, and VoA trial-extension news, triangulated against secondary sourcing not directly fetchable this session', 'https://evisa.moip.gov.mm/', '2026-09-11'
);
SET @mm1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mm1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mm1, 'Core Documents', 'Required from every applicant.', 1);
SET @mm1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mm1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mm1s1, 'Digital Passport-Style Photograph', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mm1, 'Supporting Documents', 'Evidence of your travel plans.', 2);
SET @mm1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mm1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 1),
(@mm1s2, 'Confirmed Hotel Booking', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(83, 1, NULL, 'INR', 'Confirmed After Assessment', 'Fee figures for the VoA trial arrangement were not consistently confirmed this session — contact us to confirm current figures, and please review current travel-advisory guidance before booking.', '2026-09-01', NOW(), 'https://evisa.moip.gov.mm/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is it currently safe to travel to Myanmar?', 'The current US State Department advisory for Myanmar is Level 4 ("Do Not Travel"), reflecting the ongoing civil conflict since the February 2021 coup. Please review current government travel advisories carefully before planning any trip.', 83, 1, 8300, 1),
('Can I still use the India-Myanmar land border to enter without a visa?', 'No — the Free Movement Regime that historically allowed limited visa-free border-area movement was suspended in February 2024 and is not a viable travel route anymore. A standard eVisa or Visa-on-Arrival is required.', 83, 1, 8301, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    83, 2, 'MMR-BUS-IN-02', '2026.09', 'published',
    'Trade, investment exploration, and commercial meetings in Myanmar.',
    'Indian nationals travelling for business, requiring the Business eVisa with a company invitation letter. As with all Myanmar travel, the current Level 4 ("Do Not Travel") advisory applies given the ongoing civil conflict.',
    'Single or multiple entry, typically up to 70 days',
    'Apply online via the Myanmar eVisa portal with a business invitation letter',
    1,
    'Review current travel-advisory guidance given the ongoing civil conflict before finalizing business travel plans',
    'Embassy of Myanmar, New Delhi, or eVisa portal',
    'Confirm current travel-advisory guidance before finalizing plans\nObtain an invitation letter from the Myanmar host company\nComplete the online eVisa application form\nCarry documents and complete arrival formalities at the port of entry',
    '/assets/images/visa-heroes/myanmar.jpg',
    'Cross-checked against Myanmar eVisa portal guidance and 2024-2026 civil-conflict/travel-advisory reporting, triangulated against secondary sourcing not directly fetchable this session', 'https://evisa.moip.gov.mm/', '2026-09-11'
);
SET @mm2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mm2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mm2, 'Core Documents', 'Required from every applicant.', 1);
SET @mm2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mm2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mm2s1, 'Invitation Letter from Myanmar Company', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mm2, 'Supporting Documents', 'Evidence of your employment/business standing.', 2);
SET @mm2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mm2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@mm2s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(83, 2, NULL, 'INR', 'Confirmed After Assessment', 'Fee not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://evisa.moip.gov.mm/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does the Business visa require anything beyond the standard eVisa process?', 'Yes — a company invitation letter from your Myanmar host business, in addition to the standard eVisa documentation.', 83, 2, 8302, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    83, 3, 'MMR-STU-IN-03', '2026.09', 'published',
    'Enrolling in a Myanmar educational institution — a comparatively rare travel direction given the current situation in the country.',
    'Indian nationals admitted to a recognized Myanmar institution, requiring a Student visa with institution sponsorship. Given the ongoing civil conflict and Level 4 advisory, this is a thinly-travelled and thinly-documented category.',
    'Tied to course duration, renewable',
    'Apply via the Embassy of Myanmar with the institution''s admission letter',
    1,
    'Limited public documentation found this session for this specific, lightly-travelled category given the current situation in the country — confirm current requirements directly with the Embassy',
    'Embassy of Myanmar, New Delhi',
    'Secure admission at a recognized Myanmar institution\nReview current travel-advisory guidance carefully given the ongoing civil conflict\nSubmit the visa application with admission proof and supporting documents at the Embassy',
    '/assets/images/visa-heroes/myanmar.jpg',
    'Limited secondary sourcing found this session given how uncommon this travel direction currently is; recommend direct confirmation with the Embassy', 'https://evisa.moip.gov.mm/', '2026-09-11'
);
SET @mm3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mm3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mm3, 'Core Documents', 'Required from every applicant.', 1);
SET @mm3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mm3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mm3s1, 'Admission Letter from Myanmar Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mm3, 'Supporting Documents', 'Evidence of your academic background and means.', 2);
SET @mm3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mm3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@mm3s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2),
(@mm3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(83, 3, NULL, 'INR', 'Confirmed After Assessment', 'Fee not confirmed this session for this rarely-travelled direction — contact us to confirm.', '2026-09-01', NOW(), 'https://evisa.moip.gov.mm/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is studying in Myanmar currently advisable given the situation there?', 'This is a genuinely difficult question given the ongoing civil conflict and the current Level 4 ("Do Not Travel") advisory. We strongly recommend reviewing current government travel guidance and consulting the institution and Embassy directly before proceeding.', 83, 3, 8303, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    83, 4, 'MMR-WORK-IN-04', '2026.09', 'published',
    'Employment with a Myanmar employer.',
    'Indian nationals with a confirmed job offer, requiring the Business visa (Myanmar does not maintain a fully separate Work visa code for most foreign staff; the Business visa is the standard route, converted to a work permit/stay permit after arrival).',
    'Tied to the employment contract, via work-permit/stay-permit renewal after arrival',
    'Apply for the Business visa, then employer processes local work-permit registration after arrival',
    1,
    'Given the ongoing civil conflict, employer operations and government processing capacity may be affected — confirm current conditions directly with your employer and the Embassy',
    'Embassy of Myanmar, New Delhi',
    'Review current travel-advisory guidance carefully before accepting employment in Myanmar\nObtain an employment contract and Business visa\nEmployer processes local work-permit/stay-permit registration after arrival',
    '/assets/images/visa-heroes/myanmar.jpg',
    'Limited secondary sourcing found this session; treated as a Business-visa use-case per standard Myanmar practice, triangulated against sources not directly fetchable this session', 'https://evisa.moip.gov.mm/', '2026-09-11'
);
SET @mm4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mm4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mm4, 'Core Documents', 'Required from every applicant.', 1);
SET @mm4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mm4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mm4s1, 'Employment Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mm4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @mm4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mm4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@mm4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(83, 4, NULL, 'INR', 'Confirmed After Assessment', 'Fee not consistently confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://evisa.moip.gov.mm/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a distinct Work Visa code for Myanmar?', 'No — most foreign employment uses the Business visa, converted to a local work/stay permit after arrival by the employer.', 83, 4, 8304, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    83, 5, 'MMR-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives resident in Myanmar.',
    'Covered under the same eVisa/VoA policy as Tourist entry — no distinct Family Visit visa product was confirmed this session. As with all Myanmar travel, the current Level 4 advisory applies.',
    'Single entry, typically 28 days, same as Tourist',
    'Same eVisa/VoA process as Tourist entry',
    0,
    'Review current travel-advisory guidance given the ongoing civil conflict before finalizing plans',
    'Embassy of Myanmar, New Delhi, or eVisa portal',
    'Review current travel-advisory guidance before finalizing plans\nComplete the eVisa application online, or confirm VoA eligibility\nCarry proof of relationship as supporting evidence',
    '/assets/images/visa-heroes/myanmar.jpg',
    'Limited secondary sourcing found this session for a distinct Family Visit product; treated as covered under the general eVisa/VoA policy', 'https://evisa.moip.gov.mm/', '2026-09-11'
);
SET @mm5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mm5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mm5, 'Core Documents', 'Same as Tourist entry.', 1);
SET @mm5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mm5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mm5s1, 'Digital Passport-Style Photograph', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mm5, 'Supporting Documents', 'Family-visit-specific evidence.', 2);
SET @mm5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mm5s2, 'Proof of Relationship', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(83, 5, NULL, 'INR', 'Confirmed After Assessment', 'Follows the Tourist eVisa/VoA fee schedule — contact us to confirm.', '2026-09-01', NOW(), 'https://evisa.moip.gov.mm/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate visa to visit family in Myanmar?', 'No distinct product was confirmed this session — it is treated the same as the Tourist eVisa/VoA route.', 83, 5, 8305, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    83, 6, 'MMR-TRANS-IN-06', '2026.09', 'published',
    'Passing through Myanmar en route to a third country.',
    'A lightly-travelled and lightly-documented category given the current situation in the country and limited international connectivity.',
    'Short stay, typically up to 24 hours',
    'Apply via the Embassy of Myanmar or eVisa portal; confirm current transit eligibility given the ongoing situation',
    1,
    'No detailed transit-specific policy was confirmed this session — recommend confirming directly with the Embassy given limited connectivity through Myanmar currently',
    'Embassy of Myanmar, New Delhi',
    'Review current travel-advisory guidance given the ongoing civil conflict\nConfirm transit-visa requirements directly with the Embassy or your airline\nCarry onward ticket and passport',
    '/assets/images/visa-heroes/myanmar.jpg',
    'Limited direct sourcing found this session; recommend confirming with the Embassy given how limited international transit through Myanmar currently is', 'https://evisa.moip.gov.mm/', '2026-09-11'
);
SET @mm6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mm6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mm6, 'Core Documents', 'Required from every applicant.', 1);
SET @mm6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mm6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mm6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mm6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @mm6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mm6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(83, 6, NULL, 'INR', 'Confirmed After Assessment', 'Fee not confirmed this session — contact us to confirm.', '2026-09-01', NOW(), 'https://evisa.moip.gov.mm/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is transiting through Myanmar currently advisable?', 'Given the ongoing civil conflict and Level 4 advisory, we recommend reviewing current government travel guidance and, where possible, choosing routes that avoid transiting through Myanmar.', 83, 6, 8306, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    83, 7, 'MMR-MED-IN-07', '2026.09', 'published',
    'Travel to Myanmar for medical treatment — a highly uncommon direction, since medical-tourism traffic runs overwhelmingly from Myanmar to India, not the reverse.',
    'Covered under the general Tourist eVisa/VoA policy; no distinct Medical visa product was confirmed this session.',
    'Single entry, typically 28 days, same as Tourist',
    'Same eVisa/VoA process as Tourist entry',
    0,
    'An exceptionally rare travel direction given both the medical-tourism flow pattern and the current civil conflict — recommend confirming directly with the Embassy',
    'Embassy of Myanmar, New Delhi, or eVisa portal',
    'Review current travel-advisory guidance carefully before finalizing plans\nComplete the eVisa application online, or confirm VoA eligibility\nCarry hospital documentation as supporting evidence',
    '/assets/images/visa-heroes/myanmar.jpg',
    'Limited secondary sourcing found this session for this highly uncommon travel direction; treated as covered under the general Tourist eVisa/VoA policy', 'https://evisa.moip.gov.mm/', '2026-09-11'
);
SET @mm7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mm7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mm7, 'Core Documents', 'Same as Tourist entry.', 1);
SET @mm7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mm7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mm7s1, 'Digital Passport-Style Photograph', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mm7, 'Supporting Documents', 'Medical-specific evidence.', 2);
SET @mm7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mm7s2, 'Hospital Appointment Confirmation', NULL, 'copy', 0, 1, 0, 1),
(@mm7s2, 'Medical Records/Referral', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(83, 7, NULL, 'INR', 'Confirmed After Assessment', 'Follows the Tourist eVisa/VoA fee schedule — contact us to confirm.', '2026-09-01', NOW(), 'https://evisa.moip.gov.mm/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is medical travel to Myanmar common for Indians?', 'No — it is highly uncommon. Medical-tourism traffic runs overwhelmingly from Myanmar to India, not the reverse, and the current civil conflict makes this an especially rare travel direction.', 83, 7, 8307, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    83, 8, 'MMR-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, seminars, and official delegations in Myanmar.',
    'Typically processed under the Business visa category, with an event/host invitation letter as supporting evidence — no distinct Conference visa code was confirmed this session.',
    'Single or multiple entry, typically up to 70 days, same as Business',
    'Same Business eVisa process, with a conference/event invitation letter',
    1,
    'Review current travel-advisory guidance given the ongoing civil conflict before finalizing plans',
    'Embassy of Myanmar, New Delhi, or eVisa portal',
    'Review current travel-advisory guidance before finalizing plans\nObtain an invitation letter from the conference organizer/host institution\nComplete the online Business eVisa application form',
    '/assets/images/visa-heroes/myanmar.jpg',
    'Limited secondary sourcing found this session for a distinct Conference visa product; treated as a Business-visa use-case', 'https://evisa.moip.gov.mm/', '2026-09-11'
);
SET @mm8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mm8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mm8, 'Core Documents', 'Required from every applicant.', 1);
SET @mm8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mm8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mm8s1, 'Conference/Event Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mm8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @mm8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mm8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(83, 8, NULL, 'INR', 'Confirmed After Assessment', 'Follows the Business eVisa fee schedule — contact us to confirm.', '2026-09-01', NOW(), 'https://evisa.moip.gov.mm/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a distinct Conference Visa for Myanmar?', 'No — conference and delegation travel is typically processed under the Business visa category, with an event invitation letter as supporting evidence.', 83, 8, 8308, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    83, 9, 'MMR-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in Myanmar.',
    'Myanmar has no dedicated Sports visa code — delegations are routed through the Business visa category, per sources found this session.',
    'Single or multiple entry, typically up to 70 days, same as Business',
    'Same Business eVisa process, with federation/tournament accreditation',
    1,
    'Review current travel-advisory guidance given the ongoing civil conflict before finalizing plans',
    'Embassy of Myanmar, New Delhi, or eVisa portal',
    'Review current travel-advisory guidance before finalizing plans\nObtain accreditation from the relevant sports federation or tournament organizer\nComplete the online Business eVisa application form',
    '/assets/images/visa-heroes/myanmar.jpg',
    'Cross-checked against secondary sourcing confirming no dedicated Sports visa code exists; delegations routed through Business visa', 'https://evisa.moip.gov.mm/', '2026-09-11'
);
SET @mm9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mm9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mm9, 'Core Documents', 'Required from every applicant.', 1);
SET @mm9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mm9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mm9s1, 'Sports Federation/Tournament Accreditation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mm9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @mm9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mm9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(83, 9, NULL, 'INR', 'Confirmed After Assessment', 'Follows the Business eVisa fee schedule — contact us to confirm.', '2026-09-01', NOW(), 'https://evisa.moip.gov.mm/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Sports Visa for Myanmar?', 'No — Myanmar has no dedicated Sports visa code. Athletes and officials are routed through the Business visa category, with federation accreditation as the invitation basis.', 83, 9, 8309, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    83, 10, 'MMR-DEP-IN-10', '2026.09', 'published',
    'Spouse/children accompanying an Indian Work or Student visa holder in Myanmar.',
    'Myanmar has no dedicated Dependent visa code — family members are routed through the Business visa category as well, per sources found this session, then handled via local stay-permit registration alongside the principal.',
    'Tied to the principal visa/permit holder''s stay',
    'Family members apply for the Business visa, then register locally alongside the principal permit holder',
    1,
    'Review current travel-advisory guidance given the ongoing civil conflict before finalizing plans',
    'Embassy of Myanmar, New Delhi, or eVisa portal',
    'Review current travel-advisory guidance before finalizing plans\nGather documents proving the family relationship\nApply for the Business visa for each family member\nRegister locally alongside the principal permit holder after arrival',
    '/assets/images/visa-heroes/myanmar.jpg',
    'Cross-checked against secondary sourcing confirming no dedicated Dependent visa code exists; family members routed through Business visa', 'https://evisa.moip.gov.mm/', '2026-09-11'
);
SET @mm10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mm10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mm10, 'Core Documents', 'Required from every applicant.', 1);
SET @mm10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mm10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mm10s1, 'Proof of Relationship to Principal Visa Holder', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mm10, 'Supporting Documents', 'Evidence tied to the principal applicant''s visa.', 2);
SET @mm10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mm10s2, 'Principal Applicant''s Visa Copy', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(83, 10, NULL, 'INR', 'Confirmed After Assessment', 'Follows the Business eVisa fee schedule — contact us to confirm.', '2026-09-01', NOW(), 'https://evisa.moip.gov.mm/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Dependent Visa for Myanmar?', 'No — Myanmar has no dedicated Dependent visa code. Family members are routed through the Business visa category, then registered locally alongside the principal permit holder.', 83, 10, 8310, 1);
