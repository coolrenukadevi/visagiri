-- Serbia Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search. hero_image_url left NULL at
-- authoring time (no photo bundle supplied yet for this batch).
--
-- IMPORTANT SOURCING CAVEAT: Serbia's own government domains
-- (newdelhi.mfa.gov.rs, mfa.gov.rs, mup.gov.rs, welcometoserbia.gov.rs)
-- and the Indian Embassy in Belgrade (eoibelgrade.gov.in) were all
-- blocked by the network egress proxy this session and could not be
-- fetched directly. All findings below are triangulated from
-- WebSearch results only (secondary sourcing: immigration-law-firm
-- alerts, visa agencies, relocation consultancies, and news coverage
-- of Serbia's 2022 policy announcement). Fee/process figures should
-- be treated as approximate and reconfirmed with the Embassy of
-- Serbia, New Delhi, or the welcometoserbia.gov.rs eVisa portal
-- before an applicant relies on them. Conference (8) and Sports (9)
-- visa categories in particular were not found with Serbia-specific
-- documentary detail and are built from the general C-visa short-stay
-- framework plus standard invitation-letter logic used for Business/
-- Family Visit — flagged inline as NOT independently confirmed for
-- Serbia-specific nuance.
--
-- SERBIA'S REAL, DISTINCTIVE FACTS VERIFIED THIS SESSION:
--   - Serbia is NOT in the EU or Schengen Area. It runs its own
--     national visa regime (Type A airport transit, Type C short-stay,
--     Type D long-stay), separate from the Schengen system, even
--     though Serbia is an EU candidate country.
--   - GENUINELY DISTINCTIVE POLICY CHANGE: Indian nationals lost
--     visa-free access to Serbia effective 1 January 2023. Until then,
--     Indian passport holders could enter Serbia visa-free for up to
--     30 days — a route widely reported (per immigration-law-firm
--     alerts and Indian press coverage from December 2022) as having
--     been used as a Schengen-adjacent backdoor, prompting Serbia to
--     remove India from its visa-exempt list under EU pressure to
--     align its visa policy with the Schengen bloc's own India
--     requirements. This is exactly the kind of "periodically
--     tightened visa-free access under EU pressure" pattern flagged
--     in this task's brief. NOTE: several still-live secondary
--     sources (travel-insurance blogs, some agency pages) continue to
--     describe Indians as visa-free for 30 days — these appear to be
--     stale/outdated content that was not updated after the January
--     2023 change; the dated, sourced law-firm/press coverage from
--     December 2022 is treated as authoritative here.
--   - Genuine visa-free EXCEPTION that survived the 2023 tightening:
--     Indian passport holders already holding a valid Schengen Area,
--     UK, or US visa or residence permit can still enter Serbia
--     visa-free for up to 90 days in any 180-day period, provided
--     that visa/permit remains valid throughout the stay in Serbia.
--   - Two-tier fee/visa-type structure: Type C (short-stay, up to 90
--     days — tourist/business/family-visit/medical/conference/sports)
--     is reported at EUR 60, while Type D (long-stay — student/work/
--     dependent) is reported at EUR 30, plus a separate EUR 2 (~INR
--     200) visa-sticker fee applied to any granted visa regardless of
--     type. Minors under 6 are exempt from the visa fee itself but not
--     the sticker fee.
--   - Genuine 2026 reform on the work side: Serbia introduced a
--     unified residence-and-work permit ("Single Permit"), replacing
--     the formerly separate temporary residence permit and work
--     permit with one combined instrument, applied for by the
--     employer through the eVisa Portal — a genuine structural change
--     to how Indian nationals get authorized to work in Serbia.
--   - Family reunification in Serbia (the basis for the Dependent
--     category here) automatically confers the right to work in
--     Serbia for all adult family members granted a residence permit
--     on that basis — a genuinely distinctive rule, not universal
--     across the countries in this catalog.
--   - No special appointment system reported at the Embassy of Serbia,
--     New Delhi: passports are reportedly accepted in person every
--     working day except Friday, 11:00-13:00, with collection
--     4:00-5:00pm the same way — a walk-in model rather than a slotted
--     booking system (unlike VFS Global-routed Schengen countries).
--
-- country_id 145 = Serbia. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Type C Short-Stay National Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    145, 1, 'SRB-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to the Republic of Serbia.',
    'Indian passport holders generally require a Type C national visa since Serbia removed India from its visa-exempt list effective 1 January 2023 (Serbia is not in Schengen). Indians already holding a valid Schengen/UK/US visa or residence permit may instead enter visa-free for up to 90 days in 180.',
    'Single, double, or multiple entry, up to 90 days within any 180-day period',
    'Apply in person at the Embassy of Serbia, New Delhi (no VFS/outsourced centre reported); walk-in passport submission Mon-Thu, 11:00-13:00',
    1,
    'Standard decision period is reported as 15 calendar days from submission, extendable to a maximum of 30 days in special circumstances',
    'Embassy of the Republic of Serbia, New Delhi',
    'Check whether you already hold a valid Schengen/UK/US visa or residence permit (may allow visa-free entry instead)\nComplete the Serbian visa application form\nGather supporting documents\nSubmit the passport in person at the Embassy of Serbia, New Delhi (11:00-13:00, Mon-Thu)\nCollect the passport with visa (4:00-5:00pm) once processed',
    '/assets/images/visa-heroes/serbia.webp',
    'Triangulated from WebSearch results (immigration-law-firm alerts, visa-agency and travel guidance) — Serbia government domains (mfa.gov.rs, newdelhi.mfa.gov.rs) were blocked by the network egress proxy this session and could not be fetched directly', 'https://newdelhi.mfa.gov.rs/en/citizens/frequently-asked-questions', '2026-09-17'
);
SET @srb1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@srb1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@srb1, 'Core Documents', 'Required from every applicant.', 1);
SET @srb1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@srb1s1, 'Valid Passport (90+ Days Validity from Visa Issue)', NULL, 'original', 1, 0, 1, 1),
(@srb1s1, 'Completed Serbian Visa Application Form', NULL, 'copy', 1, 0, 1, 2),
(@srb1s1, 'Recent Passport-Size Photograph (3.5 x 4.5 cm)', NULL, 'original', 1, 0, 1, 3),
(@srb1s1, 'Travel/Medical Insurance (Valid for Serbia)', NULL, 'original', 1, 0, 1, 4);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@srb1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @srb1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@srb1s2, 'Return/Onward Flight Ticket or Itinerary', NULL, 'copy', 1, 0, 0, 1),
(@srb1s2, 'Confirmed Hotel Booking or Proof of Accommodation', NULL, 'copy', 1, 0, 0, 2),
(@srb1s2, 'Bank Statement (Last 6 Months, Min. ~EUR 50/Day of Stay)', NULL, 'copy', 1, 0, 0, 3),
(@srb1s2, 'Proof of Existing Schengen/UK/US Visa or Residence Permit', 'If relying on the visa-free exception instead of applying for a Serbian visa.', 'copy', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(145, 1, 60.00, 'EUR', 'Type C Short-Stay Visa Fee', 'Plus a separate ~EUR 2 (approx. INR 200) visa-sticker fee applied once the visa is granted. Minors under 6 are exempt from the visa fee itself but not the sticker fee. Payable in INR or EUR by bank transfer per secondary sourcing — confirm current accepted payment method with the Embassy.', '2026-09-01', NOW(), 'https://newdelhi.mfa.gov.rs/en/citizens/frequently-asked-questions', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indians still get visa-free entry to Serbia?', 'Not automatically. Serbia removed India from its visa-exempt list effective 1 January 2023. However, Indian passport holders who already hold a valid Schengen, UK, or US visa or residence permit can still enter Serbia visa-free for up to 90 days in any 180-day period.', 145, 1, 14500, 1),
('Is Serbia part of the Schengen Area?', 'No. Serbia is an EU candidate country but is not in the EU or Schengen Area, so it operates its own separate national visa system (Type A/C/D), not a Schengen visa.', 145, 1, 14501, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Type C Short-Stay National Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    145, 2, 'SRB-BUS-IN-02', '2026.09', 'published',
    'Trade negotiations, meetings, and commercial activity in Serbia.',
    'Indian nationals travelling for business, on the same Type C national visa as Tourist, differentiated by a company invitation letter from the Serbian host entity plus employer sponsorship documentation from India.',
    'Single, double, or multiple entry, up to 90 days within any 180-day period',
    'Apply in person at the Embassy of Serbia, New Delhi, with a business invitation letter',
    1,
    'Standard decision period is reported as 15 calendar days from submission, extendable to a maximum of 30 days',
    'Embassy of the Republic of Serbia, New Delhi',
    'Obtain an invitation letter from the Serbian host company\nGather Indian employer sponsorship/forwarding letter\nComplete the Serbian visa application form\nSubmit the passport and documents in person at the Embassy',
    '/assets/images/visa-heroes/serbia.webp',
    'Triangulated from WebSearch results (visa-agency and travel guidance); Serbia government domains were blocked by the network egress proxy this session', 'https://newdelhi.mfa.gov.rs/en/citizens/frequently-asked-questions', '2026-09-17'
);
SET @srb2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@srb2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@srb2, 'Core Documents', 'Required from every applicant.', 1);
SET @srb2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@srb2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@srb2s1, 'Invitation Letter from Serbian Host Company', NULL, 'original', 1, 0, 1, 2),
(@srb2s1, 'Travel/Medical Insurance (Valid for Serbia)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@srb2, 'Supporting Documents', 'Evidence of your own employment and financial responsibility.', 2);
SET @srb2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@srb2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@srb2s2, 'Business Registration/Company Profile Proof', NULL, 'copy', 0, 1, 0, 2),
(@srb2s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(145, 2, 60.00, 'EUR', 'Type C Short-Stay Visa Fee', 'Same fee structure as Tourist, plus the separate ~EUR 2 visa-sticker fee.', '2026-09-01', NOW(), 'https://newdelhi.mfa.gov.rs/en/citizens/frequently-asked-questions', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I use a Business visa for multiple entries into Serbia?', 'Multiple-entry Type C visas are reported as available for business applicants who can show a genuine ongoing commercial relationship with a Serbian host, subject to the standard 90-days-in-180 stay ceiling — confirm eligibility with the Embassy when applying.', 145, 2, 14502, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Type D Long-Stay National Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    145, 3, 'SRB-STU-IN-03', '2026.09', 'published',
    'Enrolling in a recognized Serbian university or educational institution.',
    'Indian nationals admitted to a recognized Serbian institution, requiring the Type D long-stay national visa for study, followed by conversion to a temporary residence permit for the duration of the program.',
    'Initial Type D visa validity tied to enrollment; converts to a temporary residence permit for the course duration',
    'Apply in person at the Embassy of Serbia, New Delhi, with proof of enrollment',
    1,
    'Standard decision period is reported as 15 calendar days from submission, extendable to a maximum of 30 days; residence-permit conversion in Serbia is a separate, additional step',
    'Embassy of the Republic of Serbia, New Delhi',
    'Secure an offer/admission letter from a recognized Serbian institution\nArrange proof of funds and health insurance valid in Serbia\nComplete the Serbian Type D visa application form\nSubmit the passport and documents in person at the Embassy\nAfter arrival, apply for a temporary residence permit for the study duration',
    '/assets/images/visa-heroes/serbia.webp',
    'Triangulated from WebSearch results (student-visa guides and Serbian government portal summaries); welcometoserbia.gov.rs was blocked by the network egress proxy this session', 'https://welcometoserbia.gov.rs/d-visa-purpose-of-stay-education', '2026-09-17'
);
SET @srb3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@srb3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@srb3, 'Core Documents', 'Required from every applicant.', 1);
SET @srb3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@srb3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@srb3s1, 'Admission/Enrollment Letter from Serbian Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@srb3, 'Supporting Documents', 'Evidence of your academic background, funds, and health cover.', 2);
SET @srb3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@srb3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@srb3s2, 'Proof of Funds for Tuition and Living Costs', NULL, 'copy', 1, 0, 0, 2),
(@srb3s2, 'Health/Travel Insurance (Min. ~EUR 20,000 Coverage)', NULL, 'original', 1, 0, 0, 3),
(@srb3s2, 'Police Clearance Certificate', 'May be required depending on course duration.', 'original', 0, 1, 0, 4),
(@srb3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 5);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(145, 3, 30.00, 'EUR', 'Type D Long-Stay Visa Fee', 'Plus the separate ~EUR 2 visa-sticker fee. A further, separately payable fee applies for the temporary residence permit once in Serbia — confirm current amount with the Embassy.', '2026-09-01', NOW(), 'https://welcometoserbia.gov.rs/d-visa-purpose-of-stay-education', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does the Student visa alone let me stay for my whole course?', 'No — the Type D visa is an entry document. After arriving in Serbia, students are generally required to separately apply for a temporary residence permit covering the full duration of their study program.', 145, 3, 14503, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Unified Residence-and-Work Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    145, 4, 'SRB-WORK-IN-04', '2026.09', 'published',
    'Employment with a Serbian employer under Serbia''s unified residence-and-work permit ("Single Permit").',
    'Indian nationals with a confirmed employment contract with a Serbian company; Serbia''s 2026 reform consolidated the previously separate temporary residence permit and work permit into one combined instrument, applied for by the employer through the eVisa Portal.',
    'Tied to the Single Permit validity, typically up to 1-3 years and renewable',
    'Employer-driven application via the eVisa Portal; applicant applies for the entry Type D visa at the Embassy of Serbia, New Delhi',
    1,
    'Reported to be faster than the former two-step process; exact combined timeline not independently confirmed this session — confirm with the Embassy or a licensed Serbian immigration agent',
    'Embassy of the Republic of Serbia, New Delhi (visa); Serbian Ministry of Interior/eVisa Portal (Single Permit decision)',
    'Secure a formal employment contract with a Serbian employer\nEmployer submits the Single Permit application via the eVisa Portal\nApply for the entry Type D visa at the Embassy of Serbia, New Delhi\nTravel to Serbia and complete any in-country registration once the Single Permit is issued',
    '/assets/images/visa-heroes/serbia.webp',
    'Triangulated from WebSearch results on Serbia''s 2026 unified permit reform (immigration-law-firm and relocation-consultancy guidance); official mup.gov.rs and welcometoserbia.gov.rs pages were blocked by the network egress proxy this session', 'https://welcometoserbia.gov.rs/residence-and-work-permit', '2026-09-17'
);
SET @srb4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@srb4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@srb4, 'Core Documents', 'Required from every applicant.', 1);
SET @srb4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@srb4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@srb4s1, 'Employment Contract with Serbian Employer', NULL, 'copy', 1, 0, 1, 2),
(@srb4s1, 'Single Permit Application Confirmation (Filed by Employer)', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@srb4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @srb4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@srb4s2, 'Academic/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@srb4s2, 'Health Insurance Valid in Serbia', NULL, 'original', 1, 0, 0, 2),
(@srb4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(145, 4, NULL, 'EUR', 'Confirmed After Assessment', 'The entry Type D visa fee is reported at EUR 30 plus the ~EUR 2 sticker fee, but the Single Permit itself carries its own separate administrative fee not consistently reported across sources — contact us to confirm the current combined cost.', '2026-09-01', NOW(), 'https://welcometoserbia.gov.rs/residence-and-work-permit', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What changed with Serbia''s work permit system in 2026?', 'Serbia introduced a unified "Single Permit" that combines the previously separate temporary residence permit and work permit into one document, applied for by the employer through the eVisa Portal — a genuine structural simplification versus the older two-step process.', 145, 4, 14504, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Type C Short-Stay National Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    145, 5, 'SRB-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives or friends resident in Serbia.',
    'Indian nationals with family or friends in Serbia, on the same Type C national visa as Tourist, requiring an invitation letter from the host in Serbia plus proof of the relationship.',
    'Up to 90 days within any 180-day period',
    'Apply in person at the Embassy of Serbia, New Delhi, with an invitation letter and relationship proof',
    1,
    'Standard decision period is reported as 15 calendar days from submission, extendable to a maximum of 30 days',
    'Embassy of the Republic of Serbia, New Delhi',
    'Obtain an invitation letter from your host in Serbia\nGather documents proving the family/personal relationship\nComplete the Serbian visa application form\nSubmit the passport and documents in person at the Embassy',
    '/assets/images/visa-heroes/serbia.webp',
    'Triangulated from WebSearch results (visa-agency and travel guidance); Serbia government domains were blocked by the network egress proxy this session', 'https://newdelhi.mfa.gov.rs/en/citizens/frequently-asked-questions', '2026-09-17'
);
SET @srb5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@srb5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@srb5, 'Core Documents', 'Required from every applicant.', 1);
SET @srb5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@srb5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@srb5s1, 'Invitation Letter from Host in Serbia', NULL, 'original', 1, 0, 1, 2),
(@srb5s1, 'Proof of Relationship', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@srb5, 'Supporting Documents', 'Evidence of your own means.', 2);
SET @srb5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@srb5s2, 'Bank Statement (Last 6 Months, Min. ~EUR 50/Day of Stay)', NULL, 'copy', 1, 0, 0, 1),
(@srb5s2, 'Travel/Medical Insurance (Valid for Serbia)', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(145, 5, 60.00, 'EUR', 'Type C Short-Stay Visa Fee', 'Same fee structure as Tourist, plus the separate ~EUR 2 visa-sticker fee.', '2026-09-01', NOW(), 'https://newdelhi.mfa.gov.rs/en/citizens/frequently-asked-questions', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does my host in Serbia need to be a Serbian citizen?', 'Not necessarily — the invitation letter can generally come from a host who is a Serbian citizen or a foreign national holding a valid Serbian residence permit; the key requirement is that the letter and relationship proof are genuine and verifiable.', 145, 5, 14505, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Type A Airport Transit / Type C Transit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    145, 6, 'SRB-TRAN-IN-06', '2026.09', 'published',
    'Passing through Serbia (e.g. Belgrade Nikola Tesla Airport) en route to a third country.',
    'Indian nationals remaining airside within the international transit zone do not need a visa. A visa is required only if leaving the transit zone or transiting overland, and an entry visa for the onward destination country is generally required to obtain it.',
    'Valid for the transit window only',
    'Apply in person at the Embassy of Serbia, New Delhi, only if genuinely required for your specific connection',
    1,
    'Standard decision period is reported as 15 calendar days from submission where a transit visa is genuinely required',
    'Embassy of the Republic of Serbia, New Delhi',
    'Confirm whether your specific connection requires a visa (airside-only international transit is visa-exempt)\nIf leaving the transit zone or transiting overland, obtain a valid visa for your onward destination first\nApply for the Serbian transit visa with your itinerary and onward-destination visa\nSubmit the passport and documents in person at the Embassy',
    '/assets/images/visa-heroes/serbia.webp',
    'Triangulated from WebSearch results on Serbia''s transit rules; Serbia government domains were blocked by the network egress proxy this session', 'https://www.mfa.gov.rs/en/citizens/travel-serbia/visa-requirements', '2026-09-17'
);
SET @srb6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@srb6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@srb6, 'Core Documents', 'Required if a Serbian transit visa is genuinely needed.', 1);
SET @srb6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@srb6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@srb6s1, 'Onward Flight Ticket/Itinerary', NULL, 'copy', 1, 0, 1, 2),
(@srb6s1, 'Valid Visa for Onward Destination Country', 'Generally required to obtain a Serbian transit visa.', 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@srb6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @srb6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@srb6s2, 'Travel/Medical Insurance (Valid for Serbia)', NULL, 'original', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(145, 6, NULL, 'EUR', 'Confirmed After Assessment', 'No transit-specific fee figure was independently confirmed this session; secondary sources suggest it may follow the standard Type C fee of EUR 60 plus the ~EUR 2 sticker fee — confirm with the Embassy before applying.', '2026-09-01', NOW(), 'https://www.mfa.gov.rs/en/citizens/travel-serbia/visa-requirements', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa if I never leave the airport in Serbia?', 'No — Indian nationals transiting through the international transit zone of a Serbian airport without leaving it are exempt from any visa requirement, regardless of the 2023 change to Serbia''s general visa-free list.', 145, 6, 14506, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Type C Short-Stay National Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    145, 7, 'SRB-MED-IN-07', '2026.09', 'published',
    'Travel to Serbia for medical treatment.',
    'Indian nationals travelling for treatment, on the same Type C national visa as Tourist, requiring a certificate from the treating Serbian doctor or institution confirming the need for specific treatment.',
    'Up to 90 days within any 180-day period',
    'Apply in person at the Embassy of Serbia, New Delhi, with the medical certificate and adequate insurance',
    1,
    'Standard decision period is reported as 15 calendar days from submission, extendable to a maximum of 30 days',
    'Embassy of the Republic of Serbia, New Delhi',
    'Obtain a certificate from the treating Serbian doctor/institution\nArrange travel/medical insurance covering the treatment period\nComplete the Serbian visa application form\nSubmit the passport and documents in person at the Embassy',
    '/assets/images/visa-heroes/serbia.webp',
    'Triangulated from WebSearch results (general Type C documentary framework applied to a medical purpose; Serbia-specific medical-visa nuance NOT independently confirmed this session); Serbia government domains were blocked by the network egress proxy', 'https://newdelhi.mfa.gov.rs/en/citizens/frequently-asked-questions', '2026-09-17'
);
SET @srb7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@srb7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@srb7, 'Core Documents', 'Required from every applicant.', 1);
SET @srb7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@srb7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@srb7s1, 'Medical Certificate/Institution Confirmation', NULL, 'original', 1, 0, 1, 2),
(@srb7s1, 'Travel/Medical Insurance (Valid for Serbia)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@srb7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @srb7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@srb7s2, 'Medical Records/Referral from India', NULL, 'copy', 1, 0, 0, 1),
(@srb7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2),
(@srb7s2, 'Attendant/Companion Documentation (If Applicable)', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(145, 7, 60.00, 'EUR', 'Type C Short-Stay Visa Fee (Approximate)', 'Serbia-specific medical-visa fee waivers, if any, NOT independently confirmed this session — applied here as the standard Type C fee plus the ~EUR 2 sticker fee.', '2026-09-01', NOW(), 'https://newdelhi.mfa.gov.rs/en/citizens/frequently-asked-questions', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Medical visa category in Serbia, distinct from Tourist?', 'Serbia''s national visa system does not appear to run a separately named "Medical" visa product distinct from the Type C short-stay visa; medical travellers apply for the standard Type C visa and support it with a treatment certificate. This was not independently confirmed against an official Serbian source this session.', 145, 7, 14507, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Type C Short-Stay National Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    145, 8, 'SRB-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, congresses, and trade fairs in Serbia.',
    'Indian nationals attending a conference, on the same Type C national visa as Tourist/Business, supported by a conference invitation or registration confirmation. Serbia-specific conference-visa nuance was NOT independently confirmed this session.',
    'Up to 90 days within any 180-day period',
    'Apply in person at the Embassy of Serbia, New Delhi, with a conference invitation/registration confirmation',
    1,
    'Standard decision period is reported as 15 calendar days from submission, extendable to a maximum of 30 days',
    'Embassy of the Republic of Serbia, New Delhi',
    'Obtain a conference invitation or registration confirmation from the organizer\nGather proof of accommodation and return travel\nComplete the Serbian visa application form\nSubmit the passport and documents in person at the Embassy',
    '/assets/images/visa-heroes/serbia.webp',
    'General Type C documentary framework applied to a conference purpose; Serbia-specific conference-visa nuance NOT independently confirmed this session — Serbia government domains were blocked by the network egress proxy', 'https://newdelhi.mfa.gov.rs/en/citizens/frequently-asked-questions', '2026-09-17'
);
SET @srb8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@srb8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@srb8, 'Core Documents', 'Required from every applicant.', 1);
SET @srb8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@srb8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@srb8s1, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@srb8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @srb8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@srb8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@srb8s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(145, 8, 60.00, 'EUR', 'Type C Short-Stay Visa Fee (Approximate)', 'No conference-specific fee variant was independently confirmed this session — applied here as the standard Type C fee plus the ~EUR 2 sticker fee.', '2026-09-01', NOW(), 'https://newdelhi.mfa.gov.rs/en/citizens/frequently-asked-questions', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Conference visa category in Serbia?', 'Serbia''s national visa system does not appear to run a separately named "Conference" visa product; conference attendees apply for the standard Type C visa supported by an invitation/registration document. This was not independently confirmed against an official Serbian source this session.', 145, 8, 14508, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Type C Short-Stay National Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    145, 9, 'SRB-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in Serbia.',
    'Indian nationals competing or officiating, on the same Type C national visa as Tourist/Conference, supported by a letter from the home-country sports association and an invitation from the host event organizer. Serbia-specific sports-visa nuance was NOT independently confirmed this session.',
    'Up to 90 days within any 180-day period',
    'Apply in person at the Embassy of Serbia, New Delhi, with a home-association letter and host-organizer invitation',
    1,
    'Standard decision period is reported as 15 calendar days from submission, extendable to a maximum of 30 days',
    'Embassy of the Republic of Serbia, New Delhi',
    'Obtain a letter from your home-country sports association confirming your role and no-employment status\nObtain an invitation letter from the host event organizer with event details\nComplete the Serbian visa application form\nSubmit the passport and documents in person at the Embassy',
    '/assets/images/visa-heroes/serbia.webp',
    'General Type C documentary framework applied to a sports purpose; Serbia-specific sports-visa nuance NOT independently confirmed this session — Serbia government domains were blocked by the network egress proxy', 'https://newdelhi.mfa.gov.rs/en/citizens/frequently-asked-questions', '2026-09-17'
);
SET @srb9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@srb9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@srb9, 'Core Documents', 'Required from every applicant.', 1);
SET @srb9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@srb9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@srb9s1, 'Home-Country Sports Association Letter', 'Confirms role and no-employment status.', 'original', 1, 0, 1, 2),
(@srb9s1, 'Host Event Organizer Invitation Letter', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@srb9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @srb9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@srb9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(145, 9, 60.00, 'EUR', 'Type C Short-Stay Visa Fee (Approximate)', 'No sports-event-specific fee variant was independently confirmed this session — applied here as the standard Type C fee plus the ~EUR 2 sticker fee.', '2026-09-01', NOW(), 'https://newdelhi.mfa.gov.rs/en/citizens/frequently-asked-questions', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Sports visa category in Serbia?', 'Serbia''s national visa system does not appear to run a separately named "Sports" visa product; athletes and officials apply for the standard Type C visa supported by association and organizer letters. This was not independently confirmed against an official Serbian source this session.', 145, 9, 14509, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Family Reunification Residence Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    145, 10, 'SRB-DEP-IN-10', '2026.09', 'published',
    'Spouse, minor/adopted children, or in justified cases other dependents joining an Indian national with a valid Serbian residence permit.',
    'Family members of an Indian national already holding a valid Serbian temporary or permanent residence permit (e.g. via the Work or Student category). The sponsor must show sufficient means and adequate registered accommodation for the family.',
    'Tied to the sponsor''s residence permit validity',
    'Apply in person at the Embassy of Serbia, New Delhi, for the entry Type D visa; family reunification permit filed in Serbia',
    1,
    'Standard Type D decision period is reported as 15 calendar days, extendable to 30; the family reunification residence-permit decision in Serbia is a separate, additional step not independently confirmed this session',
    'Embassy of the Republic of Serbia, New Delhi (visa); Serbian Ministry of Interior (residence permit)',
    'Confirm the sponsor holds a valid Serbian temporary/permanent residence permit\nGather relationship proof (marriage/birth certificates) and the sponsor''s permit copy\nApply for the entry Type D visa at the Embassy of Serbia, New Delhi\nTravel to Serbia and apply for the family reunification residence permit',
    '/assets/images/visa-heroes/serbia.webp',
    'Triangulated from WebSearch results on Serbia''s family reunification residence framework; official mup.gov.rs and welcometoserbia.gov.rs pages were blocked by the network egress proxy this session', 'https://welcometoserbia.gov.rs/family-reunification', '2026-09-17'
);
SET @srb10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@srb10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@srb10, 'Core Documents', 'Required from every applicant.', 1);
SET @srb10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@srb10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@srb10s1, 'Proof of Relationship to Sponsor', 'Marriage/birth certificate, apostilled/attested as required.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@srb10, 'Supporting Documents', 'Evidence tied to the sponsor''s residence permit and household.', 2);
SET @srb10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@srb10s2, 'Sponsor''s Serbian Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@srb10s2, 'Proof of Sponsor''s Sufficient Financial Means', NULL, 'copy', 1, 0, 0, 2),
(@srb10s2, 'Proof of Adequate Registered Accommodation in Serbia', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(145, 10, 30.00, 'EUR', 'Type D Long-Stay Visa Fee', 'Plus the separate ~EUR 2 visa-sticker fee, and a further, separately payable family-reunification residence-permit fee once in Serbia — exact residence-permit fee figure NOT independently confirmed this session.', '2026-09-01', NOW(), 'https://welcometoserbia.gov.rs/family-reunification', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can dependents work in Serbia once their residence permit is approved?', 'Yes — a Serbian residence permit granted on family reunification grounds automatically confers the right to work in Serbia for all adult family members covered by it, without needing a separate standalone work authorization.', 145, 10, 14510, 1);
