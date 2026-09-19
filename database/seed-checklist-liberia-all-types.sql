-- Liberia Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Liberia's real, distinctive facts verified this session:
--   - The Government of Liberia officially launched a NEW Visa on
--     Arrival system (visaonarrival.lis.gov.lr) on 11 March 2025,
--     replacing older sourcing that inaccurately described Liberia as
--     simply "visa-free" for Indians. Travellers pre-apply online,
--     then complete biometric data collection and receive a visa
--     sticker on arrival by air.
--   - Distinctive rule specific to India: applicants must use this
--     VOA portal (rather than an embassy) BECAUSE Liberia has no
--     operating embassy in India — its former resident mission in New
--     Delhi closed due to budgetary constraints, and the Honorary
--     Consulate for Liberia in India is explicitly NOT authorized to
--     issue visas. The nearest Liberian embassies in Asia are in Tokyo
--     and China.
--   - Recommended to apply 7 days to 3 months before travel.
--   - Work visas require a distinct Liberia Work Visa (6 months to 1
--     year validity) for any salaried, technical, or project-based
--     employment — fee varies by duration and entry type.
--   - India maintains its own Embassy of India in Monrovia for
--     consular assistance to Indian nationals in Liberia.
--
-- country_id 27 = Liberia. visa_type_id: 1=Tourist, 2=Business,
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
    27, 1, 'LBR-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Liberia.',
    'Indian citizens use Liberia\'s new Visa on Arrival portal (launched March 2025) since Liberia has no operating embassy in India — the Honorary Consulate is not authorized to issue visas.',
    'Up to 30-90 days',
    'Pre-apply online at visaonarrival.lis.gov.lr, then complete biometrics on arrival by air',
    1,
    'Apply 7 days to 3 months before travel. Biometric data collection happens on arrival.',
    'No authorized Liberian visa-issuing office in India — apply via the online VOA portal instead',
    'Confirm your passport is valid for 6+ months\nPre-apply online at visaonarrival.lis.gov.lr, 7 days to 3 months before travel\nGather a recent passport-size photo and proof of onward travel\nPresent your confirmation form on arrival by air\nComplete biometric data collection to receive your visa sticker',
    NULL,
    'lis.gov.lr and joinsherpa.com secondary sourcing', 'https://visaonarrival.lis.gov.lr/', '2026-09-19'
);
SET @lbr1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lbr1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbr1, 'Core Documents', 'Required from every applicant.', 1);
SET @lbr1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbr1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@lbr1s1, 'VOA Pre-Application Confirmation Form', NULL, 'copy', 1, 0, 1, 2),
(@lbr1s1, 'Passport-Size Photograph', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbr1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lbr1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbr1s2, 'Proof of Onward/Return Travel', NULL, 'copy', 1, 0, 0, 1),
(@lbr1s2, 'Proof of Accommodation', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(27, 1, 0.00, 'USD', 'Fee Not Independently Confirmed', 'The official VOA portal did not return a specific fee figure in sources reviewed this session — check visaonarrival.lis.gov.lr directly for current pricing.', '2026-01-01', NOW(), 'https://visaonarrival.lis.gov.lr/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Liberia?', 'Yes, via Liberia\'s Visa on Arrival system, launched March 2025 — pre-apply online at visaonarrival.lis.gov.lr, then complete biometrics on arrival.', 27, 1, 2700, 1),
('Why do Indians use the VOA portal instead of an embassy for Liberia?', 'Liberia has no operating embassy in India — its former New Delhi mission closed due to budgetary constraints, and the Honorary Consulate is not authorized to issue visas. The nearest Liberian embassies in Asia are in Tokyo and China.', 27, 1, 2701, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    27, 2, 'LBR-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Liberia.',
    'Business travellers use the same VOA portal as tourists, with a business invitation letter as additional support.',
    'Up to 30-90 days',
    'Pre-apply online at visaonarrival.lis.gov.lr, then complete biometrics on arrival by air',
    1,
    'Apply 7 days to 3 months before travel.',
    'No authorized Liberian visa-issuing office in India — apply via the online VOA portal instead',
    'Confirm your passport is valid for 6+ months\nPre-apply online at visaonarrival.lis.gov.lr\nCarry a business invitation letter from the host organization\nGather proof of sufficient funds\nComplete biometric data collection on arrival',
    NULL,
    'lis.gov.lr secondary sourcing', 'https://visaonarrival.lis.gov.lr/', '2026-09-19'
);
SET @lbr2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lbr2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbr2, 'Core Documents', 'Required from every applicant.', 1);
SET @lbr2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbr2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@lbr2s1, 'Business Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbr2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @lbr2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbr2s2, 'Company Sponsorship Letter', NULL, 'copy', 0, 1, 0, 1),
(@lbr2s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(27, 2, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Check visaonarrival.lis.gov.lr directly for current pricing.', '2026-01-01', NOW(), 'https://visaonarrival.lis.gov.lr/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travellers need a visa for Liberia?', 'Yes — the same VOA portal applies, with a business invitation letter recommended.', 27, 2, 2720, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    27, 3, 'LBR-STU-IN-01', '2026.09', 'published',
    'Academic study at a Liberian educational institution.',
    'Sources reviewed this session did not describe a dedicated Liberia student-visa category distinct from the VOA portal for entry, followed by local registration once admission is secured.',
    'Study-program length, via local registration',
    'Pre-apply online at visaonarrival.lis.gov.lr, then register with the institution and immigration authorities after arrival',
    1,
    'Not independently confirmed this session whether a distinct student-visa category exists — verify directly with your institution.',
    'No authorized Liberian visa-issuing office in India — apply via the online VOA portal instead',
    'Confirm admission with a Liberian educational institution\nPre-apply online at visaonarrival.lis.gov.lr\nGather passport, admission letter, and proof of funds\nComplete biometric data collection on arrival\nRegister with the institution and local immigration authorities',
    NULL,
    'lis.gov.lr secondary sourcing', 'https://visaonarrival.lis.gov.lr/', '2026-09-19'
);
SET @lbr3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lbr3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbr3, 'Core Documents', 'Required from every applicant.', 1);
SET @lbr3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbr3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@lbr3s1, 'Proof of Admission/Enrollment Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbr3, 'Supporting Documents', 'Evidence of your means and academic status.', 2);
SET @lbr3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbr3s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@lbr3s2, 'Proof of Accommodation', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(27, 3, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Student visa/registration fees were not independently confirmed this session.', '2026-01-01', NOW(), 'https://visaonarrival.lis.gov.lr/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated student visa for Liberia?', 'Not independently confirmed this session — enter via the VOA portal, then register with your institution and local immigration authorities.', 27, 3, 2730, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    27, 4, 'LBR-WORK-IN-01', '2026.09', 'published',
    'Employment in Liberia, including salaried, technical, and project-based roles.',
    'A distinct Liberia Work Visa (6 months to 1 year validity) is required for any employment — fee varies by duration and entry type, with long-term approvals costing more than temporary contracts.',
    '6 months to 1 year, renewable',
    'Employer sponsors your Liberia Work Visa application',
    1,
    'Fee not independently confirmed to a single figure this session — varies by duration and entry type.',
    'No authorized Liberian visa-issuing office in India — coordinate through your employer and Liberian immigration authorities',
    'Secure a job offer from a Liberian employer\nEmployer sponsors your Liberia Work Visa application\nGather employment contract and proof of qualifications\nComplete the work-visa application process as directed\nRegister with local authorities after arrival',
    NULL,
    'akbartravels.com secondary sourcing', 'https://www.akbartravels.com/in/visas/liberia-work-visa', '2026-09-19'
);
SET @lbr4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lbr4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbr4, 'Core Documents', 'Required from every work-visa applicant.', 1);
SET @lbr4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbr4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@lbr4s1, 'Employment Contract/Sponsorship Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbr4, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @lbr4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbr4s2, 'Educational/Professional Certificates', NULL, 'copy', 0, 1, 0, 1),
(@lbr4s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(27, 4, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Varies by duration and entry type; long-term approvals cost more than temporary contracts.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/liberia-work-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What does an Indian citizen need to work in Liberia?', 'A distinct Liberia Work Visa (6 months to 1 year validity), sponsored by your employer, separate from the tourist VOA.', 27, 4, 2740, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    27, 5, 'LBR-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in Liberia.',
    'Family visitors use the same VOA portal as tourists.',
    'Up to 30-90 days',
    'Pre-apply online at visaonarrival.lis.gov.lr, then complete biometrics on arrival by air',
    1,
    'Apply 7 days to 3 months before travel.',
    'No authorized Liberian visa-issuing office in India — apply via the online VOA portal instead',
    'Confirm your passport is valid for 6+ months\nPre-apply online at visaonarrival.lis.gov.lr\nCarry proof of relationship and host contact details\nGather proof of sufficient funds\nComplete biometric data collection on arrival',
    NULL,
    'lis.gov.lr secondary sourcing', 'https://visaonarrival.lis.gov.lr/', '2026-09-19'
);
SET @lbr5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lbr5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbr5, 'Core Documents', 'Required from every applicant.', 1);
SET @lbr5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbr5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@lbr5s1, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbr5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lbr5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbr5s2, 'Host Invitation Letter', NULL, 'copy', 0, 1, 0, 1),
(@lbr5s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(27, 5, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Check visaonarrival.lis.gov.lr directly for current pricing.', '2026-01-01', NOW(), 'https://visaonarrival.lis.gov.lr/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit family in Liberia?', 'Yes — the same VOA portal applies as for tourist travel.', 27, 5, 2750, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    27, 6, 'LBR-TRAN-IN-01', '2026.09', 'published',
    'Transit through Liberia en route to another destination.',
    'The VOA portal explicitly lists "transit" as one of its eligible travel purposes, alongside tourism and business.',
    'Short transit, per VOA terms',
    'Pre-apply online at visaonarrival.lis.gov.lr for transit purpose',
    1,
    'Apply 7 days to 3 months before travel if there is any possibility of clearing immigration.',
    'No authorized Liberian visa-issuing office in India — apply via the online VOA portal instead',
    'Confirm your connecting flight and transit time\nPre-apply online at visaonarrival.lis.gov.lr for transit purpose\nCarry your onward boarding pass and passport\nComplete biometric data collection if clearing immigration',
    NULL,
    'lis.gov.lr secondary sourcing', 'https://visaonarrival.lis.gov.lr/', '2026-09-19'
);
SET @lbr6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lbr6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbr6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @lbr6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbr6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@lbr6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(27, 6, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Check visaonarrival.lis.gov.lr directly for current transit pricing.', '2026-01-01', NOW(), 'https://visaonarrival.lis.gov.lr/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a transit visa for Liberia?', 'The VOA portal explicitly lists transit as an eligible purpose — pre-apply online before travel.', 27, 6, 2760, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    27, 7, 'LBR-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Liberia.',
    'Medical travellers use the same VOA portal as tourists. Note: Liberia\'s medical infrastructure is limited; verify facility availability directly.',
    'Up to 30-90 days',
    'Pre-apply online at visaonarrival.lis.gov.lr, then complete biometrics on arrival by air',
    1,
    'Confirm treatment availability directly given Liberia\'s limited medical infrastructure.',
    'No authorized Liberian visa-issuing office in India — apply via the online VOA portal instead',
    'Confirm treatment and appointment directly with the Liberian medical facility\nPre-apply online at visaonarrival.lis.gov.lr\nGather proof of sufficient funds\nComplete biometric data collection on arrival\nCarry all medical and travel documents for immigration',
    NULL,
    'lis.gov.lr secondary sourcing', 'https://visaonarrival.lis.gov.lr/', '2026-09-19'
);
SET @lbr7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lbr7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbr7, 'Core Documents', 'Required from every applicant.', 1);
SET @lbr7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbr7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@lbr7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbr7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lbr7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbr7s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@lbr7s2, 'Proof of Onward/Return Travel', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(27, 7, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Check visaonarrival.lis.gov.lr directly for current pricing.', '2026-01-01', NOW(), 'https://visaonarrival.lis.gov.lr/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for Liberia?', 'No separate medical visa — the same VOA portal applies. Given limited local medical infrastructure, confirm treatment availability directly beforehand.', 27, 7, 2770, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    27, 8, 'LBR-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in Liberia.',
    'Conference attendees use the same VOA portal as business travellers.',
    'Up to 30-90 days',
    'Pre-apply online at visaonarrival.lis.gov.lr, then complete biometrics on arrival by air',
    1,
    'Apply 7 days to 3 months before travel.',
    'No authorized Liberian visa-issuing office in India — apply via the online VOA portal instead',
    'Confirm your passport is valid for 6+ months\nCarry conference invitation/registration confirmation\nPre-apply online at visaonarrival.lis.gov.lr\nGather proof of sufficient funds\nComplete biometric data collection on arrival',
    NULL,
    'lis.gov.lr secondary sourcing', 'https://visaonarrival.lis.gov.lr/', '2026-09-19'
);
SET @lbr8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lbr8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbr8, 'Core Documents', 'Required from every applicant.', 1);
SET @lbr8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbr8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@lbr8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbr8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lbr8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbr8s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@lbr8s2, 'Proof of Onward/Return Travel', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(27, 8, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Check visaonarrival.lis.gov.lr directly for current pricing.', '2026-01-01', NOW(), 'https://visaonarrival.lis.gov.lr/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for Liberia?', 'No separate conference visa — the same VOA portal applies as for business travel.', 27, 8, 2780, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    27, 9, 'LBR-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in Liberia.',
    'Sports travellers use the same VOA portal as tourists.',
    'Up to 30-90 days',
    'Pre-apply online at visaonarrival.lis.gov.lr, then complete biometrics on arrival by air',
    1,
    'Apply 7 days to 3 months before travel.',
    'No authorized Liberian visa-issuing office in India — apply via the online VOA portal instead',
    'Confirm your passport is valid for 6+ months\nCarry event invitation/participation confirmation\nPre-apply online at visaonarrival.lis.gov.lr\nGather proof of sufficient funds\nComplete biometric data collection on arrival',
    NULL,
    'lis.gov.lr secondary sourcing', 'https://visaonarrival.lis.gov.lr/', '2026-09-19'
);
SET @lbr9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lbr9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbr9, 'Core Documents', 'Required from every applicant.', 1);
SET @lbr9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbr9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@lbr9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbr9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lbr9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbr9s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@lbr9s2, 'Proof of Onward/Return Travel', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(27, 9, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Check visaonarrival.lis.gov.lr directly for current pricing.', '2026-01-01', NOW(), 'https://visaonarrival.lis.gov.lr/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a sports visa for Liberia?', 'No separate sports visa — the same VOA portal applies as for tourist travel.', 27, 9, 2790, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    27, 10, 'LBR-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent who holds a Liberia Work Visa.',
    'Dependants enter via the same VOA portal; longer stays alongside a Work Visa holder are expected to require their own registration/dependant documentation.',
    'Tied to the primary permit holder\'s Work Visa validity',
    'Pre-apply online at visaonarrival.lis.gov.lr, then register locally alongside the primary permit holder',
    1,
    'Not independently confirmed this session: exact dependant registration process and fee.',
    'No authorized Liberian visa-issuing office in India — apply via the online VOA portal instead',
    'Confirm the primary permit holder\'s Work Visa status in Liberia\nGather proof of relationship (marriage/birth certificate)\nPre-apply online at visaonarrival.lis.gov.lr\nComplete biometric data collection on arrival\nRegister locally alongside the primary permit holder',
    NULL,
    'akbartravels.com secondary sourcing', 'https://www.akbartravels.com/in/visas/liberia-work-visa', '2026-09-19'
);
SET @lbr10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lbr10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbr10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @lbr10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbr10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@lbr10s1, 'Proof of Relationship to Primary Permit Holder', NULL, 'original', 1, 0, 1, 2),
(@lbr10s1, 'Primary Permit Holder\'s Work Visa Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lbr10, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @lbr10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lbr10s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@lbr10s2, 'Proof of Accommodation', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(27, 10, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Dependant registration fees were not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/liberia-work-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do dependants of Work Visa holders need their own documentation in Liberia?', 'Expected to require local registration alongside the primary permit holder — not independently confirmed this session; enter via the same VOA portal.', 27, 10, 2700, 1);
