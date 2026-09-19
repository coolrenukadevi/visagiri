-- Nicaragua Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Nicaragua's real, distinctive facts verified this session:
--   - Major, very recent policy reversal: effective 14 February 2026,
--     Nicaragua eliminated BOTH the Visa on Arrival AND the
--     "substitute-visa" program (which previously let Indian
--     passport holders with a valid US/UK/Schengen/Canada visa obtain
--     a VOA for up to 30 days) — part of a broader overhaul also
--     affecting Colombia, Morocco, Indonesia, Senegal, Thailand,
--     Serbia, Peru, the Central African Republic, and Zimbabwe. Older
--     sourcing describing the substitute-visa VOA route is now
--     explicitly outdated and flagged as such rather than repeated.
--   - Indian citizens now have exactly two options: an eVisa via
--     tramitesconsulares.mint.gob.ni, or applying through the nearest
--     Nicaraguan consular representative (India is classified under
--     Category 'C' visa for ordinary passport holders).
--   - Nicaragua has no resident embassy in India — the Nicaraguan
--     Embassy in Tokyo is concurrently accredited to India, with
--     Honorary Consuls General in New Delhi and Mumbai for local
--     consular support.
--   - Visa validity: 30 days, extendable by a further 60 days, up to
--     90 days total.
--
-- country_id 173 = Nicaragua. visa_type_id: 1=Tourist, 2=Business,
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
    173, 1, 'NIC-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Nicaragua.',
    'As of 14 February 2026, Nicaragua eliminated Visa on Arrival and the substitute-visa program (previously available via a valid US/UK/Schengen/Canada visa). Indian citizens must now apply for an eVisa or via a Nicaraguan consular representative before travel.',
    'Up to 30 days, extendable to 90 days',
    'Apply for the eVisa via tramitesconsulares.mint.gob.ni, or through the nearest Nicaraguan consular representative',
    0,
    'Older sourcing describing VOA via a US/UK/Schengen/Canada visa is now outdated following the February 2026 policy change. Processing 3-15 business days.',
    'Honorary Consul General, New Delhi and Mumbai; Embassy of Nicaragua, Tokyo (concurrently accredited to India)',
    'Confirm your passport is valid for 6+ months\nApply for the eVisa via tramitesconsulares.mint.gob.ni, or apply through the nearest Nicaraguan consular representative\nGather proof of accommodation and sufficient funds\nSubmit biometric data if applying in person\nCarry the approved visa for immigration on arrival',
    '/assets/images/visa-heroes/nicaragua.webp',
    'visasnews.com secondary sourcing', 'https://visasnews.com/en/nicaragua-overhauls-its-visa-policy/', '2026-09-19'
);
SET @nic1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nic1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nic1, 'Core Documents', 'Required from every applicant.', 1);
SET @nic1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nic1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@nic1s1, 'Approved eVisa or Consular Visa', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nic1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @nic1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nic1s2, 'Proof of Accommodation', NULL, 'copy', 1, 0, 0, 1),
(@nic1s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(173, 1, 35.00, 'USD', 'Tourist Visa Fee (Indicative)', 'Sources cite a USD 20-50 range depending on application channel; not independently confirmed to a single figure this session.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/nicaragua-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian citizens still get a visa on arrival in Nicaragua?', 'No — as of 14 February 2026, Nicaragua eliminated both visa-on-arrival and the substitute-visa program that previously let holders of a US/UK/Schengen/Canada visa obtain VOA. A visa must now be arranged in advance.', 173, 1, 17300, 1),
('Where do Indian citizens apply for a Nicaragua visa?', 'Via the eVisa portal (tramitesconsulares.mint.gob.ni) or through the nearest Nicaraguan consular representative — Nicaragua has no resident embassy in India, with Honorary Consuls General in New Delhi and Mumbai.', 173, 1, 17301, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    173, 2, 'NIC-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Nicaragua.',
    'Business travellers use the same eVisa/consular framework as tourists, following the February 2026 elimination of VOA.',
    'Up to 30 days, extendable to 90 days',
    'Apply for the eVisa via tramitesconsulares.mint.gob.ni, or through the nearest Nicaraguan consular representative',
    0,
    'Processing 3-15 business days.',
    'Honorary Consul General, New Delhi and Mumbai',
    'Confirm your passport is valid for 6+ months\nApply for the eVisa, or apply through the nearest Nicaraguan consular representative\nCarry a business invitation letter from the host organization\nGather proof of sufficient funds\nSubmit biometric data if applying in person',
    '/assets/images/visa-heroes/nicaragua.webp',
    'visasnews.com secondary sourcing', 'https://visasnews.com/en/nicaragua-overhauls-its-visa-policy/', '2026-09-19'
);
SET @nic2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nic2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nic2, 'Core Documents', 'Required from every applicant.', 1);
SET @nic2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nic2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@nic2s1, 'Business Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nic2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @nic2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nic2s2, 'Company Sponsorship Letter', NULL, 'copy', 0, 1, 0, 1),
(@nic2s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(173, 2, 35.00, 'USD', 'Business Visa Fee (Indicative)', 'Same USD 20-50 range as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/nicaragua-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travellers need a visa for Nicaragua?', 'Yes — apply via the eVisa portal or the nearest consular representative, following the February 2026 VOA elimination.', 173, 2, 17320, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    173, 3, 'NIC-STU-IN-01', '2026.09', 'published',
    'Academic study at a Nicaraguan educational institution.',
    'Sources reviewed this session did not describe a dedicated Nicaragua student-visa category distinct from the general consular visa process, applied for once admission is secured.',
    'Study-program length, renewable',
    'Apply through the nearest Nicaraguan consular representative, with a university admission letter',
    1,
    'Not independently confirmed this session whether a distinct student-visa category exists.',
    'Honorary Consul General, New Delhi and Mumbai',
    'Confirm admission with a Nicaraguan educational institution\nGather passport, admission letter, and proof of funds\nApply through the nearest Nicaraguan consular representative\nRegister with local authorities after arrival if required\nRenew your visa as needed for continued study',
    '/assets/images/visa-heroes/nicaragua.webp',
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-requirements/nicaragua-visa-requirements/', '2026-09-19'
);
SET @nic3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nic3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nic3, 'Core Documents', 'Required from every applicant.', 1);
SET @nic3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nic3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@nic3s1, 'Proof of Admission/Enrollment Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nic3, 'Supporting Documents', 'Evidence of your means and academic status.', 2);
SET @nic3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nic3s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@nic3s2, 'Proof of Accommodation', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(173, 3, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Student visa fees were not independently confirmed this session.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-requirements/nicaragua-visa-requirements/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated student visa for Nicaragua?', 'Not independently confirmed this session — apply through the nearest consular representative once admission is secured.', 173, 3, 17330, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    173, 4, 'NIC-WORK-IN-01', '2026.09', 'published',
    'Employment in Nicaragua under a local employer.',
    'The tourist visa cannot be used for employment — a distinct work visa is required, sponsored by a local employer.',
    'Per work-visa validity, renewable',
    'Employer sponsors your work-visa application through the nearest Nicaraguan consular representative',
    1,
    'Not independently confirmed this session: exact work-visa fee and local work-permit process.',
    'Honorary Consul General, New Delhi and Mumbai',
    'Secure a job offer from a Nicaraguan employer\nGather employment contract/sponsorship letter\nApply through the nearest Nicaraguan consular representative\nRegister with local labour authorities on arrival\nRenew your work visa as required for continued employment',
    '/assets/images/visa-heroes/nicaragua.webp',
    'atlys.com secondary sourcing', 'https://www.atlys.com/en-US/visa/nicaragua-visa', '2026-09-19'
);
SET @nic4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nic4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nic4, 'Core Documents', 'Required from every work-visa applicant.', 1);
SET @nic4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nic4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@nic4s1, 'Employment Contract/Sponsorship Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nic4, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @nic4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nic4s2, 'Educational/Professional Certificates', NULL, 'copy', 0, 1, 0, 1),
(@nic4s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(173, 4, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Work visa fees were not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.atlys.com/en-US/visa/nicaragua-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I work in Nicaragua on a tourist visa?', 'No — a distinct work visa, sponsored by a local employer, is required for employment.', 173, 4, 17340, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    173, 5, 'NIC-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in Nicaragua.',
    'Family visitors use the same eVisa/consular framework as tourists, following the February 2026 elimination of VOA.',
    'Up to 30 days, extendable to 90 days',
    'Apply for the eVisa via tramitesconsulares.mint.gob.ni, or through the nearest Nicaraguan consular representative',
    0,
    'Processing 3-15 business days.',
    'Honorary Consul General, New Delhi and Mumbai',
    'Confirm your passport is valid for 6+ months\nApply for the eVisa, or apply through the nearest Nicaraguan consular representative\nCarry proof of relationship and host contact details\nGather proof of sufficient funds\nSubmit biometric data if applying in person',
    '/assets/images/visa-heroes/nicaragua.webp',
    'visasnews.com secondary sourcing', 'https://visasnews.com/en/nicaragua-overhauls-its-visa-policy/', '2026-09-19'
);
SET @nic5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nic5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nic5, 'Core Documents', 'Required from every applicant.', 1);
SET @nic5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nic5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@nic5s1, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nic5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @nic5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nic5s2, 'Host Invitation Letter', NULL, 'copy', 0, 1, 0, 1),
(@nic5s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(173, 5, 35.00, 'USD', 'Family Visit Visa Fee (Indicative)', 'Same USD 20-50 range as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/nicaragua-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit family in Nicaragua?', 'Yes — the same eVisa/consular framework applies as for tourist travel, following the February 2026 VOA elimination.', 173, 5, 17350, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    173, 6, 'NIC-TRAN-IN-01', '2026.09', 'published',
    'Transit through Nicaragua en route to another destination.',
    'Sources reviewed this session did not describe a separate airside-only transit exemption for Indian passport holders following the February 2026 VOA elimination.',
    'Short transit only',
    'Apply for the eVisa in advance if clearing immigration',
    0,
    'Not independently confirmed this session whether an airside-only exemption exists — verify with your airline.',
    'Honorary Consul General, New Delhi and Mumbai',
    'Confirm your connecting flight and transit time\nApply for the eVisa in advance if there is any possibility of clearing immigration\nCarry your onward boarding pass and passport\nConfirm airside-only transit exemptions directly with your airline',
    '/assets/images/visa-heroes/nicaragua.webp',
    'visasnews.com secondary sourcing (transit exemption not independently confirmed)', 'https://visasnews.com/en/nicaragua-overhauls-its-visa-policy/', '2026-09-19'
);
SET @nic6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nic6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nic6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @nic6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nic6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@nic6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(173, 6, 35.00, 'USD', 'Visa Fee (If Clearing Immigration)', 'Airside-only transit exemption not independently confirmed this session — budget for the standard visa fee unless your airline confirms otherwise.', '2026-01-01', NOW(), 'https://visasnews.com/en/nicaragua-overhauls-its-visa-policy/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a transit visa for Nicaragua?', 'Not independently confirmed this session whether airside-only transit is exempt following the February 2026 VOA elimination. If you may clear immigration, apply for the eVisa in advance.', 173, 6, 17360, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    173, 7, 'NIC-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Nicaragua.',
    'Medical travellers use the same eVisa/consular framework as tourists.',
    'Up to 30 days, extendable to 90 days',
    'Apply for the eVisa via tramitesconsulares.mint.gob.ni, or through the nearest Nicaraguan consular representative',
    0,
    'Confirm treatment and appointment directly with the Nicaraguan medical facility before applying.',
    'Honorary Consul General, New Delhi and Mumbai',
    'Confirm treatment and appointment directly with the Nicaraguan medical facility\nApply for the eVisa, or apply through the nearest Nicaraguan consular representative\nGather proof of sufficient funds\nCarry all medical and travel documents for immigration',
    '/assets/images/visa-heroes/nicaragua.webp',
    'visasnews.com secondary sourcing', 'https://visasnews.com/en/nicaragua-overhauls-its-visa-policy/', '2026-09-19'
);
SET @nic7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nic7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nic7, 'Core Documents', 'Required from every applicant.', 1);
SET @nic7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nic7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@nic7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nic7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @nic7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nic7s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@nic7s2, 'Proof of Accommodation', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(173, 7, 35.00, 'USD', 'Medical Visa Fee (Indicative)', 'Same USD 20-50 range as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/nicaragua-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for Nicaragua?', 'No separate medical visa — the same eVisa/consular framework applies as for tourist travel.', 173, 7, 17370, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    173, 8, 'NIC-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in Nicaragua.',
    'Conference attendees use the same eVisa/consular framework as business travellers.',
    'Up to 30 days, extendable to 90 days',
    'Apply for the eVisa via tramitesconsulares.mint.gob.ni, or through the nearest Nicaraguan consular representative',
    0,
    'Processing 3-15 business days.',
    'Honorary Consul General, New Delhi and Mumbai',
    'Confirm your passport is valid for 6+ months\nCarry conference invitation/registration confirmation\nApply for the eVisa, or apply through the nearest Nicaraguan consular representative\nGather proof of sufficient funds\nSubmit biometric data if applying in person',
    '/assets/images/visa-heroes/nicaragua.webp',
    'visasnews.com secondary sourcing', 'https://visasnews.com/en/nicaragua-overhauls-its-visa-policy/', '2026-09-19'
);
SET @nic8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nic8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nic8, 'Core Documents', 'Required from every applicant.', 1);
SET @nic8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nic8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@nic8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nic8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @nic8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nic8s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@nic8s2, 'Proof of Accommodation', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(173, 8, 35.00, 'USD', 'Conference Visa Fee (Indicative)', 'Same USD 20-50 range as the business visa applies.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/nicaragua-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for Nicaragua?', 'No separate conference visa — the same eVisa/consular framework applies as for business travel.', 173, 8, 17380, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    173, 9, 'NIC-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in Nicaragua.',
    'Sports travellers use the same eVisa/consular framework as tourists.',
    'Up to 30 days, extendable to 90 days',
    'Apply for the eVisa via tramitesconsulares.mint.gob.ni, or through the nearest Nicaraguan consular representative',
    0,
    'Processing 3-15 business days.',
    'Honorary Consul General, New Delhi and Mumbai',
    'Confirm your passport is valid for 6+ months\nCarry event invitation/participation confirmation\nApply for the eVisa, or apply through the nearest Nicaraguan consular representative\nGather proof of sufficient funds\nSubmit biometric data if applying in person',
    '/assets/images/visa-heroes/nicaragua.webp',
    'visasnews.com secondary sourcing', 'https://visasnews.com/en/nicaragua-overhauls-its-visa-policy/', '2026-09-19'
);
SET @nic9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nic9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nic9, 'Core Documents', 'Required from every applicant.', 1);
SET @nic9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nic9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@nic9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nic9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @nic9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nic9s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@nic9s2, 'Proof of Accommodation', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(173, 9, 35.00, 'USD', 'Sports Visa Fee (Indicative)', 'Same USD 20-50 range as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/nicaragua-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a sports visa for Nicaragua?', 'No separate sports visa — the same eVisa/consular framework applies as for tourist travel.', 173, 9, 17390, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    173, 10, 'NIC-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent who holds a Nicaragua work/student visa.',
    'Dependants apply through the nearest Nicaraguan consular representative, referencing the primary permit holder\'s visa.',
    'Tied to the primary permit holder\'s visa validity',
    'Apply through the nearest Nicaraguan consular representative, referencing the primary permit holder\'s visa',
    1,
    'Not independently confirmed this session: exact dependant-visa fee and processing time.',
    'Honorary Consul General, New Delhi and Mumbai',
    'Confirm the primary permit holder\'s work/student visa status\nGather proof of relationship (marriage/birth certificate)\nApply through the nearest Nicaraguan consular representative\nRegister with local authorities on arrival if required\nRenew your visa alongside the primary permit holder',
    '/assets/images/visa-heroes/nicaragua.webp',
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-requirements/nicaragua-visa-requirements/', '2026-09-19'
);
SET @nic10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nic10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nic10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @nic10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nic10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@nic10s1, 'Proof of Relationship (Marriage/Birth Certificate)', NULL, 'original', 1, 0, 1, 2),
(@nic10s1, 'Primary Permit Holder\'s Visa Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nic10, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @nic10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nic10s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@nic10s2, 'Proof of Accommodation', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(173, 10, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Dependant visa fees were not independently confirmed this session.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-requirements/nicaragua-visa-requirements/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can dependants accompany a work/student visa holder to Nicaragua?', 'Yes, via a separate application through the nearest Nicaraguan consular representative, referencing the primary permit holder\'s visa.', 173, 10, 17300, 1);
