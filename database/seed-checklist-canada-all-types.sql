-- Canada Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search, same standard as Mexico/Singapore/
-- France/Japan/USA/Australia (see AUDIT.md). Canada's real, distinctive
-- facts:
--   - Tourist, Business, Family Visit and Medical all sit inside the
--     same Temporary Resident Visa (TRV) product — distinguished by
--     purpose-specific documents, not separate visa categories.
--   - Mandatory biometrics for applicants aged 14-79 (CAD 85), valid 10
--     years from enrolment — no re-collection needed on repeat
--     applications within that window, a genuine Canada-specific detail.
--   - Student uses a separate "Study Permit" product (not a visa in the
--     visitor sense), gated on a Letter of Acceptance from a
--     Designated Learning Institution and a real, current GIC benchmark
--     (CAD 23,448/year, effective 1 September 2026).
--   - Work has two genuinely different pathways: LMIA-based (employer
--     must obtain a Labour Market Impact Assessment first) vs
--     LMIA-exempt International Mobility Program routes — not the same
--     process with different paperwork, but different legal bases.
--   - The Super Visa (for parents/grandparents specifically) is a real,
--     distinct product from the standard Family Visit TRV — up to 10
--     years multi-entry, requiring CAD 100,000 medical insurance and a
--     host income test.
--   - India is NOT on Canada's Transit Without a Visa (TWOV) eligible
--     list, so most Indian travellers need a standard TRV even for
--     short layovers — except a real carve-out for holders of a valid
--     US non-immigrant visa transiting under 48 hours via a designated
--     airport.
--   - No standalone "Dependent Visa" — accompanying spouses of a
--     work/study permit holder generally apply for a Spousal Open Work
--     Permit (a currently-extended public policy through end of 2026).
--
-- country_id 159 = Canada. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.
--
-- hero_image_url points at the real CN Tower/Toronto skyline and
-- Canadian flag photo supplied by the client for this hero.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Temporary Resident Visa (TRV)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    159, 1, 'CAN-TOUR-IN-01', '2026.09', 'published',
    'Leisure travel, sightseeing, and short personal visits to Canada.',
    'Indian citizens need a Temporary Resident Visa (TRV) before travel — there is no visa-on-arrival. Applications are made via the IRCC Portal, with mandatory biometrics for applicants aged 14-79 (valid 10 years, no re-collection on repeat applications within that window).',
    'Typically up to 6 months per entry, as decided by the border officer',
    'Online application via the IRCC Portal, biometrics at a VFS Global Visa Application Centre',
    1,
    'India processing times have generally been easing through 2026 — check IRCC''s current published times before planning your trip',
    'VFS Global Canada Visa Application Centre, India (biometrics only; decision made by IRCC)',
    'Initial consultation to confirm Tourist TRV is the right category\nGather documents against this checklist\nSubmit your application via the IRCC Portal\nAttend a VFS Global centre for biometrics (if not already valid)\nSupport responding to any additional-document request\nDecision — TRV label affixed to your passport once approved',
    '/assets/images/visa-heroes/canada.jpg',
    'Government of Canada (IRCC) Temporary Resident Visa guidance, cross-checked via independent visa-agency sourcing', 'https://www.canada.ca/en/immigration-refugees-citizenship/services/visit-canada/apply.html', '2026-09-11'
);
SET @ct1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ct1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct1, 'Core Documents', 'Every applicant needs these.', 1);
SET @ct1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct1s1, 'Valid Passport', 'Valid for the duration of your intended stay.', 'original', 1, 0, 1, 1),
(@ct1s1, 'Passport Photograph', 'Per IRCC photo specifications.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct1, 'Financial & Ties Documents', 'Evidence of funds and ties to India.', 2);
SET @ct1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct1s2, 'Bank Statements', 'Last 6 months.', 'copy', 1, 0, 1, 1),
(@ct1s2, 'Proof of Ties to India', 'Employment letter, property documents, or family ties evidence.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct1, 'Application & Biometrics', 'Your formal application and biometrics.', 3);
SET @ct1s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct1s3, 'IRCC Portal Application Form', NULL, 'original', 1, 0, 0, 1),
(@ct1s3, 'Biometric Instruction Letter & Appointment', 'Issued after payment; biometrics valid 10 years once captured.', 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct1, 'Travel Documents', 'Evidence of your trip plans.', 4);
SET @ct1s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct1s4, 'Travel Itinerary', 'Indicative flight and accommodation plans.', 'original', 0, 1, 1, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(159, 1, 100.00, 'CAD', 'TRV Application Fee', 'CAD 100 per person (family cap CAD 500), plus a separate CAD 85 biometrics fee for applicants aged 14-79 (family cap CAD 170), valid 10 years once captured.', '2026-09-01', NOW(), 'https://www.canada.ca/en/immigration-refugees-citizenship/services/visit-canada/apply.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need to give biometrics every time I apply?', 'No — biometrics are valid for 10 years from enrolment, so repeat TRV, study, or work permit applications within that window generally do not require re-collection.', 159, 1, 860, 1),
('Is there a visa-on-arrival for Canada?', 'No — Indian passport holders must obtain a Temporary Resident Visa before travelling; there is no visa-on-arrival option.', 159, 1, 861, 1),
('How is the application submitted?', 'Entirely online via the IRCC Portal, with a separate in-person visit to a VFS Global centre only for biometrics.', 159, 1, 862, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — TRV, Business Visitor
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    159, 2, 'CAN-BUS-IN-02', '2026.09', 'published',
    'Short business visits — meetings, negotiations, and training — to Canada.',
    'Business visitors use the same TRV product as Tourist — there is no separate "business visa." You may stay up to 6 months for meetings, training, or events without a work permit, provided your main employer and source of income/profit remain outside Canada.',
    'Typically up to 6 months per entry, as decided by the border officer',
    'Online application via the IRCC Portal, biometrics at a VFS Global centre',
    1,
    'India processing times have generally been easing through 2026',
    'VFS Global Canada Visa Application Centre, India',
    'Initial consultation to confirm the trip is a genuine business visit\nObtain a clear invitation letter from your Canadian host company\nGather documents against this checklist\nSubmit your application via the IRCC Portal\nAttend biometrics if required\nDecision once processed',
    '/assets/images/visa-heroes/canada.jpg',
    'Government of Canada (IRCC) Business Visitors guidance', 'https://www.canada.ca/en/immigration-refugees-citizenship/services/visit-canada/business/visitors-events-conferences.html', '2026-09-11'
);
SET @ct2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ct2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct2, 'Core Documents', 'Every applicant needs these.', 1);
SET @ct2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ct2s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct2, 'Business Invitation & Purpose', 'Evidence of who you are meeting and why.', 2);
SET @ct2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct2s2, 'Letter of Invitation from Canadian Host', 'Stating purpose, duration, and confirming your main income remains outside Canada.', 'original', 1, 0, 1, 1),
(@ct2s2, 'Covering Letter from Indian Employer', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct2, 'Financial & Ties Documents', 'Evidence of funds and ties to India.', 3);
SET @ct2s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct2s3, 'Bank Statements', 'Last 6 months.', 'copy', 1, 0, 0, 1),
(@ct2s3, 'Proof of Ties to India', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(159, 2, 100.00, 'CAD', 'TRV Application Fee', 'Same fee/biometrics structure as Tourist — Business is the same TRV product.', '2026-09-01', NOW(), 'https://www.canada.ca/en/immigration-refugees-citizenship/services/visit-canada/business/visitors-events-conferences.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I be paid by the Canadian company I am visiting?', 'No — business visitors may not be paid from a Canadian source. Your main employer and income must remain outside Canada.', 159, 2, 863, 1),
('Is there a separate Business Visa for Canada?', 'No — Business visitors use the same TRV as Tourist visitors; the difference is the purpose-specific documents (invitation letter, etc.).', 159, 2, 864, 1),
('How long can I stay as a business visitor?', 'Up to 6 months for meetings, training, or events, without needing a work permit.', 159, 2, 865, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Study Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    159, 3, 'CAN-STU-IN-03', '2026.09', 'published',
    'Full-time study at a Designated Learning Institution (DLI) in Canada.',
    'Requires a Letter of Acceptance from a DLI and proof of funds meeting the current Guaranteed Investment Certificate (GIC) benchmark — CAD 23,448 for applications filed on/after 1 September 2026, covering one year''s living costs only (tuition and return travel shown separately). Some provinces require a Provincial Attestation Letter (PAL) tied to national intake caps.',
    'Duration of your study program',
    'Online application via the IRCC Portal, biometrics at a VFS Global centre',
    1,
    'India-specific processing times were reported around 5-7 weeks as of September 2026',
    'VFS Global Canada Visa Application Centre, India',
    'Secure admission and receive your Letter of Acceptance from a DLI\nObtain your Provincial Attestation Letter (PAL) if required\nArrange your GIC or other qualifying proof of funds\nGather documents against this checklist\nSubmit your application via the IRCC Portal\nAttend biometrics\nDecision once processed',
    '/assets/images/visa-heroes/canada.jpg',
    'Government of Canada (IRCC) Study Permit guidance', 'https://www.canada.ca/en/immigration-refugees-citizenship/services/study-canada/study-permit.html', '2026-09-11'
);
SET @ct3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ct3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct3, 'Core Documents', 'Every applicant needs these.', 1);
SET @ct3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ct3s1, 'Letter of Acceptance', 'From your Designated Learning Institution.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct3, 'Financial Documents', 'Evidence you can fund your studies.', 2);
SET @ct3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct3s2, 'GIC (Guaranteed Investment Certificate)', 'Currently CAD 23,448, covering one year''s living costs.', 'original', 1, 0, 1, 1),
(@ct3s2, 'Tuition Payment Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct3, 'Provincial & Academic Documents', 'Evidence specific to your province/program.', 3);
SET @ct3s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct3s3, 'Provincial Attestation Letter (PAL)', 'Required by some provinces under the national study permit intake cap.', 'original', 0, 1, 0, 1),
(@ct3s3, 'Academic Transcripts & Test Scores', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(159, 3, 150.00, 'CAD', 'Study Permit Application Fee', 'Plus a separate CAD 85 biometrics fee. GIC (CAD 23,448) and tuition are separate from this application fee.', '2026-09-01', NOW(), 'https://www.canada.ca/en/immigration-refugees-citizenship/services/study-canada/study-permit.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is the current GIC amount required?', 'CAD 23,448 for applications filed on or after 1 September 2026, covering one year''s living costs — tuition and return travel funds must be shown separately.', 159, 3, 866, 1),
('What is a Provincial Attestation Letter (PAL)?', 'A letter some provinces require, tied to Canada''s national study permit intake cap — check with your institution whether your program requires one.', 159, 3, 867, 1),
('Is the Study Permit the same as a visa?', 'Not exactly — the Study Permit is a separate document from a TRV, though a TRV or eTA is typically issued alongside it for entry.', 159, 3, 868, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Work Permit (LMIA-based or LMIA-exempt)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    159, 4, 'CAN-WORK-IN-04', '2026.09', 'published',
    'Employer-sponsored employment in Canada.',
    'Two genuinely different pathways exist: LMIA-based (Temporary Foreign Worker Program), where the employer first obtains a Labour Market Impact Assessment from ESDC, or LMIA-exempt (International Mobility Program — e.g. intra-company transfer, CUSMA, spousal open permits), where the employer instead submits an Offer of Employment via the IRCC Employer Portal with no labour market test.',
    'Tied to the job offer/LMIA validity period',
    'Employer-driven (LMIA or Employer Portal offer); employee then applies via the IRCC Portal',
    1,
    'LMIA processing runs roughly 8-12 weeks; subsequent worker application for India was reported around 12-20 weeks in 2026',
    'VFS Global Canada Visa Application Centre, India',
    'Employer obtains an LMIA (if required) or submits an Offer of Employment via the Employer Portal\nGather documents against this checklist\nSubmit your Work Permit application via the IRCC Portal\nAttend biometrics\nSupport responding to any additional-document request\nDecision once processed',
    '/assets/images/visa-heroes/canada.jpg',
    'Government of Canada (IRCC) Work Permit and Labour Market Impact Assessment guidance', 'https://www.canada.ca/en/immigration-refugees-citizenship/services/work-canada.html', '2026-09-11'
);
SET @ct4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ct4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct4, 'Core Documents', 'Every applicant needs these.', 1);
SET @ct4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ct4s1, 'Offer of Employment Number / LMIA Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct4, 'Employer Sponsorship Documents', 'Evidence of your job offer and its basis.', 2);
SET @ct4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct4s2, 'Employment Contract & Job Description', NULL, 'copy', 1, 0, 1, 1),
(@ct4s2, 'Positive LMIA', 'Required only for the LMIA-based route.', 'copy', 0, 1, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct4, 'Qualification Documents', 'Evidence you meet the role''s requirements.', 3);
SET @ct4s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct4s3, 'Educational Credentials & Resume', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(159, 4, 155.00, 'CAD', 'Work Permit Application Fee', 'Plus CAD 85 biometrics. LMIA route carries a separate CAD 1,000 employer fee; LMIA-exempt route carries a CAD 230 employer compliance fee — both paid by the employer, not the applicant.', '2026-09-01', NOW(), 'https://www.canada.ca/en/immigration-refugees-citizenship/services/work-canada.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is the difference between LMIA-based and LMIA-exempt work permits?', 'LMIA-based requires the employer to first prove no Canadian worker is available (an ESDC Labour Market Impact Assessment); LMIA-exempt routes (e.g. intra-company transfer) skip that test and use the Employer Portal instead — different legal basis, not just different paperwork.', 159, 4, 869, 1),
('Who pays the LMIA or compliance fee?', 'The employer — CAD 1,000 per position for LMIA, or CAD 230 for the LMIA-exempt compliance fee — not the worker.', 159, 4, 870, 1),
('How long does the LMIA process take?', 'Roughly 8-12 weeks for the LMIA itself, before the worker''s own Work Permit application is submitted and processed separately.', 159, 4, 871, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — TRV / Super Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    159, 5, 'CAN-FAM-IN-05', '2026.09', 'published',
    'Visiting family in Canada, including a dedicated long-stay option for parents and grandparents.',
    'Most family visits use the standard TRV. Parents and grandparents specifically may instead apply for the Super Visa — a multi-entry TRV valid up to 10 years, allowing stays of up to 5 years per entry (extendable to 7), but requiring CAD 100,000 medical insurance and the host meeting an income test.',
    'Standard TRV: up to 6 months per entry. Super Visa: up to 5 years per entry (extendable to 7), visa valid up to 10 years',
    'Online application via the IRCC Portal, biometrics at a VFS Global centre',
    1,
    'Super Visa applications require additional review of the host''s income and the medical insurance policy',
    'VFS Global Canada Visa Application Centre, India',
    'Determine whether a standard TRV or the Super Visa (parents/grandparents) applies\nObtain an invitation letter and relationship proof from your Canadian host\nFor Super Visa: arrange CAD 100,000 medical insurance and host income evidence\nGather documents against this checklist\nSubmit your application via the IRCC Portal\nAttend biometrics\nDecision once processed',
    '/assets/images/visa-heroes/canada.jpg',
    'Government of Canada (IRCC) Super Visa and TRV guidance', 'https://www.canada.ca/en/immigration-refugees-citizenship/services/visit-canada/super-visa-parents-grandparents.html', '2026-09-11'
);
SET @ct5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ct5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct5, 'Core Documents', 'Every applicant needs these.', 1);
SET @ct5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ct5s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct5, 'Host Invitation & Relationship Proof', 'Evidence of who you are visiting.', 2);
SET @ct5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct5s2, 'Invitation Letter from Canadian Host', NULL, 'original', 1, 0, 1, 1),
(@ct5s2, 'Relationship Proof', 'Birth/marriage certificates.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct5, 'Super Visa Documents (Parents/Grandparents Only)', 'Required only for the Super Visa pathway.', 3);
SET @ct5s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct5s3, 'Medical Insurance (CAD 100,000 minimum)', 'Valid for at least one year, from a Canadian insurance company.', 'original', 0, 1, 1, 1),
(@ct5s3, 'Host''s Income Evidence', 'Meeting IRCC''s Super Visa income test.', 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(159, 5, 100.00, 'CAD', 'TRV / Super Visa Application Fee', 'Same CAD 100 fee for both the standard TRV and Super Visa; Super Visa additionally requires CAD 100,000 medical insurance, priced separately by the insurer.', '2026-09-01', NOW(), 'https://www.canada.ca/en/immigration-refugees-citizenship/services/visit-canada/super-visa-parents-grandparents.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is the Super Visa and who can use it?', 'A distinct multi-entry TRV specifically for parents and grandparents of a Canadian citizen/permanent resident, allowing stays of up to 5 years per entry (extendable to 7) over a visa valid up to 10 years.', 159, 5, 872, 1),
('Does the Super Visa require special insurance?', 'Yes — at least CAD 100,000 in medical insurance coverage, valid for a minimum of one year, from a Canadian insurance company.', 159, 5, 873, 1),
('Can any family member use the Super Visa?', 'No — it is specifically for parents and grandparents. Other family members use the standard TRV with an invitation letter and relationship proof.', 159, 5, 874, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — TRV (Transit)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    159, 6, 'CAN-TRANS-IN-06', '2026.09', 'published',
    'Passing through Canada en route to a third country.',
    'India is not on Canada''s Transit Without a Visa (TWOV) or China Transit Program eligible-nationality list, so most Indian travellers need a standard TRV even for short layovers. One real exception: holders of a valid, unexpired US non-immigrant visa may transit visa-free under TWOV if travelling strictly to/from the US, with a layover under 48 hours through a designated airport.',
    'Strictly for the duration of your layover/connection',
    'Online application via the IRCC Portal (unless the US-visa TWOV exception applies)',
    1,
    'Confirm first whether you qualify for the US-visa TWOV exception before applying for a standard TRV',
    'VFS Global Canada Visa Application Centre, India (if a TRV is required)',
    'Confirm whether the US-visa TWOV exception applies to your itinerary\nIf not, gather documents against this checklist and apply for a standard TRV\nAttend biometrics if required\nDecision once processed',
    '/assets/images/visa-heroes/canada.jpg',
    'Government of Canada (IRCC) Transit Without a Visa eligibility guidance', 'https://www.canada.ca/en/immigration-refugees-citizenship/services/visit-canada/transit/without-visa/eligibility.html', '2026-09-11'
);
SET @ct6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ct6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct6, 'Core Documents', 'Every applicant needs these.', 1);
SET @ct6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ct6s1, 'Confirmed Onward Travel Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct6, 'TWOV Exception Documents', 'For the US-visa transit exception only.', 2);
SET @ct6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct6s2, 'Valid US Non-Immigrant Visa', 'Required to qualify for the visa-free TWOV exception.', 'copy', 0, 1, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct6, 'Standard TRV Documents (If TWOV Does Not Apply)', 'Full TRV requirements.', 3);
SET @ct6s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct6s3, 'IRCC Portal Application Form', NULL, 'original', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(159, 6, 100.00, 'CAD', 'TRV Application Fee (If Required)', 'No fee applies if you qualify for the US-visa TWOV exception; otherwise the standard CAD 100 TRV fee applies.', '2026-09-01', NOW(), 'https://www.canada.ca/en/immigration-refugees-citizenship/services/visit-canada/transit/without-visa/eligibility.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian passport holders need a transit visa for Canada?', 'Usually yes — India is not on Canada''s TWOV eligible-nationality list. The one exception is holders of a valid US non-immigrant visa transiting under 48 hours via a designated airport, strictly to/from the US.', 159, 6, 875, 1),
('What designated airports support the TWOV exception?', 'Airports such as Toronto Pearson and Vancouver support the US-visa TWOV program — confirm the current designated list before relying on this exception.', 159, 6, 876, 1),
('What if my layover exceeds 48 hours?', 'You would not qualify for TWOV and would need a standard TRV regardless of holding a US visa.', 159, 6, 877, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — TRV (Medical Treatment)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    159, 7, 'CAN-MED-IN-07', '2026.09', 'published',
    'Travelling to Canada to receive medical treatment.',
    'No dedicated "medical visa" exists — it is a purpose-specific TRV. Canadian public healthcare does not cover visitors, so a Canadian hospital/institution letter confirming the appointment and treatment plan, plus proof of funds sufficient to cover treatment and living costs, are the key differentiating documents.',
    'As needed for the course of treatment, typically up to 6 months',
    'Online application via the IRCC Portal, biometrics at a VFS Global centre',
    1,
    'Processing depends on the completeness of medical documentation',
    'VFS Global Canada Visa Application Centre, India',
    'Obtain a treatment/appointment letter from the Canadian hospital or institution\nGather documents against this checklist\nSubmit your application via the IRCC Portal\nAttend biometrics\nDecision once processed',
    '/assets/images/visa-heroes/canada.jpg',
    'Government of Canada (IRCC) medical exam and TRV guidance', 'https://www.canada.ca/en/immigration-refugees-citizenship/services/application/medical-police/medical-exams/requirements-temporary-residents/country-requirements.html', '2026-09-11'
);
SET @ct7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ct7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct7, 'Core Documents', 'Every applicant needs these.', 1);
SET @ct7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ct7s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct7, 'Medical Documents', 'Evidence of your treatment plan.', 2);
SET @ct7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct7s2, 'Canadian Hospital/Institution Letter', 'Confirming appointment and treatment plan.', 'original', 1, 0, 1, 1),
(@ct7s2, 'Referral from Doctor in India', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct7, 'Financial Documents', 'Evidence you can pay for treatment.', 3);
SET @ct7s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct7s3, 'Proof of Funds for Treatment & Living Costs', 'Canadian public healthcare does not cover visitors.', 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(159, 7, 100.00, 'CAD', 'TRV Application Fee', 'Same fee/biometrics structure as Tourist — Medical treatment is a TRV purpose, not a separate visa product.', '2026-09-01', NOW(), 'https://www.canada.ca/en/immigration-refugees-citizenship/services/application/medical-police/medical-exams/requirements-temporary-residents/country-requirements.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a distinct Medical Visa for Canada?', 'No — medical treatment is a purpose-specific TRV, using the same product as Tourist with different supporting documents.', 159, 7, 878, 1),
('Does Canada''s public healthcare cover visitors receiving treatment?', 'No — you must show proof of funds sufficient to cover the full treatment and living costs yourself.', 159, 7, 879, 1),
('What if my treatment takes longer than expected?', 'Extensions are possible with evidence of ongoing treatment from your Canadian provider, filed before your authorized stay expires.', 159, 7, 880, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — TRV (Business Visitor, Conference)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    159, 8, 'CAN-CONF-IN-08', '2026.09', 'published',
    'Attending a conference, convention, or seminar in Canada.',
    'Conference attendance falls under the business-visitor TRV stream. If the conference is formally registered with IRCC, the organizer supplies an event code applicants enter on the application, which can streamline processing; otherwise a standard invitation/registration letter and registration-fee payment proof are used.',
    'Typically up to 6 months per entry, as decided by the border officer',
    'Online application via the IRCC Portal, biometrics at a VFS Global centre',
    1,
    'Processing depends on individual circumstances',
    'VFS Global Canada Visa Application Centre, India',
    'Obtain your conference invitation/registration confirmation\nCheck if the conference has an IRCC event code and include it if so\nGather documents against this checklist\nSubmit your application via the IRCC Portal\nAttend biometrics\nDecision once processed',
    '/assets/images/visa-heroes/canada.jpg',
    'Government of Canada (IRCC) Business Visitors — events and conferences guidance', 'https://www.canada.ca/en/immigration-refugees-citizenship/services/visit-canada/business/visitors-events-conferences.html', '2026-09-11'
);
SET @ct8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ct8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct8, 'Core Documents', 'Every applicant needs these.', 1);
SET @ct8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ct8s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct8, 'Conference Documents', 'Evidence of the event and your registration.', 2);
SET @ct8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct8s2, 'Conference Invitation/Registration Confirmation', 'Include the IRCC event code if the conference is registered.', 'original', 1, 0, 1, 1),
(@ct8s2, 'Registration Fee Payment Proof', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct8, 'Financial & Ties Documents', 'Evidence of funds and ties to India.', 3);
SET @ct8s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct8s3, 'Bank Statements', 'Last 6 months.', 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(159, 8, 100.00, 'CAD', 'TRV Application Fee', 'Same fee/biometrics structure as Business — Conference is a business-visitor TRV purpose.', '2026-09-01', NOW(), 'https://www.canada.ca/en/immigration-refugees-citizenship/services/visit-canada/business/visitors-events-conferences.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is an IRCC event code?', 'A code some formally-registered conferences receive from IRCC, which applicants can enter to help identify legitimate attendees and potentially streamline processing.', 159, 8, 881, 1),
('Is Conference a separate visa category for Canada?', 'No — it falls under the same business-visitor TRV stream, distinguished by conference-specific documents rather than a different visa product.', 159, 8, 882, 1),
('What if my conference is not IRCC-registered?', 'You can still apply using a standard invitation/registration letter from the organizer and proof of your registration fee payment.', 159, 8, 883, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — TRV or Work Permit depending on status
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    159, 9, 'CAN-SPORT-IN-09', '2026.09', 'published',
    'Competing in Canada as an amateur or signing with a Canadian professional sporting team.',
    'No standalone "sports visa" exists. Amateur athletes/coaches competing in tournaments, exhibitions, or charity events (even with prize money) are visitor-visa-exempt from needing a work permit under Canada''s Work Permit exemption regulations. Athletes signing with a Canadian professional team need a Work Permit, commonly under the LMIA-exempt C20 code.',
    'Tied to the competition/event or, for professional athletes, the team contract',
    'Amateur: standard TRV. Professional: Work Permit via LMIA-exempt Employer Portal route',
    1,
    'High-performance amateur athletes attending PCH-designated International Single-Sport Events may go through a specific authorization process',
    'VFS Global Canada Visa Application Centre, India',
    'Confirm whether your participation is amateur (TRV) or professional/employed (Work Permit)\nGather documents against this checklist\nSubmit the appropriate application via the IRCC Portal\nAttend biometrics\nDecision once processed',
    '/assets/images/visa-heroes/canada.jpg',
    'Government of Canada (IRCC) Work Permit exemptions (athletes) guidance', 'https://www.canada.ca/en/immigration-refugees-citizenship/services/work-canada.html', '2026-09-11'
);
SET @ct9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ct9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct9, 'Core Documents', 'Every applicant needs these.', 1);
SET @ct9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ct9s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct9, 'Event/Contract Documents', 'Evidence of your specific sporting engagement.', 2);
SET @ct9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct9s2, 'Event/Tournament Invitation (Amateur)', NULL, 'original', 0, 1, 1, 1),
(@ct9s2, 'Team Contract (Professional)', 'For a Work Permit application.', 'copy', 0, 1, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct9, 'Financial Documents', 'Evidence of funds where applicable.', 3);
SET @ct9s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct9s3, 'Bank Statements', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(159, 9, NULL, 'CAD', 'Confirmed After Assessment', 'Fee depends on whether you apply as an amateur (CAD 100 TRV) or professional athlete requiring a Work Permit (CAD 155) — we confirm the exact fee once your status is assessed.', '2026-09-01', NOW(), 'https://www.canada.ca/en/immigration-refugees-citizenship/services/work-canada.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do amateur athletes need a work permit to compete in Canada?', 'No — amateur athletes and coaches competing in tournaments, exhibitions, or charity events are work-permit-exempt, even where prize money is involved.', 159, 9, 884, 1),
('What about athletes signing with a Canadian professional team?', 'They need a Work Permit, commonly processed under the LMIA-exempt C20 code since they are being employed by a Canadian sporting organization.', 159, 9, 885, 1),
('Is there a special process for major international sporting events?', 'High-performance amateur athletes attending Canadian Heritage-designated International Single-Sport Events may go through a specific authorization process — we confirm this for your specific event.', 159, 9, 886, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Spousal Open Work Permit / accompanying family
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    159, 10, 'CAN-DEP-IN-10', '2026.09', 'published',
    'Accompanying a spouse/partner or parent who holds a valid Canadian work or study permit.',
    'No standalone "Dependent Visa" exists. Accompanying spouses/common-law partners generally apply for their own TRV or, where eligible under a currently-extended public policy (through end of 2026), a Spousal Open Work Permit letting them work for any employer. Minor children may study without their own study permit while a parent holds a valid permit, unless entering specifically to study, in which case they are processed as students.',
    'Matches the validity of the principal permit holder''s status',
    'Online application via the IRCC Portal, typically submitted alongside the principal applicant',
    1,
    'Processing depends on the principal permit holder''s status and eligibility for the spousal open work permit policy',
    'VFS Global Canada Visa Application Centre, India',
    'Confirm the principal work/study permit holder''s status and eligibility\nGather documents against this checklist, including relationship proof\nSubmit your TRV or Spousal Open Work Permit application via the IRCC Portal\nAttend biometrics\nDecision once processed',
    '/assets/images/visa-heroes/canada.jpg',
    'Government of Canada (IRCC) open work permits for family members guidance', 'https://www.canada.ca/en/immigration-refugees-citizenship/services/work-canada/special-instructions/spouses-dependent-children.html', '2026-09-11'
);
SET @ct10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ct10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct10, 'Core Documents', 'Every applicant needs these.', 1);
SET @ct10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ct10s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct10, 'Principal Holder & Relationship Documents', 'Evidence of who you are accompanying.', 2);
SET @ct10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct10s2, 'Principal Holder''s Work/Study Permit', NULL, 'copy', 1, 0, 1, 1),
(@ct10s2, 'Marriage/Common-Law Relationship Proof', 'For a spouse/partner applicant.', 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ct10, 'Financial Documents', 'Evidence of financial support.', 3);
SET @ct10s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ct10s3, 'Principal Holder''s Income Evidence', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(159, 10, 155.00, 'CAD', 'Spousal Open Work Permit Fee', 'CAD 155 permit fee plus CAD 100 open work permit holder fee, where the spousal open work permit policy applies; otherwise a standard CAD 100 TRV fee applies.', '2026-09-01', NOW(), 'https://www.canada.ca/en/immigration-refugees-citizenship/services/work-canada/special-instructions/spouses-dependent-children.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Dependent Visa for Canada?', 'No — accompanying spouses generally apply for their own TRV or a Spousal Open Work Permit; there is no standalone dependent-visa product.', 159, 10, 887, 1),
('Can my children study without their own study permit?', 'Minor children may study up to secondary level without their own permit while a parent holds a valid work/study permit — but if entering specifically to study, they are processed as students instead.', 159, 10, 888, 1),
('What is a Spousal Open Work Permit?', 'A work permit letting an accompanying spouse/common-law partner work for any Canadian employer, available under a currently-extended public policy through end of 2026 for eligible principal permit holders.', 159, 10, 889, 1);
