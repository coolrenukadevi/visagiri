-- Chile Visa Checklist Engine content for all 10 visa types — built this
-- session via web search. hero_image_url left NULL at authoring time (no
-- photo bundle supplied yet).
--
-- IMPORTANT SOURCING CAVEAT: primary Chilean government domains
-- (chile.gob.cl, consulado.gob.cl, serviciomigraciones.cl/SERMIG,
-- tramites.extranjeria.gob.cl) and several immigration-law-firm alert
-- pages (KPMG, Fragomen, Envoy Global, L&E Global, Erickson Immigration
-- Group, eiglaw.com, leglobal.law) were all EGRESS-BLOCKED by the
-- network proxy this session and could not be directly fetched.
-- Findings below were triangulated from WebSearch result snippets of
-- secondary sources (BTW Visas, Expat.cl, ixigo, Skyscanner, Akbar
-- Travels, and the law-firm alert headlines/summaries surfaced by
-- search). Fee figures, exact processing times, and some procedural
-- detail should be treated as REPORTED/APPROXIMATE and reconfirmed
-- against primary sources before being relied on operationally. This is
-- most acute for: Work, Medical, Transit and Dependent visa FEES (all
-- marked "Confirmed After Assessment" below), and for exact SERMIG
-- processing-time figures, which were not clearly documented in any
-- source reviewed this session.
--
-- Chile's real, distinctive facts (as found this session):
--   - India is genuinely NOT on Chile's visa-exempt list. Unlike EU/US/
--     Canadian nationals, who get a free 90-day "Permanencia Transitoria"
--     on arrival with no advance visa, Indian passport holders must
--     generally obtain a consular Permanencia Transitoria (tourist/
--     business-type) visa from the Embassy of Chile before travelling.
--   - A genuinely narrow exemption exists: an Indian passport holder who
--     holds a valid US visa (any type EXCEPT a "C" transit visa, valid
--     6+ months) or a US Green Card can enter Chile visa-free as a
--     tourist for up to 90 days. Sources are explicit that a Canadian
--     visa does NOT carry the same exemption for Indian nationals.
--   - A genuine, dated 2026 development: Chile launched a new expedited,
--     multiple-entry Business visa specifically for Indian nationals,
--     announced in May 2026 during Chilean Foreign Minister Francisco
--     Pérez Mackenna's visit to India (May 11-14, 2026), in the context
--     of ongoing India-Chile CEPA trade-agreement negotiations. It is
--     reported (via multiple independent immigration-law-firm alert
--     headlines surfaced by search — KPMG, Fragomen, Envoy Global, L&E
--     Global, Erickson) to run for 2 years, allow multiple entries with
--     stays of up to 90 days each, and process faster than the standard
--     route. The underlying primary announcement page could not be
--     directly fetched this session, so exact fee/process detail is
--     flagged as needing reconfirmation.
--   - Chile's 2021 migration law (Ley de Migración y Extranjería,
--     Ley 21.325) means most temporary-residence categories (Work,
--     Medical Treatment, Family Reunification) are now applied for
--     ONLINE from abroad via the Servicio Nacional de Migraciones
--     (SERMIG)'s "Portal de Trámites Digitales" / ClaveÚnica login,
--     rather than solely through an in-person embassy appointment —
--     a genuinely different channel from the Tourist/Business/short-stay
--     categories, which are still filed at the Embassy of Chile in
--     New Delhi.
--   - Family Reunification (Dependent) residents can become eligible for
--     permanent residency after just 12 months — notably faster than
--     most other residence tracks reported for Chile.
--   - A short-stay Transit visa is only required for passengers who must
--     leave the international transit area of a Chilean airport (e.g.
--     to change terminals through immigration); passengers who remain
--     airside for a same-day connection generally do not need one.
--
-- country_id 200 = Chile. visa_type_id: 1=Tourist, 2=Business, 3=Student,
-- 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference, 9=Sports,
-- 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Permanencia Transitoria (Consular)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    200, 1, 'CHL-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Chile.',
    'Indian passport holders are not on Chile''s visa-exempt list and must generally obtain a consular Permanencia Transitoria (tourist) visa before travel, unless holding a valid US visa (any type except a transit "C" visa, valid 6+ months) or a US Green Card, which exempts Indians from this visa for stays up to 90 days.',
    'Up to 90 days, decided at entry even after consular pre-approval',
    'Apply in person at the Embassy of Chile, New Delhi with required documents before travel',
    1,
    'Reported processing of roughly 2-4 calendar weeks; apply well ahead of travel dates',
    'Embassy of Chile, New Delhi (Vasant Vihar) — primary visa-issuing post for India; honorary consulates also present in Mumbai, Chennai and Kolkata',
    'Confirm you are not covered by the US-visa/Green Card exemption\nComplete the Chilean visa application form\nGather supporting documents (passport, funds, travel plan)\nBook an appointment and submit in person at the Embassy of Chile, New Delhi\nCollect your passport with the visa affixed; final stay length is set by immigration at entry',
    '/assets/images/visa-heroes/chile.webp',
    'Cross-checked against secondary visa-agency and reciprocity-fee sourcing (ixigo, Skyscanner, BTW Visas); primary consulado.gob.cl and chile.gob.cl pages were egress-blocked this session', 'https://www.consulado.gob.cl/informacion-sobre-visas-para-ingresar-a-chile', '2026-09-17'
);
SET @chl1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@chl1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@chl1, 'Core Documents', 'Required from every applicant.', 1);
SET @chl1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@chl1s1, 'Valid Passport (6+ Months Beyond Intended Stay)', NULL, 'original', 1, 0, 1, 1),
(@chl1s1, 'Completed Visa Application Form', NULL, 'copy', 1, 0, 1, 2),
(@chl1s1, 'Passport-Size Photographs', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@chl1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @chl1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@chl1s2, 'Confirmed Hotel Booking', NULL, 'copy', 1, 0, 0, 1),
(@chl1s2, 'Return/Onward Flight Ticket', 'Proof of onward departure from Chile.', 'copy', 1, 0, 0, 2),
(@chl1s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3),
(@chl1s2, 'Valid US Visa or Green Card (If Claiming Exemption)', 'Any type except a transit "C" visa, valid 6+ months.', 'copy', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(200, 1, 42.00, 'USD', 'Single-Entry Tourist Visa Fee (Reported)', 'Multiple-entry reported at USD 76. Chile''s consular fees are often reciprocity-based (tied to what the destination country charges Chilean nationals) — reconfirm before relying on this figure, as the primary consulado.gob.cl fee schedule was not reachable this session.', '2026-09-01', NOW(), 'https://www.consulado.gob.cl/informacion-sobre-visas-para-ingresar-a-chile', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian passport holders need a visa to visit Chile as a tourist?', 'Yes — India is not on Chile''s visa-exempt list, so Indian passport holders generally need a consular Permanencia Transitoria (tourist) visa before travel. The one reported exception: holding a valid US visa (any type except a transit "C" visa) or a US Green Card valid for at least 6 months lets Indian nationals enter Chile visa-free for up to 90 days.', 200, 1, 20010, 1),
('Does a Canadian visa also exempt Indian travellers from Chile''s visa requirement?', 'No — sourcing reviewed this session is explicit that only a qualifying US visa or US Green Card carries this exemption for Indian passport holders; a Canadian visa does not.', 200, 1, 20011, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Standard Route + New 2026 Expedited Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    200, 2, 'CHL-BUS-IN-02', '2026.09', 'published',
    'Trade, negotiations, and business meetings in Chile, including via Chile''s new expedited visa for Indian nationals.',
    'Indian nationals travelling for business; as of mid-2026 Chile offers a new expedited, multiple-entry Business visa specifically for Indian nationals (announced May 2026 during the Chilean Foreign Minister''s visit to India, amid CEPA trade talks), alongside the standard single Permanencia Transitoria business-visa route.',
    'New expedited visa: 2-year validity, multiple entries, up to 90 days per stay (reported); standard route: up to 90 days',
    'Apply at the Embassy of Chile, New Delhi with a business invitation letter and employer sponsorship letter',
    1,
    'Reported to process faster than the standard route under the new expedited scheme; standard route roughly 2-4 weeks',
    'Embassy of Chile, New Delhi (Vasant Vihar) — primary visa-issuing post for India; honorary consulates also present in Mumbai, Chennai and Kolkata',
    'Confirm whether you qualify for the new expedited multiple-entry Business visa or the standard route\nObtain an invitation letter from the Chilean host company\nGather Indian employer sponsorship/forwarding letter\nBook an appointment and submit in person at the Embassy of Chile, New Delhi\nCollect your passport with the visa affixed',
    '/assets/images/visa-heroes/chile.webp',
    'Cross-checked against multiple immigration-law-firm alert summaries on the May-June 2026 launch (KPMG, Fragomen, Envoy Global); primary chile.gob.cl pages were egress-blocked this session', 'https://www.envoyglobal.com/news-alert/chile-launches-expedited-business-visa-for-indian-nationals/', '2026-09-17'
);
SET @chl2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@chl2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@chl2, 'Core Documents', 'Required from every applicant.', 1);
SET @chl2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@chl2s1, 'Valid Passport (6+ Months Beyond Intended Stay)', NULL, 'original', 1, 0, 1, 1),
(@chl2s1, 'Invitation Letter from Chilean Host Company', NULL, 'original', 1, 0, 1, 2),
(@chl2s1, 'Completed Visa Application Form', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@chl2, 'Supporting Documents', 'Evidence of your own employment and financial standing.', 2);
SET @chl2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@chl2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@chl2s2, 'Business Registration/Company Proof', NULL, 'copy', 0, 1, 0, 2),
(@chl2s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(200, 2, NULL, 'USD', 'Confirmed After Assessment', 'Fee for the new 2026 expedited multiple-entry Business visa was not confirmed this session (primary announcement pages were egress-blocked). The standard-route Business Permanencia Transitoria fee is reported similarly to Tourist (~USD 42 single-entry / USD 76 multiple-entry) pending confirmation.', '2026-09-01', NOW(), 'https://www.envoyglobal.com/news-alert/chile-launches-expedited-business-visa-for-indian-nationals/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What changed for Indian business travellers to Chile in 2026?', 'Chile introduced a new expedited, multiple-entry Business visa specifically for Indian nationals, announced in May 2026 during the Chilean Foreign Minister''s visit to India amid CEPA trade-deal talks. It is reported to run for 2 years, allow multiple entries with stays of up to 90 days each, and process faster than the standard route — reconfirm current details with the Embassy before applying.', 200, 2, 20020, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Nominee / Dependent Student Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    200, 3, 'CHL-STU-IN-03', '2026.09', 'published',
    'Enrolling in a Chilean university or state-recognized academic institution.',
    'Indian nationals admitted to a Chilean institution apply for a Student temporary-residence visa: "Nominee" (self-funded, no sponsor or invitation letter needed) or "Dependent" (sponsored by a Chilean entity, requiring an invitation/sponsorship letter).',
    'Up to 1 year, renewable for the program duration; scholarship holders may receive a visa matching the scholarship period',
    'Apply in person at the Embassy of Chile, New Delhi; physical appearance is mandatory to submit documents and the signed form',
    1,
    'Reported processing of roughly 2-8 weeks',
    'Embassy of Chile, New Delhi (Vasant Vihar) — primary visa-issuing post for India; honorary consulates also present in Mumbai, Chennai and Kolkata',
    'Secure admission at a recognized Chilean institution\nDetermine whether you apply as Nominee (self-funded) or Dependent (sponsored)\nGather proof of funds/scholarship and academic records\nBook an embassy appointment and submit in person\nCollect your passport with the visa affixed and register locally after arrival',
    '/assets/images/visa-heroes/chile.webp',
    'Cross-checked against visa-agency secondary sourcing (BTW Visas) on the Nominee/Dependent student-visa split; primary chile.gob.cl pages were egress-blocked this session', 'https://btwvisas.com/visa-guide/chile-student-visa/', '2026-09-17'
);
SET @chl3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@chl3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@chl3, 'Core Documents', 'Required from every applicant.', 1);
SET @chl3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@chl3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@chl3s1, 'Admission Letter from Chilean Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@chl3, 'Supporting Documents', 'Evidence of your academic background, funds, and sponsorship (if applicable).', 2);
SET @chl3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@chl3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@chl3s2, 'Proof of Funds/Scholarship', NULL, 'copy', 1, 0, 0, 2),
(@chl3s2, 'Sponsorship/Invitation Letter (Dependent Route Only)', NULL, 'original', 0, 1, 0, 3),
(@chl3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(200, 3, NULL, 'USD', 'Confirmed After Assessment', 'Secondary sourcing reports a fee range of roughly USD 50-150, reportedly payable in cash in INR at the Embassy — reconfirm the current figure before applying, as the primary fee schedule was not reachable this session.', '2026-09-01', NOW(), 'https://btwvisas.com/visa-guide/chile-student-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What''s the difference between Chile''s "Nominee" and "Dependent" student visas?', 'The Nominee student visa is for self-funded students who do not need a sponsor or invitation letter; the Dependent student visa is for those sponsored by a Chilean entity and requires an invitation/sponsorship letter from that entity.', 200, 3, 20030, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Temporary Residence for Work (SERMIG)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    200, 4, 'CHL-WORK-IN-04', '2026.09', 'published',
    'Employment in Chile under a local work contract, signed job offer, or self-employed services contract.',
    'Indian nationals with a Chilean work/services contract or signed job offer apply for a work-purpose temporary-residence permit via the Servicio Nacional de Migraciones (SERMIG); under Chile''s 2021 migration law (Ley 21.325), most such applications are now filed online from abroad through SERMIG''s Portal de Trámites Digitales rather than solely in person.',
    'Up to 2 years, extendable for a further 2 years',
    'Apply online from India via SERMIG''s Portal de Trámites Digitales; formal contracts must also be registered with SERMIG within 45 days of entry',
    0,
    'Reported processing of roughly 8 weeks; renewal must be filed within 90 days before expiry',
    'Servicio Nacional de Migraciones (SERMIG) — online portal; Embassy of Chile, New Delhi for any consular visa stamp/entry formalities',
    'Secure a work contract, job offer, or services contract with a Chilean employer/client\nApply for the work-purpose temporary-residence permit via SERMIG''s online Portal de Trámites Digitales\nAwait the outcome and any consular formalities at the Embassy of Chile, New Delhi\nTravel to Chile and register the formal contract with SERMIG within 45 days of entry\nRenew within 90 days before the permit expires if continuing',
    '/assets/images/visa-heroes/chile.webp',
    'Cross-checked against SERMIG and Dirección del Trabajo secondary sourcing on the post-Ley 21.325 online work-permit process; primary extranjeria.gob.cl and serviciomigraciones.cl pages were egress-blocked this session', 'https://tramites.extranjeria.gob.cl/tramites/ver_ficha/261', '2026-09-17'
);
SET @chl4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@chl4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@chl4, 'Core Documents', 'Required from every applicant.', 1);
SET @chl4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@chl4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@chl4s1, 'Signed Employment/Services Contract or Job Offer', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@chl4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @chl4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@chl4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@chl4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2),
(@chl4s2, 'Proof of Financial Means', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(200, 4, NULL, 'USD', 'Confirmed After Assessment', 'SERMIG''s work-permit fee schedule varies by permit subcategory and was not directly reachable this session (serviciomigraciones.cl egress-blocked) — contact us or SERMIG to confirm the current figure.', '2026-09-01', NOW(), 'https://tramites.extranjeria.gob.cl/tramites/ver_ficha/261', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I apply for a Chile work permit without travelling first?', 'Largely yes — since Chile''s 2021 migration law (Ley 21.325), most work-purpose temporary-residence applications are filed online from abroad via SERMIG''s Portal de Trámites Digitales, rather than requiring an in-person embassy visit before your permit outcome is known.', 200, 4, 20040, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Permanencia Transitoria (Consular)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    200, 5, 'CHL-FAM-IN-05', '2026.09', 'published',
    'Visiting family or friends resident in Chile for a short stay.',
    'Indian nationals visiting relatives or friends apply for the same consular Permanencia Transitoria visa as Tourist, adding an invitation letter from the host in Chile and documentary proof of the family relationship. This is distinct from the longer Family Reunification residence route (see Dependent).',
    'Up to 90 days, decided at entry even after consular pre-approval',
    'Apply in person at the Embassy of Chile, New Delhi with an invitation letter and relationship proof',
    1,
    'Reported processing of roughly 2-4 calendar weeks; apply well ahead of travel dates',
    'Embassy of Chile, New Delhi (Vasant Vihar) — primary visa-issuing post for India; honorary consulates also present in Mumbai, Chennai and Kolkata',
    'Obtain an invitation letter from your host in Chile\nGather documents proving the family or personal relationship\nComplete the visa application form\nBook an appointment and submit in person at the Embassy of Chile, New Delhi',
    '/assets/images/visa-heroes/chile.webp',
    'Cross-checked against secondary visa-agency and reciprocity-fee sourcing (ixigo, Skyscanner, BTW Visas); primary consulado.gob.cl and chile.gob.cl pages were egress-blocked this session', 'https://www.consulado.gob.cl/informacion-sobre-visas-para-ingresar-a-chile', '2026-09-17'
);
SET @chl5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@chl5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@chl5, 'Core Documents', 'Required from every applicant.', 1);
SET @chl5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@chl5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@chl5s1, 'Invitation Letter from Host in Chile', NULL, 'original', 1, 0, 1, 2),
(@chl5s1, 'Proof of Relationship', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@chl5, 'Supporting Documents', 'Evidence of your own means.', 2);
SET @chl5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@chl5s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 1),
(@chl5s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(200, 5, 42.00, 'USD', 'Permanencia Transitoria Visa Fee (Reported)', 'Multiple-entry reported at USD 76, same structure as Tourist. Reciprocity-based fee — reconfirm before relying on this figure, as the primary consulado.gob.cl fee schedule was not reachable this session.', '2026-09-01', NOW(), 'https://www.consulado.gob.cl/informacion-sobre-visas-para-ingresar-a-chile', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a Family Visit visa the same as Chile''s Family Reunification visa?', 'No — a short Family Visit uses the same consular Permanencia Transitoria (tourist-type) visa as Tourist, capped at 90 days, while Family Reunification (see Dependent) is a longer temporary-residence permit for those settling with a sponsor in Chile.', 200, 5, 20050, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Airport Transit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    200, 6, 'CHL-TRAN-IN-06', '2026.09', 'published',
    'Passing through a Chilean airport toward a non-Chilean destination.',
    'A transit visa is only needed if leaving the international transit area of the airport (e.g. to change terminals through immigration); passengers who remain airside for a same-day connection generally do not need one. Reported maximum transit stay is around 72 hours.',
    'Up to 72 hours, only if leaving the international transit area',
    'Apply at the Embassy of Chile, New Delhi only if your specific connection requires leaving the transit area; confirm with your airline first',
    1,
    'Confirm the requirement well ahead of travel; exact processing time was not clearly documented in sources reviewed this session',
    'Embassy of Chile, New Delhi (Vasant Vihar) — primary visa-issuing post for India; honorary consulates also present in Mumbai, Chennai and Kolkata',
    'Confirm with your airline whether your connection requires leaving the international transit area\nIf required, apply at the Embassy of Chile, New Delhi with your onward ticket and itinerary\nSubmit documents and any required biometrics',
    '/assets/images/visa-heroes/chile.webp',
    'Cross-checked against visa-agency secondary sourcing (Akbar Travels, BTW Visas) on the transit-visa/airside-connection distinction; primary chile.gob.cl pages were egress-blocked this session', 'https://www.akbartravels.com/in/visas/chile-transit-visa', '2026-09-17'
);
SET @chl6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@chl6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@chl6, 'Core Documents', 'Required if a transit visa is genuinely needed.', 1);
SET @chl6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@chl6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@chl6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@chl6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @chl6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@chl6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(200, 6, NULL, 'USD', 'Confirmed After Assessment', 'Fee for a genuine transit visa (when the international transit area must be left) was not clearly documented in sources reviewed this session — contact us or the Embassy to confirm.', '2026-09-01', NOW(), 'https://www.akbartravels.com/in/visas/chile-transit-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa just to change planes in Chile?', 'Not if you remain within the international transit area of the airport without passing through immigration. A transit visa is only required if your connection requires you to exit that area — confirm with your airline and the Chilean consulate before travelling.', 200, 6, 20060, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Temporary Residence for Medical Treatment
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    200, 7, 'CHL-MED-IN-07', '2026.09', 'published',
    'Receiving medical treatment from a healthcare provider registered with Chile''s Superintendencia de Salud.',
    'Indian nationals needing to start or continue treatment with a Chilean institutional or private healthcare provider registered with the Superintendencia de Salud (health regulator) apply for a medical-treatment temporary-residence permit via SERMIG; this route does not lead to permanent residency.',
    'Tied to the treatment plan; temporary-residence permits are typically valid up to 2 years',
    'Apply from outside Chile via SERMIG''s Portal de Trámites Digitales (ClaveÚnica login) with the treatment-provider letter',
    0,
    'Reported as generally processed within a few weeks',
    'Servicio Nacional de Migraciones (SERMIG) — online portal; Embassy of Chile, New Delhi for any consular visa stamp/entry formalities',
    'Confirm the treating institution/provider is registered with the Superintendencia de Salud\nObtain a letter outlining the treatment plan from that provider\nApply for the medical-treatment temporary-residence permit via SERMIG''s online portal\nGather proof of financial means to cover treatment and stay\nTravel to Chile once the permit is granted',
    '/assets/images/visa-heroes/chile.webp',
    'Cross-checked against SERMIG-summary secondary sourcing (Expat.cl) on the medical-treatment residence subcategory; primary serviciomigraciones.cl pages were egress-blocked this session', 'https://serviciomigraciones.cl/en/residencia-temporal-permit/subcategories/medical-treatment/', '2026-09-17'
);
SET @chl7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@chl7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@chl7, 'Core Documents', 'Required from every applicant.', 1);
SET @chl7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@chl7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@chl7s1, 'Treatment Plan Letter from Registered Provider', 'Provider must be registered with the Superintendencia de Salud.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@chl7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @chl7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@chl7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@chl7s2, 'Proof of Financial Means for Treatment and Stay', NULL, 'copy', 1, 0, 0, 2),
(@chl7s2, 'Criminal Record Certificate (Applicants 18+)', NULL, 'original', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(200, 7, NULL, 'USD', 'Confirmed After Assessment', 'Medical-treatment permit fee was not clearly documented in sources reviewed this session (serviciomigraciones.cl egress-blocked) — contact us or SERMIG to confirm.', '2026-09-01', NOW(), 'https://serviciomigraciones.cl/en/residencia-temporal-permit/subcategories/medical-treatment/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can any hospital in Chile sponsor a medical-treatment visa?', 'No — the treating institution or private provider must be registered with Chile''s Superintendencia de Salud (health regulator); treatment from an unregistered provider does not qualify for this permit category.', 200, 7, 20070, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Permanencia Transitoria (Consular)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    200, 8, 'CHL-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, congresses, and trade fairs in Chile.',
    'Indian nationals attending a conference apply for the same consular Permanencia Transitoria visa as Business/Tourist, with a conference invitation or registration confirmation as the differentiating document; Chile does not appear to operate a legally distinct Conference-visa category.',
    'Up to 90 days, decided at entry even after consular pre-approval',
    'Apply in person at the Embassy of Chile, New Delhi with a conference invitation/registration confirmation',
    1,
    'Reported processing of roughly 2-4 calendar weeks; apply well ahead of travel dates',
    'Embassy of Chile, New Delhi (Vasant Vihar) — primary visa-issuing post for India; honorary consulates also present in Mumbai, Chennai and Kolkata',
    'Obtain a conference invitation or registration confirmation\nGather proof of accommodation and return travel\nComplete the visa application form\nBook an appointment and submit in person at the Embassy of Chile, New Delhi',
    '/assets/images/visa-heroes/chile.webp',
    'Cross-checked against secondary visa-agency and reciprocity-fee sourcing (ixigo, Skyscanner, BTW Visas); primary consulado.gob.cl and chile.gob.cl pages were egress-blocked this session', 'https://www.consulado.gob.cl/informacion-sobre-visas-para-ingresar-a-chile', '2026-09-17'
);
SET @chl8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@chl8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@chl8, 'Core Documents', 'Required from every applicant.', 1);
SET @chl8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@chl8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@chl8s1, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@chl8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @chl8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@chl8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@chl8s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(200, 8, 42.00, 'USD', 'Permanencia Transitoria Visa Fee (Reported)', 'Multiple-entry reported at USD 76, same structure as Tourist. Reciprocity-based fee — reconfirm before relying on this figure, as the primary consulado.gob.cl fee schedule was not reachable this session.', '2026-09-01', NOW(), 'https://www.consulado.gob.cl/informacion-sobre-visas-para-ingresar-a-chile', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Chilean visa category just for conferences?', 'Not distinctly — sources reviewed this session indicate conference attendance is handled under the same consular Permanencia Transitoria visa as Business/Tourist, differentiated mainly by the invitation/registration document you submit.', 200, 8, 20080, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Permanencia Transitoria (Consular)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    200, 9, 'CHL-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing or officiating at events in Chile.',
    'Indian nationals travelling to compete or officiate apply for the same consular Permanencia Transitoria visa as Business/Tourist, typically supported by a letter from the home-country sports federation plus a host-event organizer invitation; Chile does not appear to operate a legally distinct Sports-visa category.',
    'Up to 90 days, decided at entry even after consular pre-approval',
    'Apply in person at the Embassy of Chile, New Delhi with federation and organizer letters',
    1,
    'Reported processing of roughly 2-4 calendar weeks; apply well ahead of travel dates',
    'Embassy of Chile, New Delhi (Vasant Vihar) — primary visa-issuing post for India; honorary consulates also present in Mumbai, Chennai and Kolkata',
    'Obtain a letter from your home-country sports federation confirming your role\nObtain an invitation letter from the host event organizer with event details\nGather proof of accommodation and return travel\nBook an appointment and submit in person at the Embassy of Chile, New Delhi',
    '/assets/images/visa-heroes/chile.webp',
    'Cross-checked against secondary visa-agency and reciprocity-fee sourcing (ixigo, Skyscanner, BTW Visas); primary consulado.gob.cl and chile.gob.cl pages were egress-blocked this session', 'https://www.consulado.gob.cl/informacion-sobre-visas-para-ingresar-a-chile', '2026-09-17'
);
SET @chl9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@chl9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@chl9, 'Core Documents', 'Required from every applicant.', 1);
SET @chl9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@chl9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@chl9s1, 'Home-Country Sports Federation Letter', 'Confirms role and no-employment status.', 'original', 1, 0, 1, 2),
(@chl9s1, 'Host Event Organizer Invitation Letter', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@chl9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @chl9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@chl9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(200, 9, 42.00, 'USD', 'Permanencia Transitoria Visa Fee (Reported)', 'Multiple-entry reported at USD 76, same structure as Tourist. Reciprocity-based fee — reconfirm before relying on this figure, as the primary consulado.gob.cl fee schedule was not reachable this session.', '2026-09-01', NOW(), 'https://www.consulado.gob.cl/informacion-sobre-visas-para-ingresar-a-chile', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What documents does a Chilean Sports visa need beyond a standard Tourist visa?', 'Reported requirements add a letter from your home-country sports federation confirming your role, alongside a host-event organizer invitation — submitted through the same Permanencia Transitoria visa route as Business/Tourist.', 200, 9, 20090, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Family Reunification Temporary Residence
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    200, 10, 'CHL-DEP-IN-10', '2026.09', 'published',
    'Spouse, civil partner, minor child, or dependent joining a family member with Chilean citizenship or residency.',
    'Family Reunification temporary-residence permit for dependents of a Chilean citizen or resident. Sponsors who are permanent residents or citizens face no financial-capacity requirement, while temporary-resident sponsors must show they can support the dependent. All foreign civil-status documents must be apostilled or legalized.',
    'Up to 2 years; eligible for permanent residency after just 12 months of residence',
    'Apply online via SERMIG''s digital portal; can also be filed from within Chile while on a tourist Permanencia Transitoria',
    0,
    'Exact processing time was not clearly documented in sources reviewed this session; SERMIG''s portal issues status updates online',
    'Servicio Nacional de Migraciones (SERMIG) — online portal; Embassy of Chile, New Delhi for any consular visa stamp/entry formalities',
    'Confirm the sponsor''s status (Chilean citizen, permanent resident, or temporary resident) and any financial-capacity requirement\nGather relationship proof (marriage/birth certificates), apostilled or legalized\nApply for Family Reunification temporary residence via SERMIG''s online portal\nAwait the outcome and any consular formalities\nRegister locally after arrival; apply for permanent residency once 12 months of residence are completed',
    '/assets/images/visa-heroes/chile.webp',
    'Cross-checked against SERMIG-summary and expatriate-family secondary sourcing (Expat.cl) on the Family Reunification residence subcategory; primary serviciomigraciones.cl pages were egress-blocked this session', 'https://serviciomigraciones.cl/en/residencia-temporal-permit/subcategories/family-reunification/', '2026-09-17'
);
SET @chl10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@chl10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@chl10, 'Core Documents', 'Required from every applicant.', 1);
SET @chl10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@chl10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@chl10s1, 'Apostilled/Legalized Marriage or Birth Certificate', 'Proves relationship to sponsor.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@chl10, 'Supporting Documents', 'Evidence tied to the sponsor''s status.', 2);
SET @chl10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@chl10s2, 'Sponsor''s Citizenship/Residency Proof', NULL, 'copy', 1, 0, 0, 1),
(@chl10s2, 'Proof of Financial Support (Temporary-Resident Sponsors Only)', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(200, 10, NULL, 'USD', 'Confirmed After Assessment', 'SERMIG''s Family Reunification fee was not clearly documented in sources reviewed this session; some sources cite a general permanent-residence fee around CLP 138,974, which is a different category — reconfirm the correct figure before applying.', '2026-09-01', NOW(), 'https://serviciomigraciones.cl/en/residencia-temporal-permit/subcategories/family-reunification/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How fast can a Family Reunification dependent get permanent residency in Chile?', 'Reported sourcing indicates eligibility as soon as 12 months into the temporary Family Reunification residence permit — notably faster than most other residence tracks.', 200, 10, 20100, 1),
('Do foreign marriage or birth certificates need special processing for this visa?', 'Yes — all civil-status documents issued abroad must be apostilled or legalized (per Articles 345 and 345 bis of Chile''s Code of Civil Procedure) before submission.', 200, 10, 20101, 1);
