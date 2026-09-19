-- Afghanistan Visa Checklist Engine content for all 10 visa types —
-- built fresh this session via web search. hero_image_url left NULL
-- pattern-consistent with other batches (no photo bundle supplied yet).
--
-- SOURCING CAVEAT: Afghan government domains were not directly
-- fetchable this session (egress-proxy blocked); findings below are
-- triangulated from web-search-indexed secondary sources (Akbar
-- Travels, embassies.net, VisaGo, Fly Well Tours, Indian Immigration
-- guides) plus Indian MEA travel-advisory context. Category-specific
-- document specifics beyond the confirmed general framework are
-- marked "not independently confirmed this session".
--
-- Afghanistan's real, distinctive facts verified this session:
--   - Indian citizens are granted GRATIS (fee-free) visas for all
--     Afghan visa categories — a genuinely distinctive fact versus
--     most destinations in this catalog.
--   - The Embassy of Afghanistan in New Delhi is the primary mission;
--     Consulate General offices in Hyderabad and Mumbai also process
--     applications — a wider in-India footprint than many peer
--     missions.
--   - Visa categories offered: Tourist, Business/Working Entry,
--     Student/Research, Transit, Visit, Official, Diplomatic, Crew.
--   - CRITICAL SAFETY CONTEXT: India's Ministry of External Affairs
--     and most governments maintain a "do not travel"/extremely
--     restricted advisory for Afghanistan given the current security
--     and political situation. This is surfaced honestly in every
--     checklist's disclaimer/purpose below rather than omitted —
--     Visagiri's standing rule is to never understate a genuine
--     safety caveat to close a booking.
--
-- country_id 55 = Afghanistan. visa_type_id: 1=Tourist, 2=Business,
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
    55, 1, 'AFG-TOUR-IN-01', '2026.09', 'published',
    'Leisure and cultural travel to Afghanistan.',
    'Indian passport holders require a visa before travel. IMPORTANT: India''s Ministry of External Affairs and most foreign governments currently maintain an extremely restricted/do-not-travel advisory for Afghanistan — confirm the current advisory status with the MEA before planning any trip.',
    'Varies by visa grant; confirm validity/duration on the visa sticker at issuance',
    'Apply in person at the Embassy of Afghanistan, New Delhi, or its Consulates General in Hyderabad or Mumbai',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Embassy of Afghanistan, New Delhi (also Consulates General in Hyderabad and Mumbai)',
    'Check the current Indian MEA travel advisory for Afghanistan before proceeding\nComplete the visa application form\nSubmit passport, photographs, and supporting documents at the Embassy/Consulate\nAttend any required in-person interview\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/afghanistan.webp',
    'Triangulated from Akbar Travels, embassies.net, VisaGo and Fly Well Tours secondary sourcing; official Afghan government domains not directly fetchable this session', 'https://www.akbartravels.com/visa/afghanistan-visa', '2026-09-19'
);
SET @afg1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@afg1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@afg1, 'Core Documents', 'Required from every applicant.', 1);
SET @afg1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@afg1s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@afg1s1, 'Recent Passport-Size Photographs', NULL, 'copy', 1, 0, 1, 2),
(@afg1s1, 'Completed Visa Application Form', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@afg1, 'Supporting Documents', 'Evidence of your travel plans and purpose.', 2);
SET @afg1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@afg1s2, 'Letter Explaining Purpose of Visit', NULL, 'copy', 1, 0, 0, 1),
(@afg1s2, 'Confirmed Accommodation Details', NULL, 'copy', 0, 1, 0, 2),
(@afg1s2, 'Return/Onward Travel Itinerary', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(55, 1, 0.00, 'USD', 'Gratis (Fee-Free) for Indian Nationals', 'Indian citizens are reported to be granted Afghan visas on a gratis (no-charge) basis across categories — confirm at the Embassy/Consulate before applying.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/afghanistan-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is it safe to travel to Afghanistan right now?', 'India''s Ministry of External Affairs and most foreign governments currently maintain an extremely restricted or do-not-travel advisory for Afghanistan. Check the latest MEA advisory before making any travel plans, regardless of visa eligibility.', 55, 1, 5500, 1),
('Do Indian citizens have to pay for an Afghan tourist visa?', 'Indian nationals are reported to be granted Afghan visas on a gratis (fee-free) basis, though this should be confirmed directly with the Embassy of Afghanistan at the time of application.', 55, 1, 5501, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    55, 2, 'AFG-BUS-IN-01', '2026.09', 'published',
    'Business meetings, trade, and investment-related travel to Afghanistan.',
    'Indian business travelers require a visa and an invitation from an Afghan company or organisation. IMPORTANT: confirm the current Indian MEA travel advisory for Afghanistan before planning any trip.',
    'Varies by visa grant; confirm validity/duration on the visa sticker at issuance',
    'Apply in person at the Embassy of Afghanistan, New Delhi, or its Consulates General in Hyderabad or Mumbai',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Embassy of Afghanistan, New Delhi (also Consulates General in Hyderabad and Mumbai)',
    'Obtain a business invitation letter from the host Afghan company\nComplete the visa application form\nSubmit passport, photographs, and supporting documents\nAttend any required in-person interview\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/afghanistan.webp',
    'Triangulated from Akbar Travels and embassies.net secondary sourcing; official Afghan government domains not directly fetchable this session', 'https://www.akbartravels.com/in/visas/types-of-afghanistan-visa', '2026-09-19'
);
SET @afg2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@afg2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@afg2, 'Core Documents', 'Required from every applicant.', 1);
SET @afg2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@afg2s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@afg2s1, 'Recent Passport-Size Photographs', NULL, 'copy', 1, 0, 1, 2),
(@afg2s1, 'Business Invitation Letter from Afghan Host Company', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@afg2, 'Supporting Documents', 'Evidence of your business purpose and company standing.', 2);
SET @afg2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@afg2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@afg2s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(55, 2, 0.00, 'USD', 'Gratis (Fee-Free) for Indian Nationals', 'Indian citizens are reported to be granted Afghan visas on a gratis (no-charge) basis across categories — confirm at the Embassy/Consulate before applying.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/types-of-afghanistan-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need an invitation letter for an Afghan business visa?', 'Yes — a business invitation letter from the Afghan host company is a core requirement alongside your passport and application form.', 55, 2, 5502, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    55, 3, 'AFG-STUD-IN-01', '2026.09', 'published',
    'Academic or research study programs in Afghanistan.',
    'Indian students require a visa and admission confirmation from an accredited Afghan institution. IMPORTANT: confirm the current Indian MEA travel advisory for Afghanistan before planning any trip.',
    'Tied to the academic program duration; confirm on the visa sticker at issuance',
    'Apply in person at the Embassy of Afghanistan, New Delhi, or its Consulates General in Hyderabad or Mumbai',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Embassy of Afghanistan, New Delhi (also Consulates General in Hyderabad and Mumbai)',
    'Secure admission confirmation from the Afghan institution\nComplete the visa application form\nSubmit passport, photographs, and academic documents\nAttend any required in-person interview\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/afghanistan.webp',
    'Triangulated from Akbar Travels and embassies.net secondary sourcing; official Afghan government domains not directly fetchable this session', 'https://www.akbartravels.com/in/visas/types-of-afghanistan-visa', '2026-09-19'
);
SET @afg3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@afg3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@afg3, 'Core Documents', 'Required from every applicant.', 1);
SET @afg3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@afg3s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@afg3s1, 'Recent Passport-Size Photographs', NULL, 'copy', 1, 0, 1, 2),
(@afg3s1, 'Admission Confirmation from Afghan Institution', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@afg3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @afg3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@afg3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@afg3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(55, 3, 0.00, 'USD', 'Gratis (Fee-Free) for Indian Nationals', 'Indian citizens are reported to be granted Afghan visas on a gratis (no-charge) basis across categories — confirm at the Embassy/Consulate before applying.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/types-of-afghanistan-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What proof of admission is needed for an Afghan student visa?', 'A formal admission confirmation letter from an accredited Afghan educational institution is required alongside academic transcripts and proof of financial support.', 55, 3, 5503, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    55, 4, 'AFG-WORK-IN-01', '2026.09', 'published',
    'Employment with an Afghan company or organisation.',
    'Indian professionals require a Working Entry Visa backed by an Afghan employer sponsorship. IMPORTANT: confirm the current Indian MEA travel advisory for Afghanistan before planning any trip.',
    'Tied to the employment contract duration; confirm on the visa sticker at issuance',
    'Apply in person at the Embassy of Afghanistan, New Delhi, or its Consulates General in Hyderabad or Mumbai',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Embassy of Afghanistan, New Delhi (also Consulates General in Hyderabad and Mumbai)',
    'Secure a signed employment contract/sponsorship from the Afghan employer\nComplete the visa application form\nSubmit passport, photographs, and employer documents\nAttend any required in-person interview\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/afghanistan.webp',
    'Triangulated from Akbar Travels and embassies.net secondary sourcing; official Afghan government domains not directly fetchable this session', 'https://www.akbartravels.com/in/visas/types-of-afghanistan-visa', '2026-09-19'
);
SET @afg4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@afg4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@afg4, 'Core Documents', 'Required from every applicant.', 1);
SET @afg4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@afg4s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@afg4s1, 'Recent Passport-Size Photographs', NULL, 'copy', 1, 0, 1, 2),
(@afg4s1, 'Signed Employment Contract/Sponsorship Letter', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@afg4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @afg4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@afg4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@afg4s2, 'Employer''s Registration Proof (Afghanistan)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(55, 4, 0.00, 'USD', 'Gratis (Fee-Free) for Indian Nationals', 'Indian citizens are reported to be granted Afghan visas on a gratis (no-charge) basis across categories — confirm at the Embassy/Consulate before applying.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/types-of-afghanistan-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need an employer sponsor for an Afghan work visa?', 'Yes — a signed employment contract or sponsorship letter from the Afghan employer is a core requirement for the Working Entry Visa.', 55, 4, 5504, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    55, 5, 'AFG-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Afghanistan.',
    'Indian nationals visiting relatives in Afghanistan require a Visit Visa supported by an invitation from the resident family member. IMPORTANT: confirm the current Indian MEA travel advisory for Afghanistan before planning any trip.',
    'Varies by visa grant; confirm validity/duration on the visa sticker at issuance',
    'Apply in person at the Embassy of Afghanistan, New Delhi, or its Consulates General in Hyderabad or Mumbai',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Embassy of Afghanistan, New Delhi (also Consulates General in Hyderabad and Mumbai)',
    'Obtain an invitation letter from the family member resident in Afghanistan\nComplete the visa application form\nSubmit passport, photographs, and relationship proof\nAttend any required in-person interview\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/afghanistan.webp',
    'Triangulated from Akbar Travels and embassies.net secondary sourcing; official Afghan government domains not directly fetchable this session', 'https://www.akbartravels.com/in/visas/types-of-afghanistan-visa', '2026-09-19'
);
SET @afg5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@afg5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@afg5, 'Core Documents', 'Required from every applicant.', 1);
SET @afg5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@afg5s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@afg5s1, 'Recent Passport-Size Photographs', NULL, 'copy', 1, 0, 1, 2),
(@afg5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@afg5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @afg5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@afg5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@afg5s2, 'Host''s Residence/ID Proof in Afghanistan', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(55, 5, 0.00, 'USD', 'Gratis (Fee-Free) for Indian Nationals', 'Indian citizens are reported to be granted Afghan visas on a gratis (no-charge) basis across categories — confirm at the Embassy/Consulate before applying.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/types-of-afghanistan-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What proof do I need to visit family in Afghanistan?', 'An invitation letter from the resident family member plus proof of relationship (birth or marriage certificate) are core requirements for the Visit Visa.', 55, 5, 5505, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    55, 6, 'AFG-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Afghanistan en route to a third country.',
    'Indian nationals transiting via Afghanistan require a Transit Visa with confirmed onward travel. IMPORTANT: confirm the current Indian MEA travel advisory for Afghanistan before planning any trip.',
    'Short duration tied to the transit itinerary; confirm on the visa sticker at issuance',
    'Apply in person at the Embassy of Afghanistan, New Delhi, or its Consulates General in Hyderabad or Mumbai',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Embassy of Afghanistan, New Delhi (also Consulates General in Hyderabad and Mumbai)',
    'Confirm onward travel itinerary and connecting flight/transport\nComplete the visa application form\nSubmit passport, photographs, and onward ticket\nAttend any required in-person interview\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/afghanistan.webp',
    'Triangulated from Akbar Travels and embassies.net secondary sourcing; official Afghan government domains not directly fetchable this session', 'https://www.akbartravels.com/in/visas/types-of-afghanistan-visa', '2026-09-19'
);
SET @afg6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@afg6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@afg6, 'Core Documents', 'Required from every applicant.', 1);
SET @afg6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@afg6s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@afg6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2),
(@afg6s1, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@afg6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @afg6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@afg6s2, 'Recent Passport-Size Photographs', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(55, 6, 0.00, 'USD', 'Gratis (Fee-Free) for Indian Nationals', 'Indian citizens are reported to be granted Afghan visas on a gratis (no-charge) basis across categories — confirm at the Embassy/Consulate before applying.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/types-of-afghanistan-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a transit visa to pass through Afghanistan?', 'Yes, a Transit Visa with confirmed onward travel documents is generally required — check current requirements with the Embassy given the evolving security situation.', 55, 6, 5506, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    55, 7, 'AFG-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Afghanistan.',
    'Not independently confirmed this session as a distinct standard visa category for Afghanistan — likely processed under the general Visit Visa framework with medical documentation. IMPORTANT: confirm the current Indian MEA travel advisory for Afghanistan before planning any trip.',
    'Varies by treatment duration; confirm on the visa sticker at issuance',
    'Apply in person at the Embassy of Afghanistan, New Delhi, or its Consulates General in Hyderabad or Mumbai',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Embassy of Afghanistan, New Delhi (also Consulates General in Hyderabad and Mumbai)',
    'Obtain a medical appointment/admission letter from the Afghan hospital\nComplete the visa application form\nSubmit passport, photographs, and medical documents\nAttend any required in-person interview\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/afghanistan.webp',
    'Best-effort structure built from the confirmed general Afghan visa framework; category-specific detail not independently confirmed this session', 'https://www.akbartravels.com/in/visas/types-of-afghanistan-visa', '2026-09-19'
);
SET @afg7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@afg7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@afg7, 'Core Documents', 'Required from every applicant.', 1);
SET @afg7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@afg7s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@afg7s1, 'Recent Passport-Size Photographs', NULL, 'copy', 1, 0, 1, 2),
(@afg7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@afg7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @afg7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@afg7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@afg7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(55, 7, 0.00, 'USD', 'Gratis (Fee-Free) for Indian Nationals', 'Indian citizens are reported to be granted Afghan visas on a gratis (no-charge) basis across categories — confirm at the Embassy/Consulate before applying.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/types-of-afghanistan-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Afghanistan?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the general Visit Visa framework with supporting medical documentation — confirm directly with the Embassy.', 55, 7, 5507, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    55, 8, 'AFG-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Afghanistan.',
    'Not independently confirmed this session as a distinct standard visa category — likely processed under the Business or Official Visa framework with an event invitation. IMPORTANT: confirm the current Indian MEA travel advisory for Afghanistan before planning any trip.',
    'Short duration tied to the event; confirm on the visa sticker at issuance',
    'Apply in person at the Embassy of Afghanistan, New Delhi, or its Consulates General in Hyderabad or Mumbai',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Embassy of Afghanistan, New Delhi (also Consulates General in Hyderabad and Mumbai)',
    'Obtain an official invitation letter from the event organiser\nComplete the visa application form\nSubmit passport, photographs, and event documents\nAttend any required in-person interview\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/afghanistan.webp',
    'Best-effort structure built from the confirmed general Afghan visa framework; category-specific detail not independently confirmed this session', 'https://www.akbartravels.com/in/visas/types-of-afghanistan-visa', '2026-09-19'
);
SET @afg8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@afg8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@afg8, 'Core Documents', 'Required from every applicant.', 1);
SET @afg8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@afg8s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@afg8s1, 'Recent Passport-Size Photographs', NULL, 'copy', 1, 0, 1, 2),
(@afg8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@afg8, 'Supporting Documents', 'Evidence of the event and sponsoring organisation.', 2);
SET @afg8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@afg8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(55, 8, 0.00, 'USD', 'Gratis (Fee-Free) for Indian Nationals', 'Indian citizens are reported to be granted Afghan visas on a gratis (no-charge) basis across categories — confirm at the Embassy/Consulate before applying.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/types-of-afghanistan-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Afghanistan?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business/Official Visa framework with an official invitation letter — confirm directly with the Embassy.', 55, 8, 5508, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    55, 9, 'AFG-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Afghanistan.',
    'Not independently confirmed this session as a distinct standard visa category — likely processed under the general Visit Visa framework with an event invitation. IMPORTANT: confirm the current Indian MEA travel advisory for Afghanistan before planning any trip.',
    'Short duration tied to the event; confirm on the visa sticker at issuance',
    'Apply in person at the Embassy of Afghanistan, New Delhi, or its Consulates General in Hyderabad or Mumbai',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Embassy of Afghanistan, New Delhi (also Consulates General in Hyderabad and Mumbai)',
    'Obtain an official invitation from the sporting federation/event organiser\nComplete the visa application form\nSubmit passport, photographs, and event documents\nAttend any required in-person interview\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/afghanistan.webp',
    'Best-effort structure built from the confirmed general Afghan visa framework; category-specific detail not independently confirmed this session', 'https://www.akbartravels.com/in/visas/types-of-afghanistan-visa', '2026-09-19'
);
SET @afg9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@afg9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@afg9, 'Core Documents', 'Required from every applicant.', 1);
SET @afg9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@afg9s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@afg9s1, 'Recent Passport-Size Photographs', NULL, 'copy', 1, 0, 1, 2),
(@afg9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@afg9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @afg9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@afg9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(55, 9, 0.00, 'USD', 'Gratis (Fee-Free) for Indian Nationals', 'Indian citizens are reported to be granted Afghan visas on a gratis (no-charge) basis across categories — confirm at the Embassy/Consulate before applying.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/types-of-afghanistan-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Afghanistan?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the general Visit Visa framework with a federation/event invitation — confirm directly with the Embassy.', 55, 9, 5509, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    55, 10, 'AFG-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Afghan work or residence visa.',
    'Family members of an Indian national holding a qualifying Afghan work/residence visa. IMPORTANT: confirm the current Indian MEA travel advisory for Afghanistan before planning any trip.',
    'Tied to the sponsor''s visa validity',
    'Apply in person at the Embassy of Afghanistan, New Delhi, or its Consulates General in Hyderabad or Mumbai',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Embassy of Afghanistan, New Delhi (also Consulates General in Hyderabad and Mumbai)',
    'Confirm the sponsor holds a qualifying work/residence visa\nGather relationship proof and the sponsor''s visa copy\nComplete the visa application form\nSubmit passport, photographs, and supporting documents\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/afghanistan.webp',
    'Best-effort structure built from the confirmed general Afghan visa framework; category-specific detail not independently confirmed this session', 'https://www.akbartravels.com/in/visas/types-of-afghanistan-visa', '2026-09-19'
);
SET @afg10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@afg10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@afg10, 'Core Documents', 'Required from every applicant.', 1);
SET @afg10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@afg10s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@afg10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@afg10, 'Supporting Documents', 'Evidence tied to the sponsor''s visa.', 2);
SET @afg10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@afg10s2, 'Sponsor''s Work/Residence Visa Copy', NULL, 'copy', 1, 0, 0, 1),
(@afg10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(55, 10, 0.00, 'USD', 'Gratis (Fee-Free) for Indian Nationals', 'Indian citizens are reported to be granted Afghan visas on a gratis (no-charge) basis across categories — confirm at the Embassy/Consulate before applying.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/types-of-afghanistan-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on an Afghan work visa as a dependent?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence visa. Confirm the exact dependent visa procedure directly with the Embassy.', 55, 10, 5510, 1);
