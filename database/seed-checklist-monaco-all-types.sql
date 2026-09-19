-- Monaco Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Monaco's real, distinctive facts verified this session:
--   - Monaco does not issue its own visa — Indian citizens apply for a
--     French Schengen Short-Stay Visa (Type C), since Monaco follows
--     France's visa system under their bilateral customs union
--     agreement. There is no visa-on-arrival or visa-free entry.
--   - Applications route through VFS Global France Visa Application
--     Centres in India, or the French Embassy/Consulate — the same
--     Embassy of India in Paris also carries "France & Principality of
--     Monaco" in its formal name, reflecting this arrangement.
--   - Fee sourcing conflict flagged rather than silently resolved: one
--     source cites EUR 80 (adult short-stay), another EUR 90 — both
--     are presented, with EUR 90 used as the primary figure since it
--     is more consistently cited across sources for the standard
--     Schengen fee.
--   - Long-stay/work-visa fee for non-EEA nationals (including Indian
--     and Pakistani applicants) is a flat EUR 99, regardless of
--     nationality.
--
-- country_id 134 = Monaco. visa_type_id: 1=Tourist, 2=Business,
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
    134, 1, 'MCO-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Monaco.',
    'Indian citizens require a French Schengen Short-Stay Visa (Type C) to visit Monaco — Monaco does not issue its own visa and follows France\'s visa system.',
    'Up to 90 days within any 180-day period',
    'Apply for a French Schengen visa via VFS Global France or the French Embassy/Consulate in India',
    1,
    'Processing 15-30 working days, up to 45 during peak season. Fee sourcing varies (EUR 80-90) — verify current pricing.',
    'French Embassy/Consulate, India (Monaco visas processed via France); Embassy of India, Paris (covers France & Monaco)',
    'Confirm your passport is valid for 6+ months beyond your stay\nBook a biometric appointment at VFS Global France or the French Embassy\nPurchase Schengen travel insurance\nGather bank statements and income proof\nAttend your visa interview and submit biometrics',
    '/assets/images/visa-heroes/monaco.webp',
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/monaco-tourist-visa/', '2026-09-19'
);
SET @mco1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mco1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mco1, 'Core Documents', 'Required from every applicant.', 1);
SET @mco1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mco1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mco1s1, 'Schengen Visa Application Form', NULL, 'original', 1, 0, 1, 2),
(@mco1s1, 'Schengen Travel Insurance', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mco1, 'Supporting Documents', 'Evidence of your travel plans and financial means.', 2);
SET @mco1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mco1s2, 'Confirmed Return/Onward Flight Bookings', NULL, 'copy', 1, 0, 0, 1),
(@mco1s2, 'Hotel/Accommodation Reservation', NULL, 'copy', 1, 0, 0, 2),
(@mco1s2, 'Bank Statements (Last 3-6 Months)', NULL, 'original', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(134, 1, 90.00, 'EUR', 'Adult Schengen Visa Fee', 'Sourcing conflict flagged: one source cites EUR 80, another EUR 90 for the adult short-stay fee. Children 6-12: EUR 40-45; under 6 free.', '2026-01-01', NOW(), 'https://maxglob.com/monaco-visa-for-indian/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Monaco?', 'Yes — a French Schengen Short-Stay Visa (Type C), since Monaco does not issue its own visa and follows France\'s visa system.', 134, 1, 13400, 1),
('Where do Indian citizens apply for a Monaco visa?', 'Through VFS Global France Visa Application Centres in India, or the French Embassy/Consulate — the same channel used for France itself.', 134, 1, 13401, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    134, 2, 'MCO-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Monaco.',
    'Business travellers use the same French Schengen visa route as tourists, with a business invitation letter as additional support.',
    'Up to 90 days within any 180-day period',
    'Apply for a French Schengen visa via VFS Global France or the French Embassy/Consulate in India',
    1,
    'Same processing time as the tourist visa applies.',
    'French Embassy/Consulate, India (Monaco visas processed via France)',
    'Confirm your passport is valid for 6+ months beyond your stay\nBook a biometric appointment at VFS Global France or the French Embassy\nCarry a business invitation letter from the host organization\nPurchase Schengen travel insurance\nAttend your visa interview and submit biometrics',
    '/assets/images/visa-heroes/monaco.webp',
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/monaco-visa', '2026-09-19'
);
SET @mco2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mco2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mco2, 'Core Documents', 'Required from every applicant.', 1);
SET @mco2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mco2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mco2s1, 'Business Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mco2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @mco2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mco2s2, 'Company Sponsorship Letter', NULL, 'copy', 0, 1, 0, 1),
(@mco2s2, 'Bank Statements (Last 3-6 Months)', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(134, 2, 90.00, 'EUR', 'Adult Schengen Visa Fee', 'Same fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://maxglob.com/monaco-visa-for-indian/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travellers need a visa for Monaco?', 'Yes — the same French Schengen visa route applies, with a business invitation letter recommended.', 134, 2, 13420, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    134, 3, 'MCO-STU-IN-01', '2026.09', 'published',
    'Academic study at a Monaco educational institution.',
    'A short-stay Schengen visa does not cover long-term study — a French long-stay visa is required, processed via the same French Embassy/Consulate channel.',
    'Study-program length, via long-stay visa',
    'Apply for a French long-stay visa via the French Embassy/Consulate in India, with a university admission letter',
    1,
    'Not independently confirmed this session: exact student-visa fee — the general long-stay fee is EUR 99.',
    'French Embassy/Consulate, India (Monaco visas processed via France)',
    'Confirm admission with a Monaco educational institution\nGather passport, admission letter, and proof of funds\nApply for a French long-stay visa via the French Embassy/Consulate\nPurchase Schengen-compliant health insurance\nRegister with local authorities after arrival',
    '/assets/images/visa-heroes/monaco.webp',
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/monaco-visa', '2026-09-19'
);
SET @mco3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mco3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mco3, 'Core Documents', 'Required from every applicant.', 1);
SET @mco3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mco3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mco3s1, 'University Admission Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mco3, 'Supporting Documents', 'Evidence of your means and academic status.', 2);
SET @mco3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mco3s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@mco3s2, 'Schengen-Compliant Health Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(134, 3, 99.00, 'EUR', 'Long-Stay Visa Fee', 'Flat EUR 99 fee for non-EEA nationals applies to the general long-stay visa route.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/monaco-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I study in Monaco on a short-stay Schengen visa?', 'No — long-term study requires a French long-stay visa, processed via the French Embassy/Consulate in India.', 134, 3, 13430, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    134, 4, 'MCO-WORK-IN-01', '2026.09', 'published',
    'Employment in Monaco under a local employer.',
    'A short-stay Schengen visa does not permit work — employment requires a French long-stay work visa, coordinated with a Monaco work authorization, at a flat EUR 99 fee for non-EEA nationals.',
    'Per work-permit validity, renewable',
    'Employer sponsors your long-stay work-visa application via the French Embassy/Consulate',
    1,
    'Monaco maintains its own local employment-priority rules favoring Monegasque and French/Italian cross-border workers — verify current quota/priority rules directly.',
    'French Embassy/Consulate, India (Monaco visas processed via France)',
    'Secure a job offer from a Monaco employer\nEmployer sponsors your long-stay work-visa application\nApply via the French Embassy/Consulate, India\nConfirm Monaco\'s local work-authorization requirements\nRegister with local authorities after arrival',
    '/assets/images/visa-heroes/monaco.webp',
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/monaco-visa', '2026-09-19'
);
SET @mco4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mco4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mco4, 'Core Documents', 'Required from every work-visa applicant.', 1);
SET @mco4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mco4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mco4s1, 'Employment Contract/Sponsorship Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mco4, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @mco4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mco4s2, 'Educational/Professional Certificates', NULL, 'copy', 0, 1, 0, 1),
(@mco4s2, 'Schengen-Compliant Health Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(134, 4, 99.00, 'EUR', 'Long-Stay Work Visa Fee', 'Flat EUR 99 fee for non-EEA nationals including Indian applicants.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/monaco-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How much does a Monaco work visa cost for Indian citizens?', 'A flat EUR 99 long-stay visa fee applies for non-EEA nationals, including Indian applicants, processed via the French Embassy/Consulate.', 134, 4, 13440, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    134, 5, 'MCO-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in Monaco.',
    'Family visitors use the same French Schengen visa route as tourists.',
    'Up to 90 days within any 180-day period',
    'Apply for a French Schengen visa via VFS Global France or the French Embassy/Consulate in India',
    1,
    'Carry a host invitation letter along with the standard documents.',
    'French Embassy/Consulate, India (Monaco visas processed via France)',
    'Confirm your passport is valid for 6+ months beyond your stay\nBook a biometric appointment at VFS Global France or the French Embassy\nCarry proof of relationship and a host invitation letter\nPurchase Schengen travel insurance\nAttend your visa interview and submit biometrics',
    '/assets/images/visa-heroes/monaco.webp',
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/monaco-visa', '2026-09-19'
);
SET @mco5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mco5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mco5, 'Core Documents', 'Required from every applicant.', 1);
SET @mco5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mco5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mco5s1, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mco5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mco5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mco5s2, 'Host Invitation Letter', NULL, 'original', 1, 0, 0, 1),
(@mco5s2, 'Bank Statements (Last 3-6 Months)', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(134, 5, 90.00, 'EUR', 'Adult Schengen Visa Fee', 'Same fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://maxglob.com/monaco-visa-for-indian/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit family in Monaco?', 'Yes — the same French Schengen visa route applies as for tourist travel.', 134, 5, 13450, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    134, 6, 'MCO-TRAN-IN-01', '2026.09', 'published',
    'Transit through Monaco en route to another destination.',
    'Monaco has no international airport of its own — most travel routes through Nice Cote d\'Azur Airport (France) first, using the same French Schengen visa framework.',
    'Short transit, within Schengen rules',
    'Apply for a French Schengen visa if you do not already hold a valid Schengen visa',
    1,
    'Not required if you already hold a valid Schengen visa from another member state.',
    'French Embassy/Consulate, India (Monaco visas processed via France)',
    'Confirm your connecting travel and transit time\nCheck whether you already hold a valid Schengen visa\nApply for a French Schengen visa via VFS Global France if needed\nCarry your onward travel documents and passport',
    '/assets/images/visa-heroes/monaco.webp',
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/monaco-visa', '2026-09-19'
);
SET @mco6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mco6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mco6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @mco6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mco6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mco6s1, 'Valid Schengen Visa (If Not Applying Fresh)', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(134, 6, 90.00, 'EUR', 'Schengen Visa Fee (If Needed)', 'Not required if you already hold a valid Schengen visa from another member state.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/monaco-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a transit visa for Monaco?', 'A valid Schengen visa covers transit. Monaco has no international airport of its own — most routes go through Nice, France first.', 134, 6, 13460, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    134, 7, 'MCO-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Monaco.',
    'Medical travellers use the same French Schengen visa route as tourists.',
    'Up to 90 days within any 180-day period',
    'Apply for a French Schengen visa via VFS Global France or the French Embassy/Consulate in India',
    1,
    'Confirm treatment and appointment directly with the Monaco medical facility before applying.',
    'French Embassy/Consulate, India (Monaco visas processed via France)',
    'Confirm treatment and appointment directly with the Monaco medical facility\nBook a biometric appointment at VFS Global France or the French Embassy\nPurchase Schengen travel insurance\nGather proof of sufficient funds\nAttend your visa interview and submit biometrics',
    '/assets/images/visa-heroes/monaco.webp',
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/monaco-visa', '2026-09-19'
);
SET @mco7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mco7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mco7, 'Core Documents', 'Required from every applicant.', 1);
SET @mco7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mco7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mco7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mco7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mco7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mco7s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@mco7s2, 'Schengen Travel Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(134, 7, 90.00, 'EUR', 'Adult Schengen Visa Fee', 'Same fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://maxglob.com/monaco-visa-for-indian/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for Monaco?', 'No separate medical visa — the same French Schengen visa route applies as for tourist travel.', 134, 7, 13470, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    134, 8, 'MCO-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in Monaco.',
    'Conference attendees use the same French Schengen visa route as business travellers.',
    'Up to 90 days within any 180-day period',
    'Apply for a French Schengen visa via VFS Global France or the French Embassy/Consulate in India',
    1,
    'Carry a conference invitation letter along with the standard documents.',
    'French Embassy/Consulate, India (Monaco visas processed via France)',
    'Confirm your passport is valid for 6+ months beyond your stay\nCarry conference invitation/registration confirmation\nBook a biometric appointment at VFS Global France or the French Embassy\nPurchase Schengen travel insurance\nAttend your visa interview and submit biometrics',
    '/assets/images/visa-heroes/monaco.webp',
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/monaco-visa', '2026-09-19'
);
SET @mco8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mco8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mco8, 'Core Documents', 'Required from every applicant.', 1);
SET @mco8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mco8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mco8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mco8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mco8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mco8s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@mco8s2, 'Schengen Travel Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(134, 8, 90.00, 'EUR', 'Adult Schengen Visa Fee', 'Same fee range as the business visa applies.', '2026-01-01', NOW(), 'https://maxglob.com/monaco-visa-for-indian/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for Monaco?', 'No separate conference visa — the same French Schengen visa route applies as for business travel.', 134, 8, 13480, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    134, 9, 'MCO-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in Monaco (e.g. the Monaco Grand Prix).',
    'Sports travellers use the same French Schengen visa route as tourists.',
    'Up to 90 days within any 180-day period',
    'Apply for a French Schengen visa via VFS Global France or the French Embassy/Consulate in India',
    1,
    'Book well ahead of major events (e.g. the Grand Prix) — accommodation and appointment slots fill quickly.',
    'French Embassy/Consulate, India (Monaco visas processed via France)',
    'Confirm your passport is valid for 6+ months beyond your stay\nCarry event invitation/participation confirmation\nBook a biometric appointment at VFS Global France or the French Embassy\nPurchase Schengen travel insurance\nAttend your visa interview and submit biometrics',
    '/assets/images/visa-heroes/monaco.webp',
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/monaco-visa', '2026-09-19'
);
SET @mco9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mco9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mco9, 'Core Documents', 'Required from every applicant.', 1);
SET @mco9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mco9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mco9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mco9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @mco9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mco9s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@mco9s2, 'Schengen Travel Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(134, 9, 90.00, 'EUR', 'Adult Schengen Visa Fee', 'Same fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://maxglob.com/monaco-visa-for-indian/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a sports visa for Monaco (e.g. for the Grand Prix)?', 'No separate sports visa — the same French Schengen visa route applies as for tourist travel. Book early since major events fill up quickly.', 134, 9, 13490, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    134, 10, 'MCO-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent who holds a Monaco work/student visa.',
    'Dependants apply for their own long-stay visa via the French Embassy/Consulate, referencing the primary permit holder\'s status.',
    'Tied to the primary permit holder\'s validity',
    'Apply for a French long-stay visa via the French Embassy/Consulate, referencing the primary permit holder\'s status',
    1,
    'Not independently confirmed this session: exact dependant-visa fee beyond the general EUR 99 long-stay fee.',
    'French Embassy/Consulate, India (Monaco visas processed via France)',
    'Confirm the primary permit holder\'s work/student visa status\nGather proof of relationship (marriage/birth certificate)\nApply via the French Embassy/Consulate, India\nPurchase Schengen-compliant health insurance\nRegister with local authorities after arrival',
    '/assets/images/visa-heroes/monaco.webp',
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/monaco-visa', '2026-09-19'
);
SET @mco10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mco10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mco10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @mco10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mco10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mco10s1, 'Proof of Relationship (Marriage/Birth Certificate)', NULL, 'original', 1, 0, 1, 2),
(@mco10s1, 'Primary Permit Holder\'s Visa/Permit Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mco10, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @mco10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mco10s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@mco10s2, 'Schengen-Compliant Health Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(134, 10, 99.00, 'EUR', 'Long-Stay Visa Fee', 'Flat EUR 99 fee for non-EEA nationals applies to the general long-stay visa route.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/monaco-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can dependants accompany a work/student visa holder to Monaco?', 'Yes, via their own long-stay visa application through the French Embassy/Consulate, referencing the primary permit holder\'s status.', 134, 10, 13400, 1);
