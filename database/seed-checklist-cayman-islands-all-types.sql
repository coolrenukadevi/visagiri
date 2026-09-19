-- Cayman Islands Visa Checklist Engine content for all 10 visa types —
-- built fresh this session via web search.
--
-- Cayman Islands' real, distinctive facts verified this session:
--   - Indian citizens require a visa in advance, applied online via
--     the official Cayman Islands Customs and Border Control (CBC)
--     Visitor Visa Online Application (cbc.gov.ky) — no in-person
--     embassy visit needed for the standard route.
--   - Exception: if you hold a valid US, UK, or Canadian visa, no
--     separate Cayman visa is needed — but you must enter the Cayman
--     Islands directly from the country where that visa was issued,
--     and the stay is capped at 30 days.
--   - Fee: CI$92.00 / USD 112.20, non-refundable, paid by credit/debit
--     card (American Express not accepted).
--   - Processing: typically 7-10 working days.
--
-- country_id 160 = Cayman Islands. visa_type_id: 1=Tourist, 2=Business,
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
    160, 1, 'CYM-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to the Cayman Islands.',
    'Indian citizens need a visitor visa in advance, applied online — unless holding a valid US, UK, or Canadian visa and entering directly from that country (max 30 days in that case).',
    'As endorsed on the visa (typically up to 30 days for the visa-exempt US/UK/Canada route)',
    'Apply online at cbc.gov.ky, or travel visa-free with a qualifying US/UK/Canada visa entered directly from that country',
    0,
    'Typically 7-10 working days',
    'Cayman Islands Customs and Border Control (CBC) Visa Office (online application)',
    'Check if you qualify for the US/UK/Canada visa exemption (must enter directly from that country)\nIf not, complete the Visitor Visa Online Application at cbc.gov.ky\nUpload passport, photo, and proof of sufficient funds\nPay the non-refundable visa fee by credit/debit card\nReceive your visa approval before travel',
    '/assets/images/visa-heroes/cayman-islands.webp',
    'Official Cayman Islands CBC visa guidance (cbc.gov.ky) and Atlys/Cayman Resident secondary sourcing', 'https://gov.ky/web/cbc/travel/visas-extensions/visitors-visas/visitor-visa-application', '2026-09-19'
);
SET @cym1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cym1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cym1, 'Core Documents', 'Required from every applicant.', 1);
SET @cym1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cym1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cym1s1, 'Recent Passport-Size Photograph', NULL, 'copy', 1, 0, 1, 2),
(@cym1s1, 'Completed Online Visitor Visa Application', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cym1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @cym1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cym1s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@cym1s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2),
(@cym1s2, 'Proof of Accommodation Booking', NULL, 'copy', 1, 0, 0, 3),
(@cym1s2, 'Valid US/UK/Canada Visa (If Using the Exemption Route)', NULL, 'copy', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(160, 1, 112.20, 'USD', 'Visitor Visa Application Fee', 'Non-refundable, equivalent to CI$92.00. Paid by credit/debit card only (American Express not accepted). Waived if using the US/UK/Canada visa exemption route.', '2026-01-01', NOW(), 'https://gov.ky/web/cbc/travel/visas-extensions/visitors-visas/visitor-visa-application', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for the Cayman Islands?', 'Yes, in most cases — apply online via the official CBC Visitor Visa Application. However, if you hold a valid US, UK, or Canadian visa and enter directly from that country, you can travel without a separate Cayman visa for up to 30 days.', 160, 1, 16000, 1),
('How much does the Cayman Islands visitor visa cost?', 'The fee is CI$92.00 (USD 112.20), non-refundable, paid by credit or debit card (American Express is not accepted).', 160, 1, 16001, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    160, 2, 'CYM-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in the Cayman Islands.',
    'Business travellers use the same visitor visa framework as tourists, adding a business invitation letter.',
    'As endorsed on the visa (typically up to 30 days for the visa-exempt US/UK/Canada route)',
    'Apply online at cbc.gov.ky, or travel visa-free with a qualifying US/UK/Canada visa entered directly from that country',
    0,
    'Typically 7-10 working days',
    'Cayman Islands Customs and Border Control (CBC) Visa Office (online application)',
    'Check if you qualify for the US/UK/Canada visa exemption\nObtain a business invitation letter\nComplete the Visitor Visa Online Application at cbc.gov.ky\nPay the non-refundable visa fee by credit/debit card\nReceive your visa approval before travel',
    '/assets/images/visa-heroes/cayman-islands.webp',
    'Official Cayman Islands CBC visa guidance (cbc.gov.ky) and Atlys/Cayman Resident secondary sourcing', 'https://gov.ky/web/cbc/travel/visas-extensions/visitors-visas/visitor-visa-application', '2026-09-19'
);
SET @cym2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cym2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cym2, 'Core Documents', 'Required from every applicant.', 1);
SET @cym2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cym2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cym2s1, 'Business Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cym2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @cym2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cym2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@cym2s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(160, 2, 112.20, 'USD', 'Visitor Visa Application Fee', 'Non-refundable, equivalent to CI$92.00. Waived if using the US/UK/Canada visa exemption route.', '2026-01-01', NOW(), 'https://gov.ky/web/cbc/travel/visas-extensions/visitors-visas/visitor-visa-application', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can business travellers use the US/UK/Canada visa exemption?', 'Yes — the exemption applies regardless of purpose, provided you hold a valid qualifying visa and enter the Cayman Islands directly from that country, for a stay of up to 30 days.', 160, 2, 16002, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    160, 3, 'CYM-STUD-IN-01', '2026.09', 'published',
    'Academic study in the Cayman Islands.',
    'Not independently confirmed this session as covered by the standard visitor visa; longer academic programs likely require a student permit from CBC.',
    'Tied to the academic program duration',
    'Confirm with Cayman Islands CBC for the student-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Cayman Islands Customs and Border Control (CBC) Visa Office',
    'Secure admission confirmation from the Cayman Islands institution\nContact CBC to confirm the student-permit process\nGather proof of financial support\nSubmit the permit application with required documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/cayman-islands.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://gov.ky/web/cbc/travel/visas-extensions/visitors-visas/visitor-visa-application', '2026-09-19'
);
SET @cym3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cym3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cym3, 'Core Documents', 'Required from every applicant.', 1);
SET @cym3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cym3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cym3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cym3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @cym3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cym3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@cym3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(160, 3, NULL, 'USD', 'Confirm with CBC', 'Student permit fee not independently confirmed this session; confirm with Cayman Islands CBC.', '2026-09-01', NOW(), 'https://gov.ky/web/cbc/travel/visas-extensions/visitors-visas/visitor-visa-application', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a student permit for the Cayman Islands?', 'Not independently confirmed this session — longer academic programs likely require a permit from CBC beyond the standard visitor visa. Confirm directly with CBC.', 160, 3, 16003, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    160, 4, 'CYM-WORK-IN-01', '2026.09', 'published',
    'Employment with a Cayman Islands company.',
    'The Cayman Islands offers a distinct Visitor''s Work Visa category for short-term work, alongside longer-term employer-sponsored work permits.',
    'Tied to the work visa/permit validity',
    'Employer typically applies for the Visitor''s Work Visa or work permit via Cayman Islands CBC',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Cayman Islands Customs and Border Control (CBC) Visa Office',
    'Secure a signed employment offer from the Cayman Islands employer\nHave the employer initiate the Visitor''s Work Visa or work permit application with CBC\nGather proof of qualifications\nSubmit passport and supporting documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/cayman-islands.webp',
    'Official Cayman Islands CBC Visitor''s Work Visa guidance', 'https://gov.ky/web/cbc/travel/visas-extensions/visitors-visas/visitor-work-visa', '2026-09-19'
);
SET @cym4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cym4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cym4, 'Core Documents', 'Required from every applicant.', 1);
SET @cym4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cym4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cym4s1, 'Signed Employment Offer/Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cym4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @cym4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cym4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@cym4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(160, 4, NULL, 'USD', 'Confirm with CBC', 'Work visa/permit fee not independently confirmed this session; confirm with Cayman Islands CBC.', '2026-09-01', NOW(), 'https://gov.ky/web/cbc/travel/visas-extensions/visitors-visas/visitor-work-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a specific short-term work visa for the Cayman Islands?', 'Yes — the Cayman Islands offers a Visitor''s Work Visa for short-term work, in addition to longer-term employer-sponsored work permits.', 160, 4, 16004, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    160, 5, 'CYM-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in the Cayman Islands.',
    'Family visits use the same visitor visa framework as tourism, adding relationship proof and an invitation letter.',
    'As endorsed on the visa (typically up to 30 days for the visa-exempt US/UK/Canada route)',
    'Apply online at cbc.gov.ky, or travel visa-free with a qualifying US/UK/Canada visa entered directly from that country',
    0,
    'Typically 7-10 working days',
    'Cayman Islands Customs and Border Control (CBC) Visa Office (online application)',
    'Check if you qualify for the US/UK/Canada visa exemption\nObtain an invitation letter from the resident family member\nComplete the Visitor Visa Online Application at cbc.gov.ky\nPay the non-refundable visa fee by credit/debit card\nReceive your visa approval before travel',
    '/assets/images/visa-heroes/cayman-islands.webp',
    'Official Cayman Islands CBC visa guidance (cbc.gov.ky) and Atlys/Cayman Resident secondary sourcing', 'https://gov.ky/web/cbc/travel/visas-extensions/visitors-visas/visitor-visa-application', '2026-09-19'
);
SET @cym5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cym5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cym5, 'Core Documents', 'Required from every applicant.', 1);
SET @cym5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cym5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cym5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cym5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @cym5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cym5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@cym5s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(160, 5, 112.20, 'USD', 'Visitor Visa Application Fee', 'Non-refundable, equivalent to CI$92.00. Waived if using the US/UK/Canada visa exemption route.', '2026-01-01', NOW(), 'https://gov.ky/web/cbc/travel/visas-extensions/visitors-visas/visitor-visa-application', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in the Cayman Islands using the visa exemption?', 'Yes — if you hold a qualifying US, UK, or Canadian visa and enter directly from that country, you can visit family for up to 30 days without a separate Cayman visa.', 160, 5, 16005, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    160, 6, 'CYM-TRAN-IN-01', '2026.09', 'published',
    'Transiting through the Cayman Islands en route to a third country.',
    'Not independently confirmed this session whether transit requires the standard visitor visa or a separate provision — confirm with the airline before travel.',
    'Short duration tied to the transit itinerary',
    'Confirm with Cayman Islands CBC or your airline whether the standard visitor visa applies',
    0,
    'Not independently confirmed this session for a specific working-day figure',
    'Cayman Islands Customs and Border Control (CBC) Visa Office',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck whether a transit-specific provision applies\nApply via cbc.gov.ky if needed\nUpload passport, photo, and onward ticket\nConfirm requirements with your airline before travel',
    '/assets/images/visa-heroes/cayman-islands.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://gov.ky/web/cbc/travel/visas-extensions/visitors-visas/visitor-visa-application', '2026-09-19'
);
SET @cym6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cym6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cym6, 'Core Documents', 'Required from every applicant.', 1);
SET @cym6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cym6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cym6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cym6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @cym6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cym6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(160, 6, NULL, 'USD', 'Confirm with CBC', 'Transit fee not independently confirmed this session; confirm with Cayman Islands CBC.', '2026-09-01', NOW(), 'https://gov.ky/web/cbc/travel/visas-extensions/visitors-visas/visitor-visa-application', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through the Cayman Islands?', 'Not independently confirmed this session — confirm with Cayman Islands CBC or your airline whether your specific transit routing requires the standard visitor visa.', 160, 6, 16006, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    160, 7, 'CYM-MED-IN-01', '2026.09', 'published',
    'Medical treatment in the Cayman Islands.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard visitor visa with medical documentation.',
    'As endorsed on the visa (typically up to 30 days for the visa-exempt US/UK/Canada route)',
    'Apply online via the official Visitor Visa Online Application at cbc.gov.ky',
    0,
    'Typically 7-10 working days',
    'Cayman Islands Customs and Border Control (CBC) Visa Office (online application)',
    'Obtain a medical appointment/admission letter from the hospital\nComplete the Visitor Visa Online Application at cbc.gov.ky\nUpload passport, photo, and medical documents\nPay the non-refundable visa fee by credit/debit card\nReceive your visa approval before travel',
    '/assets/images/visa-heroes/cayman-islands.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://gov.ky/web/cbc/travel/visas-extensions/visitors-visas/visitor-visa-application', '2026-09-19'
);
SET @cym7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cym7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cym7, 'Core Documents', 'Required from every applicant.', 1);
SET @cym7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cym7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cym7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cym7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @cym7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cym7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@cym7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(160, 7, 112.20, 'USD', 'Visitor Visa Application Fee', 'Non-refundable, equivalent to CI$92.00.', '2026-01-01', NOW(), 'https://gov.ky/web/cbc/travel/visas-extensions/visitors-visas/visitor-visa-application', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for the Cayman Islands?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the standard visitor visa with supporting medical documentation.', 160, 7, 16007, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    160, 8, 'CYM-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in the Cayman Islands.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the Business visitor visa framework with an event invitation.',
    'As endorsed on the visa (typically up to 30 days for the visa-exempt US/UK/Canada route)',
    'Apply online via the official Visitor Visa Online Application at cbc.gov.ky',
    0,
    'Typically 7-10 working days',
    'Cayman Islands Customs and Border Control (CBC) Visa Office (online application)',
    'Obtain an official event invitation letter\nComplete the Visitor Visa Online Application at cbc.gov.ky\nUpload passport, photo, and event documents\nPay the non-refundable visa fee by credit/debit card\nReceive your visa approval before travel',
    '/assets/images/visa-heroes/cayman-islands.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://gov.ky/web/cbc/travel/visas-extensions/visitors-visas/visitor-visa-application', '2026-09-19'
);
SET @cym8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cym8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cym8, 'Core Documents', 'Required from every applicant.', 1);
SET @cym8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cym8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cym8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cym8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @cym8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cym8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(160, 8, 112.20, 'USD', 'Visitor Visa Application Fee', 'Non-refundable, equivalent to CI$92.00.', '2026-01-01', NOW(), 'https://gov.ky/web/cbc/travel/visas-extensions/visitors-visas/visitor-visa-application', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for the Cayman Islands?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business visitor visa framework with an official invitation letter.', 160, 8, 16008, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    160, 9, 'CYM-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in the Cayman Islands.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard visitor visa with an event invitation.',
    'As endorsed on the visa (typically up to 30 days for the visa-exempt US/UK/Canada route)',
    'Apply online via the official Visitor Visa Online Application at cbc.gov.ky',
    0,
    'Typically 7-10 working days',
    'Cayman Islands Customs and Border Control (CBC) Visa Office (online application)',
    'Obtain an official invitation from the sporting federation/event organiser\nComplete the Visitor Visa Online Application at cbc.gov.ky\nUpload passport, photo, and event documents\nPay the non-refundable visa fee by credit/debit card\nReceive your visa approval before travel',
    '/assets/images/visa-heroes/cayman-islands.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://gov.ky/web/cbc/travel/visas-extensions/visitors-visas/visitor-visa-application', '2026-09-19'
);
SET @cym9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cym9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cym9, 'Core Documents', 'Required from every applicant.', 1);
SET @cym9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cym9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cym9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cym9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @cym9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cym9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(160, 9, 112.20, 'USD', 'Visitor Visa Application Fee', 'Non-refundable, equivalent to CI$92.00.', '2026-01-01', NOW(), 'https://gov.ky/web/cbc/travel/visas-extensions/visitors-visas/visitor-visa-application', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for the Cayman Islands?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the standard visitor visa with a federation/event invitation.', 160, 9, 16009, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    160, 10, 'CYM-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Cayman Islands work permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent application alongside the sponsor''s work permit.',
    'Tied to the sponsor''s work permit validity',
    'Confirm with Cayman Islands CBC for the dependent-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Cayman Islands Customs and Border Control (CBC) Visa Office',
    'Confirm the sponsor holds a qualifying Cayman Islands work permit\nGather relationship proof and the sponsor''s permit copy\nApply via Cayman Islands CBC\nSubmit passport and supporting documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/cayman-islands.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://gov.ky/web/cbc/travel/visas-extensions/visitors-visas/visitor-visa-application', '2026-09-19'
);
SET @cym10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cym10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cym10, 'Core Documents', 'Required from every applicant.', 1);
SET @cym10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cym10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cym10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cym10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @cym10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cym10s2, 'Sponsor''s Cayman Islands Work Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@cym10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(160, 10, NULL, 'USD', 'Confirm with CBC', 'Dependent permit fee not independently confirmed this session; confirm with Cayman Islands CBC.', '2026-09-01', NOW(), 'https://gov.ky/web/cbc/travel/visas-extensions/visitors-visas/visitor-visa-application', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent permit in the Cayman Islands?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work permit. Confirm the exact procedure with Cayman Islands CBC.', 160, 10, 16010, 1);
