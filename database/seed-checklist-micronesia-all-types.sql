-- Micronesia (Federated States of) Visa Checklist Engine content for
-- all 10 visa types — built fresh this session via web search.
--
-- Micronesia's real, distinctive facts verified this session:
--   - Indian citizens can enter Micronesia visa-free for up to 30 days
--     for tourism — no fee applies.
--   - Sourcing note: passport-validity guidance conflicts slightly
--     across sources (6 months vs. 120 days beyond the stay) — 6
--     months is used here as the more commonly cited, safer figure.
--   - Employment is not permitted under visa-free entry — a work
--     permit/visa is required, needing an employment offer letter,
--     medical certificate, and police clearance certificate.
--   - An Arrival/Departure immigration form must be completed, usually
--     provided during the flight or on arrival.
--
-- country_id 186 = Micronesia. visa_type_id: 1=Tourist, 2=Business,
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
    186, 1, 'FSM-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Micronesia.',
    'Indian citizens can enter Micronesia visa-free for up to 30 days for tourism — no fee applies.',
    'Up to 30 days',
    'No visa needed for tourism — present passport and complete the Arrival/Departure form on arrival',
    0,
    'Not applicable for entry itself. Passport validity guidance varies by source (6 months vs. 120 days) — 6 months is safer.',
    'No Indian mission in Micronesia; nearest coverage via India\'s diplomatic missions in the Pacific region',
    'Confirm your passport is valid for 6+ months\nBook proof of return/onward ticket\nGather proof of sufficient funds for your stay\nComplete the Arrival/Departure immigration form\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/micronesia.webp',
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/micronesia-fm', '2026-09-19'
);
SET @fsm1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fsm1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fsm1, 'Core Documents', 'Required from every traveller.', 1);
SET @fsm1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fsm1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@fsm1s1, 'Arrival/Departure Immigration Form', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fsm1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @fsm1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fsm1s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 1),
(@fsm1s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(186, 1, 0.00, 'USD', 'No Visa Fee for Visa-Free Entry', 'No fee applies for the visa-free 30-day entry.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/micronesia-fm', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Micronesia?', 'No — Indian citizens can enter Micronesia visa-free for up to 30 days for tourism.', 186, 1, 18600, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    186, 2, 'FSM-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Micronesia.',
    'Business travellers use the same visa-free, 30-day framework as tourists.',
    'Up to 30 days',
    'No visa needed — present passport and complete the Arrival/Departure form on arrival',
    0,
    'Not applicable for entry itself.',
    'No Indian mission in Micronesia; nearest coverage via India\'s diplomatic missions in the Pacific region',
    'Confirm your passport is valid for 6+ months\nCarry a business invitation letter from the host organization\nComplete the Arrival/Departure immigration form\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/micronesia.webp',
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/micronesia-fm', '2026-09-19'
);
SET @fsm2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fsm2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fsm2, 'Core Documents', 'Required from every traveller.', 1);
SET @fsm2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fsm2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@fsm2s1, 'Business Invitation Letter', NULL, 'original', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fsm2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @fsm2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fsm2s2, 'Company Sponsorship Letter', NULL, 'copy', 0, 1, 0, 1),
(@fsm2s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(186, 2, 0.00, 'USD', 'No Visa Fee for Visa-Free Entry', 'No fee applies for the visa-free 30-day entry.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/micronesia-fm', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travellers need a visa for Micronesia?', 'No — the same visa-free, 30-day framework applies as for tourist travel.', 186, 2, 18620, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    186, 3, 'FSM-STU-IN-01', '2026.09', 'published',
    'Academic study at a Micronesia educational institution.',
    'Sources reviewed this session did not describe a dedicated Micronesia student-visa category distinct from the general entry framework and local registration once admission is secured.',
    'Study-program length, via local registration',
    'Enter visa-free, then register with the institution and immigration authorities after arrival',
    1,
    'Not independently confirmed this session whether a distinct student-visa category exists.',
    'No Indian mission in Micronesia; nearest coverage via India\'s diplomatic missions in the Pacific region',
    'Confirm admission with a Micronesia educational institution\nGather passport, admission letter, and proof of funds\nEnter Micronesia visa-free, or apply for a visa if the stay exceeds 30 days\nRegister with the institution and immigration authorities\nRenew your status as required for continued study',
    '/assets/images/visa-heroes/micronesia.webp',
    'visahq.in secondary sourcing', 'https://www.visahq.in/micronesia/', '2026-09-19'
);
SET @fsm3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fsm3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fsm3, 'Core Documents', 'Required from every applicant.', 1);
SET @fsm3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fsm3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@fsm3s1, 'Proof of Admission/Enrollment Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fsm3, 'Supporting Documents', 'Evidence of your means and academic status.', 2);
SET @fsm3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fsm3s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@fsm3s2, 'Medical Certificate', NULL, 'original', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(186, 3, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Student visa fees were not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.visahq.in/micronesia/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated student visa for Micronesia?', 'Not independently confirmed this session — enter visa-free for short stays, then register with your institution for longer academic programs.', 186, 3, 18630, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    186, 4, 'FSM-WORK-IN-01', '2026.09', 'published',
    'Employment in Micronesia under a local employer.',
    'Employment is not permitted under visa-free entry — a distinct work permit/visa is required, needing an employment offer letter, medical certificate, and police clearance certificate.',
    'Per work-permit validity, renewable',
    'Employer sponsors your work-permit application',
    1,
    'Not independently confirmed this session: exact work-permit fee and processing time.',
    'No Indian mission in Micronesia; nearest coverage via India\'s diplomatic missions in the Pacific region',
    'Secure a job offer from a Micronesia employer\nEmployer sponsors your work-permit application\nGather medical certificate and police clearance certificate\nSubmit your work-permit application as directed\nRegister with local authorities on arrival',
    '/assets/images/visa-heroes/micronesia.webp',
    'visitworld.today secondary sourcing', 'https://visitworld.today/micronesia/india-citizenship/work', '2026-09-19'
);
SET @fsm4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fsm4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fsm4, 'Core Documents', 'Required from every work-visa applicant.', 1);
SET @fsm4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fsm4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@fsm4s1, 'Employment Offer Letter', NULL, 'original', 1, 0, 1, 2),
(@fsm4s1, 'Police Clearance Certificate', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fsm4, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @fsm4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fsm4s2, 'Medical Certificate', NULL, 'original', 1, 0, 0, 1),
(@fsm4s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(186, 4, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Work permit fees were not independently confirmed this session.', '2026-01-01', NOW(), 'https://visitworld.today/micronesia/india-citizenship/work', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I work in Micronesia under visa-free entry?', 'No — employment is not permitted under visa-free entry. A distinct work permit/visa is required, with an employment offer letter, medical certificate, and police clearance certificate.', 186, 4, 18640, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    186, 5, 'FSM-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in Micronesia.',
    'Family visitors use the same visa-free, 30-day framework as tourists.',
    'Up to 30 days',
    'No visa needed — present passport and complete the Arrival/Departure form on arrival',
    0,
    'Not applicable for entry itself.',
    'No Indian mission in Micronesia; nearest coverage via India\'s diplomatic missions in the Pacific region',
    'Confirm your passport is valid for 6+ months\nBook proof of return/onward ticket\nCarry proof of relationship and host contact details\nGather proof of sufficient funds\nComplete the Arrival/Departure immigration form',
    '/assets/images/visa-heroes/micronesia.webp',
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/micronesia-fm', '2026-09-19'
);
SET @fsm5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fsm5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fsm5, 'Core Documents', 'Required from every traveller.', 1);
SET @fsm5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fsm5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@fsm5s1, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fsm5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @fsm5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fsm5s2, 'Host Invitation Letter', NULL, 'copy', 0, 1, 0, 1),
(@fsm5s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(186, 5, 0.00, 'USD', 'No Visa Fee for Visa-Free Entry', 'No fee applies for the visa-free 30-day entry.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/micronesia-fm', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit family in Micronesia?', 'No — the same visa-free, 30-day framework applies as for tourist travel.', 186, 5, 18650, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    186, 6, 'FSM-TRAN-IN-01', '2026.09', 'published',
    'Transit through Micronesia en route to another destination.',
    'Given Micronesia\'s visa-free tourist entry framework, short transit is expected to be covered by the same visa-free rules.',
    'Short transit, within the visa-free framework',
    'No visa needed for short transit — present passport and onward ticket',
    0,
    'Not applicable for entry itself.',
    'No Indian mission in Micronesia',
    'Confirm your connecting flight and transit time\nConfirm your passport is valid for 6+ months\nCarry your onward boarding pass and passport\nComplete the Arrival/Departure immigration form if clearing customs',
    '/assets/images/visa-heroes/micronesia.webp',
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/micronesia-fm', '2026-09-19'
);
SET @fsm6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fsm6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fsm6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @fsm6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fsm6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@fsm6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(186, 6, 0.00, 'USD', 'No Fee for Visa-Free Transit', 'No fee applies within the visa-free tourist framework.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/micronesia-fm', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a transit visa for Micronesia?', 'No — short transit is expected to be covered by the same visa-free tourist framework as other short visits.', 186, 6, 18660, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    186, 7, 'FSM-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Micronesia.',
    'Medical travellers use the same visa-free, 30-day framework as tourists. Note: local medical infrastructure is limited; serious treatment is often referred overseas.',
    'Up to 30 days',
    'No visa needed — present passport and complete the Arrival/Departure form on arrival',
    0,
    'Confirm treatment availability directly given limited local medical infrastructure.',
    'No Indian mission in Micronesia',
    'Confirm treatment and appointment directly with the Micronesia medical facility\nConfirm your passport is valid for 6+ months\nBook proof of return/onward ticket\nGather proof of sufficient funds\nCarry all medical and travel documents for immigration',
    '/assets/images/visa-heroes/micronesia.webp',
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/micronesia-fm', '2026-09-19'
);
SET @fsm7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fsm7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fsm7, 'Core Documents', 'Required from every traveller.', 1);
SET @fsm7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fsm7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@fsm7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fsm7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @fsm7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fsm7s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@fsm7s2, 'Confirmed Onward/Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(186, 7, 0.00, 'USD', 'No Visa Fee for Visa-Free Entry', 'No fee applies for the visa-free 30-day entry.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/micronesia-fm', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for Micronesia?', 'No separate medical visa — the same visa-free, 30-day framework applies. Given limited local medical infrastructure, confirm treatment availability directly beforehand.', 186, 7, 18670, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    186, 8, 'FSM-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in Micronesia.',
    'Conference attendees use the same visa-free, 30-day framework as tourists.',
    'Up to 30 days',
    'No visa needed — present passport and complete the Arrival/Departure form on arrival',
    0,
    'Not applicable for entry itself.',
    'No Indian mission in Micronesia',
    'Confirm your passport is valid for 6+ months\nCarry conference invitation/registration confirmation\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/micronesia.webp',
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/micronesia-fm', '2026-09-19'
);
SET @fsm8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fsm8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fsm8, 'Core Documents', 'Required from every traveller.', 1);
SET @fsm8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fsm8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@fsm8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fsm8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @fsm8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fsm8s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@fsm8s2, 'Confirmed Onward/Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(186, 8, 0.00, 'USD', 'No Visa Fee for Visa-Free Entry', 'No fee applies for the visa-free 30-day entry.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/micronesia-fm', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for Micronesia?', 'No separate conference visa — the same visa-free, 30-day framework applies.', 186, 8, 18680, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    186, 9, 'FSM-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in Micronesia.',
    'Sports travellers use the same visa-free, 30-day framework as tourists.',
    'Up to 30 days',
    'No visa needed — present passport and complete the Arrival/Departure form on arrival',
    0,
    'Not applicable for entry itself.',
    'No Indian mission in Micronesia',
    'Confirm your passport is valid for 6+ months\nCarry event invitation/participation confirmation\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/micronesia.webp',
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/micronesia-fm', '2026-09-19'
);
SET @fsm9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fsm9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fsm9, 'Core Documents', 'Required from every traveller.', 1);
SET @fsm9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fsm9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@fsm9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fsm9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @fsm9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fsm9s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@fsm9s2, 'Confirmed Onward/Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(186, 9, 0.00, 'USD', 'No Visa Fee for Visa-Free Entry', 'No fee applies for the visa-free 30-day entry.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/micronesia-fm', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a sports visa for Micronesia?', 'No separate sports visa — the same visa-free, 30-day framework applies.', 186, 9, 18690, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    186, 10, 'FSM-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent who holds a Micronesia work permit.',
    'Dependants enter visa-free like other Indian citizens for short visits; longer stays alongside a work-permit holder are expected to require their own application.',
    'Tied to the primary permit holder\'s work-permit validity',
    'Enter visa-free, then apply for dependant status if staying beyond 30 days',
    1,
    'Not independently confirmed this session: exact dependant process and fee.',
    'No Indian mission in Micronesia',
    'Confirm the primary permit holder\'s work-permit status\nGather proof of relationship (marriage/birth certificate)\nEnter Micronesia visa-free (up to 30 days)\nApply for dependant status locally if staying longer\nRenew alongside the primary permit holder',
    '/assets/images/visa-heroes/micronesia.webp',
    'visitworld.today secondary sourcing', 'https://visitworld.today/micronesia/india-citizenship/work', '2026-09-19'
);
SET @fsm10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fsm10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fsm10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @fsm10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fsm10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@fsm10s1, 'Proof of Relationship to Primary Permit Holder', NULL, 'original', 1, 0, 1, 2),
(@fsm10s1, 'Primary Permit Holder\'s Work Permit Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fsm10, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @fsm10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fsm10s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@fsm10s2, 'Medical Certificate', NULL, 'original', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(186, 10, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Dependant status fees were not independently confirmed this session.', '2026-01-01', NOW(), 'https://visitworld.today/micronesia/india-citizenship/work', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do dependants of work-permit holders need their own status in Micronesia?', 'Expected to be required for stays beyond 30 days — not independently confirmed this session.', 186, 10, 18600, 1);
