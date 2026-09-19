-- Bahamas Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search. hero_image_url left NULL
-- pattern-consistent with other batches.
--
-- SOURCING CAVEAT: official Bahamian immigration domains were not
-- directly fetchable this session (egress-proxy blocked); findings
-- triangulated from iVisa and Holidify secondary sourcing, which
-- disagreed on processing time (20 days vs. 6-8 weeks) — both figures
-- are recorded below rather than picking one arbitrarily.
--
-- Bahamas' real, distinctive facts verified this session:
--   - Two visa types: single-entry (valid 90 days, one entry only) and
--     multiple-entry (valid 12 months).
--   - Government fee reported at USD 110; a separate secondary source
--     cites up to INR 29,500 for a single-entry visa inclusive of
--     processing/service tax/embassy charges — flagged as a
--     discrepancy, confirm the exact current fee before applying.
--   - A medical certificate meeting minimum health requirements is a
--     stated requirement, alongside a confirmed round-trip ticket.
--
-- country_id 155 = Bahamas. visa_type_id: 1=Tourist, 2=Business,
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
    155, 1, 'BHS-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to the Bahamas.',
    'Indian passport holders require a visa. Single-entry visas are valid 90 days (one entry); multiple-entry visas are valid 12 months.',
    'Single-entry: 90 days validity, one entry; Multiple-entry: 12 months validity',
    'Apply via the nearest Bahamian diplomatic mission or authorised visa service',
    1,
    'Reported figures disagree: approximately 20 days per one source, 6-8 weeks per another — confirm current timing before booking travel',
    'Nearest Bahamian diplomatic mission (no dedicated embassy confirmed in India this session)',
    'Get a medical certificate meeting minimum health requirements\nBook a confirmed, paid round-trip ticket\nArrange proof of accommodation\nComplete the visa application form\nSubmit documents and pay the fee at the relevant mission or visa service',
    '/assets/images/visa-heroes/bahamas.webp',
    'iVisa and Holidify secondary sourcing; official Bahamian government domains not directly fetchable this session', 'https://ivisatravel.com/bahamas/c/bahamas-visa-for-citizens-of-india', '2026-09-19'
);
SET @bhs1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bhs1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bhs1, 'Core Documents', 'Required from every applicant.', 1);
SET @bhs1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bhs1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bhs1s1, 'Medical Certificate (Minimum Health Requirements)', NULL, 'original', 1, 0, 1, 2),
(@bhs1s1, 'Completed Visa Application Form', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bhs1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @bhs1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bhs1s2, 'Confirmed, Paid Round-Trip Flight Ticket', NULL, 'copy', 1, 0, 0, 1),
(@bhs1s2, 'Confirmed Hotel Reservation', NULL, 'copy', 1, 0, 0, 2),
(@bhs1s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(155, 1, 110.00, 'USD', 'Single/Multiple-Entry Visa Government Fee', 'A separate secondary source cites up to INR 29,500 for single-entry inclusive of processing/service tax/embassy charges — this discrepancy is flagged, not resolved; confirm the exact current fee before applying.', '2026-01-01', NOW(), 'https://ivisatravel.com/bahamas/c/bahamas-visa-for-citizens-of-india', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What visa types are available for the Bahamas?', 'Single-entry visas (valid 90 days, one entry) and multiple-entry visas (valid 12 months) are both available for Indian citizens.', 155, 1, 15500, 1),
('How long does a Bahamas visa take to process?', 'Reported figures disagree between sources — approximately 20 days per one source, and 6-8 weeks per another. Confirm current timing before booking travel.', 155, 1, 15501, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    155, 2, 'BHS-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in the Bahamas.',
    'Business travellers use the same single/multiple-entry visa framework as tourists, adding a business invitation letter.',
    'Single-entry: 90 days validity, one entry; Multiple-entry: 12 months validity',
    'Apply via the nearest Bahamian diplomatic mission or authorised visa service',
    1,
    'Reported figures disagree: approximately 20 days per one source, 6-8 weeks per another — confirm current timing before booking travel',
    'Nearest Bahamian diplomatic mission (no dedicated embassy confirmed in India this session)',
    'Obtain a business invitation letter from the Bahamian host\nGet a medical certificate meeting minimum health requirements\nBook a confirmed, paid round-trip ticket\nComplete the visa application form\nSubmit documents and pay the fee at the relevant mission or visa service',
    '/assets/images/visa-heroes/bahamas.webp',
    'iVisa and Holidify secondary sourcing; official Bahamian government domains not directly fetchable this session', 'https://ivisatravel.com/bahamas/c/bahamas-visa-for-citizens-of-india', '2026-09-19'
);
SET @bhs2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bhs2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bhs2, 'Core Documents', 'Required from every applicant.', 1);
SET @bhs2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bhs2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bhs2s1, 'Medical Certificate (Minimum Health Requirements)', NULL, 'original', 1, 0, 1, 2),
(@bhs2s1, 'Business Invitation Letter', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bhs2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @bhs2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bhs2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@bhs2s2, 'Confirmed, Paid Round-Trip Flight Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(155, 2, 110.00, 'USD', 'Single/Multiple-Entry Visa Government Fee', 'A separate secondary source cites up to INR 29,500 for single-entry inclusive of processing/service tax/embassy charges — confirm the exact current fee before applying.', '2026-01-01', NOW(), 'https://ivisatravel.com/bahamas/c/bahamas-visa-for-citizens-of-india', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How long does a Bahamas business visa take?', 'Both tourist and business visas may take up to 6-8 weeks to process after approval, per one source, though another cites approximately 20 days — confirm current timing.', 155, 2, 15502, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    155, 3, 'BHS-STUD-IN-01', '2026.09', 'published',
    'Academic study in the Bahamas.',
    'Not independently confirmed this session as a distinct standard visa category; likely requires a student permit beyond the standard visitor visa for longer programs.',
    'Tied to the academic program duration',
    'Confirm with the nearest Bahamian mission for the student-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Bahamian diplomatic mission (no dedicated embassy confirmed in India this session)',
    'Secure admission confirmation from the Bahamian institution\nCheck whether a separate student permit is required\nGet a medical certificate\nGather proof of financial support\nSubmit documents and pay the fee at the relevant mission',
    '/assets/images/visa-heroes/bahamas.webp',
    'Best-effort structure built from the confirmed general Bahamian visa framework; category-specific detail not independently confirmed this session', 'https://ivisatravel.com/bahamas/c/bahamas-visa-for-citizens-of-india', '2026-09-19'
);
SET @bhs3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bhs3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bhs3, 'Core Documents', 'Required from every applicant.', 1);
SET @bhs3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bhs3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bhs3s1, 'Admission Confirmation from Bahamian Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bhs3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @bhs3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bhs3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@bhs3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(155, 3, NULL, 'USD', 'Confirm at Mission', 'Student permit fee not independently confirmed this session; confirm with the relevant Bahamian mission.', '2026-09-01', NOW(), 'https://ivisatravel.com/bahamas/c/bahamas-visa-for-citizens-of-india', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate student visa for the Bahamas?', 'Not independently confirmed this session — longer academic programs likely require a student permit beyond the standard visitor visa. Confirm with the relevant mission.', 155, 3, 15503, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    155, 4, 'BHS-WORK-IN-01', '2026.09', 'published',
    'Employment with a Bahamian company.',
    'Not independently confirmed this session as a distinct standard visa category; likely requires an employer-sponsored work permit beyond the standard visitor visa.',
    'Tied to the employment contract duration',
    'Confirm with the employer and the nearest Bahamian mission for the work-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Bahamian diplomatic mission (no dedicated embassy confirmed in India this session)',
    'Secure a signed employment contract from the Bahamian employer\nCheck whether a separate work permit is required\nGet a medical certificate\nGather proof of qualifications\nSubmit documents and pay the fee at the relevant mission',
    '/assets/images/visa-heroes/bahamas.webp',
    'Best-effort structure built from the confirmed general Bahamian visa framework; category-specific detail not independently confirmed this session', 'https://ivisatravel.com/bahamas/c/bahamas-visa-for-citizens-of-india', '2026-09-19'
);
SET @bhs4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bhs4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bhs4, 'Core Documents', 'Required from every applicant.', 1);
SET @bhs4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bhs4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bhs4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bhs4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @bhs4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bhs4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@bhs4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(155, 4, NULL, 'USD', 'Confirm at Mission', 'Work permit fee not independently confirmed this session; confirm with the relevant Bahamian mission.', '2026-09-01', NOW(), 'https://ivisatravel.com/bahamas/c/bahamas-visa-for-citizens-of-india', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a work permit for the Bahamas beyond the visitor visa?', 'Not independently confirmed this session — employment likely requires a separate employer-sponsored work permit. Confirm with the relevant mission.', 155, 4, 15504, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    155, 5, 'BHS-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in the Bahamas.',
    'Family visits use the same single/multiple-entry visa framework as tourism, adding an invitation letter and relationship proof.',
    'Single-entry: 90 days validity, one entry; Multiple-entry: 12 months validity',
    'Apply via the nearest Bahamian diplomatic mission or authorised visa service',
    1,
    'Reported figures disagree: approximately 20 days per one source, 6-8 weeks per another — confirm current timing before booking travel',
    'Nearest Bahamian diplomatic mission (no dedicated embassy confirmed in India this session)',
    'Obtain an invitation letter from the family member resident in the Bahamas\nGet a medical certificate meeting minimum health requirements\nBook a confirmed, paid round-trip ticket\nComplete the visa application form\nSubmit documents and pay the fee at the relevant mission or visa service',
    '/assets/images/visa-heroes/bahamas.webp',
    'iVisa and Holidify secondary sourcing; official Bahamian government domains not directly fetchable this session', 'https://ivisatravel.com/bahamas/c/bahamas-visa-for-citizens-of-india', '2026-09-19'
);
SET @bhs5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bhs5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bhs5, 'Core Documents', 'Required from every applicant.', 1);
SET @bhs5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bhs5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bhs5s1, 'Medical Certificate (Minimum Health Requirements)', NULL, 'original', 1, 0, 1, 2),
(@bhs5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bhs5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @bhs5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bhs5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@bhs5s2, 'Confirmed, Paid Round-Trip Flight Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(155, 5, 110.00, 'USD', 'Single/Multiple-Entry Visa Government Fee', 'A separate secondary source cites up to INR 29,500 for single-entry inclusive of processing/service tax/embassy charges — confirm the exact current fee before applying.', '2026-01-01', NOW(), 'https://ivisatravel.com/bahamas/c/bahamas-visa-for-citizens-of-india', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in the Bahamas on the standard visa?', 'Yes — family visits use the same single/multiple-entry visa framework as tourism, with an invitation letter and relationship proof added.', 155, 5, 15505, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    155, 6, 'BHS-TRAN-IN-01', '2026.09', 'published',
    'Transiting through the Bahamas en route to a third country.',
    'Not independently confirmed this session whether transit requires a full visa or a separate provision — confirm with the airline before travel.',
    'Short duration tied to the transit itinerary',
    'Confirm with the nearest Bahamian mission or your airline whether the standard visa applies',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Bahamian diplomatic mission (no dedicated embassy confirmed in India this session)',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck whether a transit-specific provision applies\nComplete the visa application form if required\nSubmit passport, photo, and onward ticket\nCollect the passport with visa once processed (if applicable)',
    '/assets/images/visa-heroes/bahamas.webp',
    'Best-effort structure built from the confirmed general Bahamian visa framework; category-specific detail not independently confirmed this session', 'https://ivisatravel.com/bahamas/c/bahamas-visa-for-citizens-of-india', '2026-09-19'
);
SET @bhs6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bhs6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bhs6, 'Core Documents', 'Required from every applicant.', 1);
SET @bhs6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bhs6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bhs6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bhs6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @bhs6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bhs6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(155, 6, NULL, 'USD', 'Confirm at Mission', 'Transit fee not independently confirmed this session; confirm with the relevant Bahamian mission.', '2026-09-01', NOW(), 'https://ivisatravel.com/bahamas/c/bahamas-visa-for-citizens-of-india', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through the Bahamas?', 'Not independently confirmed this session — confirm with the relevant mission or your airline whether your specific transit routing requires the standard visa.', 155, 6, 15506, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    155, 7, 'BHS-MED-IN-01', '2026.09', 'published',
    'Medical treatment in the Bahamas.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard visitor visa with medical documentation.',
    'Single-entry: 90 days validity, one entry; Multiple-entry: 12 months validity',
    'Apply via the nearest Bahamian diplomatic mission or authorised visa service',
    1,
    'Reported figures disagree: approximately 20 days per one source, 6-8 weeks per another — confirm current timing before booking travel',
    'Nearest Bahamian diplomatic mission (no dedicated embassy confirmed in India this session)',
    'Obtain a medical appointment/admission letter from the hospital\nGet a medical certificate meeting minimum health requirements\nComplete the visa application form\nSubmit documents and pay the fee at the relevant mission\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/bahamas.webp',
    'Best-effort structure built from the confirmed general Bahamian visa framework; category-specific detail not independently confirmed this session', 'https://ivisatravel.com/bahamas/c/bahamas-visa-for-citizens-of-india', '2026-09-19'
);
SET @bhs7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bhs7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bhs7, 'Core Documents', 'Required from every applicant.', 1);
SET @bhs7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bhs7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bhs7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bhs7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @bhs7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bhs7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@bhs7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(155, 7, 110.00, 'USD', 'Single/Multiple-Entry Visa Government Fee', 'A separate secondary source cites up to INR 29,500 for single-entry inclusive of processing/service tax/embassy charges — confirm the exact current fee before applying.', '2026-01-01', NOW(), 'https://ivisatravel.com/bahamas/c/bahamas-visa-for-citizens-of-india', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for the Bahamas?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the standard visitor visa with supporting medical documentation.', 155, 7, 15507, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    155, 8, 'BHS-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in the Bahamas.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the Business visa framework with an event invitation.',
    'Single-entry: 90 days validity, one entry; Multiple-entry: 12 months validity',
    'Apply via the nearest Bahamian diplomatic mission or authorised visa service',
    1,
    'Reported figures disagree: approximately 20 days per one source, 6-8 weeks per another — confirm current timing before booking travel',
    'Nearest Bahamian diplomatic mission (no dedicated embassy confirmed in India this session)',
    'Obtain an official invitation letter from the event organiser\nGet a medical certificate meeting minimum health requirements\nComplete the visa application form\nSubmit documents and pay the fee at the relevant mission\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/bahamas.webp',
    'Best-effort structure built from the confirmed general Bahamian visa framework; category-specific detail not independently confirmed this session', 'https://ivisatravel.com/bahamas/c/bahamas-visa-for-citizens-of-india', '2026-09-19'
);
SET @bhs8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bhs8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bhs8, 'Core Documents', 'Required from every applicant.', 1);
SET @bhs8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bhs8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bhs8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bhs8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @bhs8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bhs8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(155, 8, 110.00, 'USD', 'Single/Multiple-Entry Visa Government Fee', 'A separate secondary source cites up to INR 29,500 for single-entry inclusive of processing/service tax/embassy charges — confirm the exact current fee before applying.', '2026-01-01', NOW(), 'https://ivisatravel.com/bahamas/c/bahamas-visa-for-citizens-of-india', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for the Bahamas?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business visa framework with an official invitation letter.', 155, 8, 15508, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    155, 9, 'BHS-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in the Bahamas.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard visitor visa with an event invitation.',
    'Single-entry: 90 days validity, one entry; Multiple-entry: 12 months validity',
    'Apply via the nearest Bahamian diplomatic mission or authorised visa service',
    1,
    'Reported figures disagree: approximately 20 days per one source, 6-8 weeks per another — confirm current timing before booking travel',
    'Nearest Bahamian diplomatic mission (no dedicated embassy confirmed in India this session)',
    'Obtain an official invitation from the sporting federation/event organiser\nGet a medical certificate meeting minimum health requirements\nComplete the visa application form\nSubmit documents and pay the fee at the relevant mission\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/bahamas.webp',
    'Best-effort structure built from the confirmed general Bahamian visa framework; category-specific detail not independently confirmed this session', 'https://ivisatravel.com/bahamas/c/bahamas-visa-for-citizens-of-india', '2026-09-19'
);
SET @bhs9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bhs9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bhs9, 'Core Documents', 'Required from every applicant.', 1);
SET @bhs9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bhs9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bhs9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bhs9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @bhs9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bhs9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(155, 9, 110.00, 'USD', 'Single/Multiple-Entry Visa Government Fee', 'A separate secondary source cites up to INR 29,500 for single-entry inclusive of processing/service tax/embassy charges — confirm the exact current fee before applying.', '2026-01-01', NOW(), 'https://ivisatravel.com/bahamas/c/bahamas-visa-for-citizens-of-india', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for the Bahamas?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the standard visitor visa with a federation/event invitation.', 155, 9, 15509, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    155, 10, 'BHS-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Bahamian work or residence permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent application alongside the sponsor''s permit.',
    'Tied to the sponsor''s permit validity',
    'Confirm with the nearest Bahamian mission for the dependent-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Nearest Bahamian diplomatic mission (no dedicated embassy confirmed in India this session)',
    'Confirm the sponsor holds a qualifying work/residence permit\nGather relationship proof and the sponsor''s permit copy\nGet a medical certificate\nSubmit documents and pay the fee at the relevant mission\nCollect the passport with visa once processed',
    '/assets/images/visa-heroes/bahamas.webp',
    'Best-effort structure built from the confirmed general Bahamian visa framework; category-specific detail not independently confirmed this session', 'https://ivisatravel.com/bahamas/c/bahamas-visa-for-citizens-of-india', '2026-09-19'
);
SET @bhs10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bhs10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bhs10, 'Core Documents', 'Required from every applicant.', 1);
SET @bhs10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bhs10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bhs10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bhs10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @bhs10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bhs10s2, 'Sponsor''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@bhs10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(155, 10, NULL, 'USD', 'Confirm at Mission', 'Dependent permit fee not independently confirmed this session; confirm with the relevant Bahamian mission.', '2026-09-01', NOW(), 'https://ivisatravel.com/bahamas/c/bahamas-visa-for-citizens-of-india', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent permit in the Bahamas?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence permit. Confirm the exact procedure with the relevant mission.', 155, 10, 15510, 1);
