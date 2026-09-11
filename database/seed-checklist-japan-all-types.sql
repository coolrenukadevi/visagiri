-- Japan Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search, same standard as Mexico/Singapore/
-- France (see AUDIT.md). Japan's real, distinctive facts differ from
-- all three:
--   - India and Japan have a bilateral treaty rate: the government
--     consular fee for Indian passport holders is a genuinely low flat
--     INR 500 (single or multiple entry) / INR 50 (transit) — a real,
--     sourced fact worth highlighting clearly, kept separate from
--     VFS Global's own service charge (which is NOT a government fee).
--   - As of 2026, eligible Indian tourists can use Japan's
--     accredited-agency eVISA for single-entry short-term tourism —
--     stated as an option alongside the standard VFS Global route, not
--     a blanket replacement (eligibility/accreditation conditions
--     apply).
--   - Student and Work visas are both built around a Certificate of
--     Eligibility (COE) obtained by the Japanese institution/employer
--     BEFORE the applicant ever applies for the visa itself — this is
--     the single most load-bearing fact for both checklists.
--   - Japan has no dedicated "Sports Visa" sticker category the way
--     France does; short-term sporting activity is covered either by
--     the Short-Term Business Visa (for cultural/sport exchange) or,
--     for genuine amateur athletes with a federation sponsor, the
--     "Amateur Athlete" designated-activities status — both stated
--     honestly rather than inventing a single named "Sports Visa."
--   - Historically, Japan's visa process for Indian applicants is
--     document-based via VFS Global rather than biometric/interview-
--     driven the way Schengen is — personal_appearance is set to 0
--     across the board to reflect that, based on consistent search
--     results across every category researched.
--
-- country_id 72 = Japan. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical,
-- 8=Conference, 9=Sports, 10=Dependent.
--
-- hero_image_url points at the real Mt. Fuji/Chureito Pagoda/Japanese
-- flag photo supplied by the client for this hero.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Short-Term Stay (Tourism)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    72, 1, 'JPN-TOUR-IN-01', '2026.09', 'published',
    'Leisure travel, sightseeing, and short personal visits to Japan.',
    'All Indian passport holders require a valid Japanese visa before travel — there is no visa-on-arrival. As of 2026, eligible applicants can alternatively use Japan''s accredited-agency eVISA for single-entry short-term tourism, entirely online.',
    'Up to 90 days, single or multiple entry depending on approval',
    'Via VFS Global, or Japan''s accredited-agency eVISA for eligible single-entry tourism',
    0,
    '5-7 working days for a complete application (indicative)',
    'VFS Global Japan Visa Application Centre, India',
    'Initial consultation to confirm Tourist Visa is the right category, and whether the eVISA route applies to you\nGather documents against this checklist, including a detailed day-by-day itinerary\nApplication preparation and formatting\nSubmission via VFS Global (or online, for eVISA-eligible applicants)\nSupport responding to any additional-information request\nDecision — visa sticker affixed to your passport (or eVISA issued electronically)\nCollect your passport from VFS, if applicable',
    '/assets/images/visa-heroes/japan.jpg',
    'Independent visa-agency guidance for Japan tourist visas issued to Indian passport holders', 'https://btwvisas.com/visa-guide/japan-tourist-visa', '2026-09-11'
);
SET @jpt1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@jpt1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt1, 'Core Documents', 'Every applicant needs these.', 1);
SET @jt1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt1s1, 'Valid Passport', 'Issued within the last 10 years, valid 6+ months beyond planned departure, with at least 2 blank facing pages.', 'original', 1, 0, 1, 1),
(@jt1s1, 'Passport-Size Photograph', '45mm x 45mm (square format), white background, taken within the last 6 months.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt1, 'Travel & Financial Documents', 'Your itinerary and financial standing.', 2);
SET @jt1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt1s2, 'Detailed Day-by-Day Itinerary', NULL, 'original', 1, 0, 1, 1),
(@jt1s2, 'Bank Statement', 'Recent statement with a healthy balance.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt1, 'Employment Documents', 'Evidence you will return to your role in India.', 3);
SET @jt1s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt1s3, 'Employer Leave Letter / NOC', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt1, 'Application Documents', 'Your formal application paperwork.', 4);
SET @jt1s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt1s4, 'Completed Visa Application Form', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt1, 'Submission', 'Via VFS Global or eVISA.', 5);
SET @jt1s5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt1s5, 'Visa Fee Payment Receipt', NULL, 'original', 1, 0, 0, 1),
(@jt1s5, 'Passport Submission Acknowledgement', 'For VFS Global submissions.', 'original', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(72, 1, 500.00, 'INR', 'Consular Fee (India-Japan Treaty Rate)', 'This is the government fee only, under the India-Japan bilateral treaty rate. VFS Global''s separate service charge and biometric fee are additional (commonly bringing the total to around INR 2,200-2,900).', '2026-06-01', NOW(), 'https://btwvisas.com/visa-guide/japan-tourist-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Why is Japan''s visa fee so low for Indians?', 'India and Japan have a bilateral treaty rate — the government consular fee for Indian passport holders is just INR 500, much lower than many other countries'' visa fees. VFS Global''s own service charge is separate and additional.', 72, 1, 700, 1),
('Can I apply for a Japan tourist visa online?', 'As of 2026, eligible applicants can use Japan''s accredited-agency eVISA for single-entry short-term tourism entirely online — we can confirm if you qualify, otherwise the standard VFS Global route applies.', 72, 1, 701, 1),
('Is there a visa-on-arrival for Japan?', 'No — all Indian passport holders need a valid visa before travel; Japan does not offer visa-on-arrival for Indian nationals.', 72, 1, 702, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Short-Term Business Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    72, 2, 'JPN-BUS-IN-02', '2026.09', 'published',
    'Short-term business visits — meetings, negotiations, and market research — to Japan.',
    'Requires an invitation or sponsorship from a company in Japan — typically an original Invitation Letter and, sometimes, a Letter of Guarantee from the sponsoring company.',
    'Up to 90 days, single or multiple entry depending on travel history and stated purpose',
    'Via VFS Global Japan Visa Application Centre',
    0,
    '5-7 working days, provided documentation from the Japanese inviting party is complete (indicative)',
    'VFS Global Japan Visa Application Centre, India',
    'Initial consultation to confirm the trip is a genuine business visit\nObtain an Invitation Letter (and Letter of Guarantee, if required) from your Japanese host company\nGather documents against this checklist\nApplication preparation\nSubmission via VFS Global\nSupport responding to any additional-information request\nCollect your passport from VFS once approved',
    '/assets/images/visa-heroes/japan.jpg',
    'VFS Global Japan and independent visa-agency guidance for short-term business visas issued to Indian applicants', 'https://www.vfsglobal.com/one-pager/japan/india/delhi/pdf/3-Short-Term-Business-Visa.pdf', '2026-09-11'
);
SET @jpt2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@jpt2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt2, 'Core Documents', 'Every applicant needs these.', 1);
SET @jt2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt2s1, 'Valid Passport', 'Valid at least 6 months beyond planned departure, with photocopies.', 'original', 1, 0, 1, 1),
(@jt2s1, 'Passport-Size Photograph', '2x2 inch photograph on the application form.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt2, 'Business Invitation & Purpose', 'Evidence of who you are meeting and why.', 2);
SET @jt2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt2s2, 'Invitation Letter from Japanese Host', 'Including your itinerary in Japan, hotel information, and contact details.', 'original', 1, 0, 1, 1),
(@jt2s2, 'Letter of Guarantee', 'From the sponsoring Japanese company, where required.', 'original', 0, 1, 1, 2),
(@jt2s2, 'Cover Letter / Travel Order from Employer', 'Stating your designation, purpose of travel, and confirmation that expenses will be covered.', 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt2, 'Financial Documents', 'Evidence you can support your trip.', 3);
SET @jt2s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt2s3, 'Bank Statements', 'Last 6 months, with bank stamp and authorised signature on every page.', 'copy', 1, 0, 0, 1),
(@jt2s3, 'Income Tax Returns / Form 16', 'Typically the last 3 years.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt2, 'Employment Documents', 'Evidence of your role and approved leave.', 4);
SET @jt2s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt2s4, 'Original Leave Letter from Employer', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt2, 'Application Documents', 'Your formal application paperwork.', 5);
SET @jt2s5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt2s5, 'Completed Visa Application Form', NULL, 'original', 1, 0, 0, 1),
(@jt2s5, 'Visa Fee Payment Receipt', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(72, 2, 500.00, 'INR', 'Consular Fee (India-Japan Treaty Rate)', 'Government fee only; VFS Global''s separate service charge is additional (commonly around INR 800).', '2025-12-01', NOW(), 'https://www.businesstoday.in/nri/visa/story/japan-business-visa-for-indians-short-term-or-long-haul-everything-you-need-to-know-532021-2026-05-19', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What documents does my Japanese host need to provide?', 'An original Invitation Letter (and sometimes a Letter of Guarantee) from the sponsoring company, including your itinerary and hotel information in Japan.', 72, 2, 710, 1),
('How long does a Japan business visa take?', 'Typically 5-7 working days once all documentation from the Japanese inviting party is complete and in order.', 72, 2, 711, 1),
('Do I need to appear in person for a Japan business visa?', 'No — applications are submitted through VFS Global as a document-based process; there is no interview requirement for the standard short-term business visa.', 72, 2, 712, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Certificate of Eligibility (COE)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    72, 3, 'JPN-STU-IN-03', '2026.09', 'published',
    'Full-time study at a Japanese educational institution.',
    'You cannot apply for the student visa without a Certificate of Eligibility (COE) — your Japanese institution applies for this on your behalf, not you directly. The COE is valid for 3 months from issuance, so you must apply for your visa and enter Japan within that window.',
    'Duration of your course, subject to your Residence Card remaining valid',
    'Certificate of Eligibility (COE) obtained by your Japanese institution, then a visa application via VFS Global',
    0,
    'COE processing 4-8 weeks, then visa issuance in a few working days once the COE is obtained (indicative)',
    'VFS Global Japan Visa Application Centre, India',
    'Secure admission to a Japanese institution\nYour institution applies for your Certificate of Eligibility (COE) on your behalf\nGather documents against this checklist once the COE is issued\nApplication preparation\nSubmission via VFS Global — apply within 3 months of your COE''s issue date\nCollect your passport from VFS once approved\nAfter arrival: register your address and receive your Residence Card',
    '/assets/images/visa-heroes/japan.jpg',
    'Independent education-consultancy guidance for the Japan student visa (COE process) issued to Indian applicants', 'https://leverageedu.com/learn/japan-student-visa/', '2026-09-11'
);
SET @jpt3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@jpt3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt3, 'Core Documents', 'Every applicant needs these.', 1);
SET @jt3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt3s1, 'Valid Passport', 'Valid well beyond your course duration.', 'original', 1, 0, 1, 1),
(@jt3s1, 'Passport-Size Photograph', '45mm x 45mm, white background.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt3, 'Admission & COE Documents', 'Proof of your place and eligibility to enter Japan as a student.', 2);
SET @jt3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt3s2, 'Offer / Admission Letter', 'From your Japanese institution.', 'original', 1, 0, 1, 1),
(@jt3s2, 'Certificate of Eligibility (COE)', 'Issued by Japan''s Regional Immigration Services Bureau via your institution — mandatory, and valid for only 3 months.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt3, 'Financial Documents', 'Evidence you can fund your studies.', 3);
SET @jt3s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt3s3, 'Proof of Funds', 'Roughly JPY 2,000,000/year (indicative) for living expenses, plus tuition.', 'copy', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt3, 'Academic Documents', 'Your academic background.', 4);
SET @jt3s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt3s4, 'Academic Transcripts & Certificates', NULL, 'copy', 1, 0, 0, 1),
(@jt3s4, 'Language Proficiency Proof', 'IELTS (~6.0) or JLPT (N2/N1 for Japanese-taught courses), as required by your course.', 'copy', 0, 1, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt3, 'Application Documents', 'Your formal application paperwork.', 5);
SET @jt3s5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt3s5, 'Completed Visa Application Form', NULL, 'original', 1, 0, 0, 1),
(@jt3s5, 'Visa Fee Payment Receipt', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt3, 'Final Verification', 'What happens after arrival.', 6);
SET @jt3s6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt3s6, 'Post-Arrival Residence Registration Instructions', 'Register your address and receive your Residence Card after arrival.', 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(72, 3, 500.00, 'INR', 'Consular Fee (India-Japan Treaty Rate)', 'Government fee only, under the India-Japan bilateral treaty rate; VFS Global''s service charge is additional.', '2026-06-01', NOW(), 'https://leverageedu.com/learn/japan-student-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I apply for my own Certificate of Eligibility?', 'No — your Japanese institution applies for the COE on your behalf; you cannot apply for the student visa without it, and you cannot obtain it independently.', 72, 3, 720, 1),
('How long is a Certificate of Eligibility valid?', 'Only 3 months from the date of issuance — you must apply for your visa and enter Japan within this window, so timing matters.', 72, 3, 721, 1),
('How much money do I need to show for a Japan student visa?', 'Roughly JPY 2,000,000 per year (indicative) for living expenses, on top of tuition — Indian students without scholarships commonly show INR 12-15 lakh in accessible funds for the first year.', 72, 3, 722, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Certificate of Eligibility (COE)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    72, 4, 'JPN-WORK-IN-04', '2026.09', 'published',
    'Employment in Japan under a confirmed job offer, via a Certificate of Eligibility (COE)-based work visa.',
    'Your Japanese employer must first obtain a Certificate of Eligibility (COE) from Japan''s immigration authorities and issue it to you along with the job offer — you cannot apply for a work visa without it.',
    'Tied to your specific work visa category, renewable',
    'Certificate of Eligibility (COE) obtained by your Japanese employer, then a visa application via VFS Global',
    0,
    'COE processing around 1-3 months, then visa issuance in a few working days once the COE is obtained (indicative)',
    'VFS Global Japan Visa Application Centre, India',
    'Secure a confirmed job offer from a Japan-based employer\nYour employer applies for your Certificate of Eligibility (COE) from the Regional Immigration Bureau\nGather documents against this checklist once the COE is issued\nApplication preparation\nSubmission via VFS Global\nCollect your passport from VFS once approved\nAfter arrival: register your address and receive your Residence Card',
    '/assets/images/visa-heroes/japan.jpg',
    'Independent employer-immigration guidance for Japan work visas (COE process) issued to Indian applicants', 'https://www.y-axis.com/blog/eligibility-requirements-for-a-japan-work-visa/', '2026-09-11'
);
SET @jpt4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@jpt4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt4, 'Core Documents', 'Every applicant needs these.', 1);
SET @jt4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt4s1, 'Valid Passport', 'Valid well beyond your intended employment period.', 'original', 1, 0, 1, 1),
(@jt4s1, 'Passport-Size Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt4, 'Employer Sponsorship Documents', 'Proof your Japanese employer has sponsored your application.', 2);
SET @jt4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt4s2, 'Certificate of Eligibility (COE)', 'Obtained by your employer from the Regional Immigration Bureau before you apply.', 'original', 1, 0, 1, 1),
(@jt4s2, 'Confirmed Job Offer', 'From your Japan-registered employer.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt4, 'Employment / Professional Documents', 'Your qualifications for the role.', 3);
SET @jt4s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt4s3, 'Educational Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@jt4s3, 'Employment History Documentation', 'Resume and past employer references.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt4, 'Additional Documents', 'Whatever else immigration requests.', 4);
SET @jt4s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt4s4, 'Additional Immigration-Requested Documents', 'Any further supporting documents requested during COE/visa assessment.', 'copy', 0, 1, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt4, 'Application Documents', 'Your formal application paperwork.', 5);
SET @jt4s5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt4s5, 'Completed Visa Application Form', NULL, 'original', 1, 0, 0, 1),
(@jt4s5, 'Visa Fee Payment Receipt', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt4, 'Final Verification', 'What happens after arrival.', 6);
SET @jt4s6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt4s6, 'Post-Arrival Residence Registration Instructions', 'Register your address and receive your Residence Card after arrival.', 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(72, 4, 500.00, 'INR', 'Consular Fee (India-Japan Treaty Rate)', 'Government fee only; VFS Global''s service charge is additional. Employer-side COE application has no separate government fee, but processing takes 1-3 months.', '2026-06-01', NOW(), 'https://www.y-axis.com/blog/eligibility-requirements-for-a-japan-work-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I apply for a Japan work visa without a job offer?', 'No — a confirmed job offer and your employer''s Certificate of Eligibility (COE), obtained from Japan''s Regional Immigration Bureau, are both required before you can apply.', 72, 4, 730, 1),
('How long does the COE process take for a work visa?', 'Commonly around 1-3 months for the employer to obtain the COE, followed by a few working days for the visa itself once it''s issued.', 72, 4, 731, 1),
('What happens after I arrive in Japan on a work visa?', 'You register your address and receive your Residence Card, which serves as your ongoing proof of status while the visa remains valid.', 72, 4, 732, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Short-Term Stay (Family/Friend)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    72, 5, 'JPN-FAM-IN-05', '2026.09', 'published',
    'Short visits to family members or friends residing in Japan.',
    'Your host in Japan (the "Guarantor and Invitee") must prepare an Invitation Letter using Japan''s official MOFA template and a Letter of Guarantee covering your expenses, return travel, and compliance with Japanese law.',
    'Up to 90 days, typically single entry unless a multiple-entry visa is later granted',
    'Via VFS Global Japan Visa Application Centre',
    0,
    '5-7 working days for a complete application (indicative)',
    'VFS Global Japan Visa Application Centre, India',
    'Ask your host in Japan to prepare the Invitation Letter (MOFA template) and Letter of Guarantee\nGather documents against this checklist, including proof of relationship\nApplication preparation\nSubmission via VFS Global\nSupport responding to any additional-information request\nCollect your passport from VFS once approved',
    '/assets/images/visa-heroes/japan.jpg',
    'Ministry of Foreign Affairs of Japan (MOFA) short-term stay visa checklist and independent visa-agency guidance', 'https://www.mofa.go.jp/files/000121327.pdf', '2026-09-11'
);
SET @jpt5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@jpt5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt5, 'Core Documents', 'Every applicant needs these.', 1);
SET @jt5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt5s1, 'Valid Passport', 'Machine-readable or e-passport, valid well beyond your travel dates.', 'original', 1, 0, 1, 1),
(@jt5s1, 'Passport-Size Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt5, 'Invitation & Host Documents', 'Evidence of who you are visiting.', 2);
SET @jt5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt5s2, 'Invitation Letter (MOFA Template)', 'Explaining the visit''s purpose, background, and your relationship with the host.', 'original', 1, 0, 1, 1),
(@jt5s2, 'Letter of Guarantee', 'From your host, covering your expenses, return travel, and compliance with Japanese law.', 'original', 1, 0, 1, 2),
(@jt5s2, 'Proof of Relationship', 'Marriage certificate, birth certificate, or family register (Koseki Tohon), as applicable.', 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt5, 'Financial & Travel Documents', 'Evidence you can support your trip.', 3);
SET @jt5s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt5s3, 'Bank Statement', 'Showing sufficient funds for your stay.', 'copy', 1, 0, 0, 1),
(@jt5s3, 'Confirmed Return Tickets', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt5, 'Application Documents', 'Your formal application paperwork.', 4);
SET @jt5s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt5s4, 'Completed Visa Application Form', NULL, 'original', 1, 0, 0, 1),
(@jt5s4, 'Visa Fee Payment Receipt', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(72, 5, 500.00, 'INR', 'Consular Fee (India-Japan Treaty Rate)', 'Government fee only, under the India-Japan bilateral treaty rate; VFS Global''s service charge is additional.', '2026-06-01', NOW(), 'https://www.mofa.go.jp/files/000121327.pdf', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is the MOFA Invitation Letter template?', 'Japan''s Ministry of Foreign Affairs provides an official template your host uses to explain the visit''s purpose, background, and your relationship — using this template is expected for a Short-Term Stay family visit application.', 72, 5, 740, 1),
('What is a Letter of Guarantee?', 'A document your host signs promising to cover your expenses in Japan, your return travel, and your compliance with Japanese law during the visit.', 72, 5, 741, 1),
('How much does a Japan family visit visa cost?', 'Indian citizens pay the same reduced treaty rate as other short-term categories — INR 500 for the government fee, whether single or multiple entry.', 72, 5, 742, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    72, 6, 'JPN-TRANS-IN-06', '2026.09', 'published',
    'Connecting through a Japanese airport en route to a third country.',
    'A same-day connection within the airport''s transit zone commonly needs no visa. A transit visa IS needed if your connection is on a different day, or if you must switch airports (e.g. between Narita and Haneda), reclaim baggage, or leave the sterile area during a long layover.',
    'Whether same-day and airside, or up to 15 days if a transit visa is issued',
    'Via VFS Global Japan Visa Application Centre, if a transit visa is actually needed',
    0,
    'At least 4 working days if a transit visa is needed (indicative)',
    'VFS Global Japan Visa Application Centre, India',
    'Confirm with us whether your specific connection needs a transit visa\nIf same-day and airside: no visa application needed, just your confirmed onward ticket\nIf not: gather documents against this checklist\nApplication preparation\nSubmission via VFS Global\nCollect your passport from VFS once approved',
    '/assets/images/visa-heroes/japan.jpg',
    'Independent visa-agency guidance for Japan transit visas issued to Indian passport holders', 'https://www.tataaig.com/travel-insurance/japan-transit-visa-for-indians', '2026-09-11'
);
SET @jpt6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@jpt6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt6, 'Core Documents', 'Needed regardless of whether a visa is required.', 1);
SET @jt6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt6s1, 'Valid Passport', 'Valid at least 6 months beyond your intended travel date.', 'original', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt6, 'Onward Journey Documents', 'Evidence of your connecting flight.', 2);
SET @jt6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt6s2, 'Confirmed Onward Flight Tickets', 'Same-day connection, ideally through the same airport.', 'copy', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt6, 'If a Transit Visa Is Needed', 'Only applies to different-day connections or airport changes.', 3);
SET @jt6s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt6s3, 'Completed Visa Application Form', NULL, 'original', 0, 1, 0, 1),
(@jt6s3, 'Visa Fee Payment Receipt', NULL, 'original', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(72, 6, 50.00, 'INR', 'Consular Fee (Treaty Rate)', 'A 15-day transit visa costs just INR 50 for Indian passport holders, if one is actually needed — most same-day, same-airport connections need no visa at all.', '2026-06-01', NOW(), 'https://www.tataaig.com/travel-insurance/japan-transit-visa-for-indians', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through a Japanese airport?', 'Not for a same-day connection within the transit zone. You would need one if your connection is on a different day, or if you must switch airports, reclaim baggage, or leave the sterile area.', 72, 6, 750, 1),
('How much does a Japan transit visa cost?', 'Just INR 50 for a 15-day transit visa for Indian passport holders — one of the lowest visa fees Japan offers, if you actually need one.', 72, 6, 751, 1),
('Is there a transit visa-on-arrival for Japan?', 'No — if your specific connection requires a transit visa, you must obtain it before travelling; there is no visa-on-arrival option.', 72, 6, 752, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Visa for Medical Stay
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    72, 7, 'JPN-MED-IN-07', '2026.09', 'published',
    'Medical treatment in Japan, including full medical check-ups, via the "Visa for Medical Stay" category.',
    'You need a Japanese medical institution that has agreed to accept you for treatment, and typically a registered guarantor (medical coordinator or travel agency) to coordinate documentation with the hospital.',
    '3-6 months typically, depending on the treatment schedule; a Certificate of Eligibility is needed for stays over 90 days',
    'Via VFS Global, coordinated with a registered guarantor organisation',
    0,
    '5-7 working days once documentation is complete (indicative) — start as early as your hospital appointment allows',
    'VFS Global Japan Visa Application Centre, India',
    'Confirm your Japanese hospital/clinic has agreed to accept you for treatment\nWork with a registered guarantor organisation to coordinate documents with the hospital\nGather documents against this checklist\nApplication preparation\nSubmission via VFS Global\nCollect your passport from VFS once approved',
    '/assets/images/visa-heroes/japan.jpg',
    'Ministry of Foreign Affairs of Japan, guidance on the Visa for Medical Stay', 'https://www.mofa.go.jp/j_info/visit/visa/medical_stay1.html', '2026-09-11'
);
SET @jpt7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@jpt7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt7, 'Core Documents', 'Every applicant needs these.', 1);
SET @jt7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt7s1, 'Valid Passport', 'For the patient and any accompanying attendant.', 'original', 1, 0, 1, 1),
(@jt7s1, 'Passport-Size Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt7, 'Medical Purpose Documents', 'Evidence of your treatment in Japan.', 2);
SET @jt7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt7s2, 'Letter of Invitation from Japanese Hospital', 'Confirming the patient will receive treatment there.', 'original', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt7, 'Financial Documents', 'Evidence you can fund treatment and stay.', 3);
SET @jt7s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt7s3, 'Proof of Financial Resources', 'Covering treatment, travel, and accommodation costs.', 'copy', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt7, 'Guarantor Coordination Documents', 'From the registered guarantor organisation.', 4);
SET @jt7s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt7s4, 'Guarantor Organisation Coordination Letter', 'Confirming the guarantor is coordinating your documents with the Japanese medical institution.', 'original', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt7, 'Application Documents', 'Your formal application paperwork.', 5);
SET @jt7s5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt7s5, 'Completed Visa Application Form', NULL, 'original', 1, 0, 0, 1),
(@jt7s5, 'Visa Fee Payment Receipt', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt7, 'Final Verification', 'For stays longer than 90 days.', 6);
SET @jt7s6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt7s6, 'Certificate of Eligibility', 'Required if your expected stay exceeds 90 days, obtained via a staff member of the medical institution or a family member in Japan.', 'original', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(72, 7, 500.00, 'INR', 'Consular Fee (India-Japan Treaty Rate)', 'Government fee only; VFS Global''s service charge is additional. Treatment costs are set by your Japanese hospital, not by us or the consulate.', '2026-06-01', NOW(), 'https://www.mofa.go.jp/j_info/visit/visa/medical_stay1.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Japan have a specific medical visa?', 'Yes — Japan operates a genuine "Visa for Medical Stay" category, but it requires a Japanese medical institution that has agreed to accept you and typically a registered guarantor to coordinate documents.', 72, 7, 760, 1),
('What is a guarantor organisation for medical visas?', 'A registered coordinator (a medical coordinator or travel agency) that liaises between you and the Japanese medical institution while preparing the necessary visa documents.', 72, 7, 761, 1),
('Do I need a Certificate of Eligibility for medical treatment?', 'Only if your expected stay in Japan exceeds 90 days — shorter treatment stays use the standard Visa for Medical Stay application instead.', 72, 7, 762, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Short-Term Business Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    72, 8, 'JPN-CONF-IN-08', '2026.09', 'published',
    'Attending a conference, seminar, or trade fair in Japan.',
    'Falls under the Short-Term Business Visa category, covering meetings, conferences, and trade events, for stays of up to 90 days.',
    'Up to 90 days, single or multiple entry depending on travel history',
    'Via VFS Global Japan Visa Application Centre',
    0,
    '5-7 working days, provided documentation is complete (indicative)',
    'VFS Global Japan Visa Application Centre, India',
    'Initial consultation once your conference registration is confirmed\nObtain a Letter of Invitation from the conference organiser confirming your registration\nGather documents against this checklist\nApplication preparation\nSubmission via VFS Global\nCollect your passport from VFS once approved',
    '/assets/images/visa-heroes/japan.jpg',
    'Independent visa-agency guidance and conference-organiser invitation-letter guidance for Japan short-term business visas issued to Indian applicants', 'https://www.atlanta.us.emb-japan.go.jp/itpr_en/visa-short-term.html', '2026-09-11'
);
SET @jpt8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@jpt8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt8, 'Core Documents', 'Every applicant needs these.', 1);
SET @jt8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt8s1, 'Valid Passport', 'Valid at least 6 months beyond planned departure.', 'original', 1, 0, 1, 1),
(@jt8s1, 'Passport-Size Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt8, 'Conference Documents', 'Evidence of the event you are attending.', 2);
SET @jt8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt8s2, 'Letter of Invitation from Conference Organiser', 'Confirming your registration and reason for attending.', 'original', 1, 0, 1, 1),
(@jt8s2, 'Cover Letter / Travel Order from Employer', 'Stating your designation and purpose of travel.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt8, 'Financial Documents', 'Evidence you can support your trip.', 3);
SET @jt8s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt8s3, 'Bank Statements', 'Last 6 months.', 'copy', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt8, 'Application Documents', 'Your formal application paperwork.', 4);
SET @jt8s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt8s4, 'Completed Visa Application Form', NULL, 'original', 1, 0, 0, 1),
(@jt8s4, 'Visa Fee Payment Receipt', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(72, 8, 500.00, 'INR', 'Consular Fee (India-Japan Treaty Rate)', 'Government fee only; VFS Global''s service charge is additional.', '2026-06-01', NOW(), 'https://www.atlanta.us.emb-japan.go.jp/itpr_en/visa-short-term.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Which visa category covers conferences in Japan?', 'The Short-Term Business Visa covers meetings, conferences, seminars, and trade fairs together — there is no separate "conference visa" sticker.', 72, 8, 770, 1),
('What does a Letter of Invitation from a conference need to confirm?', 'It should confirm your registration, payment status, and give you an official reason to travel to Japan for the event.', 72, 8, 771, 1),
('How much does attending a conference in Japan cost in visa fees?', 'The same reduced treaty rate as other short-term categories — INR 500 government fee, plus VFS Global''s separate service charge.', 72, 8, 772, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Amateur Athlete status or Short-Term
-- Business Visa (sport exchange). Japan has no single named "Sports
-- Visa" sticker the way France does — stated honestly.
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    72, 9, 'JPN-SPORT-IN-09', '2026.09', 'published',
    'Participating in a sporting event, tournament, or training programme in Japan.',
    'Japan has no single named "Sports Visa" sticker. Short sport-related trips are commonly covered by the Short-Term Business Visa (for cultural/sport exchange); genuine amateur athletes with a federation sponsor may instead qualify for the "Amateur Athlete" designated-activities status.',
    'Up to 90 days for short-term sport exchange; tied to the activity plan for Amateur Athlete status',
    'Via VFS Global — Short-Term Business Visa, or Amateur Athlete designated-activities status with a federation sponsor',
    0,
    '5-7 working days for the Short-Term Business Visa route (indicative); longer for Amateur Athlete status',
    'VFS Global Japan Visa Application Centre, India',
    'Confirm your event/federation invitation and whether Short-Term Business or Amateur Athlete status fits your situation\nGather documents against this checklist\nApplication preparation\nSubmission via VFS Global\nCollect your passport from VFS once approved',
    '/assets/images/visa-heroes/japan.jpg',
    'Independent immigration-guidance sourcing for Japan short-term sport-related visas issued to Indian applicants', 'https://japan-visa.com/visas/amateur-athlete', '2026-09-11'
);
SET @jpt9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@jpt9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt9, 'Core Documents', 'Every applicant needs these.', 1);
SET @jt9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt9s1, 'Valid Passport', 'Machine-readable or e-passport, with more than 2 blank pages.', 'original', 1, 0, 1, 1),
(@jt9s1, 'Passport-Size Photograph', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt9, 'Sporting Event Documents', 'Evidence of the event and your athletic background.', 2);
SET @jt9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt9s2, 'Federation/Event Invitation Letter', 'From your resident-country athletic association or the Japan-based host.', 'original', 1, 0, 1, 1),
(@jt9s2, 'Evidence of Athletic Background', 'Federation registration, competition results, or coaching letters — needed for Amateur Athlete status.', 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt9, 'Financial Documents', 'Evidence you can support your trip.', 3);
SET @jt9s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt9s3, 'Bank Statement', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt9, 'Application Documents', 'Your formal application paperwork.', 4);
SET @jt9s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt9s4, 'Completed Visa Application Form', NULL, 'original', 1, 0, 0, 1),
(@jt9s4, 'Visa Fee Payment Receipt', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(72, 9, 500.00, 'INR', 'Consular Fee (India-Japan Treaty Rate)', 'Government fee for the Short-Term Business Visa route; Amateur Athlete status processing may involve separate steps we confirm case by case.', '2026-06-01', NOW(), 'https://japan-visa.com/visas/amateur-athlete', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Japan have a dedicated sports visa?', 'Not a single named category — short sport-related trips commonly use the Short-Term Business Visa (sport exchange), while genuine amateur athletes with a federation sponsor may qualify for the separate "Amateur Athlete" designated-activities status instead.', 72, 9, 780, 1),
('What counts as an "Amateur Athlete" for this status?', 'A real athletic background matters — federation registration, competition results, or coaching letters — plus formal invitation and expense guarantee from a Japanese amateur sports organisation.', 72, 9, 781, 1),
('Which route should I use for a short tournament visit?', 'For a short visit to compete or train, the Short-Term Business Visa (sport exchange) is usually the simpler route — we help confirm which category actually fits your situation.', 72, 9, 782, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Family Dependent Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    72, 10, 'JPN-DEP-IN-10', '2026.09', 'published',
    'Joining a legally married spouse or financially dependent child of a foreign resident in Japan, via the Family Dependent Visa.',
    'The sponsor must hold an eligible work or student visa status (e.g. Engineer/Specialist in Humanities, Business Manager, Professor) and prove they can financially support their dependants — certain statuses (Technical Intern Training, Specified Skilled Worker (i), Temporary Visitor) cannot sponsor dependants at all.',
    'Up to 5 years initially, tied to the sponsor''s visa status and period of stay',
    'Certificate of Eligibility (COE) applied for at Japan''s Immigration Bureau, typically by the sponsor',
    0,
    '1-3 months for the Certificate of Eligibility (indicative)',
    'VFS Global Japan Visa Application Centre, India',
    'Confirm the sponsor''s visa status is eligible to sponsor dependants\nSponsor applies for the Certificate of Eligibility (COE) at the Immigration Bureau in Japan\nGather documents against this checklist once the COE is issued\nApplication preparation\nSubmission via VFS Global\nCollect your passport from VFS once approved\nAfter arrival: register your address and receive your Residence Card',
    '/assets/images/visa-heroes/japan.jpg',
    'Independent immigration-guidance sourcing for the Japan Family Dependent Visa issued to Indian applicants', 'https://cotoacademy.com/dependent-visa-japan-guide/', '2026-09-11'
);
SET @jpt10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@jpt10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt10, 'Core Documents', 'Every applicant needs these.', 1);
SET @jt10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt10s1, 'Valid Passport of the Dependant', 'Valid well beyond the intended stay.', 'original', 1, 0, 1, 1),
(@jt10s1, 'Passport-Size Photograph', 'Of the dependant.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt10, 'Family Relationship Documents', 'Proof of your relationship to the sponsor.', 2);
SET @jt10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt10s2, 'Marriage Certificate', 'For a spouse applicant, with certified Japanese translation.', 'original', 0, 1, 1, 1),
(@jt10s2, 'Birth Certificate', 'For a child applicant, with certified Japanese translation.', 'original', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt10, 'Sponsor''s Documents', 'Proof the sponsor can support the dependant.', 3);
SET @jt10s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt10s3, 'Sponsor''s Residence Card or Passport', NULL, 'copy', 1, 0, 0, 1),
(@jt10s3, 'Sponsor''s Employment & Income Evidence', 'Employer''s certificate, tax/payment certificates, bank statements, or pay slips.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt10, 'Application Documents', 'Your formal application paperwork.', 4);
SET @jt10s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt10s4, 'Certificate of Eligibility (COE)', 'Applied for at the Immigration Bureau in Japan, typically by the sponsor.', 'original', 1, 0, 0, 1),
(@jt10s4, 'Completed Visa Application Form', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@jpt10, 'Final Verification', 'What happens after submission and arrival.', 5);
SET @jt10s5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@jt10s5, 'Visa Fee Payment Receipt', NULL, 'original', 1, 0, 0, 1),
(@jt10s5, 'Post-Arrival Residence Registration Instructions', 'Register your address and receive your Residence Card after arrival.', 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(72, 10, 500.00, 'INR', 'Consular Fee (India-Japan Treaty Rate)', 'Government fee only; VFS Global''s service charge is additional. The Certificate of Eligibility process itself has no separate government fee.', '2026-06-01', NOW(), 'https://cotoacademy.com/dependent-visa-japan-guide/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can any work-visa holder sponsor a dependant in Japan?', 'No — only certain visa statuses (e.g. Engineer/Specialist in Humanities, Business Manager, Professor, Researcher) can sponsor dependants; Technical Intern Training, Specified Skilled Worker (i), and Temporary Visitor statuses cannot.', 72, 10, 790, 1),
('Who applies for the Certificate of Eligibility for a dependant?', 'Typically the sponsor in Japan applies at the Immigration Bureau, not the dependant applicant in India.', 72, 10, 791, 1),
('How long can a Family Dependent Visa last?', 'Up to 5 years initially, though the actual period granted depends on the sponsor''s own visa status and period of stay.', 72, 10, 792, 1);
