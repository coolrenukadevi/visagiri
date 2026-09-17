-- Fiji Visa Checklist Engine content for all 10 visa types — built
-- this session via web search (WebFetch to immigration.gov.fj itself
-- was blocked by network egress; all findings below are triangulated
-- across secondary sources — Wikipedia's "Visa policy of Fiji" /
-- "Visa requirements for Indian citizens", visa-agency pages such as
-- Terratern/DesiNRI/VinaVisas/Atlys, Tourism Fiji, and rivermate/
-- playroll/G-P employer-of-record guides — since the official
-- immigration.gov.fj pages could not be fetched directly this
-- session). Fee figures in particular vary across secondary sources
-- and are flagged as approximate throughout; confirm before relying
-- on them operationally.
--
-- Fiji's real, distinctive facts (independently corroborated across
-- multiple sources this session):
--   - Indian passport holders are VISA-EXEMPT for Fiji for tourism,
--     family visits, and short business trips — a free Visitors
--     Permit is issued on arrival, valid for up to 4 months (120
--     days), extendable by a further 2 months (to a 6-month ceiling)
--     via the Fiji Immigration Department before the initial permit
--     expires. This is the single most distinctive fact for this
--     country and shapes the Tourist, Family Visit, and (to a lesser
--     extent) Transit categories.
--   - Business travel is NOT simply folded into the general Visitors
--     Permit: Fiji issues a separate, shorter "Business Visitors
--     Permit" (commonly cited at 14 days for most visa-exempt
--     nationalities, longer for a short list of countries), requiring
--     an approval/invitation letter from the Fiji host business and a
--     "Business" purpose declaration on arrival — a genuine structural
--     difference from Tourist that is reflected below.
--   - The Student Permit is the one category where India is treated
--     differently from the general visa-exempt rule: non-regional
--     students (a group that includes Indian nationals) must have
--     their Student Permit APPROVED BEFORE arrival — unlike Tourist/
--     Family Visit, which are genuinely visa-free at the border.
--   - Fiji's Work Permit route is strictly employer-initiated — an
--     Indian applicant cannot self-file; the sponsoring Fijian
--     employer must first demonstrate local recruitment effort and
--     file on the applicant's behalf. Secondary sourcing also
--     reports tightened 2025 compliance under the Immigration Act
--     2003, which is noted as a dated, flagged-approximate policy
--     signal rather than a verified statute citation.
--   - Fiji does not appear (per this session's sourcing) to maintain
--     separately named "Conference Visa" or "Sports Visa" categories
--     the way Schengen states do — these purposes are handled under
--     the general Visitors Permit or Business Visitors Permit
--     framework depending on duration and purpose declared. This is
--     itself a genuine finding (not a research gap) and is reflected
--     in how those two categories are framed below; flagged in each
--     section as NOT a dedicated, separately named permit type.
--   - There is no dedicated "Medical Visa" either: short medical
--     trips fall under the general Visitors Permit, while a longer
--     stay for treatment requires a distinct "Residence Special
--     Purpose Permit on Medical Grounds" application to the Director
--     of Immigration, on a certified medical practitioner's
--     recommendation — a genuinely distinct instrument from a
--     Schengen-style medical visa.
--   - Fiji has a large, historically rooted Indo-Fijian community —
--     Indo-Fijians made up roughly 32.7% of Fiji's population per
--     2017-era figures (around 460,000 people), almost entirely
--     descended from Indian indentured labourers brought to Fiji in
--     the late 19th/early 20th century. This is genuinely relevant
--     context for Family Visit and Dependent applicants, though it
--     should be stated carefully: most Indo-Fijians are many
--     generations removed from India, many families report having
--     lost direct personal contact with relatives in India, and a
--     significant share of the Indo-Fijian community has itself
--     emigrated onward to Australia, New Zealand, the US, and Canada.
--     The more concrete, present-day driver of Indian nationals
--     visiting family in Fiji is typically the smaller population of
--     first/second-generation Indian expatriates (professionals,
--     business owners, and their spouses/dependents) now resident in
--     Fiji on work or business permits, plus their extended families
--     visiting under the standard visa-exempt Visitors Permit.
--   - Dependent Permits are sponsored by the principal permit holder
--     (spouse/partner and dependent children, commonly cited under
--     18-21) and run for the same duration as the principal's permit,
--     but work rights for a dependent are NOT automatic and generally
--     require their own separate application — distinct from
--     countries where a dependent permit carries automatic work
--     rights.
--
-- country_id 182 = Fiji, slug 'fiji'. visa_type_id: 1=Tourist,
-- 2=Business, 3=Student, 4=Work, 5=Family Visit, 6=Transit,
-- 7=Medical, 8=Conference, 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Visa-Exempt Visitors Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    182, 1, 'FJI-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Fiji.',
    'Indian passport holders are visa-exempt for tourism — a free Visitors Permit is issued on arrival, no prior visa application needed. Onward travel proof and sufficient funds may be checked at the immigration counter.',
    'Up to 4 months (120 days) on arrival; extendable by 2 more months to a 6-month ceiling',
    'Visa-exempt entry; Visitors Permit issued free on arrival at any Fiji port of entry',
    0,
    'No advance processing needed for entry; an in-country extension (if required) is reported to take a few working days',
    'No visa application needed; Fiji High Commission, New Delhi available for related consular queries',
    'Confirm your passport has 6+ months'' validity and 2+ blank pages\nBook return/onward travel and accommodation\nArrive in Fiji and receive the free Visitors Permit at immigration\nIf staying longer, apply for a 2-month extension at the Fiji Immigration Department before the initial permit expires',
    '/assets/images/visa-heroes/fiji.webp',
    'Cross-checked across Wikipedia (Visa policy of Fiji / Visa requirements for Indian citizens), Tourism Fiji, and visa-agency secondary sourcing (immigration.gov.fj itself was not directly fetchable this session)', 'https://www.immigration.gov.fj/fiji-visas/', '2026-09-17'
);
SET @fji1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fji1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fji1, 'Core Documents', 'Required from every visa-exempt visitor.', 1);
SET @fji1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fji1s1, 'Valid Passport (6+ Months Beyond Departure)', 'Must have at least 2 blank pages.', 'original', 1, 0, 1, 1),
(@fji1s1, 'Confirmed Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fji1, 'Supporting Documents', 'May be requested at the immigration counter on arrival.', 2);
SET @fji1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fji1s2, 'Proof of Sufficient Funds', NULL, 'copy', 0, 1, 0, 1),
(@fji1s2, 'Confirmed Accommodation Booking', NULL, 'copy', 0, 1, 0, 2),
(@fji1s2, 'Travel Insurance', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(182, 1, 0.00, 'FJD', 'Visitors Permit — Free on Arrival', 'No entry visa fee for visa-exempt Indian nationals; a reported ~FJD 95.10 extension fee applies only if extending beyond the initial 4-month permit — treat as approximate.', '2026-09-01', NOW(), 'https://www.immigration.gov.fj/visitors-permit/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit Fiji?', 'No — Indian passport holders are visa-exempt for tourism and receive a free Visitors Permit on arrival, typically valid for up to 4 months (120 days).', 182, 1, 18200, 1),
('Can I extend my stay in Fiji beyond 4 months?', 'Yes — a further 2-month extension can be applied for at the Fiji Immigration Department before your initial permit expires, taking the maximum stay to around 6 months. Confirm the current extension fee before applying.', 182, 1, 18201, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Business Visitors Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    182, 2, 'FJI-BUS-IN-02', '2026.09', 'published',
    'Short business trips, meetings, market research, and consultancy in Fiji.',
    'Indian nationals travelling for business are visa-exempt but receive a distinct, shorter Business Visitors Permit (commonly cited at 14 days) rather than the 4-month Tourist Visitors Permit, and must carry an approval/invitation letter from the Fiji host business.',
    'Commonly cited at 14 days on arrival (longer for a short list of other nationalities)',
    'Visa-exempt entry; Business Visitors Permit issued on arrival after declaring "Business" purpose',
    0,
    'No advance processing for entry; the host business''s approval letter should be arranged ahead of travel',
    'No visa application needed; Fiji High Commission, New Delhi available for related consular queries',
    'Obtain an approval/invitation letter from the Fiji host business or organisation\nBook return/onward travel\nDeclare "Business" purpose on arrival and present the approval letter\nReceive the Business Visitors Permit at immigration',
    '/assets/images/visa-heroes/fiji.webp',
    'Cross-checked against Fiji Ministry of Immigration "Business Visitors Permit" secondary sourcing and employer-of-record guides (rivermate/G-P/playroll); immigration.gov.fj not directly fetchable this session', 'https://www.immigration.gov.fj/business-visitors-permit/', '2026-09-17'
);
SET @fji2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fji2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fji2, 'Core Documents', 'Required from every business visitor.', 1);
SET @fji2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fji2s1, 'Valid Passport (6+ Months Beyond Departure)', NULL, 'original', 1, 0, 1, 1),
(@fji2s1, 'Approval/Invitation Letter from Fiji Host Business', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fji2, 'Supporting Documents', 'Evidence of your own employment and travel plans.', 2);
SET @fji2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fji2s2, 'Forwarding Letter from Indian Employer', NULL, 'copy', 0, 1, 0, 1),
(@fji2s2, 'Confirmed Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(182, 2, 0.00, 'FJD', 'Business Visitors Permit — Free on Arrival', 'No entry visa fee reported for visa-exempt nationals; confirm current duration and any fee if your business trip needs to exceed the standard short-stay window.', '2026-09-01', NOW(), 'https://www.immigration.gov.fj/business-visitors-permit/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Fiji''s Business Visitors Permit the same as the Tourist permit?', 'No — it is a genuinely separate, shorter permit (commonly cited at 14 days) that requires an approval/invitation letter from your Fiji host business and a "Business" purpose declaration on arrival, unlike the 4-month Tourist Visitors Permit.', 182, 2, 18202, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Student Permit (Pre-Arrival Approval)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    182, 3, 'FJI-STU-IN-03', '2026.09', 'published',
    'Enrolling in a Fiji institution such as the University of the South Pacific (USP).',
    'Indian students fall under Fiji''s "non-regional student" category — unlike Tourist/Family Visit, the Student Permit must be approved BEFORE arrival, applied for through the institution (e.g. USP''s Student Administrative Services).',
    'Tied to course duration; permit renewed/extended for multi-year programs',
    'Apply through your Fiji institution before travel; the institution typically assists with the Immigration Department submission',
    0,
    'Reported around 10-21 days once a complete application is submitted, ahead of travel',
    'No visa application at Fiji High Commission, New Delhi; the Fiji institution and Fiji Immigration Department handle the Student Permit directly',
    'Secure admission at a recognized Fiji institution\nGather proof of funds, admission letter, and academic records\nApply for the Student Permit through the institution before travel (mandatory pre-arrival approval for non-regional/Indian students)\nPay the permit fee (institution-administered + Immigration Department portions)\nTravel only once the Student Permit is approved',
    '/assets/images/visa-heroes/fiji.webp',
    'Cross-checked against USP Student Administrative Services "Study Permits" page description and Fiji Ministry of Immigration "Student Permit" secondary sourcing; immigration.gov.fj not directly fetchable this session', 'https://www.usp.ac.fj/sas/student-administrative-services-2/admissions-enrolment/study-permits/', '2026-09-17'
);
SET @fji3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fji3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fji3, 'Core Documents', 'Required from every applicant.', 1);
SET @fji3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fji3s1, 'Valid Passport (6+ Months Beyond Departure)', NULL, 'original', 1, 0, 1, 1),
(@fji3s1, 'Admission/Offer Letter from Fiji Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fji3, 'Supporting Documents', 'Evidence of your academic background, funds, and health.', 2);
SET @fji3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fji3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@fji3s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2),
(@fji3s2, 'Medical Report', NULL, 'original', 0, 1, 0, 3),
(@fji3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(182, 3, 521.00, 'FJD', 'Student Permit Fee (Approximate, USP Route)', 'Reported for the USP route as roughly FJD 521 total (about FJD 200 payable to the institution for administrative assistance + FJD 321 to Fiji Immigration); other institutions may differ — confirm with your specific institution.', '2026-09-01', NOW(), 'https://www.usp.ac.fj/sas/student-administrative-services-2/admissions-enrolment/study-permits/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I travel to Fiji first and apply for a Student Permit after arrival?', 'No — this is the key difference from Fiji''s visa-exempt Tourist route. Indian students fall under the "non-regional student" category and must have the Student Permit approved BEFORE arrival.', 182, 3, 18203, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Employer-Sponsored Work Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    182, 4, 'FJI-WORK-IN-04', '2026.09', 'published',
    'Employment with a Fiji-registered employer under a Short-term, Long-term, or Secondment work permit.',
    'Indian nationals with a confirmed job offer; the process is strictly employer-initiated — the applicant cannot self-file. The Fiji employer must show evidence of attempted local recruitment and file the permit application on the applicant''s behalf.',
    'Varies by permit type (Short-term, Long-term, Secondment); tied to the employment contract',
    'Employer-driven application to Fiji Immigration; applicant cannot apply independently',
    0,
    'Reported at 4-6 weeks standard processing',
    'No visa application at Fiji High Commission, New Delhi; the Fiji employer files directly with the Fiji Immigration Department',
    'Secure a job offer from a Fiji-registered employer\nEmployer demonstrates local recruitment effort and prepares job description, salary range, and company documents (business registration, tax compliance)\nEmployer files the Work Permit application with supporting employee documents\nEmployee provides passport, CV, qualification copies, reference letters, police clearance, and medical reports as requested\nAwait approval (reported 4-6 weeks) before travel',
    '/assets/images/visa-heroes/fiji.webp',
    'Cross-checked against employer-of-record guides (rivermate, playroll, Globalization Partners) and visa-agency sourcing (Terratern); immigration.gov.fj not fetchable this session — reported 2025 Immigration Act 2003 tightening not independently verified', 'https://www.immigration.gov.fj/work-in-fiji/', '2026-09-17'
);
SET @fji4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fji4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fji4, 'Core Documents', 'Required from every applicant (employer-filed).', 1);
SET @fji4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fji4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@fji4s1, 'Employment Contract', NULL, 'copy', 1, 0, 1, 2),
(@fji4s1, 'Evidence of Local Recruitment Effort', 'Prepared and filed by the Fiji employer.', 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fji4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @fji4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fji4s2, 'Academic/Professional Qualification Copies', NULL, 'copy', 1, 0, 0, 1),
(@fji4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2),
(@fji4s2, 'Medical Report', NULL, 'original', 1, 0, 0, 3),
(@fji4s2, 'Reference Letters', NULL, 'copy', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(182, 4, NULL, 'FJD', 'Confirmed After Assessment', 'Work Permit fees are reported to vary by permit type (Short-term/Long-term/Secondment) and are largely employer-borne — figures were not consistently reported across sources this session, contact us to confirm.', '2026-09-01', NOW(), 'https://www.immigration.gov.fj/work-permit-application-for-overseas-employers-secondments/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I apply for a Fiji work permit myself without an employer?', 'No — the process is strictly employer-initiated. A Fiji-registered employer must first offer you the job, demonstrate local recruitment effort, and file the Work Permit application on your behalf; applicants cannot self-file.', 182, 4, 18204, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Visa-Exempt Visitors Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    182, 5, 'FJI-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives or friends resident in Fiji.',
    'Indian nationals visiting family are visa-exempt under the same free Visitors Permit as Tourist. Relevant context: Fiji has a large, historically rooted Indo-Fijian community (~32.7% of the population per 2017-era figures) as well as a smaller, present-day population of Indian expatriate professionals and business owners resident in Fiji, whose relatives commonly travel to visit them under this route.',
    'Up to 4 months (120 days) on arrival; extendable by 2 more months to a 6-month ceiling',
    'Visa-exempt entry; Visitors Permit issued free on arrival at any Fiji port of entry',
    0,
    'No advance processing needed for entry',
    'No visa application needed; Fiji High Commission, New Delhi available for related consular queries',
    'Confirm your passport has 6+ months'' validity and 2+ blank pages\nBook return/onward travel\nOptionally carry an invitation letter and proof of relationship from your host in Fiji (not required for entry, but useful if questioned)\nArrive in Fiji and receive the free Visitors Permit at immigration\nApply for a 2-month extension at the Fiji Immigration Department if staying longer',
    '/assets/images/visa-heroes/fiji.webp',
    'Cross-checked against Wikipedia (Visa policy of Fiji), and Indo-Fijian population/diaspora context cross-checked against Wikipedia "Indo-Fijians"; immigration.gov.fj not directly fetchable this session', 'https://www.immigration.gov.fj/fiji-visas/', '2026-09-17'
);
SET @fji5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fji5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fji5, 'Core Documents', 'Required from every visa-exempt visitor.', 1);
SET @fji5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fji5s1, 'Valid Passport (6+ Months Beyond Departure)', NULL, 'original', 1, 0, 1, 1),
(@fji5s1, 'Confirmed Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fji5, 'Supporting Documents', 'Not required for entry, but useful to carry.', 2);
SET @fji5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fji5s2, 'Invitation Letter from Host in Fiji', NULL, 'copy', 0, 1, 0, 1),
(@fji5s2, 'Proof of Relationship', NULL, 'copy', 0, 1, 0, 2),
(@fji5s2, 'Proof of Sufficient Funds', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(182, 5, 0.00, 'FJD', 'Visitors Permit — Free on Arrival', 'Same fee-free entry as Tourist; a reported ~FJD 95.10 extension fee applies only if extending beyond the initial 4-month permit.', '2026-09-01', NOW(), 'https://www.immigration.gov.fj/visitors-permit/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Family Visit visa for Fiji, or is it the same as Tourist?', 'Indian nationals visiting family use the same visa-exempt Visitors Permit as Tourist entry — there is no separate application process, though carrying an invitation letter and relationship proof can help at immigration.', 182, 5, 18205, 1),
('Why do so many Indian nationals visit family in Fiji?', 'Fiji has a large, historically rooted Indo-Fijian community (roughly a third of the population), mostly descended from 19th/20th-century Indian indentured labourers, alongside a smaller present-day population of Indian expatriate professionals and business owners now resident in Fiji.', 182, 5, 18206, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Visa-Exempt / Airport Transit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    182, 6, 'FJI-TRAN-IN-06', '2026.09', 'published',
    'Passing through Nadi International Airport en route to another destination.',
    'Indian nationals are visa-exempt and generally do NOT need a separate transit visa for connections within 72 hours with a valid onward ticket. Layovers under 10 hours can typically remain in the airport transit lounge without clearing immigration; longer layovers or leaving the airport require clearing immigration under the standard Visitors Permit.',
    'Up to 72 hours for a connecting itinerary; under 10 hours can stay airside without immigration clearance',
    'Visa-exempt; no prior application needed for most transiting Indian passport holders with a valid onward ticket',
    0,
    'No advance processing for entry; onward ticket and next-destination visa (if required) should be confirmed before travel',
    'No visa application needed; Fiji High Commission, New Delhi available for related consular queries',
    'Confirm your onward ticket is within 72 hours and you meet your next destination''s entry requirements\nIf your layover is under 10 hours, remain in the Nadi Airport Transit Lounge (no immigration clearance needed)\nIf your layover exceeds 10 hours or you wish to leave the airport, clear immigration and receive a standard Visitors Permit',
    '/assets/images/visa-heroes/fiji.webp',
    'Cross-checked against Tourism Fiji "Transiting Fiji" guidance and Airports Fiji Limited (Nadi Immigration) secondary sourcing; immigration.gov.fj not directly fetchable this session', 'https://www.fiji.travel/fiji-guide/things-to-know/transitting-fiji', '2026-09-17'
);
SET @fji6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fji6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fji6, 'Core Documents', 'Required for every transiting passenger.', 1);
SET @fji6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fji6s1, 'Valid Passport (6+ Months Beyond Departure)', NULL, 'original', 1, 0, 1, 1),
(@fji6s1, 'Onward Flight Ticket (Within 72 Hours)', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fji6, 'Supporting Documents', 'Only relevant if leaving the airport or your layover exceeds 10 hours.', 2);
SET @fji6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fji6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(182, 6, 0.00, 'FJD', 'No Fee for Standard Transit', 'No separate transit visa fee reported for visa-exempt Indian nationals connecting within 72 hours; a standard Visitors Permit (free) applies only if you choose to clear immigration.', '2026-09-01', NOW(), 'https://www.fiji.travel/fiji-guide/things-to-know/transitting-fiji', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a transit visa to connect through Nadi Airport from India?', 'Generally no — Indian nationals are visa-exempt, and connections within 72 hours with a valid onward ticket don''t require a separate transit visa. Layovers under 10 hours can typically stay in the transit lounge without clearing immigration at all.', 182, 6, 18207, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Visitors Permit / Special Purpose Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    182, 7, 'FJI-MED-IN-07', '2026.09', 'published',
    'Travel to Fiji for medical treatment.',
    'Fiji does not issue a dedicated "medical visa" — short medical trips fall under the standard visa-exempt Visitors Permit (up to 4 months). A longer stay for ongoing treatment instead requires a distinct Residence Special Purpose Permit on Medical Grounds, filed with the Director of Immigration on a certified medical practitioner''s recommendation.',
    'Up to 4 months under the Visitors Permit; longer treatment requires the separate Special Purpose Permit',
    'Short trips: visa-exempt Visitors Permit on arrival. Longer treatment: Special Purpose Permit application to the Director of Immigration',
    0,
    'No advance processing for a short-stay Visitors Permit; the Special Purpose Permit route timeline was not consistently reported this session',
    'No visa application at Fiji High Commission, New Delhi for short trips; Special Purpose Permit applications go directly to the Fiji Immigration Department',
    'Confirm whether your treatment fits within a standard 4-month Visitors Permit or requires longer residence\nFor a short trip: travel visa-exempt and receive the free Visitors Permit on arrival\nFor longer treatment: obtain a certified medical practitioner''s recommendation and file a Residence Special Purpose Permit on Medical Grounds with the Director of Immigration\nArrange comprehensive health/travel insurance given Fiji''s limited private hospital capacity',
    '/assets/images/visa-heroes/fiji.webp',
    'Cross-checked against Fiji Ministry of Immigration "Residence Special Purpose Permit on Medical Grounds" secondary sourcing and expat healthcare guides; immigration.gov.fj not directly fetchable this session', 'https://www.immigration.gov.fj/residence-special-purpose-permit-on-medical-grounds-application/', '2026-09-17'
);
SET @fji7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fji7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fji7, 'Core Documents', 'Required for a short-stay medical trip (Visitors Permit).', 1);
SET @fji7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fji7s1, 'Valid Passport (6+ Months Beyond Departure)', NULL, 'original', 1, 0, 1, 1),
(@fji7s1, 'Confirmed Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fji7, 'Supporting Documents — Longer Treatment (Special Purpose Permit)', 'Required only if your treatment needs longer residence than the standard Visitors Permit allows.', 2);
SET @fji7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fji7s2, 'Certified Medical Practitioner''s Recommendation', NULL, 'original', 0, 1, 0, 1),
(@fji7s2, 'Medical Records/Referral', NULL, 'copy', 0, 1, 0, 2),
(@fji7s2, 'Proof of Funds for Treatment', NULL, 'copy', 0, 1, 0, 3),
(@fji7s2, 'Health/Travel Insurance', NULL, 'copy', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(182, 7, NULL, 'FJD', 'Confirmed After Assessment', 'A short medical trip is free under the standard Visitors Permit; the Residence Special Purpose Permit on Medical Grounds fee was not consistently reported this session — contact us to confirm.', '2026-09-01', NOW(), 'https://www.immigration.gov.fj/residence-special-purpose-permit-on-medical-grounds-application/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Fiji medical visa?', 'No — Fiji does not issue entry visas specifically for treatment purposes. Short medical trips use the standard visa-exempt Visitors Permit, while longer treatment requires a separate Residence Special Purpose Permit on Medical Grounds.', 182, 7, 18208, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Visitors Permit / Business Visitors Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    182, 8, 'FJI-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, congresses, and trade events in Fiji.',
    'Fiji does not appear to maintain a separately named "Conference Visa" — conference attendance by visa-exempt Indian nationals is handled under the general Visitors Permit (short stays) or the Business Visitors Permit (if declared as business-purpose), depending on duration and purpose stated on arrival.',
    'Up to 4 months under the Visitors Permit, or the shorter Business Visitors Permit window if declared as business',
    'Visa-exempt entry; Visitors Permit or Business Visitors Permit issued on arrival depending on declared purpose',
    0,
    'No advance processing needed for entry',
    'No visa application needed; Fiji High Commission, New Delhi available for related consular queries',
    'Obtain a conference invitation or registration confirmation from the organiser\nDecide whether to declare "Tourism" or "Business" purpose on arrival based on the nature of your trip\nBook return/onward travel and accommodation\nArrive in Fiji and receive the applicable permit at immigration',
    '/assets/images/visa-heroes/fiji.webp',
    'No dedicated Conference Visa category found for Fiji this session — only Visitors/Business Visitors Permit categories appear in secondary sourcing; immigration.gov.fj not directly fetchable this session', 'https://www.immigration.gov.fj/fiji-visas/', '2026-09-17'
);
SET @fji8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fji8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fji8, 'Core Documents', 'Required from every visa-exempt visitor.', 1);
SET @fji8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fji8s1, 'Valid Passport (6+ Months Beyond Departure)', NULL, 'original', 1, 0, 1, 1),
(@fji8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fji8, 'Supporting Documents', 'Additional evidence, especially if declaring "Business" purpose.', 2);
SET @fji8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fji8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@fji8s2, 'Confirmed Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(182, 8, 0.00, 'FJD', 'No Separate Conference Visa Fee', 'Conference attendance is covered by the free Visitors Permit or Business Visitors Permit depending on declared purpose — no dedicated fee category found.', '2026-09-01', NOW(), 'https://www.immigration.gov.fj/fiji-visas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Fiji have a dedicated Conference Visa?', 'Not as a separately named category, as far as this session''s research found — conference attendance is handled under the general Visitors Permit or the Business Visitors Permit, depending on the purpose you declare on arrival.', 182, 8, 18209, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Visitors Permit / Business Visitors Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    182, 9, 'FJI-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in Fiji.',
    'Fiji does not appear to maintain a separately named "Sports Visa" — like Conference, sporting participation by visa-exempt Indian nationals is handled under the general Visitors Permit or Business Visitors Permit, depending on duration and purpose declared on arrival.',
    'Up to 4 months under the Visitors Permit, or the shorter Business Visitors Permit window if declared as business',
    'Visa-exempt entry; Visitors Permit or Business Visitors Permit issued on arrival depending on declared purpose',
    0,
    'No advance processing needed for entry',
    'No visa application needed; Fiji High Commission, New Delhi available for related consular queries',
    'Obtain an invitation/confirmation letter from the host event organiser or sporting federation\nDecide whether to declare "Tourism" or "Business" purpose on arrival based on the nature of your participation\nBook return/onward travel\nArrive in Fiji and receive the applicable permit at immigration',
    '/assets/images/visa-heroes/fiji.webp',
    'No dedicated Sports Visa category found for Fiji this session — only Visitors/Business Visitors Permit categories appear in secondary sourcing; immigration.gov.fj not directly fetchable this session', 'https://www.immigration.gov.fj/fiji-visas/', '2026-09-17'
);
SET @fji9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fji9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fji9, 'Core Documents', 'Required from every visa-exempt visitor.', 1);
SET @fji9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fji9s1, 'Valid Passport (6+ Months Beyond Departure)', NULL, 'original', 1, 0, 1, 1),
(@fji9s1, 'Event Organiser/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fji9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @fji9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fji9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1),
(@fji9s2, 'Confirmed Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(182, 9, 0.00, 'FJD', 'No Separate Sports Visa Fee', 'Sporting participation is covered by the free Visitors Permit or Business Visitors Permit depending on declared purpose — no dedicated fee category found.', '2026-09-01', NOW(), 'https://www.immigration.gov.fj/fiji-visas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Fiji have a dedicated Sports Visa for athletes?', 'Not as a separately named category, as far as this session''s research found — sporting participation is handled under the general Visitors Permit or the Business Visitors Permit, depending on the purpose you declare on arrival.', 182, 9, 18210, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Dependent Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    182, 10, 'FJI-DEP-IN-10', '2026.09', 'published',
    'Spouse/partner and dependent children joining an Indian work or long-term permit holder in Fiji.',
    'Family members of an Indian national holding a qualifying Fiji Work Permit or other long-term permit. Sponsored by the principal permit holder; commonly cited as covering spouses/de facto partners and dependent children (often cited under 18-21). Work rights for dependents are NOT automatic and generally need their own separate application.',
    'Same duration as the principal permit holder''s Work/Residence Permit',
    'Sponsored application by the principal permit holder to the Fiji Immigration Department',
    0,
    'Tied to the principal permit''s own processing timeline; not independently reported this session',
    'No visa application at Fiji High Commission, New Delhi; the Fiji-based principal permit holder sponsors the application directly with Fiji Immigration',
    'Confirm the sponsor holds a qualifying Work Permit or other long-term permit\nGather relationship proof (marriage/birth certificates) and the sponsor''s permit copy\nSubmit the Dependent Permit application, sponsored by the principal permit holder\nEach dependent provides their own passport, medical report, and (for spouses) police clearance certificate\nIf work rights are needed, file a separate application — they are not automatic under the Dependent Permit', '/assets/images/visa-heroes/fiji.webp',
    'Cross-checked against Fiji Ministry of Immigration "Live in Fiji" dependent-permit sourcing and employer-of-record guides; diaspora context checked against Wikipedia "Indo-Fijians"; immigration.gov.fj not directly fetchable this session', 'https://www.immigration.gov.fj/live-in-fiji/', '2026-09-17'
);
SET @fji10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@fji10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fji10, 'Core Documents', 'Required from every applicant.', 1);
SET @fji10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fji10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@fji10s1, 'Proof of Relationship to Sponsor', 'Marriage or birth certificate.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@fji10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit and per-dependent checks.', 2);
SET @fji10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@fji10s2, 'Sponsor''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@fji10s2, 'Medical Report (Per Dependent)', NULL, 'original', 1, 0, 0, 2),
(@fji10s2, 'Police Clearance Certificate (Spouse/Partner)', NULL, 'original', 0, 1, 0, 3),
(@fji10s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(182, 10, 189.15, 'FJD', 'Dependent Permit Issue Fee (Per Dependent, Approximate)', 'Reported at roughly FJD 189.15 per dependent by secondary sourcing — not independently confirmed against the official Fiji Immigration fee schedule this session; confirm before relying on it.', '2026-09-01', NOW(), 'https://www.immigration.gov.fj/live-in-fiji/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse work in Fiji on a Dependent Permit?', 'Not automatically — work rights for dependents generally require their own separate application and are not granted automatically alongside the Dependent Permit itself.', 182, 10, 18211, 1),
('How long does a Dependent Permit last?', 'It is generally tied to the same duration as the principal permit holder''s Work or Residence Permit, and subject to similar health and character checks for each dependent.', 182, 10, 18212, 1);
