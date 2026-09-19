-- Haiti Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Haiti's real, distinctive facts verified this session:
--   - Indian citizens can enter Haiti visa-free for up to 90 days for
--     tourism, business, or visit purposes — no visa or eVisa needed.
--   - Distinctive requirement: a USD 10 tourist fee is collected at the
--     airport on arrival (not a visa fee).
--   - Anyone intending to WORK in Haiti (including missionaries,
--     teachers, businessmen, and students who work) must obtain a work
--     permit from the Ministere des Affaires Sociales (Ministry of
--     Labor and Social Affairs) — sourced from ht.usembassy.gov.
--   - Foreign nationals aged 21+ staying beyond 90 days must obtain a
--     residence permit ("permis de sejour") from the Direction de
--     l'Immigration (Department of Immigration and Emigration) in
--     Port-au-Prince, valid for a fiscal year (Oct 1 - Sep 30).
--   - India has NO embassy or consulate in Haiti. The Embassy of
--     India, Santo Domingo (Dominican Republic) is concurrently
--     accredited to Haiti, but has no resident Indian diplomats there;
--     an Honorary Consul (Mr. Eddy Handal) provides limited local
--     consular contact. Sourced from eoisantodomingo.gov.in.
--   - CRITICAL SAFETY CAVEAT: the Embassy of India's own advisory for
--     Haiti (eoisantodomingo.gov.in, updated Dec 2024) and the U.S.
--     Department of State both describe a severe security situation
--     (gang violence, organized crime, civil unrest) — this is flagged
--     directly in eligibility_summary/processing_note for every visa
--     type below rather than omitted, since it materially affects
--     whether travel is advisable at all, independent of visa rules.
--   - Sourcing note: some third-party visa-agency sites (e.g. Akbar
--     Travels) sell a paid "Haiti transit visa" / "Haiti visa" service
--     despite Haiti being visa-free for Indians — flagged as a
--     sourcing conflict rather than silently resolved, consistent with
--     the same pattern seen for other visa-free Caribbean countries in
--     this project.
--
-- country_id 169 = Haiti. visa_type_id: 1=Tourist, 2=Business,
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
    169, 1, 'HTI-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Haiti.',
    'Indian citizens can enter Haiti visa-free for up to 90 days for tourism. Note: the Government of India advises caution — Haiti faces a severe security situation (gang violence, unrest); review the current advisory before booking.',
    'Up to 90 days',
    'No visa needed — pay the USD 10 tourist fee on arrival at the airport',
    0,
    'Not applicable for entry itself. Severe security advisory in effect for Haiti — verify current conditions before travel.',
    'No Indian mission in Haiti. Embassy of India, Santo Domingo (Dominican Republic) is concurrently accredited; Honorary Consul Eddy Handal provides local contact.',
    'Confirm your passport is valid for the intended stay\nReview the current Government of India travel advisory for Haiti\nBook proof of return/onward ticket and accommodation\nGather proof of sufficient funds for your stay\nPay the USD 10 tourist fee on arrival',
    '/assets/images/visa-heroes/haiti.webp',
    'ht.usembassy.gov and eoisantodomingo.gov.in secondary sourcing', 'https://eoisantodomingo.gov.in/advisory-for-haiti.php', '2026-09-19'
);
SET @hti1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hti1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hti1, 'Core Documents', 'Required from every traveller.', 1);
SET @hti1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hti1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@hti1s1, 'Proof of USD 10 Tourist Fee (Paid on Arrival)', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hti1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @hti1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hti1s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 1),
(@hti1s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2),
(@hti1s2, 'Proof of Accommodation', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(169, 1, 10.00, 'USD', 'Tourist Fee (Paid on Arrival)', 'This is an airport tourist fee, not a visa fee — Haiti has no tourist visa requirement for Indian citizens.', '2026-01-01', NOW(), 'https://ht.usembassy.gov/information-for-travelers/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Haiti?', 'No — Indian citizens can enter Haiti visa-free for up to 90 days for tourism, paying only a USD 10 tourist fee on arrival.', 169, 1, 16900, 1),
('Is it safe to travel to Haiti right now?', 'Haiti faces a severe security situation. Both the Government of India (via the Embassy of India, Santo Domingo) and other governments advise caution or against travel. Review the latest advisory before booking.', 169, 1, 16901, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    169, 2, 'HTI-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Haiti.',
    'Business travellers use the same visa-free framework as tourists, paying the USD 10 fee on arrival. Severe security advisory in effect — review before travel.',
    'Up to 90 days',
    'No visa needed — pay the USD 10 fee on arrival at the airport',
    0,
    'Not applicable for entry itself. Note: this is not a work permit — do not take up local employment on this basis.',
    'No Indian mission in Haiti. Embassy of India, Santo Domingo (Dominican Republic) is concurrently accredited.',
    'Confirm your passport is valid for the intended stay\nReview the current Government of India travel advisory for Haiti\nCarry a business invitation letter if requested by immigration\nBook proof of return/onward ticket\nPay the USD 10 fee on arrival',
    '/assets/images/visa-heroes/haiti.webp',
    'ht.usembassy.gov secondary sourcing', 'https://ht.usembassy.gov/information-for-travelers/', '2026-09-19'
);
SET @hti2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hti2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hti2, 'Core Documents', 'Required from every traveller.', 1);
SET @hti2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hti2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@hti2s1, 'Business Invitation Letter', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hti2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @hti2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hti2s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 1),
(@hti2s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(169, 2, 10.00, 'USD', 'Tourist/Entry Fee (Paid on Arrival)', 'Same USD 10 airport fee applies; there is no separate business visa.', '2026-01-01', NOW(), 'https://ht.usembassy.gov/information-for-travelers/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travellers need a visa for Haiti?', 'No — the same visa-free, 90-day framework applies. Only the USD 10 arrival fee is payable.', 169, 2, 16920, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    169, 3, 'HTI-STU-IN-01', '2026.09', 'published',
    'Academic study at a Haitian educational institution.',
    'Sources reviewed this session did not describe a dedicated Haitian student-visa category. Entry itself uses the same visa-free framework; students staying beyond 90 days must register for a residence permit, and those who also work must obtain a work permit.',
    'Up to 90 days visa-free, then residence-permit renewal',
    'Enter visa-free, then file a residence permit at Direction de l\'Immigration, Port-au-Prince, if staying beyond 90 days',
    1,
    'Not independently confirmed this session whether a distinct student visa category exists — verify directly with your institution and the Direction de l\'Immigration before relying on this as a complete process.',
    'No Indian mission in Haiti. Embassy of India, Santo Domingo (Dominican Republic) is concurrently accredited.',
    'Confirm admission with a Haitian educational institution\nEnter Haiti visa-free (up to 90 days)\nIf staying beyond 90 days, file for a residence permit at the Direction de l\'Immigration in Port-au-Prince\nIf you intend to work while studying, also obtain a work permit from the Ministere des Affaires Sociales\nCarry proof of enrollment at all times',
    '/assets/images/visa-heroes/haiti.webp',
    'ht.usembassy.gov secondary sourcing', 'https://ht.usembassy.gov/information-on-obtaining-a-permis-de-sejour/', '2026-09-19'
);
SET @hti3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hti3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hti3, 'Core Documents', 'Required from every applicant.', 1);
SET @hti3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hti3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@hti3s1, 'Proof of Admission/Enrollment Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hti3, 'Residence Permit Documents (Stays Beyond 90 Days)', 'Required only for stays exceeding 90 days.', 2);
SET @hti3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hti3s2, 'Residence Permit Application (Direction de l\'Immigration)', NULL, 'original', 0, 1, 1, 1),
(@hti3s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(169, 3, 0.00, 'USD', 'No Fee for Visa-Free Entry', 'Residence permit fees, if a longer stay is needed, were not independently confirmed this session.', '2026-01-01', NOW(), 'https://ht.usembassy.gov/information-on-obtaining-a-permis-de-sejour/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated student visa for Haiti?', 'Not independently confirmed this session. Entry uses the same visa-free framework as tourists; longer academic stays require a residence permit from the Direction de l\'Immigration.', 169, 3, 16930, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    169, 4, 'HTI-WORK-IN-01', '2026.09', 'published',
    'Employment in Haiti, including missionaries, teachers, and business employees.',
    'Anyone intending to work in Haiti must obtain a work permit from the Ministere des Affaires Sociales. Employees 21 or older staying 3+ months must also obtain a residence permit from the Direction de l\'Immigration.',
    'Fiscal-year residence permit (Oct 1 - Sep 30), renewable',
    'Apply for a work permit through your employer at the Ministere des Affaires Sociales in Port-au-Prince',
    1,
    'Employees 21+ staying 3+ months must separately file for a residence permit. Severe security advisory in effect for Haiti.',
    'No Indian mission in Haiti. Embassy of India, Santo Domingo (Dominican Republic) is concurrently accredited.',
    'Secure a Haitian employer/sponsor\nEmployer applies for your work permit at the Ministere des Affaires Sociales\nIf 21+ and staying 3+ months, file for a residence permit at the Direction de l\'Immigration\nEnter Haiti and register your residence permit\nRenew the residence permit each fiscal year (Oct 1 - Sep 30) if continuing to work',
    '/assets/images/visa-heroes/haiti.webp',
    'ht.usembassy.gov secondary sourcing', 'https://ht.usembassy.gov/obtaining-a-work-permit/', '2026-09-19'
);
SET @hti4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hti4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hti4, 'Core Documents', 'Required from every work-permit applicant.', 1);
SET @hti4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hti4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@hti4s1, 'Employment Contract/Sponsorship Letter', NULL, 'original', 1, 0, 1, 2),
(@hti4s1, 'Work Permit Application (Ministere des Affaires Sociales)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hti4, 'Residence Permit Documents (Stays 3+ Months, Age 21+)', 'Required for longer employment stays.', 2);
SET @hti4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hti4s2, 'Residence Permit Application (Direction de l\'Immigration)', NULL, 'original', 0, 1, 1, 1),
(@hti4s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(169, 4, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Exact work permit and residence permit fees were not independently confirmed this session — verify with the Ministere des Affaires Sociales and Direction de l\'Immigration directly.', '2026-01-01', NOW(), 'https://ht.usembassy.gov/obtaining-a-work-permit/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a separate work permit to work in Haiti?', 'Yes — anyone intending to work in Haiti, regardless of nationality, must obtain a work permit from the Ministere des Affaires Sociales, and typically a residence permit as well if staying 3 or more months.', 169, 4, 16940, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    169, 5, 'HTI-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in Haiti.',
    'Family visitors use the same visa-free, 90-day framework as tourists, paying the USD 10 arrival fee.',
    'Up to 90 days',
    'No visa needed — pay the USD 10 fee on arrival at the airport',
    0,
    'Not applicable for entry itself. Severe security advisory in effect for Haiti.',
    'No Indian mission in Haiti. Embassy of India, Santo Domingo (Dominican Republic) is concurrently accredited.',
    'Confirm your passport is valid for the intended stay\nReview the current Government of India travel advisory for Haiti\nCarry proof of relationship and host contact details\nBook proof of return/onward ticket\nPay the USD 10 fee on arrival',
    '/assets/images/visa-heroes/haiti.webp',
    'ht.usembassy.gov secondary sourcing', 'https://ht.usembassy.gov/information-for-travelers/', '2026-09-19'
);
SET @hti5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hti5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hti5, 'Core Documents', 'Required from every traveller.', 1);
SET @hti5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hti5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@hti5s1, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hti5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @hti5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hti5s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 1),
(@hti5s2, 'Host Invitation Letter', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(169, 5, 10.00, 'USD', 'Tourist/Entry Fee (Paid on Arrival)', 'Same USD 10 airport fee applies; there is no separate family visit visa.', '2026-01-01', NOW(), 'https://ht.usembassy.gov/information-for-travelers/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit family in Haiti?', 'No — the same visa-free, 90-day framework applies. Only the USD 10 arrival fee is payable.', 169, 5, 16950, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    169, 6, 'HTI-TRAN-IN-01', '2026.09', 'published',
    'Airside or short transit through Haiti en route to another destination.',
    'Airside transit is permitted without a separate visa for Indian passport holders. Note: some third-party visa agencies advertise a paid "Haiti transit visa" service — this appears to be an agency service fee rather than an official visa requirement, and is flagged here as a sourcing conflict rather than silently resolved.',
    'Airside/short transit only',
    'No visa needed for airside transit — remain within the international transit area',
    0,
    'If leaving the airport or clearing immigration, the standard visa-free tourist entry rules and USD 10 fee apply instead.',
    'No Indian mission in Haiti. Embassy of India, Santo Domingo (Dominican Republic) is concurrently accredited.',
    'Confirm your onward connecting flight and transit time\nRemain in the international transit area if not clearing immigration\nIf you must clear immigration, follow the standard visa-free entry process and pay the USD 10 fee\nCarry your onward boarding pass and passport',
    '/assets/images/visa-heroes/haiti.webp',
    'ixigo.com secondary sourcing (cross-checked against akbartravels.com paid-service listing)', 'https://www.ixigo.com/visa-for-indians/haiti-ht', '2026-09-19'
);
SET @hti6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hti6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hti6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @hti6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hti6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@hti6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(169, 6, 0.00, 'USD', 'No Fee for Airside Transit', 'Sourcing conflict flagged: some agencies sell a paid "transit visa" service despite airside transit being visa-free — verify before paying any agency fee.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/haiti-ht', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a transit visa for Haiti?', 'Airside transit is visa-free per most sourcing reviewed. Some travel agencies advertise a paid "transit visa" service — this is flagged as a sourcing conflict, and travellers should verify directly before paying any such fee.', 169, 6, 16960, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    169, 7, 'HTI-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Haiti.',
    'Medical travellers use the same visa-free, 90-day framework as tourists. Note: Haiti\'s own healthcare infrastructure is limited amid its security crisis — this is a highly unusual and not typically recommended destination for inbound medical travel; verify current facility availability directly.',
    'Up to 90 days',
    'No visa needed — pay the USD 10 fee on arrival at the airport',
    0,
    'Not applicable for entry itself. Severe security advisory in effect; verify hospital/clinic availability directly before travel.',
    'No Indian mission in Haiti. Embassy of India, Santo Domingo (Dominican Republic) is concurrently accredited.',
    'Confirm your passport is valid for the intended stay\nConfirm treatment and appointment directly with the Haitian medical facility\nReview the current Government of India travel advisory for Haiti\nBook proof of return/onward ticket\nPay the USD 10 fee on arrival',
    '/assets/images/visa-heroes/haiti.webp',
    'ht.usembassy.gov secondary sourcing', 'https://ht.usembassy.gov/information-for-travelers/', '2026-09-19'
);
SET @hti7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hti7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hti7, 'Core Documents', 'Required from every traveller.', 1);
SET @hti7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hti7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@hti7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hti7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @hti7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hti7s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 1),
(@hti7s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(169, 7, 10.00, 'USD', 'Tourist/Entry Fee (Paid on Arrival)', 'Same USD 10 airport fee applies; there is no separate medical visa.', '2026-01-01', NOW(), 'https://ht.usembassy.gov/information-for-travelers/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for Haiti?', 'No — the same visa-free, 90-day framework applies. Given Haiti\'s limited healthcare infrastructure and severe security situation, verify facility availability and safety directly before travel.', 169, 7, 16970, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    169, 8, 'HTI-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in Haiti.',
    'Conference attendees use the same visa-free, 90-day framework as business travellers.',
    'Up to 90 days',
    'No visa needed — pay the USD 10 fee on arrival at the airport',
    0,
    'Not applicable for entry itself. Severe security advisory in effect for Haiti.',
    'No Indian mission in Haiti. Embassy of India, Santo Domingo (Dominican Republic) is concurrently accredited.',
    'Confirm your passport is valid for the intended stay\nCarry conference invitation/registration confirmation\nReview the current Government of India travel advisory for Haiti\nBook proof of return/onward ticket\nPay the USD 10 fee on arrival',
    '/assets/images/visa-heroes/haiti.webp',
    'ht.usembassy.gov secondary sourcing', 'https://ht.usembassy.gov/information-for-travelers/', '2026-09-19'
);
SET @hti8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hti8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hti8, 'Core Documents', 'Required from every traveller.', 1);
SET @hti8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hti8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@hti8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hti8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @hti8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hti8s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 1),
(@hti8s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(169, 8, 10.00, 'USD', 'Tourist/Entry Fee (Paid on Arrival)', 'Same USD 10 airport fee applies; there is no separate conference visa.', '2026-01-01', NOW(), 'https://ht.usembassy.gov/information-for-travelers/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for Haiti?', 'No — the same visa-free, 90-day framework applies. Only the USD 10 arrival fee is payable.', 169, 8, 16980, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    169, 9, 'HTI-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in Haiti.',
    'Sports travellers use the same visa-free, 90-day framework as tourists.',
    'Up to 90 days',
    'No visa needed — pay the USD 10 fee on arrival at the airport',
    0,
    'Not applicable for entry itself. Severe security advisory in effect for Haiti.',
    'No Indian mission in Haiti. Embassy of India, Santo Domingo (Dominican Republic) is concurrently accredited.',
    'Confirm your passport is valid for the intended stay\nCarry event invitation/participation confirmation\nReview the current Government of India travel advisory for Haiti\nBook proof of return/onward ticket\nPay the USD 10 fee on arrival',
    '/assets/images/visa-heroes/haiti.webp',
    'ht.usembassy.gov secondary sourcing', 'https://ht.usembassy.gov/information-for-travelers/', '2026-09-19'
);
SET @hti9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hti9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hti9, 'Core Documents', 'Required from every traveller.', 1);
SET @hti9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hti9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@hti9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hti9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @hti9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hti9s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 1),
(@hti9s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(169, 9, 10.00, 'USD', 'Tourist/Entry Fee (Paid on Arrival)', 'Same USD 10 airport fee applies; there is no separate sports visa.', '2026-01-01', NOW(), 'https://ht.usembassy.gov/information-for-travelers/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a sports visa for Haiti?', 'No — the same visa-free, 90-day framework applies. Only the USD 10 arrival fee is payable.', 169, 9, 16990, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    169, 10, 'HTI-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent who holds a Haitian work/residence permit.',
    'Dependants enter visa-free like other Indian citizens; if accompanying a work-permit holder for 3+ months, dependants aged 21+ must also obtain their own residence permit from the Direction de l\'Immigration.',
    'Fiscal-year residence permit (Oct 1 - Sep 30), tied to the primary permit holder',
    'Enter visa-free, then file a residence permit at Direction de l\'Immigration, Port-au-Prince, if staying 3+ months',
    1,
    'Residence permit is filed separately for each dependant aged 21+. Severe security advisory in effect for Haiti.',
    'No Indian mission in Haiti. Embassy of India, Santo Domingo (Dominican Republic) is concurrently accredited.',
    'Confirm the primary permit holder\'s work permit and residence permit status\nEnter Haiti visa-free (up to 90 days)\nIf staying 3+ months and aged 21+, file for your own residence permit at the Direction de l\'Immigration\nCarry proof of relationship to the primary permit holder\nRenew the residence permit each fiscal year if continuing to reside in Haiti',
    '/assets/images/visa-heroes/haiti.webp',
    'ht.usembassy.gov secondary sourcing', 'https://ht.usembassy.gov/information-on-obtaining-a-permis-de-sejour/', '2026-09-19'
);
SET @hti10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@hti10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hti10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @hti10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hti10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@hti10s1, 'Proof of Relationship to Primary Permit Holder', NULL, 'original', 1, 0, 1, 2),
(@hti10s1, 'Primary Permit Holder\'s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@hti10, 'Residence Permit Documents (Stays 3+ Months, Age 21+)', 'Required for longer dependant stays.', 2);
SET @hti10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@hti10s2, 'Residence Permit Application (Direction de l\'Immigration)', NULL, 'original', 0, 1, 1, 1),
(@hti10s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(169, 10, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Exact residence permit fees for dependants were not independently confirmed this session — verify with the Direction de l\'Immigration directly.', '2026-01-01', NOW(), 'https://ht.usembassy.gov/information-on-obtaining-a-permis-de-sejour/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do dependants of work-permit holders need their own residence permit in Haiti?', 'Dependants aged 21+ staying 3 or more months typically must file for their own residence permit at the Direction de l\'Immigration, separate from the primary permit holder\'s application.', 169, 10, 16900, 1);
