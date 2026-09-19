-- Mauritania Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Mauritania's real, distinctive facts verified this session:
--   - Indian citizens can enter Mauritania visa-free for tourism/
--     short-stay purposes, granted 30-90 days at the port of entry.
--     An eVisa is also available if needed, but is not required for
--     short stays.
--   - Distinctive restriction: visa-free entry covers tourism and
--     short-stay purposes only — working, volunteering for pay, or
--     conducting business activities is not permitted without a work
--     permit or appropriate visa.
--   - Work visas require proof of Yellow Fever vaccination and
--     payment to the Mauritanian embassy via money order or check.
--   - India maintains its own Embassy of India in Nouakchott, with a
--     published visa-fees page, indicating active bilateral consular
--     engagement.
--
-- country_id 32 = Mauritania. visa_type_id: 1=Tourist, 2=Business,
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
    32, 1, 'MRT-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Mauritania.',
    'Indian citizens can enter Mauritania visa-free for tourism, granted 30-90 days at the port of entry. An eVisa is also available if needed, but is not required for short tourist stays.',
    '30-90 days',
    'No visa needed for tourism — present passport and onward ticket on arrival',
    0,
    'Not applicable for entry itself. Visa-free entry covers tourism/short-stay purposes only.',
    'No Mauritanian mission required for short visa-free stays; Embassy of India, Nouakchott, provides consular support',
    'Confirm your passport is valid for 6+ months\nBook proof of return/onward ticket\nGather proof of accommodation and sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/hi/mauritania-mr', '2026-09-19'
);
SET @mrt1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mrt1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mrt1, 'Core Documents', 'Required from every traveller.', 1);
SET @mrt1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mrt1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mrt1s1, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mrt1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mrt1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mrt1s2, 'Proof of Accommodation', NULL, 'copy', 1, 0, 0, 1),
(@mrt1s2, 'Proof of Sufficient Funds', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(32, 1, 0.00, 'USD', 'No Visa Fee for Visa-Free Entry', 'An optional eVisa (if not relying on visa-free entry) starts around USD 60 per agency sourcing.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/mauritania-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Mauritania?', 'No — Indian citizens can enter Mauritania visa-free for tourism, granted 30-90 days at the port of entry.', 32, 1, 3200, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    32, 2, 'MRT-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Mauritania.',
    'Visa-free entry covers tourism/short-stay purposes only — conducting business activities requires a work permit or appropriate visa rather than the visa-free route.',
    'Per visa validity if a business visa is required',
    'Apply for the eVisa or an embassy business visa if conducting formal business activities',
    0,
    'Distinguish short business meetings (may use visa-free entry) from active business/commercial activity (requires a proper visa).',
    'Embassy of Mauritania (nearest mission) or eVisa portal',
    'Confirm your passport is valid for 6+ months\nDetermine whether your activity requires a business visa rather than visa-free entry\nApply for the eVisa if conducting formal business activities\nCarry a business invitation letter from the host organization\nGather proof of sufficient funds',
    NULL,
    'ixigo.com and globalization-partners.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/hi/mauritania-mr', '2026-09-19'
);
SET @mrt2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mrt2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mrt2, 'Core Documents', 'Required from every applicant.', 1);
SET @mrt2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mrt2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mrt2s1, 'Business Invitation Letter', NULL, 'original', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mrt2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @mrt2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mrt2s2, 'Company Sponsorship Letter', NULL, 'copy', 0, 1, 0, 1),
(@mrt2s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(32, 2, 60.00, 'USD', 'eVisa Fee (If Required)', 'Not required for short business meetings under visa-free entry; applies if conducting formal business activity.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/mauritania-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travellers need a visa for Mauritania?', 'For short business meetings, visa-free entry may suffice; formal business/commercial activity requires an eVisa or appropriate visa instead.', 32, 2, 3220, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    32, 3, 'MRT-STU-IN-01', '2026.09', 'published',
    'Academic study at a Mauritanian educational institution.',
    'Sources reviewed this session did not describe a dedicated Mauritania student-visa category distinct from the general eVisa/embassy visa process, applied for once admission is secured.',
    'Study-program length, renewable',
    'Apply via the eVisa portal or nearest Mauritanian embassy, with a university admission letter',
    1,
    'Not independently confirmed this session whether a distinct student-visa category exists.',
    'Embassy of Mauritania (nearest mission) or eVisa portal',
    'Confirm admission with a Mauritanian educational institution\nGather passport, admission letter, and proof of funds\nApply via the eVisa portal or nearest Mauritanian embassy\nGet Yellow Fever vaccination if required\nRegister with local authorities after arrival',
    NULL,
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/hi/mauritania-mr', '2026-09-19'
);
SET @mrt3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mrt3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mrt3, 'Core Documents', 'Required from every applicant.', 1);
SET @mrt3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mrt3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mrt3s1, 'Proof of Admission/Enrollment Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mrt3, 'Supporting Documents', 'Evidence of your means and academic status.', 2);
SET @mrt3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mrt3s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@mrt3s2, 'Yellow Fever Vaccination Certificate', NULL, 'original', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(32, 3, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Student visa fees were not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/hi/mauritania-mr', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated student visa for Mauritania?', 'Not independently confirmed this session — apply via the eVisa portal or nearest embassy once admission is secured.', 32, 3, 3230, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    32, 4, 'MRT-WORK-IN-01', '2026.09', 'published',
    'Employment in Mauritania under a local employer.',
    'The visa-free tourist route cannot be used for employment — a distinct work visa is required, with proof of Yellow Fever vaccination and payment to the Mauritanian embassy via money order or check.',
    'Per work-visa validity, renewable',
    'Employer sponsors your work-visa application; submit payment via money order/check to the Mauritanian embassy',
    1,
    'Not independently confirmed this session: exact work-visa fee amount.',
    'Nearest Embassy of Mauritania',
    'Secure a job offer from a Mauritanian employer\nGather employment contract/sponsorship letter\nGet the Yellow Fever vaccination and certificate\nSubmit your work-visa application with payment via money order/check\nRegister with local labour authorities on arrival',
    NULL,
    'globalization-partners.com secondary sourcing', 'https://www.globalization-partners.com/globalpedia/mauritania/visa-permits/', '2026-09-19'
);
SET @mrt4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mrt4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mrt4, 'Core Documents', 'Required from every work-visa applicant.', 1);
SET @mrt4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mrt4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mrt4s1, 'Employment Contract/Sponsorship Letter', NULL, 'original', 1, 0, 1, 2),
(@mrt4s1, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mrt4, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @mrt4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mrt4s2, 'Educational/Professional Certificates', NULL, 'copy', 0, 1, 0, 1),
(@mrt4s2, 'Payment (Money Order/Check to Embassy)', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(32, 4, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Work visa fees were not independently confirmed this session — paid via money order/check to the embassy.', '2026-01-01', NOW(), 'https://www.globalization-partners.com/globalpedia/mauritania/visa-permits/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I work in Mauritania on visa-free tourist entry?', 'No — the visa-free tourist route cannot be used for employment. A distinct work visa is required, with proof of Yellow Fever vaccination.', 32, 4, 3240, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    32, 5, 'MRT-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in Mauritania.',
    'Family visitors use the same visa-free, 30-90 day framework as tourists.',
    '30-90 days',
    'No visa needed — present passport and onward ticket on arrival',
    0,
    'Not applicable for entry itself.',
    'No Mauritanian mission required for short visa-free stays; Embassy of India, Nouakchott, provides consular support',
    'Confirm your passport is valid for 6+ months\nBook proof of return/onward ticket\nCarry proof of relationship and host contact details\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/hi/mauritania-mr', '2026-09-19'
);
SET @mrt5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mrt5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mrt5, 'Core Documents', 'Required from every traveller.', 1);
SET @mrt5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mrt5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mrt5s1, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mrt5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mrt5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mrt5s2, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 0, 1),
(@mrt5s2, 'Proof of Sufficient Funds', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(32, 5, 0.00, 'USD', 'No Visa Fee for Visa-Free Entry', 'No fee applies for the visa-free entry.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/hi/mauritania-mr', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit family in Mauritania?', 'No — the same visa-free, 30-90 day framework applies as for tourist travel.', 32, 5, 3250, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    32, 6, 'MRT-TRAN-IN-01', '2026.09', 'published',
    'Transit through Mauritania en route to another destination.',
    'Given Mauritania\'s visa-free tourist entry framework, short transit is expected to be covered by the same visa-free rules.',
    'Short transit, within the visa-free framework',
    'No visa needed for short transit — present passport and onward ticket',
    0,
    'Not applicable for entry itself.',
    'No Mauritanian mission required for short visa-free stays',
    'Confirm your connecting flight and transit time\nConfirm your passport is valid for 6+ months\nCarry your onward boarding pass and passport\nCarry all documents for immigration if clearing customs',
    NULL,
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/hi/mauritania-mr', '2026-09-19'
);
SET @mrt6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mrt6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mrt6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @mrt6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mrt6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mrt6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(32, 6, 0.00, 'USD', 'No Fee for Visa-Free Transit', 'No fee applies within the visa-free tourist framework.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/hi/mauritania-mr', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a transit visa for Mauritania?', 'No — short transit is expected to be covered by the same visa-free tourist framework as other short visits.', 32, 6, 3260, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    32, 7, 'MRT-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Mauritania.',
    'Medical travellers use the same visa-free, 30-90 day framework as tourists.',
    '30-90 days',
    'No visa needed — present passport and onward ticket on arrival',
    0,
    'Not applicable for entry itself.',
    'No Mauritanian mission required for short visa-free stays; Embassy of India, Nouakchott, provides consular support',
    'Confirm treatment and appointment directly with the Mauritanian medical facility\nConfirm your passport is valid for 6+ months\nBook proof of return/onward ticket\nGather proof of sufficient funds\nCarry all medical and travel documents for immigration',
    NULL,
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/hi/mauritania-mr', '2026-09-19'
);
SET @mrt7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mrt7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mrt7, 'Core Documents', 'Required from every traveller.', 1);
SET @mrt7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mrt7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mrt7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mrt7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mrt7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mrt7s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@mrt7s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(32, 7, 0.00, 'USD', 'No Visa Fee for Visa-Free Entry', 'No fee applies for the visa-free entry.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/hi/mauritania-mr', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for Mauritania?', 'No separate medical visa — the same visa-free, 30-90 day framework applies.', 32, 7, 3270, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    32, 8, 'MRT-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in Mauritania.',
    'Conference attendees use the same visa-free, 30-90 day framework as tourists.',
    '30-90 days',
    'No visa needed — present passport and onward ticket on arrival',
    0,
    'Not applicable for entry itself.',
    'No Mauritanian mission required for short visa-free stays',
    'Confirm your passport is valid for 6+ months\nCarry conference invitation/registration confirmation\nBook proof of return/onward ticket\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/hi/mauritania-mr', '2026-09-19'
);
SET @mrt8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mrt8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mrt8, 'Core Documents', 'Required from every traveller.', 1);
SET @mrt8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mrt8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mrt8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mrt8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mrt8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mrt8s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@mrt8s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(32, 8, 0.00, 'USD', 'No Visa Fee for Visa-Free Entry', 'No fee applies for the visa-free entry.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/hi/mauritania-mr', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for Mauritania?', 'No separate conference visa — the same visa-free, 30-90 day framework applies.', 32, 8, 3280, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    32, 9, 'MRT-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in Mauritania.',
    'Sports travellers use the same visa-free, 30-90 day framework as tourists.',
    '30-90 days',
    'No visa needed — present passport and onward ticket on arrival',
    0,
    'Not applicable for entry itself.',
    'No Mauritanian mission required for short visa-free stays',
    'Confirm your passport is valid for 6+ months\nCarry event invitation/participation confirmation\nBook proof of return/onward ticket\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/hi/mauritania-mr', '2026-09-19'
);
SET @mrt9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mrt9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mrt9, 'Core Documents', 'Required from every traveller.', 1);
SET @mrt9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mrt9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mrt9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mrt9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mrt9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mrt9s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@mrt9s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(32, 9, 0.00, 'USD', 'No Visa Fee for Visa-Free Entry', 'No fee applies for the visa-free entry.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/hi/mauritania-mr', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a sports visa for Mauritania?', 'No separate sports visa — the same visa-free, 30-90 day framework applies.', 32, 9, 3290, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    32, 10, 'MRT-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent who holds a Mauritania work visa.',
    'Dependants enter visa-free like other Indian citizens for short visits; longer stays alongside a work-visa holder are expected to require their own visa application.',
    'Tied to the primary permit holder\'s work-visa validity',
    'Enter visa-free, then apply for a dependant visa at the nearest Mauritanian embassy if staying long-term',
    1,
    'Not independently confirmed this session: exact dependant-visa fee and process.',
    'Nearest Embassy of Mauritania',
    'Confirm the primary permit holder\'s work-visa status\nGather proof of relationship (marriage/birth certificate)\nEnter Mauritania visa-free (30-90 days)\nApply for a dependant visa at the nearest embassy if staying long-term\nGet the Yellow Fever vaccination if required',
    NULL,
    'globalization-partners.com secondary sourcing', 'https://www.globalization-partners.com/globalpedia/mauritania/visa-permits/', '2026-09-19'
);
SET @mrt10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mrt10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mrt10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @mrt10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mrt10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mrt10s1, 'Proof of Relationship to Primary Permit Holder', NULL, 'original', 1, 0, 1, 2),
(@mrt10s1, 'Primary Permit Holder\'s Work Visa Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mrt10, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @mrt10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mrt10s2, 'Yellow Fever Vaccination Certificate', NULL, 'original', 0, 1, 0, 1),
(@mrt10s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(32, 10, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Dependant visa fees were not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.globalization-partners.com/globalpedia/mauritania/visa-permits/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do dependants of work-visa holders need their own visa in Mauritania?', 'Expected to be required for stays beyond the visa-free window, filed separately from the primary work-visa holder — not independently confirmed this session.', 32, 10, 3200, 1);
