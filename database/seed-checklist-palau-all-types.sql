-- Palau Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Palau's real, distinctive facts verified this session:
--   - Recent policy simplification: as of 6 June 2025, Indian citizens
--     no longer go through any visa-on-arrival process at all —
--     Palau grants straightforward visa-free entry for up to 30 days,
--     simply presenting a passport on arrival.
--   - Distinctive mandatory fee: every visitor to Palau, regardless of
--     nationality, must pay the "Pristine Paradise Environmental Fee"
--     (PPEF) of USD 100 — airlines are required to bundle this into
--     the ticket price, so it is not a separate visa fee but an
--     unavoidable environmental levy.
--   - Visa-free entry covers tourism/short-stay purposes only —
--     working, volunteering for pay, or business activities require a
--     work permit; only FSM, Marshall Islands, and US nationals are
--     exempt from needing a visa/work permit for other purposes.
--
-- country_id 190 = Palau. visa_type_id: 1=Tourist, 2=Business,
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
    190, 1, 'PLW-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Palau.',
    'Indian citizens can enter Palau visa-free for up to 30 days for tourism — since 6 June 2025, there is no VOA process at all, simply straightforward visa-free entry.',
    'Up to 30 days',
    'No visa needed for tourism — present passport and onward ticket on arrival',
    0,
    'Every visitor must pay the mandatory USD 100 Pristine Paradise Environmental Fee, bundled into the airline ticket price.',
    'No Indian mission in Palau; nearest coverage via India\'s diplomatic missions in the Pacific region',
    'Confirm your passport is valid for 6+ months\nBook proof of return/onward ticket (PPEF is bundled into ticket price)\nGather proof of sufficient funds for your stay\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/palau.webp',
    'ixigo.com and fareeagle.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/palau-pw', '2026-09-19'
);
SET @plw1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@plw1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@plw1, 'Core Documents', 'Required from every traveller.', 1);
SET @plw1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@plw1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@plw1s1, 'Proof of Return/Onward Ticket (PPEF Included)', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@plw1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @plw1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@plw1s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(190, 1, 100.00, 'USD', 'Pristine Paradise Environmental Fee (PPEF)', 'Mandatory for every visitor regardless of nationality, bundled into the airline ticket price. No separate visa fee applies.', '2026-01-01', NOW(), 'https://www.fareeagle.com/palau-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Palau?', 'No — Indian citizens can enter Palau visa-free for up to 30 days for tourism, with no VOA process required since June 2025.', 190, 1, 19000, 1),
('What is the Pristine Paradise Environmental Fee?', 'A mandatory USD 100 environmental levy that every visitor to Palau must pay, bundled into the airline ticket price — not a visa fee.', 190, 1, 19001, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    190, 2, 'PLW-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Palau.',
    'Business travellers can use the same 30-day visa-free framework as tourists for short visits; a work permit is required for formal business activities.',
    'Up to 30 days',
    'No visa needed for short business visits — present passport and onward ticket on arrival',
    0,
    'For formal business activities beyond short meetings, a work permit may be required.',
    'No Indian mission in Palau; nearest coverage via India\'s diplomatic missions in the Pacific region',
    'Confirm your passport is valid for 6+ months\nCarry a business invitation letter from the host organization\nBook proof of return/onward ticket (PPEF included)\nGather proof of sufficient funds\nApply for a work permit if conducting formal business activities',
    '/assets/images/visa-heroes/palau.webp',
    'visitworld.today secondary sourcing', 'https://visitworld.today/palau/india-citizenship/travel', '2026-09-19'
);
SET @plw2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@plw2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@plw2, 'Core Documents', 'Required from every applicant.', 1);
SET @plw2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@plw2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@plw2s1, 'Business Invitation Letter', NULL, 'original', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@plw2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @plw2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@plw2s2, 'Company Sponsorship Letter', NULL, 'copy', 0, 1, 0, 1),
(@plw2s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(190, 2, 100.00, 'USD', 'Pristine Paradise Environmental Fee (PPEF)', 'Same mandatory fee as the tourist visa applies, bundled into the airline ticket price.', '2026-01-01', NOW(), 'https://www.fareeagle.com/palau-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travellers need a visa for Palau?', 'No, for short visits under the visa-free 30-day framework. A work permit is needed for formal business activities.', 190, 2, 19020, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    190, 3, 'PLW-STU-IN-01', '2026.09', 'published',
    'Academic study at a Palau educational institution.',
    'Sources reviewed this session did not describe a dedicated Palau student-visa category — long-term study is expected to require a visa/permit beyond the 30-day visa-free window.',
    'Academic-program length',
    'Enter visa-free, then apply for a longer-stay visa/permit if the program exceeds 30 days',
    1,
    'Not independently confirmed this session whether a distinct student-visa category exists.',
    'No Indian mission in Palau; nearest coverage via India\'s diplomatic missions in the Pacific region',
    'Confirm admission with a Palau educational institution\nGather passport, admission letter, and proof of funds\nEnter Palau visa-free for the initial period\nApply for a longer-stay visa/permit if the program exceeds 30 days\nRegister with the institution on arrival',
    '/assets/images/visa-heroes/palau.webp',
    'atlys.com secondary sourcing', 'https://www.atlys.com/en-US/visa/palau-visa', '2026-09-19'
);
SET @plw3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@plw3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@plw3, 'Core Documents', 'Required from every applicant.', 1);
SET @plw3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@plw3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@plw3s1, 'Proof of Admission/Enrollment Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@plw3, 'Supporting Documents', 'Evidence of your means and academic status.', 2);
SET @plw3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@plw3s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(190, 3, 100.00, 'USD', 'Pristine Paradise Environmental Fee (PPEF, Initial Entry)', 'Longer-stay visa/permit fees were not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.fareeagle.com/palau-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated student visa for Palau?', 'Not independently confirmed this session — enter visa-free for the initial period, then apply for a longer-stay visa/permit if your program exceeds 30 days.', 190, 3, 19030, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    190, 4, 'PLW-WORK-IN-01', '2026.09', 'published',
    'Employment in Palau under a local employer.',
    'Employment is not permitted under visa-free entry — a work permit is required, since only FSM, Marshall Islands, and US nationals are exempt from needing one.',
    'Per work-permit validity, renewable',
    'Employer sponsors your work-permit application',
    1,
    'Not independently confirmed this session: exact work-permit fee and processing time.',
    'No Indian mission in Palau; nearest coverage via India\'s diplomatic missions in the Pacific region',
    'Secure a job offer from a Palau employer\nEmployer sponsors your work-permit application\nGather employment contract and supporting documents\nSubmit your work-permit application as directed\nRegister with local authorities on arrival',
    '/assets/images/visa-heroes/palau.webp',
    'bcbp.pw secondary sourcing', 'https://bcbp.pw/?page_id=165', '2026-09-19'
);
SET @plw4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@plw4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@plw4, 'Core Documents', 'Required from every work-visa applicant.', 1);
SET @plw4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@plw4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@plw4s1, 'Employment Contract/Sponsorship Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@plw4, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @plw4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@plw4s2, 'Educational/Professional Certificates', NULL, 'copy', 0, 1, 0, 1),
(@plw4s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(190, 4, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Work permit fees were not independently confirmed this session.', '2026-01-01', NOW(), 'https://bcbp.pw/?page_id=165', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I work in Palau under visa-free entry?', 'No — employment is not permitted under visa-free entry. A work permit is required, since only FSM, Marshall Islands, and US nationals are exempt.', 190, 4, 19040, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    190, 5, 'PLW-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in Palau.',
    'Family visitors use the same visa-free, 30-day framework as tourists.',
    'Up to 30 days',
    'No visa needed — present passport and onward ticket on arrival',
    0,
    'Every visitor must pay the mandatory USD 100 Pristine Paradise Environmental Fee.',
    'No Indian mission in Palau; nearest coverage via India\'s diplomatic missions in the Pacific region',
    'Confirm your passport is valid for 6+ months\nBook proof of return/onward ticket (PPEF included)\nCarry proof of relationship and host contact details\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/palau.webp',
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/palau-pw', '2026-09-19'
);
SET @plw5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@plw5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@plw5, 'Core Documents', 'Required from every traveller.', 1);
SET @plw5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@plw5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@plw5s1, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@plw5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @plw5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@plw5s2, 'Host Invitation Letter', NULL, 'copy', 0, 1, 0, 1),
(@plw5s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(190, 5, 100.00, 'USD', 'Pristine Paradise Environmental Fee (PPEF)', 'Same mandatory fee as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.fareeagle.com/palau-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit family in Palau?', 'No — the same visa-free, 30-day framework applies as for tourist travel.', 190, 5, 19050, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    190, 6, 'PLW-TRAN-IN-01', '2026.09', 'published',
    'Transit through Palau en route to another destination.',
    'Given Palau\'s visa-free tourist entry framework, short transit is expected to be covered by the same visa-free rules.',
    'Short transit, within the visa-free framework',
    'No visa needed for short transit — present passport and onward ticket',
    0,
    'Verify whether the PPEF applies to pure airside transit versus full entry.',
    'No Indian mission in Palau',
    'Confirm your connecting flight and transit time\nConfirm your passport is valid for 6+ months\nCarry your onward boarding pass and passport\nCarry all documents for immigration if clearing customs',
    '/assets/images/visa-heroes/palau.webp',
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/palau-pw', '2026-09-19'
);
SET @plw6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@plw6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@plw6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @plw6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@plw6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@plw6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(190, 6, 0.00, 'USD', 'No Fee for Visa-Free Transit', 'Whether the PPEF applies to pure airside transit was not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/palau-pw', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a transit visa for Palau?', 'No — short transit is expected to be covered by the same visa-free tourist framework as other short visits.', 190, 6, 19060, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    190, 7, 'PLW-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Palau.',
    'Medical travellers use the same visa-free, 30-day framework as tourists. Note: local medical infrastructure is limited; serious treatment is often referred overseas.',
    'Up to 30 days',
    'No visa needed — present passport and onward ticket on arrival',
    0,
    'Confirm treatment availability directly given limited local medical infrastructure.',
    'No Indian mission in Palau',
    'Confirm treatment and appointment directly with the Palau medical facility\nConfirm your passport is valid for 6+ months\nBook proof of return/onward ticket (PPEF included)\nGather proof of sufficient funds\nCarry all medical and travel documents for immigration',
    '/assets/images/visa-heroes/palau.webp',
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/palau-pw', '2026-09-19'
);
SET @plw7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@plw7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@plw7, 'Core Documents', 'Required from every traveller.', 1);
SET @plw7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@plw7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@plw7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@plw7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @plw7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@plw7s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(190, 7, 100.00, 'USD', 'Pristine Paradise Environmental Fee (PPEF)', 'Same mandatory fee as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.fareeagle.com/palau-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for Palau?', 'No separate medical visa — the same visa-free, 30-day framework applies. Given limited local medical infrastructure, confirm treatment availability directly beforehand.', 190, 7, 19070, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    190, 8, 'PLW-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in Palau.',
    'Conference attendees use the same visa-free, 30-day framework as tourists.',
    'Up to 30 days',
    'No visa needed — present passport and onward ticket on arrival',
    0,
    'Every visitor must pay the mandatory USD 100 Pristine Paradise Environmental Fee.',
    'No Indian mission in Palau',
    'Confirm your passport is valid for 6+ months\nCarry conference invitation/registration confirmation\nBook proof of return/onward ticket (PPEF included)\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/palau.webp',
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/palau-pw', '2026-09-19'
);
SET @plw8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@plw8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@plw8, 'Core Documents', 'Required from every traveller.', 1);
SET @plw8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@plw8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@plw8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@plw8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @plw8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@plw8s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(190, 8, 100.00, 'USD', 'Pristine Paradise Environmental Fee (PPEF)', 'Same mandatory fee as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.fareeagle.com/palau-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for Palau?', 'No separate conference visa — the same visa-free, 30-day framework applies.', 190, 8, 19080, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    190, 9, 'PLW-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in Palau.',
    'Sports travellers use the same visa-free, 30-day framework as tourists.',
    'Up to 30 days',
    'No visa needed — present passport and onward ticket on arrival',
    0,
    'Every visitor must pay the mandatory USD 100 Pristine Paradise Environmental Fee.',
    'No Indian mission in Palau',
    'Confirm your passport is valid for 6+ months\nCarry event invitation/participation confirmation\nBook proof of return/onward ticket (PPEF included)\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/palau.webp',
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/palau-pw', '2026-09-19'
);
SET @plw9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@plw9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@plw9, 'Core Documents', 'Required from every traveller.', 1);
SET @plw9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@plw9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@plw9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@plw9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @plw9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@plw9s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(190, 9, 100.00, 'USD', 'Pristine Paradise Environmental Fee (PPEF)', 'Same mandatory fee as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.fareeagle.com/palau-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a sports visa for Palau?', 'No separate sports visa — the same visa-free, 30-day framework applies.', 190, 9, 19090, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    190, 10, 'PLW-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent who holds a Palau work permit.',
    'Dependants enter visa-free like other Indian citizens for short visits; longer stays alongside a work-permit holder are expected to require their own permit.',
    'Tied to the primary permit holder\'s work-permit validity',
    'Enter visa-free, then apply for dependant status if staying beyond 30 days',
    1,
    'Not independently confirmed this session: exact dependant process and fee.',
    'No Indian mission in Palau',
    'Confirm the primary permit holder\'s work-permit status\nGather proof of relationship (marriage/birth certificate)\nEnter Palau visa-free (up to 30 days)\nApply for dependant status locally if staying longer\nRenew alongside the primary permit holder',
    '/assets/images/visa-heroes/palau.webp',
    'bcbp.pw secondary sourcing', 'https://bcbp.pw/?page_id=165', '2026-09-19'
);
SET @plw10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@plw10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@plw10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @plw10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@plw10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@plw10s1, 'Proof of Relationship to Primary Permit Holder', NULL, 'original', 1, 0, 1, 2),
(@plw10s1, 'Primary Permit Holder\'s Work Permit Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@plw10, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @plw10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@plw10s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(190, 10, 100.00, 'USD', 'Pristine Paradise Environmental Fee (PPEF, Initial Entry)', 'Dependant status fees beyond the PPEF were not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.fareeagle.com/palau-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do dependants of work-permit holders need their own permit in Palau?', 'Expected to be required for stays beyond 30 days — not independently confirmed this session.', 190, 10, 19000, 1);
