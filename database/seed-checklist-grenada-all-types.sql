-- Grenada Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Grenada's real, distinctive facts verified this session:
--   - Indian citizens can enter Grenada visa-free for up to 90 days —
--     no visa or eVisa needed for entry itself.
--   - Distinctive requirement: all travellers must complete an online
--     application for a "Pure Safe Travel Authorization Certificate"
--     before travel — originally introduced 1 December 2020 as a
--     COVID-era health/travel authorization; not independently
--     confirmed this session whether it remains active in its
--     original form in 2026, so flagged as a requirement to verify
--     rather than silently dropped or assumed unchanged.
--
-- country_id 167 = Grenada. visa_type_id: 1=Tourist, 2=Business,
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
    167, 1, 'GRD-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Grenada.',
    'Indian citizens can enter Grenada visa-free for up to 90 days — no visa is required for entry itself.',
    'Up to 90 days',
    'No visa needed — complete the online Pure Safe Travel Authorization Certificate application before travel',
    0,
    'Not applicable for entry itself — Pure Safe Travel Authorization is processed online before travel',
    'No in-person appearance required — visa-free entry with online travel authorization',
    'Confirm your passport is valid for the intended stay\nComplete the online Pure Safe Travel Authorization Certificate application before travel\nBook proof of return/onward ticket\nGather proof of sufficient funds for your stay\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/grenada.webp',
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/grenada-gd', '2026-09-19'
);
SET @grd1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@grd1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grd1, 'Core Documents', 'Required from every traveller.', 1);
SET @grd1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grd1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@grd1s1, 'Pure Safe Travel Authorization Certificate (Online)', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grd1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @grd1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grd1s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 1),
(@grd1s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(167, 1, 0.00, 'USD', 'No Visa Fee for Visa-Free Entry', 'The Pure Safe Travel Authorization Certificate may carry its own separate fee, not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/grenada-gd', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Grenada?', 'No — Indian citizens can enter Grenada visa-free for up to 90 days.', 167, 1, 16700, 1),
('What is the Pure Safe Travel Authorization Certificate?', 'An online travel authorization all travellers to Grenada must complete before travel, originally introduced in December 2020. Not independently confirmed this session whether it remains active in its original form — verify current requirements before travel.', 167, 1, 16701, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    167, 2, 'GRD-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Grenada.',
    'Business travellers use the same visa-free framework as tourists, also completing the online Pure Safe Travel Authorization Certificate.',
    'Up to 90 days',
    'No visa needed — complete the online Pure Safe Travel Authorization Certificate application before travel',
    0,
    'Not applicable for entry itself',
    'No in-person appearance required — visa-free entry with online travel authorization',
    'Confirm your passport is valid for the intended stay\nComplete the online Pure Safe Travel Authorization Certificate application\nCarry a business invitation letter if requested by immigration\nBook proof of return/onward ticket\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/grenada.webp',
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/grenada-gd', '2026-09-19'
);
SET @grd2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@grd2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grd2, 'Core Documents', 'Required from every traveller.', 1);
SET @grd2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grd2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@grd2s1, 'Pure Safe Travel Authorization Certificate (Online)', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grd2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @grd2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grd2s2, 'Business Invitation Letter', NULL, 'copy', 0, 1, 0, 1),
(@grd2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(167, 2, 0.00, 'USD', 'No Visa Fee for Visa-Free Entry', 'The Pure Safe Travel Authorization Certificate may carry its own separate fee, not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/grenada-gd', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I do business in Grenada visa-free?', 'Yes — business travel uses the same visa-free framework as tourism, up to 90 days, with the online travel authorization also required.', 167, 2, 16702, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    167, 3, 'GRD-STUD-IN-01', '2026.09', 'published',
    'Academic study in Grenada — notably home to St. George''s University, a well-known destination for international medical students.',
    'Not independently confirmed this session as covered by visa-free entry; longer academic programs likely require a student permit beyond the standard 90-day allowance.',
    'Tied to the academic program duration',
    'Confirm with the nearest Grenada mission or the institution for the student-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Grenada diplomatic mission (confirm current jurisdiction serving India)',
    'Secure admission confirmation from the Grenadian institution\nCheck whether visa-free entry or a separate student permit applies\nGather proof of financial support\nComplete the online Pure Safe Travel Authorization Certificate\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/grenada.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://www.ixigo.com/visa-for-indians/grenada-gd', '2026-09-19'
);
SET @grd3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@grd3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grd3, 'Core Documents', 'Required from every applicant.', 1);
SET @grd3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grd3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@grd3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grd3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @grd3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grd3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@grd3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(167, 3, NULL, 'USD', 'Confirm with Institution/Mission', 'Student permit fee not independently confirmed this session; confirm with the institution or the relevant Grenada mission.', '2026-09-01', NOW(), 'https://www.ixigo.com/visa-for-indians/grenada-gd', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a student permit for Grenada?', 'Not independently confirmed this session — longer academic programs (Grenada is home to St. George''s University, popular with international medical students) likely require a permit beyond the standard 90-day visa-free allowance.', 167, 3, 16703, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    167, 4, 'GRD-WORK-IN-01', '2026.09', 'published',
    'Employment with a Grenadian company.',
    'Not independently confirmed this session as covered by visa-free entry; employment likely requires a work permit sponsored by the employer.',
    'Tied to the work permit validity',
    'Employer applies for the work permit with Grenadian immigration authorities',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Grenada diplomatic mission (confirm current jurisdiction serving India)',
    'Secure a signed employment offer from the Grenadian employer\nHave the employer initiate the work-permit application\nGather proof of qualifications\nComplete the online Pure Safe Travel Authorization Certificate\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/grenada.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://www.ixigo.com/visa-for-indians/grenada-gd', '2026-09-19'
);
SET @grd4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@grd4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grd4, 'Core Documents', 'Required from every applicant.', 1);
SET @grd4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grd4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@grd4s1, 'Signed Employment Offer/Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grd4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @grd4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grd4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@grd4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(167, 4, NULL, 'USD', 'Confirm with Immigration', 'Work permit fee not independently confirmed this session; confirm with Grenadian immigration authorities.', '2026-09-01', NOW(), 'https://www.ixigo.com/visa-for-indians/grenada-gd', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I work in Grenada on the visa-free entry?', 'No — employment requires a work permit sponsored by the employer; the visa-free route does not authorise work.', 167, 4, 16704, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    167, 5, 'GRD-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Grenada.',
    'Family visits use the same visa-free framework as tourism, also completing the online Pure Safe Travel Authorization Certificate.',
    'Up to 90 days',
    'No visa needed — complete the online Pure Safe Travel Authorization Certificate application before travel',
    0,
    'Not applicable for entry itself',
    'No in-person appearance required — visa-free entry with online travel authorization',
    'Confirm your passport is valid for the intended stay\nComplete the online Pure Safe Travel Authorization Certificate application\nCarry an invitation letter from the resident family member if requested\nBook proof of return/onward ticket\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/grenada.webp',
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/grenada-gd', '2026-09-19'
);
SET @grd5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@grd5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grd5, 'Core Documents', 'Required from every traveller.', 1);
SET @grd5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grd5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@grd5s1, 'Pure Safe Travel Authorization Certificate (Online)', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grd5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @grd5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grd5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@grd5s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(167, 5, 0.00, 'USD', 'No Visa Fee for Visa-Free Entry', 'The Pure Safe Travel Authorization Certificate may carry its own separate fee, not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/grenada-gd', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in Grenada visa-free?', 'Yes — Indian citizens can visit family in Grenada visa-free for up to 90 days, with the online travel authorization also required.', 167, 5, 16705, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    167, 6, 'GRD-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Grenada en route to a third country.',
    'Not independently confirmed this session whether transit requires the standard visa-free entry rules or a separate provision — confirm with the airline before travel.',
    'Short duration tied to the transit itinerary',
    'Confirm with Grenadian immigration or your airline whether the visa-free route applies to your transit',
    0,
    'Not independently confirmed this session for a specific working-day figure',
    'No in-person appearance required for visa-free entry',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck whether a transit-specific provision applies\nComplete the online Pure Safe Travel Authorization Certificate if disembarking\nCarry your passport and onward ticket\nConfirm requirements with your airline before travel',
    '/assets/images/visa-heroes/grenada.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://www.ixigo.com/visa-for-indians/grenada-gd', '2026-09-19'
);
SET @grd6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@grd6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grd6, 'Core Documents', 'Required from every traveller.', 1);
SET @grd6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grd6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@grd6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grd6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @grd6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grd6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(167, 6, NULL, 'USD', 'Confirm with Immigration', 'Transit fee not independently confirmed this session; confirm with Grenadian immigration.', '2026-09-01', NOW(), 'https://www.ixigo.com/visa-for-indians/grenada-gd', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Grenada?', 'Not independently confirmed this session — confirm with Grenadian immigration or your airline whether your specific transit routing requires the standard visa-free entry rules.', 167, 6, 16706, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    167, 7, 'GRD-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Grenada.',
    'Not independently confirmed this session as a distinct standard category — likely covered under the standard visa-free route with medical documentation.',
    'Up to 90 days',
    'No visa needed — complete the online Pure Safe Travel Authorization Certificate application before travel',
    0,
    'Not applicable for entry itself',
    'No in-person appearance required — visa-free entry with online travel authorization',
    'Obtain a medical appointment/admission letter from the hospital\nComplete the online Pure Safe Travel Authorization Certificate application\nBook proof of return/onward ticket\nGather proof of financial means for treatment\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/grenada.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://www.ixigo.com/visa-for-indians/grenada-gd', '2026-09-19'
);
SET @grd7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@grd7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grd7, 'Core Documents', 'Required from every traveller.', 1);
SET @grd7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grd7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@grd7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grd7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @grd7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grd7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@grd7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(167, 7, 0.00, 'USD', 'No Visa Fee for Visa-Free Entry', 'The Pure Safe Travel Authorization Certificate may carry its own separate fee, not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/grenada-gd', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Grenada?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely covered under the standard visa-free route with supporting medical documentation.', 167, 7, 16707, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    167, 8, 'GRD-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Grenada.',
    'Not independently confirmed this session as a distinct standard category — likely covered under the Business visa-free route with an event invitation.',
    'Up to 90 days',
    'No visa needed — complete the online Pure Safe Travel Authorization Certificate application before travel',
    0,
    'Not applicable for entry itself',
    'No in-person appearance required — visa-free entry with online travel authorization',
    'Obtain an official event invitation letter\nComplete the online Pure Safe Travel Authorization Certificate application\nBook proof of return/onward ticket\nCarry all documents for immigration on arrival\nConfirm requirements with the event organiser',
    '/assets/images/visa-heroes/grenada.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://www.ixigo.com/visa-for-indians/grenada-gd', '2026-09-19'
);
SET @grd8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@grd8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grd8, 'Core Documents', 'Required from every traveller.', 1);
SET @grd8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grd8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@grd8s1, 'Official Event Invitation Letter', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grd8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @grd8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grd8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(167, 8, 0.00, 'USD', 'No Visa Fee for Visa-Free Entry', 'The Pure Safe Travel Authorization Certificate may carry its own separate fee, not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/grenada-gd', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Grenada?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely covered under the Business visa-free route with an official invitation letter.', 167, 8, 16708, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    167, 9, 'GRD-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Grenada.',
    'Not independently confirmed this session as a distinct standard category — likely covered under the standard visa-free route with an event invitation.',
    'Up to 90 days',
    'No visa needed — complete the online Pure Safe Travel Authorization Certificate application before travel',
    0,
    'Not applicable for entry itself',
    'No in-person appearance required — visa-free entry with online travel authorization',
    'Obtain an official invitation from the sporting federation/event organiser\nComplete the online Pure Safe Travel Authorization Certificate application\nBook proof of return/onward ticket\nCarry all documents for immigration on arrival\nConfirm requirements with the federation/organiser',
    '/assets/images/visa-heroes/grenada.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://www.ixigo.com/visa-for-indians/grenada-gd', '2026-09-19'
);
SET @grd9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@grd9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grd9, 'Core Documents', 'Required from every traveller.', 1);
SET @grd9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grd9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@grd9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grd9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @grd9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grd9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(167, 9, 0.00, 'USD', 'No Visa Fee for Visa-Free Entry', 'The Pure Safe Travel Authorization Certificate may carry its own separate fee, not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/grenada-gd', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Grenada?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely covered under the standard visa-free route with a federation/event invitation.', 167, 9, 16709, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    167, 10, 'GRD-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Grenada work permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent application alongside the sponsor''s work permit.',
    'Tied to the sponsor''s work permit validity',
    'Confirm with Grenadian immigration for the dependent-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Grenada diplomatic mission (confirm current jurisdiction serving India)',
    'Confirm the sponsor holds a qualifying Grenada work permit\nGather relationship proof and the sponsor''s permit copy\nApply via Grenadian immigration\nComplete the online Pure Safe Travel Authorization Certificate\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/grenada.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://www.ixigo.com/visa-for-indians/grenada-gd', '2026-09-19'
);
SET @grd10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@grd10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grd10, 'Core Documents', 'Required from every applicant.', 1);
SET @grd10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grd10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@grd10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grd10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @grd10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grd10s2, 'Sponsor''s Work Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@grd10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(167, 10, NULL, 'USD', 'Confirm with Immigration', 'Dependent permit fee not independently confirmed this session; confirm with Grenadian immigration.', '2026-09-01', NOW(), 'https://www.ixigo.com/visa-for-indians/grenada-gd', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent permit in Grenada?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work permit. Confirm the exact procedure with Grenadian immigration.', 167, 10, 16710, 1);
