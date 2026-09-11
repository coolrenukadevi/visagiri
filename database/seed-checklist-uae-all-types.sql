-- UAE Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search, same standard as every other
-- country built this session (see AUDIT.md). hero_image_url points at
-- the real Burj Khalifa/Dubai skyline and UAE flag photo supplied by
-- the client for this hero.
--
-- The UAE's real, distinctive facts:
--   - A genuine visa-on-arrival (VoA) facility exists for Indian
--     passport holders, but ONLY when they already hold a valid US
--     visa/residence/Green Card (≥6 months validity), or — since 13
--     Feb 2025 — a valid Australia/Canada/Japan/New Zealand/South
--     Korea/Singapore residence permit. As of July 2026, UK documents
--     were REMOVED from VoA eligibility — a real, recent policy
--     tightening stated with its effective date rather than assumed
--     still current. Everyone else uses the standard eVisa/sponsored
--     route.
--   - Student, Work, Medical, and Dependent are genuine RESIDENCE
--     visas (institution/employer/hospital/resident sponsor required,
--     mandatory medical fitness test, Emirates ID biometrics) — a
--     structurally different, longer process from the short-stay
--     Visit Visa family (Tourist/Business/Family Visit), which needs
--     none of that.
--   - Transit is genuinely two products: a free 48-hour transit visa
--     and a paid (AED 50) 96-hour version — both must be arranged in
--     advance by the operating airline, not obtained independently.
--   - Conference and Sports now sit under the UAE's newer "Events
--     Visit Visa" (a 2025-2026 ICP/GDRFA reform), sponsored by the
--     hosting organization/federation rather than an individual — a
--     real, recently introduced product, not the generic Visit Visa.
--   - Family Visit sponsor income thresholds are real and tiered by
--     relationship degree (AED 4,000/month for first-degree relatives,
--     AED 8,000/month for second/third-degree, AED 15,000/month for a
--     non-relative friend) per GDRFA Dubai's 2026 clarification.
--
-- country_id 102 = United Arab Emirates. visa_type_id: 1=Tourist,
-- 2=Business, 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical,
-- 8=Conference, 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Visit Visa / Visa-on-Arrival
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    102, 1, 'ARE-TOUR-IN-01', '2026.09', 'published',
    'Leisure travel, sightseeing, and shopping trips to the United Arab Emirates.',
    'Indian passport holders qualify for a 14-day visa-on-arrival ONLY if they already hold a valid US visa/residence/Green Card (6+ months validity remaining) or a valid Australia/Canada/Japan/New Zealand/South Korea/Singapore residence permit. UK documents were removed from this eligibility list in July 2026. Everyone else applies for a standard eVisa in advance.',
    '30 or 60 days, single or multiple entry, as selected',
    'Standard eVisa via a licensed sponsor (airline, hotel, tour operator); or visa-on-arrival if eligible',
    0,
    'eVisa processing is typically fast (2-4 working days); no biometrics required for this short-stay visa',
    'No in-person office visit required — arranged online via sponsor',
    'Confirm whether you qualify for visa-on-arrival or need a standard eVisa\nIf standard: apply through a licensed sponsor (airline/hotel/tour operator)\nGather documents against this checklist\nReceive and print your eVisa approval before travel\nPresent it with your passport on arrival',
    '/assets/images/visa-heroes/uae.jpg',
    'UAE government (u.ae) and GDRFA Dubai visa-on-arrival guidance for Indian nationals', 'https://www.gdrfad.gov.ae/en/services/727c91b1-52eb-11ea-0320-0050569629e8', '2026-09-11'
);
SET @at1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@at1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at1, 'Core Documents', 'Every applicant needs these.', 1);
SET @at1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at1s1, 'Valid Passport', 'Valid at least 6 months beyond arrival.', 'original', 1, 0, 1, 1),
(@at1s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at1, 'Visa-on-Arrival Eligibility Documents', 'If you qualify for the 14-day VoA.', 2);
SET @at1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at1s2, 'Valid US Visa/Residence/Green Card', 'Or a valid Australia/Canada/Japan/New Zealand/South Korea/Singapore residence permit.', 'copy', 0, 1, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at1, 'Standard eVisa Documents (If Not VoA-Eligible)', 'For sponsor-arranged applications.', 3);
SET @at1s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at1s3, 'Sponsor Application (Airline/Hotel/Tour Operator)', NULL, 'original', 0, 1, 0, 1),
(@at1s3, 'Return/Onward Ticket', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(102, 1, 210.00, 'AED', 'Tourist Visa Fee (30-Day Single Entry)', 'AED 200 + 5% VAT for a 30-day single-entry visa; 60-day and multiple-entry options cost more. Visa-on-arrival, where eligible, is free of a separate application fee.', '2026-09-01', NOW(), 'https://www.gdrfad.gov.ae/en/services/f9e586fe-0642-11ec-0320-0050569629e8', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do all Indian citizens get visa-on-arrival for the UAE?', 'No — only those already holding a valid US visa/residence/Green Card, or a valid Australia/Canada/Japan/New Zealand/South Korea/Singapore residence permit. As of July 2026, UK documents no longer qualify.', 102, 1, 1010, 1),
('What if I don''t qualify for visa-on-arrival?', 'You apply for a standard eVisa in advance through a licensed sponsor such as an airline, hotel, or tour operator.', 102, 1, 1011, 1),
('Is biometrics required for a Tourist visa?', 'No — short-stay Visit Visas do not require biometrics or a medical test, unlike UAE residence visas.', 102, 1, 1012, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Visit Visa (Business)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    102, 2, 'ARE-BUS-IN-02', '2026.09', 'published',
    'Short business visits — meetings and negotiations — to the United Arab Emirates.',
    'Uses the same Visit Visa product as Tourist (30/60-day, single/multiple entry), but requires sponsorship by a UAE-licensed company via an invitation letter and trade license copy — the visitor need not be an employee of the sponsoring company.',
    '30 or 60 days, single or multiple entry',
    'Sponsored eVisa via a UAE-licensed company; or visa-on-arrival if eligible',
    0,
    'Processing typically runs 2-4 working days',
    'No in-person office visit required — arranged online via sponsor',
    'Confirm whether you qualify for visa-on-arrival or need a sponsored eVisa\nObtain an invitation letter and trade license copy from your UAE sponsor\nGather documents against this checklist\nReceive and print your eVisa approval before travel\nPresent it with your passport on arrival',
    '/assets/images/visa-heroes/uae.jpg',
    'UAE government (u.ae) Visit Visa (business) guidance', 'https://u.ae/en/information-and-services/visa-and-emirates-id/Types-of-visas', '2026-09-11'
);
SET @at2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@at2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at2, 'Core Documents', 'Every applicant needs these.', 1);
SET @at2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@at2s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at2, 'Sponsorship Documents', 'Evidence of your UAE company sponsor.', 2);
SET @at2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at2s2, 'Invitation Letter from UAE Company', NULL, 'original', 1, 0, 1, 1),
(@at2s2, 'Sponsor''s Trade License Copy', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at2, 'Financial Documents', 'Evidence of funds.', 3);
SET @at2s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at2s3, 'Bank Statements', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(102, 2, 210.00, 'AED', 'Visit Visa Fee (30-Day Single Entry)', 'Same fee structure as Tourist — Business is the same Visit Visa product, sponsored by a UAE company instead of a tour operator.', '2026-09-01', NOW(), 'https://u.ae/en/information-and-services/visa-and-emirates-id/Types-of-visas', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Business Visa product for the UAE?', 'No — Business uses the same Visit Visa as Tourist, but requires sponsorship by a UAE-licensed company via an invitation letter and trade license copy.', 102, 2, 1013, 1),
('Do I need to be an employee of the sponsoring company?', 'No — clients, suppliers, and business partners can also qualify for company sponsorship, not just employees.', 102, 2, 1014, 1),
('Does visa-on-arrival eligibility apply to Business visits too?', 'Yes — the same VoA eligibility rules (valid US or select other-country documents) apply regardless of tourist or business purpose.', 102, 2, 1015, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Student Residence Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    102, 3, 'ARE-STU-IN-03', '2026.09', 'published',
    'Full-time study at a UAE educational institution.',
    'A genuine residence visa, not a short-stay Visit Visa — the educational institution is the legal sponsor. Requires a mandatory medical fitness test and Emirates ID biometrics after arrival, a structurally different process from the short-stay visit visa family.',
    'Tied to your course duration',
    'Institution-sponsored residence visa: entry permit, then status change, medical test, and Emirates ID after arrival',
    1,
    'End-to-end process (entry permit through Emirates ID) typically takes several weeks after arrival',
    'Arranged through your UAE educational institution; medical test and Emirates ID biometrics after arrival',
    'Secure admission from an accredited UAE institution, which becomes your sponsor\nObtain your entry permit\nAttend a mandatory medical fitness test after arrival\nComplete Emirates ID biometrics\nArrange mandatory health insurance\nVisa stamping once all steps are complete',
    '/assets/images/visa-heroes/uae.jpg',
    'UAE government (u.ae) Student residence visa guidance', 'https://u.ae/en/information-and-services/visa-and-emirates-id/Types-of-visas/Residence-visa', '2026-09-11'
);
SET @at3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@at3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at3, 'Core Documents', 'Every applicant needs these.', 1);
SET @at3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@at3s1, 'Admission/Enrolment Letter', 'From an accredited UAE institution.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at3, 'Medical & Biometric Documents', 'Mandatory post-arrival steps.', 2);
SET @at3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at3s2, 'Medical Fitness Test Result', 'Chest X-ray and blood tests, within ~2 weeks of arrival.', 'original', 1, 0, 1, 1),
(@at3s2, 'Emirates ID Biometric Appointment', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at3, 'Insurance Documents', 'Mandatory health cover.', 3);
SET @at3s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at3s3, 'Mandatory Health Insurance', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(102, 3, 370.00, 'AED', 'Medical Test + Emirates ID Fees (Indicative)', 'Medical fitness test runs roughly AED 310-430; Emirates ID and visa stamping fees are separate and vary by institution/emirate — confirm your total with us once your institution is known.', '2026-09-01', NOW(), 'https://u.ae/en/information-and-services/visa-and-emirates-id/Types-of-visas/Residence-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Student visa the same as a short Visit Visa?', 'No — it is a genuine residence visa sponsored by your institution, requiring a medical fitness test and Emirates ID biometrics, unlike the short-stay Tourist/Business Visit Visas.', 102, 3, 1016, 1),
('When is the medical fitness test required?', 'Within roughly 2 weeks of arrival, for applicants aged 18 and over, as part of the residence-visa process.', 102, 3, 1017, 1),
('Do I need health insurance?', 'Yes — mandatory health insurance is required as part of the Student residence visa process.', 102, 3, 1018, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Employment Residence Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    102, 4, 'ARE-WORK-IN-04', '2026.09', 'published',
    'Employer-sponsored employment in the United Arab Emirates.',
    'A genuine residence visa requiring a UAE-licensed employer to first obtain a MOHRE work permit — you cannot self-apply. The full sequence (work permit, entry permit, medical test, status change, Emirates ID, digital labour card, visa stamping) typically takes 2-3 weeks end-to-end.',
    'Tied to your employment contract, renewable',
    'Employer-sponsored: MOHRE work permit, then entry permit, medical test, status change, Emirates ID, visa stamping',
    1,
    'End-to-end process typically runs 2-3 weeks',
    'Arranged through your UAE employer; medical test and Emirates ID biometrics after arrival',
    'Employer obtains your MOHRE work permit\nObtain your entry permit\nAttend a mandatory medical fitness test after arrival\nComplete your status change and Emirates ID biometrics\nEmployer issues your digital labour card via the MOHRE portal\nVisa stamping once all steps are complete',
    '/assets/images/visa-heroes/uae.jpg',
    'UAE government (u.ae) Employment residence visa and MOHRE work permit guidance', 'https://u.ae/en/information-and-services/visa-and-emirates-id/Types-of-visas/Residence-visa', '2026-09-11'
);
SET @at4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@at4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at4, 'Core Documents', 'Every applicant needs these.', 1);
SET @at4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@at4s1, 'MOHRE Work Permit', 'Obtained by your employer before you can apply.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at4, 'Employer Sponsorship Documents', 'Evidence of your role.', 2);
SET @at4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at4s2, 'Employment Contract', NULL, 'copy', 1, 0, 1, 1),
(@at4s2, 'Educational Credentials', 'Attested where required.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at4, 'Medical & Biometric Documents', 'Mandatory post-arrival steps.', 3);
SET @at4s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at4s3, 'Medical Fitness Test Result', NULL, 'original', 1, 0, 0, 1),
(@at4s3, 'Emirates ID Biometrics', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(102, 4, 100.00, 'AED', 'Work Visa Fee (Indicative)', 'Indicative government work-visa fee around AED 100; Iqama-equivalent (Emirates ID/labour card) and medical-test costs are separate and typically arranged/partly borne by the employer.', '2026-09-01', NOW(), 'https://u.ae/en/information-and-services/visa-and-emirates-id/Types-of-visas/Residence-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I apply for a UAE work visa on my own?', 'No — your UAE employer must first obtain a MOHRE work permit before you can begin the residence-visa process.', 102, 4, 1019, 1),
('What does the digital labour card replace?', 'The digital labour card, issued via the MOHRE portal/app, has replaced the older physical labour card.', 102, 4, 1020, 1),
('How long does the full process take?', 'Typically 2-3 weeks end-to-end, covering the work permit, entry permit, medical test, status change, and Emirates ID.', 102, 4, 1021, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Visit Visa (Family/Friends)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    102, 5, 'ARE-FAM-IN-05', '2026.09', 'published',
    'Visiting family or friends resident in the United Arab Emirates.',
    'A short-term Visit Visa (distinct from the long-term Dependent residence visa) sponsored by a UAE resident, with real tiered sponsor income thresholds: AED 4,000/month for first-degree relatives, AED 8,000/month for second/third-degree relatives, and AED 15,000/month to sponsor a non-relative friend.',
    '30/60/90 days, single or multiple entry, capped at 120 days/year cumulative',
    'Sponsored eVisa via your UAE-resident host',
    0,
    'Applications are typically processed within 48 hours; you must enter within 60 days of issuance',
    'No in-person office visit required — arranged online via sponsor',
    'Confirm your UAE-resident sponsor meets the applicable income threshold for your relationship degree\nSponsor applies through GDRFA/ICP channels\nGather documents against this checklist\nReceive and print your eVisa approval before travel\nPresent it with your passport on arrival',
    '/assets/images/visa-heroes/uae.jpg',
    'GDRFA Dubai Family Visit Visa income-threshold clarification (2026)', 'https://gulfnews.com/business/tourism/gdrfa-clarifies-visit-visa-rules-for-relatives-and-friends-1.500610820', '2026-09-11'
);
SET @at5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@at5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at5, 'Core Documents', 'Every applicant needs these.', 1);
SET @at5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@at5s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at5, 'Sponsor Income Documents', 'Meeting the applicable relationship-degree threshold.', 2);
SET @at5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at5s2, 'Sponsor''s Salary Certificate', 'AED 4,000/month (first-degree), AED 8,000/month (second/third-degree), or AED 15,000/month (non-relative friend).', 'copy', 1, 0, 1, 1),
(@at5s2, 'Sponsor''s Emirates ID/Visa Copy', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at5, 'Relationship Documents', 'Evidence of your relationship to the sponsor.', 3);
SET @at5s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at5s3, 'Relationship Proof', 'Birth/marriage certificates, where the sponsor is a relative.', 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(102, 5, 210.00, 'AED', 'Family Visit Visa Fee (30-Day)', 'Similar fee structure to the general Visit Visa, sponsored by your UAE-resident family member or friend instead of a company or tour operator.', '2026-09-01', NOW(), 'https://gulfnews.com/business/tourism/gdrfa-clarifies-visit-visa-rules-for-relatives-and-friends-1.500610820', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How much must my sponsor earn to bring me on a Family Visit Visa?', 'It depends on relationship degree: AED 4,000/month for first-degree relatives (spouse, parents, children), AED 8,000/month for second/third-degree relatives, and AED 15,000/month for a non-relative friend.', 102, 5, 1022, 1),
('Is this the same as a Dependent residence visa?', 'No — this is a short-term Visit Visa (30/60/90 days), genuinely different from the long-term Dependent residence visa covered separately.', 102, 5, 1023, 1),
('Is there a cap on how long I can visit per year?', 'Yes — cumulative stays are capped at 120 days per year under this visa category.', 102, 5, 1024, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — 48-Hour / 96-Hour Transit Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    102, 6, 'ARE-TRANS-IN-06', '2026.09', 'published',
    'Passing through Dubai, Abu Dhabi, or Sharjah airports en route to a third country.',
    'Two genuine products exist: a free 48-hour transit visa and a paid (AED 50) 96-hour version, for travellers who want to leave the airport during their connection. Both must be arranged in advance by the operating UAE-based airline — not obtainable independently on arrival.',
    '48 hours (free) or 96 hours (AED 50)',
    'Arranged in advance by your operating airline',
    0,
    'Not needed if you already hold a valid UAE visa, GCC residence permit, or a visa-exempt passport',
    'Not applicable — arranged entirely through your airline',
    'Confirm with your airline whether you need a transit visa for your specific connection\nAirline arranges the 48-hour (free) or 96-hour (AED 50) transit visa on your behalf\nPresent it with your passport on arrival\nReturn to the airport in time for your onward flight',
    '/assets/images/visa-heroes/uae.jpg',
    'UAE government (u.ae) Transit Visa guidance', 'https://u.ae/en/information-and-services/visa-and-emirates-id/Types-of-visas/transit-visa', '2026-09-11'
);
SET @at6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@at6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at6, 'Core Documents', 'Every applicant needs these.', 1);
SET @at6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@at6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at6, 'Airline-Arranged Documents', 'Handled by your operating airline.', 2);
SET @at6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at6s2, 'Airline Transit Visa Application', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(102, 6, 0.00, 'AED', '48-Hour Transit Visa Fee', 'Free for the 48-hour transit visa; AED 50 for the 96-hour version. Both must be arranged by your operating airline, not applied for independently.', '2026-09-01', NOW(), 'https://u.ae/en/information-and-services/visa-and-emirates-id/Types-of-visas/transit-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I apply for a UAE transit visa myself?', 'No — both the 48-hour and 96-hour transit visas must be arranged in advance by your operating UAE-based airline, not applied for independently.', 102, 6, 1025, 1),
('Is there a fee for transit?', 'The 48-hour version is free; the 96-hour version costs AED 50.', 102, 6, 1026, 1),
('When is a transit visa not needed?', 'If you already hold a valid UAE visa, a GCC residence permit, or a visa-exempt passport.', 102, 6, 1027, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Patient and Companion Entry Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    102, 7, 'ARE-MED-IN-07', '2026.09', 'published',
    'Travelling to the United Arab Emirates to receive medical treatment.',
    'Officially the "Patient and Companion Entry Permit," sponsored by the licensed UAE hospital, valid for 90 or 180 days, one or multiple entries. Since June 2026, Dubai launched an integrated coordination system streamlining medical-visa approvals as part of a broader health-tourism push.',
    '90 or 180 days, one or multiple entries',
    'Hospital-sponsored entry permit, arranged through the treating UAE hospital',
    0,
    'The 2026 integrated coordination system has streamlined approval timelines in Dubai specifically',
    'Arranged through your treating UAE hospital',
    'Obtain an invitation from a licensed UAE hospital, including your medical reports\nGather documents against this checklist\nHospital sponsors your Patient Entry Permit (and a linked Companion Permit if needed)\nReceive and print your approval before travel\nPresent it with your passport on arrival',
    '/assets/images/visa-heroes/uae.jpg',
    'UAE government (u.ae) and GDRFA Dubai Medical Visa (Patient and Companion Entry Permit) guidance', 'https://u.ae/en/information-and-services/visa-and-emirates-id/visit-visas/patient-and-companion-entry-permits', '2026-09-11'
);
SET @at7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@at7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at7, 'Core Documents', 'Every applicant needs these.', 1);
SET @at7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@at7s1, 'Hospital Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at7, 'Medical Documents', 'Evidence of your treatment plan.', 2);
SET @at7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at7s2, 'Medical Reports', NULL, 'copy', 1, 0, 1, 1),
(@at7s2, 'Proof of Financial Capability for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at7, 'Companion Documents', 'If a companion is accompanying you.', 3);
SET @at7s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at7s3, 'Companion Entry Permit Application', 'Linked to the patient''s own permit.', 'original', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(102, 7, NULL, 'AED', 'Confirmed After Assessment', 'Fee is arranged and typically quoted by the treating hospital as part of the invitation process rather than a single fixed government figure — confirmed once your treatment plan is known.', '2026-09-01', NOW(), 'https://u.ae/en/information-and-services/visa-and-emirates-id/visit-visas/patient-and-companion-entry-permits', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Who sponsors a UAE Medical Visa?', 'The licensed UAE hospital where you are being treated — they issue the invitation and sponsor your Patient Entry Permit.', 102, 7, 1028, 1),
('Can a companion travel with me?', 'Yes — a Companion Entry Permit can be linked to the patient''s own permit for someone accompanying you.', 102, 7, 1029, 1),
('What changed in June 2026?', 'Dubai launched an integrated coordination system between immigration and health authorities, streamlining medical-visa approvals as part of a broader health-tourism push.', 102, 7, 1030, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Events Visit Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    102, 8, 'ARE-CONF-IN-08', '2026.09', 'published',
    'Attending a conference, summit, or exhibition in the United Arab Emirates.',
    'Falls under the newer "Events Visit Visa" (a real 2025-2026 ICP/GDRFA reform) rather than the generic Visit Visa. The sponsor must be the hosting organization itself, which can apply for an approved participant quota covering 100+ attendees per event.',
    '30 or 60 days, single or multiple entry',
    'Sponsored via the event''s hosting organization under the Events Visit Visa scheme',
    0,
    'The hosting organization applies for a participant quota, which can streamline processing for large delegations',
    'No in-person office visit required — arranged online via the hosting organization',
    'Confirm your conference is covered by the hosting organization''s Events Visit Visa quota\nGather documents against this checklist, including the event invitation\nHosting organization sponsors your application\nReceive and print your approval before travel\nPresent it with your passport on arrival',
    '/assets/images/visa-heroes/uae.jpg',
    'UAE Events Visit Visa guidance (Gulf News, Arabian Business, citing 2025-2026 ICP/GDRFA reforms)', 'https://gulfnews.com/uae/government/gdrfa-dubai-clarifies-who-can-apply-for-the-uae-events-visit-visa-1.500613560', '2026-09-11'
);
SET @at8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@at8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at8, 'Core Documents', 'Every applicant needs these.', 1);
SET @at8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@at8s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at8, 'Event Documents', 'Evidence of the event and your role.', 2);
SET @at8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at8s2, 'Event Invitation Letter', 'From the hosting organization, detailing the event and its duration.', 'original', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at8, 'Financial Documents', 'Evidence of funds.', 3);
SET @at8s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at8s3, 'Bank Statements', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(102, 8, 210.00, 'AED', 'Events Visit Visa Fee (Indicative)', 'Fee roughly tracks the standard 30-day Visit Visa rate but is arranged via the hosting organization''s event quota rather than a general sponsor — confirmed once your conference details are known.', '2026-09-01', NOW(), 'https://gulfnews.com/uae/government/gdrfa-dubai-clarifies-who-can-apply-for-the-uae-events-visit-visa-1.500613560', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Conference a separate visa product for the UAE?', 'Yes — a real, recently introduced "Events Visit Visa," sponsored by the hosting organization rather than an individual company, distinct from the generic Visit Visa.', 102, 8, 1031, 1),
('Who can sponsor an Events Visit Visa?', 'Only the hosting public or private organizing entity, which can apply for an approved participant quota covering large delegations.', 102, 8, 1032, 1),
('Does this cover exhibitions and festivals too?', 'Yes — the Events Visit Visa covers conferences, summits, exhibitions, conventions, and cultural/sports/entertainment festivals.', 102, 8, 1033, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Events Visit Visa / Golden Visa (Elite Athletes)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    102, 9, 'ARE-SPORT-IN-09', '2026.09', 'published',
    'Participating in a sporting event in the United Arab Emirates as an athlete, coach, referee, or official.',
    'Largely processed under the same Events Visit Visa as Conference, sponsored by the event organizer or a recognized federation (e.g. the UAE Football Association). A distinct, separate pathway exists for elite athletes (Olympic medallists, World Cup participants): a long-term Golden Visa via federation nomination/endorsement.',
    '30 or 60 days for event participants (Events Visit Visa); long-term for Golden Visa-eligible elite athletes',
    'Events Visit Visa via the organizing federation; or Golden Visa nomination for elite athletes',
    0,
    'Golden Visa nomination is a separate, longer process reserved for elite/medal-winning athletes',
    'No in-person office visit required for event participation — arranged via the organizing federation',
    'Confirm whether you qualify for the standard Events Visit Visa or elite-athlete Golden Visa nomination\nObtain sponsorship from the organizing federation or event body\nGather documents against this checklist\nReceive and print your approval before travel\nPresent it with your passport on arrival',
    '/assets/images/visa-heroes/uae.jpg',
    'UAE Events Visit Visa and Abu Dhabi Golden Visa for Athletes guidance', 'https://www.added.gov.ae/en/live/long-term-residency/abu-dhabi-golden-visa/for-brilliant-talents/for-athletes', '2026-09-11'
);
SET @at9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@at9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at9, 'Core Documents', 'Every applicant needs these.', 1);
SET @at9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@at9s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at9, 'Event Sponsorship Documents', 'For standard event participation.', 2);
SET @at9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at9s2, 'Federation/Organizer Invitation Letter', NULL, 'original', 0, 1, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at9, 'Golden Visa Documents (Elite Athletes Only)', 'For qualifying long-term nomination.', 3);
SET @at9s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at9s3, 'Federation Nomination/Endorsement', 'For Olympic medallists, World Cup participants, and similar elite achievement.', 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(102, 9, 210.00, 'AED', 'Events Visit Visa Fee (Standard Participation)', 'Roughly tracks the standard Visit Visa rate for event participants; the Golden Visa pathway for elite athletes has a separate, different fee structure confirmed once eligibility is assessed.', '2026-09-01', NOW(), 'https://www.added.gov.ae/en/live/long-term-residency/abu-dhabi-golden-visa/for-brilliant-talents/for-athletes', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a long-term visa option for elite athletes?', 'Yes — a distinct Golden Visa track via nomination/endorsement from a UAE sports federation, for Olympic medallists, World Cup participants, and similarly elite achievers.', 102, 9, 1034, 1),
('How do most athletes attend a UAE sporting event?', 'Most process under the same Events Visit Visa as conferences, sponsored by the event organizer or a recognized federation.', 102, 9, 1035, 1),
('Who sponsors a standard sports event participation visa?', 'The event organizer or a recognized federation, such as the UAE Football Association for football-related events.', 102, 9, 1036, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Dependent Residence Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    102, 10, 'ARE-DEP-IN-10', '2026.09', 'published',
    'Joining a spouse or parent who holds a UAE residence visa.',
    'A genuine long-term residence visa (distinct from the short-stay Family Visit Visa) for a UAE resident''s spouse, unmarried daughters, sons under 25, and special-needs children. Sponsor must hold a valid residence visa/Emirates ID and earn a minimum of AED 4,000/month (or AED 3,000 plus employer-provided accommodation).',
    'Tied to the sponsor''s residence visa validity',
    'Sponsor-driven: entry permit, status change, medical test, Emirates ID biometrics, visa stamping',
    1,
    'Total processing runs 2-4 weeks, plus 1-2 weeks if MOFA attestation of marriage/birth certificates is still needed',
    'Arranged through your sponsoring resident family member; medical test and Emirates ID biometrics after arrival',
    'Confirm your sponsor meets the minimum income requirement\nObtain your entry permit\nAttend a mandatory medical fitness test after arrival (dependents 18+)\nComplete Emirates ID biometrics\nMOFA-attest your marriage/birth certificates if not already done\nVisa stamping once all steps are complete',
    '/assets/images/visa-heroes/uae.jpg',
    'UAE government (u.ae) Residence visa for families of employees guidance', 'https://u.ae/en/information-and-services/visa-and-emirates-id/Types-of-visas/Residence-visa/residence-visa-for-family-members', '2026-09-11'
);
SET @at10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@at10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at10, 'Core Documents', 'Every applicant needs these.', 1);
SET @at10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@at10s1, 'Sponsor''s Residence Visa/Emirates ID Copy', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at10, 'Relationship Documents', 'Evidence of your relationship to the sponsor.', 2);
SET @at10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at10s2, 'MOFA-Attested Marriage Certificate', 'For a spouse applicant.', 'copy', 0, 1, 1, 1),
(@at10s2, 'MOFA-Attested Birth Certificate', 'For a child applicant.', 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@at10, 'Financial & Medical Documents', 'Evidence of the sponsor''s income and mandatory medical clearance.', 3);
SET @at10s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@at10s3, 'Sponsor''s Salary Certificate', 'Minimum AED 4,000/month, or AED 3,000/month with employer-provided accommodation.', 'copy', 1, 0, 0, 1),
(@at10s3, 'Medical Fitness Test Result', 'For dependents aged 18 and over.', 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(102, 10, 370.00, 'AED', 'Dependent Residence Visa Fees (Indicative)', 'Indicative combined medical test/Emirates ID/stamping costs; exact total varies by emirate and dependent age — confirmed once your sponsor''s details are known.', '2026-09-01', NOW(), 'https://u.ae/en/information-and-services/visa-and-emirates-id/Types-of-visas/Residence-visa/residence-visa-for-family-members', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is the minimum sponsor income for a Dependent visa?', 'AED 4,000/month, or AED 3,000/month if the sponsor''s employer provides accommodation.', 102, 10, 1037, 1),
('Do all dependents need a medical test?', 'Only those aged 18 and over — younger children are typically exempt from the mandatory medical fitness test.', 102, 10, 1038, 1),
('Is this the same as the Family Visit Visa?', 'No — Dependent is a genuine long-term residence visa, distinct from the short-stay Family Visit Visa covered separately.', 102, 10, 1039, 1);
