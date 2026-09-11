-- New Zealand Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search, same standard as Mexico/Singapore/
-- France/Japan/USA/Australia/Canada/Germany (see AUDIT.md). New
-- Zealand's real, distinctive facts:
--   - Indian passport holders are NOT eligible for the NZeTA (the
--     digital travel-authority scheme reserved for select other
--     passport holders) — every Indian applicant needs a full Visitor
--     Visa for Tourist/Business/Family/Medical/Conference purposes, not
--     a quick online authorization.
--   - Tourist, Business, Family Visit, Medical and Conference all sit
--     inside the same Visitor Visa product, distinguished by purpose,
--     not separate visa categories.
--   - A mandatory International Visitor Conservation and Tourism Levy
--     (IVL, NZD 100) applies on top of the visa application fee itself
--     — a genuinely separate charge, not folded into one number.
--   - Work uses the Accredited Employer Work Visa (AEWV) as the primary
--     pathway, with real 2026 median-wage-linked thresholds: pay at 2x
--     median wage can exempt from labour-market testing, and 1.5x
--     median wage unlocks the maximum 5-year continuous stay — the
--     median wage itself rises to NZD 35.00/hr from 9 March 2026.
--   - Sports genuinely splits in two: amateur competitors use the
--     ordinary Visitor Visa, while paid/professional sportspeople and
--     coaches use a distinct Specific Purpose Work Visa (sports
--     professionals stream) — and partners/children cannot be included
--     on that visa; they must apply separately.
--   - There is no single "Dependent Visa" — partners and children of
--     Work/Student visa holders apply for purpose-linked visas (Partner
--     of a Worker Work Visa, Dependent Child Student Visa).
--
-- country_id 189 = New Zealand. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.
--
-- hero_image_url points at the real South Island landscape and New
-- Zealand flag photo supplied by the client for this hero.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Visitor Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    189, 1, 'NZL-TOUR-IN-01', '2026.09', 'published',
    'Leisure travel, sightseeing, and visiting friends/relatives in New Zealand.',
    'Indian passport holders are NOT eligible for the NZeTA digital travel authority (reserved for select other nationalities) and must apply for a full Visitor Visa via Immigration New Zealand (INZ), with biometrics given at a VFS Global centre in India.',
    'As granted by INZ, commonly up to 9 months within an 18-month period',
    'Online application via INZ, biometrics required at a VFS Global Visa Application Centre',
    1,
    'Processing times vary; apply well ahead of your planned travel dates',
    'VFS Global New Zealand Visa Application Centre, India',
    'Initial consultation to confirm Visitor Visa (Tourist) is correct\nGather documents against this checklist\nSubmit your application to INZ online\nAttend a VFS Global centre for biometrics\nSupport responding to any additional-information request\nDecision — visa label affixed to your passport once approved',
    '/assets/images/visa-heroes/new-zealand.jpg',
    'Immigration New Zealand (immigration.govt.nz) Visitor Visa guidance, cross-checked via VFS Global India logistics', 'https://www.immigration.govt.nz/visas/visitor-visa/', '2026-09-11'
);
SET @nt1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nt1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nt1, 'Core Documents', 'Every applicant needs these.', 1);
SET @nt1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nt1s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@nt1s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nt1, 'Financial & Ties Documents', 'Evidence of funds and ties to India.', 2);
SET @nt1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nt1s2, 'Bank Statements', 'Showing at least NZD 1,000/month of stay (NZD 400/month if accommodation is prepaid).', 'copy', 1, 0, 1, 1),
(@nt1s2, 'Proof of Ties to India', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nt1, 'Travel Documents', 'Evidence of your trip.', 3);
SET @nt1s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nt1s3, 'Return/Onward Travel Ticket', 'Or evidence of funds to purchase one.', 'copy', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nt1, 'Application & Biometrics', 'Booking your VFS appointment.', 4);
SET @nt1s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nt1s4, 'Biometrics Appointment', 'At a VFS Global centre in India.', 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(189, 1, 441.00, 'NZD', 'Visitor Visa Application Fee + Levy', 'NZD 300 application fee + NZD 41 immigration levy = NZD 341, plus a separate mandatory NZD 100 International Visitor Conservation and Tourism Levy (IVL), totalling roughly NZD 441.', '2026-01-01', NOW(), 'https://www.immigration.govt.nz/process-to-apply/applying-for-a-visa/fees-processing-times-and-refunds/how-much-visa-applications-cost-and-when-to-pay/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian citizens use the NZeTA instead of a full Visitor Visa?', 'No — the NZeTA is reserved for select other passport holders. Indian citizens must apply for a full Visitor Visa (one exception: Indians already holding a valid US/UK/Canada visa may qualify for NZeTA instead).', 189, 1, 920, 1),
('What is the IVL?', 'The International Visitor Conservation and Tourism Levy — a separate NZD 100 charge on top of the visa application fee itself, funding conservation and tourism infrastructure.', 189, 1, 921, 1),
('How much money do I need to show per month of stay?', 'At least NZD 1,000/month, or NZD 400/month if your accommodation is already prepaid.', 189, 1, 922, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Visitor Visa (Business stream)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    189, 2, 'NZL-BUS-IN-02', '2026.09', 'published',
    'Short business visits — meetings and negotiations — to New Zealand.',
    'Business visits use the same Visitor Visa product as Tourist. Applicants may not undertake paid work in NZ; a letter from the Indian employer and an invitation from the NZ host company are the differentiating documents.',
    'As granted by INZ, commonly up to 9 months within an 18-month period',
    'Online application via INZ, biometrics at a VFS Global centre',
    1,
    'Processing times vary; apply well ahead of your planned travel dates',
    'VFS Global New Zealand Visa Application Centre, India',
    'Initial consultation to confirm the trip is genuine business\nObtain an invitation letter from your NZ host company\nGather documents against this checklist\nSubmit your application to INZ online\nAttend a VFS Global centre for biometrics\nDecision once processed',
    '/assets/images/visa-heroes/new-zealand.jpg',
    'Immigration New Zealand Business Visitor Visa guidance', 'https://www.immigration.govt.nz/visas/business-visitor-visa/', '2026-09-11'
);
SET @nt2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nt2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nt2, 'Core Documents', 'Every applicant needs these.', 1);
SET @nt2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nt2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@nt2s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nt2, 'Business Invitation & Purpose', 'Evidence of who you are meeting and why.', 2);
SET @nt2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nt2s2, 'Invitation Letter from NZ Host Company', NULL, 'original', 1, 0, 1, 1),
(@nt2s2, 'Letter from Indian Employer', 'Confirming your role and purpose of travel.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nt2, 'Financial Documents', 'Evidence of funds.', 3);
SET @nt2s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nt2s3, 'Bank Statements', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(189, 2, 441.00, 'NZD', 'Visitor Visa Application Fee + Levy', 'Same fee/IVL structure as Tourist — Business is the same Visitor Visa product.', '2026-01-01', NOW(), 'https://www.immigration.govt.nz/visas/business-visitor-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I be paid by the NZ company I am visiting?', 'No — business visitors on this visa may not undertake paid work in New Zealand.', 189, 2, 923, 1),
('Is a Sponsorship Form needed for Business visits?', 'Not typically — an invitation letter from your NZ host and a letter from your Indian employer are the key documents; sponsorship forms are used for family visits.', 189, 2, 924, 1),
('Is Business a separate visa category?', 'No — it uses the same Visitor Visa product as Tourist, distinguished by purpose-specific documents.', 189, 2, 925, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Student Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    189, 3, 'NZL-STU-IN-03', '2026.09', 'published',
    'Full-time study at an approved New Zealand education provider.',
    'Requires a confirmed, unconditional Offer of Place from an NZQA-approved provider and living-cost evidence of NZD 20,000/year — INZ explicitly flags sudden deposits as a common refusal reason, so funds should show accumulation over 3-6 months from a verifiable source.',
    'Duration of your approved course, plus limited post-study allowance where applicable',
    'Online application via INZ, biometrics at a VFS Global centre',
    1,
    'Processing times vary; apply well ahead of your course start date',
    'VFS Global New Zealand Visa Application Centre, India',
    'Secure admission and receive your Offer of Place\nArrange and evidence your funds over time (avoid last-minute lump deposits)\nGather documents against this checklist\nSubmit your application to INZ online\nAttend a VFS Global centre for biometrics\nDecision once processed',
    '/assets/images/visa-heroes/new-zealand.jpg',
    'Immigration New Zealand Student Visa guidance', 'https://www.immigration.govt.nz/new-zealand-visas/visas/visa/student-visa', '2026-09-11'
);
SET @nt3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nt3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nt3, 'Core Documents', 'Every applicant needs these.', 1);
SET @nt3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nt3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@nt3s1, 'Offer of Place', 'From an NZQA-approved education provider.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nt3, 'Financial Documents', 'Evidence you can fund your studies.', 2);
SET @nt3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nt3s2, 'Bank Statements (3-6 Months)', 'Showing accumulated funds of NZD 20,000/year, not a sudden deposit.', 'copy', 1, 0, 1, 1),
(@nt3s2, 'Tuition Payment Evidence', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nt3, 'Academic Documents', 'Evidence of your admission.', 3);
SET @nt3s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nt3s3, 'Academic Transcripts', NULL, 'copy', 1, 0, 0, 1),
(@nt3s3, 'Return Airfare or Equivalent Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(189, 3, 375.00, 'NZD', 'Student Visa Application Fee', 'Indicative government fee; varies by category/band. Plus the separate NZD 100 IVL. Confirm the exact current figure with us before applying.', '2026-09-01', NOW(), 'https://www.immigration.govt.nz/process-to-apply/applying-for-a-visa/fees-processing-times-and-refunds/how-much-visa-applications-cost-and-when-to-pay/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Why does INZ care how my funds accumulated?', 'INZ explicitly flags sudden, large deposits shortly before applying as a common refusal reason — funds should show a credible history of accumulation over 3-6 months from a verifiable, lawful source.', 189, 3, 926, 1),
('How much do I need for living costs?', 'NZD 20,000 per year (less any prepaid expenses like accommodation), in addition to tuition fees and return travel funds.', 189, 3, 927, 1),
('Do I need my Offer of Place before applying?', 'Yes — a confirmed, unconditional Offer of Place from an NZQA-approved provider is required before you can apply for the Student Visa.', 189, 3, 928, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Accredited Employer Work Visa (AEWV)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    189, 4, 'NZL-WORK-IN-04', '2026.09', 'published',
    'Skilled employment in New Zealand, sponsored by an INZ-accredited employer.',
    'The Accredited Employer Work Visa (AEWV) requires a genuine, full-time (30+ hrs/week) job offer from an accredited employer, plus 2+ years relevant experience or a relevant Level 4+ qualification. Real 2026 wage thresholds matter: 2x median wage (~NZD 67.12/hr) may exempt from labour-market testing; 1.5x median wage (~NZD 50.34/hr) unlocks the maximum 5-year continuous stay.',
    'Tied to the job offer; up to 5 years continuous stay at 1.5x median wage or above',
    'Employer becomes accredited and completes a Job Check; employee then applies online via INZ',
    1,
    'Typical processing runs roughly 25-35 working days',
    'VFS Global New Zealand Visa Application Centre, India',
    'Employer becomes an INZ-accredited employer\nEmployer completes a Job Check for your position\nGather documents against this checklist, including experience evidence\nSubmit your AEWV application to INZ online\nAttend a VFS Global centre for biometrics\nDecision once processed',
    '/assets/images/visa-heroes/new-zealand.jpg',
    'Immigration New Zealand Accredited Employer Work Visa guidance and 2026 median wage changes', 'https://www.immigration.govt.nz/visas/accredited-employer-work-visa/', '2026-09-11'
);
SET @nt4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nt4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nt4, 'Core Documents', 'Every applicant needs these.', 1);
SET @nt4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nt4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@nt4s1, 'Job Check Confirmation', 'From your accredited employer.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nt4, 'Employer & Job Offer Documents', 'Evidence of your role and employer accreditation.', 2);
SET @nt4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nt4s2, 'Employment Agreement', 'Full-time (30+ hrs/week), stating wage and role.', 'copy', 1, 0, 1, 1),
(@nt4s2, 'Employer Accreditation Evidence', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nt4, 'Qualification Documents', 'Evidence of your experience/qualification.', 3);
SET @nt4s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nt4s3, 'Work Experience Evidence', '2+ years relevant experience, or a relevant Level 4+ qualification.', 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(189, 4, 1540.00, 'NZD', 'AEWV Visa Application Fee', 'Indicative fee; varies by band. Separate employer-side accreditation (NZD 775 standard, NZD 1,280 high-volume) and Job Check fees apply and are typically borne by the employer.', '2026-09-01', NOW(), 'https://www.immigration.govt.nz/work/for-employers/getting-accreditation-or-approval-to-hire/employer-accreditation-for-the-aewv/aewv-employer-accreditation-and-job-check-process/paying-for-aewv-employer-accreditation-and-job-checks/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What wage unlocks the maximum 5-year AEWV stay?', 'Pay at 1.5x the median wage (around NZD 50.34/hr as of recent settings) unlocks the maximum 5-year continuous stay; the median wage itself rises to NZD 35.00/hr from 9 March 2026.', 189, 4, 929, 1),
('Does my employer need to prove no NZ worker was available?', 'Not always — pay at 2x median wage (around NZD 67.12/hr) can exempt the role from labour-market testing.', 189, 4, 930, 1),
('What experience do I need for the AEWV?', 'Either 2+ years of relevant work experience, or a relevant Level 4+ qualification, alongside a genuine full-time job offer from an accredited employer.', 189, 4, 931, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Visitor Visa (Family stream)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    189, 5, 'NZL-FAM-IN-05', '2026.09', 'published',
    'Visiting family members who are New Zealand citizens or residence-class visa holders.',
    'Your NZ-based sponsor must be a citizen or residence-class visa holder and must complete the Sponsorship Form for Temporary Entry (INZ 1025); if you lack a return ticket, the sponsor can instead provide bank statements proving they can fund one.',
    'As granted by INZ, commonly up to 9 months within an 18-month period',
    'Online application via INZ, biometrics at a VFS Global centre, requires an eligible sponsor',
    1,
    'Processing depends on both the sponsor''s documentation and your own application',
    'VFS Global New Zealand Visa Application Centre, India',
    'Confirm your NZ sponsor is a citizen or residence-class visa holder\nSponsor completes the Sponsorship Form for Temporary Entry (INZ 1025)\nGather documents against this checklist, including relationship proof\nSubmit your application to INZ online\nAttend a VFS Global centre for biometrics\nDecision once processed',
    '/assets/images/visa-heroes/new-zealand.jpg',
    'Immigration New Zealand Visitor Visa (family purpose) and sponsorship guidance', 'https://www.immigration.govt.nz/process-to-apply/applying-for-a-visa/sponsoring-someone-on-a-visa/sponsorship-process-for-a-visa/', '2026-09-11'
);
SET @nt5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nt5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nt5, 'Core Documents', 'Every applicant needs these.', 1);
SET @nt5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nt5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@nt5s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nt5, 'Sponsorship Documents', 'Evidence of your sponsor''s eligibility and commitment.', 2);
SET @nt5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nt5s2, 'Sponsorship Form for Temporary Entry (INZ 1025)', NULL, 'original', 1, 0, 1, 1),
(@nt5s2, 'Relationship Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nt5, 'Travel Documents', 'Evidence of your trip.', 3);
SET @nt5s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nt5s3, 'Return Ticket or Sponsor''s Funds Evidence', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(189, 5, 441.00, 'NZD', 'Visitor Visa Application Fee + Levy', 'Same fee/IVL structure as Tourist — the difference is your sponsor''s Sponsorship Form and relationship evidence.', '2026-01-01', NOW(), 'https://www.immigration.govt.nz/process-to-apply/applying-for-a-visa/sponsoring-someone-on-a-visa/sponsorship-process-for-a-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Who can sponsor a Family Visit visa?', 'A New Zealand citizen or residence-class visa holder, who must complete the Sponsorship Form for Temporary Entry (INZ 1025).', 189, 5, 932, 1),
('What if I don''t have a return ticket?', 'Your sponsor can instead provide bank statements proving they can fund one on your behalf.', 189, 5, 933, 1),
('Is this a different visa product from Tourist?', 'No — it uses the same Visitor Visa, with the addition of your sponsor''s documentation.', 189, 5, 934, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Transit Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    189, 6, 'NZL-TRANS-IN-06', '2026.09', 'published',
    'Passing through New Zealand en route to a third country.',
    'India is not listed among INZ''s transit-visa-waiver countries, so Indian passport holders generally require a Transit Visa to pass airside through New Zealand — unless specifically travelling to/from Australia via Auckland, where an NZeTA-based transit option may apply instead.',
    'Strictly for the duration of your layover/connection',
    'Online application via INZ, biometrics at a VFS Global centre',
    1,
    'Check current transit-visa-waiver country listings before assuming you need a full application',
    'VFS Global New Zealand Visa Application Centre, India',
    'Confirm whether the Australia-via-Auckland NZeTA transit option applies to your itinerary\nIf not, gather documents against this checklist\nSubmit your Transit Visa application to INZ online\nAttend biometrics if required\nDecision once processed',
    '/assets/images/visa-heroes/new-zealand.jpg',
    'Immigration New Zealand Transit Visa and transit-waiver-countries guidance', 'https://www.immigration.govt.nz/visas/transit-visa/', '2026-09-11'
);
SET @nt6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nt6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nt6, 'Core Documents', 'Every applicant needs these.', 1);
SET @nt6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nt6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@nt6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nt6, 'Destination Documents', 'Evidence of your final destination.', 2);
SET @nt6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nt6s2, 'Valid Visa for Final Destination', 'If required.', 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(189, 6, NULL, 'NZD', 'Confirmed After Assessment', 'Fee mirrors standard visa processing; confirmed once we verify whether the Australia-via-Auckland NZeTA exception applies to your specific itinerary.', '2026-09-01', NOW(), 'https://www.immigration.govt.nz/visas/transit-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a transit visa for New Zealand?', 'Generally yes — India is not on INZ''s transit-visa-waiver list. The exception is travel specifically to/from Australia via Auckland, where an NZeTA-based transit option may apply.', 189, 6, 935, 1),
('Is biometrics required for a transit application?', 'Standard biometric requirements apply, the same as other visa categories.', 189, 6, 936, 1),
('What if my final destination requires its own visa?', 'You should have that visa (or evidence of eligibility) in place before your New Zealand transit application.', 189, 6, 937, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Medical Treatment Visitor Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    189, 7, 'NZL-MED-IN-07', '2026.09', 'published',
    'Travelling to New Zealand to receive medical treatment.',
    'A distinct Medical Treatment Visitor Visa sub-type of the Visitor Visa. Requires written evidence of acceptance for treatment from the NZ treating authority, full expected treatment costs, and proof of ability to pay all medical and living costs — public-funded treatment exemptions apply only to certain South Pacific nationals, not India.',
    'As needed for the course of treatment',
    'Online application via INZ, biometrics at a VFS Global centre',
    1,
    'Processing depends on the completeness of medical documentation',
    'VFS Global New Zealand Visa Application Centre, India',
    'Obtain a written acceptance-for-treatment letter from the NZ medical authority\nGather documents against this checklist\nSubmit your application to INZ online\nAttend a VFS Global centre for biometrics\nDecision once processed',
    '/assets/images/visa-heroes/new-zealand.jpg',
    'Immigration New Zealand Medical Treatment Visitor Visa guidance', 'https://www.immigration.govt.nz/visas/medical-treatment-visitor-visa/', '2026-09-11'
);
SET @nt7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nt7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nt7, 'Core Documents', 'Every applicant needs these.', 1);
SET @nt7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nt7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@nt7s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nt7, 'Medical Documents', 'Evidence of your treatment plan.', 2);
SET @nt7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nt7s2, 'Written Acceptance for Treatment', 'From the NZ treating authority.', 'original', 1, 0, 1, 1),
(@nt7s2, 'Referral from Doctor in India', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nt7, 'Financial Documents', 'Evidence you can pay for treatment.', 3);
SET @nt7s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nt7s3, 'Full Treatment Cost Estimate & Funds Evidence', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(189, 7, 441.00, 'NZD', 'Visitor Visa Application Fee + Levy', 'Same fee/IVL structure as Tourist — Medical Treatment is a distinct sub-type of the Visitor Visa.', '2026-01-01', NOW(), 'https://www.immigration.govt.nz/visas/medical-treatment-visitor-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does New Zealand fund treatment for Indian visitors?', 'No — public-funded treatment exemptions apply only to certain South Pacific nationals; Indian applicants must show ability to pay all medical and living costs themselves.', 189, 7, 938, 1),
('What written evidence do I need from the treating authority?', 'A formal acceptance-for-treatment letter confirming your diagnosis and treatment plan.', 189, 7, 939, 1),
('Is Medical Treatment a separate visa from Tourist?', 'It is a distinct sub-type within the Visitor Visa product, not an entirely separate visa category.', 189, 7, 940, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Visitor Visa (Conference purpose)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    189, 8, 'NZL-CONF-IN-08', '2026.09', 'published',
    'Attending a conference or convention in New Zealand.',
    'Uses the general Visitor Visa with the conference purpose selected. Requires the conference registration confirmation and an invitation letter from the event organiser (typically released only to registered delegates). INZ recommends a minimum 30-day lead time before the event.',
    'As granted by INZ, matching your conference dates plus reasonable travel time',
    'Online application via INZ, biometrics at a VFS Global centre',
    1,
    'Apply at least 30 days before your conference, per INZ''s own recommendation',
    'VFS Global New Zealand Visa Application Centre, India',
    'Obtain your conference registration confirmation and organiser invitation letter\nGather documents against this checklist\nSubmit your application to INZ online at least 30 days ahead\nAttend a VFS Global centre for biometrics\nDecision once processed',
    '/assets/images/visa-heroes/new-zealand.jpg',
    'Immigration New Zealand Visitor Visa (conference purpose) guidance', 'https://www.immigration.govt.nz/visas/visitor-visa/', '2026-09-11'
);
SET @nt8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nt8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nt8, 'Core Documents', 'Every applicant needs these.', 1);
SET @nt8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nt8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@nt8s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nt8, 'Conference Documents', 'Evidence of the event and your registration.', 2);
SET @nt8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nt8s2, 'Conference Registration Confirmation', NULL, 'original', 1, 0, 1, 1),
(@nt8s2, 'Organiser Invitation Letter', 'Released to registered delegates.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nt8, 'Financial Documents', 'Evidence of funds.', 3);
SET @nt8s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nt8s3, 'Bank Statements', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(189, 8, 441.00, 'NZD', 'Visitor Visa Application Fee + Levy', 'Same fee/IVL structure as Tourist — Conference is a purpose within the Visitor Visa.', '2026-01-01', NOW(), 'https://www.immigration.govt.nz/visas/visitor-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How early should I apply for a conference visa?', 'INZ recommends a minimum 30-day lead time before your event.', 189, 8, 941, 1),
('Do large delegations need to do anything extra?', 'Organisers of large delegations (30+ international attendees) are encouraged to notify INZ in advance to streamline group processing.', 189, 8, 942, 1),
('Is Conference a separate visa category?', 'No — it uses the same Visitor Visa product, selected with the conference purpose.', 189, 8, 943, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Visitor Visa (amateur) / Specific Purpose Work Visa (professional)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    189, 9, 'NZL-SPORT-IN-09', '2026.09', 'published',
    'Competing as an amateur, or playing/coaching professionally for a New Zealand sports club.',
    'Genuinely splits in two: amateur/recreational competitors (e.g. a marathon or amateur tournament) apply under the ordinary Visitor Visa, while paid/professional sportspeople and coaches use a distinct Specific Purpose Work Visa (sports professionals stream) — up to 36 months for national/regional-level players or coaches, 12 months below that level. Partners and dependent children cannot be included on this visa and must apply separately.',
    'Amateur: as granted under Visitor Visa. Professional: up to 36 months (national/regional level) or 12 months (below)',
    'Amateur: standard Visitor Visa application. Professional: Specific Purpose Work Visa application via INZ',
    1,
    'Confirm your amateur/professional status first — it determines which visa and document set applies',
    'VFS Global New Zealand Visa Application Centre, India',
    'Confirm whether your participation is amateur or paid/professional\nGather documents against this checklist for the applicable pathway\nSubmit your application to INZ online\nAttend a VFS Global centre for biometrics\nDecision once processed',
    '/assets/images/visa-heroes/new-zealand.jpg',
    'Immigration New Zealand Specific Purpose Work Visa (sports professionals) guidance', 'https://www.immigration.govt.nz/visas/specific-purpose-work-visa/', '2026-09-11'
);
SET @nt9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nt9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nt9, 'Core Documents', 'Every applicant needs these.', 1);
SET @nt9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nt9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@nt9s1, 'Passport Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nt9, 'Amateur Event Documents', 'For amateur/recreational competitors.', 2);
SET @nt9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nt9s2, 'Event/Tournament Invitation', NULL, 'original', 0, 1, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nt9, 'Professional Sponsorship Documents', 'For paid/professional sportspeople and coaches.', 3);
SET @nt9s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nt9s3, 'Contract with NZ Sports Club', NULL, 'copy', 0, 1, 0, 1),
(@nt9s3, 'Evidence of Playing/Coaching Level', 'National, regional, or below.', 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(189, 9, NULL, 'NZD', 'Confirmed After Assessment', 'Fee depends on whether you apply as an amateur (standard Visitor Visa fee) or a professional (Specific Purpose Work Visa fee) — confirmed once your status is assessed.', '2026-09-01', NOW(), 'https://www.immigration.govt.nz/visas/specific-purpose-work-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my family come with me on a Specific Purpose Work Visa?', 'No — partners and dependent children cannot be included on this visa and must apply separately based on their own relationship to you.', 189, 9, 944, 1),
('How long can a professional athlete stay?', 'Up to 36 months for national/regional-level players or coaches, or up to 12 months for those below that level.', 189, 9, 945, 1),
('Do amateur competitors need a special sports visa?', 'No — amateur/recreational participants use the ordinary Visitor Visa; only paid/professional sportspeople need the Specific Purpose Work Visa.', 189, 9, 946, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Partner of a Worker / Dependent Child Student Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    189, 10, 'NZL-DEP-IN-10', '2026.09', 'published',
    'Joining a spouse/partner or parent who holds a valid NZ Work or Student visa.',
    'No single "Dependent Visa" exists — partners of a work visa holder apply for a Partner of a Worker Work Visa, and dependent children of a student visa holder apply for a Dependent Child Student Visa. Eligibility for family inclusion under the AEWV specifically depends on the principal''s wage level and visa length.',
    'Matches the validity of the principal visa holder''s visa',
    'Online application via INZ, biometrics at a VFS Global centre',
    1,
    'Processing depends on the principal holder''s visa type and wage/duration thresholds',
    'VFS Global New Zealand Visa Application Centre, India',
    'Confirm the principal visa holder''s visa type, wage level, and duration\nGather documents against this checklist, including relationship proof\nSubmit the applicable Partner or Dependent Child visa application to INZ online\nAttend a VFS Global centre for biometrics\nDecision once processed',
    '/assets/images/visa-heroes/new-zealand.jpg',
    'Immigration New Zealand bringing family to New Zealand guidance', 'https://www.immigration.govt.nz/process-to-apply/once-you-have-a-visa/bringing-family-to-new-zealand/', '2026-09-11'
);
SET @nt10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nt10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nt10, 'Core Documents', 'Every applicant needs these.', 1);
SET @nt10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nt10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@nt10s1, 'Principal Holder''s Visa Grant Notice', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nt10, 'Relationship Documents', 'Evidence of your relationship to the principal holder.', 2);
SET @nt10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nt10s2, 'Marriage/Partnership Certificate', 'For a Partner of a Worker application.', 'copy', 0, 1, 1, 1),
(@nt10s2, 'Birth Certificate', 'For a Dependent Child Student Visa application.', 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nt10, 'Financial Documents', 'Evidence the principal can support you.', 3);
SET @nt10s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nt10s3, 'Principal Holder''s Wage/Income Evidence', 'Assessed against the principal''s wage-band and visa-length thresholds.', 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(189, 10, 1630.00, 'NZD', 'Partner of a Worker Work Visa Fee (Indicative)', 'Partner of a Worker Work Visa is commonly quoted around NZD 1,630; Dependent Child Student Visa around NZD 750 — we confirm the exact fee for your specific case.', '2026-09-01', NOW(), 'https://www.immigration.govt.nz/process-to-apply/once-you-have-a-visa/bringing-family-to-new-zealand/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there one Dependent Visa for all family members?', 'No — partners apply for a Partner of a Worker Work Visa and dependent children for a Dependent Child Student Visa; these are separate, purpose-linked products.', 189, 10, 947, 1),
('Does the principal''s wage affect my eligibility?', 'Yes — under the AEWV specifically, family-inclusion eligibility depends on the principal holder''s wage level and visa length.', 189, 10, 948, 1),
('Do I need to apply at the same time as the principal holder?', 'Not necessarily — you can apply once the principal holder''s visa is granted, provided their status meets the applicable thresholds.', 189, 10, 949, 1);
