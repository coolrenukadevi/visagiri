-- Iraq Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Iraq's real, distinctive facts verified this session:
--   - Indian citizens require a visa for Iraq for every purpose — no
--     visa-free or visa-on-arrival access remains. Visa-on-arrival was
--     permanently suspended 1 March 2025; airlines deny boarding
--     without a pre-approved visa.
--   - Two application routes with different costs: the official eVisa
--     via evisa.iq (USD 159-160, including mandatory health insurance,
--     3-5 business days), or the Embassy of Iraq, New Delhi (C-2, West
--     End Colony) at a lower USD 30-40 consular fee, but travel
--     insurance must then be arranged separately. Embassy applications
--     for business/work visas should be filed 4-6 weeks ahead due to
--     sponsor-approval requirements.
--   - Sourcing conflict flagged rather than silently resolved: one
--     secondary source claims Indian nationals are "currently
--     blacklisted" from the Kurdistan Region (Erbil, Sulaymaniyah,
--     Dohuk); the Ministry of External Affairs' own advisory
--     (mea.gov.in) instead states Indians may travel, study, and
--     conduct business in all provinces including Iraqi Kurdistan,
--     subject to required documents/permissions, restricting only five
--     named provinces (Nineveh, Salahuddin, Diyala, Al-Anbar, Kirkuk).
--     The MEA's own advisory is used as primary since it is the
--     first-party source, with the conflicting claim flagged.
--   - Indian nationals travelling to Iraq for employment must route
--     through India's e-migrate portal (emigration clearance), per the
--     MEA advisory — consistent with Iraq's Emigration Check Required
--     (ECR) status for Indian workers.
--
-- country_id 70 = Iraq. visa_type_id: 1=Tourist, 2=Business,
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
    70, 1, 'IRQ-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Iraq.',
    'Indian citizens require a visa for Iraq — visa-on-arrival was permanently suspended 1 March 2025. Apply via the official eVisa (evisa.iq) or the Embassy of Iraq, New Delhi. The MEA advises avoiding travel to Nineveh, Salahuddin, Diyala, Al-Anbar, and Kirkuk provinces; other provinces, including Iraqi Kurdistan, are permitted subject to required documents.',
    'Per visa validity',
    'Apply online via evisa.iq (USD 159-160, incl. insurance), or through the Embassy of Iraq, New Delhi (USD 30-40, insurance separate)',
    0,
    'Review the current MEA travel advisory for Iraq and avoid the 5 restricted provinces. eVisa processing 3-5 business days.',
    'Embassy of Iraq, New Delhi (C-2, West End Colony)',
    'Review the current MEA travel advisory for Iraq\nConfirm your passport is valid for 6+ months\nApply via evisa.iq, or apply through the Embassy of Iraq, New Delhi\nArrange travel health insurance if applying via the embassy route\nAvoid the 5 MEA-restricted provinces during your trip',
    NULL,
    'evisa.iq, btwvisas.com, and mea.gov.in secondary sourcing', 'https://www.mea.gov.in/iraq-travel-advisory.htm', '2026-09-19'
);
SET @irq1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@irq1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irq1, 'Core Documents', 'Required from every applicant.', 1);
SET @irq1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irq1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@irq1s1, 'Approved eVisa or Embassy Visa', NULL, 'copy', 1, 0, 1, 2),
(@irq1s1, 'Hotel Booking Confirmation or Invitation Letter', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irq1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @irq1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irq1s2, 'Passport-Size Photograph', NULL, 'original', 1, 0, 0, 1),
(@irq1s2, 'Travel Health Insurance (Embassy Route Only)', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(70, 1, 159.00, 'USD', 'eVisa Fee (Includes Mandatory Health Insurance)', 'The alternative Embassy of Iraq, New Delhi route costs a lower USD 30-40 consular fee, but travel insurance must then be arranged separately.', '2026-01-01', NOW(), 'https://evisa.iq/en', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian citizens get a visa on arrival in Iraq?', 'No — visa-on-arrival was permanently suspended on 1 March 2025. A pre-approved eVisa or embassy visa is required; airlines will deny boarding without one.', 70, 1, 7000, 1),
('Can Indian citizens visit Iraqi Kurdistan?', 'Sources disagree: the Ministry of External Affairs\' own advisory states Indians may travel to Iraqi Kurdistan (Erbil) subject to required documents, restricting only 5 named provinces elsewhere in Iraq. A separate secondary source claims a blanket Kurdistan restriction — this conflict is flagged rather than resolved; verify current guidance before travelling.', 70, 1, 7001, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    70, 2, 'IRQ-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Iraq.',
    'Business travellers use the same eVisa/embassy-visa framework, with sponsor approval and a longer 4-6 week lead time recommended via the embassy route.',
    'Per visa validity',
    'Apply through the Embassy of Iraq, New Delhi, 4-6 weeks ahead, with sponsor approval documentation',
    0,
    'Review the current MEA travel advisory for Iraq. Business visas via the embassy route need sponsor approval.',
    'Embassy of Iraq, New Delhi (C-2, West End Colony)',
    'Review the current MEA travel advisory for Iraq\nSecure a business sponsor/host organization in Iraq\nApply via evisa.iq, or apply through the Embassy of Iraq, New Delhi 4-6 weeks ahead\nCarry a business invitation letter and sponsor approval\nArrange travel health insurance if applying via the embassy route',
    NULL,
    'bankbazaar.com secondary sourcing', 'https://www.bankbazaar.com/visa/how-to-apply-iraq-visa-for-indians.html', '2026-09-19'
);
SET @irq2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@irq2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irq2, 'Core Documents', 'Required from every applicant.', 1);
SET @irq2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irq2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@irq2s1, 'Business Invitation Letter', NULL, 'original', 1, 0, 1, 2),
(@irq2s1, 'Sponsor Approval Documentation', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irq2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @irq2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irq2s2, 'Company Sponsorship Letter', NULL, 'copy', 0, 1, 0, 1),
(@irq2s2, 'Travel Health Insurance (Embassy Route Only)', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(70, 2, 35.00, 'USD', 'Embassy Visa Fee (Indicative)', 'Sources cite a USD 30-40 range for the embassy route; the eVisa route costs USD 159-160 including insurance.', '2026-01-01', NOW(), 'https://www.bankbazaar.com/visa/how-to-apply-iraq-visa-for-indians.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How far in advance should I apply for an Iraq business visa?', '4-6 weeks ahead is recommended for embassy-route business and work visas, since sponsor approval takes time to process.', 70, 2, 7020, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    70, 3, 'IRQ-STU-IN-01', '2026.09', 'published',
    'Academic study at an Iraqi educational institution.',
    'Per the MEA advisory, Indians may study in Iraq including in Iraqi Kurdistan, subject to required documents and permissions. A dedicated student-visa application process distinct from the general embassy visa was not extensively detailed in sources reviewed this session.',
    'Academic-program length, renewable',
    'Apply through the Embassy of Iraq, New Delhi, with a university admission letter',
    1,
    'Review the current MEA travel advisory for Iraq before committing to study there, and avoid the 5 MEA-restricted provinces.',
    'Embassy of Iraq, New Delhi (C-2, West End Colony)',
    'Review the current MEA travel advisory for Iraq\nSecure admission from an Iraqi educational institution\nApply through the Embassy of Iraq, New Delhi, with your admission letter\nArrange travel health insurance\nRegister with local authorities after arrival as required',
    NULL,
    'mea.gov.in secondary sourcing', 'https://www.mea.gov.in/iraq-travel-advisory.htm', '2026-09-19'
);
SET @irq3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@irq3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irq3, 'Core Documents', 'Required from every applicant.', 1);
SET @irq3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irq3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@irq3s1, 'University Admission Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irq3, 'Supporting Documents', 'Evidence of your means and academic status.', 2);
SET @irq3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irq3s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@irq3s2, 'Travel Health Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(70, 3, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Student visa fees were not independently confirmed this session — verify with the Embassy of Iraq, New Delhi.', '2026-01-01', NOW(), 'https://www.mea.gov.in/iraq-travel-advisory.htm', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian students study in Iraq?', 'Per the MEA advisory, yes, including in Iraqi Kurdistan, subject to required documents and permissions — apply through the Embassy of Iraq, New Delhi.', 70, 3, 7030, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    70, 4, 'IRQ-WORK-IN-01', '2026.09', 'published',
    'Employment in Iraq under a local sponsor/employer.',
    'Distinctive requirement per the MEA advisory: Indian nationals travelling to Iraq for employment must route their emigration clearance through India\'s e-migrate portal, consistent with Iraq\'s Emigration Check Required (ECR) status for Indian workers, in addition to obtaining a work visa with sponsor approval.',
    'Per work-permit/sponsorship validity',
    'Route emigration clearance via e-migrate.gov.in, then apply through the Embassy of Iraq, New Delhi, with sponsor approval',
    1,
    'Apply 4-6 weeks ahead due to sponsor-approval requirements. Review the current MEA travel advisory and avoid the 5 restricted provinces.',
    'Embassy of Iraq, New Delhi (C-2, West End Colony)',
    'Secure a job offer from an Iraqi employer/sponsor\nObtain emigration clearance via India\'s e-migrate portal (e-migrate.gov.in)\nApply through the Embassy of Iraq, New Delhi, with sponsor approval documentation\nArrange travel health insurance\nAvoid the 5 MEA-restricted provinces during employment',
    NULL,
    'mea.gov.in and bankbazaar.com secondary sourcing', 'https://www.mea.gov.in/iraq-travel-advisory.htm', '2026-09-19'
);
SET @irq4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@irq4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irq4, 'Core Documents', 'Required from every work-visa applicant.', 1);
SET @irq4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irq4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@irq4s1, 'Employment Contract/Sponsorship Letter', NULL, 'original', 1, 0, 1, 2),
(@irq4s1, 'e-Migrate Emigration Clearance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irq4, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @irq4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irq4s2, 'Educational/Professional Certificates', NULL, 'copy', 0, 1, 0, 1),
(@irq4s2, 'Travel Health Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(70, 4, 35.00, 'USD', 'Embassy Visa Fee (Indicative)', 'Same USD 30-40 embassy fee range as the business visa applies; e-migrate clearance is a separate Indian government process with its own requirements.', '2026-01-01', NOW(), 'https://www.mea.gov.in/iraq-travel-advisory.htm', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian workers need e-migrate clearance for Iraq?', 'Yes — per the MEA advisory, Indian nationals travelling to Iraq for employment must route through the e-migrate portal in addition to obtaining a work visa with sponsor approval.', 70, 4, 7040, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    70, 5, 'IRQ-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in Iraq.',
    'Family visitors use the same eVisa/embassy-visa framework as tourists.',
    'Per visa validity',
    'Apply online via evisa.iq, or through the Embassy of Iraq, New Delhi',
    0,
    'Review the current MEA travel advisory for Iraq and avoid the 5 restricted provinces.',
    'Embassy of Iraq, New Delhi (C-2, West End Colony)',
    'Review the current MEA travel advisory for Iraq\nConfirm your passport is valid for 6+ months\nApply via evisa.iq, or apply through the Embassy of Iraq, New Delhi\nCarry proof of relationship and host contact details\nArrange travel health insurance if applying via the embassy route',
    NULL,
    'evisa.iq and mea.gov.in secondary sourcing', 'https://www.mea.gov.in/iraq-travel-advisory.htm', '2026-09-19'
);
SET @irq5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@irq5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irq5, 'Core Documents', 'Required from every applicant.', 1);
SET @irq5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irq5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@irq5s1, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irq5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @irq5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irq5s2, 'Host Invitation Letter', NULL, 'copy', 0, 1, 0, 1),
(@irq5s2, 'Travel Health Insurance (Embassy Route Only)', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(70, 5, 35.00, 'USD', 'Embassy Visa Fee (Indicative)', 'Same USD 30-40 embassy fee range as the tourist visa applies; the eVisa route costs USD 159-160 including insurance.', '2026-01-01', NOW(), 'https://www.bankbazaar.com/visa/how-to-apply-iraq-visa-for-indians.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit family in Iraq?', 'Yes — the same eVisa/embassy-visa framework applies as for tourist travel; visa-on-arrival is suspended.', 70, 5, 7050, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    70, 6, 'IRQ-TRAN-IN-01', '2026.09', 'published',
    'Transit through Iraq en route to another destination.',
    'Sources reviewed this session did not confirm a separate airside-only transit exemption for Indian passport holders — since visa-on-arrival is suspended entirely, travellers should expect to need the same eVisa/embassy-visa as other visa types if clearing immigration.',
    'Short transit only, per visa validity',
    'Apply via evisa.iq, or through the Embassy of Iraq, New Delhi, before transiting',
    0,
    'Not independently confirmed this session whether an airside-only exemption exists — verify with your airline before relying on it.',
    'Embassy of Iraq, New Delhi (C-2, West End Colony)',
    'Confirm your connecting flight and transit time\nApply for the eVisa in advance if there is any possibility of clearing immigration\nCarry your onward boarding pass and passport\nConfirm airside-only transit exemptions directly with your airline',
    NULL,
    'evisa.iq secondary sourcing (transit exemption not independently confirmed)', 'https://evisa.iq/en', '2026-09-19'
);
SET @irq6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@irq6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irq6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @irq6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irq6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@irq6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(70, 6, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Transit visa fee was not independently confirmed this session — verify with the Embassy of Iraq, New Delhi.', '2026-01-01', NOW(), 'https://evisa.iq/en', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a transit visa for Iraq?', 'Not independently confirmed this session whether airside-only transit is exempt. Since visa-on-arrival is suspended entirely, apply for the eVisa in advance if there is any chance of clearing immigration.', 70, 6, 7060, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    70, 7, 'IRQ-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Iraq.',
    'Medical travellers use the same eVisa/embassy-visa framework as tourists.',
    'Per visa validity',
    'Apply online via evisa.iq, or through the Embassy of Iraq, New Delhi',
    0,
    'Review the current MEA travel advisory for Iraq and avoid the 5 restricted provinces.',
    'Embassy of Iraq, New Delhi (C-2, West End Colony)',
    'Confirm treatment and appointment directly with the Iraqi medical facility\nApply via evisa.iq, or apply through the Embassy of Iraq, New Delhi\nArrange travel health insurance if applying via the embassy route\nReview the current MEA travel advisory for Iraq\nCarry all medical and travel documents for immigration',
    NULL,
    'evisa.iq and mea.gov.in secondary sourcing', 'https://www.mea.gov.in/iraq-travel-advisory.htm', '2026-09-19'
);
SET @irq7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@irq7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irq7, 'Core Documents', 'Required from every applicant.', 1);
SET @irq7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irq7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@irq7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irq7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @irq7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irq7s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@irq7s2, 'Travel Health Insurance (Embassy Route Only)', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(70, 7, 35.00, 'USD', 'Embassy Visa Fee (Indicative)', 'Same USD 30-40 embassy fee range as the tourist visa applies; the eVisa route costs USD 159-160 including insurance.', '2026-01-01', NOW(), 'https://www.bankbazaar.com/visa/how-to-apply-iraq-visa-for-indians.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for Iraq?', 'No separate medical visa — the same eVisa/embassy-visa framework applies as for tourist travel.', 70, 7, 7070, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    70, 8, 'IRQ-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in Iraq.',
    'Conference attendees use the same eVisa/embassy-visa framework as business travellers.',
    'Per visa validity',
    'Apply through the Embassy of Iraq, New Delhi, with a conference invitation letter',
    0,
    'Review the current MEA travel advisory for Iraq and avoid the 5 restricted provinces.',
    'Embassy of Iraq, New Delhi (C-2, West End Colony)',
    'Carry conference invitation/registration confirmation\nApply via evisa.iq, or apply through the Embassy of Iraq, New Delhi\nArrange travel health insurance if applying via the embassy route\nReview the current MEA travel advisory for Iraq\nCarry all documents for immigration on arrival',
    NULL,
    'evisa.iq and mea.gov.in secondary sourcing', 'https://www.mea.gov.in/iraq-travel-advisory.htm', '2026-09-19'
);
SET @irq8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@irq8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irq8, 'Core Documents', 'Required from every applicant.', 1);
SET @irq8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irq8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@irq8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irq8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @irq8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irq8s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@irq8s2, 'Travel Health Insurance (Embassy Route Only)', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(70, 8, 35.00, 'USD', 'Embassy Visa Fee (Indicative)', 'Same USD 30-40 embassy fee range as the business visa applies.', '2026-01-01', NOW(), 'https://www.bankbazaar.com/visa/how-to-apply-iraq-visa-for-indians.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for Iraq?', 'No separate conference visa — the same eVisa/embassy-visa framework applies as for business travel.', 70, 8, 7080, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    70, 9, 'IRQ-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in Iraq.',
    'Sports travellers use the same eVisa/embassy-visa framework as tourists.',
    'Per visa validity',
    'Apply online via evisa.iq, or through the Embassy of Iraq, New Delhi',
    0,
    'Review the current MEA travel advisory for Iraq and avoid the 5 restricted provinces.',
    'Embassy of Iraq, New Delhi (C-2, West End Colony)',
    'Carry event invitation/participation confirmation\nApply via evisa.iq, or apply through the Embassy of Iraq, New Delhi\nArrange travel health insurance if applying via the embassy route\nReview the current MEA travel advisory for Iraq\nCarry all documents for immigration on arrival',
    NULL,
    'evisa.iq and mea.gov.in secondary sourcing', 'https://www.mea.gov.in/iraq-travel-advisory.htm', '2026-09-19'
);
SET @irq9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@irq9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irq9, 'Core Documents', 'Required from every applicant.', 1);
SET @irq9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irq9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@irq9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irq9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @irq9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irq9s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@irq9s2, 'Travel Health Insurance (Embassy Route Only)', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(70, 9, 35.00, 'USD', 'Embassy Visa Fee (Indicative)', 'Same USD 30-40 embassy fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.bankbazaar.com/visa/how-to-apply-iraq-visa-for-indians.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a sports visa for Iraq?', 'No separate sports visa — the same eVisa/embassy-visa framework applies as for tourist travel.', 70, 9, 7090, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    70, 10, 'IRQ-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent who holds an Iraqi work/residence visa.',
    'Dependants apply through the Embassy of Iraq, New Delhi, referencing the primary permit holder\'s sponsor approval.',
    'Tied to the primary permit holder\'s visa validity',
    'Apply through the Embassy of Iraq, New Delhi, referencing the primary permit holder\'s sponsor approval',
    1,
    'Not independently confirmed this session: exact dependant-visa fee and processing time — verify with the Embassy of Iraq, New Delhi.',
    'Embassy of Iraq, New Delhi (C-2, West End Colony)',
    'Confirm the primary permit holder\'s work/residence visa status\nGather proof of relationship (marriage/birth certificate)\nApply through the Embassy of Iraq, New Delhi\nArrange travel health insurance\nAvoid the 5 MEA-restricted provinces during your stay',
    NULL,
    'mea.gov.in secondary sourcing', 'https://www.mea.gov.in/iraq-travel-advisory.htm', '2026-09-19'
);
SET @irq10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@irq10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irq10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @irq10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irq10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@irq10s1, 'Proof of Relationship (Marriage/Birth Certificate)', NULL, 'original', 1, 0, 1, 2),
(@irq10s1, 'Primary Permit Holder\'s Visa/Sponsorship Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@irq10, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @irq10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@irq10s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@irq10s2, 'Travel Health Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(70, 10, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Dependant visa fees were not independently confirmed this session — verify with the Embassy of Iraq, New Delhi.', '2026-01-01', NOW(), 'https://www.mea.gov.in/iraq-travel-advisory.htm', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can dependants accompany a work/residence visa holder to Iraq?', 'Yes, via a separate application through the Embassy of Iraq, New Delhi, referencing the primary permit holder\'s sponsor approval.', 70, 10, 7000, 1);
