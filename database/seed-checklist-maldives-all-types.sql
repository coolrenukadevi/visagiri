-- Maldives Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search. hero_image_url left NULL at
-- authoring time, wired to the real supplied photo during the apply
-- step.
--
-- IMPORTANT SOURCING CAVEAT: imuga.immigration.gov.mv was not directly
-- fetchable this session (network egress blocked) — findings
-- triangulated from web-search-indexed news and travel-advisory
-- secondary sourcing.
--
-- Maldives' real, distinctive facts:
--   - Nearly universal visa-free entry: all nationalities, including
--     Indians, get a free 30-day (extendable up to 90-day) Tourist entry
--     on arrival, gated by the mandatory online IMUGA "Traveller
--     Declaration" (submitted within 96 hours of arrival) rather than a
--     conventional visa application.
--   - The 2024 India-Maldives diplomatic row (triggered by disparaging
--     remarks about Indian PM Modi from Maldivian officials, followed by
--     a documented tourism boycott sentiment in India) is confirmed to
--     NOT have changed visa policy itself — it affected travel demand
--     and political sentiment, not the legal visa framework, and this
--     file states that distinction explicitly rather than implying any
--     policy tightening that didn't occur.
--   - Work visas run through a genuinely three-layer system: Employment
--     Approval (EA) from the Ministry of Economic Development, work
--     permit quota/registration via PFED (Ministry's Expatriate
--     division), and the "Xpat" online system used for the actual
--     permit issuance/tracking — modeled here as one combined workflow
--     since Indian workers experience it as a single employer-driven
--     process even though three separate government touchpoints exist.
--   - As of November 2025, Maldives has been shifting to a fully digital
--     e-Visa/facial-recognition border system, progressively phasing out
--     physical visa stickers — noted in the processing fields as a
--     recent operational change rather than baked silently into fee/
--     process descriptions.
--
-- country_id 81 = Maldives. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Free 30-Day Visa on Arrival
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    81, 1, 'MDV-TOUR-IN-01', '2026.09', 'published',
    'Leisure and resort travel to the Maldives.',
    'All Indian nationals — free 30-day visa on arrival, extendable up to 90 days, gated by the mandatory online IMUGA Traveller Declaration rather than a pre-approval visa application.',
    'Up to 30 days on arrival, extendable to a total of 90 days',
    'Submit the IMUGA Traveller Declaration online within 96 hours before arrival; visa is granted on arrival at immigration',
    0,
    'Immediate at the border once the IMUGA declaration is on file; the border system has been progressively shifting to e-Visa/facial-recognition processing since November 2025, phasing out physical visa stickers',
    'Not applicable — visa on arrival, no consulate visit required',
    'Complete the IMUGA Traveller Declaration online (passport, accommodation, and flight details) within 96 hours of arrival\nPresent your passport and IMUGA confirmation at immigration on arrival\nReceive your visa on arrival, valid for up to 30 days',
    '/assets/images/visa-heroes/maldives.jpg',
    'Cross-checked against IMUGA system guidance and 2025-2026 border-digitization reporting, triangulated against secondary travel-advisory sourcing not directly fetchable this session', 'https://immigration.gov.mv/', '2026-09-11'
);
SET @mv1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mv1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mv1, 'Core Documents', 'Required from every traveller.', 1);
SET @mv1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mv1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@mv1s1, 'IMUGA Traveller Declaration Confirmation', 'Submitted online within 96 hours before arrival.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mv1, 'Supporting Documents', 'Evidence of your accommodation and onward travel.', 2);
SET @mv1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mv1s2, 'Confirmed Resort/Hotel Booking', NULL, 'copy', 1, 0, 0, 1),
(@mv1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(81, 1, 0.00, 'INR', 'No Visa Fee', 'Free 30-day visa on arrival for all nationalities, extendable up to 90 days; the only requirement is the online IMUGA Traveller Declaration.', '2026-09-01', NOW(), 'https://immigration.gov.mv/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indians need a visa in advance for the Maldives?', 'No — Indian citizens receive a free visa on arrival for up to 30 days. You only need to complete the online IMUGA Traveller Declaration within 96 hours before arrival.', 81, 1, 8100, 1),
('Did the 2024 India-Maldives diplomatic tension change the visa policy?', 'No — the diplomatic tension affected travel demand and political sentiment, not the legal visa framework itself. The free visa-on-arrival policy for Indians has remained unchanged throughout.', 81, 1, 8101, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    81, 2, 'MDV-BUS-IN-02', '2026.09', 'published',
    'Trade, investment exploration, and commercial meetings in the Maldives.',
    'Indian nationals travelling for business purposes; typically covered under the same free visa-on-arrival policy as tourism, since a formal separate business-visa product for short visits is not commonly required.',
    'Up to 30 days on arrival, extendable to a total of 90 days',
    'Same IMUGA Traveller Declaration as Tourist entry; a business letter is good supporting evidence rather than a separate legal requirement',
    0,
    'Immediate at the border once the IMUGA declaration is on file',
    'Not applicable for short visits; longer commercial engagements may require Ministry of Economic Development registration, a separate business-registration process outside visa scope',
    'Complete the IMUGA Traveller Declaration online\nCarry a business invitation/meeting confirmation letter as supporting evidence\nPresent your passport and IMUGA confirmation at immigration on arrival',
    '/assets/images/visa-heroes/maldives.jpg',
    'Cross-checked against IMUGA system guidance and secondary business-travel sourcing, triangulated against sources not directly fetchable this session', 'https://immigration.gov.mv/', '2026-09-11'
);
SET @mv2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mv2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mv2, 'Core Documents', 'Same as Tourist entry.', 1);
SET @mv2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mv2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mv2s1, 'IMUGA Traveller Declaration Confirmation', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mv2, 'Supporting Documents', 'Business-specific evidence.', 2);
SET @mv2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mv2s2, 'Business Invitation/Meeting Confirmation Letter', NULL, 'copy', 0, 1, 0, 1),
(@mv2s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(81, 2, 0.00, 'INR', 'No Visa Fee', 'Same free visa-on-arrival policy as Tourist entry; no separate business-visa fee for short visits.', '2026-09-01', NOW(), 'https://immigration.gov.mv/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a distinct Business Visa for the Maldives?', 'For short visits, no — business travel is typically covered under the same free visa-on-arrival policy as tourism, via the IMUGA Traveller Declaration.', 81, 2, 8102, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    81, 3, 'MDV-STU-IN-03', '2026.09', 'published',
    'Enrolling in a Maldivian educational institution.',
    'Indian nationals admitted to a recognized Maldivian institution; the institution sponsors a Student Visa/permit application through the Ministry of Higher Education and Immigration.',
    'Tied to course duration, renewable annually',
    'Institution files the sponsorship application; student then completes visa processing through the Department of Immigration',
    1,
    'Processed through the institution rather than a walk-in visa-on-arrival route; allow several weeks for the sponsorship and permit steps',
    'Maldives Immigration, Male',
    'Secure admission at a recognized Maldivian institution\nHave the institution file the student sponsorship application with immigration\nSubmit passport and supporting documents\nComplete biometrics/registration after arrival, per Maldivian immigration rules',
    '/assets/images/visa-heroes/maldives.jpg',
    'Cross-checked against Ministry of Higher Education guidance and secondary education-consultancy sourcing, triangulated against sources not directly fetchable this session', 'https://immigration.gov.mv/', '2026-09-11'
);
SET @mv3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mv3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mv3, 'Core Documents', 'Required from every applicant.', 1);
SET @mv3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mv3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mv3s1, 'Admission Letter from Maldivian Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mv3, 'Supporting Documents', 'Evidence of your academic background and means.', 2);
SET @mv3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mv3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@mv3s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2),
(@mv3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(81, 3, NULL, 'MVR', 'Confirmed After Assessment', 'Fee varies by institution-sponsored permit type — not consistently confirmed this session, contact us to confirm.', '2026-09-01', NOW(), 'https://immigration.gov.mv/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I get a Student visa on arrival like the Tourist visa?', 'No — the Student Visa is sponsored by your Maldivian institution and processed through the Department of Immigration, separate from the visa-on-arrival system.', 81, 3, 8103, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    81, 4, 'MDV-WORK-IN-04', '2026.09', 'published',
    'Employment with a Maldivian employer — a significant category given the large resident Indian expatriate workforce, especially in resorts, healthcare, and construction.',
    'Indian nationals with a confirmed job offer; the employer secures Employment Approval (EA) from the Ministry of Economic Development, registers the position/quota via PFED, and manages the permit through the Xpat online system.',
    'Tied to the employment contract, renewable',
    'Employer-driven: EA approval, quota registration (PFED), and Xpat-system permit issuance, in that order, before the employee travels',
    1,
    'A genuinely multi-agency process (EA, PFED, Xpat) experienced by the employee as one employer-managed workflow; allow several weeks for the employer-side steps to complete',
    'Ministry of Economic Development, Male (employer-facing); Department of Immigration for entry processing',
    'Employer obtains Employment Approval (EA) from the Ministry of Economic Development\nEmployer registers the position/quota via PFED\nEmployer issues the work permit through the Xpat online system\nEmployee travels and completes entry formalities and medical screening on arrival',
    '/assets/images/visa-heroes/maldives.jpg',
    'Cross-checked against Ministry of Economic Development EA/PFED/Xpat guidance and secondary expatriate-labour sourcing, triangulated against sources not directly fetchable this session', 'https://immigration.gov.mv/', '2026-09-11'
);
SET @mv4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mv4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mv4, 'Core Documents', 'Required from every applicant.', 1);
SET @mv4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mv4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mv4s1, 'Employment Contract', NULL, 'copy', 1, 0, 1, 2),
(@mv4s1, 'Employer''s Employment Approval (EA)', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mv4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @mv4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mv4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@mv4s2, 'Medical Fitness Certificate', 'Health screening typically completed on arrival in the Maldives.', 'original', 1, 0, 0, 2),
(@mv4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(81, 4, NULL, 'MVR', 'Confirmed After Assessment', 'EA/quota/Xpat fees are employer-paid and vary by sector — not consistently confirmed this session, contact us to confirm.', '2026-09-01', NOW(), 'https://immigration.gov.mv/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Who applies for a Maldives work permit — me or my employer?', 'Your employer drives the process end-to-end: securing Employment Approval, registering the quota via PFED, and issuing the permit through the Xpat system, before you travel.', 81, 4, 8104, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    81, 5, 'MDV-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives, including expatriate workers, resident in the Maldives.',
    'Covered under the same free visa-on-arrival policy as Tourist entry — no separate Family Visit visa product exists for short stays.',
    'Up to 30 days on arrival, extendable to a total of 90 days',
    'Same IMUGA Traveller Declaration as Tourist entry',
    0,
    'Immediate at the border once the IMUGA declaration is on file',
    'Not applicable',
    'Complete the IMUGA Traveller Declaration online\nCarry proof of relationship and your relative''s local address/permit details as supporting evidence\nPresent your passport and IMUGA confirmation at immigration on arrival',
    '/assets/images/visa-heroes/maldives.jpg',
    'Cross-checked against IMUGA system guidance, triangulated against sources not directly fetchable this session', 'https://immigration.gov.mv/', '2026-09-11'
);
SET @mv5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mv5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mv5, 'Core Documents', 'Same as Tourist entry.', 1);
SET @mv5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mv5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mv5s1, 'IMUGA Traveller Declaration Confirmation', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mv5, 'Supporting Documents', 'Family-visit-specific evidence.', 2);
SET @mv5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mv5s2, 'Proof of Relationship', NULL, 'copy', 0, 1, 0, 1),
(@mv5s2, 'Relative''s Local Address/Work Permit Details', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(81, 5, 0.00, 'INR', 'No Visa Fee', 'Same free visa-on-arrival policy as Tourist entry.', '2026-09-01', NOW(), 'https://immigration.gov.mv/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate visa to visit family working in the Maldives?', 'No — it is covered under the same free visa-on-arrival policy as tourism. Carrying proof of relationship is good practice but not a formal legal requirement.', 81, 5, 8105, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    81, 6, 'MDV-TRANS-IN-06', '2026.09', 'published',
    'Passing through Velana International Airport (Male) for a connecting flight.',
    'Covered under the same free visa-on-arrival policy; a formal separate Transit Visa is not required for onward connections within the same day, though the IMUGA declaration still applies if leaving the airport transit area.',
    'Short stay, typically same-day; up to 30 days if choosing to leave the airport under the general visa-on-arrival allowance',
    'Same IMUGA Traveller Declaration if leaving the airport transit area; airside connections generally do not require a separate process',
    0,
    'Immediate; confirm with your airline whether your specific connection requires you to clear immigration',
    'Not applicable',
    'Confirm with your airline whether your connection is airside-only or requires clearing immigration\nIf clearing immigration, complete the IMUGA Traveller Declaration\nPresent your passport and onward ticket at immigration if required',
    '/assets/images/visa-heroes/maldives.jpg',
    'Cross-checked against IMUGA system guidance and airport-transit secondary sourcing, triangulated against sources not directly fetchable this session', 'https://immigration.gov.mv/', '2026-09-11'
);
SET @mv6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mv6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mv6, 'Core Documents', 'Required if clearing immigration.', 1);
SET @mv6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mv6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mv6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mv6, 'Supporting Documents', 'Only relevant if leaving the airport transit area.', 2);
SET @mv6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mv6s2, 'IMUGA Traveller Declaration Confirmation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(81, 6, 0.00, 'INR', 'No Visa Fee', 'No separate Transit Visa fee; covered under the general visa-on-arrival policy if you clear immigration.', '2026-09-01', NOW(), 'https://immigration.gov.mv/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need to fill the IMUGA form if I''m just changing planes in Male?', 'If your connection is airside-only, generally no. If you plan to leave the airport transit area, you should complete the IMUGA Traveller Declaration first — confirm with your airline based on your specific itinerary.', 81, 6, 8106, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    81, 7, 'MDV-MED-IN-07', '2026.09', 'published',
    'Travel for medical treatment in the Maldives — a comparatively uncommon direction, since Maldivians more often travel to India for advanced treatment than the reverse.',
    'Covered under the same free visa-on-arrival policy as Tourist entry for most short-term treatment; no distinct Medical Visa product was confirmed this session.',
    'Up to 30 days on arrival, extendable to a total of 90 days',
    'Same IMUGA Traveller Declaration as Tourist entry',
    0,
    'Immediate at the border once the IMUGA declaration is on file',
    'Not applicable',
    'Complete the IMUGA Traveller Declaration online\nCarry hospital appointment confirmation and medical records as supporting evidence\nPresent your passport and IMUGA confirmation at immigration on arrival',
    '/assets/images/visa-heroes/maldives.jpg',
    'Limited secondary sourcing found this session for a distinct Medical Visa product; treated as covered under the general visa-on-arrival policy', 'https://immigration.gov.mv/', '2026-09-11'
);
SET @mv7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mv7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mv7, 'Core Documents', 'Same as Tourist entry.', 1);
SET @mv7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mv7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mv7s1, 'IMUGA Traveller Declaration Confirmation', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mv7, 'Supporting Documents', 'Medical-specific evidence.', 2);
SET @mv7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mv7s2, 'Hospital Appointment Confirmation', NULL, 'copy', 0, 1, 0, 1),
(@mv7s2, 'Medical Records/Referral', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(81, 7, 0.00, 'INR', 'No Visa Fee', 'Covered under the general visa-on-arrival policy; no distinct Medical Visa fee confirmed this session.', '2026-09-01', NOW(), 'https://immigration.gov.mv/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is medical travel to the Maldives common for Indians?', 'It is comparatively uncommon — medical travel between the two countries runs predominantly the other way, from the Maldives to India. Short-term treatment visits are generally covered under the standard visa-on-arrival policy.', 81, 7, 8107, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    81, 8, 'MDV-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, seminars, and official delegations in the Maldives.',
    'Covered under the same free visa-on-arrival policy as Tourist entry — no distinct Conference Visa product was confirmed this session.',
    'Up to 30 days on arrival, extendable to a total of 90 days',
    'Same IMUGA Traveller Declaration as Tourist entry',
    0,
    'Immediate at the border once the IMUGA declaration is on file',
    'Not applicable',
    'Complete the IMUGA Traveller Declaration online\nCarry a conference/event invitation letter as supporting evidence\nPresent your passport and IMUGA confirmation at immigration on arrival',
    '/assets/images/visa-heroes/maldives.jpg',
    'Limited secondary sourcing found this session for a distinct Conference Visa product; treated as covered under the general visa-on-arrival policy', 'https://immigration.gov.mv/', '2026-09-11'
);
SET @mv8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mv8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mv8, 'Core Documents', 'Same as Tourist entry.', 1);
SET @mv8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mv8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mv8s1, 'IMUGA Traveller Declaration Confirmation', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mv8, 'Supporting Documents', 'Conference-specific evidence.', 2);
SET @mv8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mv8s2, 'Conference/Event Invitation Letter', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(81, 8, 0.00, 'INR', 'No Visa Fee', 'Covered under the general visa-on-arrival policy.', '2026-09-01', NOW(), 'https://immigration.gov.mv/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do conference delegates need anything beyond the standard visa on arrival?', 'No distinct Conference Visa was confirmed this session — delegates are covered under the standard free visa-on-arrival policy, with an invitation letter as useful supporting evidence.', 81, 8, 8108, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    81, 9, 'MDV-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in the Maldives.',
    'Covered under the same free visa-on-arrival policy as Tourist entry — no distinct Sports Visa product was confirmed this session.',
    'Up to 30 days on arrival, extendable to a total of 90 days',
    'Same IMUGA Traveller Declaration as Tourist entry',
    0,
    'Immediate at the border once the IMUGA declaration is on file',
    'Not applicable',
    'Complete the IMUGA Traveller Declaration online\nCarry federation/tournament accreditation as supporting evidence\nPresent your passport and IMUGA confirmation at immigration on arrival',
    '/assets/images/visa-heroes/maldives.jpg',
    'Limited secondary sourcing found this session for a distinct Sports Visa product; treated as covered under the general visa-on-arrival policy', 'https://immigration.gov.mv/', '2026-09-11'
);
SET @mv9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mv9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mv9, 'Core Documents', 'Same as Tourist entry.', 1);
SET @mv9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mv9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mv9s1, 'IMUGA Traveller Declaration Confirmation', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mv9, 'Supporting Documents', 'Sports-specific evidence.', 2);
SET @mv9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mv9s2, 'Sports Federation/Tournament Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(81, 9, 0.00, 'INR', 'No Visa Fee', 'Covered under the general visa-on-arrival policy.', '2026-09-01', NOW(), 'https://immigration.gov.mv/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do sports delegations need a special visa for the Maldives?', 'No distinct Sports Visa was confirmed this session — delegations are covered under the standard free visa-on-arrival policy, with federation accreditation as useful supporting evidence.', 81, 9, 8109, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    81, 10, 'MDV-DEP-IN-10', '2026.09', 'published',
    'Spouse/children accompanying an Indian Work or Student visa holder in the Maldives.',
    'Family members of an Indian national already working or studying in the Maldives; sponsored by the principal visa/permit holder through the Department of Immigration.',
    'Tied to the principal visa holder''s permit validity',
    'Employer/institution or principal permit holder sponsors the dependent pass application through immigration',
    1,
    'Employer- or institution-driven, following the principal applicant''s own EA/Xpat or student-sponsorship process',
    'Department of Immigration, Male',
    'Confirm the principal applicant''s Work permit (Xpat) or Student sponsorship is approved\nGather documents proving the family relationship\nSubmit the dependent pass application with relationship proof and the principal''s permit copy',
    '/assets/images/visa-heroes/maldives.jpg',
    'Cross-checked against Xpat system guidance and secondary expatriate-family sourcing, triangulated against sources not directly fetchable this session', 'https://immigration.gov.mv/', '2026-09-11'
);
SET @mv10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mv10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mv10, 'Core Documents', 'Required from every applicant.', 1);
SET @mv10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mv10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@mv10s1, 'Proof of Relationship to Principal Permit Holder', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mv10, 'Supporting Documents', 'Evidence tied to the principal applicant''s permit.', 2);
SET @mv10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@mv10s2, 'Principal Applicant''s Work Permit (Xpat)/Student Sponsorship Copy', NULL, 'copy', 1, 0, 0, 1),
(@mv10s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(81, 10, NULL, 'MVR', 'Confirmed After Assessment', 'Fee not clearly confirmed this session — contact us to confirm current figures.', '2026-09-01', NOW(), 'https://immigration.gov.mv/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my family join me while I work in the Maldives?', 'Yes — as dependants, sponsored by your employer or institution through the Department of Immigration, alongside proof of relationship and a copy of your own approved permit.', 81, 10, 8110, 1);
