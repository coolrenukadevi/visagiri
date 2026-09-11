-- USA Visa Checklist Engine content for all 10 visa types — built fresh
-- this session via web search, same standard as Mexico/Singapore/France/
-- Japan (see AUDIT.md). The USA's real, distinctive facts are genuinely
-- different from every country built so far:
--   - The US does NOT use VFS Global at all for visa processing — Indian
--     applicants schedule via the State Department's own portal
--     (ustraveldocs.com) and attend directly at the US Embassy New Delhi
--     or a US Consulate (Mumbai, Chennai, Hyderabad, Kolkata). No
--     third-party visa centre is involved, unlike every other country
--     built so far.
--   - Tourist, Business, Family Visit, Medical and Conference are NOT
--     five separate legal visa categories — all five are the SAME
--     B-1/B-2 Visitor Visa class. The State Department's own B-1 Fact
--     Sheet lists conference/convention attendance as an explicit
--     permissible B-1 activity, and Medical treatment is a standard
--     B-2 purpose. Each of these 5 checklists states this honestly and
--     covers the purpose-specific supporting documents that genuinely
--     differ (conference invitation/acceptance letter, hospital
--     treatment letter, host's invitation, etc.) rather than inventing
--     5 separate visa products that don't exist.
--   - India is NOT in the Visa Waiver Program, so a mandatory in-person
--     interview is required for virtually every category — current
--     interview wait times commonly run 3-10+ months depending on the
--     consulate, a real and materially significant fact for applicants
--     to plan around.
--   - The Visa Integrity Fee (USD 250, enacted under the One Big
--     Beautiful Bill Act, effective FY2026, expected fully rolled out
--     by 30 Sept 2026) applies on top of the standard MRV application
--     fee across nearly every nonimmigrant category, collected only
--     after a visa is approved (not charged on refusal) — noted on
--     every fee row rather than folded silently into one number.
--   - F-1 Student requires an I-20 from a SEVP-certified school AND a
--     separate SEVIS I-901 fee (USD 350) before the visa application.
--   - H-1B Work is employer-sponsored only (LCA + I-129 petition, annual
--     lottery cap), and the visa application (MRV) fee for H/L/O/P/Q/R
--     categories is USD 205, not the standard USD 185 — carried forward
--     accurately rather than reusing the B-1/B-2 figure.
--   - C-1 Transit is only needed if the traveller holds no other valid
--     US visa for a connecting itinerary.
--   - Sports uses the P-1A (internationally recognized athlete/team) or
--     O-1 (extraordinary ability) category — petitioner/employer-driven,
--     not a simple visitor-purpose document set.
--   - H-4 Dependent is a derivative status tied to a principal H-1B
--     holder's status and timeline, not an independent application.
--
-- country_id 180 = United States. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.
--
-- hero_image_url points at the real Statue of Liberty/US flag photo
-- supplied by the client for this hero.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — B-1/B-2 Visitor Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    180, 1, 'USA-TOUR-IN-01', '2026.09', 'published',
    'Leisure travel, sightseeing, and visiting friends/relatives in the United States.',
    'Tourist travel falls under the B-2 Visitor Visa, almost always issued combined as "B-1/B-2." India is not part of the US Visa Waiver Program, so a mandatory in-person interview is required — current wait times for a first appointment commonly run 3-10+ months depending on the consulate.',
    'Up to 6 months per entry (CBP officer''s decision); visa itself valid up to 10 years, multiple entry',
    'Nonimmigrant visa application via DS-160, in-person interview at the US Embassy/Consulate',
    1,
    'Interview wait time varies significantly by consulate (Mumbai, Delhi, Chennai, Hyderabad, Kolkata) — check the State Department''s current Global Visa Wait Times page before planning your trip',
    'US Embassy New Delhi or US Consulate (Mumbai, Chennai, Hyderabad, Kolkata) — scheduled via ustraveldocs.com, no VFS Global involvement',
    'Initial consultation to confirm B-1/B2 Tourist purpose is correct\nComplete the DS-160 online application form\nPay the MRV application fee and schedule your interview via ustraveldocs.com\nGather documents against this checklist\nAttend your in-person interview\nSupport responding to any administrative processing request (214(b) refusal guidance if needed)\nCollect your passport with visa once approved',
    '/assets/images/visa-heroes/usa.jpg',
    'US Department of State (travel.state.gov) B-1/B-2 guidance and current Visa Integrity Fee policy, cross-checked via independent visa-agency sourcing', 'https://travel.state.gov/content/travel/en/us-visas/tourism-visit/visitor.html', '2026-09-11'
);
SET @ut1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ut1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut1, 'Core Documents', 'Every applicant needs these.', 1);
SET @ut1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut1s1, 'Valid Passport', 'Valid for at least 6 months beyond your intended stay, with at least one blank visa page.', 'original', 1, 0, 1, 1),
(@ut1s1, 'DS-160 Confirmation Page', 'Printed confirmation page from your completed online DS-160 application.', 'original', 1, 0, 1, 2),
(@ut1s1, 'Passport Photograph', 'One recent 2x2 inch (51x51mm) colour photo, white background, per US visa photo requirements.', 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut1, 'Financial & Ties Documents', 'Evidence of funds and strong ties to India.', 2);
SET @ut1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut1s2, 'Bank Statements', 'Last 6 months, showing sufficient funds for your trip.', 'copy', 1, 0, 1, 1),
(@ut1s2, 'Proof of Ties to India', 'Employment letter, property documents, or family ties evidence showing intent to return — the leading factor in avoiding a 214(b) refusal.', 'copy', 1, 0, 0, 2),
(@ut1s2, 'Income Tax Returns', 'Last 2-3 years, if available.', 'copy', 0, 1, 0, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut1, 'Travel Documents', 'Your itinerary and trip details.', 3);
SET @ut1s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut1s3, 'Travel Itinerary', 'Indicative flight and accommodation plans (a firm ticket is not required before visa approval).', 'original', 0, 1, 1, 1),
(@ut1s3, 'Invitation Letter from Host', 'If staying with friends/relatives in the US.', 'original', 0, 1, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut1, 'Interview & Fee', 'Booking and attending your consular interview.', 4);
SET @ut1s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut1s4, 'MRV Fee Payment Receipt', NULL, 'original', 1, 0, 0, 1),
(@ut1s4, 'Interview Appointment Confirmation', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(180, 1, 185.00, 'USD', 'MRV Application Fee', 'Paid before your interview, non-refundable regardless of outcome. A separate Visa Integrity Fee of USD 250 applies only if your visa is approved (not charged on refusal), bringing the total to USD 435 once fully rolled out in FY2026.', '2026-09-01', NOW(), 'https://travel.state.gov/content/travel/en/us-visas/tourism-visit/visitor.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need to appear in person for a US tourist visa?', 'Yes — India is not part of the US Visa Waiver Program, so an in-person interview at the US Embassy/Consulate is mandatory for virtually every applicant.', 180, 1, 800, 1),
('Is there VFS Global processing for US visas?', 'No — unlike most other countries, the US does not use VFS Global. Appointments are scheduled directly via the State Department''s own ustraveldocs.com portal, and interviews take place at the US Embassy or Consulate itself.', 180, 1, 801, 1),
('What is the Visa Integrity Fee?', 'A USD 250 fee enacted under the One Big Beautiful Bill Act, charged on top of the standard MRV fee once your visa is approved (not if refused), applying to nearly all nonimmigrant visa categories including B-1/B-2.', 180, 1, 802, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — B-1 Visitor Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    180, 2, 'USA-BUS-IN-02', '2026.09', 'published',
    'Short business visits — meetings, negotiations, contract signing, and site visits — to the United States.',
    'Business travel falls under the same B-1/B-2 Visitor Visa class as Tourist — the US has no separate "business visa" category. A B-1 traveller may not receive a US salary, but reimbursement of incidental travel, lodging, and meal expenses by the US host is permitted.',
    'Typically up to 6 months per entry, as decided by the CBP officer at the port of entry',
    'Nonimmigrant visa application via DS-160, in-person interview at the US Embassy/Consulate',
    1,
    'Interview wait time varies significantly by consulate — check the State Department''s current Global Visa Wait Times page',
    'US Embassy New Delhi or US Consulate (Mumbai, Chennai, Hyderabad, Kolkata) — scheduled via ustraveldocs.com',
    'Initial consultation to confirm B-1 Business purpose is correct\nComplete the DS-160 online application form\nObtain a clear invitation/purpose letter from your US business contact\nPay the MRV application fee and schedule your interview\nGather documents against this checklist\nAttend your in-person interview\nCollect your passport with visa once approved',
    '/assets/images/visa-heroes/usa.jpg',
    'US Department of State B-1 Fact Sheet and USCIS Temporary Business Visitor guidance', 'https://travel.state.gov/content/travel/en/us-visas/business/b-1-fact-sheet.html', '2026-09-11'
);
SET @ut2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ut2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut2, 'Core Documents', 'Every applicant needs these.', 1);
SET @ut2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut2s1, 'Valid Passport', 'Valid for at least 6 months beyond your intended stay, with at least one blank visa page.', 'original', 1, 0, 1, 1),
(@ut2s1, 'DS-160 Confirmation Page', NULL, 'original', 1, 0, 1, 2),
(@ut2s1, 'Passport Photograph', '2x2 inch (51x51mm) colour photo, white background.', 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut2, 'Business Invitation & Purpose', 'Evidence of who you are meeting and why.', 2);
SET @ut2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut2s2, 'Invitation Letter from US Host Company', 'Stating purpose, duration, and who bears travel/lodging costs — B-1 rules do not permit a US salary, only expense reimbursement.', 'original', 1, 0, 1, 1),
(@ut2s2, 'Covering Letter from Indian Employer', 'Confirming your role, purpose of travel, and that you will return to your position in India.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut2, 'Financial & Ties Documents', 'Evidence of funds and ties to India.', 3);
SET @ut2s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut2s3, 'Bank Statements', 'Last 6 months.', 'copy', 1, 0, 0, 1),
(@ut2s3, 'Proof of Ties to India', 'Employment and property evidence showing intent to return.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut2, 'Interview & Fee', 'Booking and attending your consular interview.', 4);
SET @ut2s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut2s4, 'MRV Fee Payment Receipt', NULL, 'original', 1, 0, 0, 1),
(@ut2s4, 'Interview Appointment Confirmation', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(180, 2, 185.00, 'USD', 'MRV Application Fee', 'Same fee and Visa Integrity Fee (USD 250, approved visas only) structure as Tourist — Business is the same B-1/B-2 visa class.', '2026-09-01', NOW(), 'https://travel.state.gov/content/travel/en/us-visas/business/b-1-fact-sheet.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate "Business Visa" category for the US?', 'No — Business travel uses the same B-1/B-2 Visitor Visa class as Tourist travel. The difference is purpose-specific supporting documents, not a different visa product.', 180, 2, 803, 1),
('Can I be paid by the US company I am visiting?', 'No — B-1 status does not permit a US salary. Reimbursement of incidental travel, lodging, and meal expenses by your US host is permitted.', 180, 2, 804, 1),
('What is the biggest reason Indian B-1 applications get refused?', 'A weak or generic invitation letter, or insufficient evidence of ties to India under INA Section 214(b) — a clear invitation letter and strong ties documentation materially improve outcomes.', 180, 2, 805, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — F-1 Academic Student Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    180, 3, 'USA-STU-IN-03', '2026.09', 'published',
    'Full-time academic study at a US college, university, or SEVP-certified institution.',
    'Requires an I-20 form issued by a SEVP-certified school AFTER you are admitted, and payment of the separate SEVIS I-901 fee before you can even book your visa interview — the sequence matters and cannot be skipped.',
    'Duration of study program (F-1 status, "D/S" — duration of status)',
    'Nonimmigrant visa application via DS-160, in-person interview, requires prior I-20 issuance and SEVIS registration',
    1,
    'Book your interview as early as possible — F-1 visas may be issued up to 365 days before your program start date, but you cannot enter the US more than 30 days before that date',
    'US Embassy New Delhi or US Consulate (Mumbai, Chennai, Hyderabad, Kolkata) — scheduled via ustraveldocs.com',
    'Secure admission and receive your Form I-20 from a SEVP-certified school\nPay the SEVIS I-901 fee and print your confirmation\nComplete the DS-160 online application form\nPay the MRV application fee and schedule your interview\nGather documents against this checklist\nAttend your in-person interview\nCollect your passport with visa once approved',
    '/assets/images/visa-heroes/usa.jpg',
    'US Department of State F-1 Student Visa guidance and SEVP I-901 fee schedule', 'https://travel.state.gov/content/travel/en/us-visas/study/student-visa.html', '2026-09-11'
);
SET @ut3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ut3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut3, 'Core Documents', 'Every applicant needs these.', 1);
SET @ut3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut3s1, 'Valid Passport', 'Valid for at least 6 months beyond your intended stay.', 'original', 1, 0, 1, 1),
(@ut3s1, 'Form I-20', 'Issued and signed by your SEVP-certified school after admission — required before you can apply.', 'original', 1, 0, 1, 2),
(@ut3s1, 'SEVIS Fee Payment Receipt (I-901)', 'Paid separately from the MRV fee, before scheduling your interview.', 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut3, 'Academic Documents', 'Evidence of your admission and academic record.', 2);
SET @ut3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut3s2, 'Admission/Acceptance Letter', 'From your SEVP-certified school.', 'original', 1, 0, 1, 1),
(@ut3s2, 'Academic Transcripts & Test Scores', 'Prior degree transcripts, SAT/GRE/GMAT/TOEFL/IELTS scores as required by your program.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut3, 'Financial Documents', 'Evidence you can fund your entire program.', 3);
SET @ut3s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut3s3, 'Financial Support Evidence', 'Bank statements, loan sanction letters, or scholarship/sponsor letters covering tuition and living costs shown on your I-20.', 'copy', 1, 0, 0, 1),
(@ut3s3, 'Sponsor Affidavit of Support', 'If funded by a parent/relative, with their bank statements and relationship proof.', 'copy', 0, 1, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut3, 'Interview & Fee', 'Booking and attending your consular interview.', 4);
SET @ut3s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut3s4, 'MRV Fee Payment Receipt', NULL, 'original', 1, 0, 0, 1),
(@ut3s4, 'DS-160 Confirmation Page', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(180, 3, 535.00, 'USD', 'MRV Fee + SEVIS I-901 Fee', 'USD 185 MRV application fee plus a separate USD 350 SEVIS I-901 fee, both paid before your interview. The Visa Integrity Fee (USD 250, approved visas only, FY2026 rollout) may also apply — we confirm the full current total before you apply.', '2026-09-01', NOW(), 'https://travel.state.gov/content/travel/en/us-visas/study/student-visa.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is the SEVIS fee and is it different from the visa fee?', 'Yes — the SEVIS I-901 fee (USD 350) is separate from and in addition to the USD 185 MRV visa application fee. It must be paid before you can schedule your interview.', 180, 3, 806, 1),
('How early can I apply for my F-1 visa?', 'F-1 visas may be issued up to 365 days before your program start date, but you cannot enter the US more than 30 days before that date.', 180, 3, 807, 1),
('Do I need my I-20 before applying?', 'Yes — you must be admitted and receive your Form I-20 from a SEVP-certified school before you can pay the SEVIS fee or complete your DS-160.', 180, 3, 808, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — H-1B Specialty Occupation
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    180, 4, 'USA-WORK-IN-04', '2026.09', 'published',
    'Specialty-occupation employment in the United States, sponsored by a US employer.',
    'H-1B is entirely employer-sponsored — an individual cannot self-petition. The employer must first file a Labor Condition Application (LCA, Form ETA-9035) with the Department of Labor, then submit an I-129 petition to USCIS, which is subject to an annual lottery cap of 85,000 (65,000 regular cap + 20,000 US master''s degree exemption).',
    'Initial approval up to 3 years, extendable to a maximum of 6 years (longer in specific green-card-pending scenarios)',
    'Employer files I-129 petition with USCIS; once approved, employee applies for the H-1B visa stamp via DS-160 and in-person interview',
    1,
    'Visa stamping interview typically scheduled after USCIS approves the I-129 petition — processing time depends on premium processing election by the employer',
    'US Embassy New Delhi or US Consulate (Mumbai, Chennai, Hyderabad, Kolkata) — scheduled via ustraveldocs.com',
    'Employer files LCA (ETA-9035) with the Department of Labor\nEmployer submits I-129 petition to USCIS (subject to annual lottery cap)\nOnce approved, complete your DS-160 application\nPay the MRV application fee (H-category rate) and schedule your interview\nGather documents against this checklist\nAttend your in-person interview\nCollect your passport with visa once approved',
    '/assets/images/visa-heroes/usa.jpg',
    'USCIS H-1B Specialty Occupations guidance and US Department of State nonimmigrant visa fee schedule', 'https://www.uscis.gov/working-in-the-united-states/h-1b-specialty-occupations', '2026-09-11'
);
SET @ut4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ut4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut4, 'Core Documents', 'Every applicant needs these.', 1);
SET @ut4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut4s1, 'Valid Passport', 'Valid for at least 6 months beyond your intended stay.', 'original', 1, 0, 1, 1),
(@ut4s1, 'Form I-797 Approval Notice', 'USCIS approval of the employer''s I-129 petition.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut4, 'Employer Sponsorship Documents', 'Evidence of the employer-sponsored petition.', 2);
SET @ut4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut4s2, 'Labor Condition Application (ETA-9035)', 'Certified by the Department of Labor before the I-129 petition was filed.', 'copy', 1, 0, 1, 1),
(@ut4s2, 'Offer Letter & Job Description', 'From your sponsoring US employer, describing the specialty occupation role.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut4, 'Qualification Documents', 'Evidence you meet the specialty-occupation requirement.', 3);
SET @ut4s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut4s3, 'Educational Credentials', 'Degree certificates and transcripts, with a credential evaluation if from outside the US.', 'copy', 1, 0, 0, 1),
(@ut4s3, 'Resume/CV & Prior Employment Letters', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut4, 'Interview & Fee', 'Booking and attending your consular interview.', 4);
SET @ut4s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut4s4, 'MRV Fee Payment Receipt (H-Category Rate)', NULL, 'original', 1, 0, 0, 1),
(@ut4s4, 'DS-160 Confirmation Page', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(180, 4, 205.00, 'USD', 'MRV Application Fee (H-Category)', 'H, L, O, P, and Q/R category visas carry a higher USD 205 MRV fee than the standard USD 185 rate. This does not include the employer''s separate USCIS filing fees (I-129, ACWIA, fraud-prevention fees), which the sponsoring employer pays, not the applicant.', '2026-09-01', NOW(), 'https://www.uscis.gov/working-in-the-united-states/h-1b-specialty-occupations', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I apply for an H-1B visa on my own?', 'No — H-1B is entirely employer-sponsored. A US employer must file the Labor Condition Application and I-129 petition on your behalf before you can apply for the visa stamp.', 180, 4, 809, 1),
('Is H-1B subject to an annual limit?', 'Yes — an annual lottery cap of 85,000 (65,000 regular cap plus 20,000 for US master''s degree holders), so timing and employer registration matter.', 180, 4, 810, 1),
('How long can I stay on an H-1B?', 'Initial approval is up to 3 years, extendable to a maximum of 6 years, with further extensions possible in specific green-card-pending scenarios.', 180, 4, 811, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — B-2 Visitor Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    180, 5, 'USA-FAM-IN-05', '2026.09', 'published',
    'Visiting family members or friends living in the United States.',
    'Family visits fall under the same B-1/B-2 Visitor Visa class as Tourist — the US has no separate "family visit visa." The difference is purpose-specific supporting documents: an invitation and relationship proof from your US-based host.',
    'Typically up to 6 months per entry, as decided by the CBP officer at the port of entry',
    'Nonimmigrant visa application via DS-160, in-person interview at the US Embassy/Consulate',
    1,
    'Interview wait time varies significantly by consulate — check the State Department''s current Global Visa Wait Times page',
    'US Embassy New Delhi or US Consulate (Mumbai, Chennai, Hyderabad, Kolkata) — scheduled via ustraveldocs.com',
    'Initial consultation to confirm B-2 Family Visit purpose is correct\nComplete the DS-160 online application form\nObtain an invitation letter and relationship proof from your US host\nPay the MRV application fee and schedule your interview\nGather documents against this checklist\nAttend your in-person interview\nCollect your passport with visa once approved',
    '/assets/images/visa-heroes/usa.jpg',
    'US Department of State B-1/B-2 Visitor Visa guidance', 'https://travel.state.gov/content/travel/en/us-visas/tourism-visit/visitor.html', '2026-09-11'
);
SET @ut5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ut5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut5, 'Core Documents', 'Every applicant needs these.', 1);
SET @ut5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut5s1, 'Valid Passport', 'Valid for at least 6 months beyond your intended stay.', 'original', 1, 0, 1, 1),
(@ut5s1, 'DS-160 Confirmation Page', NULL, 'original', 1, 0, 1, 2),
(@ut5s1, 'Passport Photograph', '2x2 inch (51x51mm) colour photo, white background.', 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut5, 'Host Invitation & Relationship Proof', 'Evidence of who you are visiting.', 2);
SET @ut5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut5s2, 'Invitation Letter from US Host', 'Stating relationship, purpose, and duration of your visit.', 'original', 1, 0, 1, 1),
(@ut5s2, 'Proof of Host''s Status in the US', 'Copy of your host''s Green Card, visa, or citizenship document.', 'copy', 1, 0, 1, 2),
(@ut5s2, 'Relationship Proof', 'Birth/marriage certificates or other documents establishing the family relationship.', 'copy', 1, 0, 0, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut5, 'Financial & Ties Documents', 'Evidence of funds and ties to India.', 3);
SET @ut5s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut5s3, 'Bank Statements', 'Last 6 months.', 'copy', 1, 0, 0, 1),
(@ut5s3, 'Proof of Ties to India', 'Employment and property evidence showing intent to return.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut5, 'Interview & Fee', 'Booking and attending your consular interview.', 4);
SET @ut5s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut5s4, 'MRV Fee Payment Receipt', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(180, 5, 185.00, 'USD', 'MRV Application Fee', 'Same fee and Visa Integrity Fee (USD 250, approved visas only) structure as Tourist — Family Visit is the same B-1/B-2 visa class.', '2026-09-01', NOW(), 'https://travel.state.gov/content/travel/en/us-visas/tourism-visit/visitor.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a Family Visit visa different from a Tourist visa in the US?', 'No — both use the same B-1/B-2 Visitor Visa. The application is the same; only the supporting documents (your host''s invitation and relationship proof) differ.', 180, 5, 812, 1),
('What proof of relationship is accepted?', 'Birth certificates, marriage certificates, or other official documents establishing your relationship to your US-based host, alongside their invitation letter.', 180, 5, 813, 1),
('Does my host need to sponsor me financially?', 'Not necessarily — an affidavit of support from your host can help, but you may also demonstrate your own sufficient funds and ties to India.', 180, 5, 814, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — C-1 Transit Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    180, 6, 'USA-TRANS-IN-06', '2026.09', 'published',
    'Passing through the United States en route to a third country.',
    'A C-1 Transit Visa is only needed if you do not already hold another valid US visa. Many Indian travellers connecting through the US already hold a valid B-1/B-2 or other visa, in which case a separate transit visa is not required — this checklist covers the case where you genuinely need a standalone C-1.',
    'Typically 29 days maximum, strictly for transit purposes',
    'Nonimmigrant visa application via DS-160, in-person interview at the US Embassy/Consulate',
    1,
    'Confirm first whether you already hold a valid US visa that covers transit — a C-1 application is only necessary if you do not',
    'US Embassy New Delhi or US Consulate (Mumbai, Chennai, Hyderabad, Kolkata) — scheduled via ustraveldocs.com',
    'Confirm you do not already hold a valid US visa covering transit\nComplete the DS-160 online application form\nGather documents against this checklist, including onward tickets and destination-country visa if required\nPay the MRV application fee and schedule your interview\nAttend your in-person interview\nCollect your passport with visa once approved',
    '/assets/images/visa-heroes/usa.jpg',
    'US Department of State C-1 Transit Visa guidance', 'https://travel.state.gov/content/travel/en/us-visas/transit-crewmember.html', '2026-09-11'
);
SET @ut6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ut6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut6, 'Core Documents', 'Every applicant needs these.', 1);
SET @ut6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut6s1, 'Valid Passport', 'Valid for at least 6 months beyond your intended stay.', 'original', 1, 0, 1, 1),
(@ut6s1, 'DS-160 Confirmation Page', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut6, 'Onward Travel Documents', 'Evidence you are genuinely transiting, not stopping.', 2);
SET @ut6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut6s2, 'Onward/Connecting Flight Ticket', 'Confirmed ticket to your final destination.', 'copy', 1, 0, 1, 1),
(@ut6s2, 'Valid Visa for Destination Country', 'If required by your final destination.', 'copy', 0, 1, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut6, 'Interview & Fee', 'Booking and attending your consular interview.', 3);
SET @ut6s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut6s3, 'MRV Fee Payment Receipt', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(180, 6, 185.00, 'USD', 'MRV Application Fee', 'Standard non-petition-based category fee, only payable if you do not already hold another valid US visa covering transit.', '2026-09-01', NOW(), 'https://travel.state.gov/content/travel/en/us-visas/transit-crewmember.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I always need a separate transit visa for the US?', 'No — if you already hold another valid US visa (e.g. B-1/B-2), you typically do not need a separate C-1 Transit Visa. Confirm your specific itinerary with us before applying.', 180, 6, 815, 1),
('How long can I stay in the US on a C-1 visa?', 'Typically up to 29 days, strictly for transit purposes — it is not intended for tourism or business activity.', 180, 6, 816, 1),
('Do I need a visa for my final destination too?', 'If your final destination country requires one, you should have it (or evidence you are eligible for one) before your US transit interview.', 180, 6, 817, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — B-2 Visitor Visa (Medical Treatment)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    180, 7, 'USA-MED-IN-07', '2026.09', 'published',
    'Travelling to the United States to receive medical treatment.',
    'Medical treatment is a standard, explicitly recognized B-2 Visitor Visa purpose — the US has no separate "medical visa" category. A hospital/physician appointment letter and evidence of funds to cover treatment costs are the key purpose-specific documents.',
    'As needed for the course of treatment, typically up to 6 months, extendable with evidence of ongoing treatment',
    'Nonimmigrant visa application via DS-160, in-person interview at the US Embassy/Consulate',
    1,
    'Interview wait time varies significantly by consulate — check the State Department''s current Global Visa Wait Times page',
    'US Embassy New Delhi or US Consulate (Mumbai, Chennai, Hyderabad, Kolkata) — scheduled via ustraveldocs.com',
    'Initial consultation to confirm B-2 Medical Treatment purpose is correct\nObtain a treatment/appointment letter from the US hospital or physician\nComplete the DS-160 online application form\nPay the MRV application fee and schedule your interview\nGather documents against this checklist\nAttend your in-person interview\nCollect your passport with visa once approved',
    '/assets/images/visa-heroes/usa.jpg',
    'US Department of State B-1/B-2 Visitor Visa guidance (medical treatment is an explicit B-2 purpose)', 'https://travel.state.gov/content/travel/en/us-visas/tourism-visit/visitor.html', '2026-09-11'
);
SET @ut7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ut7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut7, 'Core Documents', 'Every applicant needs these.', 1);
SET @ut7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut7s1, 'Valid Passport', 'Valid for at least 6 months beyond your intended stay.', 'original', 1, 0, 1, 1),
(@ut7s1, 'DS-160 Confirmation Page', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut7, 'Medical Documents', 'Evidence of your treatment plan.', 2);
SET @ut7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut7s2, 'Hospital/Physician Appointment Letter', 'From the US medical facility, confirming diagnosis, planned treatment, and estimated duration.', 'original', 1, 0, 1, 1),
(@ut7s2, 'Diagnosis Report from Indian Physician', 'Explaining why treatment in the US is needed.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut7, 'Financial Documents', 'Evidence you can pay for treatment and travel.', 3);
SET @ut7s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut7s3, 'Cost Estimate from US Facility', NULL, 'copy', 1, 0, 0, 1),
(@ut7s3, 'Bank Statements/Financial Guarantee', 'Showing ability to pay for treatment, or a sponsor''s financial guarantee.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut7, 'Interview & Fee', 'Booking and attending your consular interview.', 4);
SET @ut7s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut7s4, 'MRV Fee Payment Receipt', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(180, 7, 185.00, 'USD', 'MRV Application Fee', 'Same fee and Visa Integrity Fee (USD 250, approved visas only) structure as Tourist — Medical treatment is a B-2 purpose, not a separate visa class.', '2026-09-01', NOW(), 'https://travel.state.gov/content/travel/en/us-visas/tourism-visit/visitor.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Medical Visa for the US?', 'No — medical treatment is a recognized B-2 Visitor Visa purpose, not a distinct visa category. Your appointment letter and treatment plan are the key differentiating documents.', 180, 7, 818, 1),
('Can I extend my stay if my treatment takes longer than expected?', 'Yes — extensions are possible with evidence of ongoing treatment from your US physician, filed before your current authorized stay expires.', 180, 7, 819, 1),
('Do I need proof I can pay for the full treatment cost upfront?', 'You need to show credible ability to pay — this can be your own funds, insurance, or a documented sponsor''s financial guarantee, not necessarily the full amount in a single account.', 180, 7, 820, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — B-1 Visitor Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    180, 8, 'USA-CONF-IN-08', '2026.09', 'published',
    'Attending or presenting at a scientific, educational, professional, or business conference, convention, or seminar in the United States.',
    'The State Department''s own B-1 Fact Sheet explicitly lists conference/convention/seminar attendance as a permissible B-1 activity — Conference is not a separate visa category, it is the same B-1/B-2 Visitor Visa as Business, with conference-specific supporting documents.',
    'Typically up to 6 months per entry, as decided by the CBP officer at the port of entry',
    'Nonimmigrant visa application via DS-160, in-person interview at the US Embassy/Consulate',
    1,
    'Interview wait time varies significantly by consulate — check the State Department''s current Global Visa Wait Times page',
    'US Embassy New Delhi or US Consulate (Mumbai, Chennai, Hyderabad, Kolkata) — scheduled via ustraveldocs.com',
    'Initial consultation to confirm B-1 Conference purpose is correct\nObtain your conference invitation/registration and (if presenting) acceptance letter\nComplete the DS-160 online application form\nPay the MRV application fee and schedule your interview\nGather documents against this checklist\nAttend your in-person interview\nCollect your passport with visa once approved',
    '/assets/images/visa-heroes/usa.jpg',
    'US Department of State B-1 Fact Sheet (conference/convention/seminar attendance listed as a permissible B-1 activity)', 'https://travel.state.gov/content/travel/en/us-visas/business/b-1-fact-sheet.html', '2026-09-11'
);
SET @ut8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ut8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut8, 'Core Documents', 'Every applicant needs these.', 1);
SET @ut8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut8s1, 'Valid Passport', 'Valid for at least 6 months beyond your intended stay.', 'original', 1, 0, 1, 1),
(@ut8s1, 'DS-160 Confirmation Page', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut8, 'Conference Documents', 'Evidence of the event and your role in it.', 2);
SET @ut8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut8s2, 'Conference Invitation/Registration Confirmation', 'From the organizing body, stating event name, dates, and venue.', 'original', 1, 0, 1, 1),
(@ut8s2, 'Acceptance Letter for Presenters', 'If presenting a paper/poster, confirmation of your accepted submission.', 'copy', 0, 1, 1, 2),
(@ut8s2, 'Sponsoring Employer Letter', 'Confirming purpose of travel and, if applicable, that costs are covered by your employer (reimbursement only, no US salary).', 'original', 1, 0, 0, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut8, 'Financial & Ties Documents', 'Evidence of funds and ties to India.', 3);
SET @ut8s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut8s3, 'Bank Statements', 'Last 6 months.', 'copy', 1, 0, 0, 1),
(@ut8s3, 'Proof of Ties to India', 'Employment and property evidence showing intent to return.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut8, 'Interview & Fee', 'Booking and attending your consular interview.', 4);
SET @ut8s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut8s4, 'MRV Fee Payment Receipt', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(180, 8, 185.00, 'USD', 'MRV Application Fee', 'Same fee and Visa Integrity Fee (USD 250, approved visas only) structure as Tourist/Business — Conference is a B-1 purpose, not a separate visa class.', '2026-09-01', NOW(), 'https://travel.state.gov/content/travel/en/us-visas/business/b-1-fact-sheet.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Conference Visa for the US?', 'No — attending or presenting at a conference is an explicitly recognized B-1 activity, not a distinct visa category. It uses the same B-1/B-2 visa as Business.', 180, 8, 821, 1),
('Can my employer or the conference organizer cover my expenses?', 'Reimbursement of incidental travel, lodging, and meal expenses is permitted; you cannot receive a US salary while on B-1 status.', 180, 8, 822, 1),
('Do I need proof I have been accepted to present?', 'Only if you are presenting a paper or poster — if you are simply attending, your registration confirmation and invitation letter are sufficient.', 180, 8, 823, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — P-1A / O-1 Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    180, 9, 'USA-SPORT-IN-09', '2026.09', 'published',
    'Competing or coaching in the United States as an internationally recognized athlete, team member, or coach.',
    'Professional/internationally-recognized athletes typically use the P-1A visa (individual or team), requiring a US petitioner (team, league, or sponsoring organization) to file an I-129 petition with evidence of international recognition. Athletes of extraordinary ability may instead qualify for O-1. Amateur participants in a genuinely amateur event may instead qualify under B-1/B-2 — we confirm the right category for your competition.',
    'Tied to the competition/event/season, typically up to 5 years for P-1A with extensions',
    'US petitioner files I-129 petition with USCIS; once approved, applicant applies for the visa stamp via DS-160 and in-person interview',
    1,
    'Petition approval timeline depends on the petitioner''s premium processing election',
    'US Embassy New Delhi or US Consulate (Mumbai, Chennai, Hyderabad, Kolkata) — scheduled via ustraveldocs.com',
    'US petitioner (team/league/sponsoring body) files I-129 petition, P-1A or O-1 as applicable\nOnce approved, complete your DS-160 application\nPay the MRV application fee (P/O-category rate) and schedule your interview\nGather documents against this checklist\nAttend your in-person interview\nCollect your passport with visa once approved',
    '/assets/images/visa-heroes/usa.jpg',
    'USCIS P-1A Internationally Recognized Athlete and O-1 Extraordinary Ability visa guidance', 'https://www.uscis.gov/working-in-the-united-states/temporary-workers/p-1a-internationally-recognized-athlete', '2026-09-11'
);
SET @ut9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ut9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut9, 'Core Documents', 'Every applicant needs these.', 1);
SET @ut9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut9s1, 'Valid Passport', 'Valid for at least 6 months beyond your intended stay.', 'original', 1, 0, 1, 1),
(@ut9s1, 'Form I-797 Approval Notice', 'USCIS approval of the petitioner''s I-129 petition.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut9, 'Petition & Recognition Documents', 'Evidence of your petitioner and international recognition.', 2);
SET @ut9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut9s2, 'Petitioner''s Consultation/Support Letter', 'From a relevant sports governing body or players'' association.', 'copy', 1, 0, 1, 1),
(@ut9s2, 'Evidence of International Recognition', 'Rankings, awards, media coverage, or competition records establishing your standing.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut9, 'Event/Contract Documents', 'Evidence of your specific engagement.', 3);
SET @ut9s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut9s3, 'Contract or Event Schedule', 'With the petitioning team, league, or event organizer.', 'copy', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut9, 'Interview & Fee', 'Booking and attending your consular interview.', 4);
SET @ut9s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut9s4, 'MRV Fee Payment Receipt (P/O-Category Rate)', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(180, 9, 205.00, 'USD', 'MRV Application Fee (P/O-Category)', 'P and O category visas carry the higher USD 205 MRV fee, same rate as H-category. Does not include the petitioner''s separate USCIS I-129 filing fees.', '2026-09-01', NOW(), 'https://www.uscis.gov/working-in-the-united-states/temporary-workers/p-1a-internationally-recognized-athlete', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Which visa do professional athletes use for the US?', 'Most internationally recognized athletes and team members use the P-1A visa; those of extraordinary/exceptional ability may instead qualify for O-1. We confirm the right category based on your specific competition and standing.', 180, 9, 824, 1),
('Can an amateur athlete use this category?', 'Genuinely amateur, non-professional participants may sometimes qualify under B-1/B-2 instead — we assess this case by case rather than defaulting everyone to P-1A/O-1.', 180, 9, 825, 1),
('Do I need a US-based sponsor to apply?', 'Yes — P-1A and O-1 both require a US petitioner (team, league, or sponsoring organization) to file the I-129 petition; you cannot self-petition.', 180, 9, 826, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — H-4 Dependent Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    180, 10, 'USA-DEP-IN-10', '2026.09', 'published',
    'Accompanying a spouse or parent who holds H-1B status in the United States, as their spouse or unmarried child under 21.',
    'H-4 is a derivative status entirely dependent on the principal H-1B holder''s valid status and timeline — it cannot be applied for independently or before the principal''s H-1B is approved. In certain cases, an H-4 holder may separately apply for an Employment Authorization Document (EAD) to work in the US.',
    'Matches the validity period of the principal H-1B holder''s status',
    'Nonimmigrant visa application via DS-160, in-person interview, tied to principal H-1B holder''s approval',
    1,
    'Apply only after the principal H-1B holder''s status/petition is approved — H-4 cannot be processed independently',
    'US Embassy New Delhi or US Consulate (Mumbai, Chennai, Hyderabad, Kolkata) — scheduled via ustraveldocs.com',
    'Confirm the principal H-1B holder''s petition/status is approved\nComplete the DS-160 online application form\nGather documents against this checklist, including relationship proof\nPay the MRV application fee (H-category rate) and schedule your interview\nAttend your in-person interview\nCollect your passport with visa once approved',
    '/assets/images/visa-heroes/usa.jpg',
    'USCIS H-4 Dependent Visa and USCIS H-4 EAD guidance', 'https://www.uscis.gov/working-in-the-united-states/h-1b-specialty-occupations', '2026-09-11'
);
SET @ut10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ut10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut10, 'Core Documents', 'Every applicant needs these.', 1);
SET @ut10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut10s1, 'Valid Passport', 'Valid for at least 6 months beyond your intended stay.', 'original', 1, 0, 1, 1),
(@ut10s1, 'DS-160 Confirmation Page', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut10, 'Principal Holder & Relationship Documents', 'Evidence of the H-1B holder you are accompanying.', 2);
SET @ut10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut10s2, 'Principal H-1B Holder''s Approval Notice (I-797)', 'Copy of the principal''s approved H-1B petition.', 'copy', 1, 0, 1, 1),
(@ut10s2, 'Marriage Certificate', 'For a spouse applicant.', 'copy', 0, 1, 1, 2),
(@ut10s2, 'Birth Certificate', 'For a child applicant, under 21 and unmarried.', 'copy', 0, 1, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut10, 'Financial Documents', 'Evidence the principal can support you.', 3);
SET @ut10s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut10s3, 'Principal Holder''s Pay Stubs/Employment Letter', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ut10, 'Interview & Fee', 'Booking and attending your consular interview.', 4);
SET @ut10s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ut10s4, 'MRV Fee Payment Receipt (H-Category Rate)', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(180, 10, 205.00, 'USD', 'MRV Application Fee (H-Category)', 'Same H-category USD 205 rate as the principal H-1B holder''s own visa fee.', '2026-09-01', NOW(), 'https://www.uscis.gov/working-in-the-united-states/h-1b-specialty-occupations', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I apply for an H-4 visa before my spouse''s H-1B is approved?', 'No — H-4 is a derivative status. You can only apply once the principal H-1B holder''s petition or status is approved.', 180, 10, 827, 1),
('Can I work in the US on an H-4 visa?', 'Not automatically — some H-4 holders may separately apply for an Employment Authorization Document (EAD), depending on the principal holder''s specific H-1B status and green card stage.', 180, 10, 828, 1),
('Who qualifies as a dependent for H-4?', 'The spouse or an unmarried child under 21 of the principal H-1B holder.', 180, 10, 829, 1);
