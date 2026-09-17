-- Senegal Visa Checklist Engine content for all 10 visa types — built this
-- session via web search. IMPORTANT SOURCING CAVEAT: WebFetch/direct site
-- access was blocked by the network egress proxy for every domain tried
-- this session, including embsenindia.org, en.wikipedia.org, atlys.com,
-- and visago.dev — so every finding below is triangulated across multiple
-- independent secondary sources (visa agencies, expat/relocation guides,
-- and Indian government mission pages) surfaced via web search, rather
-- than confirmed against a single primary Senegalese government source
-- (sec.gouv.sn / diplomatie.gouv.sn were not reachable). Fee figures and
-- processing times should be treated as approximate pending direct
-- confirmation with the Embassy of Senegal, New Delhi.
--
-- Senegal's real, distinctive facts verified this session:
--   - MAJOR: Senegal explicitly names India among 60+ nationalities granted
--     visa-free entry for up to 90 days for TOURISM, BUSINESS, OR TRANSIT
--     purposes (not tourism alone) — corroborated across Atlys, VisaGo,
--     ixigo, embassies.net, and VisaList. This is unusually liberal versus
--     most West African destinations and is the defining fact shaping the
--     Tourist, Business, Family Visit, Transit, Conference, and Sports
--     categories below, none of which require an advance visa application
--     within the 90-day window.
--   - Only genuine long-stay purposes — Student, Work, and Dependent/family
--     reunification beyond 90 days — require Senegal's "Visa Long Séjour",
--     applied for in advance at a Senegalese mission, followed by a Carte
--     d'Identité d'Étranger (CIE) residence card (valid 5 years, renewable)
--     obtained after arrival from Senegal's Directorate of Immigration.
--   - Work authorization is a genuine two-stage process: the EMPLOYER first
--     obtains a "contrat de travail visé" (contract approval) from the
--     Directorate of Labor and Social Security before the employee applies
--     for the long-stay visa; a récépissé (interim receipt/permit) bridges
--     the gap until the physical CIE is issued. Reported overall timeline:
--     1-3 months (per Rivermate, Playroll, and Expat.com relocation guides).
--   - A spouse/dependent holding a Senegalese dependent residence permit
--     does NOT automatically gain work rights — they must independently
--     secure their own job offer and work-permit sponsorship.
--   - Per Indian government mission pages (Embassy of India, Dakar; High
--     Commission of India, Georgetown), Senegal requires a WHO-format
--     Yellow Fever Vaccination Certificate from travellers arriving from
--     India. This is applied here as a document requirement across every
--     category, since it governs actual entry regardless of visa-free
--     status, and is worth flagging as a genuinely distinctive practical
--     requirement Indian travellers often overlook.
--   - Secondary sourcing also indicates Senegal has announced plans for a
--     future Electronic Travel Authorization (ETA)/electronic entry system,
--     but as of this session it was not confirmed as implemented — flagged
--     as a policy area to re-check periodically, not stated as current fact.
--   - Categories with NO distinct named visa type in Senegal's published
--     policy (Medical, Conference, Sports, and short-stay Family Visit) are
--     structured here as falling under the general visa-free/business
--     exemption, by inference from the "tourism, business, or transit"
--     wording. This inferred structuring was NOT independently confirmed
--     against a primary source naming these categories explicitly, and is
--     flagged as "NOT independently confirmed this session" per category.
--
-- country_id 42 = Senegal. visa_type_id: 1=Tourist, 2=Business, 3=Student,
-- 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference, 9=Sports,
-- 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Visa-Free Entry (up to 90 days)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    42, 1, 'SEN-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Senegal.',
    'Indian passport holders are visa-exempt for tourism stays up to 90 days — Senegal explicitly names India among 60+ nationalities granted this visa-free entry, a notably liberal policy versus most West African destinations. No advance visa application is needed within this window.',
    'Visa-free entry, up to 90 days per visit — verify current duration at your port of entry',
    'No visa application needed — present passport and entry documents directly at immigration on arrival',
    0,
    'No embassy or visa processing required for stays up to 90 days; only an on-arrival immigration check applies',
    'Not applicable for visa-free entry — Embassy of Senegal, New Delhi (C-6/10, Vasant Vihar, 110057) handles long-stay categories only',
    'Confirm your trip is for tourism and 90 days or under\nCheck passport validity (6+ months beyond arrival recommended)\nObtain a WHO-format Yellow Fever Vaccination Certificate, required by Senegal from travellers arriving from India\nBook onward/return travel and accommodation\nPresent documents to immigration on arrival',
    '/assets/images/visa-heroes/senegal.webp',
    'Cross-checked across VFS/visa-agency secondary sources (Atlys, VisaGo, ixigo, embassies.net) naming India in Senegal''s 90-day visa exemption list; primary gouv.sn portal not fetchable this session (egress blocked)', 'https://visago.dev/visa/senegal/from-india/', '2026-09-17'
);
SET @sen1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sen1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sen1, 'Core Documents', 'Required from every traveller at immigration.', 1);
SET @sen1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sen1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@sen1s1, 'Yellow Fever Vaccination Certificate (WHO Format)', 'Required by Senegal from travellers arriving from India, per Indian mission guidance.', 'original', 1, 0, 1, 2),
(@sen1s1, 'Proof of Onward/Return Travel', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sen1, 'Supporting Documents', 'Recommended to carry in case immigration requests them.', 2);
SET @sen1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sen1s2, 'Proof of Accommodation', NULL, 'copy', 0, 1, 0, 1),
(@sen1s2, 'Travel/Medical Insurance', NULL, 'if_applicable', 0, 1, 0, 2),
(@sen1s2, 'Proof of Sufficient Funds', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(42, 1, 0.00, 'USD', 'No Visa Fee (Visa-Free Entry)', 'Indian passport holders pay no visa fee for tourism stays up to 90 days; this is genuine visa-free entry, not a waived-fee visa. Confirm current duration and any future ETA fee with the Embassy of Senegal, New Delhi.', '2026-09-01', NOW(), 'https://visago.dev/visa/senegal/from-india/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit Senegal?', 'No — Indian passport holders are visa-exempt for tourism stays up to 90 days. Senegal explicitly names India in its list of visa-free nationalities, a more liberal policy than most West African countries offer Indians.', 42, 1, 4200, 1),
('Is a Yellow Fever certificate genuinely required for Indian travellers?', 'Yes — per Indian government mission guidance (Embassy of India, Dakar; High Commission of India, Georgetown), Senegal requires a WHO-format Yellow Fever Vaccination Certificate from travellers arriving from India, even though the visa itself is free.', 42, 1, 4201, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Visa-Free Entry (up to 90 days)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    42, 2, 'SEN-BUS-IN-02', '2026.09', 'published',
    'Trade, negotiations, and commercial meetings in Senegal.',
    'Indian nationals travelling for business — Senegal''s visa exemption explicitly covers "tourism, business, or transit" purposes for stays up to 90 days, not tourism alone. Only genuine employment/work activity requires a separate long-stay visa and work permit.',
    'Visa-free entry, up to 90 days per visit',
    'No visa application needed for stays up to 90 days; carry a business invitation letter for immigration checks',
    0,
    'No embassy or visa processing required for visa-free business travel under 90 days',
    'Not applicable for visa-free entry — Embassy of Senegal, New Delhi (C-6/10, Vasant Vihar, 110057) handles long-stay categories only',
    'Confirm your trip is for business meetings/negotiations, not paid local employment\nObtain an invitation letter from the Senegalese host company\nObtain a WHO-format Yellow Fever Vaccination Certificate\nBook travel and gather employer forwarding letter\nPresent documents to immigration on arrival',
    '/assets/images/visa-heroes/senegal.webp',
    'Cross-checked across VFS/visa-agency secondary sources naming "business" explicitly within Senegal''s 90-day visa exemption wording; primary gouv.sn portal not fetchable this session (egress blocked)', 'https://ivisatravel.com/senegal/c/senegal-visa-policy', '2026-09-17'
);
SET @sen2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sen2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sen2, 'Core Documents', 'Required from every traveller at immigration.', 1);
SET @sen2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sen2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@sen2s1, 'Invitation Letter from Senegalese Host Company', NULL, 'original', 1, 0, 1, 2),
(@sen2s1, 'Yellow Fever Vaccination Certificate (WHO Format)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sen2, 'Supporting Documents', 'Evidence of your own employment and travel plans.', 2);
SET @sen2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sen2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 0, 1, 0, 1),
(@sen2s2, 'Business Registration Proof', NULL, 'if_applicable', 0, 1, 0, 2),
(@sen2s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(42, 2, 0.00, 'USD', 'No Visa Fee (Visa-Free Entry)', 'Indian passport holders pay no visa fee for business stays up to 90 days. If the trip involves taking up paid local employment rather than short business activity, the Work visa category applies instead.', '2026-09-01', NOW(), 'https://ivisatravel.com/senegal/c/senegal-visa-policy', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Senegal''s visa-free policy cover business trips, or only tourism?', 'It covers both — the exemption is explicitly worded as "tourism, business, or transit" for stays up to 90 days, so short business trips do not require an advance visa.', 42, 2, 4202, 1),
('When would a business traveller need a different visa instead?', 'If the trip becomes genuine paid employment with a Senegalese employer rather than short-term meetings/negotiations, the Work visa route (long-stay visa plus CIE) applies instead.', 42, 2, 4203, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Visa Long Séjour (Study)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    42, 3, 'SEN-STU-IN-03', '2026.09', 'published',
    'Enrolling in a Senegalese university or institution for study exceeding 90 days.',
    'Indian nationals admitted to a Senegalese institution for programs longer than the 90-day visa-free window must obtain a Visa Long Séjour before travel, then register for a Carte d''Identité d''Étranger (CIE) after arrival — the general tourism exemption does not cover long-term study.',
    'Long-stay visa issued for the program duration; CIE residence card valid 5 years, renewable',
    'Apply in person for the Visa Long Séjour at the Embassy of Senegal, New Delhi, before travel',
    1,
    'Reported 1-3 months overall for long-stay/residence processing once in Senegal; embassy visa-issuance timelines not independently confirmed this session',
    'Embassy of Senegal, New Delhi (C-6/10, Vasant Vihar, New Delhi 110057)',
    'Secure an admission letter from a recognized Senegalese institution\nApply for the Visa Long Séjour at the Embassy of Senegal, New Delhi\nArrange proof of funds and international health insurance\nTravel to Senegal and register with the Directorate of Immigration\nPay the fiscal stamp (reported ~XOF 15,000) and apply for the Carte d''Identité d''Étranger (CIE)',
    '/assets/images/visa-heroes/senegal.webp',
    'Cross-checked against Expat.com study-in-Senegal and long-stay-visa guidance, triangulated against sources not directly fetchable this session (egress blocked)', 'https://www.expat.com/en/guide/africa/senegal/dakar/37429-study-in-dakar.html', '2026-09-17'
);
SET @sen3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sen3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sen3, 'Core Documents', 'Required from every applicant.', 1);
SET @sen3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sen3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@sen3s1, 'Admission Letter from Senegalese Institution', NULL, 'original', 1, 0, 1, 2),
(@sen3s1, 'Completed Visa Long Séjour Application Form', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sen3, 'Supporting Documents', 'Evidence of academic background, funds, and health cover.', 2);
SET @sen3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sen3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@sen3s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2),
(@sen3s2, 'International Health/Student Insurance', 'Senegal''s public health scheme does not cover international students.', 'original', 1, 0, 0, 3),
(@sen3s2, 'Medical Certificate', NULL, 'original', 1, 0, 0, 4),
(@sen3s2, 'Fiscal Stamp (Reported ~XOF 15,000)', 'Purchased locally as part of residence/CIE registration.', 'original', 1, 0, 0, 5),
(@sen3s2, 'Guardian Consent (Minors)', NULL, 'if_applicable', 0, 1, 0, 6);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(42, 3, NULL, 'XOF', 'Confirmed After Assessment', 'The Visa Long Séjour embassy fee was not independently confirmed this session. A separate fiscal stamp of reportedly ~XOF 15,000 applies during CIE/residence registration in Senegal, on top of the visa fee itself.', '2026-09-01', NOW(), 'https://www.expat.com/en/guide/africa/senegal/12191-visas-for-senegal.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I switch from a visa-free tourist entry to a student visa after arriving?', 'No — secondary sourcing indicates it is not possible to switch from a short-stay visit to long-stay/residency status after arriving as a tourist. The Visa Long Séjour must be obtained in advance from the Embassy of Senegal, New Delhi.', 42, 3, 4204, 1),
('What is the fiscal stamp students are asked to pay?', 'Multiple sources cite a fiscal stamp of roughly XOF 15,000 as part of the residence/CIE registration process for students, separate from the visa application fee itself — confirm the current amount with the embassy or on arrival.', 42, 3, 4205, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Visa Long Séjour + Carte d'Identité d'Étranger
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    42, 4, 'SEN-WORK-IN-04', '2026.09', 'published',
    'Employment with a Senegal-registered employer via an approved work contract and residence card.',
    'Indian nationals with a confirmed job offer from a Senegal-registered employer. The employer must first obtain a "contrat de travail visé" (approved employment contract) from the Directorate of Labor and Social Security before the employee applies for the long-stay visa; the CIE residence/work card is issued after arrival.',
    'CIE valid 5 years, renewable, tied to continued employment',
    'Employer-driven — employer secures the visé contract, then applicant applies for the Visa Long Séjour at the Embassy of Senegal, New Delhi',
    1,
    'Reported 1-3 months overall for work-permit/residence processing; embassy-stage visa timelines not independently confirmed this session',
    'Embassy of Senegal, New Delhi (visa decision); Carte d''Identité d''Étranger issued by the Directorate of Immigration in Senegal after arrival',
    'Secure a job offer from a Senegal-registered employer\nEmployer obtains the contrat de travail visé from the Directorate of Labor and Social Security\nApply for the Visa Long Séjour at the Embassy of Senegal, New Delhi\nTravel to Senegal and receive a récépissé (interim permit) while the CIE is processed\nCollect the 5-year Carte d''Identité d''Étranger (CIE)',
    '/assets/images/visa-heroes/senegal.webp',
    'Cross-checked against Rivermate, Playroll, and Expat.com Senegal work-permit relocation guidance, triangulated against sources not directly fetchable this session (egress blocked)', 'https://rivermate.com/guides/senegal/work-permits-and-visas', '2026-09-17'
);
SET @sen4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sen4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sen4, 'Core Documents', 'Required from every applicant.', 1);
SET @sen4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sen4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@sen4s1, 'Approved Employment Contract (Contrat de Travail Visé)', 'Approved by Senegal''s Directorate of Labor and Social Security.', 'copy', 1, 0, 1, 2),
(@sen4s1, 'Employer Sponsorship/Invitation Letter', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sen4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @sen4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sen4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@sen4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2),
(@sen4s2, 'Medical Certificate', NULL, 'original', 0, 1, 0, 3),
(@sen4s2, 'Proof of Accommodation in Senegal', NULL, 'copy', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(42, 4, NULL, 'XOF', 'Confirmed After Assessment', 'Exact work-visa/CIE fee figures were not independently confirmed this session. Relocation-guide sourcing consistently cites a 1-3 month overall processing window for the combined contract-approval-plus-residence-card process.', '2026-09-01', NOW(), 'https://www.playroll.com/work-permit-visas/senegal', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse work in Senegal if I hold a Work visa?', 'Not automatically — a spouse or dependent on a dependent residence permit does not gain work rights from that status alone. They must independently secure their own job offer and apply for their own work-permit sponsorship.', 42, 4, 4206, 1),
('What is the récépissé mentioned in the work-permit process?', 'It is an interim receipt/permit issued after arrival that authorizes you to legally reside in Senegal while your Carte d''Identité d''Étranger (CIE) application is being processed, bridging the gap until the physical 5-year card is issued.', 42, 4, 4207, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Visa-Free Entry (up to 90 days)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    42, 5, 'SEN-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives or friends resident in Senegal.',
    'Indian nationals visiting family/friends for up to 90 days fall under Senegal''s general visa-free entry for Indian passport holders; no separate "family visit" visa category was found. Stays intended to exceed 90 days instead require the long-stay family-reunification route (see Dependent visa). This short-stay structuring was NOT independently confirmed against a source naming "family visit" explicitly.',
    'Visa-free entry, up to 90 days per visit',
    'No visa application needed for stays up to 90 days; carry an invitation letter/relationship proof for immigration checks',
    0,
    'No embassy or visa processing required for visa-free family visits under 90 days',
    'Not applicable for visa-free entry — Embassy of Senegal, New Delhi (C-6/10, Vasant Vihar, 110057) handles long-stay family reunification',
    'Obtain an invitation letter from your host in Senegal\nGather documents proving the family relationship\nObtain a WHO-format Yellow Fever Vaccination Certificate\nBook travel\nPresent documents to immigration on arrival',
    '/assets/images/visa-heroes/senegal.webp',
    'Cross-checked across visa-agency secondary sources on Senegal''s general 90-day visa exemption; the exemption''s wording covers "tourism, business, or transit" and does not separately name family visits, so this category is inferred, not confirmed', 'https://ivisatravel.com/senegal/c/senegal-visa-policy', '2026-09-17'
);
SET @sen5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sen5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sen5, 'Core Documents', 'Required from every traveller at immigration.', 1);
SET @sen5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sen5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@sen5s1, 'Invitation Letter from Host in Senegal', NULL, 'original', 1, 0, 1, 2),
(@sen5s1, 'Yellow Fever Vaccination Certificate (WHO Format)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sen5, 'Supporting Documents', 'Evidence of the relationship and your own means.', 2);
SET @sen5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sen5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@sen5s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 0, 1, 0, 2),
(@sen5s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(42, 5, 0.00, 'USD', 'No Visa Fee (Visa-Free Entry)', 'Indian passport holders pay no visa fee for family-visit stays up to 90 days. For stays intended to exceed 90 days, the long-stay Dependent/family-reunification visa route applies instead.', '2026-09-01', NOW(), 'https://ivisatravel.com/senegal/c/senegal-visa-policy', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate visa just to visit family in Senegal?', 'No distinct "family visit" visa was found — for stays up to 90 days, Indian nationals visiting family fall under the general visa-free entry. Carrying an invitation letter and proof of the relationship is still recommended for immigration.', 42, 5, 4208, 1),
('What if I want to stay with family longer than 90 days?', 'A visit intended to exceed 90 days needs to be handled through the long-stay family-reunification (Dependent) route instead, applied for in advance — not the visa-free short-stay entry.', 42, 5, 4209, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Visa-Free Entry (up to 90 days)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    42, 6, 'SEN-TRAN-IN-06', '2026.09', 'published',
    'Passing through Senegal (e.g. Blaise Diagne International Airport, Dakar) en route to a third country.',
    'Senegal''s visa exemption for Indian passport holders explicitly names "tourism, business, or transit" purposes for stays up to 90 days, so a transiting Indian traveller generally does not need a separate transit visa — though the Yellow Fever certificate and standard immigration checks still apply if leaving the airport.',
    'Visa-free; transit stays are typically hours to a few days, within the 90-day exemption window',
    'No visa required to transit; standard visa-free entry rules apply if leaving the international transit zone',
    0,
    'No embassy or visa processing required for visa-free transit',
    'Not applicable for visa-free transit — Embassy of Senegal, New Delhi (C-6/10, Vasant Vihar, 110057) handles long-stay categories only',
    'Confirm your itinerary and layover duration\nCarry your onward/connecting flight ticket\nCarry a WHO-format Yellow Fever Vaccination Certificate in case you leave the international transit zone\nConfirm whether your final destination requires a separate visa',
    '/assets/images/visa-heroes/senegal.webp',
    'Cross-checked against Senegal''s visa-exemption wording, which names "transit" explicitly alongside tourism/business; specific edge cases (e.g. overnight non-airside transit) were not independently confirmed this session', 'https://ivisatravel.com/senegal/c/senegal-visa-policy', '2026-09-17'
);
SET @sen6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sen6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sen6, 'Core Documents', 'Required from every transiting traveller.', 1);
SET @sen6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sen6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@sen6s1, 'Onward/Connecting Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sen6, 'Supporting Documents', 'Needed only if leaving the international transit zone.', 2);
SET @sen6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sen6s2, 'Yellow Fever Vaccination Certificate (WHO Format)', NULL, 'if_applicable', 0, 1, 0, 1),
(@sen6s2, 'Visa for Final Destination Country', NULL, 'if_applicable', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(42, 6, 0.00, 'USD', 'No Visa Fee (Visa-Free Entry)', 'Indian passport holders pay no visa fee to transit through Senegal within the 90-day exemption window. Airside-only connections typically require no additional documentation beyond the onward ticket.', '2026-09-01', NOW(), 'https://ivisatravel.com/senegal/c/senegal-visa-policy', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian travellers need a separate transit visa for Senegal?', 'No distinct transit-only visa was found for Indian passport holders — transit is explicitly covered by the same 90-day visa exemption as tourism and business.', 42, 6, 4210, 1),
('Is the Yellow Fever certificate needed for a short airport layover?', 'It is primarily required if you leave the international transit zone; carrying it regardless is recommended since requirements can vary by airline and specific layover circumstances, which were not independently confirmed this session.', 42, 6, 4211, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Visa-Free Entry (up to 90 days, inferred)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    42, 7, 'SEN-MED-IN-07', '2026.09', 'published',
    'Travel to Senegal for medical treatment.',
    'Medical travel is not called out as a distinct visa category in Senegal''s published policy. Indian nationals travelling for treatment lasting up to 90 days are treated here as falling under the general visa-free entry; treatment expected to exceed 90 days would need the long-stay visa route. This structuring is inferred and was NOT independently confirmed against a source naming a "medical visa" explicitly.',
    'Visa-free entry, up to 90 days, for treatment lasting within that window',
    'No visa application needed for stays up to 90 days; carry hospital/doctor documentation for immigration and insurance purposes',
    0,
    'No embassy or visa processing required for visa-free medical stays under 90 days',
    'Not applicable for visa-free entry — Embassy of Senegal, New Delhi (C-6/10, Vasant Vihar, 110057) handles long-stay categories only',
    'Obtain a medical certificate/hospital invitation confirming the need for treatment\nArrange travel/medical insurance\nObtain a WHO-format Yellow Fever Vaccination Certificate\nBook travel\nPresent documents to immigration on arrival',
    '/assets/images/visa-heroes/senegal.webp',
    'Inferred from Senegal''s general visa-exemption wording ("tourism, business, or transit"), which does not separately name medical travel; NOT independently confirmed against a source naming a distinct Medical visa this session', 'https://ivisatravel.com/senegal/c/senegal-visa-policy', '2026-09-17'
);
SET @sen7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sen7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sen7, 'Core Documents', 'Required from every traveller at immigration.', 1);
SET @sen7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sen7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@sen7s1, 'Medical Certificate/Hospital Invitation', NULL, 'original', 1, 0, 1, 2),
(@sen7s1, 'Yellow Fever Vaccination Certificate (WHO Format)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sen7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @sen7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sen7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@sen7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2),
(@sen7s2, 'Travel/Medical Insurance', NULL, 'if_applicable', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(42, 7, 0.00, 'USD', 'No Visa Fee (Visa-Free Entry, Inferred)', 'Treated as falling under the general visa-free entry for stays up to 90 days, since no distinct Medical visa fee/category was found. Confirm directly with the Embassy of Senegal, New Delhi, before travel for treatment.', '2026-09-01', NOW(), 'https://ivisatravel.com/senegal/c/senegal-visa-policy', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Senegal have a distinct Medical visa for Indian patients?', 'No dedicated Medical visa category was found in Senegal''s published policy this session. Treatment lasting up to 90 days is treated here as falling under the general visa-free entry; confirm this directly with the embassy before booking treatment.', 42, 7, 4212, 1),
('What if treatment in Senegal is expected to take longer than 90 days?', 'Extended treatment would require the long-stay Visa Long Séjour route rather than visa-free entry — the exact process for a purely medical long-stay case was not independently confirmed this session.', 42, 7, 4213, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Visa-Free Entry (up to 90 days)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    42, 8, 'SEN-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, summits, or trade fairs in Senegal — Dakar hosts a range of AU- and internationally-linked events.',
    'Indian nationals attending conferences for up to 90 days are treated here as falling under Senegal''s business/tourism visa-free exemption; no distinct conference-visa category was found in Senegal''s published policy, so this structuring is inferred rather than separately confirmed.',
    'Visa-free entry, up to 90 days',
    'No visa application needed for stays up to 90 days; carry conference invitation/registration confirmation',
    0,
    'No embassy or visa processing required for visa-free conference travel under 90 days',
    'Not applicable for visa-free entry — Embassy of Senegal, New Delhi (C-6/10, Vasant Vihar, 110057) handles long-stay categories only',
    'Obtain a conference invitation or registration confirmation\nObtain a WHO-format Yellow Fever Vaccination Certificate\nGather proof of accommodation and return travel\nPresent documents to immigration on arrival',
    '/assets/images/visa-heroes/senegal.webp',
    'Inferred from Senegal''s general visa-exemption wording ("tourism, business, or transit"); NOT independently confirmed against a source naming a distinct Conference visa this session', 'https://ivisatravel.com/senegal/c/senegal-visa-policy', '2026-09-17'
);
SET @sen8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sen8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sen8, 'Core Documents', 'Required from every traveller at immigration.', 1);
SET @sen8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sen8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@sen8s1, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 2),
(@sen8s1, 'Yellow Fever Vaccination Certificate (WHO Format)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sen8, 'Supporting Documents', 'Additional employer-side and travel evidence.', 2);
SET @sen8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sen8s2, 'Forwarding Letter from Employer', NULL, 'if_applicable', 0, 1, 0, 1),
(@sen8s2, 'Proof of Accommodation', NULL, 'copy', 0, 1, 0, 2),
(@sen8s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(42, 8, 0.00, 'USD', 'No Visa Fee (Visa-Free Entry, Inferred)', 'Treated as falling under the general visa-free entry for stays up to 90 days, since no distinct Conference visa fee/category was found. Confirm directly with the Embassy of Senegal, New Delhi, for major official delegations.', '2026-09-01', NOW(), 'https://ivisatravel.com/senegal/c/senegal-visa-policy', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do conference attendees need a separate visa from tourists?', 'No distinct Conference visa was found — attending a conference in Senegal for up to 90 days is treated here as covered by the same visa-free business/tourism exemption available to Indian passport holders.', 42, 8, 4214, 1),
('Why is Dakar a common conference destination?', 'Dakar regularly hosts African Union- and internationally-linked summits and trade fairs, making it a notable regional conference hub — carrying your registration confirmation is still recommended for immigration checks.', 42, 8, 4215, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Visa-Free Entry (up to 90 days)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    42, 9, 'SEN-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in or attending sporting events hosted in Senegal.',
    'Indian nationals travelling to compete or attend a sporting event for up to 90 days are treated here as falling under Senegal''s visa-free business/tourism exemption; no distinct sports-visa category was found. Dakar''s recent role as a Youth Olympic host city is noted from general knowledge but was not independently re-verified via search this session.',
    'Visa-free entry, up to 90 days',
    'No visa application needed for stays up to 90 days; carry event accreditation/invitation for immigration checks',
    0,
    'No embassy or visa processing required for visa-free sports travel under 90 days',
    'Not applicable for visa-free entry — Embassy of Senegal, New Delhi (C-6/10, Vasant Vihar, 110057) handles long-stay categories only',
    'Obtain a letter from your sports association confirming your role\nObtain an invitation/accreditation letter from the host event organizer\nObtain a WHO-format Yellow Fever Vaccination Certificate\nPresent documents to immigration on arrival',
    '/assets/images/visa-heroes/senegal.webp',
    'Inferred from Senegal''s general visa-exemption wording ("tourism, business, or transit"); NOT independently confirmed against a source naming a distinct Sports visa this session', 'https://ivisatravel.com/senegal/c/senegal-visa-policy', '2026-09-17'
);
SET @sen9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sen9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sen9, 'Core Documents', 'Required from every traveller at immigration.', 1);
SET @sen9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sen9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@sen9s1, 'Sports Association/Federation Letter', 'Confirms your role and event participation.', 'original', 1, 0, 1, 2),
(@sen9s1, 'Host Event Organizer Invitation/Accreditation', NULL, 'original', 1, 0, 1, 3),
(@sen9s1, 'Yellow Fever Vaccination Certificate (WHO Format)', NULL, 'original', 1, 0, 1, 4);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sen9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @sen9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sen9s2, 'Team/Delegation List', NULL, 'if_applicable', 0, 1, 0, 1),
(@sen9s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(42, 9, 0.00, 'USD', 'No Visa Fee (Visa-Free Entry, Inferred)', 'Treated as falling under the general visa-free entry for stays up to 90 days, since no distinct Sports visa fee/category was found. Major games/delegations should confirm accreditation procedures directly with event organizers and the embassy.', '2026-09-01', NOW(), 'https://ivisatravel.com/senegal/c/senegal-visa-policy', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a separate visa to compete in Senegal?', 'No distinct Sports visa was found — competing or attending an event in Senegal for up to 90 days is treated here as covered by the general visa-free entry, though carrying association and event accreditation letters is still recommended.', 42, 9, 4216, 1),
('Has Senegal hosted major international sporting events recently?', 'Dakar has been positioned as a notable African sporting host city in recent years; specific 2026 event dates and any related entry procedures were not independently re-verified via search this session and should be confirmed closer to travel.', 42, 9, 4217, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Family Reunification Residence Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    42, 10, 'SEN-DEP-IN-10', '2026.09', 'published',
    'Spouse or minor children joining an Indian national who holds a qualifying Senegalese work/residence permit (CIE).',
    'Family members of an Indian national holding a valid Carte d''Identité d''Étranger (CIE) or Senegalese residence status. A dependent residence permit does NOT itself grant the right to work — a dependent spouse must independently secure their own job offer and separate work-permit sponsorship.',
    'Tied to the sponsor''s CIE validity (typically up to 5 years), renewable',
    'Apply in person for the Visa Long Séjour at the Embassy of Senegal, New Delhi, before travel',
    1,
    'Reported 1-3 months overall for long-stay/residence processing once in Senegal; embassy-stage visa timelines not independently confirmed this session',
    'Embassy of Senegal, New Delhi (C-6/10, Vasant Vihar, New Delhi 110057)',
    'Confirm the sponsor holds a valid CIE/Senegalese residence permit\nGather relationship proof (marriage/birth certificates), apostilled/legalized and translated into French\nApply for the Visa Long Séjour at the Embassy of Senegal, New Delhi\nTravel to Senegal and register with the Directorate of Immigration\nApply for the dependent Carte d''Identité d''Étranger (CIE)',
    '/assets/images/visa-heroes/senegal.webp',
    'Cross-checked against expat-relocation and residence-permit-type guidance on Senegalese family reunification, triangulated against sources not directly fetchable this session (egress blocked)', 'https://mosaicvisa.com/senegal/latest-news-residence-types.html', '2026-09-17'
);
SET @sen10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@sen10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sen10, 'Core Documents', 'Required from every applicant.', 1);
SET @sen10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sen10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@sen10s1, 'Proof of Relationship to Sponsor', 'Marriage/birth certificate, apostilled/legalized and translated into French.', 'copy', 1, 0, 1, 2),
(@sen10s1, 'Sponsor''s Carte d''Identité d''Étranger (CIE) Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@sen10, 'Supporting Documents', 'Evidence of the sponsor''s ability to support dependents.', 2);
SET @sen10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@sen10s2, 'Proof of Accommodation in Senegal', NULL, 'copy', 1, 0, 0, 1),
(@sen10s2, 'Proof of Sponsor''s Financial Means', NULL, 'copy', 1, 0, 0, 2),
(@sen10s2, 'Yellow Fever Vaccination Certificate (WHO Format)', NULL, 'original', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(42, 10, NULL, 'XOF', 'Confirmed After Assessment', 'Exact dependent visa/CIE fee figures were not independently confirmed this session. Sourcing consistently distinguishes this from the primary sponsor''s own work-permit fee, so confirm both separately with the embassy.', '2026-09-01', NOW(), 'https://mosaicvisa.com/senegal/latest-news-residence-types.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can a dependent spouse work in Senegal once they arrive?', 'Not automatically — a dependent residence permit does not itself grant the right to work. The spouse must independently secure their own job offer and apply for a separate work permit in their own name, per relocation-guide sourcing.', 42, 10, 4218, 1),
('Does the marriage certificate need special legalization for Senegal?', 'Yes — sourcing indicates the marriage certificate (or birth certificate for children) generally needs to be apostilled/legalized and officially translated into French before it is accepted for the dependent residence application.', 42, 10, 4219, 1);
