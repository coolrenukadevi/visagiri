-- Marshall Islands Visa Checklist Engine content for all 10 visa types
-- — built fresh this session via web search.
--
-- Marshall Islands's real, distinctive facts verified this session:
--   - Indian citizens can enter the Marshall Islands visa-free for up
--     to 90 days, including airside transit and short layovers outside
--     the international zone.
--   - Non-visa-free purposes use a Visitor visa (V-1), a non-refundable
--     USD 100 application fee.
--   - Work visas require the employer to first obtain a work permit,
--     then the applicant applies at the nearest Marshall Islands
--     mission — issued for 2 years.
--   - The Marshall Islands has no resident embassy in India: the
--     Embassy in Tokyo, Japan is concurrently accredited to India, and
--     there is a Marshall Islands Honorary Consulate in New Delhi plus
--     a Consulate in Mumbai for consular services.
--
-- country_id 185 = Marshall Islands. visa_type_id: 1=Tourist,
-- 2=Business, 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical,
-- 8=Conference, 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    185, 1, 'MHL-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to the Marshall Islands.',
    'Indian citizens can enter the Marshall Islands visa-free for up to 90 days for tourism.',
    'Up to 90 days',
    'No visa needed for tourism — present passport and onward ticket on arrival',
    0,
    'Not applicable for entry itself.',
    'Honorary Consulate of Marshall Islands, New Delhi; Consulate, Mumbai; Embassy in Tokyo, Japan (concurrently accredited to India)',
    'Confirm your passport is valid for 6+ months\nBook proof of onward/return ticket\nGather proof of accommodation and sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/marshall-islands-mh', '2026-09-19'
);
SET @mhl1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mhl1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mhl1, 'Core Documents', 'Required from every traveller.', 1);
SET @mhl1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mhl1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mhl1s1, 'Confirmed Onward/Return Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mhl1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mhl1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mhl1s2, 'Proof of Accommodation', NULL, 'copy', 1, 0, 0, 1),
(@mhl1s2, 'Proof of Sufficient Funds', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(185, 1, 0.00, 'USD', 'No Visa Fee for Visa-Free Entry', 'No fee applies for the visa-free 90-day tourist entry.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/marshall-islands-mh', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for the Marshall Islands?', 'No — Indian citizens can enter the Marshall Islands visa-free for up to 90 days for tourism.', 185, 1, 18500, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    185, 2, 'MHL-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in the Marshall Islands.',
    'Business travellers can use the same 90-day visa-free entry as tourists for short trips; a Visitor visa (V-1, USD 100) covers other non-tourism purposes.',
    'Up to 90 days',
    'No visa needed for short business visits — present passport and onward ticket on arrival',
    0,
    'For longer or formal business stays, apply for the Visitor visa (V-1) instead.',
    'Honorary Consulate of Marshall Islands, New Delhi; Consulate, Mumbai',
    'Confirm your passport is valid for 6+ months\nCarry a business invitation letter from the host organization\nBook proof of onward/return ticket\nGather proof of sufficient funds\nApply for a Visitor visa (V-1) if a longer/formal stay is needed',
    NULL,
    'visitworld.today secondary sourcing', 'https://visitworld.today/marshall-islands/india-citizenship/travel', '2026-09-19'
);
SET @mhl2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mhl2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mhl2, 'Core Documents', 'Required from every applicant.', 1);
SET @mhl2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mhl2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mhl2s1, 'Business Invitation Letter', NULL, 'original', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mhl2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @mhl2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mhl2s2, 'Company Sponsorship Letter', NULL, 'copy', 0, 1, 0, 1),
(@mhl2s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(185, 2, 100.00, 'USD', 'Visitor Visa (V-1) Fee (If Required)', 'Not required for short visits under the visa-free framework; non-refundable USD 100 for a formal Visitor visa.', '2026-01-01', NOW(), 'https://visitworld.today/marshall-islands/india-citizenship/travel', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travellers need a visa for the Marshall Islands?', 'No, for short visits under the visa-free 90-day framework. A Visitor visa (V-1, USD 100) applies for other non-tourism purposes.', 185, 2, 18520, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    185, 3, 'MHL-STU-IN-01', '2026.09', 'published',
    'Academic study at a Marshall Islands educational institution.',
    'Sources reviewed this session did not describe a dedicated Marshall Islands student-visa category — long-term study is expected to route through the Visitor visa (V-1) process or a related long-stay category.',
    'Academic-program length',
    'Apply for a Visitor visa (V-1) with a university admission letter',
    1,
    'Not independently confirmed this session whether a distinct student-visa category exists.',
    'Honorary Consulate of Marshall Islands, New Delhi; Consulate, Mumbai',
    'Confirm admission with a Marshall Islands educational institution\nGather passport, admission letter, and proof of funds\nApply for a Visitor visa (V-1) with your admission letter\nRegister with local authorities after arrival\nRenew your visa as required for continued study',
    NULL,
    'visitworld.today secondary sourcing', 'https://visitworld.today/marshall-islands/india-citizenship/travel', '2026-09-19'
);
SET @mhl3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mhl3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mhl3, 'Core Documents', 'Required from every applicant.', 1);
SET @mhl3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mhl3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mhl3s1, 'Proof of Admission/Enrollment Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mhl3, 'Supporting Documents', 'Evidence of your means and academic status.', 2);
SET @mhl3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mhl3s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@mhl3s2, 'Proof of Accommodation', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(185, 3, 100.00, 'USD', 'Visitor Visa (V-1) Fee (Indicative)', 'Same non-refundable USD 100 fee as the general Visitor visa; a distinct student category was not independently confirmed this session.', '2026-01-01', NOW(), 'https://visitworld.today/marshall-islands/india-citizenship/travel', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated student visa for the Marshall Islands?', 'Not independently confirmed this session — long-term study is expected to route through the general Visitor visa (V-1) process.', 185, 3, 18530, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    185, 4, 'MHL-WORK-IN-01', '2026.09', 'published',
    'Employment in the Marshall Islands under a local employer.',
    'Work visas require the employer to first obtain a work permit, before the applicant applies for the work visa at the nearest Marshall Islands mission — issued for 2 years.',
    '2 years, renewable',
    'Employer obtains a work permit first; then apply at the nearest Marshall Islands mission',
    1,
    'Nearest full mission is the Embassy in Tokyo, Japan (concurrently accredited to India); consular support also available via New Delhi/Mumbai.',
    'Honorary Consulate of Marshall Islands, New Delhi; Consulate, Mumbai; Embassy in Tokyo, Japan',
    'Secure a job offer from a Marshall Islands employer\nEmployer obtains a work permit on your behalf\nApply for the work visa with your job offer letter and work permit\nGather passport and completed application form\nRegister with local authorities on arrival',
    NULL,
    'visitworld.today secondary sourcing', 'https://visitworld.today/marshall-islands/india-citizenship/work', '2026-09-19'
);
SET @mhl4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mhl4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mhl4, 'Core Documents', 'Required from every work-visa applicant.', 1);
SET @mhl4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mhl4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mhl4s1, 'Job Offer Letter', NULL, 'original', 1, 0, 1, 2),
(@mhl4s1, 'Employer-Obtained Work Permit', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mhl4, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @mhl4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mhl4s2, 'Completed Application Form', NULL, 'original', 1, 0, 0, 1),
(@mhl4s2, 'Passport-Size Photographs', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(185, 4, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Work visa fees were not independently confirmed this session — verify with the nearest Marshall Islands mission.', '2026-01-01', NOW(), 'https://visitworld.today/marshall-islands/india-citizenship/work', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How long is a Marshall Islands work visa valid?', 'Work visas are usually issued for 2 years, after the employer first obtains a work permit on the applicant\'s behalf.', 185, 4, 18540, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    185, 5, 'MHL-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in the Marshall Islands.',
    'Family visitors use the same visa-free, 90-day framework as tourists.',
    'Up to 90 days',
    'No visa needed — present passport and onward ticket on arrival',
    0,
    'Not applicable for entry itself.',
    'Honorary Consulate of Marshall Islands, New Delhi; Consulate, Mumbai',
    'Confirm your passport is valid for 6+ months\nBook proof of onward/return ticket\nCarry proof of relationship and host contact details\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/marshall-islands-mh', '2026-09-19'
);
SET @mhl5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mhl5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mhl5, 'Core Documents', 'Required from every traveller.', 1);
SET @mhl5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mhl5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mhl5s1, 'Confirmed Onward/Return Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mhl5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mhl5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mhl5s2, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 0, 1),
(@mhl5s2, 'Proof of Sufficient Funds', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(185, 5, 0.00, 'USD', 'No Visa Fee for Visa-Free Entry', 'No fee applies for the visa-free 90-day entry.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/marshall-islands-mh', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit family in the Marshall Islands?', 'No — the same visa-free, 90-day framework applies as for tourist travel.', 185, 5, 18550, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    185, 6, 'MHL-TRAN-IN-01', '2026.09', 'published',
    'Airside or short transit through the Marshall Islands en route to another destination.',
    'Airside transit is permitted without a separate visa for Indian passport holders — even leaving the international zone for an overnight layover or baggage recheck follows the same visa-free leisure-entry rules.',
    'Airside/short transit, within the 90-day visa-free framework',
    'No visa needed for transit — present passport and onward ticket',
    0,
    'Not applicable for entry itself.',
    'Honorary Consulate of Marshall Islands, New Delhi',
    'Confirm your connecting flight and transit time\nConfirm your passport is valid for 6+ months\nCarry your onward boarding pass and passport\nCarry all documents for immigration if leaving the international zone',
    NULL,
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/marshall-islands-mh', '2026-09-19'
);
SET @mhl6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mhl6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mhl6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @mhl6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mhl6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mhl6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(185, 6, 0.00, 'USD', 'No Fee for Visa-Free Transit', 'No fee applies within the visa-free framework, including for overnight layovers.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/marshall-islands-mh', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a transit visa for the Marshall Islands?', 'No — airside transit is visa-free, and even an overnight layover leaving the international zone follows the same visa-free leisure-entry rules.', 185, 6, 18560, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    185, 7, 'MHL-MED-IN-01', '2026.09', 'published',
    'Medical treatment in the Marshall Islands.',
    'Medical travellers use the same visa-free, 90-day framework as tourists. Note: local medical infrastructure is limited; serious treatment is often referred overseas.',
    'Up to 90 days',
    'No visa needed — present passport and onward ticket on arrival',
    0,
    'Confirm treatment availability directly given limited local medical infrastructure.',
    'Honorary Consulate of Marshall Islands, New Delhi',
    'Confirm treatment and appointment directly with the Marshall Islands medical facility\nConfirm your passport is valid for 6+ months\nBook proof of onward/return ticket\nGather proof of sufficient funds\nCarry all medical and travel documents for immigration',
    NULL,
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/marshall-islands-mh', '2026-09-19'
);
SET @mhl7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mhl7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mhl7, 'Core Documents', 'Required from every traveller.', 1);
SET @mhl7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mhl7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mhl7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mhl7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mhl7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mhl7s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@mhl7s2, 'Confirmed Onward/Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(185, 7, 0.00, 'USD', 'No Visa Fee for Visa-Free Entry', 'No fee applies for the visa-free 90-day entry.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/marshall-islands-mh', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for the Marshall Islands?', 'No separate medical visa — the same visa-free, 90-day framework applies. Given limited local medical infrastructure, confirm treatment availability directly beforehand.', 185, 7, 18570, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    185, 8, 'MHL-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in the Marshall Islands.',
    'Conference attendees use the same visa-free, 90-day framework as tourists.',
    'Up to 90 days',
    'No visa needed — present passport and onward ticket on arrival',
    0,
    'Not applicable for entry itself.',
    'Honorary Consulate of Marshall Islands, New Delhi',
    'Confirm your passport is valid for 6+ months\nCarry conference invitation/registration confirmation\nBook proof of onward/return ticket\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/marshall-islands-mh', '2026-09-19'
);
SET @mhl8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mhl8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mhl8, 'Core Documents', 'Required from every traveller.', 1);
SET @mhl8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mhl8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mhl8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mhl8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mhl8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mhl8s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@mhl8s2, 'Confirmed Onward/Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(185, 8, 0.00, 'USD', 'No Visa Fee for Visa-Free Entry', 'No fee applies for the visa-free 90-day entry.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/marshall-islands-mh', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for the Marshall Islands?', 'No separate conference visa — the same visa-free, 90-day framework applies.', 185, 8, 18580, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    185, 9, 'MHL-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in the Marshall Islands.',
    'Sports travellers use the same visa-free, 90-day framework as tourists.',
    'Up to 90 days',
    'No visa needed — present passport and onward ticket on arrival',
    0,
    'Not applicable for entry itself.',
    'Honorary Consulate of Marshall Islands, New Delhi',
    'Confirm your passport is valid for 6+ months\nCarry event invitation/participation confirmation\nBook proof of onward/return ticket\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'ixigo.com secondary sourcing', 'https://www.ixigo.com/visa-for-indians/marshall-islands-mh', '2026-09-19'
);
SET @mhl9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mhl9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mhl9, 'Core Documents', 'Required from every traveller.', 1);
SET @mhl9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mhl9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mhl9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mhl9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mhl9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mhl9s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@mhl9s2, 'Confirmed Onward/Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(185, 9, 0.00, 'USD', 'No Visa Fee for Visa-Free Entry', 'No fee applies for the visa-free 90-day entry.', '2026-01-01', NOW(), 'https://www.ixigo.com/visa-for-indians/marshall-islands-mh', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a sports visa for the Marshall Islands?', 'No separate sports visa — the same visa-free, 90-day framework applies.', 185, 9, 18590, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    185, 10, 'MHL-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent who holds a Marshall Islands work visa.',
    'Dependants enter visa-free like other Indian citizens for short stays; longer stays alongside a work-visa holder are expected to require their own application at the nearest Marshall Islands mission.',
    'Tied to the primary permit holder\'s work-visa validity',
    'Enter visa-free, then apply for a dependant visa at the nearest Marshall Islands mission if staying long-term',
    1,
    'Not independently confirmed this session: exact dependant-visa process and fee.',
    'Honorary Consulate of Marshall Islands, New Delhi; Embassy in Tokyo, Japan',
    'Confirm the primary permit holder\'s work-visa status\nGather proof of relationship (marriage/birth certificate)\nEnter the Marshall Islands visa-free (up to 90 days)\nApply for a dependant visa at the nearest mission if staying long-term\nRenew alongside the primary permit holder',
    NULL,
    'visitworld.today secondary sourcing', 'https://visitworld.today/marshall-islands/india-citizenship/work', '2026-09-19'
);
SET @mhl10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mhl10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mhl10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @mhl10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mhl10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mhl10s1, 'Proof of Relationship to Primary Permit Holder', NULL, 'original', 1, 0, 1, 2),
(@mhl10s1, 'Primary Permit Holder\'s Work Visa Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mhl10, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @mhl10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mhl10s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@mhl10s2, 'Proof of Accommodation', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(185, 10, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Dependant visa fees were not independently confirmed this session.', '2026-01-01', NOW(), 'https://visitworld.today/marshall-islands/india-citizenship/work', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do dependants of work-visa holders need their own visa in the Marshall Islands?', 'Expected to be required for stays beyond 90 days, filed separately from the primary work-visa holder — not independently confirmed this session.', 185, 10, 18500, 1);
