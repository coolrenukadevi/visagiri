-- Ethiopia Visa Checklist Engine content for all 10 visa types — built
-- this session via web search. hero_image_url left NULL at authoring
-- time (no photo bundle supplied yet).
--
-- IMPORTANT SOURCING CAVEAT: the official e-Visa portal (evisa.gov.et)
-- and the Embassy of Ethiopia in New Delhi were NOT directly fetchable
-- this session (network egress to both evisa.gov.et and secondary
-- aggregator sites such as ethiopia-e-visa.com and eoiaddisababa.gov.in
-- was blocked by the environment's proxy). All findings below are
-- triangulated from web-search-indexed secondary sourcing (visa
-- agencies, immigration-guide sites, and search-engine summaries of the
-- official portal's own category pages). Fee figures in particular vary
-- meaningfully across sources (Tourist e-Visa reported anywhere from
-- ~$50 to ~$82 depending on source and date, with one source citing a
-- recent ~$20 price cut) and are flagged as approximate throughout.
-- CATEGORIES FLAGGED "NOT INDEPENDENTLY CONFIRMED THIS SESSION" for
-- fee purposes: Business, Student, Family Visit, Transit, Medical,
-- Conference, Sports, and Dependent (only Tourist and the Work e-Visa
-- subtypes had fee figures repeated consistently enough across sources
-- to record a specific amount).
--
-- Ethiopia's real, distinctive facts (as found this session):
--   - Ethiopia runs a mandatory e-Visa system at evisa.gov.et covering
--     nearly all nationalities including India; most categories need no
--     embassy visit at all. A visa-on-arrival option is also reported
--     at Bole International Airport, Addis Ababa, at least for the
--     Tourist category.
--   - The e-Visa portal splits "Work" into several distinctly named,
--     separately priced sub-categories — Private Work Visa, Government
--     Employment Visa, NGO Work Visa, Foreign Business Firm Employment
--     Visa, and Investment Visa — a granularity of work-visa splitting
--     not common in many other countries' systems.
--   - Addis Ababa hosts the African Union headquarters, and Ethiopia
--     maintains a distinct Conference e-Visa category explicitly framed
--     around AU and other international conferences held there.
--   - A confirmed Sports Competition and Training e-Visa (SPV) category
--     exists on the official portal (evisa.gov.et/information/sport-visa
--     was found indexed, though not directly fetchable this session).
--   - "Dependent" status is not a separate e-Visa/entry-visa category at
--     all — spouses and minor children of a work/residence-permit
--     holder instead apply domestically to Ethiopia's Immigration &
--     Citizenship Service (ICS) for a dependent residence permit and
--     family-member residence ID, only after the principal applicant's
--     own permit is already approved.
--   - SAFETY CAVEAT (genuinely relevant, flagged honestly): Ethiopia has
--     had significant internal conflict in recent years. As of this
--     session, secondary sourcing on the U.S. Department of State's
--     Ethiopia advisory describes a Level 3 "Reconsider Travel" rating
--     (dated April 2026), with the Tigray region and the Eritrea border
--     under a "Do Not Travel" rating, and elevated risk also flagged for
--     parts of Afar, Amhara, Gambella, Benishangul-Gumuz, and Oromia.
--     Addis Ababa itself is reported as calm from a security standpoint
--     but with rising petty crime. India's own Embassy in Addis Ababa
--     maintains a dedicated "Advisory for Indians in Ethiopia" page
--     (indexed as last updated May 2025), but its specific content could
--     not be independently fetched this session (egress blocked) — this
--     is flagged as NOT INDEPENDENTLY CONFIRMED and travellers should
--     check mea.gov.in and eoiaddisababa.gov.in directly before booking.
--   - Ethiopia has a longstanding Indian business/expatriate community
--     (notably textile and manufacturing investment, plus Indian-linked
--     educational and training institutions), which is reflected in the
--     Work and Student category framing below.
--
-- country_id 18 = Ethiopia. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    18, 1, 'ETH-TOUR-IN-01', '2026.09', 'published',
    'Leisure, sightseeing, and cultural tourism travel to Ethiopia.',
    'Indian passport holders apply through Ethiopia''s mandatory e-Visa portal (evisa.gov.et); a visa-on-arrival option is also reported at Bole International Airport, Addis Ababa, for this category. No embassy visit is required for most applicants.',
    'Single entry, typically 30 or 90 days depending on the e-Visa option chosen',
    'Apply online via the official Ethiopia e-Visa portal (evisa.gov.et); visa-on-arrival also reported available at Bole International Airport',
    0,
    'Reported at 1-3 business days for standard e-Visa approval, extending up to around 10 days during peak season or with incomplete documents',
    'Ethiopian Immigration & Citizenship Service (online decision authority); Embassy of Ethiopia, 7/50-G Satya Marg, Chanakyapuri, New Delhi for consular queries',
    'Create an account and complete the online application at evisa.gov.et\nUpload passport bio page and a passport-size photo\nPay the e-Visa fee online\nReceive the e-Visa by email and print a copy for travel\nCarry the printed e-Visa and show it on arrival at Bole International Airport',
    '/assets/images/visa-heroes/ethiopia.webp',
    'Cross-checked against visa-agency secondary sourcing summarizing the official e-Visa portal''s Tourist category; evisa.gov.et itself was not directly fetchable this session (network egress blocked)', 'https://www.evisa.gov.et/', '2026-09-17'
);
SET @eth1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@eth1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eth1, 'Core Documents', 'Required from every applicant.', 1);
SET @eth1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eth1s1, 'Valid Passport (6+ Months Beyond Intended Stay)', NULL, 'original', 1, 0, 1, 1),
(@eth1s1, 'Digital Passport-Size Photograph', 'Uploaded during the online e-Visa application.', 'copy', 1, 0, 1, 2),
(@eth1s1, 'Printed Copy of Approved e-Visa', 'Carried and shown on arrival.', 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eth1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @eth1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eth1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 1),
(@eth1s2, 'Confirmed Hotel Booking', NULL, 'copy', 0, 1, 0, 2),
(@eth1s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(18, 1, 52.00, 'USD', 'Tourist e-Visa Fee (30-Day Single Entry, Approximate)', 'Figures vary across sources from roughly $50 to $82, with at least one source citing a recent ~$20 price reduction — treat as approximate and confirm the exact current amount on evisa.gov.et before paying.', '2026-09-01', NOW(), 'https://www.evisa.gov.et/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need to visit an embassy for an Ethiopia Tourist visa?', 'No — most Indian applicants can apply entirely online through the e-Visa portal (evisa.gov.et); a visa-on-arrival option is also reported at Bole International Airport, though applying online in advance is recommended.', 18, 1, 1800, 1),
('Are there any areas of Ethiopia I should avoid as a tourist?', 'Yes — secondary sourcing on other governments'' advisories (e.g., a reported U.S. Level 3 "Reconsider Travel" rating, April 2026) flags the Tigray region and Eritrea border as "Do Not Travel," with elevated risk also noted in parts of Afar, Amhara, Gambella, Benishangul-Gumuz, and Oromia. Check mea.gov.in and the Indian Embassy in Addis Ababa''s advisory page before finalizing an itinerary.', 18, 1, 1801, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    18, 2, 'ETH-BUS-IN-02', '2026.09', 'published',
    'Trade meetings, commercial negotiations, and investment scouting in Ethiopia.',
    'Indian nationals travelling for business apply through the same e-Visa portal as Tourist, submitting a company invitation letter; a separate Investment e-Visa category exists for applicants specifically scouting investment opportunities.',
    'Single or multiple entry, typically 30 or 90 days',
    'Apply online via evisa.gov.et under the Business category with an invitation letter from the Ethiopian host company',
    0,
    'Reported in the same 1-3 business day e-Visa processing window as Tourist, extending during peak periods',
    'Ethiopian Immigration & Citizenship Service (online decision authority); Embassy of Ethiopia, New Delhi for consular queries',
    'Obtain an invitation letter from the Ethiopian host company\nGather your Indian employer''s forwarding/sponsorship letter\nComplete the online e-Visa application at evisa.gov.et\nPay the fee and receive the e-Visa by email\nCarry the printed e-Visa for arrival at Bole International Airport',
    '/assets/images/visa-heroes/ethiopia.webp',
    'Cross-checked against visa-agency secondary sourcing; evisa.gov.et was not directly fetchable this session (network egress blocked) — the Business fee figure specifically is NOT INDEPENDENTLY CONFIRMED', 'https://www.evisa.gov.et/', '2026-09-17'
);
SET @eth2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@eth2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eth2, 'Core Documents', 'Required from every applicant.', 1);
SET @eth2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eth2s1, 'Valid Passport (6+ Months Beyond Intended Stay)', NULL, 'original', 1, 0, 1, 1),
(@eth2s1, 'Invitation Letter from Ethiopian Host Company', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eth2, 'Supporting Documents', 'Evidence of your own employment and financial standing.', 2);
SET @eth2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eth2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@eth2s2, 'Business Registration/Company Profile', NULL, 'copy', 0, 1, 0, 2),
(@eth2s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(18, 2, NULL, 'USD', 'Confirmed After Assessment', 'Not independently confirmed this session. Secondary sources place it in the same broad $50-$82 range as the Tourist e-Visa, with some agencies quoting a slightly higher figure (~$62) for Business specifically — verify the exact current amount on evisa.gov.et.', '2026-09-01', NOW(), 'https://www.evisa.gov.et/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate visa for investment scouting rather than general business?', 'Yes — Ethiopia''s e-Visa portal lists a distinct Investment e-Visa category alongside the general Business category; choose whichever matches your primary purpose of travel.', 18, 2, 1810, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    18, 3, 'ETH-STU-IN-03', '2026.09', 'published',
    'Enrolling in a recognized Ethiopian educational institution (e.g., Addis Ababa University, Addis Ababa Science and Technology University).',
    'Indian nationals admitted to a recognized Ethiopian institution apply for the Student e-Visa category with an acceptance letter and proof of funds; validity is generally tied to course duration rather than a fixed short-stay window.',
    'Tied to course duration, renewable for the program length',
    'Apply online via evisa.gov.et under the Student category with an acceptance/admission letter from the Ethiopian institution',
    0,
    'Reported in the same 1-3 business day e-Visa processing window as other categories generally; allow extra time for document review on the Student category',
    'Ethiopian Immigration & Citizenship Service (online decision authority); Embassy of Ethiopia, New Delhi for consular queries',
    'Secure admission at a recognized Ethiopian institution\nGather proof of funds/scholarship confirmation and a health clearance certificate if requested\nComplete the online e-Visa application at evisa.gov.et\nPay the fee and receive the e-Visa by email\nCarry the printed e-Visa on arrival and register locally as required by the institution',
    '/assets/images/visa-heroes/ethiopia.webp',
    'Cross-checked against visa-agency secondary sourcing on the Student e-Visa category; evisa.gov.et was not directly fetchable this session (network egress blocked) — the Student fee figure specifically is NOT INDEPENDENTLY CONFIRMED', 'https://www.evisa.gov.et/', '2026-09-17'
);
SET @eth3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@eth3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eth3, 'Core Documents', 'Required from every applicant.', 1);
SET @eth3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eth3s1, 'Valid Passport (6+ Months Beyond Intended Stay)', NULL, 'original', 1, 0, 1, 1),
(@eth3s1, 'Admission/Acceptance Letter from Ethiopian Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eth3, 'Supporting Documents', 'Evidence of your academic background, funds, and health cover.', 2);
SET @eth3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eth3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@eth3s2, 'Proof of Funds or Scholarship Confirmation', NULL, 'copy', 1, 0, 0, 2),
(@eth3s2, 'Health Clearance Certificate', 'Requested for some courses/institutions.', 'original', 0, 1, 0, 3),
(@eth3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(18, 3, NULL, 'USD', 'Confirmed After Assessment', 'Not independently confirmed this session — sources did not consistently report a Student e-Visa fee figure. Likely comparable to the $50-$82 Tourist e-Visa range but verify directly on evisa.gov.et or with the institution before applying.', '2026-09-01', NOW(), 'https://www.evisa.gov.et/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Ethiopia have institutions with Indian links that Indian students commonly attend?', 'Ethiopia has a longstanding Indian business and expatriate presence, and Indian-linked educational and training institutions are reported alongside major public universities such as Addis Ababa University — confirm program-specific recognition/accreditation directly with the institution before applying.', 18, 3, 1820, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — e-Visa (multiple named subtypes)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    18, 4, 'ETH-WORK-IN-04', '2026.09', 'published',
    'Employment with an Ethiopian employer, foreign business, NGO, government body, or investment-linked entity.',
    'Indian nationals with a confirmed Ethiopian job offer apply for one of several named Work e-Visa subtypes — Private Work Visa, Government Employment Visa, NGO Work Visa, Foreign Business Firm Employment Visa, or Investment Visa — each separately priced. A Ministry of Labour and Social Affairs work-permit registration by the employer is also generally required for stays beyond 90 days.',
    'Tied to the employment contract and work-permit validity',
    'Employer-initiated: Ministry of Labour work-permit registration first, then e-Visa application via evisa.gov.et under the matching subtype',
    0,
    'The Foreign Business Firm Employment e-Visa itself is reported to process in about 3 days; the underlying Ministry of Labour work permit is separately reported to take roughly 7-21 days',
    'Ministry of Labour and Social Affairs (work permit); Ethiopian Immigration & Citizenship Service (e-Visa); Embassy of Ethiopia, New Delhi for consular queries',
    'Secure a job offer and identify the correct Work e-Visa subtype for your role (Private/Government/NGO/Foreign Business Firm/Investment)\nHave the Ethiopian employer register the role with the Ministry of Labour and Social Affairs\nComplete the online e-Visa application at evisa.gov.et under the matching subtype\nPay the applicable subtype fee and receive the e-Visa by email\nTravel, then complete any further residence-permit registration required locally',
    '/assets/images/visa-heroes/ethiopia.webp',
    'Cross-checked against visa-agency secondary sourcing summarizing the e-Visa portal''s named Work subtypes and general work-permit process reporting; evisa.gov.et was not directly fetchable this session (network egress blocked)', 'https://www.evisa.gov.et/', '2026-09-17'
);
SET @eth4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@eth4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eth4, 'Core Documents', 'Required from every applicant.', 1);
SET @eth4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eth4s1, 'Valid Passport (6+ Months Beyond Intended Stay)', NULL, 'original', 1, 0, 1, 1),
(@eth4s1, 'Employment Contract/Offer Letter', NULL, 'copy', 1, 0, 1, 2),
(@eth4s1, 'Ministry of Labour Work-Permit Registration Confirmation', 'Filed by the Ethiopian employer.', 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eth4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @eth4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eth4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@eth4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2),
(@eth4s2, 'Medical Fitness Certificate', NULL, 'original', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(18, 4, 32.00, 'USD', 'Private Work Visa Fee (Approximate)', 'Reported subtype fees vary: Private Work Visa and Government Employment Visa ~$32, Foreign Business Firm Employment Visa ~$42, NGO Work Visa ~$62, Investment Visa ~$32 — confirm the figure for your specific subtype on evisa.gov.et; these figures are as reported by secondary sourcing, not independently confirmed on the official portal this session.', '2026-09-01', NOW(), 'https://www.evisa.gov.et/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Why does Ethiopia have so many different Work visa categories?', 'The e-Visa portal splits work-related entry into several distinctly named, separately priced subtypes (Private, Government, NGO, Foreign Business Firm Employment, and Investment) rather than one generic Work visa — choosing the correct subtype for your employer type affects both the fee and the underlying Ministry of Labour registration route.', 18, 4, 1830, 1),
('Is the e-Visa the same as the work permit?', 'No — the e-Visa is the entry visa; a separate work-permit registration with the Ministry of Labour and Social Affairs, generally initiated by the employer, is required for employment stays beyond 90 days.', 18, 4, 1831, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    18, 5, 'ETH-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives or family members resident in Ethiopia.',
    'Indian nationals with family in Ethiopia apply for the Visit/Family Visit e-Visa category, reported as distinct from the general Tourist e-Visa, typically requiring an invitation from the Ethiopia-based host plus proof of the family relationship.',
    'Short-stay, typically up to 30 or 90 days depending on category chosen',
    'Apply online via evisa.gov.et under the Visit/Family Visit category with a host invitation and relationship proof',
    0,
    'Reported in the same 1-3 business day e-Visa processing window as Tourist, extending during peak periods',
    'Ethiopian Immigration & Citizenship Service (online decision authority); Embassy of Ethiopia, New Delhi for consular queries',
    'Obtain an invitation letter from your host resident in Ethiopia\nGather documents proving the family relationship\nComplete the online e-Visa application at evisa.gov.et under the Visit/Family Visit category\nPay the fee and receive the e-Visa by email\nCarry the printed e-Visa on arrival',
    '/assets/images/visa-heroes/ethiopia.webp',
    'Cross-checked against visa-agency secondary sourcing describing a distinct Visit/Family Visit e-Visa category; evisa.gov.et was not directly fetchable this session (network egress blocked) — the fee figure is NOT INDEPENDENTLY CONFIRMED', 'https://www.evisa.gov.et/', '2026-09-17'
);
SET @eth5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@eth5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eth5, 'Core Documents', 'Required from every applicant.', 1);
SET @eth5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eth5s1, 'Valid Passport (6+ Months Beyond Intended Stay)', NULL, 'original', 1, 0, 1, 1),
(@eth5s1, 'Invitation Letter from Host in Ethiopia', NULL, 'copy', 1, 0, 1, 2),
(@eth5s1, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eth5, 'Supporting Documents', 'Evidence of your own means.', 2);
SET @eth5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eth5s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 1),
(@eth5s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(18, 5, NULL, 'USD', 'Confirmed After Assessment', 'Not independently confirmed this session. Likely close to the $50-$82 Tourist e-Visa range but verify the exact current amount on evisa.gov.et before applying.', '2026-09-01', NOW(), 'https://www.evisa.gov.et/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Family Visit different from the general Tourist e-Visa?', 'It is reported as a distinct category on the e-Visa portal, mainly differing in the required host invitation and relationship-proof documents rather than the overall online application process.', 18, 5, 1840, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — e-Visa / Airport Transit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    18, 6, 'ETH-TRAN-IN-06', '2026.09', 'published',
    'Passing through Addis Ababa Bole International Airport toward a third country.',
    'Ethiopia''s Transit category is reported to allow a stay of up to 72 hours in Addis Ababa for travellers with a confirmed onward booking; it is generally not required for passengers who remain airside throughout their connection.',
    'Up to 72 hours',
    'Apply online via evisa.gov.et under the Transit category if leaving the airport transit zone is required',
    0,
    'Reported in the same 1-3 business day e-Visa processing window as other categories; apply before travel, as visa-on-arrival cannot be assumed for Transit',
    'Ethiopian Immigration & Citizenship Service (online decision authority); Embassy of Ethiopia, New Delhi for consular queries',
    'Confirm whether your specific connection requires leaving the airport transit zone (if not, no visa is generally needed)\nIf required, complete the online e-Visa application at evisa.gov.et under the Transit category with your onward ticket\nPay the fee and receive the e-Visa by email\nCarry the printed e-Visa and onward ticket on arrival',
    '/assets/images/visa-heroes/ethiopia.webp',
    'Cross-checked against visa-agency secondary sourcing describing a 72-hour Transit category; evisa.gov.et was not directly fetchable this session (network egress blocked) — the fee figure is NOT INDEPENDENTLY CONFIRMED', 'https://www.evisa.gov.et/', '2026-09-17'
);
SET @eth6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@eth6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eth6, 'Core Documents', 'Required if a Transit visa is genuinely needed.', 1);
SET @eth6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eth6s1, 'Valid Passport (6+ Months Beyond Intended Stay)', NULL, 'original', 1, 0, 1, 1),
(@eth6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eth6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @eth6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eth6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(18, 6, NULL, 'USD', 'Confirmed After Assessment', 'Not independently confirmed this session — no consistent Transit-specific fee figure was found. Verify the exact current amount on evisa.gov.et before applying.', '2026-09-01', NOW(), 'https://www.evisa.gov.et/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa if I never leave Bole Airport''s transit area?', 'Generally no — a Transit e-Visa is reported to be required only if you must leave the international transit zone at Bole International Airport; a purely airside connection typically does not require one.', 18, 6, 1850, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — e-Visa (Medical Treatment / MDV)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    18, 7, 'ETH-MED-IN-07', '2026.09', 'published',
    'Travel to Ethiopia for medical treatment.',
    'The Medical Treatment e-Visa (MDV) category, confirmed to exist on the official portal, requires a supporting letter or certificate from the treating Ethiopian hospital or clinic confirming the planned treatment.',
    'Tied to treatment duration, typically up to 90 days',
    'Apply online via evisa.gov.et under the Medical Treatment (MDV) category with a hospital confirmation letter',
    0,
    'Reported in the same 1-3 business day e-Visa processing window as other categories; allow extra time if the hospital confirmation letter is still pending',
    'Ethiopian Immigration & Citizenship Service (online decision authority); Embassy of Ethiopia, New Delhi for consular queries',
    'Obtain a confirmation letter from the treating Ethiopian hospital/clinic\nComplete the online e-Visa application at evisa.gov.et under the Medical Treatment (MDV) category\nPay the fee and receive the e-Visa by email\nCarry the printed e-Visa and medical documents on arrival',
    '/assets/images/visa-heroes/ethiopia.webp',
    'Cross-checked against visa-agency secondary sourcing confirming the Medical Treatment (MDV) category name; evisa.gov.et was not directly fetchable this session (network egress blocked) — the fee figure is NOT INDEPENDENTLY CONFIRMED', 'https://www.evisa.gov.et/', '2026-09-17'
);
SET @eth7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@eth7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eth7, 'Core Documents', 'Required from every applicant.', 1);
SET @eth7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eth7s1, 'Valid Passport (6+ Months Beyond Intended Stay)', NULL, 'original', 1, 0, 1, 1),
(@eth7s1, 'Hospital/Clinic Confirmation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eth7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @eth7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eth7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@eth7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2),
(@eth7s2, 'Attendant''s Passport Copy (If Accompanying)', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(18, 7, NULL, 'USD', 'Confirmed After Assessment', 'Not independently confirmed this session — no consistent Medical-specific fee figure was found. Verify the exact current amount on evisa.gov.et before applying.', '2026-09-01', NOW(), 'https://www.evisa.gov.et/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can a family member accompany a patient on the Medical e-Visa?', 'Accompanying family members typically apply under a separate matching category (e.g., a Tourist or Family Visit e-Visa) rather than being automatically covered by the patient''s Medical Treatment (MDV) visa — confirm the current guidance on evisa.gov.et.', 18, 7, 1860, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — e-Visa (Conference)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    18, 8, 'ETH-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, summits, or official meetings in Addis Ababa, including African Union-linked gatherings.',
    'Ethiopia operates a distinct Conference e-Visa category, notable because Addis Ababa hosts the African Union headquarters and frequent AU/UN-linked international conferences; applicants submit a conference invitation or registration confirmation.',
    'Tied to the conference dates, typically short-stay',
    'Apply online via evisa.gov.et under the Conference category with an official conference invitation/registration letter',
    0,
    'Reported in the same 1-3 business day e-Visa processing window as other categories; AU-linked conferences may involve additional accreditation steps not confirmed this session',
    'Ethiopian Immigration & Citizenship Service (online decision authority); Embassy of Ethiopia, New Delhi for consular queries',
    'Obtain a conference invitation or registration confirmation from the organizer\nGather proof of accommodation and return travel\nComplete the online e-Visa application at evisa.gov.et under the Conference category\nPay the fee and receive the e-Visa by email\nCarry the printed e-Visa and conference documents on arrival',
    '/assets/images/visa-heroes/ethiopia.webp',
    'Cross-checked against visa-agency sourcing on the Conference e-Visa category''s AU/international-conference framing; evisa.gov.et not directly fetchable this session (egress blocked) — fee NOT INDEPENDENTLY CONFIRMED', 'https://www.evisa.gov.et/', '2026-09-17'
);
SET @eth8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@eth8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eth8, 'Core Documents', 'Required from every applicant.', 1);
SET @eth8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eth8s1, 'Valid Passport (6+ Months Beyond Intended Stay)', NULL, 'original', 1, 0, 1, 1),
(@eth8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eth8, 'Supporting Documents', 'Additional employer-side and travel evidence.', 2);
SET @eth8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eth8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@eth8s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(18, 8, NULL, 'USD', 'Confirmed After Assessment', 'Not independently confirmed this session — no consistent Conference-specific fee figure was found. Verify the exact current amount on evisa.gov.et before applying.', '2026-09-01', NOW(), 'https://www.evisa.gov.et/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Why does Ethiopia have a specific Conference visa category?', 'Addis Ababa hosts the African Union headquarters and a steady flow of AU, UN, and other international conferences, and the e-Visa portal reflects this with a dedicated Conference category alongside the general Business visa.', 18, 8, 1870, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — e-Visa (Sports Competition and Training / SPV)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    18, 9, 'ETH-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, coaches, or officials competing or training in Ethiopia.',
    'The Sports Competition and Training e-Visa (SPV) category is confirmed to exist on the official portal (evisa.gov.et/information/sport-visa was found indexed), requiring a letter from the sponsoring sports federation, club, or event organizer confirming the competition or training program.',
    'Tied to the competition/training schedule',
    'Apply online via evisa.gov.et under the Sports Competition and Training (SPV) category with a federation/event sponsor letter',
    0,
    'Reported in the same 1-3 business day e-Visa processing window as other categories',
    'Ethiopian Immigration & Citizenship Service (online decision authority); Embassy of Ethiopia, New Delhi for consular queries',
    'Obtain a letter from your sports federation/club or the host event organizer confirming your participation\nComplete the online e-Visa application at evisa.gov.et under the Sports Competition and Training (SPV) category\nPay the fee and receive the e-Visa by email\nCarry the printed e-Visa and event documents on arrival',
    '/assets/images/visa-heroes/ethiopia.webp',
    'Cross-checked against a search-engine-indexed listing of the official Sports Competition and Training (SPV) category page; evisa.gov.et was not directly fetchable this session (network egress blocked) — the fee figure is NOT INDEPENDENTLY CONFIRMED', 'https://www.evisa.gov.et/information/sport-visa', '2026-09-17'
);
SET @eth9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@eth9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eth9, 'Core Documents', 'Required from every applicant.', 1);
SET @eth9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eth9s1, 'Valid Passport (6+ Months Beyond Intended Stay)', NULL, 'original', 1, 0, 1, 1),
(@eth9s1, 'Federation/Club or Event Organizer Confirmation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eth9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @eth9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eth9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1),
(@eth9s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(18, 9, NULL, 'USD', 'Confirmed After Assessment', 'Not independently confirmed this session — the category''s existence was confirmed via an indexed portal URL, but no fee figure was found. Verify the exact current amount on evisa.gov.et before applying.', '2026-09-01', NOW(), 'https://www.evisa.gov.et/information/sport-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated visa category for athletes travelling to Ethiopia?', 'Yes — the official e-Visa portal lists a specific "Sports Competition and Training" (SPV) category distinct from the general Tourist or Business categories.', 18, 9, 1880, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Residence-Permit Add-On (not a standalone e-Visa)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    18, 10, 'ETH-DEP-IN-10', '2026.09', 'published',
    'Spouse or minor children joining an Indian national who holds a valid Ethiopian work or residence permit.',
    'Dependent status is not a separate e-Visa category but a residence-permit add-on: after the principal applicant secures their own work and residence permit, spouse/children apply to Ethiopia''s Immigration & Citizenship Service (ICS) for a dependent residence permit and family-member residence ID, submitting marriage/birth certificates.',
    'Tied to the principal applicant''s work/residence permit validity',
    'Apply in person at Ethiopia''s Immigration & Citizenship Service (ICS) after the principal''s permit is approved — not via the e-Visa portal',
    1,
    'Domestic residence-permit processing; a specific timeline was not consistently reported across sources this session — confirm current timelines directly with ICS or an immigration adviser',
    'Immigration & Citizenship Service (ICS), Addis Ababa (residence permit decision authority); Embassy of Ethiopia, New Delhi for the initial entry-visa leg',
    'Confirm the principal applicant''s own work permit and residence permit are already approved\nGather authenticated marriage certificate (spouse) or birth certificate (children)\nEnter Ethiopia on a matching entry visa if required, or coordinate with the principal''s permit timeline\nApply to the Immigration & Citizenship Service (ICS) for a dependent residence permit and family-member residence ID\nCollect the residence ID once approved',
    '/assets/images/visa-heroes/ethiopia.webp',
    'Cross-checked against secondary sourcing on Ethiopia''s residence-permit and family-reunification process via the Immigration & Citizenship Service (ICS); official ICS and evisa.gov.et pages were not directly fetchable this session (network egress blocked)', 'https://ics.gov.et/services/', '2026-09-17'
);
SET @eth10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@eth10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eth10, 'Core Documents', 'Required from every applicant.', 1);
SET @eth10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eth10s1, 'Valid Passport (6+ Months Beyond Intended Stay)', NULL, 'original', 1, 0, 1, 1),
(@eth10s1, 'Proof of Relationship to Principal Applicant', 'Authenticated marriage or birth certificate.', 'original', 1, 0, 1, 2),
(@eth10s1, 'Principal Applicant''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@eth10, 'Supporting Documents', 'Additional evidence for the residence-permit application.', 2);
SET @eth10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@eth10s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 1),
(@eth10s2, 'Passport-Size Photographs', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(18, 10, NULL, 'USD', 'Confirmed After Assessment', 'Not independently confirmed this session — no consistent Dependent/family-member residence-permit fee figure was found across sources. Confirm the exact current amount directly with the Immigration & Citizenship Service (ICS) before applying.', '2026-09-01', NOW(), 'https://ics.gov.et/services/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can a dependent apply before the principal applicant''s own permit is approved?', 'No — the dependent residence-permit process is reported to require the principal applicant''s work and residence permit to already be approved before spouse/children can apply for their own dependent residence permit and family-member residence ID.', 18, 10, 1890, 1);
