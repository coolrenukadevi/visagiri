-- Saint Kitts and Nevis Visa Checklist Engine content for all 10 visa
-- types.
--
-- Saint Kitts and Nevis's real, distinctive facts verified this session:
--   - SOURCING CONFLICT (flagged, not silently resolved): sources
--     disagree on whether Indian citizens need advance clearance.
--     Several sources state pure visa-free entry for up to 3 months at
--     the port of entry. Other sources state that, following the
--     implementation of an Electronic Travel Authorisation (eTA)
--     system on 26 May 2025, a single-entry eTA (valid 90 days, USD
--     17) is now the mandatory entry clearance for Indian passport
--     holders — similar to how the UK and EU introduced ETA/ETIAS
--     schemes for visa-exempt nationals. Given the eTA is a newer
--     policy (2025) that older visa-free-only sources may not yet
--     reflect, and given the low cost/simplicity of applying, this
--     checklist recommends Indian travellers register for the eTA
--     before travel rather than assume pure visa-free entry.
--   - A separate, more expensive eVisa (evisa.gov.kn, USD 100, ~2 weeks
--     processing) also exists — this appears to be the standard visa
--     portal for nationals who are NOT visa-exempt, distinct from the
--     eTA used by visa-exempt nationals like Indians. This distinction
--     was not fully confirmed by a first-party source this session.
--   - Passport must be valid for at least 120 days beyond the date of
--     entry per one source (others say 6 months) — the stricter 6-month
--     guidance is used here as the safer figure.
--   - Work permits require a Mantoux skin test, syphilis test, and
--     police record from the current country of residence — a
--     distinctive and specific requirement noted for Work Visa.
--
-- country_id 176 = Saint Kitts and Nevis. visa_type_id: 1=Tourist,
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
    176, 1, 'KNA-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Saint Kitts and Nevis for Indian citizens.',
    'SOURCING CONFLICT: some sources describe pure visa-free entry up to 3 months; others state that since 26 May 2025 an eTA (single-entry, 90 days, USD 17) is the mandatory entry clearance. Given the eTA is the more recent policy, travellers are advised to register for it before travel rather than assume visa-free entry.',
    'Up to 3 months at the port of entry; eTA (if required) valid 90 days, single entry',
    'Register for the eTA online before travel (recommended), or confirm current visa-free status directly with Kittitian/Nevisian immigration authorities',
    0,
    'Given the sourcing conflict, applying for the low-cost eTA (USD 17) before travel is the safer approach.',
    'High Commission of India, Port of Spain (Trinidad and Tobago) — accredited for Saint Kitts and Nevis; local immigration authorities issue the eTA/entry clearance',
    'Confirm current eTA/visa-free requirement given conflicting sources\nRegister for the eTA online if applicable\nGather passport, return ticket, and proof of funds\nPresent documents at the port of entry',
    '/assets/images/visa-heroes/saint-kitts-and-nevis.webp',
    'skyscanner.co.in, hinterlandtravel.com, visago.dev (conflicting on eTA requirement)', 'https://www.skyscanner.co.in/destinations/visa/29475411/saint-kitts-and-nevis', '2026-09-19'
);
SET @kna1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kna1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kna1, 'Core Documents', 'Required from every applicant.', 1);
SET @kna1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kna1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@kna1s1, 'eTA Approval (If Applicable)', 'Register online given the sourcing conflict on whether eTA is mandatory.', 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kna1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @kna1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kna1s2, 'Return Flight Ticket', NULL, 'copy', 1, 0, 0, 1),
(@kna1s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2),
(@kna1s2, 'Hotel/Accommodation Booking Confirmation', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(176, 1, 17.00, 'USD', 'eTA Fee (If Applicable)', 'Single-entry eTA valid 90 days costs USD 17, per sources describing the May 2025 eTA rollout. Some sources still describe pure visa-free entry — verify before paying.', '2025-05-26', NOW(), 'https://www.skyscanner.co.in/destinations/visa/29475411/saint-kitts-and-nevis', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa or eTA for Saint Kitts and Nevis?', 'Sources disagree: some describe pure visa-free entry for up to 3 months, while others state an eTA (USD 17, 90-day validity) became mandatory from 26 May 2025. Given the eTA is the more recent policy, register for it before travel to be safe.', 176, 1, 17600, 1),
('Is the eTA the same as the USD 100 eVisa?', 'No — the USD 100 eVisa at evisa.gov.kn appears to be a separate, standard visa process for non-visa-exempt nationals, distinct from the eTA used by visa-exempt nationals like Indians. This distinction was not fully confirmed by a first-party source this session.', 176, 1, 17601, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    176, 2, 'KNA-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Saint Kitts and Nevis.',
    'Business travellers likely use the same eTA/visa-free entry as tourists (see Tourist Visa sourcing-conflict note); a business invitation letter is recommended as supporting evidence though not confirmed mandatory this session.',
    'Up to 3 months at the port of entry; eTA (if required) valid 90 days, single entry',
    'Register for the eTA online before travel (recommended)',
    0,
    'Given the sourcing conflict, applying for the eTA before travel is the safer approach.',
    'High Commission of India, Port of Spain (Trinidad and Tobago) — accredited for Saint Kitts and Nevis',
    'Confirm current eTA/visa-free requirement\nRegister for the eTA online if applicable\nGather business invitation letter and company documents\nPresent documents at the port of entry',
    '/assets/images/visa-heroes/saint-kitts-and-nevis.webp',
    'General inference from Saint Kitts and Nevis visa-category structure; not independently confirmed with a dedicated business-visa source this session', NULL, '2026-09-19'
);
SET @kna2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kna2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kna2, 'Core Documents', 'Required from every applicant.', 1);
SET @kna2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kna2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@kna2s1, 'eTA Approval (If Applicable)', NULL, 'copy', 0, 1, 1, 2),
(@kna2s1, 'Business Invitation Letter', NULL, 'copy', 0, 1, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kna2, 'Supporting Documents', 'Company evidence.', 2);
SET @kna2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kna2s2, 'Proof of Employment/Business Ownership in India', NULL, 'copy', 1, 0, 0, 1),
(@kna2s2, 'Return Flight Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Business Visa for Saint Kitts and Nevis?', 'A dedicated first-party category was not independently confirmed this session; the same eTA/visa-free entry framework used for tourism appears to apply.', 176, 2, 17700, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    176, 3, 'KNA-STU-IN-01', '2026.09', 'published',
    'Enrollment in a recognized educational institution in Saint Kitts and Nevis (notably home to several offshore medical schools attracting international students).',
    'Saint Kitts is known internationally for its offshore medical schools (e.g., Ross University School of Medicine historically, and others). A Student Visa/permit is required beyond the eTA/visa-free tourist entry; specific document checklists were not independently itemized by a first-party source this session.',
    'Duration tied to course length, subject to immigration assessment; not independently confirmed this session',
    'Apply via the nearest Saint Kitts and Nevis mission or the institution''s international student office',
    1,
    'Confirm requirements directly with the institution''s international office and Kittitian/Nevisian immigration authorities.',
    'Nearest Saint Kitts and Nevis mission; High Commission of India, Port of Spain (Trinidad and Tobago)',
    'Secure admission to a recognized institution (e.g., a medical school)\nGather academic and financial documents\nApply for the Student Visa/permit\nAwait visa decision',
    '/assets/images/visa-heroes/saint-kitts-and-nevis.webp',
    'General knowledge of Saint Kitts'' offshore-medical-school sector; not independently confirmed with a dedicated student-visa document checklist this session', NULL, '2026-09-19'
);
SET @kna3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kna3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kna3, 'Core Documents', 'Required from every applicant.', 1);
SET @kna3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kna3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@kna3s1, 'Admission/Enrollment Letter from a Recognized Institution', NULL, 'copy', 1, 0, 1, 2),
(@kna3s1, 'Proof of Tuition Fee Payment or Funding Arrangement', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kna3, 'Supporting Documents', 'Academic evidence.', 2);
SET @kna3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kna3s2, 'Academic Transcripts and Certificates', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Saint Kitts a known destination for international students?', 'Yes — it hosts several offshore medical schools attracting international students, though the specific student-visa document checklist was not independently confirmed this session.', 176, 3, 17800, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    176, 4, 'KNA-WORK-IN-01', '2026.09', 'published',
    'Paid employment in Saint Kitts and Nevis for Indian nationals.',
    'A work permit is required beyond the eTA/visa-free tourist entry, involving medical tests (Mantoux skin test, syphilis test), a police record from the current country of residence, and a notarized passport identification page. Employers must show the vacancy was advertised for at least 3 weeks before hiring a non-national.',
    'Tied to the employment contract/work permit duration',
    'Employer-sponsored work permit application through Kittitian/Nevisian labour authorities',
    1,
    'Employers must demonstrate a 3-week local job advertisement period before hiring a non-national — a distinctive requirement.',
    'Nearest Saint Kitts and Nevis mission; local Department of Labour',
    'Secure an employment offer from a local employer\nEmployer advertises the vacancy locally for 3+ weeks\nComplete required medical tests (Mantoux, syphilis)\nObtain a police record from current country of residence\nApply for the work permit with a notarized passport ID page',
    '/assets/images/visa-heroes/saint-kitts-and-nevis.webp',
    'globalization-partners.com, visitworld.today secondary sourcing on Saint Kitts and Nevis work-permit process', 'https://www.globalization-partners.com/globalpedia/saint-kitts-and-nevis/visa-permits/', '2026-09-19'
);
SET @kna4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kna4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kna4, 'Core Documents', 'Required from every applicant.', 1);
SET @kna4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kna4s1, 'Valid Passport (6+ Months Validity), Notarized ID Page', NULL, 'original', 1, 0, 1, 1),
(@kna4s1, 'Employment Offer Letter from Local Employer', NULL, 'copy', 1, 0, 1, 2),
(@kna4s1, 'Mantoux Skin Test Result', NULL, 'original', 1, 0, 1, 3),
(@kna4s1, 'Syphilis Test Result', NULL, 'original', 1, 0, 1, 4),
(@kna4s1, 'Police Record from Current Country of Residence', NULL, 'original', 1, 0, 1, 5);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kna4, 'Supporting Documents', 'Employer-related evidence.', 2);
SET @kna4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kna4s2, 'Proof of 3-Week Local Job Advertisement (Employer-Provided)', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What medical tests are required for a Saint Kitts and Nevis work permit?', 'A Mantoux skin test and a syphilis test are both required as part of the work-permit application, per sources reviewed.', 176, 4, 17900, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    176, 5, 'KNA-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Saint Kitts and Nevis.',
    'Indian nationals visiting family use the same eTA/visa-free entry framework as tourists (see Tourist Visa sourcing-conflict note).',
    'Up to 3 months at the port of entry; eTA (if required) valid 90 days, single entry',
    'Register for the eTA online before travel (recommended)',
    0,
    'Given the sourcing conflict, applying for the eTA before travel is the safer approach.',
    'High Commission of India, Port of Spain (Trinidad and Tobago) — accredited for Saint Kitts and Nevis',
    'Confirm current eTA/visa-free requirement\nGather invitation letter and proof of relationship\nRegister for the eTA online if applicable\nPresent documents at the port of entry',
    '/assets/images/visa-heroes/saint-kitts-and-nevis.webp',
    'General inference from Saint Kitts and Nevis visa-category structure', NULL, '2026-09-19'
);
SET @kna5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kna5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kna5, 'Core Documents', 'Required from every applicant.', 1);
SET @kna5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kna5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@kna5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 0, 1, 1, 2),
(@kna5s1, 'Proof of Relationship (Birth/Marriage Certificates)', NULL, 'copy', 0, 1, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kna5, 'Supporting Documents', 'Additional evidence.', 2);
SET @kna5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kna5s2, 'Return Flight Ticket', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Family Visit Visa for Saint Kitts and Nevis?', 'A dedicated first-party category was not independently confirmed this session; the same eTA/visa-free entry used for tourism applies.', 176, 5, 18000, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    176, 6, 'KNA-TRAN-IN-01', '2026.09', 'published',
    'Brief transit through Saint Kitts and Nevis en route to a third country.',
    'Transit requirements for Indian passport holders were not independently confirmed from a first-party source this session. Given the eTA sourcing conflict on general entry, travellers should confirm with their airline and register for the eTA if leaving the airside area.',
    'Short transit period; not independently confirmed this session',
    'Confirm with airline; register for the eTA if leaving the transit area',
    0,
    'Not independently confirmed this session — confirm directly before travel.',
    'Nearest Saint Kitts and Nevis mission',
    'Confirm transit requirements with your airline\nRegister for the eTA if leaving the transit area\nCarry onward flight ticket and destination visa if applicable',
    '/assets/images/visa-heroes/saint-kitts-and-nevis.webp',
    'Inference from general entry-requirement sourcing conflict; not independently confirmed this session', NULL, '2026-09-19'
);
SET @kna6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kna6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kna6, 'Core Documents', 'Required from every applicant.', 1);
SET @kna6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kna6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@kna6s1, 'Onward Flight Ticket to Final Destination', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need the eTA to transit through Saint Kitts and Nevis?', 'This was not independently confirmed this session — confirm with your airline and register for the eTA if leaving the transit area.', 176, 6, 18100, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    176, 7, 'KNA-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Saint Kitts and Nevis for Indian nationals.',
    'Saint Kitts and Nevis is not a typical medical-tourism destination for Indian nationals. A dedicated first-party Medical Visa checklist was not located this session; the standard eTA/visa-free entry with hospital documentation would likely apply.',
    'Tied to treatment duration; not independently confirmed this session',
    'Register for the eTA (if applicable) with hospital documentation',
    0,
    'Confirm category-specific requirements directly with local immigration authorities.',
    'Nearest Saint Kitts and Nevis mission',
    'Obtain hospital admission/treatment confirmation from a local hospital\nRegister for the eTA if applicable\nGather proof of funds for treatment and stay',
    '/assets/images/visa-heroes/saint-kitts-and-nevis.webp',
    'Inference; not independently confirmed with a dedicated medical-visa source this session', NULL, '2026-09-19'
);
SET @kna7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kna7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kna7, 'Core Documents', 'Required from every applicant.', 1);
SET @kna7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kna7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@kna7s1, 'Hospital Admission Letter/Treatment Confirmation', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Saint Kitts and Nevis a common destination for medical treatment from India?', 'No — this was not independently sourced this session.', 176, 7, 18200, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    176, 8, 'KNA-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Saint Kitts and Nevis.',
    'Conference attendees likely use the same eTA/visa-free entry as tourists and business travellers (see Tourist Visa sourcing-conflict note).',
    'Up to 3 months at the port of entry; eTA (if required) valid 90 days, single entry',
    'Register for the eTA online before travel (recommended)',
    0,
    'A formal invitation letter from the conference organizer is recommended supporting evidence.',
    'Nearest Saint Kitts and Nevis mission',
    'Confirm current eTA/visa-free requirement\nObtain formal invitation letter from the conference organizer\nRegister for the eTA online if applicable',
    '/assets/images/visa-heroes/saint-kitts-and-nevis.webp',
    'General inference from Saint Kitts and Nevis visa-category structure', NULL, '2026-09-19'
);
SET @kna8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kna8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kna8, 'Core Documents', 'Required from every applicant.', 1);
SET @kna8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kna8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@kna8s1, 'Formal Invitation Letter from Conference/Event Organizer', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Conference Visa for Saint Kitts and Nevis?', 'A dedicated first-party category was not independently confirmed this session; the same eTA/visa-free entry applies.', 176, 8, 18300, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    176, 9, 'KNA-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Saint Kitts and Nevis.',
    'A dedicated Sports Visa category was not located from a first-party source this session. Indian athletes/officials would likely use the same eTA/visa-free entry as tourists.',
    'Up to 3 months at the port of entry; eTA (if required) valid 90 days, single entry',
    'Register for the eTA online before travel (recommended)',
    0,
    'Confirm the appropriate category with local immigration authorities before applying.',
    'Nearest Saint Kitts and Nevis mission',
    'Confirm current eTA/visa-free requirement\nObtain letter from sports federation/event organizer confirming participation\nRegister for the eTA online if applicable',
    '/assets/images/visa-heroes/saint-kitts-and-nevis.webp',
    'Inference; not independently confirmed with a dedicated sports-visa source this session', NULL, '2026-09-19'
);
SET @kna9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kna9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kna9, 'Core Documents', 'Required from every applicant.', 1);
SET @kna9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kna9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@kna9s1, 'Letter from Sports Federation/Event Organizer Confirming Participation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Sports Visa for Saint Kitts and Nevis?', 'Not independently confirmed this session — athletes/officials should confirm the appropriate requirement with local immigration authorities.', 176, 9, 18400, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    176, 10, 'KNA-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse/family member who holds a Saint Kitts and Nevis work permit or long-term residency.',
    'Dependents of Indian nationals working in Saint Kitts and Nevis typically apply through a process linked to the primary work-permit holder''s employer sponsorship. A dedicated first-party checklist was not located this session.',
    'Typically matches the primary permit holder''s duration; not independently confirmed this session',
    'Employer/sponsor-linked application through local immigration authorities',
    1,
    'Coordinate with the sponsoring employer and local immigration authorities for the correct process.',
    'Nearest Saint Kitts and Nevis mission',
    'Confirm sponsorship arrangement with the primary permit holder''s employer\nGather proof of relationship and primary permit holder''s documents\nApply through local immigration authorities\nAwait decision',
    '/assets/images/visa-heroes/saint-kitts-and-nevis.webp',
    'Inference; not independently confirmed with a dedicated dependent-visa source this session', NULL, '2026-09-19'
);
SET @kna10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kna10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kna10, 'Core Documents', 'Required from every applicant.', 1);
SET @kna10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kna10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@kna10s1, 'Proof of Relationship to Primary Permit Holder (Marriage/Birth Certificate)', NULL, 'copy', 1, 0, 1, 2),
(@kna10s1, 'Copy of Primary Permit Holder''s Work Permit', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can dependents of a Saint Kitts and Nevis work-permit holder apply directly?', 'This was not independently confirmed this session — dependents should coordinate with the sponsoring employer and local immigration authorities for the correct process.', 176, 10, 18500, 1);
