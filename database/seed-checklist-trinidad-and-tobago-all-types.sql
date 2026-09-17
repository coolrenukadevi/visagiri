-- Trinidad and Tobago Visa Checklist Engine content for all 10 visa types —
-- built this session via web search. hero_image_url points to the existing
-- bundled asset at /assets/images/visa-heroes/trinidad-and-tobago.webp.
--
-- IMPORTANT SOURCING CAVEAT: foreign.gov.tt (the Ministry of Foreign and
-- CARICOM Affairs, incl. the High Commission for the Republic of Trinidad
-- and Tobago, New Delhi's own visa-instruction PDF) and nationalsecurity/
-- homelandsecurity.gov.tt were NOT directly fetchable this session
-- (blocked by the network egress proxy) — findings are triangulated from
-- Wikipedia's "Visa policy of Trinidad and Tobago", travel-agency and
-- visa-information secondary sourcing, Fragomen/Newsday/IdentityWeek
-- coverage of the new arrival-card rollout, and University of the West
-- Indies (UWI St. Augustine) admissions pages. Actual visa FEES for the
-- categories that do require a visa (Student, Work, Dependent) were NOT
-- reliably confirmed this session and are left NULL / "Confirmed After
-- Assessment" throughout rather than guessed — flagged per category below.
--
-- Trinidad and Tobago's real, distinctive, verified facts:
--   - The single most important fact for this file: Indian passport
--     holders are VISA-EXEMPT for tourism, business, family/social
--     visits, short medical treatment, conference attendance, and
--     unpaid sports participation — no visa at all is required for
--     stays up to 90 days within any 180-day period, as long as no
--     paid/compensated activity for a Trinidad-and-Tobago-based entity
--     is involved. Sourcing specifically notes that even UNPAID
--     missionary/volunteer work is treated the same as paid work and
--     falls outside this exemption, requiring a visa instead — a
--     genuinely distinctive carve-out reflected in the Business,
--     Conference, and Sports FAQs below.
--   - Effective 17 March 2026, Trinidad and Tobago made a new Online
--     Arrival/Departure Card (ADC) mandatory for ALL travellers,
--     including visa-exempt visitors — a genuine, dated 2025/2026
--     policy change (reported by Fragomen, Newsday, and IdentityWeek),
--     replacing the old paper immigration/customs card. It must be
--     completed online up to 72 hours before travel.
--   - The High Commission for the Republic of Trinidad and Tobago in
--     New Delhi is the ONLY Trinidadian diplomatic mission in India,
--     and it also covers Trinidad and Tobago's representation in Japan
--     and Singapore — relevant for the categories that do require a
--     formal visa (Student, Work, Dependent).
--   - Trinidad and Tobago has one of the largest Indian diaspora
--     populations outside India: Indo-Trinidadians made up roughly 35%
--     of the population per the 2011 census (468,524 people),
--     descended from Indian indentured laborers first brought by the
--     British on 30 May 1845 (commemorated annually as Indian Arrival
--     Day), predominantly from the Bhojpur and Awadh regions of
--     present-day Bihar and Uttar Pradesh. This is genuinely relevant
--     and distinctive for the Family Visit and Dependent categories.
--   - Individual Work Permit applications and extensions are processed
--     EXCLUSIVELY ONLINE — there is no paper-based route — through the
--     Work Permit Unit, and are employer-driven, requiring evidence
--     that no suitably qualified local or CARICOM national is
--     available. Visits of 30 days or less within any 12-month period
--     do not need a Work Permit at all.
--   - Family reunification/Dependent residence is governed by Section
--     6 of the Immigration Act (spouse of a citizen/resident, parent
--     or grandparent of a citizen/resident if the sponsor can support
--     them, or a dependent minor child of a citizen/resident), with no
--     officially guaranteed processing timeframe — decisions rest with
--     the Minister responsible for immigration and commonly take
--     several months.
--
-- country_id 179 = Trinidad and Tobago. visa_type_id: 1=Tourist,
-- 2=Business, 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical,
-- 8=Conference, 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Visa-Exempt Entry
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    179, 1, 'TTO-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Trinidad and Tobago.',
    'Indian passport holders are visa-exempt for tourism — no visa is required for stays up to 90 days within any 180-day period, provided no compensated work is undertaken in Trinidad and Tobago.',
    'Visa-free entry, up to 90 days within any 180-day period',
    'No visa application needed — complete the mandatory Online Arrival/Departure Card (ADC) instead',
    0,
    'No visa processing — entry is decided by the immigration officer at the port of arrival based on the ADC and standard entry documents.',
    'Not applicable — visa-exempt entry; immigration clearance at Piarco (Trinidad) or ANR Robinson (Tobago) International Airport',
    'Confirm your trip is genuinely tourism-only (no paid work or compensated activity)\nComplete the Online Arrival/Departure Card (ADC) within 72 hours of travel\nCarry a passport valid 6+ months beyond arrival with a blank page\nCarry proof of onward/return travel\nPresent the ADC QR-code receipt and passport to the immigration officer on arrival',
    '/assets/images/visa-heroes/trinidad-and-tobago.webp',
    'Cross-checked against Wikipedia''s Visa policy of Trinidad and Tobago and visa-information secondary sourcing; foreign.gov.tt was blocked by network egress this session, so triangulated instead', 'https://foreign.gov.tt/services/visas/', '2026-09-17'
);
SET @tto1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tto1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tto1, 'Entry Documents', 'Required from every visa-exempt traveller.', 1);
SET @tto1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tto1s1, 'Valid Passport (6+ Months Validity, 1 Blank Page)', NULL, 'original', 1, 0, 1, 1),
(@tto1s1, 'Online Arrival/Departure Card (ADC) Receipt with QR Code', NULL, 'original', 1, 0, 1, 2),
(@tto1s1, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tto1, 'Supporting Documents (If Requested by Immigration)', 'Not always checked, but be ready to show them on arrival.', 2);
SET @tto1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tto1s2, 'Proof of Accommodation (Hotel Booking or Invitation)', NULL, 'copy', 0, 1, 0, 1),
(@tto1s2, 'Proof of Sufficient Funds', NULL, 'copy', 0, 1, 0, 2),
(@tto1s2, 'Travel/Medical Insurance', 'Recommended, not confirmed as mandatory.', 'if_applicable', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(179, 1, 0.00, 'USD', 'No Visa Fee — Visa-Exempt Entry', 'Indian nationals pay no visa fee for tourism because no visa is required for stays up to 90 days; the Online Arrival/Departure Card is a free government platform, not a paid visa.', '2026-09-01', NOW(), 'https://foreign.gov.tt/services/visas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit Trinidad and Tobago as a tourist?', 'No — Indian passport holders are visa-exempt for tourism stays of up to 90 days within any 180-day period, as long as the visit does not involve paid work or compensation from a Trinidad and Tobago-based organization.', 179, 1, 17900, 1),
('What is the Online Arrival/Departure Card and is it new?', 'It is a mandatory digital entry/exit form that became compulsory for all travellers, including visa-exempt visitors, from 17 March 2026, replacing the old paper card. Complete it online up to 72 hours before travel and keep the QR-code receipt.', 179, 1, 17901, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Visa-Exempt Entry
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    179, 2, 'TTO-BUS-IN-02', '2026.09', 'published',
    'Trade meetings, negotiations, and short-term commercial activity in Trinidad and Tobago.',
    'Indian passport holders are visa-exempt for business visits — no visa is required for stays up to 90 days within any 180-day period, provided the applicant is not paid or compensated by a Trinidad and Tobago entity.',
    'Visa-free entry, up to 90 days within any 180-day period',
    'No visa application needed — complete the Online Arrival/Departure Card (ADC); carry a business invitation letter as a precaution',
    0,
    'No visa processing — immigration officers may question business travellers more closely than tourists and can request an invitation letter on arrival.',
    'Not applicable — visa-exempt entry; immigration clearance at Piarco (Trinidad) or ANR Robinson (Tobago) International Airport',
    'Confirm the visit is unpaid business activity (meetings/negotiations), not employment\nObtain an invitation letter from the Trinidad and Tobago host company as a precaution\nComplete the Online Arrival/Departure Card (ADC)\nCarry proof of your Indian employment and return travel\nPresent documents to the immigration officer on arrival',
    '/assets/images/visa-heroes/trinidad-and-tobago.webp',
    'Cross-checked against Wikipedia''s Visa policy of Trinidad and Tobago and visa-information secondary sourcing; foreign.gov.tt was blocked by network egress this session, so triangulated instead', 'https://foreign.gov.tt/services/visas/', '2026-09-17'
);
SET @tto2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tto2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tto2, 'Entry Documents', 'Required from every visa-exempt traveller.', 1);
SET @tto2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tto2s1, 'Valid Passport (6+ Months Validity, 1 Blank Page)', NULL, 'original', 1, 0, 1, 1),
(@tto2s1, 'Online Arrival/Departure Card (ADC) Receipt with QR Code', NULL, 'original', 1, 0, 1, 2),
(@tto2s1, 'Invitation Letter from Trinidad and Tobago Host Company', NULL, 'both', 0, 1, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tto2, 'Supporting Documents (If Requested by Immigration)', 'Evidence of your own employment and financial responsibility.', 2);
SET @tto2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tto2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 0, 1, 0, 1),
(@tto2s2, 'Proof of Business Registration/Purpose', NULL, 'copy', 0, 1, 0, 2),
(@tto2s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(179, 2, 0.00, 'USD', 'No Visa Fee — Visa-Exempt Entry', 'No visa fee applies for unpaid business visits up to 90 days. Important: if any compensation is paid by a Trinidad and Tobago-based organization for the visit — even unpaid missionary or volunteer work is treated the same as paid work under this rule — a visa is required instead of visa-free business entry.', '2026-09-01', NOW(), 'https://foreign.gov.tt/services/visas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I do paid work in Trinidad and Tobago on a visa-exempt business visit?', 'No — visa-exempt business entry only covers unpaid activity such as meetings and negotiations. Being compensated by a Trinidad and Tobago organization, or even doing unpaid missionary/volunteer work, requires a visa instead.', 179, 2, 17902, 1),
('Is a business invitation letter mandatory for visa-exempt entry?', 'It is not formally required to get an entry stamp, but carrying one from your Trinidad and Tobago host is recommended, since immigration officers can ask business travellers for evidence of their purpose.', 179, 2, 17903, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    179, 3, 'TTO-STU-IN-03', '2026.09', 'published',
    'Enrolling as a full-time student at a Trinidad and Tobago university or institution.',
    'Indian nationals require a student visa for study in Trinidad and Tobago, since study falls outside the 90-day visa-exempt window. Apply at the High Commission for the Republic of Trinidad and Tobago, New Delhi — the only Trinidadian mission in India.',
    'Tied to the academic program; renewable for the course duration',
    'Apply directly at the High Commission for the Republic of Trinidad and Tobago, New Delhi',
    1,
    'Processing time not consistently confirmed this session; apply well ahead of the academic term start date.',
    'High Commission for the Republic of Trinidad and Tobago, New Delhi (also accredited to Japan and Singapore)',
    'Secure admission at a recognized Trinidad and Tobago institution (e.g. UWI St. Augustine, UTT)\nCheck whether your institution also requires a separate Student Permit from the Immigration Division\nGather proof of funds, accommodation, and academic records\nBook an appointment and apply in person at the High Commission, New Delhi\nCollect the visa and travel; register with the institution''s International Office on arrival',
    '/assets/images/visa-heroes/trinidad-and-tobago.webp',
    'Cross-checked against UWI St. Augustine admissions/immigration pages and visa-information secondary sourcing; foreign.gov.tt was blocked by network egress this session, so triangulated instead', 'https://foreign.gov.tt/services/visas/', '2026-09-17'
);
SET @tto3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tto3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tto3, 'Core Documents', 'Required from every applicant.', 1);
SET @tto3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tto3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@tto3s1, 'Admission/Acceptance Letter from Trinidad and Tobago Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tto3, 'Supporting Documents', 'Evidence of academic background, funds, and character.', 2);
SET @tto3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tto3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@tto3s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2),
(@tto3s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 3),
(@tto3s2, 'Student Permit Application (Immigration Division)', 'Only if your institution requires a Student Permit in addition to the visa.', 'if_applicable', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(179, 3, NULL, 'USD', 'Confirmed After Assessment', 'Student visa fee was not independently confirmed this session; confirm the current figure directly with the High Commission, New Delhi, before applying.', '2026-09-01', NOW(), 'https://foreign.gov.tt/services/visas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do full-time UWI students need a separate Student Permit as well as a visa?', 'Registered full-time students at UWI St. Augustine are generally exempt from the separate Student Permit requirement, but Indian nationals still need an entry visa since study falls outside the 90-day visa-exempt window — confirm both requirements with your institution and the High Commission.', 179, 3, 17904, 1),
('Where do Indian students apply for a Trinidad and Tobago student visa?', 'At the High Commission for the Republic of Trinidad and Tobago in New Delhi — the only Trinidadian diplomatic mission in India, which also covers Japan and Singapore.', 179, 3, 17905, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Work Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    179, 4, 'TTO-WORK-IN-04', '2026.09', 'published',
    'Employment with a Trinidad and Tobago employer under a Work Permit.',
    'Indian nationals with a confirmed job offer; the employer must generally show no suitably qualified local or CARICOM national is available, then apply for the Work Permit entirely online via the Work Permit Unit before the employee applies for an entry visa.',
    'Work Permits typically issued up to 3 years, renewable while employment continues',
    'Employer-driven; Work Permit applications are processed online only via the Work Permit Unit',
    1,
    'Work Permit processing commonly reported at around 2-3 months; stays of 30 days or less within a 12-month period do not require a Work Permit.',
    'Work Permit Unit, Immigration Division; entry visa via the High Commission, New Delhi',
    'Secure a job offer from a Trinidad and Tobago employer\nEmployer documents local/CARICOM recruitment efforts and submits the Work Permit application online\nApplicant submits qualifications, police clearance, and medical reports as requested\nOnce the Work Permit is approved, apply for the corresponding entry visa at the High Commission, New Delhi\nTravel and register with authorities as required on arrival',
    '/assets/images/visa-heroes/trinidad-and-tobago.webp',
    'Cross-checked against Ministry of Homeland Security/national-security Work Permit guidance and expatriate-employment secondary sourcing; foreign.gov.tt and nationalsecurity.gov.tt were blocked by network egress this session', 'https://foreign.gov.tt/services/visas/', '2026-09-17'
);
SET @tto4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tto4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tto4, 'Core Documents', 'Required from every applicant.', 1);
SET @tto4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tto4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@tto4s1, 'Employment Contract/Job Offer Letter', NULL, 'copy', 1, 0, 1, 2),
(@tto4s1, 'Online Work Permit Approval', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tto4, 'Supporting Documents', 'Additional applicant and employer-side evidence.', 2);
SET @tto4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tto4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@tto4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2),
(@tto4s2, 'Medical Report', NULL, 'if_applicable', 0, 1, 0, 3),
(@tto4s2, 'Proof of Employer''s Local Recruitment Effort', NULL, 'copy', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(179, 4, NULL, 'USD', 'Confirmed After Assessment', 'Reported figures vary widely across sources — from roughly TTD 1,000-2,000 (about USD 150-300) for shorter-tier permits, up to a cited "standard" 2025 fee of around USD 1,770 — so treat any figure as approximate and confirm the current schedule with the Work Permit Unit before applying.', '2026-09-01', NOW(), 'https://foreign.gov.tt/services/visas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a way to work in Trinidad and Tobago without a Work Permit?', 'Short visits of 30 days or less within any 12-month period do not require a Work Permit, but this is a narrow exception — most employment, including longer assignments, needs one.', 179, 4, 17906, 1),
('Can a Work Permit application be submitted on paper?', 'No — Trinidad and Tobago processes individual Work Permit applications and extensions exclusively online through the Work Permit Unit; there is no paper-based route.', 179, 4, 17907, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Visa-Exempt Entry
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    179, 5, 'TTO-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives resident in Trinidad and Tobago, including the country''s large Indo-Trinidadian community.',
    'Indian passport holders are visa-exempt for family/social visits — no visa is required for stays up to 90 days within any 180-day period. Many such visits connect Indian nationals to relatives descended from 19th/20th-century Indian indentured migrants, who today make up roughly 35-40% of the population.',
    'Visa-free entry, up to 90 days within any 180-day period',
    'No visa application needed — complete the Online Arrival/Departure Card (ADC); carry proof of the relationship and host details',
    0,
    'No visa processing — immigration officers may ask about the purpose of the visit and your relationship to your host on arrival.',
    'Not applicable — visa-exempt entry; immigration clearance at Piarco (Trinidad) or ANR Robinson (Tobago) International Airport',
    'Confirm the visit is unpaid and social/family in nature\nGather proof of your relationship to your Trinidad and Tobago-based host\nComplete the Online Arrival/Departure Card (ADC)\nCarry your host''s contact details and address\nPresent documents to the immigration officer on arrival',
    '/assets/images/visa-heroes/trinidad-and-tobago.webp',
    'Cross-checked against Wikipedia''s Visa policy of Trinidad and Tobago and Indo-Trinidadian demographic sourcing; foreign.gov.tt was blocked by network egress this session, so triangulated instead', 'https://foreign.gov.tt/services/visas/', '2026-09-17'
);
SET @tto5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tto5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tto5, 'Entry Documents', 'Required from every visa-exempt traveller.', 1);
SET @tto5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tto5s1, 'Valid Passport (6+ Months Validity, 1 Blank Page)', NULL, 'original', 1, 0, 1, 1),
(@tto5s1, 'Online Arrival/Departure Card (ADC) Receipt with QR Code', NULL, 'original', 1, 0, 1, 2),
(@tto5s1, 'Proof of Relationship to Host (Birth/Marriage Certificate or Equivalent)', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tto5, 'Supporting Documents (If Requested by Immigration)', 'Additional evidence of your host and travel plans.', 2);
SET @tto5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tto5s2, 'Host''s Invitation Letter/Contact Details', NULL, 'copy', 0, 1, 0, 1),
(@tto5s2, 'Return/Onward Flight Ticket', NULL, 'copy', 0, 1, 0, 2),
(@tto5s2, 'Proof of Funds', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(179, 5, 0.00, 'USD', 'No Visa Fee — Visa-Exempt Entry', 'Indian nationals pay no visa fee for family/social visits because no visa is required for stays up to 90 days.', '2026-09-01', NOW(), 'https://foreign.gov.tt/services/visas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Why is Trinidad and Tobago a common Family Visit destination for Indian nationals?', 'Trinidad and Tobago has one of the largest Indian diaspora populations outside India — Indo-Trinidadians made up roughly 35-40% of the population per the 2011 census, descended from Indian indentured laborers brought by the British beginning 30 May 1845 (now marked annually as Indian Arrival Day) — so many Indian nationals travel to visit extended family there.', 179, 5, 17908, 1),
('Do I need proof of my relationship even though no visa is required?', 'It is not a formal visa document since none is needed, but carrying proof of the relationship and your host''s details is strongly recommended, since immigration officers can ask about the purpose of a family visit on arrival.', 179, 5, 17909, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — No Separate Category for Indian Nationals
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    179, 6, 'TTO-TRAN-IN-06', '2026.09', 'published',
    'Passing through a Trinidad and Tobago airport en route to an onward destination.',
    'Trinidad and Tobago has no separate transit-visa category confirmed for Indian passport holders. A pure airside connection needs no visa, and any immigration clearance during a layover falls under the same visa-exempt terms as a short visit, up to 90 days.',
    'Duration of the connection; if immigration clearance is required, the general 90-day visa-exempt allowance applies',
    'No separate transit visa application — confirm with your airline whether your routing requires immigration clearance',
    0,
    'Not independently confirmed this session whether any nationality-specific transit category exists beyond general visa-exempt entry; confirm with your airline and the High Commission.',
    'Not applicable for airside transit; immigration clearance at Piarco (Trinidad) or ANR Robinson (Tobago) International Airport if required',
    'Check your itinerary to see if you clear immigration during the connection or remain airside\nIf clearing immigration, complete the Online Arrival/Departure Card (ADC) like any other entrant\nCarry your onward ticket and passport\nCarry proof of a visa for your final destination if one is required there\nProceed through security/immigration as instructed by airport staff',
    '/assets/images/visa-heroes/trinidad-and-tobago.webp',
    'Cross-checked against Wikipedia''s Visa policy of Trinidad and Tobago and airport/travel-agency secondary sourcing; foreign.gov.tt was blocked by network egress this session, so triangulated instead', 'https://foreign.gov.tt/services/visas/', '2026-09-17'
);
SET @tto6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tto6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tto6, 'Core Documents', 'Required for every connection.', 1);
SET @tto6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tto6s1, 'Valid Passport (6+ Months Validity, 1 Blank Page)', NULL, 'original', 1, 0, 1, 1),
(@tto6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2),
(@tto6s1, 'Online Arrival/Departure Card (ADC) Receipt', 'Only if your connection requires you to clear immigration.', 'if_applicable', 0, 1, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tto6, 'Supporting Documents', 'Evidence for the destination beyond Trinidad and Tobago.', 2);
SET @tto6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tto6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(179, 6, 0.00, 'USD', 'No Separate Transit Visa Fee', 'No distinct transit-visa fee applies to Indian passport holders since there is no separate transit-visa category; if immigration clearance is needed during a layover, it is treated as ordinary visa-exempt entry, which is also free.', '2026-09-01', NOW(), 'https://foreign.gov.tt/services/visas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian passport holders need a transit visa for Trinidad and Tobago?', 'No separate transit-visa category was confirmed for Indian nationals. A pure airside connection needs no visa; if you must clear immigration during your layover, that is covered by the same visa-exempt terms as a short visit.', 179, 6, 17910, 1),
('Should I still complete the Online Arrival/Departure Card if I''m only transiting?', 'Only if your connection requires you to clear immigration — pure airside transit passengers generally do not need to complete the ADC, but confirm with your airline since routings vary.', 179, 6, 17911, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Visa-Exempt for Short-Term Treatment
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    179, 7, 'TTO-MED-IN-07', '2026.09', 'published',
    'Travel to Trinidad and Tobago for medical treatment.',
    'Indian passport holders are visa-exempt for genuine short-term medical visits — no visa is required for stays up to 90 days within any 180-day period, provided the applicant is not paid or compensated by a Trinidad and Tobago entity; longer treatment courses may require a visa.',
    'Visa-free entry, up to 90 days within any 180-day period; longer treatment may require a visa',
    'No visa application needed for stays up to 90 days — complete the Online Arrival/Departure Card (ADC)',
    0,
    'No visa processing for the standard 90-day window; treatment expected to run longer should be confirmed with the High Commission, New Delhi in advance.',
    'Not applicable for stays under 90 days; High Commission for the Republic of Trinidad and Tobago, New Delhi for longer treatment courses',
    'Obtain a letter/appointment confirmation from the treating Trinidad and Tobago doctor or hospital\nConfirm your expected treatment duration fits within 90 days\nComplete the Online Arrival/Departure Card (ADC)\nCarry medical records and proof of funds for treatment\nPresent documents to the immigration officer on arrival',
    '/assets/images/visa-heroes/trinidad-and-tobago.webp',
    'Cross-checked against Wikipedia''s Visa policy of Trinidad and Tobago and visa-information secondary sourcing; foreign.gov.tt was blocked by network egress this session, so triangulated instead', 'https://foreign.gov.tt/services/visas/', '2026-09-17'
);
SET @tto7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tto7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tto7, 'Entry Documents', 'Required from every visa-exempt medical traveller.', 1);
SET @tto7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tto7s1, 'Valid Passport (6+ Months Validity, 1 Blank Page)', NULL, 'original', 1, 0, 1, 1),
(@tto7s1, 'Medical Appointment/Hospital Confirmation Letter', NULL, 'original', 1, 0, 1, 2),
(@tto7s1, 'Online Arrival/Departure Card (ADC) Receipt', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tto7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @tto7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tto7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@tto7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2),
(@tto7s2, 'Travel/Medical Insurance', NULL, 'if_applicable', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(179, 7, 0.00, 'USD', 'No Visa Fee for Stays Under 90 Days', 'Indian nationals pay no visa fee for medical visits within the 90-day visa-exempt window; treatment expected to run longer requires a visa and should be discussed with the High Commission in advance.', '2026-09-01', NOW(), 'https://foreign.gov.tt/services/visas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa for a short medical trip to Trinidad and Tobago?', 'No — Indian passport holders are visa-exempt for medical visits of up to 90 days within any 180-day period, the same as tourism, provided you are not paid by a Trinidad and Tobago entity.', 179, 7, 17912, 1),
('What if my treatment needs longer than 90 days?', 'You would need to apply for a visa in advance — contact the High Commission for the Republic of Trinidad and Tobago, New Delhi, since this falls outside the standard visa-exempt window.', 179, 7, 17913, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Visa-Exempt Entry
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    179, 8, 'TTO-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, seminars, and trade events in Trinidad and Tobago.',
    'Indian passport holders are visa-exempt for conference attendance as a form of business/visit travel — no visa is required for stays up to 90 days within any 180-day period, provided the applicant is not paid or compensated by a Trinidad and Tobago-based organizer.',
    'Visa-free entry, up to 90 days within any 180-day period',
    'No visa application needed — complete the Online Arrival/Departure Card (ADC); carry your conference invitation/registration',
    0,
    'No visa processing — carrying conference documentation helps if an immigration officer questions the purpose of travel.',
    'Not applicable — visa-exempt entry; immigration clearance at Piarco (Trinidad) or ANR Robinson (Tobago) International Airport',
    'Obtain a conference invitation or registration confirmation\nConfirm you are not being paid a fee/honorarium by a Trinidad and Tobago organizer (this can require a visa instead)\nComplete the Online Arrival/Departure Card (ADC)\nCarry proof of accommodation and return travel\nPresent documents to the immigration officer on arrival',
    '/assets/images/visa-heroes/trinidad-and-tobago.webp',
    'Cross-checked against Wikipedia''s Visa policy of Trinidad and Tobago and visa-information secondary sourcing; foreign.gov.tt was blocked by network egress this session, so triangulated instead', 'https://foreign.gov.tt/services/visas/', '2026-09-17'
);
SET @tto8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tto8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tto8, 'Entry Documents', 'Required from every visa-exempt conference traveller.', 1);
SET @tto8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tto8s1, 'Valid Passport (6+ Months Validity, 1 Blank Page)', NULL, 'original', 1, 0, 1, 1),
(@tto8s1, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 2),
(@tto8s1, 'Online Arrival/Departure Card (ADC) Receipt', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tto8, 'Supporting Documents', 'Additional employer-side and financial evidence.', 2);
SET @tto8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tto8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@tto8s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(179, 8, 0.00, 'USD', 'No Visa Fee — Visa-Exempt Entry', 'No visa fee applies for unpaid conference attendance up to 90 days. Receiving a fee/honorarium from a Trinidad and Tobago-based organizer generally takes the visit outside this exemption and requires a visa instead.', '2026-09-01', NOW(), 'https://foreign.gov.tt/services/visas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I receive a speaking fee at a Trinidad and Tobago conference without a visa?', 'Being compensated by a Trinidad and Tobago-based organizer generally takes the visit outside the visa-exempt "business/visit" category — clarify your compensation arrangement in advance, as it may require a visa instead.', 179, 8, 17914, 1),
('Is Conference travel treated differently from Business travel?', 'Not distinctly — conference attendance is treated as a form of unpaid business/visit travel under the same 90-day visa-exempt allowance as standard Business visas.', 179, 8, 17915, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Visa-Exempt for Unpaid Participation
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    179, 9, 'TTO-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing or officiating in Trinidad and Tobago.',
    'Indian passport holders are visa-exempt for participating in sporting events as unpaid visitors — no visa is required for stays up to 90 days within any 180-day period, provided the applicant is not paid or compensated by a Trinidad and Tobago-based club or organizer.',
    'Visa-free entry, up to 90 days within any 180-day period',
    'No visa application needed — complete the Online Arrival/Departure Card (ADC); carry event/association documentation',
    0,
    'No visa processing — carrying event documentation helps if an immigration officer questions the purpose of travel; paid/professional engagements may require a visa or Work Permit instead.',
    'Not applicable — visa-exempt entry; immigration clearance at Piarco (Trinidad) or ANR Robinson (Tobago) International Airport',
    'Obtain a letter from your home-country sports association confirming your role\nObtain an invitation letter from the host event organizer\nConfirm you are not being paid by a Trinidad and Tobago-based club/organizer (this can require a visa or Work Permit instead)\nComplete the Online Arrival/Departure Card (ADC)\nPresent documents to the immigration officer on arrival',
    '/assets/images/visa-heroes/trinidad-and-tobago.webp',
    'Cross-checked against Wikipedia''s Visa policy of Trinidad and Tobago and visa-information secondary sourcing; foreign.gov.tt was blocked by network egress this session, so triangulated instead', 'https://foreign.gov.tt/services/visas/', '2026-09-17'
);
SET @tto9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tto9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tto9, 'Entry Documents', 'Required from every visa-exempt sports traveller.', 1);
SET @tto9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tto9s1, 'Valid Passport (6+ Months Validity, 1 Blank Page)', NULL, 'original', 1, 0, 1, 1),
(@tto9s1, 'Home-Country Sports Association Letter', 'Confirms role and unpaid/no-employment status.', 'original', 1, 0, 1, 2),
(@tto9s1, 'Host Event Organizer Invitation Letter', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tto9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @tto9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tto9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1),
(@tto9s2, 'Online Arrival/Departure Card (ADC) Receipt', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(179, 9, 0.00, 'USD', 'No Visa Fee — Visa-Exempt Entry', 'No visa fee applies for unpaid participation in sporting events up to 90 days. Being paid or compensated by a Trinidad and Tobago-based club or organizer generally requires a visa or Work Permit instead.', '2026-09-01', NOW(), 'https://foreign.gov.tt/services/visas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do professional athletes need a Work Permit instead of visa-exempt entry?', 'If you are being paid or compensated by a Trinidad and Tobago-based club or organizer, that generally falls outside the unpaid visa-exempt visit category and may require a visa or Work Permit — confirm your specific arrangement before travel.', 179, 9, 17916, 1),
('What documents should Indian sports delegations carry even though no visa is required?', 'A letter from your home-country sports association plus an invitation from the host event organizer, since immigration officers can ask sports travellers to confirm their unpaid status and purpose.', 179, 9, 17917, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Family Reunification / Residence
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    179, 10, 'TTO-DEP-IN-10', '2026.09', 'published',
    'Spouse, minor/dependent child, or parent/grandparent joining a Trinidad and Tobago citizen or resident sponsor.',
    'Family reunification is governed by Section 6 of the Immigration Act, covering the spouse of a citizen/resident, the parent or grandparent of a citizen/resident (if the sponsor can support them), and the dependent minor child of a citizen/resident — relevant to Indian nationals joining relatives within Trinidad and Tobago''s large Indo-Trinidadian community.',
    'Tied to the residence category granted; no fixed validity confirmed this session',
    'Apply via the High Commission, New Delhi for entry; residence status via the Immigration Division, Ministry of Homeland Security',
    1,
    'No officially guaranteed timeframe is published — decisions commonly take several months and remain at the discretion of the Minister responsible for immigration.',
    'High Commission for the Republic of Trinidad and Tobago, New Delhi (entry visa); Immigration Division, Ministry of Homeland Security (residence status)',
    'Confirm the sponsor''s citizen/resident status and category (spouse, parent/grandparent, or dependent minor child)\nGather relationship proof (marriage/birth certificates) and the sponsor''s status documents\nApply for the appropriate entry visa at the High Commission, New Delhi\nSubmit the residence application to the Immigration Division on arrival, including a police certificate of good character\nAwait the Minister''s decision, which can take several months with no guaranteed timeframe',
    '/assets/images/visa-heroes/trinidad-and-tobago.webp',
    'Cross-checked against Immigration Act Section 6 family-reunification secondary sourcing and Indo-Trinidadian demographic sourcing; foreign.gov.tt and homelandsecurity.gov.tt were blocked by network egress this session', 'https://foreign.gov.tt/services/visas/', '2026-09-17'
);
SET @tto10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@tto10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tto10, 'Core Documents', 'Required from every applicant.', 1);
SET @tto10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tto10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@tto10s1, 'Proof of Relationship to Sponsor (Marriage/Birth Certificate)', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@tto10, 'Supporting Documents', 'Evidence tied to the sponsor''s status and character checks.', 2);
SET @tto10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@tto10s2, 'Sponsor''s Citizenship/Residence Proof', NULL, 'copy', 1, 0, 0, 1),
(@tto10s2, 'Police Certificate of Good Character', NULL, 'original', 1, 0, 0, 2),
(@tto10s2, 'Proof of Sponsor''s Ability to Support', 'Required for parent/grandparent sponsorship cases.', 'if_applicable', 0, 1, 0, 3),
(@tto10s2, 'Proof of Funds', NULL, 'copy', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(179, 10, NULL, 'USD', 'Confirmed After Assessment', 'Residence/family-reunification fees were not independently confirmed this session; confirm the current schedule with the Immigration Division or the High Commission, New Delhi.', '2026-09-01', NOW(), 'https://foreign.gov.tt/services/visas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Who can sponsor a family member for residence in Trinidad and Tobago?', 'Under Section 6 of the Immigration Act, a citizen or resident can sponsor their spouse, their dependent minor child, or their parent or grandparent if willing and able to provide care and maintenance.', 179, 10, 17918, 1),
('Why is Dependent/family reunification especially relevant for Indian nationals and Trinidad and Tobago?', 'Trinidad and Tobago has one of the world''s largest Indian diaspora populations outside India — roughly 35-40% Indo-Trinidadian, tracing back to indentured migrants from the Bhojpur and Awadh regions from 1845 onward — so genuine family ties spanning India and Trinidad and Tobago are common.', 179, 10, 17919, 1);
