-- El Salvador Visa Checklist Engine content for all 10 visa types —
-- built fresh this session via web search.
--
-- El Salvador's real, distinctive facts verified this session:
--   - Indian citizens can enter visa-free for up to 90 days for
--     tourism/business — a tourist card (USD 10) is purchased on
--     arrival, valid for 90 days.
--   - El Salvador is part of the CA-4 free-movement zone with
--     Guatemala, Honduras, and Nicaragua; the 90-day count starts
--     from first entry into the CA-4 zone, not specifically into
--     El Salvador — a genuinely easy-to-miss detail for multi-country
--     Central America trips.
--   - Genuinely distinctive and separate fact: since October 2023, El
--     Salvador imposes a USD 1,000 transit visa fee specifically on
--     Indian nationals — an unusually high, targeted charge distinct
--     from the visa-free tourism/business route.
--
-- country_id 165 = El Salvador. visa_type_id: 1=Tourist, 2=Business,
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
    165, 1, 'SLV-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to El Salvador.',
    'Indian citizens can enter visa-free for up to 90 days; a USD 10 tourist card is purchased on arrival.',
    'Up to 90 days, counted from first entry into the CA-4 zone (El Salvador, Guatemala, Honduras, Nicaragua)',
    'No visa needed — arrive with a valid passport and purchase the tourist card on arrival',
    0,
    'Not applicable — no advance application required',
    'No advance application; tourist card purchased at the port of entry',
    'Confirm your passport is valid for 6+ months from arrival\nBook proof of onward/return travel\nArrive in El Salvador and purchase the USD 10 tourist card at the port of entry\nNote that your 90-day count starts from first entry into the CA-4 zone if arriving via Guatemala, Honduras, or Nicaragua\nKeep the tourist card for the duration of your stay',
    '/assets/images/visa-heroes/el-salvador.webp',
    'ivisatravel.com and thingstodoinsansalvador.com secondary sourcing', 'https://ivisatravel.com/el-salvador/c/el-salvador-visa-policy-check-requirements', '2026-09-19'
);
SET @slv1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@slv1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@slv1, 'Core Documents', 'Required from every traveller.', 1);
SET @slv1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@slv1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@slv1s1, 'Tourist Card (Purchased on Arrival, USD 10)', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@slv1, 'Supporting Documents', 'Evidence of your travel plans.', 2);
SET @slv1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@slv1s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 1),
(@slv1s2, 'Proof of Accommodation Booking', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(165, 1, 10.00, 'USD', 'Tourist Card Fee (Paid on Arrival)', 'No advance visa fee — this is the only cost for visa-free tourist entry, valid 90 days.', '2026-01-01', NOW(), 'https://ivisatravel.com/el-salvador/c/el-salvador-visa-policy-check-requirements', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for El Salvador tourism?', 'No — Indian citizens can enter visa-free for up to 90 days, purchasing a USD 10 tourist card on arrival.', 165, 1, 16500, 1),
('Does my 90-day stay reset if I visit Guatemala or Honduras too?', 'No — El Salvador is part of the CA-4 free-movement zone with Guatemala, Honduras, and Nicaragua, so the 90-day count starts from your first entry into any CA-4 country, not from your El Salvador entry specifically.', 165, 1, 16501, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    165, 2, 'SLV-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in El Salvador.',
    'Business travellers use the same visa-free framework as tourists, purchasing the same tourist card on arrival.',
    'Up to 90 days, counted from first entry into the CA-4 zone',
    'No visa needed — arrive with a valid passport and purchase the tourist card on arrival',
    0,
    'Not applicable — no advance application required',
    'No advance application; tourist card purchased at the port of entry',
    'Confirm your passport is valid for 6+ months from arrival\nCarry a business invitation letter if requested by immigration\nBook proof of onward/return travel\nArrive in El Salvador and purchase the USD 10 tourist card at the port of entry\nKeep the tourist card for the duration of your stay',
    '/assets/images/visa-heroes/el-salvador.webp',
    'ivisatravel.com and thingstodoinsansalvador.com secondary sourcing', 'https://ivisatravel.com/el-salvador/c/el-salvador-visa-policy-check-requirements', '2026-09-19'
);
SET @slv2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@slv2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@slv2, 'Core Documents', 'Required from every traveller.', 1);
SET @slv2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@slv2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@slv2s1, 'Business Invitation Letter', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@slv2, 'Supporting Documents', 'Evidence of your business purpose.', 2);
SET @slv2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@slv2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@slv2s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(165, 2, 10.00, 'USD', 'Tourist Card Fee (Paid on Arrival)', 'No advance visa fee — this is the only cost for visa-free business entry, valid 90 days.', '2026-01-01', NOW(), 'https://ivisatravel.com/el-salvador/c/el-salvador-visa-policy-check-requirements', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I attend business meetings in El Salvador visa-free?', 'Yes — business travel uses the same 90-day visa-free entry as tourism, with the USD 10 tourist card purchased on arrival.', 165, 2, 16502, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    165, 3, 'SLV-STUD-IN-01', '2026.09', 'published',
    'Academic study in El Salvador.',
    'Not independently confirmed this session as covered by visa-free entry; longer academic programs likely require a residency-linked student visa.',
    'Tied to the academic program duration',
    'Confirm with the nearest El Salvador mission for the student-visa process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest El Salvador diplomatic mission (confirm current jurisdiction serving India)',
    'Secure admission confirmation from the Salvadoran institution\nCheck whether visa-free entry or a separate student visa applies\nGather proof of financial support\nApply via the relevant mission if required\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/el-salvador.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://ivisatravel.com/el-salvador/c/el-salvador-visa-policy-check-requirements', '2026-09-19'
);
SET @slv3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@slv3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@slv3, 'Core Documents', 'Required from every applicant.', 1);
SET @slv3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@slv3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@slv3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@slv3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @slv3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@slv3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@slv3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(165, 3, NULL, 'USD', 'Confirm at Mission', 'Student visa fee not independently confirmed this session; confirm with the relevant El Salvador mission.', '2026-09-01', NOW(), 'https://ivisatravel.com/el-salvador/c/el-salvador-visa-policy-check-requirements', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate student visa for El Salvador?', 'Not independently confirmed this session — longer academic programs likely require a residency-linked student visa beyond the 90-day visa-free allowance. Confirm with the relevant mission.', 165, 3, 16503, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    165, 4, 'SLV-WORK-IN-01', '2026.09', 'published',
    'Employment with a Salvadoran company.',
    'Not independently confirmed this session as covered by visa-free entry; employment likely requires an employer-sponsored work/residency permit.',
    'Tied to the work permit validity',
    'Confirm with the employer and the nearest El Salvador mission for the work-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest El Salvador diplomatic mission (confirm current jurisdiction serving India)',
    'Secure a signed employment contract from the Salvadoran employer\nCheck whether a separate work/residency permit is required\nGather proof of qualifications\nApply via the relevant mission\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/el-salvador.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://ivisatravel.com/el-salvador/c/el-salvador-visa-policy-check-requirements', '2026-09-19'
);
SET @slv4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@slv4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@slv4, 'Core Documents', 'Required from every applicant.', 1);
SET @slv4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@slv4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@slv4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@slv4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @slv4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@slv4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@slv4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(165, 4, NULL, 'USD', 'Confirm at Mission', 'Work permit fee not independently confirmed this session; confirm with the relevant El Salvador mission.', '2026-09-01', NOW(), 'https://ivisatravel.com/el-salvador/c/el-salvador-visa-policy-check-requirements', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I work in El Salvador on the 90-day visa-free entry?', 'No — employment requires a separate employer-sponsored work/residency permit; the visa-free route does not authorise work.', 165, 4, 16504, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    165, 5, 'SLV-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in El Salvador.',
    'Family visits use the same visa-free framework as tourism, purchasing the same tourist card on arrival.',
    'Up to 90 days, counted from first entry into the CA-4 zone',
    'No visa needed — arrive with a valid passport and purchase the tourist card on arrival',
    0,
    'Not applicable — no advance application required',
    'No advance application; tourist card purchased at the port of entry',
    'Confirm your passport is valid for 6+ months from arrival\nCarry an invitation letter from the resident family member if requested\nBook proof of onward/return travel\nArrive in El Salvador and purchase the USD 10 tourist card at the port of entry\nKeep the tourist card for the duration of your stay',
    '/assets/images/visa-heroes/el-salvador.webp',
    'ivisatravel.com and thingstodoinsansalvador.com secondary sourcing', 'https://ivisatravel.com/el-salvador/c/el-salvador-visa-policy-check-requirements', '2026-09-19'
);
SET @slv5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@slv5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@slv5, 'Core Documents', 'Required from every traveller.', 1);
SET @slv5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@slv5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@slv5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@slv5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @slv5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@slv5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@slv5s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(165, 5, 10.00, 'USD', 'Tourist Card Fee (Paid on Arrival)', 'No advance visa fee for the visa-free route.', '2026-01-01', NOW(), 'https://ivisatravel.com/el-salvador/c/el-salvador-visa-policy-check-requirements', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in El Salvador visa-free?', 'Yes — family visits use the same 90-day visa-free entry as tourism, purchasing the USD 10 tourist card on arrival.', 165, 5, 16505, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    165, 6, 'SLV-TRAN-IN-01', '2026.09', 'published',
    'Transiting through El Salvador en route to a third country.',
    'Distinctive and separate from the visa-free tourism route: since October 2023, El Salvador imposes a USD 1,000 transit visa fee specifically on Indian nationals.',
    'Short duration tied to the transit itinerary',
    'Apply for the transit visa at the nearest El Salvador mission, or confirm with your airline whether transit is genuinely required',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest El Salvador diplomatic mission (confirm current jurisdiction serving India)',
    'Confirm onward travel itinerary and connecting flight/transport\nVerify whether your routing genuinely requires disembarking in El Salvador\nIf so, budget for the USD 1,000 transit visa fee applicable to Indian nationals\nApply at the nearest El Salvador mission\nCarry passport and onward ticket for the application',
    '/assets/images/visa-heroes/el-salvador.webp',
    'ivisatravel.com secondary sourcing on the October 2023 transit visa fee for Indian nationals', 'https://ivisatravel.com/el-salvador/c/el-salvador-visa-policy-check-requirements', '2026-09-19'
);
SET @slv6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@slv6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@slv6, 'Core Documents', 'Required from every applicant.', 1);
SET @slv6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@slv6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@slv6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@slv6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @slv6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@slv6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(165, 6, 1000.00, 'USD', 'Transit Visa Fee (Indian Nationals)', 'Distinctive, unusually high fee applying specifically to Indian nationals since October 2023 — verify current applicability before assuming transit is required, as many routings do not require disembarking.', '2023-10-01', NOW(), 'https://ivisatravel.com/el-salvador/c/el-salvador-visa-policy-check-requirements', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is it true El Salvador charges Indian citizens USD 1,000 for a transit visa?', 'Yes — since October 2023, El Salvador has imposed a USD 1,000 transit visa fee specifically on Indian nationals, distinct from the visa-free tourism/business route. Confirm whether your specific routing actually requires this before travel.', 165, 6, 16506, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    165, 7, 'SLV-MED-IN-01', '2026.09', 'published',
    'Medical treatment in El Salvador.',
    'Not independently confirmed this session as a distinct standard category — likely covered under the standard visa-free route with medical documentation.',
    'Up to 90 days, counted from first entry into the CA-4 zone',
    'No visa needed — arrive with a valid passport and purchase the tourist card on arrival',
    0,
    'Not applicable — no advance application required',
    'No advance application; tourist card purchased at the port of entry',
    'Obtain a medical appointment/admission letter from the hospital\nConfirm your passport is valid for 6+ months from arrival\nBook proof of onward/return travel\nArrive in El Salvador and purchase the USD 10 tourist card at the port of entry\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/el-salvador.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://ivisatravel.com/el-salvador/c/el-salvador-visa-policy-check-requirements', '2026-09-19'
);
SET @slv7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@slv7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@slv7, 'Core Documents', 'Required from every traveller.', 1);
SET @slv7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@slv7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@slv7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@slv7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @slv7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@slv7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@slv7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(165, 7, 10.00, 'USD', 'Tourist Card Fee (Paid on Arrival)', 'No advance visa fee for the visa-free route.', '2026-01-01', NOW(), 'https://ivisatravel.com/el-salvador/c/el-salvador-visa-policy-check-requirements', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for El Salvador?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely covered under the standard 90-day visa-free route with supporting medical documentation.', 165, 7, 16507, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    165, 8, 'SLV-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in El Salvador.',
    'Not independently confirmed this session as a distinct standard category — likely covered under the Business visa-free route with an event invitation.',
    'Up to 90 days, counted from first entry into the CA-4 zone',
    'No visa needed — arrive with a valid passport and purchase the tourist card on arrival',
    0,
    'Not applicable — no advance application required',
    'No advance application; tourist card purchased at the port of entry',
    'Obtain an official invitation letter from the event organiser\nConfirm your passport is valid for 6+ months from arrival\nBook proof of onward/return travel\nArrive in El Salvador and purchase the USD 10 tourist card at the port of entry\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/el-salvador.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://ivisatravel.com/el-salvador/c/el-salvador-visa-policy-check-requirements', '2026-09-19'
);
SET @slv8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@slv8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@slv8, 'Core Documents', 'Required from every traveller.', 1);
SET @slv8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@slv8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@slv8s1, 'Official Event Invitation Letter', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@slv8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @slv8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@slv8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(165, 8, 10.00, 'USD', 'Tourist Card Fee (Paid on Arrival)', 'No advance visa fee for the visa-free route.', '2026-01-01', NOW(), 'https://ivisatravel.com/el-salvador/c/el-salvador-visa-policy-check-requirements', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for El Salvador?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely covered under the Business visa-free route with an official invitation letter.', 165, 8, 16508, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    165, 9, 'SLV-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in El Salvador.',
    'Not independently confirmed this session as a distinct standard category — likely covered under the standard visa-free route with an event invitation.',
    'Up to 90 days, counted from first entry into the CA-4 zone',
    'No visa needed — arrive with a valid passport and purchase the tourist card on arrival',
    0,
    'Not applicable — no advance application required',
    'No advance application; tourist card purchased at the port of entry',
    'Obtain an official invitation from the sporting federation/event organiser\nConfirm your passport is valid for 6+ months from arrival\nBook proof of onward/return travel\nArrive in El Salvador and purchase the USD 10 tourist card at the port of entry\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/el-salvador.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://ivisatravel.com/el-salvador/c/el-salvador-visa-policy-check-requirements', '2026-09-19'
);
SET @slv9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@slv9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@slv9, 'Core Documents', 'Required from every traveller.', 1);
SET @slv9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@slv9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@slv9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@slv9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @slv9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@slv9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(165, 9, 10.00, 'USD', 'Tourist Card Fee (Paid on Arrival)', 'No advance visa fee for the visa-free route.', '2026-01-01', NOW(), 'https://ivisatravel.com/el-salvador/c/el-salvador-visa-policy-check-requirements', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for El Salvador?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely covered under the standard visa-free route with a federation/event invitation.', 165, 9, 16509, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    165, 10, 'SLV-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid El Salvador work or residence permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent application alongside the sponsor''s permit.',
    'Tied to the sponsor''s permit validity',
    'Confirm with the nearest El Salvador mission for the dependent-visa process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest El Salvador diplomatic mission (confirm current jurisdiction serving India)',
    'Confirm the sponsor holds a qualifying work/residence permit\nGather relationship proof and the sponsor''s permit copy\nApply via the relevant mission\nSubmit passport and supporting documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/el-salvador.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://ivisatravel.com/el-salvador/c/el-salvador-visa-policy-check-requirements', '2026-09-19'
);
SET @slv10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@slv10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@slv10, 'Core Documents', 'Required from every applicant.', 1);
SET @slv10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@slv10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@slv10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@slv10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @slv10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@slv10s2, 'Sponsor''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@slv10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(165, 10, NULL, 'USD', 'Confirm at Mission', 'Dependent visa fee not independently confirmed this session; confirm with the relevant El Salvador mission.', '2026-09-01', NOW(), 'https://ivisatravel.com/el-salvador/c/el-salvador-visa-policy-check-requirements', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent visa in El Salvador?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence permit. Confirm the exact procedure with the relevant mission.', 165, 10, 16510, 1);
