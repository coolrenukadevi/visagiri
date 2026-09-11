-- First real checklist built on the Visa Checklist Engine —
-- Mexico Tourist Visa for Indian applicants. Grounded in Mexico's real
-- visa framework for Indian passport holders (a Mexican visa is
-- required UNLESS the applicant holds a valid multiple-entry US, UK,
-- Canada, Japan, or Schengen visa/residence permit, in which case
-- Mexico's own visa-waiver policy applies instead) — researched via
-- web search this session since no single official Mexican-government
-- URL was directly fetchable from this sandbox; see AUDIT.md for the
-- sourcing note and the fee/processing-time caveats.
--
-- country_id 172 = Mexico, visa_type_id 1 = Tourist Visa (both from
-- the existing shared countries/visa_types catalog — see
-- database/seed.sql).

INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url,
    source, source_url, last_reviewed_at
) VALUES (
    172, 1, 'MEX-TOUR-IN-01', '2026.09', 'published',
    'Tourism, sightseeing, and leisure travel to Mexico.',
    'Indian passport holders without a valid US/UK/Canada/Japan/Schengen visa or residence permit (which may qualify for visa-waived entry instead) generally need to apply for this visa directly.',
    'Up to 180 days per entry',
    'In person, through the Embassy of Mexico or its visa application partner in India',
    1,
    '10-15 working days (indicative)',
    'Embassy of Mexico, New Delhi',
    'Confirm you actually need this visa (check the US/UK/Canada/Japan/Schengen visa-waiver option first)\nGather and organise your documents against this checklist\nComplete and sign the visa application form\nBook your consulate appointment\nAttend in person with your original documents and pay the consular fee\nSubmit your passport for visa stamping\nCollect your passport once the visa is issued',
    '/assets/images/visa-heroes/mexico-city.jpg',
    'Consular guidance and independent visa-agency sources for Mexico tourist visas issued to Indian passport holders', 'https://btwvisas.com/visa-guide/mexico-visa', '2026-09-11'
);

SET @checklist_id = LAST_INSERT_ID();

INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by)
VALUES (@checklist_id, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

-- Section 01 — Core Documents (fully public: genuinely useful on its own)
INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES
(@checklist_id, 'Core Documents', 'Every applicant needs these regardless of travel purpose within the tourist category.', 1);
SET @s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@s1, 'Valid Passport', 'Valid for at least 6 months beyond your planned arrival in Mexico, with at least 2 blank visa pages.', 'original', 1, 0, 1, 1),
(@s1, 'Passport Copy', 'A clear photocopy of the passport bio-data page.', 'copy', 1, 0, 1, 2),
(@s1, 'Previous Passport', 'If you hold an expired passport with earlier travel history, include it — it can support your application.', 'copy', 0, 1, 1, 3),
(@s1, 'Passport-Size Photograph', 'Recent, white background, matching Mexican visa photo specifications.', 'original', 1, 0, 1, 4);

-- Section 02 — Application & Photograph (public — a whole section is
-- shown in full, or not at all; see checklist_section_is_public() in
-- includes/visa-checklist.php)
INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES
(@checklist_id, 'Application & Photograph', 'The formal application paperwork for your tourist visa.', 2);
SET @s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@s2, 'Completed Visa Application Form', 'The Mexican consulate''s tourist visa application form, fully completed and signed.', 'original', 1, 0, 1, 1),
(@s2, 'Cover Letter', 'A short letter explaining your purpose of travel, planned dates, and itinerary.', 'original', 1, 0, 1, 2),
(@s2, 'Confirmed Return/Onward Flight Itinerary', NULL, 'copy', 1, 0, 1, 3),
(@s2, 'Hotel Booking or Accommodation Proof', 'A confirmed hotel booking, or an invitation letter if staying with a host in Mexico.', 'copy', 1, 0, 1, 4);

-- Section 03 — Employment / Professional Documents (public)
INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES
(@checklist_id, 'Employment / Professional Documents', 'Evidence of your employment or business, and that you intend to return to it.', 3);
SET @s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@s3, 'Employment Letter / No-Objection Certificate', 'From your employer, confirming your role, leave approval, and intent to return.', 'original', 1, 0, 1, 1),
(@s3, 'Business Registration Certificate', 'For self-employed or business-owner applicants, in place of an employment letter.', 'copy', 0, 1, 1, 2),
(@s3, 'Recent Salary Slips', 'Typically the last 3 months.', 'copy', 1, 0, 1, 3);

-- Section 04 — Financial Documents (locked)
INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES
(@checklist_id, 'Financial Documents', 'Evidence you can support the cost of your trip.', 4);
SET @s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@s4, 'Bank Statement', 'Typically the last 6 months, showing sufficient funds for the trip.', 'original', 1, 0, 0, 1),
(@s4, 'Income Tax Returns', 'Typically the last 2 years.', 'copy', 1, 0, 0, 2),
(@s4, 'Sponsorship Letter', 'If someone else is funding your trip, a letter and their financial proof.', 'original', 0, 1, 0, 3);

-- Section 05 — Travel / Supporting Documents (locked)
INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES
(@checklist_id, 'Travel / Supporting Documents', 'Additional evidence that strengthens a tourist-visa application.', 5);
SET @s5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@s5, 'Travel Insurance', 'Covering the full duration of your stay in Mexico.', 'copy', 0, 1, 0, 1),
(@s5, 'Valid US / UK / Canada / Japan / Schengen Visa or Residence Permit', 'If you hold one of these, valid and multiple-entry, you may be able to enter Mexico under its visa-waiver policy instead of applying for a separate Mexican visa — check with our team before starting a full application.', 'copy', 0, 1, 0, 2),
(@s5, 'Marriage Certificate', 'For applications submitted jointly with a spouse.', 'copy', 0, 1, 0, 3);

-- Section 06 — Additional Documents (locked)
INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES
(@checklist_id, 'Additional Documents', 'Situational documents that apply to some applicants.', 6);
SET @s6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@s6, 'Company Authorization Letter', 'If part of your trip includes any business activity alongside tourism.', 'original', 0, 1, 0, 1),
(@s6, 'Property Documents', 'Optional supporting evidence of ties to India (property ownership).', 'copy', 0, 1, 0, 2);

-- Section 07 — Appointment & Submission (locked)
INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES
(@checklist_id, 'Appointment & Submission', 'What happens at the consulate/visa application centre itself.', 7);
SET @s7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@s7, 'Consulate Appointment Confirmation', 'Personal appearance is typically required for a Mexican tourist visa application.', 'original', 1, 0, 0, 1),
(@s7, 'Visa Fee Payment Receipt', 'Proof of the consular fee payment.', 'original', 1, 0, 0, 2),
(@s7, 'Passport Submission Acknowledgement', 'The receipt given when your passport is submitted for visa stamping.', 'original', 1, 0, 0, 3);

-- Section 08 — Final Verification (locked)
INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES
(@checklist_id, 'Final Verification', 'Final checks before and after your visa is issued.', 8);
SET @s8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@s8, 'Document Checklist Sign-Off', 'A final review against this checklist before submission, which our team can help with.', 'original', 1, 0, 0, 1),
(@s8, 'Application Tracking Reference', 'Given once your application is submitted, to track status.', 'original', 1, 0, 0, 2),
(@s8, 'Passport Collection Instructions', 'How and when to collect your passport once the visa is issued.', 'original', 1, 0, 0, 3);

-- Manually admin-controlled fee — see includes/visa-checklist.php's
-- set_visa_fee() for how this should be changed going forward rather
-- than a raw UPDATE; inserted directly here since no admin UI exists
-- yet to drive it (see AUDIT.md).
INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, last_updated, source_url, updated_by)
VALUES (172, 1, 53.00, 'USD', 'Current Consular Fee', 'Payable in Indian Rupees at the exchange rate applicable on the date of application. The Mexican Consulate sets and revises this fee independently of Visagiri — confirm the current amount with our team before paying.', NOW(), 'https://btwvisas.com/visa-guide/mexico-visa', 'Visagiri Content Team');
