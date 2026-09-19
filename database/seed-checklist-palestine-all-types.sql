-- Palestine (Palestinian Territories) Visa Checklist Engine content
-- for all 10 visa types — built fresh this session via web search.
--
-- Palestine's real, distinctive facts verified this session:
--   - CRITICAL SAFETY CAVEAT: multiple governments (Australia,
--     Singapore, and others) advise against all travel to Gaza and
--     against non-essential travel to the West Bank (including
--     Bethlehem, Jericho, and Ramallah) amid an unpredictable
--     security situation, ongoing military activity, armed conflict,
--     and terrorism. A specific, dedicated MEA advisory statement for
--     Palestine was not located in sources reviewed this session —
--     flagged as a sourcing gap rather than assumed absent; travellers
--     should check mea.gov.in directly given the fast-changing
--     regional situation.
--   - Distinctive entry mechanic: Palestine has no independent entry
--     control of its own — access is entirely via Israel, Jordan, or
--     Egypt, and it is Israeli authorities who issue the effective
--     tourist visa/entry permit covering West Bank travel, either on
--     arrival or through the embassy/consulate in advance.
--   - Israel introduced an eVisa system for Indian tourists from
--     January 2025 — this is the recommended route for Indian
--     citizens travelling to the West Bank via Israel.
--   - India maintains a "Representative Office of India" in Ramallah
--     rather than a full embassy, reflecting Palestine's disputed
--     statehood status.
--
-- country_id 88 = Palestine. visa_type_id: 1=Tourist, 2=Business,
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
    88, 1, 'PSE-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to the Palestinian Territories (West Bank).',
    'IMPORTANT: multiple governments advise against all travel to Gaza and against non-essential travel to the West Bank (including Bethlehem, Jericho, and Ramallah) amid an unpredictable security situation. Separately, entry is controlled entirely by Israeli authorities, who issue the effective tourist visa/entry permit — Palestine has no independent entry control of its own.',
    'Per Israeli-issued entry permit validity',
    'Apply for the Israeli eVisa (available to Indian tourists since January 2025), or obtain entry permission on arrival via Israel',
    0,
    'Review the current security situation before booking. Access is also possible via Jordan or Egypt, subject to their own entry rules.',
    'Israeli Embassy/Consulate, India (for entry permission); Representative Office of India, Ramallah',
    'Review the current security situation for the West Bank and Gaza\nConfirm your passport is valid for 6+ months\nApply for the Israeli eVisa, or plan for entry permission on arrival via Israel\nGather proof of accommodation and return ticket\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/palestine.webp',
    'bankbazaar.com and akbartravels.com secondary sourcing', 'https://www.bankbazaar.com/visa/palestinian-territories-visa-for-indians.html', '2026-09-19'
);
SET @pse1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pse1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pse1, 'Core Documents', 'Required from every applicant.', 1);
SET @pse1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pse1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pse1s1, 'Israeli eVisa or Entry Permission', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pse1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @pse1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pse1s2, 'Proof of Accommodation', NULL, 'copy', 1, 0, 0, 1),
(@pse1s2, 'Proof of Return Flight Ticket', NULL, 'copy', 1, 0, 0, 2),
(@pse1s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(88, 1, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Fee for the Israeli eVisa/entry permission was not independently confirmed this session — verify directly.', '2026-01-01', NOW(), 'https://www.bankbazaar.com/visa/palestinian-territories-visa-for-indians.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is it safe to travel to the West Bank or Gaza right now?', 'Multiple governments advise against all travel to Gaza and against non-essential travel to the West Bank amid an unpredictable security situation. A dedicated MEA advisory for Palestine was not located this session — check mea.gov.in directly given the fast-changing situation.', 88, 1, 8800, 1),
('Who issues the visa for entering Palestine?', 'Israeli authorities control entry and issue the effective tourist visa/entry permit, since Palestine has no independent entry control of its own — access is via Israel, Jordan, or Egypt.', 88, 1, 8801, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    88, 2, 'PSE-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in the Palestinian Territories.',
    'IMPORTANT: review the current security situation before booking. Business travellers use the same Israeli-controlled entry framework as tourists.',
    'Per Israeli-issued entry permit validity',
    'Apply for the Israeli eVisa, or obtain entry permission on arrival via Israel',
    0,
    'Review the current security situation before booking.',
    'Israeli Embassy/Consulate, India; Representative Office of India, Ramallah',
    'Review the current security situation\nApply for the Israeli eVisa, or plan for entry permission on arrival\nCarry a business invitation letter from the host organization\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/palestine.webp',
    'bankbazaar.com secondary sourcing', 'https://www.bankbazaar.com/visa/palestinian-territories-visa-for-indians.html', '2026-09-19'
);
SET @pse2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pse2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pse2, 'Core Documents', 'Required from every applicant.', 1);
SET @pse2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pse2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pse2s1, 'Business Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pse2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @pse2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pse2s2, 'Company Sponsorship Letter', NULL, 'copy', 0, 1, 0, 1),
(@pse2s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(88, 2, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Fee was not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.bankbazaar.com/visa/palestinian-territories-visa-for-indians.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travellers need a visa for Palestine?', 'Entry is controlled by Israeli authorities via the eVisa/entry-permission process. Review the current security situation before booking.', 88, 2, 8820, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    88, 3, 'PSE-STU-IN-01', '2026.09', 'published',
    'Academic study at a Palestinian educational institution (e.g. Birzeit University).',
    'IMPORTANT: review the current security situation before committing to study in the West Bank. Sources reviewed this session did not describe a dedicated student-visa category distinct from the general Israeli-controlled entry framework.',
    'Study-program length, via extended Israeli-issued permit',
    'Apply through Israeli authorities, with a university admission letter',
    1,
    'Review the current security situation. Not independently confirmed this session: exact student-visa process for extended stays.',
    'Israeli Embassy/Consulate, India; Representative Office of India, Ramallah',
    'Review the current security situation\nSecure admission from a Palestinian educational institution\nApply through Israeli authorities for an extended entry permit\nGather proof of sufficient funds\nRegister with the Representative Office of India, Ramallah',
    '/assets/images/visa-heroes/palestine.webp',
    'bankbazaar.com secondary sourcing', 'https://www.bankbazaar.com/visa/palestinian-territories-visa-for-indians.html', '2026-09-19'
);
SET @pse3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pse3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pse3, 'Core Documents', 'Required from every applicant.', 1);
SET @pse3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pse3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pse3s1, 'Proof of Admission/Enrollment Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pse3, 'Supporting Documents', 'Evidence of your means and academic status.', 2);
SET @pse3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pse3s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(88, 3, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Fee was not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.bankbazaar.com/visa/palestinian-territories-visa-for-indians.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Should Indian students study in the West Bank given the current situation?', 'This should be weighed very heavily given the current security situation — check the latest guidance before committing.', 88, 3, 8830, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    88, 4, 'PSE-WORK-IN-01', '2026.09', 'published',
    'Employment in the Palestinian Territories under a local employer (e.g. NGO/humanitarian work).',
    'IMPORTANT: review the current security situation before accepting employment in the West Bank or Gaza. Work-related entry requires coordination with Israeli authorities, given their control over entry permits.',
    'Per Israeli-issued work-related permit validity',
    'Employer/sponsor coordinates your entry permit with Israeli authorities',
    1,
    'Review the current security situation. Not independently confirmed this session: exact work-visa fee and process.',
    'Israeli Embassy/Consulate, India; Representative Office of India, Ramallah',
    'Review the current security situation\nSecure a job offer or sponsorship from a Palestinian employer/organization\nCoordinate your entry permit through Israeli authorities\nGather employment/sponsorship documentation\nRegister with the Representative Office of India, Ramallah',
    '/assets/images/visa-heroes/palestine.webp',
    'bankbazaar.com secondary sourcing', 'https://www.bankbazaar.com/visa/palestinian-territories-visa-for-indians.html', '2026-09-19'
);
SET @pse4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pse4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pse4, 'Core Documents', 'Required from every work-visa applicant.', 1);
SET @pse4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pse4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pse4s1, 'Employment/Sponsorship Documentation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pse4, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @pse4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pse4s2, 'Educational/Professional Certificates', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(88, 4, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Fee was not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.bankbazaar.com/visa/palestinian-territories-visa-for-indians.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian citizens work in the Palestinian Territories?', 'Entry for work purposes requires coordination through Israeli authorities, who control entry permits. Review the current security situation carefully first.', 88, 4, 8840, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    88, 5, 'PSE-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in the Palestinian Territories.',
    'IMPORTANT: review the current security situation before booking. Family visitors use the same Israeli-controlled entry framework as tourists.',
    'Per Israeli-issued entry permit validity',
    'Apply for the Israeli eVisa, or obtain entry permission on arrival via Israel',
    0,
    'Review the current security situation before booking.',
    'Israeli Embassy/Consulate, India; Representative Office of India, Ramallah',
    'Review the current security situation\nApply for the Israeli eVisa, or plan for entry permission on arrival\nCarry proof of relationship and host contact details\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/palestine.webp',
    'bankbazaar.com secondary sourcing', 'https://www.bankbazaar.com/visa/palestinian-territories-visa-for-indians.html', '2026-09-19'
);
SET @pse5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pse5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pse5, 'Core Documents', 'Required from every applicant.', 1);
SET @pse5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pse5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pse5s1, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pse5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @pse5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pse5s2, 'Host Invitation Letter', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(88, 5, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Fee was not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.bankbazaar.com/visa/palestinian-territories-visa-for-indians.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit family in the Palestinian Territories?', 'Entry is controlled by Israeli authorities via the eVisa/entry-permission process. Review the current security situation before travelling.', 88, 5, 8850, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    88, 6, 'PSE-TRAN-IN-01', '2026.09', 'published',
    'Transit through the Palestinian Territories en route to another destination.',
    'Given the security situation and Israeli control of entry, transit through the West Bank/Gaza should be avoided wherever an alternative routing exists.',
    'Not recommended given the current situation',
    'Seek alternative routing avoiding the West Bank/Gaza',
    0,
    'No dedicated airport exists in the Palestinian Territories — most travel routes through Israeli, Jordanian, or Egyptian airports.',
    'Israeli Embassy/Consulate, India',
    'Seek alternative routing avoiding the West Bank/Gaza\nConfirm current entry rules via Israel, Jordan, or Egypt if travel is essential\nReview the current security situation before any transit',
    '/assets/images/visa-heroes/palestine.webp',
    'bankbazaar.com secondary sourcing', 'https://www.bankbazaar.com/visa/palestinian-territories-visa-for-indians.html', '2026-09-19'
);
SET @pse6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pse6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pse6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @pse6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pse6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(88, 6, 0.00, 'USD', 'Fee Not Independently Confirmed', 'No dedicated transit process was identified — avoid if possible.', '2026-01-01', NOW(), 'https://www.bankbazaar.com/visa/palestinian-territories-visa-for-indians.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian citizens transit through the Palestinian Territories?', 'Given the current security situation, seek alternative routing wherever possible — there is no dedicated airport in the West Bank or Gaza.', 88, 6, 8860, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    88, 7, 'PSE-MED-IN-01', '2026.09', 'published',
    'Medical treatment in the Palestinian Territories.',
    'IMPORTANT: the Palestinian Territories are not a recommended destination for inbound medical travel given the current security situation.',
    'Per Israeli-issued entry permit validity',
    'Apply for the Israeli eVisa, or obtain entry permission on arrival via Israel',
    0,
    'Review the current security situation. Verify treatment facility availability and safety directly.',
    'Israeli Embassy/Consulate, India; Representative Office of India, Ramallah',
    'Review the current security situation\nConfirm treatment and appointment directly with the medical facility\nApply for the Israeli eVisa, or plan for entry permission on arrival\nGather proof of sufficient funds\nCarry all medical and travel documents for immigration',
    '/assets/images/visa-heroes/palestine.webp',
    'bankbazaar.com secondary sourcing', 'https://www.bankbazaar.com/visa/palestinian-territories-visa-for-indians.html', '2026-09-19'
);
SET @pse7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pse7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pse7, 'Core Documents', 'Required from every applicant.', 1);
SET @pse7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pse7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pse7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pse7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @pse7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pse7s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(88, 7, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Fee was not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.bankbazaar.com/visa/palestinian-territories-visa-for-indians.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for the Palestinian Territories?', 'No separate medical visa — entry follows the Israeli-controlled framework. Given the current situation, this is not a recommended destination for medical travel.', 88, 7, 8870, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    88, 8, 'PSE-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in the Palestinian Territories.',
    'IMPORTANT: review the current security situation before booking. Conference attendees use the same Israeli-controlled entry framework as business travellers.',
    'Per Israeli-issued entry permit validity',
    'Apply for the Israeli eVisa, or obtain entry permission on arrival via Israel',
    0,
    'Review the current security situation before booking.',
    'Israeli Embassy/Consulate, India; Representative Office of India, Ramallah',
    'Review the current security situation\nCarry conference invitation/registration confirmation\nApply for the Israeli eVisa, or plan for entry permission on arrival\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/palestine.webp',
    'bankbazaar.com secondary sourcing', 'https://www.bankbazaar.com/visa/palestinian-territories-visa-for-indians.html', '2026-09-19'
);
SET @pse8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pse8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pse8, 'Core Documents', 'Required from every applicant.', 1);
SET @pse8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pse8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pse8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pse8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @pse8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pse8s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(88, 8, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Fee was not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.bankbazaar.com/visa/palestinian-territories-visa-for-indians.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for the Palestinian Territories?', 'No separate conference visa — entry follows the Israeli-controlled framework. Review the current security situation before booking.', 88, 8, 8880, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    88, 9, 'PSE-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in the Palestinian Territories.',
    'IMPORTANT: review the current security situation before booking. Sports travellers use the same Israeli-controlled entry framework as tourists.',
    'Per Israeli-issued entry permit validity',
    'Apply for the Israeli eVisa, or obtain entry permission on arrival via Israel',
    0,
    'Review the current security situation before booking.',
    'Israeli Embassy/Consulate, India; Representative Office of India, Ramallah',
    'Review the current security situation\nCarry event invitation/participation confirmation\nApply for the Israeli eVisa, or plan for entry permission on arrival\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/palestine.webp',
    'bankbazaar.com secondary sourcing', 'https://www.bankbazaar.com/visa/palestinian-territories-visa-for-indians.html', '2026-09-19'
);
SET @pse9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pse9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pse9, 'Core Documents', 'Required from every applicant.', 1);
SET @pse9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pse9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pse9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pse9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @pse9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pse9s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(88, 9, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Fee was not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.bankbazaar.com/visa/palestinian-territories-visa-for-indians.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a sports visa for the Palestinian Territories?', 'No separate sports visa — entry follows the Israeli-controlled framework. Review the current security situation before booking.', 88, 9, 8890, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    88, 10, 'PSE-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent with an established presence in the Palestinian Territories.',
    'IMPORTANT: the current security situation should weigh heavily on whether dependants join a primary permit holder there at all.',
    'Tied to the primary permit holder\'s status',
    'Apply for entry via Israeli authorities, referencing the primary permit holder\'s status',
    1,
    'Review the current security situation before proceeding.',
    'Israeli Embassy/Consulate, India; Representative Office of India, Ramallah',
    'Review the current security situation\nConfirm the primary permit holder\'s status\nGather proof of relationship (marriage/birth certificate)\nApply for entry via Israeli authorities\nRegister with the Representative Office of India, Ramallah',
    '/assets/images/visa-heroes/palestine.webp',
    'bankbazaar.com secondary sourcing', 'https://www.bankbazaar.com/visa/palestinian-territories-visa-for-indians.html', '2026-09-19'
);
SET @pse10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pse10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pse10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @pse10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pse10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pse10s1, 'Proof of Relationship (Marriage/Birth Certificate)', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pse10, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @pse10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pse10s2, 'Primary Permit Holder\'s Status Documentation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(88, 10, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Fee was not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.bankbazaar.com/visa/palestinian-territories-visa-for-indians.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Should dependants join a permit holder in the Palestinian Territories?', 'Given the current security situation, this should be very carefully reconsidered before proceeding.', 88, 10, 8800, 1);
