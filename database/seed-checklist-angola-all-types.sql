-- Angola Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search. hero_image_url left NULL
-- pattern-consistent with other batches (no photo bundle supplied yet).
--
-- SOURCING CAVEAT: Angolan government domains were not directly
-- fetchable this session (egress-proxy blocked); findings triangulated
-- from iVisa and BTW Visas secondary sourcing.
--
-- Angola's real, distinctive facts verified this session:
--   - Since 29 September 2023, Indian passport holders can travel to
--     Angola VISA-FREE for tourism, up to 30 days per visit (maximum
--     90 days per calendar year) — part of Angola's unilateral
--     exemption for 98 countries including India. A genuinely
--     distinctive, traveller-favourable fact.
--   - For business, work, study, or stays exceeding 30 days, an
--     e-Visa or embassy visa is required in advance.
--   - A yellow fever vaccination certificate is required to enter
--     Angola regardless of visa category.
--   - Reported e-Visa processing fees (via iVisa, third-party):
--     Standard (8 days) USD 49.99; Rush (6 days) USD 69.99; Super Rush
--     (4 days) USD 89.99 — these are third-party service fees, not
--     necessarily the official government fee; confirm on the
--     official portal.
--
-- country_id 2 = Angola. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Visa-Free up to 30 days
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    2, 1, 'AGO-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Angola.',
    'Since 29 September 2023, Indian passport holders travel to Angola visa-free for tourism, up to 30 days per visit (max 90 days per calendar year). No visa application needed for stays within this limit.',
    'Up to 30 days per visit, maximum 90 days per calendar year, visa-free',
    'No visa required — present passport and supporting documents on arrival',
    0,
    'No visa processing needed for visa-free entry within the 30-day limit',
    'Not applicable — visa-free entry; Embassy of Angola in New Delhi available for longer-stay categories',
    'Confirm your passport has 6+ months validity\nGet a yellow fever vaccination and carry the certificate\nBook travel and accommodation for up to 30 days\nCarry proof of onward travel and sufficient funds\nPresent all documents to immigration on arrival',
    '/assets/images/visa-heroes/angola.webp',
    'iVisa and BTW Visas secondary sourcing; official Angolan government domains not directly fetchable this session', 'https://btwvisas.com/visa-guide/angola-visa/', '2026-09-19'
);
SET @ago1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ago1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ago1, 'Core Documents', 'Required from every visa-free traveller.', 1);
SET @ago1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ago1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ago1s1, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ago1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @ago1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ago1s2, 'Confirmed Accommodation Booking', NULL, 'copy', 1, 0, 0, 1),
(@ago1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2),
(@ago1s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(2, 1, 0.00, 'USD', 'Visa-Free Entry (Up to 30 Days)', 'No visa fee applies for visa-free tourism entry up to 30 days per visit (max 90 days/year). Stays beyond 30 days require an e-Visa or embassy visa instead.', '2023-09-29', NOW(), 'https://btwvisas.com/visa-guide/angola-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Angola tourism?', 'No — since 29 September 2023, Indian passport holders can travel to Angola visa-free for tourism, up to 30 days per visit and a maximum of 90 days per calendar year.', 2, 1, 200, 1),
('Do I need a yellow fever certificate for Angola?', 'Yes — a yellow fever vaccination certificate is required to enter Angola regardless of your visa status.', 2, 1, 201, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    2, 2, 'AGO-BUS-IN-01', '2026.09', 'published',
    'Business meetings and commercial activity in Angola.',
    'Business travel requires an e-Visa or embassy visa in advance, with a business invitation letter — visa-free entry only applies to tourism.',
    'Varies by e-Visa grant; confirm at issuance',
    'Apply online via an e-Visa provider, or in person at the Embassy of Angola in New Delhi',
    0,
    'Reported: Standard 8 days, Rush 6 days, Super Rush 4 days (third-party service tiers)',
    'Embassy of Angola, New Delhi (or e-Visa portal for online applications)',
    'Obtain a business invitation letter from the Angolan host company\nGet a yellow fever vaccination and carry the certificate\nApply online for the e-Visa or in person at the Embassy\nUpload/submit passport, photo, and supporting documents\nPay the applicable fee and receive the e-Visa/visa',
    '/assets/images/visa-heroes/angola.webp',
    'iVisa and BTW Visas secondary sourcing; official Angolan government domains not directly fetchable this session', 'https://btwvisas.com/visa-guide/angola-visa/', '2026-09-19'
);
SET @ago2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ago2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ago2, 'Core Documents', 'Required from every applicant.', 1);
SET @ago2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ago2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ago2s1, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 1, 2),
(@ago2s1, 'Business Invitation Letter from Angolan Host', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ago2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @ago2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ago2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@ago2s2, 'Proof of Travel Bookings (Flights, Accommodation)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(2, 2, 49.99, 'USD', 'Standard e-Visa Processing (8 Days)', 'Third-party service fee reported via iVisa; Rush (6 days) is USD 69.99 and Super Rush (4 days) is USD 89.99. Confirm official government fee on the official portal.', '2026-01-01', NOW(), 'https://ivisatravel.com/angola/c/angola-visa-requirements-india', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I use the visa-free entry for business in Angola?', 'No — the visa-free tourism entry does not cover business travel. Business visitors need an e-Visa or embassy visa with a business invitation letter.', 2, 2, 202, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — e-Visa/embassy
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    2, 3, 'AGO-STUD-IN-01', '2026.09', 'published',
    'Academic study in Angola.',
    'Students require an e-Visa or embassy visa in advance, with admission confirmation from an accredited Angolan institution.',
    'Tied to the academic program duration',
    'Apply online via an e-Visa provider, or in person at the Embassy of Angola in New Delhi',
    1,
    'Not independently confirmed this session for a specific working-day figure beyond the general e-Visa tiers',
    'Embassy of Angola, New Delhi (or e-Visa portal for online applications)',
    'Secure admission confirmation from the Angolan institution\nGet a yellow fever vaccination and carry the certificate\nApply online for the e-Visa or in person at the Embassy\nSubmit passport, photographs, and academic documents\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/angola.webp',
    'iVisa and BTW Visas secondary sourcing; official Angolan government domains not directly fetchable this session', 'https://btwvisas.com/visa-guide/angola-visa/', '2026-09-19'
);
SET @ago3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ago3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ago3, 'Core Documents', 'Required from every applicant.', 1);
SET @ago3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ago3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ago3s1, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 1, 2),
(@ago3s1, 'Admission Confirmation from Angolan Institution', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ago3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @ago3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ago3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@ago3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(2, 3, NULL, 'USD', 'Confirm at Embassy/Portal', 'Student visa fee not independently broken out this session; confirm the current fee at the Embassy or official e-Visa portal.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/angola-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can students use the visa-free entry for Angola?', 'No — the visa-free tourism entry does not cover study. Students need an e-Visa or embassy visa with admission confirmation from an Angolan institution.', 2, 3, 203, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — e-Visa/embassy
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    2, 4, 'AGO-WORK-IN-01', '2026.09', 'published',
    'Employment with an Angolan company.',
    'Work visa applicants require an e-Visa or embassy visa in advance, backed by an Angolan employer sponsorship.',
    'Tied to the employment contract duration',
    'Apply online via an e-Visa provider, or in person at the Embassy of Angola in New Delhi',
    1,
    'Not independently confirmed this session for a specific working-day figure beyond the general e-Visa tiers',
    'Embassy of Angola, New Delhi (or e-Visa portal for online applications)',
    'Secure a signed employment contract from the Angolan employer\nGet a yellow fever vaccination and carry the certificate\nApply online for the e-Visa or in person at the Embassy\nSubmit passport, photographs, and employer documents\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/angola.webp',
    'iVisa and BTW Visas secondary sourcing; official Angolan government domains not directly fetchable this session', 'https://btwvisas.com/visa-guide/angola-visa/', '2026-09-19'
);
SET @ago4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ago4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ago4, 'Core Documents', 'Required from every applicant.', 1);
SET @ago4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ago4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ago4s1, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 1, 2),
(@ago4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ago4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @ago4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ago4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@ago4s2, 'Employer''s Registration Proof (Angola)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(2, 4, NULL, 'USD', 'Confirm at Embassy/Portal', 'Work visa fee not independently broken out this session; confirm the current fee at the Embassy or official e-Visa portal.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/angola-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I work in Angola on the visa-free entry?', 'No — the visa-free tourism entry does not cover employment. Work visa applicants need an e-Visa or embassy visa with employer sponsorship.', 2, 4, 204, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Visa-Free up to 30 days
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    2, 5, 'AGO-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Angola for up to 30 days.',
    'Family visits fall under the same visa-free tourism exemption (up to 30 days per visit, max 90 days/year) — stays beyond 30 days require an e-Visa or embassy visa.',
    'Up to 30 days per visit, maximum 90 days per calendar year, visa-free',
    'No visa required within the 30-day limit — present passport and supporting documents on arrival',
    0,
    'No visa processing needed for visa-free entry within the 30-day limit',
    'Not applicable — visa-free entry; Embassy of Angola in New Delhi available for longer-stay categories',
    'Confirm your passport has 6+ months validity\nGet a yellow fever vaccination and carry the certificate\nObtain an invitation letter from the resident family member (recommended)\nCarry proof of relationship and onward travel\nPresent all documents to immigration on arrival',
    '/assets/images/visa-heroes/angola.webp',
    'iVisa and BTW Visas secondary sourcing; official Angolan government domains not directly fetchable this session', 'https://btwvisas.com/visa-guide/angola-visa/', '2026-09-19'
);
SET @ago5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ago5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ago5, 'Core Documents', 'Required from every visa-free traveller.', 1);
SET @ago5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ago5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ago5s1, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ago5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @ago5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ago5s2, 'Invitation Letter from Resident Family Member', NULL, 'copy', 0, 1, 0, 1),
(@ago5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(2, 5, 0.00, 'USD', 'Visa-Free Entry (Up to 30 Days)', 'No visa fee applies for visa-free entry up to 30 days per visit (max 90 days/year). Stays beyond 30 days require an e-Visa or embassy visa instead.', '2023-09-29', NOW(), 'https://btwvisas.com/visa-guide/angola-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in Angola visa-free?', 'Yes — family visits up to 30 days fall under the same visa-free tourism exemption available to Indian citizens since September 2023.', 2, 5, 205, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    2, 6, 'AGO-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Angola en route to a third country.',
    'Not independently confirmed this session whether transit is covered by the visa-free exemption or needs a separate transit visa — confirm with the airline/Embassy before travel.',
    'Short duration tied to the transit itinerary',
    'Confirm with the Embassy of Angola or your airline whether a transit visa is needed for your routing',
    0,
    'Not independently confirmed this session for a specific working-day figure',
    'Embassy of Angola, New Delhi (or e-Visa portal for online applications)',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck whether a transit visa is required for your specific routing\nGet a yellow fever vaccination and carry the certificate\nApply for the transit visa if required, or proceed under visa-free entry\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/angola.webp',
    'Best-effort structure built from the confirmed general Angolan visa-free/e-Visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/angola-visa/', '2026-09-19'
);
SET @ago6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ago6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ago6, 'Core Documents', 'Required from every applicant.', 1);
SET @ago6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ago6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ago6s1, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 1, 2),
(@ago6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ago6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @ago6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ago6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(2, 6, NULL, 'USD', 'Confirm at Embassy/Portal', 'Transit visa fee (if required at all) not independently confirmed this session; confirm with the Embassy or official e-Visa portal.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/angola-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a transit visa for Angola?', 'Not independently confirmed this session — confirm with your airline or the Embassy of Angola whether your specific transit routing is covered by the visa-free exemption or needs a separate visa.', 2, 6, 206, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    2, 7, 'AGO-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Angola.',
    'For stays up to 30 days, likely covered by the visa-free tourism exemption; longer treatment requires an e-Visa or embassy visa with medical documentation.',
    'Up to 30 days visa-free; longer stays via e-Visa/embassy visa',
    'No visa required within the 30-day limit; otherwise apply via e-Visa provider or the Embassy',
    0,
    'Not independently confirmed this session for a specific working-day figure beyond the general e-Visa tiers',
    'Embassy of Angola, New Delhi (or e-Visa portal for online applications)',
    'Obtain a medical appointment/admission letter from the Angolan hospital\nGet a yellow fever vaccination and carry the certificate\nProceed visa-free if the stay is within 30 days, or apply for the e-Visa/embassy visa\nSubmit medical documents if applying for the visa\nCollect the passport with visa once processed (if applicable)',
    '/assets/images/visa-heroes/angola.webp',
    'Best-effort structure built from the confirmed general Angolan visa-free/e-Visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/angola-visa/', '2026-09-19'
);
SET @ago7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ago7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ago7, 'Core Documents', 'Required from every applicant.', 1);
SET @ago7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ago7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ago7s1, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 1, 2),
(@ago7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ago7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @ago7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ago7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@ago7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(2, 7, 0.00, 'USD', 'Visa-Free for Stays up to 30 Days', 'No visa fee for stays within the 30-day visa-free exemption; longer medical stays require an e-Visa or embassy visa with its own fee schedule.', '2023-09-29', NOW(), 'https://btwvisas.com/visa-guide/angola-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa for short medical treatment in Angola?', 'For treatment within 30 days, the visa-free tourism exemption likely applies; longer treatment requires an e-Visa or embassy visa with supporting medical documentation.', 2, 7, 207, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    2, 8, 'AGO-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Angola.',
    'For stays up to 30 days, likely covered by the visa-free tourism exemption; longer or formally sponsored visits use the Business e-Visa/embassy visa route.',
    'Up to 30 days visa-free; longer stays via e-Visa/embassy visa',
    'No visa required within the 30-day limit; otherwise apply via e-Visa provider or the Embassy',
    0,
    'Not independently confirmed this session for a specific working-day figure beyond the general e-Visa tiers',
    'Embassy of Angola, New Delhi (or e-Visa portal for online applications)',
    'Obtain an official invitation letter from the event organiser\nGet a yellow fever vaccination and carry the certificate\nProceed visa-free if the stay is within 30 days, or apply for the Business e-Visa/embassy visa\nSubmit event documents if applying for the visa\nCollect the passport with visa once processed (if applicable)',
    '/assets/images/visa-heroes/angola.webp',
    'Best-effort structure built from the confirmed general Angolan visa-free/e-Visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/angola-visa/', '2026-09-19'
);
SET @ago8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ago8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ago8, 'Core Documents', 'Required from every applicant.', 1);
SET @ago8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ago8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ago8s1, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 1, 2),
(@ago8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ago8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @ago8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ago8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(2, 8, 0.00, 'USD', 'Visa-Free for Stays up to 30 Days', 'No visa fee for stays within the 30-day visa-free exemption; longer conference stays use the Business e-Visa/embassy visa route with its own fee schedule.', '2023-09-29', NOW(), 'https://btwvisas.com/visa-guide/angola-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Angola?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; short stays likely fall under the visa-free exemption, with longer/sponsored visits using the Business e-Visa route.', 2, 8, 208, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    2, 9, 'AGO-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Angola.',
    'For stays up to 30 days, likely covered by the visa-free tourism exemption; longer stays use the e-Visa/embassy visa route.',
    'Up to 30 days visa-free; longer stays via e-Visa/embassy visa',
    'No visa required within the 30-day limit; otherwise apply via e-Visa provider or the Embassy',
    0,
    'Not independently confirmed this session for a specific working-day figure beyond the general e-Visa tiers',
    'Embassy of Angola, New Delhi (or e-Visa portal for online applications)',
    'Obtain an official invitation from the sporting federation/event organiser\nGet a yellow fever vaccination and carry the certificate\nProceed visa-free if the stay is within 30 days, or apply for the e-Visa/embassy visa\nSubmit event documents if applying for the visa\nCollect the passport with visa once processed (if applicable)',
    '/assets/images/visa-heroes/angola.webp',
    'Best-effort structure built from the confirmed general Angolan visa-free/e-Visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/angola-visa/', '2026-09-19'
);
SET @ago9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ago9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ago9, 'Core Documents', 'Required from every applicant.', 1);
SET @ago9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ago9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ago9s1, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 1, 2),
(@ago9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ago9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @ago9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ago9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(2, 9, 0.00, 'USD', 'Visa-Free for Stays up to 30 Days', 'No visa fee for stays within the 30-day visa-free exemption; longer participation stays use the e-Visa/embassy visa route with its own fee schedule.', '2023-09-29', NOW(), 'https://btwvisas.com/visa-guide/angola-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Angola?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; short participation stays likely fall under the visa-free exemption, with longer stays using the e-Visa/embassy route.', 2, 9, 209, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — e-Visa/embassy
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    2, 10, 'AGO-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Angolan work or residence visa.',
    'Family members of an Indian national holding a qualifying Angolan work/residence visa apply via the same e-Visa/embassy visa framework.',
    'Tied to the sponsor''s visa validity',
    'Apply online via an e-Visa provider, or in person at the Embassy of Angola in New Delhi',
    1,
    'Not independently confirmed this session for a specific working-day figure beyond the general e-Visa tiers',
    'Embassy of Angola, New Delhi (or e-Visa portal for online applications)',
    'Confirm the sponsor holds a qualifying work/residence visa\nGather relationship proof and the sponsor''s visa copy\nGet a yellow fever vaccination and carry the certificate\nApply online for the e-Visa or in person at the Embassy\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/angola.webp',
    'Best-effort structure built from the confirmed general Angolan e-Visa/embassy framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/angola-visa/', '2026-09-19'
);
SET @ago10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ago10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ago10, 'Core Documents', 'Required from every applicant.', 1);
SET @ago10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ago10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ago10s1, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 1, 2),
(@ago10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ago10, 'Supporting Documents', 'Evidence tied to the sponsor''s visa.', 2);
SET @ago10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ago10s2, 'Sponsor''s Work/Residence Visa Copy', NULL, 'copy', 1, 0, 0, 1),
(@ago10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(2, 10, NULL, 'USD', 'Confirm at Embassy/Portal', 'Dependent visa fee not independently broken out this session; confirm the current fee at the Embassy or official e-Visa portal.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/angola-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on an Angola work visa as a dependent?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence visa. Confirm the exact dependent visa procedure directly with the Embassy or e-Visa portal.', 2, 10, 210, 1);
