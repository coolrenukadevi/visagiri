-- Mexico Business, Student, Work, Family Visit, Transit, Medical,
-- Conference, Sports, and Dependent Visa checklists for Indian
-- applicants — completes the Mexico country (Tourist was the first,
-- see seed-checklist-mexico-tourist.sql), built to the same standard:
-- every fact below was researched via web search this session, not
-- invented. Sourcing notes:
--   - The flat USD ~53-56 consular fee, the 6-month/2-blank-page
--     passport rule, and the US/UK/Canada/Japan/Schengen visa-waiver
--     policy are the same facts already sourced for Tourist and apply
--     to every Mexican visa category, so they're reused here rather
--     than re-cited per type.
--   - Mexico has NO distinct "Medical Visa" or "Sports Visa" legal
--     category — search results confirm applicants for medical
--     treatment or sporting events apply under the general Visitor
--     Visa with purpose-specific supporting documents. This is stated
--     honestly in both checklists' eligibility_summary rather than
--     inventing a category that doesn't exist.
--   - Work visa: requires the Mexican employer to be pre-registered
--     with INM (Instituto Nacional de Migración) and to sponsor the
--     application before the employee applies at the consulate.
--   - Dependent visa: spouse/child of a Mexican temporary or permanent
--     resident; the principal resident must show an extra ~220x UMA
--     (~USD 1,390/month) in income/savings per dependent, and
--     marriage/birth certificates must be apostilled.
--   - See AUDIT.md's "Mexico — remaining 9 visa types" entry for the
--     full source list and caveats.
--
-- country_id 172 = Mexico. visa_type_id: 2=Business, 3=Student,
-- 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent (database/seed.sql's shared catalog).

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    172, 2, 'MEX-BUS-IN-02', '2026.09', 'published',
    'Short-term business meetings, negotiations, supplier/site visits, and other professional engagements in Mexico.',
    'Indian passport holders without a valid US/UK/Canada/Japan/Schengen visa or residence permit (which may qualify for visa-waived entry instead) generally need to apply for this visa directly.',
    'Up to 180 days per entry',
    'In person, through the Embassy of Mexico or its visa application partner in India',
    1,
    '2-10 working days (indicative)',
    'Embassy of Mexico, New Delhi',
    'Confirm you actually need this visa (check the US/UK/Canada/Japan/Schengen visa-waiver option first)\nObtain a business invitation letter from the Mexican company you are visiting\nGather and organise your documents against this checklist\nComplete and sign the visa application form\nBook your consulate appointment\nAttend in person with your original documents and pay the consular fee\nCollect your passport once the visa is issued',
    '/assets/images/visa-heroes/mexico-city.jpg',
    'Consular guidance and independent visa-agency sources for Mexico business visas issued to Indian passport holders', 'https://btwvisas.com/visa-guide/mexico-business-visa', '2026-09-11'
);
SET @bid = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bid, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bid, 'Core Documents', 'Every applicant needs these regardless of the business purpose.', 1);
SET @b1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@b1, 'Valid Passport', 'Valid for at least 6 months beyond your planned arrival in Mexico, with at least 2 blank visa pages.', 'original', 1, 0, 1, 1),
(@b1, 'Passport Copy', 'A clear photocopy of the passport bio-data page.', 'copy', 1, 0, 1, 2),
(@b1, 'Previous Passports', 'If you hold expired passports with earlier travel history, include them — they can support your application.', 'copy', 0, 1, 1, 3),
(@b1, 'Passport-Size Photograph', 'Recent, white background, matching Mexican visa photo specifications.', 'original', 1, 0, 1, 4);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bid, 'Business Invitation & Purpose', 'Evidence of who you are meeting in Mexico and why.', 2);
SET @b2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@b2, 'Business Invitation Letter', 'From the Mexican company you are visiting, on letterhead, signed by an authorised representative, stating purpose, dates, and company stamp — ideally in both English and Spanish.', 'original', 1, 0, 1, 1),
(@b2, 'Cover Letter', 'A short letter from you (or your employer) explaining the business purpose, itinerary, and intended dates.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bid, 'Financial Documents', 'Evidence you can support the cost of your trip.', 3);
SET @b3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@b3, 'Bank Statements', 'Last 3 months, showing either a monthly income of roughly INR 1.2-1.25 lakh or an average balance of roughly INR 3.5-3.75 lakh (indicative thresholds — confirm current figures with our team).', 'copy', 1, 0, 0, 1),
(@b3, 'Income Tax Returns', 'Typically the last 2 years.', 'copy', 0, 1, 0, 2),
(@b3, 'Salary Slips / Business Proof', 'Recent salary slips, or business registration/ownership proof if self-employed.', 'copy', 1, 0, 0, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bid, 'Employment / Professional Documents', 'Evidence of your role and that you intend to return to it.', 4);
SET @b4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@b4, 'Employment Letter / No-Objection Certificate', 'From your employer, confirming your role, leave approval, and intent to return.', 'original', 1, 0, 0, 1),
(@b4, 'Business Registration Certificate', 'For self-employed or business-owner applicants, in place of an employment letter.', 'copy', 0, 1, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bid, 'Travel / Supporting Documents', 'Your travel and stay arrangements in Mexico.', 5);
SET @b5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@b5, 'Confirmed Return/Onward Flight Itinerary', NULL, 'copy', 1, 0, 0, 1),
(@b5, 'Hotel Booking or Accommodation Proof', 'A confirmed hotel booking, or a letter from your Mexican host/company if staying with them.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bid, 'Appointment & Submission', 'Booking and attending your consulate appointment.', 6);
SET @b6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@b6, 'Consulate Appointment Confirmation', 'Personal appearance is typically required for a Mexican business visa application.', 'original', 1, 0, 0, 1),
(@b6, 'Visa Fee Payment Receipt', 'Proof of the consular fee payment.', 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bid, 'Final Verification', 'What happens after submission.', 7);
SET @b7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@b7, 'Passport Submission Acknowledgement', 'Given when your passport is submitted for visa stamping.', 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(172, 2, 53.00, 'USD', 'Current Consular Fee', 'Consular fee, payable in INR at the applicable exchange rate; confirm the current amount before paying.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/mexico-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a business visa to attend meetings in Mexico?', 'Usually yes, unless you hold a valid multiple-entry US/UK/Canada/Japan/Schengen visa or residence permit, in which case Mexico''s visa-waiver policy may apply instead. Confirm with our team before assuming either way.', 172, 2, 320, 1),
('What income or savings do I need to show for a Mexico business visa?', 'Consulates commonly look for either a monthly income or an average bank balance in a specific range — the exact current figures can vary, so we confirm the latest thresholds with you before you apply.', 172, 2, 321, 1),
('Do I need an invitation letter from the Mexican company I am visiting?', 'Yes — a business invitation letter from the host company, ideally in English and Spanish and on their letterhead, is a core requirement for this visa.', 172, 2, 322, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    172, 3, 'MEX-STU-IN-03', '2026.09', 'published',
    'Full-time study at a recognised Mexican educational institution.',
    'All Indian students intending to study in Mexico need either a Temporary Resident Student Visa (courses longer than 180 days) or a Visitor Student Visa (courses of 180 days or less) — the visa-waiver policy that applies to some other visa categories does not exempt students from this requirement.',
    'Duration of the course, typically renewable annually',
    'In person, through the Embassy of Mexico or its visa application partner in India',
    1,
    'Around 10-12 working days after biometrics (indicative)',
    'Embassy of Mexico, New Delhi',
    'Secure admission to a recognised Mexican institution\nGather and organise your documents against this checklist\nComplete and sign the visa application form\nBook your consulate appointment\nAttend in person for biometrics/appearance and pay the consular fee\nCollect your passport once the visa is issued\nExchange for a Temporary Resident Card after arrival, if applicable',
    '/assets/images/visa-heroes/mexico-city.jpg',
    'Consular guidance and independent visa-agency sources for Mexico student visas issued to Indian passport holders', 'https://www.indiainmexico.gov.in/eoimx_pages/Mzcz', '2026-09-11'
);
SET @sid = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sid, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sid, 'Core Documents', 'Every applicant needs these.', 1);
SET @s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@s1, 'Valid Passport', 'Valid for at least 6 months beyond your planned stay, with at least 2 blank visa pages.', 'original', 1, 0, 1, 1),
(@s1, 'Passport Copy', 'A clear photocopy of the passport bio-data page.', 'copy', 1, 0, 1, 2),
(@s1, 'Previous Passports', 'If you hold expired passports with earlier travel history.', 'copy', 0, 1, 1, 3),
(@s1, 'Passport-Size Photograph', 'Recent, white background, matching Mexican visa photo specifications.', 'original', 1, 0, 1, 4);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sid, 'Admission & Academic Documents', 'Proof of your place at a Mexican institution.', 2);
SET @s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@s2, 'Offer / Acceptance Letter', 'Original letter from the Mexican college or university confirming your admission and course dates.', 'original', 1, 0, 1, 1),
(@s2, 'Academic Transcripts & Certificates', 'Your prior academic records supporting the application.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sid, 'Financial Documents', 'Evidence you can fund your study and stay.', 3);
SET @s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@s3, 'Bank Statements', 'Typically the last 6-10 months, showing sufficient funds for tuition and stay.', 'copy', 1, 0, 0, 1),
(@s3, 'Income Tax Returns', 'Typically the last 2 years, for yourself or your sponsor.', 'copy', 0, 1, 0, 2),
(@s3, 'Sponsor Financial Proof', 'If a parent or sponsor is funding your studies, their income/bank proof and a sponsorship letter.', 'copy', 0, 1, 0, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sid, 'Travel / Supporting Documents', 'Insurance and accommodation while you study.', 4);
SET @s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@s4, 'Travel Insurance', 'Covering the full duration of your stay in Mexico.', 'copy', 1, 0, 0, 1),
(@s4, 'Accommodation Proof', 'Hostel/hall booking, rental agreement, or host address in Mexico.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sid, 'Additional Documents', 'Explaining your study plans.', 5);
SET @s5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@s5, 'Cover Letter', 'A short letter stating your course, institution, and study plans.', 'original', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sid, 'Appointment & Submission', 'Booking and attending your consulate appointment.', 6);
SET @s6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@s6, 'Consulate Appointment Confirmation', 'Personal appearance is typically required for a student visa application.', 'original', 1, 0, 0, 1),
(@s6, 'Visa Fee Payment Receipt', 'Proof of the consular fee payment.', 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sid, 'Final Verification', 'What happens after submission.', 7);
SET @s7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@s7, 'Passport Submission Acknowledgement', 'Given when your passport is submitted for visa stamping.', 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(172, 3, 53.00, 'USD', 'Current Consular Fee', 'Consular fee, payable in INR at the applicable exchange rate; confirm the current amount before paying.', '2026-09-01', NOW(), 'https://www.akbartravels.com/in/visas/mexico-student-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does the Mexico visa-waiver policy apply to students?', 'No — unlike some other visa categories, students need a Mexican student visa regardless of any US/UK/Canada/Japan/Schengen visa they hold.', 172, 3, 330, 1),
('How long does a Mexico student visa take to process?', 'Commonly around 10-12 working days after biometrics, though this can vary — apply well ahead of your course start date.', 172, 3, 331, 1),
('Do I need travel insurance for a Mexico student visa?', 'Yes — travel insurance covering your full stay is a standard requirement for the student visa application.', 172, 3, 332, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    172, 4, 'MEX-WORK-IN-04', '2026.09', 'published',
    'Employment in Mexico under a confirmed job offer from a Mexican employer.',
    'Requires a Mexican employer registered with INM (Instituto Nacional de Migración) to sponsor the application; the visa-waiver policy available for some other categories does not apply to work visas.',
    'Typically up to 1 year initially (Temporary Resident Visa with work permission), renewable',
    'Employer-sponsored: the Mexican employer first files with INM; once approved, you apply at the Mexican consulate in India',
    1,
    '10-15 working days after INM approval (indicative)',
    'Embassy of Mexico, New Delhi',
    'Your Mexican employer registers with INM and files a sponsorship request on your behalf\nOnce INM approves, gather and organise your documents against this checklist\nComplete and sign the visa application form\nBook your consulate appointment\nAttend in person and pay the consular fee\nCollect your passport once the visa is issued\nExchange your visa for a Temporary Resident Card with work authorisation after arrival',
    '/assets/images/visa-heroes/mexico-city.jpg',
    'Consular and employer-immigration guidance for Mexico work visas issued to Indian passport holders', 'https://www.usemultiplier.com/mexico/work-visa', '2026-09-11'
);
SET @wid = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@wid, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@wid, 'Core Documents', 'Every applicant needs these.', 1);
SET @w1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@w1, 'Valid Passport', 'Valid for at least 6 months beyond your planned arrival, with at least 2 blank visa pages.', 'original', 1, 0, 1, 1),
(@w1, 'Passport Copy', 'A clear photocopy of the passport bio-data page.', 'copy', 1, 0, 1, 2),
(@w1, 'Previous Passports', 'If you hold expired passports with earlier travel history.', 'copy', 0, 1, 1, 3),
(@w1, 'Passport-Size Photograph', 'Recent, white background, matching Mexican visa photo specifications.', 'original', 1, 0, 1, 4);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@wid, 'Employer Sponsorship Documents', 'Proof your Mexican employer has sponsored your application through INM.', 2);
SET @w2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@w2, 'INM Approval / Unique Procedure Number (NUT)', 'Confirmation that your employer''s sponsorship request has been approved by INM before you apply at the consulate.', 'original', 1, 0, 1, 1),
(@w2, 'Job Offer Letter', 'From your Mexican employer, stating your role, duties, duration, and salary.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@wid, 'Employment / Professional Documents', 'Your qualifications for the role.', 3);
SET @w3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@w3, 'Resume / CV', 'Your current professional resume.', 'copy', 1, 0, 0, 1),
(@w3, 'Educational & Professional Qualification Certificates', 'Degrees, licences, or certifications relevant to the role.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@wid, 'Financial Documents', 'Supporting your application alongside the job offer.', 4);
SET @w4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@w4, 'Bank Statements', 'Recent statements, typically the last 3 months.', 'copy', 0, 1, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@wid, 'Travel / Supporting Documents', 'Your arrival arrangements.', 5);
SET @w5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@w5, 'Confirmed Flight Itinerary', NULL, 'copy', 1, 0, 0, 1),
(@w5, 'Accommodation Proof', 'Your planned address in Mexico on arrival.', 'copy', 0, 1, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@wid, 'Appointment & Submission', 'Booking and attending your consulate appointment.', 6);
SET @w6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@w6, 'Consulate Appointment Confirmation', 'Personal appearance is typically required.', 'original', 1, 0, 0, 1),
(@w6, 'Visa Fee Payment Receipt', 'Proof of the consular fee payment.', 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@wid, 'Final Verification', 'What happens after submission and arrival.', 7);
SET @w7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@w7, 'Passport Submission Acknowledgement', 'Given when your passport is submitted for visa stamping.', 'original', 1, 0, 0, 1),
(@w7, 'Temporary Resident Card Exchange Instructions', 'Your work visa must be exchanged for a physical Temporary Resident Card after you arrive in Mexico.', 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(172, 4, 53.00, 'USD', 'Current Consular Fee', 'Consular fee, payable in INR at the applicable exchange rate; confirm the current amount before paying. Separate INM/employer-side fees may also apply.', '2026-09-01', NOW(), 'https://www.tataaig.com/travel-insurance/mexico-work-visa-for-indians', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I apply for a Mexico work visa without a job offer?', 'No — a confirmed job offer from an INM-registered Mexican employer, and their INM sponsorship approval, is required before you can apply at the consulate.', 172, 4, 340, 1),
('Does the visa-waiver policy apply to work visas?', 'No — the visa-waiver option available for some tourist/business travellers does not apply to work visas; a work visa is always required regardless of other visas you hold.', 172, 4, 341, 1),
('What happens after my Mexico work visa is approved?', 'You collect your visa-stamped passport, travel to Mexico, and exchange the visa for a physical Temporary Resident Card with work authorisation shortly after arrival.', 172, 4, 342, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    172, 5, 'MEX-FAM-IN-05', '2026.09', 'published',
    'Visiting family or friends residing in Mexico.',
    'Indian passport holders without a valid US/UK/Canada/Japan/Schengen visa or residence permit (which may qualify for visa-waived entry instead) generally need to apply for this visa directly.',
    'Up to 180 days per entry',
    'In person, through the Embassy of Mexico or its visa application partner in India',
    1,
    '10-15 working days (indicative)',
    'Embassy of Mexico, New Delhi',
    'Confirm you actually need this visa (check the US/UK/Canada/Japan/Schengen visa-waiver option first)\nAsk your host in Mexico for a notarised invitation letter and their supporting documents\nGather and organise your own documents against this checklist\nComplete and sign the visa application form\nBook your consulate appointment\nAttend in person with your original documents and pay the consular fee\nCollect your passport once the visa is issued',
    '/assets/images/visa-heroes/mexico-city.jpg',
    'Consular guidance and independent visa-agency sources for Mexico family-visit visas issued to Indian passport holders', 'https://www.tataaig.com/knowledge-center/travel-insurance/mexico-visa-requirements-for-indians', '2026-09-11'
);
SET @fid = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fid, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fid, 'Core Documents', 'Every applicant needs these.', 1);
SET @f1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@f1, 'Valid Passport', 'Valid for at least 6 months beyond your planned arrival, with at least 2 blank visa pages.', 'original', 1, 0, 1, 1),
(@f1, 'Passport Copy', 'A clear photocopy of the passport bio-data page.', 'copy', 1, 0, 1, 2),
(@f1, 'Previous Passports', 'If you hold expired passports with earlier travel history.', 'copy', 0, 1, 1, 3),
(@f1, 'Passport-Size Photograph', 'Recent, white background, matching Mexican visa photo specifications.', 'original', 1, 0, 1, 4);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fid, 'Invitation & Host Documents', 'Evidence of who you are visiting in Mexico.', 2);
SET @f2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@f2, 'Notarised Invitation Letter', 'From your host in Mexico, stating the relationship, purpose, and duration of your visit.', 'original', 1, 0, 1, 1),
(@f2, 'Host''s Bank Statement', 'Typically the last 6 months, showing the host can support your visit.', 'copy', 1, 0, 1, 2),
(@f2, 'Host''s Passport / Residency Proof', 'A copy of the host''s passport and Mexican residence permit or citizenship proof.', 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fid, 'Financial Documents', 'Your own financial standing.', 3);
SET @f3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@f3, 'Bank Statements', 'Typically the last 3 months.', 'copy', 1, 0, 0, 1),
(@f3, 'Income Tax Returns', 'Typically the last 2 years.', 'copy', 0, 1, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fid, 'Travel / Supporting Documents', 'Your travel arrangements.', 4);
SET @f4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@f4, 'Confirmed Return/Onward Flight Itinerary', NULL, 'copy', 1, 0, 0, 1),
(@f4, 'Travel Insurance', 'Covering the duration of your stay.', 'copy', 0, 1, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fid, 'Appointment & Submission', 'Booking and attending your consulate appointment.', 5);
SET @f5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@f5, 'Consulate Appointment Confirmation', 'Personal appearance is typically required.', 'original', 1, 0, 0, 1),
(@f5, 'Visa Fee Payment Receipt', 'Proof of the consular fee payment.', 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fid, 'Final Verification', 'What happens after submission.', 6);
SET @f6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@f6, 'Passport Submission Acknowledgement', 'Given when your passport is submitted for visa stamping.', 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(172, 5, 53.00, 'USD', 'Current Consular Fee', 'Consular fee, payable in INR at the applicable exchange rate; confirm the current amount before paying.', '2026-09-01', NOW(), 'https://www.tataaig.com/knowledge-center/travel-insurance/mexico-visa-requirements-for-indians', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What kind of invitation letter do I need from my host in Mexico?', 'A notarised letter from your host stating your relationship, the purpose and dates of your visit, plus their own bank statement and residency/passport proof.', 172, 5, 350, 1),
('Do I need my own financial documents if my host is supporting me?', 'Yes — consulates typically still expect your own bank statements alongside your host''s supporting documents.', 172, 5, 351, 1),
('How long can I stay in Mexico on a family visit visa?', 'Typically up to 180 days per entry, though the exact duration granted is at the consulate''s discretion.', 172, 5, 352, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    172, 6, 'MEX-TRANS-IN-06', '2026.09', 'published',
    'Connecting through a Mexican airport en route to a third country.',
    'A short, same-airport connection without leaving the international zone commonly does not require a separate visa. A transit visa IS required for longer layovers, leaving the international zone, or other itineraries — confirm your specific case with us before travelling.',
    'Duration of transit only (commonly under 24 hours)',
    'In person, through the Embassy of Mexico or its visa application partner in India',
    1,
    '7-10 working days (indicative)',
    'Embassy of Mexico, New Delhi',
    'Confirm with us whether your specific layover actually requires a transit visa\nConfirm your onward ticket departs from the same airport, with no intermediate landings in Mexico\nGather and organise your documents against this checklist\nComplete and sign the visa application form\nBook your consulate appointment\nAttend in person with your original documents and pay the consular fee\nCollect your passport once the visa is issued',
    '/assets/images/visa-heroes/mexico-city.jpg',
    'Consular and airline guidance for Mexico transit visas for Indian passport holders', 'https://legalclarity.org/mexico-transit-visa-requirements-and-how-to-apply/', '2026-09-11'
);
SET @tid = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tid, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tid, 'Core Documents', 'Every applicant needs these.', 1);
SET @t1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t1, 'Valid Passport', 'Valid for at least 6 months beyond your travel dates, with at least 2 blank visa pages.', 'original', 1, 0, 1, 1),
(@t1, 'Passport Copy', 'A clear photocopy of the passport bio-data page.', 'copy', 1, 0, 1, 2),
(@t1, 'Passport-Size Photograph', 'Recent, white background, matching Mexican visa photo specifications.', 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tid, 'Onward Journey Documents', 'Evidence of your connecting flight and final destination.', 2);
SET @t2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t2, 'Confirmed Onward Ticket to Third Country', 'Showing you arrive, depart, and stay at the same Mexican airport for the connection.', 'copy', 1, 0, 1, 1),
(@t2, 'Visa for Next Destination', 'If your final destination requires one.', 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tid, 'Travel / Supporting Documents', 'Additional proof of your transit arrangements.', 3);
SET @t3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t3, 'Full Itinerary', 'Showing both inbound and onward flight details and layover duration.', 'copy', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tid, 'Appointment & Submission', 'Booking and attending your consulate appointment, if a visa is required.', 4);
SET @t4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@t4, 'Consulate Appointment Confirmation', 'Only applicable if your specific transit case requires a visa.', 'original', 0, 1, 0, 1),
(@t4, 'Visa Fee Payment Receipt', 'Proof of the consular fee payment, if applicable.', 'original', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(172, 6, 53.00, 'USD', 'Current Consular Fee', 'Applies only if your specific transit case requires a visa — many short, same-airport connections do not. Confirm with us first.', '2026-09-01', NOW(), 'https://legalclarity.org/mexico-transit-visa-requirements-and-how-to-apply/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa just to transit through a Mexican airport?', 'Not always — a short, same-airport connection without leaving the international zone commonly does not require one, but longer layovers or specific itineraries can. Confirm your exact case with us before booking.', 172, 6, 360, 1),
('What changed with Mexico''s transit rules in 2023?', 'Since October 2023, visa-required nationals must hold a visa before boarding any flight to Mexico if their specific itinerary requires one — the old option of avoiding a visa by staying airside no longer applies universally.', 172, 6, 361, 1),
('How long can I transit through Mexico without a visa?', 'Commonly under 24 hours, at the same airport, without leaving the international zone — but this depends on your specific booking, so confirm with us first.', 172, 6, 362, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Mexico has no distinct medical-visa
-- category; applicants use the general Visitor Visa with medical
-- purpose documentation. Stated honestly rather than inventing a
-- category that doesn't exist.
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    172, 7, 'MEX-MED-IN-07', '2026.09', 'published',
    'Travelling to Mexico for medical treatment or a hospital appointment.',
    'Mexico does not operate a distinct "medical visa" category — Indian applicants travelling for treatment apply under the standard Visitor Visa, supported by medical-purpose documents. The general US/UK/Canada/Japan/Schengen visa-waiver policy may still apply if you hold one of those visas/residence permits.',
    'Up to 180 days per entry, or as needed for your treatment course',
    'In person, through the Embassy of Mexico or its visa application partner in India',
    1,
    '10-15 working days (indicative)',
    'Embassy of Mexico, New Delhi',
    'Confirm your treatment/hospital appointment in Mexico and obtain supporting medical documents\nConfirm you actually need this visa (check the US/UK/Canada/Japan/Schengen visa-waiver option first)\nGather and organise your documents against this checklist\nComplete and sign the visa application form\nBook your consulate appointment\nAttend in person with your original documents and pay the consular fee\nCollect your passport once the visa is issued',
    '/assets/images/visa-heroes/mexico-city.jpg',
    'Consular guidance for Mexico visitor visas used for medical treatment by Indian passport holders', 'https://www.indiainmexico.gov.in/eoimx_pages/Mzc1', '2026-09-11'
);
SET @mid = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@mid, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mid, 'Core Documents', 'Every applicant needs these.', 1);
SET @m1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@m1, 'Valid Passport', 'Valid for at least 6 months beyond your planned arrival, with at least 2 blank visa pages.', 'original', 1, 0, 1, 1),
(@m1, 'Passport Copy', 'A clear photocopy of the passport bio-data page.', 'copy', 1, 0, 1, 2),
(@m1, 'Passport-Size Photograph', 'Recent, white background, matching Mexican visa photo specifications.', 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mid, 'Medical Purpose Documents', 'Evidence of your treatment in Mexico.', 2);
SET @m2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@m2, 'Hospital Appointment / Treatment Letter', 'From the Mexican hospital or clinic, confirming your appointment and expected treatment dates.', 'original', 1, 0, 1, 1),
(@m2, 'Doctor''s Referral Letter', 'From your treating doctor in India, if applicable.', 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mid, 'Financial Documents', 'Evidence you can fund treatment and stay.', 3);
SET @m3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@m3, 'Bank Statements', 'Typically the last 3 months.', 'copy', 1, 0, 0, 1),
(@m3, 'Proof of Funds for Treatment', 'Cost estimate from the hospital plus proof you can cover it.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mid, 'Travel / Supporting Documents', 'Your travel and stay arrangements.', 4);
SET @m4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@m4, 'Confirmed Flight Itinerary', NULL, 'copy', 1, 0, 0, 1),
(@m4, 'Accommodation Proof', 'Hotel or hospital-stay confirmation for the treatment period.', 'copy', 1, 0, 0, 2),
(@m4, 'Travel Insurance', 'Covering the duration of your stay, where separate from treatment costs.', 'copy', 0, 1, 0, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mid, 'Appointment & Submission', 'Booking and attending your consulate appointment.', 5);
SET @m5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@m5, 'Consulate Appointment Confirmation', 'Personal appearance is typically required.', 'original', 1, 0, 0, 1),
(@m5, 'Visa Fee Payment Receipt', 'Proof of the consular fee payment.', 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@mid, 'Final Verification', 'What happens after submission.', 6);
SET @m6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@m6, 'Passport Submission Acknowledgement', 'Given when your passport is submitted for visa stamping.', 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(172, 7, 53.00, 'USD', 'Current Consular Fee', 'Standard Visitor Visa consular fee — Mexico has no separate medical-visa fee category.', '2026-09-01', NOW(), 'https://www.indiainmexico.gov.in/eoimx_pages/Mzc1', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Mexico have a separate medical visa?', 'No — Mexico does not have a distinct medical-visa category. Indian applicants travelling for treatment apply under the standard Visitor Visa, supported by hospital/treatment documents.', 172, 7, 370, 1),
('What documents does the hospital need to provide?', 'A letter confirming your appointment and expected treatment dates, plus a cost estimate — both help support your visa application.', 172, 7, 371, 1),
('Do I need travel insurance for medical treatment in Mexico?', 'It''s recommended, and may be required depending on your treatment arrangements — confirm with us based on your specific hospital and treatment plan.', 172, 7, 372, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    172, 8, 'MEX-CONF-IN-08', '2026.09', 'published',
    'Attending a conference, seminar, or business meeting in Mexico.',
    'Indian passport holders without a valid US/UK/Canada/Japan/Schengen visa or residence permit (which may qualify for visa-waived entry instead) generally need to apply for this visa directly.',
    'Up to 180 days per entry',
    'In person, through the Embassy of Mexico or its visa application partner in India',
    1,
    '2-10 working days (indicative)',
    'Embassy of Mexico, New Delhi',
    'Confirm you actually need this visa (check the US/UK/Canada/Japan/Schengen visa-waiver option first)\nObtain an official invitation letter from the conference organiser\nGather and organise your documents against this checklist\nComplete and sign the visa application form\nBook your consulate appointment\nAttend in person with your original documents and pay the consular fee\nCollect your passport once the visa is issued',
    '/assets/images/visa-heroes/mexico-city.jpg',
    'Consular guidance and independent visa-agency sources for Mexico conference visas issued to Indian passport holders', 'https://www.indiainmexico.gov.in/eoimx_pages/Mzc2', '2026-09-11'
);
SET @cid = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cid, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cid, 'Core Documents', 'Every applicant needs these.', 1);
SET @c1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@c1, 'Valid Passport', 'Valid for at least 6 months beyond your planned arrival, with at least 2 blank visa pages.', 'original', 1, 0, 1, 1),
(@c1, 'Passport Copy', 'A clear photocopy of the passport bio-data page.', 'copy', 1, 0, 1, 2),
(@c1, 'Passport-Size Photograph', 'Recent, white background, matching Mexican visa photo specifications.', 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cid, 'Conference Invitation Documents', 'Evidence of the event you are attending.', 2);
SET @c2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@c2, 'Official Invitation Letter', 'From the organiser, on their letterhead, stating the event''s duration, programme, and your name and passport number.', 'original', 1, 0, 1, 1),
(@c2, 'Conference Registration Confirmation', 'Proof you are registered to attend.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cid, 'Financial Documents', 'Evidence you can support your trip.', 3);
SET @c3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@c3, 'Bank Statements', 'Typically the last 3 months.', 'copy', 1, 0, 0, 1),
(@c3, 'Employment Proof', 'Employment letter or business proof confirming your role and intent to return.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cid, 'Travel / Supporting Documents', 'Your travel and stay arrangements.', 4);
SET @c4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@c4, 'Confirmed Flight & Accommodation Booking', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cid, 'Appointment & Submission', 'Booking and attending your consulate appointment.', 5);
SET @c5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@c5, 'Consulate Appointment Confirmation', 'Personal appearance is typically required.', 'original', 1, 0, 0, 1),
(@c5, 'Visa Fee Payment Receipt', 'Proof of the consular fee payment.', 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cid, 'Final Verification', 'What happens after submission.', 6);
SET @c6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@c6, 'Passport Submission Acknowledgement', 'Given when your passport is submitted for visa stamping.', 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(172, 8, 53.00, 'USD', 'Current Consular Fee', 'Consular fee, payable in INR at the applicable exchange rate; confirm the current amount before paying.', '2026-09-01', NOW(), 'https://www.indiainmexico.gov.in/eoimx_pages/Mzc2', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What must the conference invitation letter include?', 'The event''s duration and programme, plus your name and passport number — it should be sent on the organiser''s letterhead with their contact details.', 172, 8, 380, 1),
('How quickly can a Mexico conference visa be processed?', 'Commonly 2-10 working days, though this can be expedited in some cases — apply as early as possible once your event is confirmed.', 172, 8, 381, 1),
('Do I need proof I will return to India after the conference?', 'Yes — employment or business proof showing your ongoing role in India is a standard part of the application.', 172, 8, 382, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Mexico has no distinct sports-visa
-- category; applicants use the general Visitor Visa with event/
-- federation documentation. Stated honestly rather than inventing a
-- category that doesn't exist.
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    172, 9, 'MEX-SPORT-IN-09', '2026.09', 'published',
    'Participating in a sporting event, tournament, or training camp in Mexico.',
    'Mexico does not operate a distinct "sports visa" category — Indian athletes/officials apply under the standard Visitor Visa, supported by event or federation documents. The general US/UK/Canada/Japan/Schengen visa-waiver policy may still apply if you hold one of those visas/residence permits.',
    'Up to 180 days per entry, or as needed for the event',
    'In person, through the Embassy of Mexico or its visa application partner in India',
    1,
    '10-15 working days (indicative)',
    'Embassy of Mexico, New Delhi',
    'Confirm your event/federation invitation and gather event details\nConfirm you actually need this visa (check the US/UK/Canada/Japan/Schengen visa-waiver option first)\nGather and organise your documents against this checklist\nComplete and sign the visa application form\nBook your consulate appointment\nAttend in person with your original documents and pay the consular fee\nCollect your passport once the visa is issued',
    '/assets/images/visa-heroes/mexico-city.jpg',
    'Consular guidance for Mexico visitor visas used for sporting events by Indian passport holders', 'https://www.akbartravels.com/in/visas/mexico-visa-requirements-documents', '2026-09-11'
);
SET @spid = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@spid, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@spid, 'Core Documents', 'Every applicant needs these.', 1);
SET @sp1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sp1, 'Valid Passport', 'Valid for at least 6 months beyond your planned arrival, with at least 2 blank visa pages.', 'original', 1, 0, 1, 1),
(@sp1, 'Passport Copy', 'A clear photocopy of the passport bio-data page.', 'copy', 1, 0, 1, 2),
(@sp1, 'Passport-Size Photograph', 'Recent, white background, matching Mexican visa photo specifications.', 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@spid, 'Sporting Event Documents', 'Evidence of the event you are attending.', 2);
SET @sp2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sp2, 'Federation / Event Invitation or Nomination Letter', 'From the sports federation or event organiser, confirming your participation.', 'original', 1, 0, 1, 1),
(@sp2, 'Event Schedule & Details', 'Dates, venue, and nature of the event.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@spid, 'Financial Documents', 'Evidence you can support your trip.', 3);
SET @sp3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sp3, 'Bank Statements', 'Typically the last 3 months.', 'copy', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@spid, 'Travel / Supporting Documents', 'Your travel and stay arrangements.', 4);
SET @sp4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sp4, 'Confirmed Flight & Accommodation Booking', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@spid, 'Appointment & Submission', 'Booking and attending your consulate appointment.', 5);
SET @sp5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sp5, 'Consulate Appointment Confirmation', 'Personal appearance is typically required.', 'original', 1, 0, 0, 1),
(@sp5, 'Visa Fee Payment Receipt', 'Proof of the consular fee payment.', 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@spid, 'Final Verification', 'What happens after submission.', 6);
SET @sp6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sp6, 'Passport Submission Acknowledgement', 'Given when your passport is submitted for visa stamping.', 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(172, 9, 53.00, 'USD', 'Current Consular Fee', 'Standard Visitor Visa consular fee — Mexico has no separate sports-visa fee category.', '2026-09-01', NOW(), 'https://www.akbartravels.com/in/visas/mexico-visa-requirements-documents', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Mexico have a separate sports visa?', 'No — Mexico does not have a distinct sports-visa category. Athletes and officials apply under the standard Visitor Visa, supported by a federation or event invitation.', 172, 9, 390, 1),
('What proof of the event do I need?', 'A letter from your sports federation or the event organiser confirming your participation, plus the event''s schedule and venue details.', 172, 9, 391, 1),
('Can a whole team apply together for a Mexico sporting event?', 'Each athlete/official still submits their own individual application and documents, even when travelling as part of a team — confirm the exact process with us for group bookings.', 172, 9, 392, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    172, 10, 'MEX-DEP-IN-10', '2026.09', 'published',
    'Joining a spouse, parent, or family member who already holds Mexican temporary or permanent residency.',
    'The principal resident must show the income/savings required for their own residency PLUS roughly an additional 220x UMA (approximately USD 1,390/month) for each dependent family member. Marriage and birth certificates must be apostilled, and the principal resident must be present when you apply.',
    'Temporary Residency, typically 1 year initially, renewable up to 4 years before permanent-residency eligibility',
    'In person, together with or shortly after the principal resident''s own application, at the Embassy of Mexico or its visa application partner in India',
    1,
    '10-15 working days (indicative)',
    'Embassy of Mexico, New Delhi',
    'Confirm the principal resident''s Mexican residency status and their income/savings meet the combined threshold\nApostille your marriage or birth certificate establishing the family relationship\nGather and organise your documents against this checklist\nComplete and sign the visa application form\nBook your consulate appointment (the principal resident must also be present)\nAttend in person with your original documents and pay the consular fee\nCollect your passport once the visa is issued, and register with INM after arrival',
    '/assets/images/visa-heroes/mexico-city.jpg',
    'Consular and Mexican immigration guidance for dependents of Mexican residents, applied to Indian passport holders', 'https://www.mexperience.com/applying-for-permanent-residency-in-mexico-as-a-couple/', '2026-09-11'
);
SET @did = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@did, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@did, 'Core Documents', 'Every applicant needs these.', 1);
SET @d1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@d1, 'Valid Passport', 'Valid for at least 6 months beyond your planned arrival, with at least 2 blank visa pages.', 'original', 1, 0, 1, 1),
(@d1, 'Passport Copy', 'A clear photocopy of the passport bio-data page.', 'copy', 1, 0, 1, 2),
(@d1, 'Passport-Size Photograph', 'Recent, white background, matching Mexican visa photo specifications.', 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@did, 'Family Relationship Documents', 'Proof of your relationship to the principal resident.', 2);
SET @d2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@d2, 'Apostilled Marriage Certificate', 'For a spouse/partner applicant.', 'original', 0, 1, 1, 1),
(@d2, 'Apostilled Birth Certificate', 'For a dependent child applicant.', 'original', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@did, 'Principal Resident''s Documents', 'Proof of the Mexican resident you are joining.', 3);
SET @d3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@d3, 'Principal Resident''s Residency Card Copy', 'Their Mexican temporary or permanent resident card.', 'copy', 1, 0, 0, 1),
(@d3, 'Principal Resident''s Financial Proof', 'Income or savings/investment statements meeting the combined threshold, including the extra amount required per dependent.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@did, 'Financial Documents', 'Your own financial documents, if applicable.', 4);
SET @d4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@d4, 'Applicant''s Own Bank Statements', 'If you also hold independent income or savings.', 'copy', 0, 1, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@did, 'Travel / Supporting Documents', 'Your travel arrangements.', 5);
SET @d5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@d5, 'Confirmed Flight Itinerary', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@did, 'Appointment & Submission', 'Booking and attending your consulate appointment.', 6);
SET @d6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@d6, 'Consulate Appointment Confirmation', 'The principal resident must also be present at the time of application.', 'original', 1, 0, 0, 1),
(@d6, 'Visa Fee Payment Receipt', 'Proof of the consular fee payment.', 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@did, 'Final Verification', 'What happens after submission and arrival.', 7);
SET @d7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@d7, 'Passport Submission Acknowledgement', 'Given when your passport is submitted for visa stamping.', 'original', 1, 0, 0, 1),
(@d7, 'INM Registration Instructions', 'You must register/exchange your visa for a residency card with INM shortly after arrival in Mexico.', 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(172, 10, 53.00, 'USD', 'Current Consular Fee', 'Consular visa fee only — separate INM registration fees apply after arrival in Mexico.', '2026-09-01', NOW(), 'https://www.mexperience.com/applying-for-permanent-residency-in-mexico-as-a-couple/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How much extra income does the principal resident need per dependent?', 'Roughly an additional 220x UMA (about USD 1,390/month) per dependent family member, on top of their own qualifying income/savings — confirm the current figure with us, as it is tied to Mexico''s UMA rate.', 172, 10, 400, 1),
('Do marriage and birth certificates need to be apostilled?', 'Yes — an apostilled marriage certificate (for a spouse) or birth certificate (for a child) is required to prove the family relationship.', 172, 10, 401, 1),
('Does the principal resident need to be present when I apply?', 'Yes — the Mexican resident you are joining is typically required to be present at the time of your dependent-visa application.', 172, 10, 402, 1);
