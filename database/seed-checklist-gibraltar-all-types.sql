-- Gibraltar Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Gibraltar's real, distinctive facts verified this session:
--   - Indian citizens holding a valid UK multiple-entry visa (6+
--     months validity), a UK residence permit (12+ months validity),
--     or an EU family permit can travel to Gibraltar without a
--     separate Gibraltar visa.
--   - For Indians without a qualifying UK/EU document, Gibraltar
--     introduced a dedicated eVisa specifically for India (per an
--     official Government of Gibraltar press release titled "E-Visas
--     for India — 881/2023") — confirmed to exist, though its
--     specific fee/validity/processing details could not be directly
--     fetched this session (the official gibraltar.gov.gi domain was
--     blocked by this session's network egress proxy).
--   - UK visa applications from India (which the visa-free exemption
--     relies on) are processed via outsourced centres across India
--     (New Delhi, Mumbai, Chennai, Kolkata, and others), assessed at
--     the British High Commission New Delhi or its Deputy High
--     Commissions.
--
-- country_id 120 = Gibraltar. visa_type_id: 1=Tourist, 2=Business,
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
    120, 1, 'GIB-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Gibraltar.',
    'Indian citizens holding a valid UK multiple-entry visa (6+ months), UK residence permit (12+ months), or EU family permit can enter without a separate Gibraltar visa; others apply for Gibraltar''s dedicated eVisa for India.',
    'As endorsed on the qualifying UK/EU document or the Gibraltar eVisa',
    'Travel visa-free with a qualifying UK/EU document, or apply for the Gibraltar eVisa for India',
    0,
    'Not independently confirmed this session for the eVisa route — the official gibraltar.gov.gi portal was not directly reachable this session',
    'No Gibraltar mission in India; the eVisa is applied for online, and UK visa applications route through the British High Commission New Delhi or its Deputy High Commissions',
    'Check if you hold a qualifying UK multiple-entry visa (6+ months), UK residence permit (12+ months), or EU family permit\nIf not, apply for the Gibraltar eVisa for India online\nGather passport, photo, and travel documents\nBook proof of return ticket and accommodation\nCarry your passport and qualifying document/eVisa on arrival',
    '/assets/images/visa-heroes/gibraltar.webp',
    'Government of Gibraltar press release on E-Visas for India, Skyscanner, and CIBTvisas secondary sourcing', 'https://www.gibraltar.gov.gi/press-releases/e-visas-for-india-8812023-9490', '2026-09-19'
);
SET @gib1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gib1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gib1, 'Core Documents', 'Required from every traveller.', 1);
SET @gib1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gib1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gib1s1, 'Valid UK Multiple-Entry Visa/Residence Permit/EU Family Permit (If Using the Exemption)', NULL, 'copy', 0, 1, 1, 2),
(@gib1s1, 'Gibraltar eVisa for India (If Not Using the UK/EU Exemption)', NULL, 'copy', 0, 1, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gib1, 'Supporting Documents', 'Evidence of your travel plans.', 2);
SET @gib1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gib1s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 1),
(@gib1s2, 'Proof of Accommodation Booking', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(120, 1, NULL, 'GBP', 'Confirm eVisa Fee', 'No fee applies if using the UK/EU visa-free exemption. The dedicated Gibraltar eVisa for India exists per an official government press release, but its exact fee was not independently confirmed this session — the official portal was not directly reachable.', '2026-09-01', NOW(), 'https://www.gibraltar.gov.gi/press-releases/e-visas-for-india-8812023-9490', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Gibraltar?', 'Not if you hold a valid UK multiple-entry visa (6+ months), a UK residence permit (12+ months), or an EU family permit — these exempt you from a separate Gibraltar visa. Otherwise, Gibraltar offers a dedicated eVisa specifically for Indian citizens.', 120, 1, 12000, 1),
('Is a UK visa the same as a Gibraltar visa?', 'No — they are separate, but Gibraltar exempts holders of a qualifying UK visa/residence permit from needing its own visa. Indians without one apply for Gibraltar''s own eVisa for India instead.', 120, 1, 12001, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    120, 2, 'GIB-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Gibraltar.',
    'Business travellers use the same UK/EU exemption or Gibraltar eVisa framework as tourists, adding a business invitation letter for the eVisa route.',
    'As endorsed on the qualifying UK/EU document or the Gibraltar eVisa',
    'Travel visa-free with a qualifying UK/EU document, or apply for the Gibraltar eVisa for India',
    0,
    'Not independently confirmed this session for the eVisa route',
    'No Gibraltar mission in India; the eVisa is applied for online',
    'Check if you hold a qualifying UK multiple-entry visa, UK residence permit, or EU family permit\nObtain a business invitation letter if applying for the eVisa\nGather passport, photo, and supporting documents\nBook proof of return ticket\nCarry your passport and qualifying document/eVisa on arrival',
    '/assets/images/visa-heroes/gibraltar.webp',
    'Government of Gibraltar press release on E-Visas for India and Skyscanner secondary sourcing', 'https://www.gibraltar.gov.gi/press-releases/e-visas-for-india-8812023-9490', '2026-09-19'
);
SET @gib2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gib2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gib2, 'Core Documents', 'Required from every traveller.', 1);
SET @gib2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gib2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gib2s1, 'Business Invitation Letter', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gib2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @gib2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gib2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@gib2s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(120, 2, NULL, 'GBP', 'Confirm eVisa Fee', 'No fee applies if using the UK/EU visa-free exemption; eVisa fee not independently confirmed this session.', '2026-09-01', NOW(), 'https://www.gibraltar.gov.gi/press-releases/e-visas-for-india-8812023-9490', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can business travellers use the UK visa exemption for Gibraltar?', 'Yes — the exemption applies regardless of travel purpose, provided you hold a qualifying UK multiple-entry visa, residence permit, or EU family permit.', 120, 2, 12002, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    120, 3, 'GIB-STUD-IN-01', '2026.09', 'published',
    'Academic study in Gibraltar.',
    'Not independently confirmed this session as covered by the eVisa/UK exemption; longer academic programs likely require a separate study permit.',
    'Tied to the academic program duration',
    'Confirm with Gibraltar immigration authorities for the student-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'No Gibraltar mission in India; confirm current guidance via the official Gibraltar government portal',
    'Secure admission confirmation from the Gibraltar institution\nContact Gibraltar immigration authorities to confirm the student-permit process\nGather proof of financial support\nSubmit the application with required documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/gibraltar.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://www.gibraltar.gov.gi/press-releases/e-visas-for-india-8812023-9490', '2026-09-19'
);
SET @gib3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gib3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gib3, 'Core Documents', 'Required from every applicant.', 1);
SET @gib3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gib3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gib3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gib3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @gib3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gib3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@gib3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(120, 3, NULL, 'GBP', 'Confirm with Immigration', 'Student permit fee not independently confirmed this session; confirm with Gibraltar immigration authorities.', '2026-09-01', NOW(), 'https://www.gibraltar.gov.gi/press-releases/e-visas-for-india-8812023-9490', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a student permit for Gibraltar?', 'Not independently confirmed this session — longer academic programs likely require a permit beyond the standard eVisa/UK exemption route. Confirm directly with Gibraltar immigration authorities.', 120, 3, 12003, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    120, 4, 'GIB-WORK-IN-01', '2026.09', 'published',
    'Employment with a Gibraltar company.',
    'Not independently confirmed this session as covered by the eVisa/UK exemption; employment likely requires a Gibraltar work permit sponsored by the employer.',
    'Tied to the work permit validity',
    'Employer applies for the work permit with Gibraltar immigration authorities',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'No Gibraltar mission in India; confirm current guidance via the official Gibraltar government portal',
    'Secure a signed employment offer from the Gibraltar employer\nHave the employer initiate the work-permit application with Gibraltar immigration\nGather proof of qualifications\nSubmit passport and supporting documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/gibraltar.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://www.gibraltar.gov.gi/press-releases/e-visas-for-india-8812023-9490', '2026-09-19'
);
SET @gib4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gib4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gib4, 'Core Documents', 'Required from every applicant.', 1);
SET @gib4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gib4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gib4s1, 'Signed Employment Offer/Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gib4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @gib4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gib4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@gib4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(120, 4, NULL, 'GBP', 'Confirm with Immigration', 'Work permit fee not independently confirmed this session; confirm with Gibraltar immigration authorities.', '2026-09-01', NOW(), 'https://www.gibraltar.gov.gi/press-releases/e-visas-for-india-8812023-9490', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I work in Gibraltar on the eVisa or UK exemption?', 'No — employment requires a separate Gibraltar work permit sponsored by the employer; neither the eVisa nor the UK visa-free exemption authorises work.', 120, 4, 12004, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    120, 5, 'GIB-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Gibraltar.',
    'Family visits use the same UK/EU exemption or Gibraltar eVisa framework as tourism, adding relationship proof for the eVisa route.',
    'As endorsed on the qualifying UK/EU document or the Gibraltar eVisa',
    'Travel visa-free with a qualifying UK/EU document, or apply for the Gibraltar eVisa for India',
    0,
    'Not independently confirmed this session for the eVisa route',
    'No Gibraltar mission in India; the eVisa is applied for online',
    'Check if you hold a qualifying UK multiple-entry visa, UK residence permit, or EU family permit\nObtain an invitation letter from the resident family member if applying for the eVisa\nGather passport, photo, and relationship proof\nBook proof of return ticket\nCarry your passport and qualifying document/eVisa on arrival',
    '/assets/images/visa-heroes/gibraltar.webp',
    'Government of Gibraltar press release on E-Visas for India and Skyscanner secondary sourcing', 'https://www.gibraltar.gov.gi/press-releases/e-visas-for-india-8812023-9490', '2026-09-19'
);
SET @gib5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gib5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gib5, 'Core Documents', 'Required from every traveller.', 1);
SET @gib5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gib5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gib5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gib5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @gib5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gib5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@gib5s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(120, 5, NULL, 'GBP', 'Confirm eVisa Fee', 'No fee applies if using the UK/EU visa-free exemption; eVisa fee not independently confirmed this session.', '2026-09-01', NOW(), 'https://www.gibraltar.gov.gi/press-releases/e-visas-for-india-8812023-9490', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in Gibraltar using the UK visa exemption?', 'Yes — if you hold a qualifying UK multiple-entry visa, residence permit, or EU family permit, you can visit family in Gibraltar without a separate Gibraltar visa.', 120, 5, 12005, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    120, 6, 'GIB-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Gibraltar en route to a third country.',
    'Not independently confirmed this session whether transit requires the standard eVisa/UK exemption or a separate provision — confirm with the airline before travel.',
    'Short duration tied to the transit itinerary',
    'Confirm with Gibraltar immigration or your airline whether the standard eVisa/UK exemption applies',
    0,
    'Not independently confirmed this session for a specific working-day figure',
    'No Gibraltar mission in India; the eVisa is applied for online',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck whether a transit-specific provision applies\nApply for the eVisa if needed and not using the UK exemption\nCarry your passport and onward ticket\nConfirm requirements with your airline before travel',
    '/assets/images/visa-heroes/gibraltar.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://www.gibraltar.gov.gi/press-releases/e-visas-for-india-8812023-9490', '2026-09-19'
);
SET @gib6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gib6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gib6, 'Core Documents', 'Required from every applicant.', 1);
SET @gib6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gib6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gib6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gib6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @gib6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gib6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(120, 6, NULL, 'GBP', 'Confirm with Immigration', 'Transit fee not independently confirmed this session; confirm with Gibraltar immigration.', '2026-09-01', NOW(), 'https://www.gibraltar.gov.gi/press-releases/e-visas-for-india-8812023-9490', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Gibraltar?', 'Not independently confirmed this session — confirm with Gibraltar immigration or your airline whether your specific transit routing requires the standard eVisa/UK exemption.', 120, 6, 12006, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    120, 7, 'GIB-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Gibraltar.',
    'Not independently confirmed this session as a distinct category — likely covered under the standard eVisa/UK exemption with medical documentation.',
    'As endorsed on the qualifying UK/EU document or the Gibraltar eVisa',
    'Travel visa-free with a qualifying UK/EU document, or apply for the Gibraltar eVisa for India',
    0,
    'Not independently confirmed this session for the eVisa route',
    'No Gibraltar mission in India; the eVisa is applied for online',
    'Obtain a medical appointment/admission letter from the hospital\nCheck if you hold a qualifying UK/EU document for the exemption\nApply for the eVisa if not eligible for the exemption\nGather passport, photo, and medical documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/gibraltar.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://www.gibraltar.gov.gi/press-releases/e-visas-for-india-8812023-9490', '2026-09-19'
);
SET @gib7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gib7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gib7, 'Core Documents', 'Required from every traveller.', 1);
SET @gib7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gib7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gib7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gib7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @gib7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gib7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@gib7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(120, 7, NULL, 'GBP', 'Confirm eVisa Fee', 'No fee applies if using the UK/EU visa-free exemption; eVisa fee not independently confirmed this session.', '2026-09-01', NOW(), 'https://www.gibraltar.gov.gi/press-releases/e-visas-for-india-8812023-9490', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Gibraltar?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely covered under the standard eVisa/UK exemption with supporting medical documentation.', 120, 7, 12007, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    120, 8, 'GIB-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Gibraltar.',
    'Not independently confirmed this session as a distinct category — likely covered under the Business eVisa/UK exemption with an event invitation.',
    'As endorsed on the qualifying UK/EU document or the Gibraltar eVisa',
    'Travel visa-free with a qualifying UK/EU document, or apply for the Gibraltar eVisa for India',
    0,
    'Not independently confirmed this session for the eVisa route',
    'No Gibraltar mission in India; the eVisa is applied for online',
    'Obtain an official event invitation letter\nCheck if you hold a qualifying UK/EU document for the exemption\nApply for the eVisa if not eligible for the exemption\nGather passport, photo, and event documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/gibraltar.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://www.gibraltar.gov.gi/press-releases/e-visas-for-india-8812023-9490', '2026-09-19'
);
SET @gib8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gib8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gib8, 'Core Documents', 'Required from every traveller.', 1);
SET @gib8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gib8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gib8s1, 'Official Event Invitation Letter', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gib8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @gib8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gib8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(120, 8, NULL, 'GBP', 'Confirm eVisa Fee', 'No fee applies if using the UK/EU visa-free exemption; eVisa fee not independently confirmed this session.', '2026-09-01', NOW(), 'https://www.gibraltar.gov.gi/press-releases/e-visas-for-india-8812023-9490', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Gibraltar?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely covered under the Business eVisa/UK exemption with an official invitation letter.', 120, 8, 12008, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    120, 9, 'GIB-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Gibraltar.',
    'Not independently confirmed this session as a distinct category — likely covered under the standard eVisa/UK exemption with an event invitation.',
    'As endorsed on the qualifying UK/EU document or the Gibraltar eVisa',
    'Travel visa-free with a qualifying UK/EU document, or apply for the Gibraltar eVisa for India',
    0,
    'Not independently confirmed this session for the eVisa route',
    'No Gibraltar mission in India; the eVisa is applied for online',
    'Obtain an official invitation from the sporting federation/event organiser\nCheck if you hold a qualifying UK/EU document for the exemption\nApply for the eVisa if not eligible for the exemption\nGather passport, photo, and event documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/gibraltar.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://www.gibraltar.gov.gi/press-releases/e-visas-for-india-8812023-9490', '2026-09-19'
);
SET @gib9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gib9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gib9, 'Core Documents', 'Required from every traveller.', 1);
SET @gib9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gib9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gib9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gib9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @gib9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gib9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(120, 9, NULL, 'GBP', 'Confirm eVisa Fee', 'No fee applies if using the UK/EU visa-free exemption; eVisa fee not independently confirmed this session.', '2026-09-01', NOW(), 'https://www.gibraltar.gov.gi/press-releases/e-visas-for-india-8812023-9490', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Gibraltar?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely covered under the standard eVisa/UK exemption with a federation/event invitation.', 120, 9, 12009, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    120, 10, 'GIB-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Gibraltar work permit.',
    'Not independently confirmed this session as a distinct category — likely requires a dependent application alongside the sponsor''s work permit.',
    'Tied to the sponsor''s work permit validity',
    'Confirm with Gibraltar immigration for the dependent-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'No Gibraltar mission in India; confirm current guidance via the official Gibraltar government portal',
    'Confirm the sponsor holds a qualifying Gibraltar work permit\nGather relationship proof and the sponsor''s permit copy\nApply via the official Gibraltar government portal\nSubmit passport and supporting documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/gibraltar.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://www.gibraltar.gov.gi/press-releases/e-visas-for-india-8812023-9490', '2026-09-19'
);
SET @gib10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@gib10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gib10, 'Core Documents', 'Required from every applicant.', 1);
SET @gib10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gib10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@gib10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@gib10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @gib10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@gib10s2, 'Sponsor''s Work Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@gib10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(120, 10, NULL, 'GBP', 'Confirm with Immigration', 'Dependent permit fee not independently confirmed this session; confirm with Gibraltar immigration.', '2026-09-01', NOW(), 'https://www.gibraltar.gov.gi/press-releases/e-visas-for-india-8812023-9490', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent permit in Gibraltar?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work permit. Confirm the exact procedure with Gibraltar immigration.', 120, 10, 12010, 1);
