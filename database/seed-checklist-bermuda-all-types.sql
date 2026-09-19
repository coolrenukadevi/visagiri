-- Bermuda Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search.
--
-- Bermuda's real, distinctive facts verified this session:
--   - Indian citizens are on Bermuda's Visa Controlled Nationals List
--     but can travel visa-free if holding a valid multiple-entry US,
--     UK, or Canada visitor visa (valid for 45+ days beyond the
--     planned departure from Bermuda) — no separate Bermuda visa is
--     issued or needed under this route.
--   - Permitted stay: up to 21 days.
--   - Bermuda has no dedicated visa-issuing mission serving India;
--     the Bermuda Department of Immigration handles extensions and
--     related matters locally, not visa issuance for Indian nationals.
--
-- country_id 158 = Bermuda. visa_type_id: 1=Tourist, 2=Business,
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
    158, 1, 'BMU-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Bermuda.',
    'No separate Bermuda visa is issued — Indian citizens holding a valid multiple-entry US, UK, or Canada visitor visa (valid 45+ days beyond departure from Bermuda) may enter visa-free.',
    'Up to 21 days',
    'No Bermuda visa application — travel on a valid multiple-entry US/UK/Canada visitor visa with your passport',
    0,
    'Not applicable — entry is assessed by Bermuda Immigration at the port of entry',
    'No Bermuda mission issues visas to Indian nationals; entry is via a qualifying US/UK/Canada visa',
    'Confirm your US/UK/Canada visitor visa is multiple-entry and valid 45+ days beyond your Bermuda departure\nBook a return or onward ticket\nCarry your passport, qualifying visa, and travel documents\nPresent all documents to Bermuda Immigration on arrival\nDo not overstay the 21-day permitted period',
    '/assets/images/visa-heroes/bermuda.webp',
    'Government of Bermuda entry-visa guidance and CIBTvisas/Akbar Travels secondary sourcing', 'https://www.gov.bm/bermuda-entry-visas', '2026-09-19'
);
SET @bmu1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bmu1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bmu1, 'Core Documents', 'Required from every traveller.', 1);
SET @bmu1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bmu1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bmu1s1, 'Valid Multiple-Entry US/UK/Canada Visitor Visa', 'Must remain valid for at least 45 days beyond departure from Bermuda.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bmu1, 'Supporting Documents', 'Evidence of your travel plans.', 2);
SET @bmu1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bmu1s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 1),
(@bmu1s2, 'Proof of Accommodation Booking', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(158, 1, 0.00, 'USD', 'No Separate Bermuda Visa Fee', 'No fee is charged for Bermuda entry itself; travel relies on your existing US/UK/Canada visitor visa, which carries its own fee.', '2026-01-01', NOW(), 'https://www.gov.bm/bermuda-entry-visas', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a separate Bermuda visa?', 'No standalone Bermuda visa is issued to Indian citizens. Instead, you can enter visa-free for up to 21 days if you hold a valid multiple-entry US, UK, or Canada visitor visa valid for 45+ days beyond your planned departure from Bermuda.', 158, 1, 15800, 1),
('What if I don''t hold a US, UK, or Canada visa?', 'Not independently confirmed this session — Indian nationals without a qualifying US/UK/Canada visa are on Bermuda''s Visa Controlled Nationals List, so confirm the applicable route with Bermuda Immigration before travel.', 158, 1, 15801, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    158, 2, 'BMU-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Bermuda.',
    'Business travellers use the same qualifying-visa framework as tourists, adding a business invitation letter.',
    'Up to 21 days',
    'No Bermuda visa application — travel on a valid multiple-entry US/UK/Canada visitor visa with your passport',
    0,
    'Not applicable — entry is assessed by Bermuda Immigration at the port of entry',
    'No Bermuda mission issues visas to Indian nationals; entry is via a qualifying US/UK/Canada visa',
    'Confirm your US/UK/Canada visitor visa is multiple-entry and valid 45+ days beyond your Bermuda departure\nObtain a business invitation letter\nBook a return or onward ticket\nCarry your passport, qualifying visa, and business documents\nPresent all documents to Bermuda Immigration on arrival',
    '/assets/images/visa-heroes/bermuda.webp',
    'Government of Bermuda entry-visa guidance and CIBTvisas/Akbar Travels secondary sourcing', 'https://www.gov.bm/bermuda-entry-visas', '2026-09-19'
);
SET @bmu2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bmu2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bmu2, 'Core Documents', 'Required from every traveller.', 1);
SET @bmu2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bmu2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bmu2s1, 'Valid Multiple-Entry US/UK/Canada Visitor Visa', 'Must remain valid for at least 45 days beyond departure from Bermuda.', 'original', 1, 0, 1, 2),
(@bmu2s1, 'Business Invitation Letter', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bmu2, 'Supporting Documents', 'Evidence of your business purpose.', 2);
SET @bmu2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bmu2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@bmu2s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(158, 2, 0.00, 'USD', 'No Separate Bermuda Visa Fee', 'No fee is charged for Bermuda entry itself; travel relies on your existing US/UK/Canada visitor visa, which carries its own fee.', '2026-01-01', NOW(), 'https://www.gov.bm/bermuda-entry-visas', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I do business in Bermuda on the same visa-free route as tourism?', 'Yes — business travel uses the same qualifying US/UK/Canada visitor-visa framework as tourism, with a business invitation letter added.', 158, 2, 15802, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    158, 3, 'BMU-STUD-IN-01', '2026.09', 'published',
    'Academic study in Bermuda.',
    'Not independently confirmed this session as covered by the visa-free route; longer academic programs likely require a work/study permit from Bermuda Immigration.',
    'Tied to the academic program duration',
    'Confirm with Bermuda Immigration for the student-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Bermuda Department of Immigration (Hamilton, Bermuda)',
    'Secure admission confirmation from the Bermudian institution\nContact Bermuda Immigration to confirm the student-permit process\nGather proof of financial support\nSubmit the permit application with required documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/bermuda.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://www.gov.bm/bermuda-entry-visas', '2026-09-19'
);
SET @bmu3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bmu3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bmu3, 'Core Documents', 'Required from every applicant.', 1);
SET @bmu3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bmu3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bmu3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bmu3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @bmu3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bmu3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@bmu3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(158, 3, NULL, 'USD', 'Confirm with Bermuda Immigration', 'Student permit fee not independently confirmed this session; confirm with the Bermuda Department of Immigration.', '2026-09-01', NOW(), 'https://www.gov.bm/bermuda-entry-visas', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a student permit for Bermuda?', 'Not independently confirmed this session — longer academic programs likely require a permit from Bermuda Immigration beyond the standard visa-free tourist route. Confirm directly.', 158, 3, 15803, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    158, 4, 'BMU-WORK-IN-01', '2026.09', 'published',
    'Employment with a Bermudian company.',
    'Not independently confirmed this session as covered by the visa-free route; employment requires a Bermuda work permit sponsored by the employer.',
    'Tied to the work permit validity',
    'Employer applies for the work permit with Bermuda Immigration',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Bermuda Department of Immigration (Hamilton, Bermuda)',
    'Secure a signed employment offer from the Bermudian employer\nHave the employer initiate the work-permit application with Bermuda Immigration\nGather proof of qualifications\nSubmit passport and supporting documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/bermuda.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://www.gov.bm/bermuda-entry-visas', '2026-09-19'
);
SET @bmu4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bmu4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bmu4, 'Core Documents', 'Required from every applicant.', 1);
SET @bmu4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bmu4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bmu4s1, 'Signed Employment Offer/Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bmu4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @bmu4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bmu4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@bmu4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(158, 4, NULL, 'USD', 'Confirm with Bermuda Immigration', 'Work permit fee not independently confirmed this session; confirm with the Bermuda Department of Immigration.', '2026-09-01', NOW(), 'https://www.gov.bm/bermuda-entry-visas', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I work in Bermuda on the visa-free tourist route?', 'No — employment requires a Bermuda work permit sponsored by the employer through Bermuda Immigration; the tourist visa-free route does not authorise work.', 158, 4, 15804, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    158, 5, 'BMU-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Bermuda.',
    'Family visits use the same qualifying-visa framework as tourism, adding relationship proof and an invitation letter.',
    'Up to 21 days',
    'No Bermuda visa application — travel on a valid multiple-entry US/UK/Canada visitor visa with your passport',
    0,
    'Not applicable — entry is assessed by Bermuda Immigration at the port of entry',
    'No Bermuda mission issues visas to Indian nationals; entry is via a qualifying US/UK/Canada visa',
    'Confirm your US/UK/Canada visitor visa is multiple-entry and valid 45+ days beyond your Bermuda departure\nObtain an invitation letter from the resident family member\nBook a return or onward ticket\nCarry your passport, qualifying visa, and relationship proof\nPresent all documents to Bermuda Immigration on arrival',
    '/assets/images/visa-heroes/bermuda.webp',
    'Government of Bermuda entry-visa guidance and CIBTvisas/Akbar Travels secondary sourcing', 'https://www.gov.bm/bermuda-entry-visas', '2026-09-19'
);
SET @bmu5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bmu5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bmu5, 'Core Documents', 'Required from every traveller.', 1);
SET @bmu5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bmu5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bmu5s1, 'Valid Multiple-Entry US/UK/Canada Visitor Visa', 'Must remain valid for at least 45 days beyond departure from Bermuda.', 'original', 1, 0, 1, 2),
(@bmu5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bmu5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @bmu5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bmu5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@bmu5s2, 'Proof of Return/Onward Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(158, 5, 0.00, 'USD', 'No Separate Bermuda Visa Fee', 'No fee is charged for Bermuda entry itself; travel relies on your existing US/UK/Canada visitor visa, which carries its own fee.', '2026-01-01', NOW(), 'https://www.gov.bm/bermuda-entry-visas', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in Bermuda visa-free?', 'Yes — if you hold a qualifying multiple-entry US, UK, or Canada visitor visa, you can visit family in Bermuda for up to 21 days without a separate Bermuda visa.', 158, 5, 15805, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    158, 6, 'BMU-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Bermuda en route to a third country.',
    'Not independently confirmed this session whether the same qualifying-visa route covers transit — confirm with the airline before travel.',
    'Short duration tied to the transit itinerary',
    'Confirm with your airline whether the qualifying US/UK/Canada visa route applies to your transit',
    0,
    'Not applicable — entry is assessed by Bermuda Immigration at the port of entry',
    'No Bermuda mission issues visas to Indian nationals; entry is via a qualifying US/UK/Canada visa',
    'Confirm onward travel itinerary and connecting flight/transport\nCheck whether your US/UK/Canada visa covers transit through Bermuda\nCarry your passport and onward ticket\nPresent all documents to Bermuda Immigration if disembarking\nConfirm requirements with your airline before travel',
    '/assets/images/visa-heroes/bermuda.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://www.gov.bm/bermuda-entry-visas', '2026-09-19'
);
SET @bmu6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bmu6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bmu6, 'Core Documents', 'Required from every traveller.', 1);
SET @bmu6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bmu6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bmu6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bmu6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @bmu6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bmu6s2, 'Destination Country Visa (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(158, 6, NULL, 'USD', 'Confirm with Airline/Immigration', 'Transit fee not independently confirmed this session; confirm with your airline or Bermuda Immigration.', '2026-09-01', NOW(), 'https://www.gov.bm/bermuda-entry-visas', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Bermuda?', 'Not independently confirmed this session — confirm with your airline or Bermuda Immigration whether your specific transit routing requires the qualifying US/UK/Canada visa route.', 158, 6, 15806, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    158, 7, 'BMU-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Bermuda.',
    'Not independently confirmed this session as a distinct category — likely covered under the standard visa-free route with medical documentation.',
    'Up to 21 days',
    'No Bermuda visa application — travel on a valid multiple-entry US/UK/Canada visitor visa with your passport',
    0,
    'Not applicable — entry is assessed by Bermuda Immigration at the port of entry',
    'No Bermuda mission issues visas to Indian nationals; entry is via a qualifying US/UK/Canada visa',
    'Confirm your US/UK/Canada visitor visa is multiple-entry and valid 45+ days beyond your Bermuda departure\nObtain a medical appointment/admission letter from the hospital\nBook a return or onward ticket\nCarry your passport, qualifying visa, and medical documents\nPresent all documents to Bermuda Immigration on arrival',
    '/assets/images/visa-heroes/bermuda.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://www.gov.bm/bermuda-entry-visas', '2026-09-19'
);
SET @bmu7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bmu7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bmu7, 'Core Documents', 'Required from every traveller.', 1);
SET @bmu7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bmu7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bmu7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bmu7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @bmu7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bmu7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@bmu7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(158, 7, 0.00, 'USD', 'No Separate Bermuda Visa Fee', 'No fee is charged for Bermuda entry itself; travel relies on your existing US/UK/Canada visitor visa, which carries its own fee.', '2026-01-01', NOW(), 'https://www.gov.bm/bermuda-entry-visas', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Bermuda?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely covered under the standard visa-free route with supporting medical documentation.', 158, 7, 15807, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    158, 8, 'BMU-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Bermuda.',
    'Not independently confirmed this session as a distinct category — likely covered under the Business visa-free route with an event invitation.',
    'Up to 21 days',
    'No Bermuda visa application — travel on a valid multiple-entry US/UK/Canada visitor visa with your passport',
    0,
    'Not applicable — entry is assessed by Bermuda Immigration at the port of entry',
    'No Bermuda mission issues visas to Indian nationals; entry is via a qualifying US/UK/Canada visa',
    'Confirm your US/UK/Canada visitor visa is multiple-entry and valid 45+ days beyond your Bermuda departure\nObtain an official event invitation letter\nBook a return or onward ticket\nCarry your passport, qualifying visa, and event documents\nPresent all documents to Bermuda Immigration on arrival',
    '/assets/images/visa-heroes/bermuda.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://www.gov.bm/bermuda-entry-visas', '2026-09-19'
);
SET @bmu8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bmu8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bmu8, 'Core Documents', 'Required from every traveller.', 1);
SET @bmu8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bmu8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bmu8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bmu8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @bmu8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bmu8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(158, 8, 0.00, 'USD', 'No Separate Bermuda Visa Fee', 'No fee is charged for Bermuda entry itself; travel relies on your existing US/UK/Canada visitor visa, which carries its own fee.', '2026-01-01', NOW(), 'https://www.gov.bm/bermuda-entry-visas', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Bermuda?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely covered under the Business visa-free route with an official invitation letter.', 158, 8, 15808, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    158, 9, 'BMU-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Bermuda.',
    'Not independently confirmed this session as a distinct category — likely covered under the standard visa-free route with an event invitation.',
    'Up to 21 days',
    'No Bermuda visa application — travel on a valid multiple-entry US/UK/Canada visitor visa with your passport',
    0,
    'Not applicable — entry is assessed by Bermuda Immigration at the port of entry',
    'No Bermuda mission issues visas to Indian nationals; entry is via a qualifying US/UK/Canada visa',
    'Confirm your US/UK/Canada visitor visa is multiple-entry and valid 45+ days beyond your Bermuda departure\nObtain an official invitation from the sporting federation/event organiser\nBook a return or onward ticket\nCarry your passport, qualifying visa, and event documents\nPresent all documents to Bermuda Immigration on arrival',
    '/assets/images/visa-heroes/bermuda.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://www.gov.bm/bermuda-entry-visas', '2026-09-19'
);
SET @bmu9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bmu9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bmu9, 'Core Documents', 'Required from every traveller.', 1);
SET @bmu9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bmu9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bmu9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bmu9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @bmu9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bmu9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(158, 9, 0.00, 'USD', 'No Separate Bermuda Visa Fee', 'No fee is charged for Bermuda entry itself; travel relies on your existing US/UK/Canada visitor visa, which carries its own fee.', '2026-01-01', NOW(), 'https://www.gov.bm/bermuda-entry-visas', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Bermuda?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely covered under the standard visa-free route with a federation/event invitation.', 158, 9, 15809, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    158, 10, 'BMU-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Bermuda work permit.',
    'Not independently confirmed this session as a distinct category — likely requires a dependent application alongside the sponsor''s work permit.',
    'Tied to the sponsor''s work permit validity',
    'Confirm with Bermuda Immigration for the dependent-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Bermuda Department of Immigration (Hamilton, Bermuda)',
    'Confirm the sponsor holds a qualifying Bermuda work permit\nGather relationship proof and the sponsor''s permit copy\nApply via Bermuda Immigration\nSubmit passport and supporting documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/bermuda.webp',
    'Best-effort structure built from the confirmed general entry framework; category-specific detail not independently confirmed this session', 'https://www.gov.bm/bermuda-entry-visas', '2026-09-19'
);
SET @bmu10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bmu10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bmu10, 'Core Documents', 'Required from every applicant.', 1);
SET @bmu10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bmu10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@bmu10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bmu10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @bmu10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bmu10s2, 'Sponsor''s Bermuda Work Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@bmu10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(158, 10, NULL, 'USD', 'Confirm with Bermuda Immigration', 'Dependent permit fee not independently confirmed this session; confirm with Bermuda Immigration.', '2026-09-01', NOW(), 'https://www.gov.bm/bermuda-entry-visas', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent permit in Bermuda?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid Bermuda work permit. Confirm the exact procedure with Bermuda Immigration.', 158, 10, 15810, 1);
