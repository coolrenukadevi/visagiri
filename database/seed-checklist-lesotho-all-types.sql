-- Lesotho Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Lesotho's real, distinctive facts verified this session:
--   - All Indian passport holders require a visa for Lesotho.
--     Sourcing conflict flagged rather than silently resolved: one
--     source states Indians must apply through a traditional paper/
--     embassy visa (no eVisa/VOA), while another states Indians are
--     eligible for an eVisa — the eVisa claim is used as primary since
--     it names a specific mechanism, with the conflict flagged.
--   - Lesotho maintains a resident High Commission in New Delhi
--     (opened following a 2003 prime-ministerial visit), located at
--     E-26 Poorvi Marg, Vasant Vihar, plus an Honorary Consul in
--     Mumbai — used as the consular office for embassy-route
--     applications.
--   - The tourist visa cannot be used for employment — a separate
--     work-visa category is required, coordinated regionally in part
--     through the High Commission of India, Pretoria, South Africa,
--     given Lesotho's status as an enclave country within South
--     Africa.
--   - Fee reference: Akbar Travels cites tourist visa service pricing
--     starting at INR 11,850 (an agency price, not necessarily the
--     official government fee) — flagged as such rather than
--     presented as the confirmed official fee.
--
-- country_id 26 = Lesotho. visa_type_id: 1=Tourist, 2=Business,
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
    26, 1, 'LSO-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Lesotho.',
    'All Indian passport holders require a visa for Lesotho. Sources disagree on the channel: one describes a traditional paper/embassy visa only, another describes eVisa eligibility for Indians — this conflict is flagged rather than resolved.',
    'Per visa validity',
    'Apply for the eVisa online if available, or through the High Commission of Lesotho, New Delhi',
    0,
    'Not independently confirmed this session which application channel (eVisa vs. embassy-only) is currently correct — verify directly with the High Commission of Lesotho before assuming an eVisa is available.',
    'High Commission of Lesotho, New Delhi (E-26 Poorvi Marg, Vasant Vihar); Honorary Consul, Mumbai',
    'Confirm your passport is valid for 6+ months\nCheck whether the Lesotho eVisa portal is currently accepting Indian applicants\nIf unavailable, apply through the High Commission of Lesotho, New Delhi\nGather proof of accommodation and sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'joinsherpa.com and atlys.com secondary sourcing', 'https://apply.joinsherpa.com/visa/lesotho/indian-citizens', '2026-09-19'
);
SET @lso1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lso1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lso1, 'Core Documents', 'Required from every applicant.', 1);
SET @lso1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lso1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@lso1s1, 'Approved eVisa or Embassy Visa', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lso1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lso1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lso1s2, 'Proof of Accommodation', NULL, 'copy', 1, 0, 0, 1),
(@lso1s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(26, 1, 11850.00, 'INR', 'Tourist Visa Fee (Agency-Quoted, Not Official)', 'This figure comes from a travel agency\'s service pricing (Akbar Travels), not a confirmed official government fee — verify the official fee with the High Commission of Lesotho, New Delhi.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/lesotho-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Lesotho?', 'Yes — all Indian passport holders require a visa. Sources disagree on whether an eVisa is available or whether only the traditional embassy visa applies; verify directly with the High Commission of Lesotho, New Delhi.', 26, 1, 2600, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    26, 2, 'LSO-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Lesotho.',
    'Business travellers use the same visa framework as tourists, with a business invitation letter as additional support.',
    'Per visa validity',
    'Apply for the eVisa online if available, or through the High Commission of Lesotho, New Delhi',
    0,
    'Same eVisa/embassy sourcing conflict as the tourist visa applies.',
    'High Commission of Lesotho, New Delhi',
    'Confirm your passport is valid for 6+ months\nCheck eVisa availability, or apply through the High Commission of Lesotho, New Delhi\nCarry a business invitation letter from the host organization\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'joinsherpa.com secondary sourcing', 'https://apply.joinsherpa.com/visa/lesotho/indian-citizens', '2026-09-19'
);
SET @lso2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lso2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lso2, 'Core Documents', 'Required from every applicant.', 1);
SET @lso2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lso2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@lso2s1, 'Business Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lso2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @lso2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lso2s2, 'Company Sponsorship Letter', NULL, 'copy', 0, 1, 0, 1),
(@lso2s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(26, 2, 11850.00, 'INR', 'Business Visa Fee (Agency-Quoted, Not Official)', 'Same agency-quoted figure as the tourist visa; verify the official fee with the High Commission of Lesotho, New Delhi.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/lesotho-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travellers need a visa for Lesotho?', 'Yes — the same visa framework applies as for tourist travel, with a business invitation letter recommended.', 26, 2, 2620, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    26, 3, 'LSO-STU-IN-01', '2026.09', 'published',
    'Academic study at a Lesotho educational institution.',
    'Sources reviewed this session did not describe a dedicated Lesotho student-visa category distinct from the general embassy visa process, applied for once admission is secured.',
    'Study-program length, renewable',
    'Apply through the High Commission of Lesotho, New Delhi, with a university admission letter',
    1,
    'Not independently confirmed this session whether a distinct student-visa category exists — verify directly with your institution and the High Commission of Lesotho, New Delhi.',
    'High Commission of Lesotho, New Delhi',
    'Confirm admission with a Lesotho educational institution\nGather passport, admission letter, and proof of funds\nApply through the High Commission of Lesotho, New Delhi\nRegister with local authorities after arrival if required\nRenew your visa as needed for continued study',
    NULL,
    'joinsherpa.com secondary sourcing', 'https://apply.joinsherpa.com/visa/lesotho/indian-citizens', '2026-09-19'
);
SET @lso3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lso3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lso3, 'Core Documents', 'Required from every applicant.', 1);
SET @lso3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lso3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@lso3s1, 'Proof of Admission/Enrollment Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lso3, 'Supporting Documents', 'Evidence of your means and academic status.', 2);
SET @lso3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lso3s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@lso3s2, 'Proof of Accommodation', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(26, 3, 0.00, 'INR', 'Fee Not Independently Confirmed', 'Student visa fees were not independently confirmed this session — verify with the High Commission of Lesotho, New Delhi.', '2026-01-01', NOW(), 'https://apply.joinsherpa.com/visa/lesotho/indian-citizens', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated student visa for Lesotho?', 'Not independently confirmed this session — apply through the general embassy visa process once admission is secured, via the High Commission of Lesotho, New Delhi.', 26, 3, 2630, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    26, 4, 'LSO-WORK-IN-01', '2026.09', 'published',
    'Employment in Lesotho under a local employer.',
    'The standard tourist visa cannot be used for employment — a distinct work-visa category is required, sponsored by a local employer.',
    'Per work-permit validity, renewable',
    'Employer sponsors your work-visa application through the High Commission of Lesotho, New Delhi',
    1,
    'Not independently confirmed this session: exact work-visa fee and process — verify with the High Commission of Lesotho and Lesotho labour authorities.',
    'High Commission of Lesotho, New Delhi',
    'Secure a job offer from a Lesotho employer\nGather employment contract/sponsorship letter\nApply through the High Commission of Lesotho, New Delhi\nRegister with local labour authorities on arrival\nRenew your work visa as required for continued employment',
    NULL,
    'akbartravels.com secondary sourcing', 'https://www.akbartravels.com/visa/lesotho-visa', '2026-09-19'
);
SET @lso4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lso4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lso4, 'Core Documents', 'Required from every work-visa applicant.', 1);
SET @lso4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lso4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@lso4s1, 'Employment Contract/Sponsorship Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lso4, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @lso4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lso4s2, 'Educational/Professional Certificates', NULL, 'copy', 0, 1, 0, 1),
(@lso4s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(26, 4, 0.00, 'INR', 'Fee Not Independently Confirmed', 'Work visa fees were not independently confirmed this session — verify with the High Commission of Lesotho, New Delhi.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/lesotho-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I work in Lesotho on a tourist visa?', 'No — the tourist visa cannot be used for employment. A distinct work-visa category, sponsored by a local employer, is required.', 26, 4, 2640, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    26, 5, 'LSO-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in Lesotho.',
    'Family visitors use the same visa framework as tourists.',
    'Per visa validity',
    'Apply for the eVisa online if available, or through the High Commission of Lesotho, New Delhi',
    0,
    'Same eVisa/embassy sourcing conflict as the tourist visa applies.',
    'High Commission of Lesotho, New Delhi',
    'Confirm your passport is valid for 6+ months\nCheck eVisa availability, or apply through the High Commission of Lesotho, New Delhi\nCarry proof of relationship and host contact details\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'joinsherpa.com secondary sourcing', 'https://apply.joinsherpa.com/visa/lesotho/indian-citizens', '2026-09-19'
);
SET @lso5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lso5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lso5, 'Core Documents', 'Required from every applicant.', 1);
SET @lso5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lso5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@lso5s1, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lso5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lso5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lso5s2, 'Host Invitation Letter', NULL, 'copy', 0, 1, 0, 1),
(@lso5s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(26, 5, 11850.00, 'INR', 'Family Visit Visa Fee (Agency-Quoted, Not Official)', 'Same agency-quoted figure as the tourist visa; verify the official fee with the High Commission of Lesotho, New Delhi.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/lesotho-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit family in Lesotho?', 'Yes — the same visa framework applies as for tourist travel.', 26, 5, 2650, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    26, 6, 'LSO-TRAN-IN-01', '2026.09', 'published',
    'Transit through Lesotho en route to another destination.',
    'Given Lesotho\'s enclave geography within South Africa, most travel routes through South African airports/borders first. Sources reviewed this session did not describe a dedicated Lesotho transit-visa category distinct from the general visa framework.',
    'Short transit only',
    'Apply for the eVisa online if available, or through the High Commission of Lesotho, New Delhi, before transiting',
    0,
    'Not independently confirmed this session whether a dedicated transit exemption exists — verify with your travel operator before relying on transiting without a visa.',
    'High Commission of Lesotho, New Delhi',
    'Confirm your connecting travel and transit time\nCheck eVisa availability, or apply through the High Commission of Lesotho, New Delhi\nCarry your onward travel documents and passport\nConfirm transit requirements directly with your travel operator',
    NULL,
    'joinsherpa.com secondary sourcing (transit exemption not independently confirmed)', 'https://apply.joinsherpa.com/visa/lesotho/indian-citizens', '2026-09-19'
);
SET @lso6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lso6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lso6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @lso6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lso6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@lso6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(26, 6, 0.00, 'INR', 'Fee Not Independently Confirmed', 'Transit visa fee was not independently confirmed this session — verify with the High Commission of Lesotho, New Delhi.', '2026-01-01', NOW(), 'https://apply.joinsherpa.com/visa/lesotho/indian-citizens', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a transit visa for Lesotho?', 'Not independently confirmed this session. Most routes pass through South African airports/borders first — confirm requirements for both South Africa and Lesotho with your travel operator.', 26, 6, 2660, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    26, 7, 'LSO-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Lesotho.',
    'Medical travellers use the same visa framework as tourists. Note: Lesotho\'s medical infrastructure is limited; more serious treatment is often referred to South Africa — verify facility availability directly.',
    'Per visa validity',
    'Apply for the eVisa online if available, or through the High Commission of Lesotho, New Delhi',
    0,
    'Confirm treatment availability directly given Lesotho\'s limited medical infrastructure.',
    'High Commission of Lesotho, New Delhi',
    'Confirm treatment and appointment directly with the Lesotho medical facility\nCheck eVisa availability, or apply through the High Commission of Lesotho, New Delhi\nGather proof of sufficient funds\nCarry all medical and travel documents for immigration',
    NULL,
    'joinsherpa.com secondary sourcing', 'https://apply.joinsherpa.com/visa/lesotho/indian-citizens', '2026-09-19'
);
SET @lso7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lso7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lso7, 'Core Documents', 'Required from every applicant.', 1);
SET @lso7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lso7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@lso7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lso7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lso7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lso7s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@lso7s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(26, 7, 11850.00, 'INR', 'Medical Visa Fee (Agency-Quoted, Not Official)', 'Same agency-quoted figure as the tourist visa; verify the official fee with the High Commission of Lesotho, New Delhi.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/lesotho-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for Lesotho?', 'No separate medical visa — the same visa framework applies. Given limited local medical infrastructure, confirm treatment availability directly beforehand.', 26, 7, 2670, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    26, 8, 'LSO-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in Lesotho.',
    'Conference attendees use the same visa framework as business travellers.',
    'Per visa validity',
    'Apply for the eVisa online if available, or through the High Commission of Lesotho, New Delhi',
    0,
    'Same eVisa/embassy sourcing conflict as the business visa applies.',
    'High Commission of Lesotho, New Delhi',
    'Confirm your passport is valid for 6+ months\nCarry conference invitation/registration confirmation\nCheck eVisa availability, or apply through the High Commission of Lesotho, New Delhi\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'joinsherpa.com secondary sourcing', 'https://apply.joinsherpa.com/visa/lesotho/indian-citizens', '2026-09-19'
);
SET @lso8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lso8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lso8, 'Core Documents', 'Required from every applicant.', 1);
SET @lso8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lso8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@lso8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lso8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lso8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lso8s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@lso8s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(26, 8, 11850.00, 'INR', 'Conference Visa Fee (Agency-Quoted, Not Official)', 'Same agency-quoted figure as the business visa; verify the official fee with the High Commission of Lesotho, New Delhi.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/lesotho-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for Lesotho?', 'No separate conference visa — the same visa framework applies as for business travel.', 26, 8, 2680, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    26, 9, 'LSO-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in Lesotho.',
    'Sports travellers use the same visa framework as tourists.',
    'Per visa validity',
    'Apply for the eVisa online if available, or through the High Commission of Lesotho, New Delhi',
    0,
    'Same eVisa/embassy sourcing conflict as the tourist visa applies.',
    'High Commission of Lesotho, New Delhi',
    'Confirm your passport is valid for 6+ months\nCarry event invitation/participation confirmation\nCheck eVisa availability, or apply through the High Commission of Lesotho, New Delhi\nGather proof of sufficient funds\nCarry all documents for immigration on arrival',
    NULL,
    'joinsherpa.com secondary sourcing', 'https://apply.joinsherpa.com/visa/lesotho/indian-citizens', '2026-09-19'
);
SET @lso9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lso9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lso9, 'Core Documents', 'Required from every applicant.', 1);
SET @lso9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lso9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@lso9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lso9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @lso9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lso9s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@lso9s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(26, 9, 11850.00, 'INR', 'Sports Visa Fee (Agency-Quoted, Not Official)', 'Same agency-quoted figure as the tourist visa; verify the official fee with the High Commission of Lesotho, New Delhi.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/lesotho-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a sports visa for Lesotho?', 'No separate sports visa — the same visa framework applies as for tourist travel.', 26, 9, 2690, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    26, 10, 'LSO-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent who holds a Lesotho work/student visa.',
    'Dependants apply through the High Commission of Lesotho, New Delhi, referencing the primary permit holder\'s visa/sponsorship.',
    'Tied to the primary permit holder\'s visa validity',
    'Apply through the High Commission of Lesotho, New Delhi, referencing the primary permit holder\'s visa',
    1,
    'Not independently confirmed this session: exact dependant-visa fee and processing time — verify with the High Commission of Lesotho, New Delhi.',
    'High Commission of Lesotho, New Delhi',
    'Confirm the primary permit holder\'s work/student visa status\nGather proof of relationship (marriage/birth certificate)\nApply through the High Commission of Lesotho, New Delhi\nRegister with local authorities on arrival if required\nRenew your visa alongside the primary permit holder',
    NULL,
    'joinsherpa.com secondary sourcing', 'https://apply.joinsherpa.com/visa/lesotho/indian-citizens', '2026-09-19'
);
SET @lso10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@lso10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lso10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @lso10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lso10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@lso10s1, 'Proof of Relationship (Marriage/Birth Certificate)', NULL, 'original', 1, 0, 1, 2),
(@lso10s1, 'Primary Permit Holder\'s Visa Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@lso10, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @lso10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@lso10s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@lso10s2, 'Proof of Accommodation', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(26, 10, 0.00, 'INR', 'Fee Not Independently Confirmed', 'Dependant visa fees were not independently confirmed this session — verify with the High Commission of Lesotho, New Delhi.', '2026-01-01', NOW(), 'https://apply.joinsherpa.com/visa/lesotho/indian-citizens', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can dependants accompany a work/student visa holder to Lesotho?', 'Yes, via a separate application through the High Commission of Lesotho, New Delhi, referencing the primary permit holder\'s visa.', 26, 10, 2600, 1);
