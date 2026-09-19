-- Belarus Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search. hero_image_url uses the supplied
-- photo bundle (visa-heroes/belarus.webp).
--
-- SOURCING CAVEAT: official Belarusian MFA/embassy domains were not
-- directly fetchable this session (egress-proxy blocked); findings
-- triangulated from BTW Visas, Wego Travel Blog, and
-- buch-dein-visum.de secondary sourcing.
--
-- Belarus' real, distinctive facts verified this session:
--   - THREE distinct entry routes for Indians in 2026:
--     1) Visa-free up to 30 days through Minsk, Brest, Gomel, Grodno,
--        Mogilev or Vitebsk airport ONLY, if holding an unexpired
--        multiple-entry Schengen/EU visa that has been used at least
--        once, and not transiting to/from Russia.
--     2) e-Visa: India was added to the e-visa list on 14 September
--        2026, but no start date was published as of this session —
--        the foreign ministry's e-visa page still lists 67 countries
--        without India reflected yet. Reported cost EUR 66 (EUR 60
--        consular fee + EUR 6 service fee), ~7-day processing once
--        live.
--     3) Traditional embassy visa: EUR 60, ~5-day processing, via the
--        Embassy of Belarus in New Delhi (Jacobpura Road, Surajmal
--        Vihar, New Delhi - 110092) or Consulate General in Mumbai
--        (142 Backbay Reclamation, Worli, Mumbai - 400030).
--   - Given the e-Visa's unconfirmed live status, the embassy route is
--     used as the primary described path below, with the visa-free
--     and e-Visa options flagged as alternatives.
--
-- country_id 109 = Belarus. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    109, 1, 'BLR-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Belarus.',
    'Indians with an unexpired, once-used multiple-entry Schengen/EU visa can enter visa-free for 30 days via Minsk, Brest, Gomel, Grodno, Mogilev, or Vitebsk airport only. Everyone else needs an embassy visa (an e-Visa was announced for India on 14 Sep 2026 but had no confirmed start date this session).',
    'Visa-free: up to 30 days (specific airports only); Embassy visa: confirm on issuance',
    'Apply in person at the Embassy of Belarus, New Delhi, or Consulate General, Mumbai — or use the visa-free route if eligible',
    1,
    'Embassy visa reported at ~5 working days; e-Visa (once live) reported at ~7 days',
    'Embassy of Belarus, Jacobpura Road, Surajmal Vihar, New Delhi - 110092 (also Consulate General, 142 Backbay Reclamation, Worli, Mumbai - 400030)',
    'Check if you qualify for visa-free entry via a used multiple-entry Schengen/EU visa (30 days, specific airports only)\nIf not, complete the embassy visa application form\nBook an appointment at the Embassy or Consulate\nSubmit passport, photographs, and supporting documents\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/belarus.webp',
    'BTW Visas and Wego Travel Blog secondary sourcing; official Belarusian government domains not directly fetchable this session', 'https://btwvisas.com/visa-guide/belarus-tourist-visa/', '2026-09-19'
);
SET @blr1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@blr1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blr1, 'Core Documents', 'Required from every embassy-route applicant.', 1);
SET @blr1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blr1s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@blr1s1, 'Recent Passport-Size Photograph', NULL, 'copy', 1, 0, 1, 2),
(@blr1s1, 'Completed Visa Application Form', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blr1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @blr1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blr1s2, 'Confirmed Accommodation Booking', NULL, 'copy', 1, 0, 0, 1),
(@blr1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2),
(@blr1s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 3),
(@blr1s2, 'Valid, Once-Used Multiple-Entry Schengen/EU Visa (If Using Visa-Free Route)', 'Presenting this instead qualifies you for 30-day visa-free entry via 6 named airports.', 'copy', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(109, 1, 60.00, 'EUR', 'Embassy Visa Fee', 'The e-Visa (when live) is reported at EUR 66 total (EUR 60 consular + EUR 6 service fee). Not applicable if travelling visa-free on a valid, used Schengen/EU visa via the 6 named airports.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/belarus-tourist-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian citizens enter Belarus visa-free?', 'Yes, if you hold an unexpired multiple-entry Schengen or EU visa that has already been used at least once — you can enter visa-free for up to 30 days, but only through Minsk, Brest, Gomel, Grodno, Mogilev, or Vitebsk airport, and not while transiting to/from Russia.', 109, 1, 10900, 1),
('Is the Belarus e-Visa available for Indians yet?', 'India was added to the e-visa eligible list on 14 September 2026, but as of this session no start date had been published and the official e-visa page still listed 67 countries without India reflected — confirm current status before relying on it.', 109, 1, 10901, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    109, 2, 'BLR-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Belarus.',
    'Business travellers apply at the Embassy of Belarus with an invitation letter (the visa-free/e-Visa routes primarily target tourism).',
    'Confirm on visa issuance',
    'Apply in person at the Embassy of Belarus, New Delhi, or Consulate General, Mumbai',
    1,
    'Reported at ~5 working days',
    'Embassy of Belarus, Jacobpura Road, Surajmal Vihar, New Delhi - 110092 (also Consulate General, 142 Backbay Reclamation, Worli, Mumbai - 400030)',
    'Obtain a business invitation letter from the Belarusian host\nComplete the visa application form\nBook an appointment at the Embassy or Consulate\nSubmit passport, photographs, and supporting documents\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/belarus.webp',
    'BTW Visas secondary sourcing; official Belarusian government domains not directly fetchable this session', 'https://btwvisas.com/visa-guide/belarus-business-visa/', '2026-09-19'
);
SET @blr2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@blr2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blr2, 'Core Documents', 'Required from every applicant.', 1);
SET @blr2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blr2s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@blr2s1, 'Recent Passport-Size Photograph', NULL, 'copy', 1, 0, 1, 2),
(@blr2s1, 'Business Invitation Letter from Belarusian Host', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blr2, 'Supporting Documents', 'Evidence of your business purpose and company standing.', 2);
SET @blr2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blr2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@blr2s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(109, 2, 60.00, 'EUR', 'Embassy Visa Fee', 'Confirm the current fee directly with the Embassy or Consulate before applying.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/belarus-business-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Where do I apply for a Belarus business visa?', 'At the Embassy of Belarus in New Delhi or the Consulate General in Mumbai, with a business invitation letter as a core requirement.', 109, 2, 10902, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    109, 3, 'BLR-STUD-IN-01', '2026.09', 'published',
    'Academic study in Belarus.',
    'Indian students require an embassy visa and admission confirmation from an accredited Belarusian institution.',
    'Tied to the academic program duration',
    'Apply in person at the Embassy of Belarus, New Delhi, or Consulate General, Mumbai',
    1,
    'Not independently confirmed this session for a specific working-day figure beyond the standard ~5-day embassy visa timing',
    'Embassy of Belarus, Jacobpura Road, Surajmal Vihar, New Delhi - 110092 (also Consulate General, 142 Backbay Reclamation, Worli, Mumbai - 400030)',
    'Secure admission confirmation from the Belarusian institution\nComplete the visa application form\nBook an appointment at the Embassy or Consulate\nSubmit passport, photographs, and academic documents\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/belarus.webp',
    'BTW Visas secondary sourcing; official Belarusian government domains not directly fetchable this session', 'https://btwvisas.com/visa-guide/belarus-visa/', '2026-09-19'
);
SET @blr3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@blr3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blr3, 'Core Documents', 'Required from every applicant.', 1);
SET @blr3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blr3s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@blr3s1, 'Admission Confirmation from Belarusian Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blr3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @blr3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blr3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@blr3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(109, 3, NULL, 'EUR', 'Confirm at Embassy/Consulate', 'Student visa fee not independently broken out this session; confirm with the Embassy or Consulate before applying.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/belarus-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can students use the visa-free route to Belarus?', 'No — the visa-free 30-day entry is tied to holding a used multiple-entry Schengen/EU visa and is best suited to short tourism, not long-term study. Students should apply for the embassy visa.', 109, 3, 10903, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    109, 4, 'BLR-WORK-IN-01', '2026.09', 'published',
    'Employment with a Belarusian company.',
    'Indian professionals require an embassy work visa backed by a Belarusian employer sponsorship.',
    'Tied to the employment contract duration',
    'Apply in person at the Embassy of Belarus, New Delhi, or Consulate General, Mumbai',
    1,
    'Not independently confirmed this session for a specific working-day figure beyond the standard ~5-day embassy visa timing',
    'Embassy of Belarus, Jacobpura Road, Surajmal Vihar, New Delhi - 110092 (also Consulate General, 142 Backbay Reclamation, Worli, Mumbai - 400030)',
    'Secure a signed employment contract/sponsorship from the Belarusian employer\nComplete the visa application form\nBook an appointment at the Embassy or Consulate\nSubmit passport, photographs, and employer documents\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/belarus.webp',
    'BTW Visas secondary sourcing; official Belarusian government domains not directly fetchable this session', 'https://btwvisas.com/visa-guide/belarus-visa/', '2026-09-19'
);
SET @blr4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@blr4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blr4, 'Core Documents', 'Required from every applicant.', 1);
SET @blr4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blr4s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@blr4s1, 'Signed Employment Contract/Sponsorship Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blr4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @blr4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blr4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@blr4s2, 'Employer''s Registration Proof (Belarus)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(109, 4, NULL, 'EUR', 'Confirm at Embassy/Consulate', 'Work visa fee not independently broken out this session; confirm with the Embassy or Consulate before applying.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/belarus-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need an employer sponsor for a Belarus work visa?', 'Yes — a signed employment contract or sponsorship letter from the Belarusian employer is a core requirement alongside your passport and application form.', 109, 4, 10904, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    109, 5, 'BLR-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Belarus.',
    'Indian nationals visiting relatives in Belarus can use the visa-free route (if eligible) or the embassy visa with an invitation letter.',
    'Visa-free: up to 30 days (specific airports only); Embassy visa: confirm on issuance',
    'Apply in person at the Embassy of Belarus, New Delhi, or Consulate General, Mumbai — or use the visa-free route if eligible',
    1,
    'Embassy visa reported at ~5 working days',
    'Embassy of Belarus, Jacobpura Road, Surajmal Vihar, New Delhi - 110092 (also Consulate General, 142 Backbay Reclamation, Worli, Mumbai - 400030)',
    'Obtain an invitation letter from the family member resident in Belarus\nCheck visa-free eligibility via a used multiple-entry Schengen/EU visa\nComplete the visa application form if applying via the Embassy\nSubmit passport, photographs, and relationship proof\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/belarus.webp',
    'BTW Visas and Wego Travel Blog secondary sourcing; official Belarusian government domains not directly fetchable this session', 'https://btwvisas.com/visa-guide/belarus-visa/', '2026-09-19'
);
SET @blr5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@blr5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blr5, 'Core Documents', 'Required from every applicant.', 1);
SET @blr5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blr5s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@blr5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blr5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @blr5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blr5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@blr5s2, 'Host''s Residence/ID Proof in Belarus', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(109, 5, 60.00, 'EUR', 'Embassy Visa Fee', 'Not applicable if travelling visa-free on a valid, used Schengen/EU visa via the 6 named airports.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/belarus-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in Belarus using the visa-free route?', 'Yes, if you hold an unexpired, once-used multiple-entry Schengen/EU visa — you can enter visa-free for 30 days via one of 6 named airports, or apply for an embassy visa with an invitation letter.', 109, 5, 10905, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    109, 6, 'BLR-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Belarus en route to a third country.',
    'IMPORTANT: the visa-free route explicitly excludes travellers transiting to/from Russia. Transit for other routings needs its own visa or confirmed eligibility.',
    'Short duration tied to the transit itinerary',
    'Apply in person at the Embassy of Belarus, New Delhi, or Consulate General, Mumbai — the visa-free route excludes Russia-linked transit',
    1,
    'Embassy visa reported at ~5 working days',
    'Embassy of Belarus, Jacobpura Road, Surajmal Vihar, New Delhi - 110092 (also Consulate General, 142 Backbay Reclamation, Worli, Mumbai - 400030)',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck that your routing is not transiting to/from Russia (visa-free exclusion)\nComplete the visa application form if required\nSubmit passport, photographs, and onward ticket\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/belarus.webp',
    'BTW Visas and Wego Travel Blog secondary sourcing; official Belarusian government domains not directly fetchable this session', 'https://btwvisas.com/visa-guide/belarus-visa/', '2026-09-19'
);
SET @blr6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@blr6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blr6, 'Core Documents', 'Required from every applicant.', 1);
SET @blr6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blr6s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@blr6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2),
(@blr6s1, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blr6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @blr6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blr6s2, 'Recent Passport-Size Photograph', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(109, 6, 60.00, 'EUR', 'Embassy Visa Fee', 'Confirm the current fee and whether a dedicated transit visa exists directly with the Embassy or Consulate.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/belarus-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I use the visa-free route if transiting via Russia to Belarus?', 'No — the visa-free 30-day entry explicitly excludes travellers transiting to or from Russia. You would need a regular embassy visa for that routing.', 109, 6, 10906, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    109, 7, 'BLR-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Belarus.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the embassy visa framework with medical documentation.',
    'Confirm on visa issuance',
    'Apply in person at the Embassy of Belarus, New Delhi, or Consulate General, Mumbai',
    1,
    'Embassy visa reported at ~5 working days',
    'Embassy of Belarus, Jacobpura Road, Surajmal Vihar, New Delhi - 110092 (also Consulate General, 142 Backbay Reclamation, Worli, Mumbai - 400030)',
    'Obtain a medical appointment/admission letter from the Belarusian hospital\nComplete the visa application form\nBook an appointment at the Embassy or Consulate\nSubmit passport, photographs, and medical documents\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/belarus.webp',
    'Best-effort structure built from the confirmed general Belarusian visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/belarus-visa/', '2026-09-19'
);
SET @blr7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@blr7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blr7, 'Core Documents', 'Required from every applicant.', 1);
SET @blr7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blr7s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@blr7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blr7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @blr7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blr7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@blr7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(109, 7, 60.00, 'EUR', 'Embassy Visa Fee', 'Confirm the current fee directly with the Embassy or Consulate before applying.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/belarus-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Belarus?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the embassy visa framework with supporting medical documentation.', 109, 7, 10907, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    109, 8, 'BLR-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Belarus.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the Business visa framework with an event invitation.',
    'Confirm on visa issuance',
    'Apply in person at the Embassy of Belarus, New Delhi, or Consulate General, Mumbai',
    1,
    'Embassy visa reported at ~5 working days',
    'Embassy of Belarus, Jacobpura Road, Surajmal Vihar, New Delhi - 110092 (also Consulate General, 142 Backbay Reclamation, Worli, Mumbai - 400030)',
    'Obtain an official invitation letter from the event organiser\nComplete the visa application form\nBook an appointment at the Embassy or Consulate\nSubmit passport, photographs, and event documents\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/belarus.webp',
    'Best-effort structure built from the confirmed general Belarusian visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/belarus-visa/', '2026-09-19'
);
SET @blr8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@blr8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blr8, 'Core Documents', 'Required from every applicant.', 1);
SET @blr8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blr8s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@blr8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blr8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @blr8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blr8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(109, 8, 60.00, 'EUR', 'Embassy Visa Fee', 'Confirm the current fee directly with the Embassy or Consulate before applying.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/belarus-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Belarus?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business visa framework with an official invitation letter.', 109, 8, 10908, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    109, 9, 'BLR-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Belarus.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the embassy visa framework with an event invitation.',
    'Confirm on visa issuance',
    'Apply in person at the Embassy of Belarus, New Delhi, or Consulate General, Mumbai',
    1,
    'Embassy visa reported at ~5 working days',
    'Embassy of Belarus, Jacobpura Road, Surajmal Vihar, New Delhi - 110092 (also Consulate General, 142 Backbay Reclamation, Worli, Mumbai - 400030)',
    'Obtain an official invitation from the sporting federation/event organiser\nComplete the visa application form\nBook an appointment at the Embassy or Consulate\nSubmit passport, photographs, and event documents\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/belarus.webp',
    'Best-effort structure built from the confirmed general Belarusian visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/belarus-visa/', '2026-09-19'
);
SET @blr9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@blr9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blr9, 'Core Documents', 'Required from every applicant.', 1);
SET @blr9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blr9s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@blr9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blr9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @blr9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blr9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(109, 9, 60.00, 'EUR', 'Embassy Visa Fee', 'Confirm the current fee directly with the Embassy or Consulate before applying.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/belarus-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Belarus?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the embassy visa framework with a federation/event invitation.', 109, 9, 10909, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    109, 10, 'BLR-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Belarusian work or residence visa.',
    'Family members of an Indian national holding a qualifying Belarusian work/residence visa.',
    'Tied to the sponsor''s visa validity',
    'Apply in person at the Embassy of Belarus, New Delhi, or Consulate General, Mumbai',
    1,
    'Embassy visa reported at ~5 working days',
    'Embassy of Belarus, Jacobpura Road, Surajmal Vihar, New Delhi - 110092 (also Consulate General, 142 Backbay Reclamation, Worli, Mumbai - 400030)',
    'Confirm the sponsor holds a qualifying work/residence visa\nGather relationship proof and the sponsor''s visa copy\nComplete the visa application form\nBook an appointment at the Embassy or Consulate\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/belarus.webp',
    'Best-effort structure built from the confirmed general Belarusian visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/belarus-visa/', '2026-09-19'
);
SET @blr10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@blr10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blr10, 'Core Documents', 'Required from every applicant.', 1);
SET @blr10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blr10s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@blr10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@blr10, 'Supporting Documents', 'Evidence tied to the sponsor''s visa.', 2);
SET @blr10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@blr10s2, 'Sponsor''s Work/Residence Visa Copy', NULL, 'copy', 1, 0, 0, 1),
(@blr10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(109, 10, NULL, 'EUR', 'Confirm at Embassy/Consulate', 'Dependent visa fee not independently broken out this session; confirm with the Embassy or Consulate before applying.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/belarus-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a Belarus work visa as a dependent?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence visa. Confirm the exact dependent visa procedure directly with the Embassy or Consulate.', 109, 10, 10910, 1);
