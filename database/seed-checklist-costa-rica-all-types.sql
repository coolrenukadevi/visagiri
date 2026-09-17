-- Costa Rica Visa Checklist Engine content for all 10 visa types —
-- built fresh this session via web search. hero_image_url left NULL at
-- authoring time (no photo bundle supplied yet for batch 6).
--
-- IMPORTANT SOURCING CAVEAT: Costa Rica's official immigration portal
-- (migracion.go.cr) and ticotimes.net were NOT directly fetchable this
-- session (network egress blocked to both domains, same as several
-- secondary sites: aglegal.com, passportsandvisas.com, visaindex.com).
-- Findings below were triangulated entirely from WebSearch result
-- summaries (Fragomen immigration-law alerts, El Financiero, Q Costa
-- Rica, Lexincorp, CRIE, BLP Legal, residency-law firm sites, and
-- generic visa-agency listings), not from a single authoritative
-- primary-source fetch. Fee figures conflict across sources ($30-$52)
-- and are flagged as approximate. Work-visa and Dependent/vínculo
-- processing times are ranges reported by immigration-law firms, not
-- DGME's own published SLA. Student visa two-step process (consular
-- visa, then DGME "Special Student Category" in-country) is
-- cross-checked across two independent embassy-PDF-derived summaries.
-- All 10 categories below have been filled with best-effort structure;
-- none are being skipped, but treat fee amounts and processing-day
-- figures as approximate pending direct confirmation with the Embassy
-- of Costa Rica, New Delhi before an applicant relies on them.
--
-- Costa Rica's real, distinctive facts (verified via multiple
-- cross-referenced search results this session):
--   - Costa Rica classifies all foreign nationalities into four visa
--     Groups. Group 1 is visa-exempt (stay recently extended from 90
--     to 180 days per a DGME directive published in Alcance No. 148 to
--     La Gaceta No. 216, dated November 17, 2025). Group 4 is
--     "Restricted Visa," requiring approval from Costa Rica's
--     Restricted Visa Commission before a consulate may even issue a
--     visa. INDIA SITS IN GROUP 3: "Consular Visa" — a standard visa
--     issued directly by a Costa Rican consulate (not requiring the
--     Restricted Visa Commission), reportedly valid 60 business days
--     from issuance for entry, authorizing an initial stay of up to 30
--     days, extendable to 90.
--   - Genuinely distinctive and dated: per a Fragomen immigration alert
--     (June 2023), India was explicitly added to the list of
--     nationalities that now require a Costa Rican Airport Transit
--     Visa even when merely connecting through a Costa Rican airport —
--     a requirement that reportedly did not previously apply to
--     transiting Indian nationals. This is a real, India-named policy
--     change, distinct from the general Group 3 consular visa.
--   - Costa Rica has only ONE Costa Rican diplomatic mission resident
--     in India: the Embassy of Costa Rica, New Delhi (Vasant Vihar) —
--     there is no separate consulate-general or VFS/BLS outsourced
--     visa centre network reported for India, unlike Costa Rica's
--     Schengen-style partner countries. All application channels below
--     route through this one embassy.
--   - Costa Rica does NOT issue a standalone "work visa" document —
--     work authorization is embedded inside a temporary-residence
--     category (residencia temporal por razones laborales) granted by
--     the DGME, and a first-time sponsoring employer must separately
--     register as an authorized hiring entity with the DGME before an
--     application can proceed. Reported processing commonly runs 3-8
--     months, materially longer than the short-stay consular visa.
--   - Family/Dependent immigration is built around a "vínculo familiar"
--     (family-bond) temporary residency category — covering spouse,
--     children under 18, and unmarried dependent adult children under
--     25 — rather than a Schengen-style "Dependent visa" stamp; it
--     leads to mandatory CCSS (public healthcare) enrollment and, after
--     3 years as a temporary resident, eligibility to apply for
--     permanent residency.
--
-- country_id 161 = Costa Rica. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Group 3 Consular Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    161, 1, 'CRI-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Costa Rica.',
    'Indian passport holders fall under Costa Rica''s Group 3 (Consular Visa) classification, requiring a standard visa issued directly by the Costa Rican consulate rather than the Restricted Visa Commission process used for Group 4 nationals.',
    'Up to 30 days on entry, reportedly extendable to 90 days',
    'Apply in person at the Embassy of Costa Rica, New Delhi — Costa Rica''s only resident mission in India, with no VFS/BLS outsourced network reported',
    1,
    'Reported around 30 calendar days; visa reportedly valid 60 business days from issuance for entry',
    'Embassy of Costa Rica, New Delhi (Vasant Vihar)',
    'Complete the consular visa application form\nGather supporting documents (photos, itinerary, proof of funds, insurance)\nBook an appointment at the Embassy of Costa Rica, New Delhi\nSubmit application and pay the consular fee\nCollect the passport with visa once approved',
    '/assets/images/visa-heroes/costa-rica.webp',
    'Triangulated from Fragomen immigration alerts, El Financiero, Q Costa Rica, and visa-agency secondary sourcing; migracion.go.cr and ticotimes.net were not directly fetchable this session', 'https://migracion.go.cr/visas/', '2026-09-17'
);
SET @cri1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cri1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cri1, 'Core Documents', 'Required from every applicant.', 1);
SET @cri1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cri1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cri1s1, 'Completed Consular Visa Application Form', NULL, 'original', 1, 0, 1, 2),
(@cri1s1, 'Two Recent Passport Photos (35x45mm, White Background)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cri1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @cri1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cri1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 1),
(@cri1s2, 'Confirmed Hotel Booking or Invitation Letter', NULL, 'copy', 1, 0, 0, 2),
(@cri1s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3),
(@cri1s2, 'Travel Health Insurance', NULL, 'copy', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(161, 1, 52.00, 'USD', 'Group 3 Consular Visa Fee (Approximate)', 'Sources report figures ranging $30-$52 for the consular visa fee; treat as approximate and confirm the current amount with the Embassy of Costa Rica, New Delhi before applying.', '2026-09-01', NOW(), 'https://migracion.go.cr/visas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does India need a visa to visit Costa Rica?', 'Yes. India sits in Costa Rica''s Group 3 ("Consular Visa") classification, so a visa must be obtained in advance from the Embassy of Costa Rica, New Delhi — India is not on Costa Rica''s visa-exempt Group 1 list.', 161, 1, 16100, 1),
('How long can I stay in Costa Rica on a Tourist visa?', 'The consular visa reportedly authorizes an initial stay of up to 30 days, extendable to 90 days, though the visa document itself is typically valid 60 business days from issuance for entering the country. Confirm current terms with the embassy.', 161, 1, 16101, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Group 3 Consular Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    161, 2, 'CRI-BUS-IN-02', '2026.09', 'published',
    'Trade, negotiations, and commercial meetings in Costa Rica.',
    'Indian nationals travelling for business use the same Group 3 Consular Visa as Tourist, with a company invitation letter and employer sponsorship as the differentiating documents.',
    'Up to 30 days on entry, reportedly extendable to 90 days',
    'Apply in person at the Embassy of Costa Rica, New Delhi with a business invitation letter and employer sponsorship letter',
    1,
    'Reported around 30 calendar days',
    'Embassy of Costa Rica, New Delhi (Vasant Vihar)',
    'Obtain an invitation letter from the Costa Rican host company\nGather forwarding/sponsorship letter from your Indian employer\nComplete the consular visa application form\nSubmit documents at the Embassy of Costa Rica, New Delhi\nCollect the passport with visa once approved',
    '/assets/images/visa-heroes/costa-rica.webp',
    'Triangulated from visa-agency secondary sourcing on Costa Rica''s Group 3 consular visa process; migracion.go.cr not directly fetchable this session', 'https://migracion.go.cr/visas/', '2026-09-17'
);
SET @cri2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cri2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cri2, 'Core Documents', 'Required from every applicant.', 1);
SET @cri2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cri2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cri2s1, 'Invitation Letter from Costa Rican Host Company', NULL, 'original', 1, 0, 1, 2),
(@cri2s1, 'Completed Consular Visa Application Form', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cri2, 'Supporting Documents', 'Evidence of your own employment and financial responsibility.', 2);
SET @cri2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cri2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@cri2s2, 'Business Registration Proof', NULL, 'copy', 0, 1, 0, 2),
(@cri2s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(161, 2, 52.00, 'USD', 'Group 3 Consular Visa Fee (Approximate)', 'Same fee structure as Tourist; sources report a $30-$52 range, so confirm the current amount with the embassy.', '2026-09-01', NOW(), 'https://migracion.go.cr/visas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Business visa process different from Tourist for India?', 'No — both use the same Group 3 Consular Visa. The main difference is documentary: a Business applicant adds a host-company invitation letter and an Indian employer sponsorship letter.', 161, 2, 16102, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Consular Visa + DGME Special Student Category
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    161, 3, 'CRI-STU-IN-03', '2026.09', 'published',
    'Enrolling in a Costa Rican university or educational institution.',
    'Indian nationals admitted to a recognized Costa Rican institution follow a genuinely two-step process: a temporary student consular visa issued in India, followed by an in-country application to the DGME for the "Special Student Category" residence permit.',
    'Initial consular visa for entry; residence permit (cédula) tied to the program duration once processed by DGME',
    'Apply at the Embassy of Costa Rica, New Delhi for the initial visa; the Special Student Category is then processed separately at DGME after arrival',
    1,
    'Consular visa stage reported around 30 calendar days; the in-country DGME residence step runs on a separate, additional timeline',
    'Embassy of Costa Rica, New Delhi (Vasant Vihar); Dirección General de Migración y Extranjería in Costa Rica for the in-country step',
    'Secure admission at a recognized Costa Rican institution\nGather proof of funds, health insurance, and a police clearance certificate\nApply for the temporary student visa at the Embassy of Costa Rica, New Delhi\nTravel to Costa Rica and, once there, submit a notarized letter to the DGME requesting the Special Student Category\nObtain the residence card (cédula) from DGME',
    '/assets/images/visa-heroes/costa-rica.webp',
    'Cross-checked across two independent embassy-published requirement summaries describing the two-step consular-visa-then-DGME process; migracion.go.cr not directly fetchable this session', 'https://migracion.go.cr/visas/', '2026-09-17'
);
SET @cri3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cri3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cri3, 'Core Documents', 'Required from every applicant.', 1);
SET @cri3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cri3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cri3s1, 'Letter of Acceptance from Costa Rican Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cri3, 'Supporting Documents', 'Evidence of your academic background, funds, and health cover.', 2);
SET @cri3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cri3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@cri3s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2),
(@cri3s2, 'Health Insurance Valid in Costa Rica', NULL, 'original', 1, 0, 0, 3),
(@cri3s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 4),
(@cri3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 5);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cri3, 'In-Country DGME Step', 'Additional documents needed after arrival to obtain the Special Student Category residence permit.', 3);
SET @cri3s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cri3s3, 'Notarized Letter Requesting Special Student Category', 'Submitted to DGME after arrival in Costa Rica.', 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(161, 3, NULL, 'USD', 'Confirmed After Assessment', 'The consular visa stage and the subsequent DGME residence-permit stage carry separate fees; sources did not consistently break these out, so confirm the current combined cost with the embassy.', '2026-09-01', NOW(), 'https://migracion.go.cr/visas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is one visa enough to study in Costa Rica, or do I need to do anything after arriving?', 'The consular visa from New Delhi is only the entry step. After arrival, students must separately apply to the DGME for the "Special Student Category" residence permit to remain enrolled legally for the program duration.', 161, 3, 16103, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Temporary Residence for Labor Reasons
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    161, 4, 'CRI-WORK-IN-04', '2026.09', 'published',
    'Employment with a Costa Rican employer via DGME-authorized temporary residence for labor reasons.',
    'Costa Rica does not issue a standalone "work visa" document — work authorization is embedded in a DGME temporary-residence category. A first-time sponsoring employer must separately register with the DGME as an authorized hiring entity before an application can proceed.',
    'Temporary residence typically issued for 1 year initially, renewable',
    'Employer-driven DGME application in Costa Rica; the applicant then obtains an entry visa/authorization at the Embassy of Costa Rica, New Delhi',
    1,
    'Reported commonly 3-8 months, materially longer than the short-stay consular visa, due to labor-market checks',
    'Dirección General de Migración y Extranjería (DGME), Costa Rica (decision authority); Embassy of Costa Rica, New Delhi for the entry authorization',
    'Secure a job offer from a Costa Rican employer\nEmployer registers as an authorized hiring entity with DGME (if a first-time sponsor)\nEmployer files the temporary-residence-for-labor-reasons application with DGME\nOnce approved, apply for entry authorization at the Embassy of Costa Rica, New Delhi\nTravel and complete residence-card (cédula) formalities and CCSS enrollment in Costa Rica',
    '/assets/images/visa-heroes/costa-rica.webp',
    'Triangulated from immigration-law firm guidance (Globalization Partners, Rivermate, Safeguard Global, Expat.com) on DGME work-authorization process; migracion.go.cr not directly fetchable this session', 'https://migracion.go.cr/visas/', '2026-09-17'
);
SET @cri4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cri4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cri4, 'Core Documents', 'Required from every applicant.', 1);
SET @cri4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cri4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cri4s1, 'Employment Contract with Costa Rican Employer', NULL, 'copy', 1, 0, 1, 2),
(@cri4s1, 'Employer DGME Sponsor Registration Confirmation', 'Only if the employer has not previously hired a foreign national.', 'copy', 0, 1, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cri4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @cri4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cri4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@cri4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2),
(@cri4s2, 'Medical Certificate', NULL, 'original', 1, 0, 0, 3),
(@cri4s2, 'Proof of Financial Means', NULL, 'copy', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(161, 4, NULL, 'USD', 'Confirmed After Assessment', 'Reported figures vary widely across immigration-law-firm sources and were not consistently comparable this session — confirm the current combined DGME/consular fee structure directly.', '2026-09-01', NOW(), 'https://migracion.go.cr/visas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Costa Rica issue a separate work visa document?', 'No — work authorization is embedded within a DGME temporary-residence category rather than issued as a standalone visa. The employer typically drives the application, and it commonly takes 3-8 months.', 161, 4, 16104, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Group 3 Consular Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    161, 5, 'CRI-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives or friends resident in Costa Rica on a short-term basis.',
    'Indian nationals with family or friends in Costa Rica use the same Group 3 Consular Visa as Tourist, adding an invitation letter and proof of relationship — distinct from the longer-term "vínculo familiar" residency route used by Dependents.',
    'Up to 30 days on entry, reportedly extendable to 90 days',
    'Apply in person at the Embassy of Costa Rica, New Delhi with an invitation letter and relationship proof',
    1,
    'Reported around 30 calendar days',
    'Embassy of Costa Rica, New Delhi (Vasant Vihar)',
    'Obtain an invitation letter from your host in Costa Rica\nGather documents proving the family relationship\nComplete the consular visa application form\nSubmit documents at the Embassy of Costa Rica, New Delhi',
    '/assets/images/visa-heroes/costa-rica.webp',
    'Triangulated from visa-agency secondary sourcing on Costa Rica''s Group 3 consular visa process; migracion.go.cr not directly fetchable this session', 'https://migracion.go.cr/visas/', '2026-09-17'
);
SET @cri5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cri5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cri5, 'Core Documents', 'Required from every applicant.', 1);
SET @cri5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cri5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cri5s1, 'Invitation Letter from Host in Costa Rica', NULL, 'original', 1, 0, 1, 2),
(@cri5s1, 'Proof of Relationship', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cri5, 'Supporting Documents', 'Evidence of your own means.', 2);
SET @cri5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cri5s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 1),
(@cri5s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(161, 5, 52.00, 'USD', 'Group 3 Consular Visa Fee (Approximate)', 'Same fee structure as Tourist; sources report a $30-$52 range, so confirm the current amount with the embassy.', '2026-09-01', NOW(), 'https://migracion.go.cr/visas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What''s the difference between Family Visit and Dependent for Costa Rica?', 'Family Visit is a short-term consular visa for visiting relatives, capped around 30-90 days. Dependent status is a separate longer-term "vínculo familiar" residency route for spouses and children living with a resident/citizen sponsor in Costa Rica.', 161, 5, 16105, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Airport Transit Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    161, 6, 'CRI-TRAN-IN-06', '2026.09', 'published',
    'Connecting through a Costa Rican airport (e.g. San José) on the way to a third country.',
    'India was explicitly named (per a June 2023 Fragomen immigration alert) among nationalities that now require a Costa Rican Airport Transit Visa even for a same-airport connection, a requirement reportedly not previously applied to transiting Indian nationals.',
    'Valid for the transit window only',
    'Apply in person at the Embassy of Costa Rica, New Delhi with your onward ticket and itinerary before travel',
    1,
    'Reported timelines vary; apply well ahead of travel since transit visas cannot be obtained on arrival',
    'Embassy of Costa Rica, New Delhi (Vasant Vihar)',
    'Confirm your itinerary genuinely requires an airport connection in Costa Rica\nGather your onward ticket and full itinerary\nApply for the Airport Transit Visa at the Embassy of Costa Rica, New Delhi\nSubmit documents and any required biometrics',
    '/assets/images/visa-heroes/costa-rica.webp',
    'Cross-checked against a June 2023 Fragomen immigration-law alert naming India among added Airport Transit Visa nationalities; migracion.go.cr not directly fetchable this session', 'https://www.fragomen.com/insights/costa-rica-air-transit-visa-now-required-for-more-foreign-nationals-among-other-restrictions.html', '2026-09-17'
);
SET @cri6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cri6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cri6, 'Core Documents', 'Required from every applicant.', 1);
SET @cri6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cri6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cri6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cri6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @cri6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cri6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1),
(@cri6s2, 'Full Round-Trip Itinerary', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(161, 6, NULL, 'USD', 'Confirmed After Assessment', 'Sources did not consistently report a distinct Airport Transit Visa fee figure separate from the standard consular visa — confirm the current amount with the embassy.', '2026-09-01', NOW(), 'https://migracion.go.cr/visas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian passengers really need a visa just to connect through a Costa Rican airport?', 'Reportedly yes, since a 2023 policy change — India was explicitly named among nationalities newly required to hold an Airport Transit Visa for a Costa Rican connection, even without leaving the airport. Confirm current status with the embassy before booking a routing through Costa Rica.', 161, 6, 16106, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Group 3 Consular Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    161, 7, 'CRI-MED-IN-07', '2026.09', 'published',
    'Travel to Costa Rica for medical treatment.',
    'Indian nationals travelling for treatment use the same Group 3 Consular Visa as Tourist, adding a treatment-confirmation letter from the receiving hospital/clinic.',
    'Up to 30 days on entry, reportedly extendable to 90 days',
    'Apply in person at the Embassy of Costa Rica, New Delhi with a medical certificate and proof of funds for treatment',
    1,
    'Reported around 30 calendar days',
    'Embassy of Costa Rica, New Delhi (Vasant Vihar)',
    'Obtain a certificate from the treating Costa Rican hospital/clinic\nArrange travel health insurance\nComplete the consular visa application form\nSubmit documents at the Embassy of Costa Rica, New Delhi',
    '/assets/images/visa-heroes/costa-rica.webp',
    'Triangulated from visa-agency secondary sourcing on Costa Rica''s Group 3 consular visa process; migracion.go.cr not directly fetchable this session', 'https://migracion.go.cr/visas/', '2026-09-17'
);
SET @cri7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cri7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cri7, 'Core Documents', 'Required from every applicant.', 1);
SET @cri7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cri7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cri7s1, 'Medical Certificate/Treatment Confirmation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cri7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @cri7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cri7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@cri7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2),
(@cri7s2, 'Travel Health Insurance', NULL, 'original', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(161, 7, 52.00, 'USD', 'Group 3 Consular Visa Fee (Approximate)', 'Same fee structure as Tourist; sources report a $30-$52 range, so confirm the current amount with the embassy.', '2026-09-01', NOW(), 'https://migracion.go.cr/visas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Medical visa category for Costa Rica?', 'Not a separate visa type as such — Indian medical travelers use the same Group 3 Consular Visa as Tourist, with a treatment-confirmation letter from the Costa Rican hospital/clinic as the key differentiating document.', 161, 7, 16107, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Group 3 Consular Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    161, 8, 'CRI-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, congresses, and trade fairs in Costa Rica.',
    'Indian nationals attending a conference use the same Group 3 Consular Visa as Tourist/Business, adding a conference invitation or registration confirmation.',
    'Up to 30 days on entry, reportedly extendable to 90 days',
    'Apply in person at the Embassy of Costa Rica, New Delhi with a conference invitation/registration confirmation',
    1,
    'Reported around 30 calendar days',
    'Embassy of Costa Rica, New Delhi (Vasant Vihar)',
    'Obtain a conference invitation or registration confirmation\nGather proof of accommodation and return travel\nComplete the consular visa application form\nSubmit documents at the Embassy of Costa Rica, New Delhi',
    '/assets/images/visa-heroes/costa-rica.webp',
    'Triangulated from visa-agency secondary sourcing on Costa Rica''s Group 3 consular visa process; migracion.go.cr not directly fetchable this session', 'https://migracion.go.cr/visas/', '2026-09-17'
);
SET @cri8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cri8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cri8, 'Core Documents', 'Required from every applicant.', 1);
SET @cri8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cri8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cri8s1, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cri8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @cri8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cri8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@cri8s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(161, 8, 52.00, 'USD', 'Group 3 Consular Visa Fee (Approximate)', 'Same fee structure as Tourist; sources report a $30-$52 range, so confirm the current amount with the embassy.', '2026-09-01', NOW(), 'https://migracion.go.cr/visas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Conference and Business visas share the same checklist for Costa Rica?', 'Yes — both use the same Group 3 Consular Visa applied through the Embassy of Costa Rica, New Delhi, with the invitation/registration document being the key difference.', 161, 8, 16108, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Group 3 Consular Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    161, 9, 'CRI-SPRT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in Costa Rica.',
    'Indian nationals competing or officiating use the same Group 3 Consular Visa as Tourist/Conference, adding a sports-association letter and a host-organizer invitation.',
    'Up to 30 days on entry, reportedly extendable to 90 days',
    'Apply in person at the Embassy of Costa Rica, New Delhi with a sports-association letter and host-organizer invitation',
    1,
    'Reported around 30 calendar days',
    'Embassy of Costa Rica, New Delhi (Vasant Vihar)',
    'Obtain a letter from your resident-country sports association confirming your role\nObtain an invitation letter from the host event organizer\nComplete the consular visa application form\nSubmit documents at the Embassy of Costa Rica, New Delhi',
    '/assets/images/visa-heroes/costa-rica.webp',
    'Triangulated from visa-agency secondary sourcing on Costa Rica''s Group 3 consular visa process; migracion.go.cr not directly fetchable this session', 'https://migracion.go.cr/visas/', '2026-09-17'
);
SET @cri9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cri9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cri9, 'Core Documents', 'Required from every applicant.', 1);
SET @cri9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cri9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cri9s1, 'Home-Country Sports Association Letter', 'Confirms role and no-employment status.', 'original', 1, 0, 1, 2),
(@cri9s1, 'Host Event Organizer Invitation Letter', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cri9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @cri9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cri9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(161, 9, 52.00, 'USD', 'Group 3 Consular Visa Fee (Approximate)', 'Same fee structure as Tourist; sources report a $30-$52 range, so confirm the current amount with the embassy.', '2026-09-01', NOW(), 'https://migracion.go.cr/visas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What documents does a Sports visa need beyond a generic invitation letter?', 'It typically needs two specific letters — one from your home-country sports association and one from the host event organizer — in addition to the standard Group 3 Consular Visa documents.', 161, 9, 16109, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Vínculo Familiar Temporary Residency
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    161, 10, 'CRI-DEP-IN-10', '2026.09', 'published',
    'Spouse, minor children, or dependent adult children joining an Indian citizen/resident sponsor in Costa Rica via the "vínculo familiar" (family-bond) temporary residency category.',
    'Family members of an Indian national holding qualifying Costa Rican residency, or of a Costa Rican citizen — covering spouse, children under 18, and unmarried dependent adult children under 25. Requires mandatory CCSS (public healthcare) enrollment once approved.',
    'Temporary residency, renewable; eligible for permanent residency after 3 years as a temporary resident',
    'Apply at the Embassy of Costa Rica, New Delhi for the entry visa; the vínculo familiar residency application is filed with DGME in Costa Rica',
    1,
    'Reported as a multi-month process at DGME, separate from and typically longer than the short-stay consular visa',
    'Embassy of Costa Rica, New Delhi (Vasant Vihar) for entry; Dirección General de Migración y Extranjería, Costa Rica for the residency application',
    'Confirm the sponsor holds qualifying Costa Rican residency or citizenship\nGather relationship proof (marriage/birth certificates, registered with Costa Rica''s Civil Registry if issued abroad)\nApply for the entry visa at the Embassy of Costa Rica, New Delhi\nTravel to Costa Rica and file the vínculo familiar residency application with DGME\nEnroll in CCSS (public healthcare) once residency is approved',
    '/assets/images/visa-heroes/costa-rica.webp',
    'Cross-checked against residency-law-firm guidance (Fragomen, Harvey Law Group, Residency in Costa Rica) on the vínculo familiar category; migracion.go.cr not directly fetchable this session', 'https://migracion.go.cr/visas/', '2026-09-17'
);
SET @cri10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@cri10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cri10, 'Core Documents', 'Required from every applicant.', 1);
SET @cri10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cri10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@cri10s1, 'Proof of Relationship to Sponsor', 'Marriage or birth certificate, registered with Costa Rica''s Civil Registry if issued abroad.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@cri10, 'Supporting Documents', 'Evidence tied to the sponsor''s status.', 2);
SET @cri10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@cri10s2, 'Sponsor''s Costa Rican Residency/Citizenship Proof', NULL, 'copy', 1, 0, 0, 1),
(@cri10s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2),
(@cri10s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(161, 10, NULL, 'USD', 'Confirmed After Assessment', 'Vínculo familiar residency fees were not consistently reported across sources this session — confirm the current DGME fee schedule directly.', '2026-09-01', NOW(), 'https://migracion.go.cr/visas/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Which family members qualify for Dependent status in Costa Rica?', 'The "vínculo familiar" category reportedly covers a spouse, children under 18, and unmarried dependent adult children under 25 of a qualifying Costa Rican resident or citizen sponsor.', 161, 10, 16110, 1),
('Does Dependent residency lead to permanent status?', 'Yes — after 3 years holding temporary residency under vínculo familiar, the resident becomes eligible to apply for permanent residency, per residency-law-firm guidance.', 161, 10, 16111, 1);
