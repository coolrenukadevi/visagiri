-- Denmark Visa Checklist Engine content for all 10 visa types —
-- built fresh this session via web search. hero_image_url points to the
-- existing /assets/images/visa-heroes/denmark.webp bundle.
--
-- IMPORTANT SOURCING CAVEAT: Denmark's own official domains — nyidanmark.dk
-- (SIRI / Danish Immigration Service) and indien.um.dk (Ministry of
-- Foreign Affairs, India mission) — returned EGRESS_BLOCKED when fetched
-- directly this session. All findings below are triangulated across
-- multiple independent secondary sources (VFS Global one-pagers, Schengen
-- visa aggregator sites, immigration-law firm blogs, and study-abroad
-- consultancy pages) that themselves cite the official pages. Fee and
-- threshold figures for 2026 are cross-corroborated across 2+ sources
-- each, but should still be reconfirmed against nyidanmark.dk/um.dk
-- before an applicant relies on them, since SIRI revises pay limits and
-- fees on a rolling annual/biannual basis.
--
-- Denmark's real, distinctive facts verified this session:
--   - Denmark runs THREE separate, genuinely different skilled-work
--     routes rather than one generic "work visa": the Positive Lists
--     (Positivlisten — a Higher Education list of ~190 shortage job
--     titles and a Skilled Work list of ~65 trade occupations, updated
--     TWICE yearly), the Pay Limit Scheme (a minimum-salary route, set
--     at DKK 552,000/year for 2026) plus a Supplementary Pay Limit
--     Scheme (DKK 446,000/year for 2026), and the Fast-Track Scheme for
--     SIRI-certified employers — under which an employee may reportedly
--     start work immediately upon submitting the application, without
--     waiting for the permit to be formally issued. This is a genuine,
--     distinctive structural difference from single-track work-permit
--     systems.
--   - The Danish Agency for International Recruitment and Integration
--     (SIRI) — not the embassy/consulate — is the deciding authority for
--     work and student residence permits; VFS Global/the Royal Danish
--     Embassy, New Delhi only handles biometrics collection and
--     application submission, not the decision itself.
--   - Denmark's general family-reunification regime (for a spouse of a
--     Danish citizen or permanent resident) is genuinely among the
--     strictest in Europe: both spouses must be over 24 (the "24-year
--     rule"), the couple must pass an "attachment to Denmark" test, and
--     — unless reduced or waived via the sponsor passing Danish-language
--     tests — the sponsor must post a financial collateral reported at
--     roughly DKK 61,709 for 2026, with processing reported up to 10
--     months. This is materially stricter than the separate, faster
--     "Accompanying Family Member" route used by dependants of work/
--     study permit holders (the route this checklist's Dependent
--     category is built around), and is flagged distinctly below.
--   - India is NOT on Denmark's Airport Transit Visa (ATV) list, so a
--     purely airside Copenhagen connection (no baggage reclaim, no
--     immigration) needs no visa at all — a genuine and often-missed
--     distinction from applicants assuming a transit visa is required.
--   - Denmark offers a distinct "Study, Sports and Cultural" Schengen
--     visa sub-category (stays up to 90 days to take part in a cultural,
--     sporting, or scientific event), and non-profit participants aged
--     25 or under in such events may qualify for a discretionary visa
--     fee waiver — a notable, narrowly-scoped concession not present in
--     the standard Tourist/Business track.
--
-- All 10 categories below have a best-effort structure; none required
-- being flagged as entirely unresearched, though SIRI-administered fee/
-- threshold figures (Student, Work, Dependent) carry the general caveat
-- above given the blocked official domains.
--
-- country_id 115 = Denmark. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    115, 1, 'DNK-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Denmark.',
    'Indian passport holders — the standard Schengen C-type visa, applied via VFS Global, valid for travel across the wider Schengen area, not just Denmark. Passport must be valid 3+ months beyond intended stay and issued within the last 10 years.',
    'Single or multiple entry, up to 90 days within any 180-day period',
    'Apply via VFS Global (multiple Indian cities); biometrics mandatory for first-time applicants',
    1,
    'Standard Schengen processing is typically 15 calendar days; can extend to 3-5 weeks in peak season (Jun-Aug)',
    'Royal Danish Embassy, New Delhi (decision authority), via VFS Global application centres',
    'Book a VFS Global appointment\nComplete the online Schengen visa application form\nGather supporting documents\nAttend the appointment and submit biometrics (mandatory for first-time applicants)\nTrack status and collect your passport',
    '/assets/images/visa-heroes/denmark.webp',
    'Cross-checked against VFS Global and Schengen-visa secondary sourcing; official nyidanmark.dk/indien.um.dk domains were not directly fetchable this session (network egress blocked)', 'https://www.vfsglobal.com/one-pager/denmark/india/english/index.html', '2026-09-17'
);
SET @dnk1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dnk1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dnk1, 'Core Documents', 'Required from every applicant.', 1);
SET @dnk1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dnk1s1, 'Valid Passport (3+ Months Beyond Intended Stay, Issued Within 10 Years)', NULL, 'original', 1, 0, 1, 1),
(@dnk1s1, 'Completed Schengen Visa Application Form', NULL, 'copy', 1, 0, 1, 2),
(@dnk1s1, 'Travel/Schengen Medical Insurance (Min. EUR 30,000 Coverage)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dnk1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @dnk1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dnk1s2, 'Confirmed Hotel Booking', NULL, 'copy', 1, 0, 0, 1),
(@dnk1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2),
(@dnk1s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(115, 1, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Children aged 6-12 pay EUR 45; under 6 exempt. A separate VFS Global service charge (~INR 1,360) also applies, and the visa fee itself is non-refundable even if the application is rejected.', '2026-09-01', NOW(), 'https://www.vfsglobal.com/one-pager/denmark/india/english/index.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does a Denmark Tourist visa let me travel elsewhere in Europe?', 'Yes — the Schengen C-type visa is valid for travel across the entire Schengen area, not just Denmark, subject to the standard 90-days-in-180 rule.', 115, 1, 11500, 1),
('How many VFS Global centres handle Denmark visa applications in India?', 'VFS Global operates multiple application centres across India for Denmark visas; check the current list on the VFS Global Denmark-India portal, as coverage has expanded in recent years.', 115, 1, 11501, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    115, 2, 'DNK-BUS-IN-02', '2026.09', 'published',
    'Trade, negotiations, and commercial meetings in Denmark.',
    'Indian nationals travelling for business — the same Schengen C-type visa as Tourist, with a company invitation letter and an Indian employer forwarding letter as the differentiating documents.',
    'Single, double, or multiple entry, up to 90 days within any 180-day period',
    'Apply via VFS Global with a Danish host company invitation letter and Indian employer forwarding letter',
    1,
    'Standard Schengen processing is typically 15 calendar days',
    'Royal Danish Embassy, New Delhi, via VFS Global application centres',
    'Obtain an invitation letter from the Danish host company\nGather the Indian employer forwarding/sponsorship letter\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/denmark.webp',
    'Cross-checked against VFS Global and Schengen-visa secondary sourcing; official nyidanmark.dk/indien.um.dk domains were not directly fetchable this session', 'https://www.vfsglobal.com/one-pager/denmark/india/english/index.html', '2026-09-17'
);
SET @dnk2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dnk2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dnk2, 'Core Documents', 'Required from every applicant.', 1);
SET @dnk2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dnk2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@dnk2s1, 'Invitation Letter from Danish Host Company', NULL, 'original', 1, 0, 1, 2),
(@dnk2s1, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dnk2, 'Supporting Documents', 'Evidence of your own employment and financial responsibility.', 2);
SET @dnk2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dnk2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@dnk2s2, 'Business Registration Proof', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(115, 2, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://www.vfsglobal.com/one-pager/denmark/india/english/index.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does the Danish invitation letter need to specify trip costs?', 'Commonly yes — the invitation letter is expected to confirm the purpose of the visit and, where the host company is covering costs, state which expenses (accommodation, meals) it is responsible for. Confirm current wording expectations with VFS before applying.', 115, 2, 11502, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — SIRI Student Residence Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    115, 3, 'DNK-STU-IN-03', '2026.09', 'published',
    'Enrolling in a recognized Danish university or institution.',
    'Indian nationals admitted to a Danish institution for a program longer than 90 days must obtain a Student Residence Permit decided by SIRI (Danish Agency for International Recruitment and Integration), applied for online ahead of a biometrics appointment.',
    'Tied to the length of the study program; permit issued for the course duration',
    'Apply online via SIRI''s self-service portal; attend biometrics at VFS Global or a Danish mission',
    1,
    'Standard processing time is reported at around 60 days (2 months) from a complete application',
    'SIRI (decision authority); biometrics collected via VFS Global centres or the Royal Danish Embassy, New Delhi',
    'Secure admission at a recognized Danish institution\nCreate a case order ID and submit the application online via SIRI\nGather proof of funds (DKK 7,426/month) and accommodation\nBook and attend a biometrics appointment at VFS Global or a Danish mission\nAwait the SIRI decision and collect your residence permit',
    '/assets/images/visa-heroes/denmark.webp',
    'Cross-checked against SIRI-process secondary sourcing (study-abroad consultancy and immigration-guide reporting); official nyidanmark.dk was not directly fetchable this session', 'https://www.nyidanmark.dk/en-GB/You-want-to-apply/Study', '2026-09-17'
);
SET @dnk3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dnk3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dnk3, 'Core Documents', 'Required from every applicant.', 1);
SET @dnk3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dnk3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@dnk3s1, 'Admission/Enrolment Letter from Danish Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dnk3, 'Supporting Documents', 'Evidence of your academic background, funds, and accommodation.', 2);
SET @dnk3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dnk3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@dnk3s2, 'Proof of Funds (DKK 7,426/Month)', NULL, 'copy', 1, 0, 0, 2),
(@dnk3s2, 'Proof of Accommodation in Denmark', NULL, 'copy', 1, 0, 0, 3),
(@dnk3s2, 'Proof of English/Danish Language Proficiency', 'Required by some programs depending on the language of instruction.', 'copy', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(115, 3, 3060.00, 'DKK', 'Student Residence Permit Fee (SIRI)', 'Payable online when submitting the SIRI application; distinct from the ~EUR 90 Schengen C-type fee used for short stays. Reconfirm the current figure on nyidanmark.dk before applying.', '2026-09-01', NOW(), 'https://www.nyidanmark.dk/en-GB/You-want-to-apply/Study', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Who decides my Denmark student residence permit — the embassy or SIRI?', 'SIRI (the Danish Agency for International Recruitment and Integration) makes the actual decision. The Royal Danish Embassy/VFS Global only handles application submission and biometrics collection.', 115, 3, 11503, 1),
('Can I work while studying in Denmark?', 'International students on a Danish student residence permit are commonly reported to be permitted part-time work during term and full-time during specific summer months — confirm the exact current hours cap for your permit type with SIRI before starting work.', 115, 3, 11504, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Positive List / Pay Limit / Fast-Track
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    115, 4, 'DNK-WORK-IN-04', '2026.09', 'published',
    'Employment with a Danish employer via the Positive List, Pay Limit Scheme, or Fast-Track Scheme.',
    'Indian nationals with a confirmed Danish job offer. Three distinct routes exist: the Positive Lists (Positivlisten — ~190 higher-education shortage roles and ~65 skilled-trade roles as of 2026, updated twice yearly), the Pay Limit Scheme (DKK 552,000/year for 2026) and Supplementary Pay Limit Scheme (DKK 446,000/year), or the Fast-Track Scheme for SIRI-certified employers.',
    'Permit validity tied to the job contract, typically up to 4 years, renewable',
    'Employer-initiated; apply online via SIRI, often jointly with the employer under the Fast-Track Scheme',
    1,
    'Normal SIRI processing is around 1 month; Fast-Track certified-employer cases may start work immediately on submission; the Supplementary Pay Limit track can take up to 4 months if extra information is requested',
    'SIRI (decision authority); biometrics via VFS Global or the Royal Danish Embassy, New Delhi',
    'Secure a job offer meeting the Positive List, Pay Limit, or Fast-Track criteria\nConfirm whether the employer is SIRI Fast-Track certified\nApply online via SIRI (jointly with the employer under Fast-Track)\nAttend biometrics at VFS Global or a Danish mission\nReceive the SIRI decision and collect your residence/work permit',
    '/assets/images/visa-heroes/denmark.webp',
    'Cross-checked against SIRI Positive List, Pay Limit Scheme, and Fast-Track Scheme secondary reporting (immigration-law firm and relocation-consultancy coverage); official nyidanmark.dk was not directly fetchable this session', 'https://www.nyidanmark.dk/en-GB/You-want-to-apply/Work', '2026-09-17'
);
SET @dnk4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dnk4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dnk4, 'Core Documents', 'Required from every applicant.', 1);
SET @dnk4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dnk4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@dnk4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2),
(@dnk4s1, 'Fast-Track Certified-Employer Confirmation', 'Only if applying under the Fast-Track Scheme.', 'copy', 0, 1, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dnk4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @dnk4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dnk4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@dnk4s2, 'Proof Salary Meets Pay Limit/Positive List Threshold', NULL, 'copy', 1, 0, 0, 2),
(@dnk4s2, 'Police Clearance Certificate', NULL, 'original', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(115, 4, 6810.00, 'DKK', 'Work & Residence Permit Fee (SIRI)', 'Main-applicant fee reported for 2026; accompanying family members are charged separately (~DKK 3,080 each). SIRI resets pay-limit thresholds and fees on a rolling basis — reconfirm the current figure before applying.', '2026-09-01', NOW(), 'https://www.nyidanmark.dk/en-GB/You-want-to-apply/Work', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is the difference between the Positive List and the Pay Limit Scheme?', 'The Positive List grants a work permit for occupations facing a labour shortage at a salary meeting normal Danish standards for that role, without needing to clear the higher Pay Limit threshold. The Pay Limit Scheme instead qualifies any role purely on meeting a fixed minimum annual salary (DKK 552,000 for 2026, or DKK 446,000 under the Supplementary track).', 115, 4, 11505, 1),
('Can I start working in Denmark before my work permit is approved?', 'Only under the Fast-Track Scheme with a SIRI-certified employer — in that case, employment can reportedly begin immediately upon submitting the application, rather than waiting for formal approval as under the standard Positive List or Pay Limit routes.', 115, 4, 11506, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    115, 5, 'DNK-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives or friends resident in Denmark.',
    'Indian nationals with family or friends in Denmark — the same Schengen C-type visa as Tourist, requiring an invitation letter from the host in Denmark plus documentary proof of the relationship.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with a host invitation letter and relationship proof',
    1,
    'Standard Schengen processing is typically 15 calendar days',
    'Royal Danish Embassy, New Delhi, via VFS Global application centres',
    'Obtain an invitation letter from your host in Denmark\nGather documents proving the family/personal relationship\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/denmark.webp',
    'Cross-checked against VFS Global and Schengen-visa secondary sourcing; official nyidanmark.dk/indien.um.dk domains were not directly fetchable this session', 'https://www.vfsglobal.com/one-pager/denmark/india/english/index.html', '2026-09-17'
);
SET @dnk5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dnk5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dnk5, 'Core Documents', 'Required from every applicant.', 1);
SET @dnk5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dnk5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@dnk5s1, 'Invitation Letter from Host in Denmark', NULL, 'original', 1, 0, 1, 2),
(@dnk5s1, 'Proof of Relationship', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dnk5, 'Supporting Documents', 'Evidence of your own means.', 2);
SET @dnk5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dnk5s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 1),
(@dnk5s2, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(115, 5, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge.', '2026-09-01', NOW(), 'https://www.vfsglobal.com/one-pager/denmark/india/english/index.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a Family Visit visa different from a Dependent residence permit?', 'Yes — a Family Visit visa is a short-stay Schengen visa (up to 90 days) for visiting relatives/friends, while a Dependent application is a long-stay residence permit for family members relocating to live with a sponsor already settled or working in Denmark.', 115, 5, 11507, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Airport Transit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    115, 6, 'DNK-TRAN-IN-06', '2026.09', 'published',
    'Passing through a Danish airport (e.g. Copenhagen) toward a non-Schengen destination.',
    'India is NOT on Denmark''s Airport Transit Visa (ATV) list, so a purely airside connection (no baggage reclaim, no passport control, same or connecting airport) generally needs no visa at all. A full Schengen C-type visa is only required if you must leave the international transit zone.',
    'Limited to the connection window while airside; if a Type C visa is required, standard 90/180-day Schengen terms apply',
    'No visa needed for a purely airside transfer; if leaving the transit zone, apply via VFS Global for a standard Schengen C-type visa',
    1,
    'Standard Schengen processing (only if a Type C visa is genuinely required) is typically 15 calendar days',
    'Royal Danish Embassy, New Delhi, via VFS Global application centres (only if a Type C visa is required)',
    'Confirm your itinerary stays airside with no baggage reclaim, airport change, or immigration control\nIf you must leave the transit zone, apply via VFS Global for a Schengen C-type visa\nGather your onward ticket and itinerary if applying\nSubmit documents and biometrics at VFS Global, if required',
    '/assets/images/visa-heroes/denmark.webp',
    'Cross-checked against airport-transit and Schengen-ATV-list secondary sourcing; official nyidanmark.dk/indien.um.dk domains were not directly fetchable this session', 'https://www.vfsglobal.com/one-pager/denmark/india/english/index.html', '2026-09-17'
);
SET @dnk6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dnk6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dnk6, 'Core Documents', 'Required only if a Type C visa is genuinely needed.', 1);
SET @dnk6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dnk6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@dnk6s1, 'Onward Flight Ticket/Itinerary', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dnk6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @dnk6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dnk6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(115, 6, NULL, 'EUR', 'Not Applicable for Airside Transit', 'No visa or fee applies to a purely airside connection since India is not on Denmark''s ATV list. If a full Schengen C-type visa is required because you must leave the transit zone, the standard EUR 90 fee applies instead.', '2026-09-01', NOW(), 'https://www.vfsglobal.com/one-pager/denmark/india/english/index.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian passport holders need an Airport Transit Visa for Copenhagen?', 'No — India is not on Denmark''s Airport Transit Visa list. A purely airside connection without leaving the international transit zone, collecting baggage, or clearing immigration needs no visa. A full Schengen C-type visa is only required if you must exit the transit zone.', 115, 6, 11508, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    115, 7, 'DNK-MED-IN-07', '2026.09', 'published',
    'Travel to Denmark for medical treatment.',
    'Indian nationals travelling for treatment — the same Schengen C-type visa as Tourist, requiring a certificate from the treating Danish doctor/hospital confirming the need for specific treatment, plus proof of funds to cover it.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with the medical certificate and Schengen-compliant insurance',
    1,
    'Standard Schengen processing is typically 15 calendar days, longer if documentation is incomplete',
    'Royal Danish Embassy, New Delhi, via VFS Global application centres',
    'Obtain a certificate from the treating Danish doctor/hospital\nArrange Schengen-compliant travel insurance (min. EUR 30,000 cover)\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/denmark.webp',
    'Cross-checked against VFS Global and Schengen-visa secondary sourcing; official nyidanmark.dk/indien.um.dk domains were not directly fetchable this session', 'https://www.vfsglobal.com/one-pager/denmark/india/english/index.html', '2026-09-17'
);
SET @dnk7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dnk7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dnk7, 'Core Documents', 'Required from every applicant.', 1);
SET @dnk7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dnk7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@dnk7s1, 'Medical Certificate/Hospital Confirmation', NULL, 'original', 1, 0, 1, 2),
(@dnk7s1, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dnk7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @dnk7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dnk7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@dnk7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(115, 7, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge. Consulates may waive or reduce this at their discretion on humanitarian grounds, but this is not guaranteed.', '2026-09-01', NOW(), 'https://www.vfsglobal.com/one-pager/denmark/india/english/index.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can the Danish embassy waive my Medical visa fee?', 'Consulates may exercise discretion to waive or reduce the fee on humanitarian grounds, but this is not automatic — plan to pay the standard EUR 90 fee unless you receive explicit confirmation of a waiver.', 115, 7, 11509, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    115, 8, 'DNK-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, seminars, and trade events in Denmark.',
    'Indian nationals attending a conference or seminar — the same Schengen C-type visa as Tourist. Representatives of non-profit organizations aged 25 or under attending a seminar/conference may qualify for a discretionary visa fee waiver.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with a conference invitation/registration confirmation',
    1,
    'Standard Schengen processing is typically 15 calendar days',
    'Royal Danish Embassy, New Delhi, via VFS Global application centres',
    'Obtain a conference invitation or registration confirmation\nGather proof of accommodation and return travel\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/denmark.webp',
    'Cross-checked against Schengen fee-waiver and VFS Global secondary sourcing; official nyidanmark.dk/indien.um.dk domains were not directly fetchable this session', 'https://www.vfsglobal.com/one-pager/denmark/india/english/index.html', '2026-09-17'
);
SET @dnk8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dnk8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dnk8, 'Core Documents', 'Required from every applicant.', 1);
SET @dnk8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dnk8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@dnk8s1, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dnk8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @dnk8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dnk8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@dnk8s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(115, 8, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist. Non-profit organization representatives aged 25 or under attending a seminar/conference may qualify for a discretionary fee waiver — confirm eligibility before paying.', '2026-09-01', NOW(), 'https://www.vfsglobal.com/one-pager/denmark/india/english/index.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I get my Conference visa fee waived?', 'Representatives of non-profit organizations aged 25 or under attending a seminar or conference may qualify for a discretionary fee waiver — this is not automatic, so confirm eligibility with VFS Global/the consulate before your appointment.', 115, 8, 11510, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Study, Sports and Cultural Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    115, 9, 'DNK-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments, or taking part in cultural/scientific events, hosted in Denmark.',
    'Denmark offers a distinct "Study, Sports and Cultural" Schengen visa sub-category for stays up to 90 days to take part in a cultural, sporting, or scientific event, requiring letters from both the home-country association and the host event organizer. Non-profit participants aged 25 or under may qualify for a discretionary fee waiver.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with a home-association letter and host-organizer invitation',
    1,
    'Standard Schengen processing is typically 15 calendar days',
    'Royal Danish Embassy, New Delhi, via VFS Global application centres',
    'Obtain a letter from your resident-country athletic/cultural association confirming your role\nObtain an invitation letter from the host event organizer with event details and expense arrangements\nComplete the online Schengen visa application\nSubmit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/denmark.webp',
    'Cross-checked against the Danish "Study, Sports and Cultural" visa category and Schengen fee-waiver secondary sourcing; official nyidanmark.dk/indien.um.dk domains were not directly fetchable this session', 'https://www.vfsglobal.com/one-pager/denmark/india/english/index.html', '2026-09-17'
);
SET @dnk9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dnk9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dnk9, 'Core Documents', 'Required from every applicant.', 1);
SET @dnk9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dnk9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@dnk9s1, 'Home-Country Sports/Cultural Association Letter', 'Confirms role and non-employment status.', 'original', 1, 0, 1, 2),
(@dnk9s1, 'Host Event Organizer Invitation Letter', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dnk9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @dnk9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dnk9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(115, 9, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist. Non-profit participants aged 25 or under in a sporting/cultural/scientific event may qualify for a discretionary fee waiver — confirm eligibility before paying.', '2026-09-01', NOW(), 'https://www.vfsglobal.com/one-pager/denmark/india/english/index.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a Denmark-specific visa category for sports and cultural events?', 'Yes — Denmark offers a distinct "Study, Sports and Cultural" Schengen visa sub-category for stays up to 90 days specifically to take part in a cultural, sporting, or scientific event, alongside the standard Tourist/Business route.', 115, 9, 11511, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Accompanying Family Member Residence Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    115, 10, 'DNK-DEP-IN-10', '2026.09', 'published',
    'Spouse, registered partner, or minor children joining an Indian national who holds a Danish work, study, or residence permit.',
    'Family members apply separately for an "Accompanying Family Member" residence permit tied to the sponsor''s permit. Denmark''s broader family-reunification regime (for spouses of Danish citizens/permanent residents) is notably strict: both spouses must be over 24 (the "24-year rule"), pass an attachment-to-Denmark test, and post a financial collateral reported around DKK 61,709 for 2026 unless reduced via Danish-language tests.',
    'Tied to the sponsor''s permit validity; renewable alongside it',
    'Apply online via SIRI as an accompanying family member, or under the general family-reunification track depending on the sponsor''s status',
    1,
    'Accompanying-family cases generally follow a similar 1-2 month SIRI timeline to the sponsor; the general reunification track (spouses of citizens/permanent residents) reports a maximum of up to 10 months',
    'SIRI (decision authority); biometrics via VFS Global or the Royal Danish Embassy, New Delhi',
    'Confirm which route applies: accompanying a work/study permit holder, or general reunification with a Danish citizen/permanent resident\nGather relationship proof (marriage/birth certificates) and the sponsor''s permit copy\nApply online via SIRI\nAttend biometrics at VFS Global or a Danish mission\nIf on the general track, prepare for the attachment requirement and financial collateral (~DKK 61,709 for 2026, reduced/waived via Danish-language tests)',
    '/assets/images/visa-heroes/denmark.webp',
    'Cross-checked against SIRI accompanying-family-member guidance and Danish family-reunification secondary reporting (immigration-law firm coverage of the 24-year rule and attachment requirement); nyidanmark.dk was not directly fetchable this session', 'https://www.nyidanmark.dk/en-GB/You-want-to-apply/Family', '2026-09-17'
);
SET @dnk10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dnk10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dnk10, 'Core Documents', 'Required from every applicant.', 1);
SET @dnk10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dnk10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@dnk10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dnk10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit and status.', 2);
SET @dnk10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dnk10s2, 'Sponsor''s Work/Study/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@dnk10s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2),
(@dnk10s2, 'Financial Collateral Documentation (General Family-Reunification Track Only)', 'Applies only to the stricter general reunification route with a Danish citizen/permanent resident, not the accompanying-family route.', 'if_applicable', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(115, 10, 3080.00, 'DKK', 'Accompanying Family Member Permit Fee (SIRI)', 'Applies to the faster accompanying-family route tied to a work/study permit holder. The separate general family-reunification track (spouse of a Danish citizen/permanent resident) is reported at a materially higher fee (~DKK 8,490) plus the financial collateral requirement — confirm which route applies before budgeting.', '2026-09-01', NOW(), 'https://www.nyidanmark.dk/en-GB/You-want-to-apply/Family', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Why is Danish family reunification considered so strict?', 'Denmark''s general family-reunification track (for a spouse of a Danish citizen or permanent resident) applies the "24-year rule" (both spouses must be over 24), an attachment-to-Denmark test, and a financial collateral reported around DKK 61,709 for 2026 — among the toughest regimes in Europe. This is separate from the simpler, faster "Accompanying Family Member" route used by dependants of work/study permit holders, which this checklist is built around.', 115, 10, 11512, 1),
('Can my spouse work in Denmark on an accompanying family member permit?', 'Yes — reporting indicates holders of an accompanying family member residence permit are generally free to work in Denmark, but must not give up their Danish address or stay outside Denmark for more than 6 consecutive months, or the permit reportedly lapses.', 115, 10, 11513, 1);
