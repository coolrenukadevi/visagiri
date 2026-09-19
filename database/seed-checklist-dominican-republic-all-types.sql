-- Dominican Republic Visa Checklist Engine content for all 10 visa
-- types — built fresh this session via web search.
--
-- Dominican Republic's real, distinctive facts verified this session:
--   - Indian citizens require an embassy visa — no eVisa or
--     visa-on-arrival is offered. Exception: Indians holding a valid
--     multiple-entry US, Canada, UK, or Schengen visa can instead
--     obtain a tourist card on arrival.
--   - Fee (embassy visa): USD 100 single-entry / USD 200
--     multiple-entry (approx INR 8,400-12,600). Payment only via bank
--     transfer to the Embassy's DBS bank account — no cash/card at
--     the counter.
--   - Processing: ~21 working days overall (7-10 days at the embassy
--     itself, plus Ministry of Foreign Affairs review); apply 6-8
--     weeks before travel.
--   - Distinctive universal requirement: ALL travellers, regardless
--     of visa route, must complete a mandatory electronic "E-Ticket"
--     entry form before departure to get a QR code for airport
--     scanning.
--   - Applications via the Embassy of the Dominican Republic in New
--     Delhi, VFS Global, or authorised travel agents.
--
-- country_id 164 = Dominican Republic. visa_type_id: 1=Tourist,
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
    164, 1, 'DOM-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to the Dominican Republic.',
    'Indian citizens require an embassy visa — no eVisa or visa-on-arrival exists. Exception: holders of a valid multiple-entry US/Canada/UK/Schengen visa can instead get a tourist card on arrival.',
    'As endorsed on the visa or tourist card',
    'Apply at the Embassy of the Dominican Republic in New Delhi, or get a tourist card with a qualifying US/Canada/UK/Schengen visa',
    1,
    'Approximately 21 working days overall (7-10 days at the embassy plus Ministry review); apply 6-8 weeks before travel',
    'Embassy of the Dominican Republic, New Delhi (applications also via VFS Global)',
    'Check if you hold a qualifying US/Canada/UK/Schengen visa for the tourist-card exception\nIf not, apply at the Embassy of the Dominican Republic in New Delhi or via VFS Global\nComplete the mandatory electronic E-Ticket entry form before departure\nPay the visa fee only via bank transfer to the Embassy''s DBS bank account\nCarry the QR code from the E-Ticket alongside your passport and visa',
    '/assets/images/visa-heroes/dominican-republic.webp',
    'BTW Visas and Atlys secondary sourcing', 'https://btwvisas.com/visa-guide/dominican-republic-visa/', '2026-09-19'
);
SET @dom1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dom1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dom1, 'Core Documents', 'Required from every applicant.', 1);
SET @dom1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dom1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@dom1s1, 'Completed Visa Application Form', NULL, 'original', 1, 0, 1, 2),
(@dom1s1, 'Mandatory E-Ticket Entry Form Confirmation (QR Code)', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dom1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @dom1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dom1s2, 'Valid US/Canada/UK/Schengen Multiple-Entry Visa (If Using Tourist-Card Exception)', NULL, 'copy', 0, 1, 0, 1),
(@dom1s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2),
(@dom1s2, 'Proof of Accommodation Booking', NULL, 'copy', 1, 0, 0, 3),
(@dom1s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(164, 1, 100.00, 'USD', 'Single-Entry Visa Fee', 'Multiple-entry is USD 200 (approx INR 8,400-12,600). Payment accepted only via bank transfer to the Embassy''s DBS bank account.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/dominican-republic-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for the Dominican Republic?', 'Yes — an embassy visa is required, applied for at the Embassy of the Dominican Republic in New Delhi or via VFS Global. If you hold a valid multiple-entry US, Canada, UK, or Schengen visa, you can instead get a tourist card on arrival.', 164, 1, 16400, 1),
('What is the mandatory E-Ticket for the Dominican Republic?', 'All travellers, regardless of visa route, must complete an electronic entry form before departure and carry the resulting QR code for airport scanning on arrival.', 164, 1, 16401, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    164, 2, 'DOM-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in the Dominican Republic.',
    'Business travellers apply through the same embassy process as tourists, adding a business invitation letter; the tourist-card exception applies here too.',
    'As endorsed on the visa or tourist card',
    'Apply at the Embassy of the Dominican Republic in New Delhi, or get a tourist card with a qualifying US/Canada/UK/Schengen visa',
    1,
    'Approximately 21 working days overall; apply 6-8 weeks before travel',
    'Embassy of the Dominican Republic, New Delhi (applications also via VFS Global)',
    'Check if you hold a qualifying US/Canada/UK/Schengen visa for the tourist-card exception\nObtain a business invitation letter\nApply at the Embassy of the Dominican Republic or via VFS Global\nComplete the mandatory electronic E-Ticket entry form before departure\nPay the visa fee via bank transfer to the Embassy''s DBS bank account',
    '/assets/images/visa-heroes/dominican-republic.webp',
    'BTW Visas and Atlys secondary sourcing', 'https://btwvisas.com/visa-guide/dominican-republic-visa/', '2026-09-19'
);
SET @dom2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dom2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dom2, 'Core Documents', 'Required from every applicant.', 1);
SET @dom2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dom2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@dom2s1, 'Business Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dom2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @dom2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dom2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@dom2s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(164, 2, 200.00, 'USD', 'Multiple-Entry Visa Fee', 'Single-entry is USD 100. Payment accepted only via bank transfer to the Embassy''s DBS bank account.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/dominican-republic-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Should business travellers use the multiple-entry visa?', 'If you expect repeat trips to the Dominican Republic, the multiple-entry visa (USD 200) may be more convenient than single-entry (USD 100) — though the tourist-card exception may avoid needing an embassy visa at all.', 164, 2, 16402, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    164, 3, 'DOM-STUD-IN-01', '2026.09', 'published',
    'Academic study in the Dominican Republic.',
    'Not independently confirmed this session as a distinct standard category; likely requires a residency-linked student visa beyond the standard tourist visa.',
    'Tied to the academic program duration',
    'Apply at the Embassy of the Dominican Republic in New Delhi',
    1,
    'Not independently confirmed this session for a specific working-day figure beyond the standard ~21 working days',
    'Embassy of the Dominican Republic, New Delhi',
    'Secure admission confirmation from the Dominican institution\nApply at the Embassy of the Dominican Republic in New Delhi\nGather proof of financial support\nComplete the mandatory electronic E-Ticket entry form before departure\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/dominican-republic.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/dominican-republic-visa/', '2026-09-19'
);
SET @dom3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dom3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dom3, 'Core Documents', 'Required from every applicant.', 1);
SET @dom3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dom3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@dom3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dom3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @dom3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dom3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@dom3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(164, 3, NULL, 'USD', 'Confirm at Embassy', 'Student visa fee not independently confirmed this session; confirm with the Embassy of the Dominican Republic.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/dominican-republic-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate student visa for the Dominican Republic?', 'Not independently confirmed this session — longer academic programs likely require a residency-linked student visa beyond the standard tourist visa. Confirm with the Embassy of the Dominican Republic.', 164, 3, 16403, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    164, 4, 'DOM-WORK-IN-01', '2026.09', 'published',
    'Employment with a Dominican Republic company.',
    'Not independently confirmed this session as a distinct standard category; likely requires an employer-sponsored work visa/residency permit beyond the standard tourist visa.',
    'Tied to the employment contract duration',
    'Confirm with the employer and the Embassy of the Dominican Republic for the work-visa process',
    1,
    'Not independently confirmed this session for a specific working-day figure beyond the standard ~21 working days',
    'Embassy of the Dominican Republic, New Delhi',
    'Secure a signed employment contract from the Dominican Republic employer\nApply at the Embassy of the Dominican Republic in New Delhi\nGather proof of qualifications\nComplete the mandatory electronic E-Ticket entry form before departure\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/dominican-republic.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/dominican-republic-visa/', '2026-09-19'
);
SET @dom4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dom4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dom4, 'Core Documents', 'Required from every applicant.', 1);
SET @dom4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dom4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@dom4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dom4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @dom4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dom4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@dom4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(164, 4, NULL, 'USD', 'Confirm at Embassy', 'Work visa fee not independently confirmed this session; confirm with the Embassy of the Dominican Republic.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/dominican-republic-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a work visa for the Dominican Republic beyond the tourist visa?', 'Not independently confirmed this session — employment likely requires a separate employer-sponsored work visa/residency permit. Confirm with the Embassy of the Dominican Republic.', 164, 4, 16404, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    164, 5, 'DOM-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in the Dominican Republic.',
    'Family visits use the same embassy application process as tourism, adding an invitation letter and relationship proof; the tourist-card exception applies here too.',
    'As endorsed on the visa or tourist card',
    'Apply at the Embassy of the Dominican Republic in New Delhi, or use the tourist card if holding a qualifying US/Canada/UK/Schengen visa',
    1,
    'Approximately 21 working days overall; apply 6-8 weeks before travel',
    'Embassy of the Dominican Republic, New Delhi (applications also via VFS Global)',
    'Check if you hold a qualifying US/Canada/UK/Schengen visa for the tourist-card exception\nObtain an invitation letter from the family member resident in the Dominican Republic\nApply at the Embassy of the Dominican Republic if not eligible for the exception\nComplete the mandatory electronic E-Ticket entry form before departure\nCarry passport, visa/tourist card, and relationship proof',
    '/assets/images/visa-heroes/dominican-republic.webp',
    'BTW Visas and Atlys secondary sourcing', 'https://btwvisas.com/visa-guide/dominican-republic-visa/', '2026-09-19'
);
SET @dom5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dom5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dom5, 'Core Documents', 'Required from every applicant.', 1);
SET @dom5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dom5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@dom5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dom5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @dom5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dom5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@dom5s2, 'Proof of Return Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(164, 5, 100.00, 'USD', 'Single-Entry Visa Fee', 'Multiple-entry is USD 200. Payment accepted only via bank transfer to the Embassy''s DBS bank account.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/dominican-republic-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in the Dominican Republic on the tourist card?', 'Yes — if you hold a qualifying multiple-entry US, Canada, UK, or Schengen visa, you can obtain the tourist card on arrival instead of an embassy visa.', 164, 5, 16405, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    164, 6, 'DOM-TRAN-IN-01', '2026.09', 'published',
    'Transiting through the Dominican Republic en route to a third country.',
    'Not independently confirmed this session whether transit requires the standard visa or a separate provision — confirm with the airline before travel.',
    'Short duration tied to the transit itinerary',
    'Confirm with the Embassy of the Dominican Republic or your airline whether the standard visa applies',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Embassy of the Dominican Republic, New Delhi',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck whether a transit-specific visa is required\nContact the Embassy of the Dominican Republic if needed\nComplete the mandatory electronic E-Ticket entry form if disembarking\nConfirm requirements with your airline before travel',
    '/assets/images/visa-heroes/dominican-republic.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/dominican-republic-visa/', '2026-09-19'
);
SET @dom6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dom6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dom6, 'Core Documents', 'Required from every applicant.', 1);
SET @dom6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dom6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@dom6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dom6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @dom6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dom6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(164, 6, NULL, 'USD', 'Confirm at Embassy', 'Transit fee not independently confirmed this session; confirm with the Embassy of the Dominican Republic.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/dominican-republic-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through the Dominican Republic?', 'Not independently confirmed this session — confirm with the Embassy of the Dominican Republic or your airline whether your specific transit routing requires the standard visa.', 164, 6, 16406, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    164, 7, 'DOM-MED-IN-01', '2026.09', 'published',
    'Medical treatment in the Dominican Republic.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard visa/tourist-card route with medical documentation.',
    'As endorsed on the visa or tourist card',
    'Apply at the Embassy of the Dominican Republic in New Delhi, or use the tourist card if holding a qualifying US/Canada/UK/Schengen visa',
    1,
    'Approximately 21 working days overall; apply 6-8 weeks before travel',
    'Embassy of the Dominican Republic, New Delhi (applications also via VFS Global)',
    'Obtain a medical appointment/admission letter from the hospital\nCheck if you hold a qualifying US/Canada/UK/Schengen visa for the tourist-card exception\nApply at the Embassy of the Dominican Republic if not eligible for the exception\nComplete the mandatory electronic E-Ticket entry form before departure\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/dominican-republic.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/dominican-republic-visa/', '2026-09-19'
);
SET @dom7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dom7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dom7, 'Core Documents', 'Required from every applicant.', 1);
SET @dom7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dom7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@dom7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dom7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @dom7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dom7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@dom7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(164, 7, 100.00, 'USD', 'Single-Entry Visa Fee', 'Multiple-entry is USD 200. Payment accepted only via bank transfer to the Embassy''s DBS bank account.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/dominican-republic-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for the Dominican Republic?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the standard visa/tourist-card route with supporting medical documentation.', 164, 7, 16407, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    164, 8, 'DOM-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in the Dominican Republic.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the Business visa framework with an event invitation.',
    'As endorsed on the visa or tourist card',
    'Apply at the Embassy of the Dominican Republic in New Delhi, or use the tourist card if holding a qualifying US/Canada/UK/Schengen visa',
    1,
    'Approximately 21 working days overall; apply 6-8 weeks before travel',
    'Embassy of the Dominican Republic, New Delhi (applications also via VFS Global)',
    'Obtain an official event invitation letter\nCheck if you hold a qualifying US/Canada/UK/Schengen visa for the tourist-card exception\nApply at the Embassy of the Dominican Republic if not eligible for the exception\nComplete the mandatory electronic E-Ticket entry form before departure\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/dominican-republic.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/dominican-republic-visa/', '2026-09-19'
);
SET @dom8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dom8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dom8, 'Core Documents', 'Required from every applicant.', 1);
SET @dom8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dom8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@dom8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dom8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @dom8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dom8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(164, 8, 100.00, 'USD', 'Single-Entry Visa Fee', 'Multiple-entry is USD 200. Payment accepted only via bank transfer to the Embassy''s DBS bank account.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/dominican-republic-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for the Dominican Republic?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business visa framework with an official invitation letter.', 164, 8, 16408, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    164, 9, 'DOM-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in the Dominican Republic.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard visa with an event invitation.',
    'As endorsed on the visa or tourist card',
    'Apply at the Embassy of the Dominican Republic in New Delhi, or use the tourist card if holding a qualifying US/Canada/UK/Schengen visa',
    1,
    'Approximately 21 working days overall; apply 6-8 weeks before travel',
    'Embassy of the Dominican Republic, New Delhi (applications also via VFS Global)',
    'Obtain an official invitation from the sporting federation/event organiser\nCheck if you hold a qualifying US/Canada/UK/Schengen visa for the tourist-card exception\nApply at the Embassy of the Dominican Republic if not eligible for the exception\nComplete the mandatory electronic E-Ticket entry form before departure\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/dominican-republic.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/dominican-republic-visa/', '2026-09-19'
);
SET @dom9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dom9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dom9, 'Core Documents', 'Required from every applicant.', 1);
SET @dom9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dom9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@dom9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dom9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @dom9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dom9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(164, 9, 100.00, 'USD', 'Single-Entry Visa Fee', 'Multiple-entry is USD 200. Payment accepted only via bank transfer to the Embassy''s DBS bank account.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/dominican-republic-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for the Dominican Republic?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the standard visa with a federation/event invitation.', 164, 9, 16409, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    164, 10, 'DOM-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Dominican Republic work or residence permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent application alongside the sponsor''s permit.',
    'Tied to the sponsor''s permit validity',
    'Confirm with the Embassy of the Dominican Republic for the dependent-visa process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Embassy of the Dominican Republic, New Delhi',
    'Confirm the sponsor holds a qualifying work/residence permit\nGather relationship proof and the sponsor''s permit copy\nApply at the Embassy of the Dominican Republic\nComplete the mandatory electronic E-Ticket entry form before departure\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/dominican-republic.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://btwvisas.com/visa-guide/dominican-republic-visa/', '2026-09-19'
);
SET @dom10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dom10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dom10, 'Core Documents', 'Required from every applicant.', 1);
SET @dom10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dom10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@dom10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dom10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @dom10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dom10s2, 'Sponsor''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@dom10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(164, 10, NULL, 'USD', 'Confirm at Embassy', 'Dependent visa fee not independently confirmed this session; confirm with the Embassy of the Dominican Republic.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/dominican-republic-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent visa in the Dominican Republic?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence permit. Confirm the exact procedure with the Embassy of the Dominican Republic.', 164, 10, 16410, 1);
