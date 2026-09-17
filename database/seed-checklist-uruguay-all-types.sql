-- Uruguay Visa Checklist Engine content for all 10 visa types —
-- built fresh this session via web search. hero_image_url left NULL at
-- authoring time (no photo bundle supplied yet for this batch).
--
-- IMPORTANT SOURCING CAVEAT: the official gub.uy domains (including
-- migracion.minterior.gub.uy and www.gub.uy/ministerio-relaciones-exteriores),
-- and most secondary visa-agency sites (MakeMyTrip, Atlys, Mondy, ixigo,
-- Holidify, VisaHQ, Wikipedia, embassyinformation.com) were NOT directly
-- fetchable this session (WebFetch returned EGRESS_BLOCKED for every
-- domain tried). All findings below were triangulated through WebSearch
-- result summaries only, which quote and link those same secondary
-- sources. Fee and processing-time figures vary across sources and are
-- flagged as approximate/reported throughout. Categories with genuinely
-- thin search coverage are explicitly marked "NOT independently
-- confirmed this session" in their processing_note or fee note.
--
-- Uruguay's real, distinctive facts (as found via WebSearch this session):
--   - Indian passport holders DO need a consular visa for Uruguay for
--     every purpose covered here — Uruguay is not visa-exempt, has no
--     eVisa, and has no visa-on-arrival for India, contrary to a common
--     assumption that South American entry is easy for Indians.
--   - Multiple independent secondary sources (MakeMyTrip-linked, ixigo)
--     report that the standard USD 42 consular visa fee is specifically
--     waived for Indian nationals (most other nationalities pay it) —
--     flagged as reported/unconfirmed rather than officially verified.
--   - A genuine two-stage process: applicants submit an initial request
--     that must receive pre-authorization from the Dirección Nacional de
--     Migración (DNM) BEFORE an embassy appointment can even be booked —
--     distinct from a single-step consular visa application.
--   - There is reportedly no separate "work permit" in Uruguay — work
--     authorization flows entirely from DNM-granted residence status
--     (temporary or permanent), not a standalone document. A Hoja de
--     Identidad Provisoria (HIP, provisional ID) can bridge roughly 6
--     months while full residence (reported at 6-12 months) is processed.
--   - Student and Family Reunification (Dependent) entry visas are both
--     reportedly single-entry, short-validity documents (student: 30
--     days to enter; family reunification: 180 days to use, 30-day stay)
--     that exist only to get the applicant into the country — the real
--     legal status is then obtained in-country from DNM within 30 days.
--   - Family Reunification is reported to bridge directly to PERMANENT
--     residency, skipping the temporary-residency step other routes use.
--   - Airport transit at Carrasco International Airport reportedly does
--     not need a visa for connections under 24 hours that stay airside;
--     a transit visa is only needed if leaving the transit area or
--     exceeding that 24-hour window.
--   - The sole diplomatic mission found handling Indian applications is
--     the Embassy of Uruguay in New Delhi (B-8/3, Vasant Vihar) — no
--     VFS Global or other outsourced visa centre for Uruguay in India
--     was found in this session's searches.
--
-- country_id 207 = Uruguay. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Consular Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    207, 1, 'URY-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Uruguay.',
    'Indian passport holders — Uruguay is not visa-exempt for India; a consular visa is required for all short-stay purposes, obtained via a two-stage process: Dirección Nacional de Migración (DNM) pre-authorization, then an in-person embassy appointment.',
    'Up to 90 days per entry; single or multiple entry depending on the visa granted',
    'Apply directly at the Embassy of Uruguay, New Delhi — no VFS/outsourced centre found; DNM pre-authorization is required before booking',
    1,
    'Reported range 15-30 working days total including DNM pre-authorization; some sources cite as little as 2-3 days once approved',
    'Embassy of Uruguay, New Delhi (B-8/3, Vasant Vihar) — sole mission found handling Indian applications',
    'Submit an initial visa request to the Embassy of Uruguay, New Delhi\nAwait pre-authorization from the Dirección Nacional de Migración (DNM)\nBook and attend the embassy appointment with your documents\nPay the visa fee if applicable\nCollect your passport with the visa',
    '/assets/images/visa-heroes/uruguay.webp',
    'Triangulated via WebSearch across visa-agency secondary sourcing (MakeMyTrip, ixigo, Mondy, Akbar Travels) — official gub.uy/migracion.minterior.gub.uy pages returned EGRESS_BLOCKED on direct fetch this session', 'https://migracion.minterior.gub.uy/', '2026-09-17'
);
SET @ury1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ury1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ury1, 'Core Documents', 'Required from every applicant.', 1);
SET @ury1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ury1s1, 'Valid Passport (6+ Months Validity)', 'Must have at least one blank visa page.', 'original', 1, 0, 1, 1),
(@ury1s1, 'Completed Visa Application Form', NULL, 'original', 1, 0, 1, 2),
(@ury1s1, 'Passport-Size Photograph', NULL, 'original', 1, 0, 1, 3),
(@ury1s1, 'Cover Letter Stating Purpose of Visit', NULL, 'original', 1, 0, 1, 4);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ury1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @ury1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ury1s2, 'Confirmed Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 1),
(@ury1s2, 'Hotel Booking or Host Contact Details in Uruguay', 'A confirmed hotel booking if you have no local contact.', 'copy', 1, 0, 0, 2),
(@ury1s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 3),
(@ury1s2, 'Employer Leave-Approval Letter', NULL, 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(207, 1, 0.00, 'USD', 'Consular Visa Fee (Reported Waived for Indian Nationals)', 'The standard consular visa fee is reported at USD 42 for most nationalities, but multiple secondary sources report Indian nationals pay no fee. This is reported, not officially confirmed this session — verify with the embassy before applying.', '2026-09-01', NOW(), 'https://migracion.minterior.gub.uy/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa to visit Uruguay?', 'Yes — Uruguay is not visa-exempt for Indian passport holders and has no eVisa or visa-on-arrival option for India. A consular visa must be obtained in advance.', 207, 1, 20700, 1),
('Why does the Uruguay visa process involve two stages?', 'Applicants must first get pre-authorization from the Dirección Nacional de Migración (DNM) before an embassy appointment can be booked — this two-stage structure is distinctive to Uruguay''s process and adds to overall processing time.', 207, 1, 20701, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Consular Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    207, 2, 'URY-BUS-IN-02', '2026.09', 'published',
    'Trade, negotiations, and commercial meetings in Uruguay.',
    'Indian nationals travelling for business — same consular-visa requirement as Tourist, with an invitation letter from the Uruguayan host company/organization (on letterhead, addressed to the embassy) as the differentiating document.',
    'Up to 90 days per entry; single or multiple entry depending on the visa granted',
    'Apply directly at the Embassy of Uruguay, New Delhi, with a business invitation letter; DNM pre-authorization required before booking',
    1,
    'Reported range 15-30 working days total including DNM pre-authorization',
    'Embassy of Uruguay, New Delhi (B-8/3, Vasant Vihar)',
    'Obtain an invitation letter from the Uruguayan host company/organization, on letterhead\nSubmit the initial visa request to the embassy\nAwait DNM pre-authorization\nAttend the embassy appointment and submit documents\nCollect your passport with the visa',
    '/assets/images/visa-heroes/uruguay.webp',
    'Triangulated via WebSearch across visa-agency secondary sourcing (BTW Visas, MakeMyTrip, Akbar Travels) — official gub.uy pages returned EGRESS_BLOCKED on direct fetch this session', 'https://migracion.minterior.gub.uy/', '2026-09-17'
);
SET @ury2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ury2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ury2, 'Core Documents', 'Required from every applicant.', 1);
SET @ury2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ury2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ury2s1, 'Invitation Letter from Uruguayan Host Company', 'On letterhead, signed by the responsible authority, with the inviter''s contact details and purpose of visit.', 'original', 1, 0, 1, 2),
(@ury2s1, 'Completed Visa Application Form', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ury2, 'Supporting Documents', 'Evidence of your own employment and means.', 2);
SET @ury2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ury2s2, 'Letter from Indian Employer', 'Confirms company name, business profile, and applicant''s position.', 'original', 1, 0, 0, 1),
(@ury2s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 2),
(@ury2s2, 'Confirmed Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(207, 2, 0.00, 'USD', 'Consular Visa Fee (Reported Waived for Indian Nationals)', 'Same fee structure as Tourist — standard USD 42 for most nationalities, reported as waived for Indian nationals per multiple secondary sources; not officially confirmed this session.', '2026-09-01', NOW(), 'https://migracion.minterior.gub.uy/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What must the Uruguayan invitation letter for a Business visa include?', 'It should be on the host company''s letterhead, signed by the responsible authority, addressed to the embassy, and include the inviter''s contact details, the purpose of the visit, and sponsorship arrangements if any.', 207, 2, 20702, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Entry Visa + In-Country Residence
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    207, 3, 'URY-STU-IN-03', '2026.09', 'published',
    'Enrolling in a Uruguayan university or educational institution.',
    'Indian nationals admitted to a recognized Uruguayan institution. The entry visa itself is reportedly single-entry and valid only 30 days for entry; you must then apply for a student residence permit with DNM within 30 days of arriving in Uruguay.',
    'Entry visa valid 30 days to enter Uruguay; residence permit thereafter covers the program duration',
    'Apply for the entry visa at the Embassy of Uruguay, New Delhi; register for residence with DNM in Uruguay within 30 days of arrival',
    1,
    'Entry-visa stage reported at 15-30 working days including DNM pre-authorization; in-country residence timeline NOT independently confirmed this session',
    'Embassy of Uruguay, New Delhi for the entry visa; Dirección Nacional de Migración (Montevideo) for residence afterward',
    'Secure admission at a recognized Uruguayan institution\nGather proof of funds and a local contact/reference in Uruguay\nApply for the entry visa at the Embassy of Uruguay, New Delhi\nEnter Uruguay within the visa''s 30-day validity\nApply for a student residence permit with DNM within 30 days of arrival',
    '/assets/images/visa-heroes/uruguay.webp',
    'Triangulated via WebSearch summaries referencing visadb.io and embassy-of-Uruguay study-abroad guidance — official gub.uy/migracion.minterior.gub.uy pages returned EGRESS_BLOCKED on direct fetch this session', 'https://migracion.minterior.gub.uy/', '2026-09-17'
);
SET @ury3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ury3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ury3, 'Core Documents', 'Required from every applicant.', 1);
SET @ury3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ury3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ury3s1, 'Proof of Enrollment/Registration', 'On institution letterhead, signed by its legal representative, including the MEC registration/authorization number.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ury3, 'Supporting Documents', 'Evidence of funds and local contact.', 2);
SET @ury3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ury3s2, 'Proof of Funds', 'Bank statements for the last 3 months, proof of salary, or an international credit card.', 'copy', 1, 0, 0, 1),
(@ury3s2, 'Local Reference/Contact in Uruguay', NULL, 'copy', 1, 0, 0, 2),
(@ury3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 3),
(@ury3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(207, 3, NULL, 'USD', 'Confirmed After Assessment', 'The entry-visa fee is reported as the same as Tourist (waived for Indian nationals per secondary sources); the subsequent DNM student residence-permit fee is set in Unidades Reajustables and was NOT independently confirmed this session.', '2026-09-01', NOW(), 'https://migracion.minterior.gub.uy/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does the Student entry visa cover my full study period in Uruguay?', 'No — it reportedly covers only 30 days to enter the country. Your actual legal status for the study period comes from a separate student residence permit you must apply for with DNM within 30 days of arrival.', 207, 3, 20703, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — DNM Residence Confers Work Authorization
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    207, 4, 'URY-WORK-IN-04', '2026.09', 'published',
    'Employment with a Uruguayan employer; work authorization flows from DNM residence status, not a separate standalone work permit.',
    'Indian nationals with a confirmed job offer from a Uruguayan employer registered with DGI/BPS and authorized by the Ministry of Labour (MTSS). After entry, a Hoja de Identidad Provisoria (provisional ID) can bridge roughly 6 months while full DNM residence, which confers work authorization, is processed.',
    'HIP bridges roughly 6 months; residence, once granted, is not tied to a fixed work-authorization expiry',
    'Apply for the entry visa at the Embassy of Uruguay, New Delhi if required, then register for DNM residence in Uruguay after arrival',
    1,
    'Employer-sponsored work-authorization stage reported at 2-6 months; full residence processing commonly cited at 6-12 months overall',
    'Embassy of Uruguay, New Delhi for the entry visa; Dirección Nacional de Migración (Montevideo) for residence and work authorization',
    'Secure a job offer from a DGI/BPS-registered Uruguayan employer\nEmployer obtains authorization from the Ministry of Labour (MTSS)\nApply for the entry visa at the Embassy of Uruguay if your nationality requires one\nEnter Uruguay and obtain a Hoja de Identidad Provisoria (HIP)\nApply for DNM residence, which confers ongoing work authorization',
    '/assets/images/visa-heroes/uruguay.webp',
    'Triangulated via WebSearch across employer-of-record guidance (Playroll, Remote.com, Rivermate, G-P) — official gub.uy/migracion.minterior.gub.uy pages returned EGRESS_BLOCKED on direct fetch this session', 'https://migracion.minterior.gub.uy/', '2026-09-17'
);
SET @ury4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ury4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ury4, 'Core Documents', 'Required from every applicant.', 1);
SET @ury4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ury4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ury4s1, 'Notarized Job Offer/Labour Promise', 'Detailing the company''s activity, tax IDs, job role, and the legal representative''s signature.', 'original', 1, 0, 1, 2),
(@ury4s1, 'Ministry of Labour (MTSS) Employer Authorization', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ury4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @ury4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ury4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@ury4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2),
(@ury4s2, 'Proof of Financial Means', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(207, 4, NULL, 'USD', 'Confirmed After Assessment', 'DNM residence-permit fees are set in Unidades Reajustables/Indexadas and vary by permit type; a comparable figure for a different route (Independent Means Visa) was reported at roughly USD 200-400, but the employment-residence fee itself was NOT independently confirmed this session.', '2026-09-01', NOW(), 'https://migracion.minterior.gub.uy/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a standalone Uruguay work permit separate from residence?', 'No — reported sourcing indicates Uruguay has no standalone work permit. Work authorization comes from DNM-granted residence status (temporary or permanent), with a Hoja de Identidad Provisoria bridging roughly the first 6 months while residence is processed.', 207, 4, 20704, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Consular Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    207, 5, 'URY-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives or friends resident in Uruguay, on a short-stay basis.',
    'Indian nationals with family or friends in Uruguay — same consular-visa requirement as Tourist, needing an invitation letter from the host and proof of the relationship. Distinct from the Dependent/Family Reunification route, which leads to permanent residency.',
    'Up to 90 days per entry; single or multiple entry depending on the visa granted',
    'Apply directly at the Embassy of Uruguay, New Delhi, with a host invitation letter; DNM pre-authorization required before booking',
    1,
    'Reported range 15-30 working days total including DNM pre-authorization',
    'Embassy of Uruguay, New Delhi (B-8/3, Vasant Vihar)',
    'Obtain an invitation letter from your host in Uruguay\nGather documents proving the family/personal relationship\nSubmit the initial visa request to the embassy\nAwait DNM pre-authorization, then attend the embassy appointment\nCollect your passport with the visa',
    '/assets/images/visa-heroes/uruguay.webp',
    'Triangulated via WebSearch across visa-agency secondary sourcing — official gub.uy pages returned EGRESS_BLOCKED on direct fetch this session', 'https://migracion.minterior.gub.uy/', '2026-09-17'
);
SET @ury5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ury5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ury5, 'Core Documents', 'Required from every applicant.', 1);
SET @ury5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ury5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ury5s1, 'Invitation Letter from Host in Uruguay', NULL, 'original', 1, 0, 1, 2),
(@ury5s1, 'Proof of Relationship', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ury5, 'Supporting Documents', 'Evidence of your own means.', 2);
SET @ury5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ury5s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 1),
(@ury5s2, 'Confirmed Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(207, 5, 0.00, 'USD', 'Consular Visa Fee (Reported Waived for Indian Nationals)', 'Same fee structure as Tourist — standard USD 42 for most nationalities, reported as waived for Indian nationals per multiple secondary sources; not officially confirmed this session.', '2026-09-01', NOW(), 'https://migracion.minterior.gub.uy/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Family Visit the same as the Dependent/Family Reunification visa?', 'No — Family Visit is a short-stay visit (like Tourist, capped at 90 days) with no residency intent, while Dependent/Family Reunification is an immigration route that leads directly to permanent residency.', 207, 5, 20705, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Airport Transit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    207, 6, 'URY-TRAN-IN-06', '2026.09', 'published',
    'Passing through Carrasco International Airport toward a connecting flight.',
    'Indian nationals connecting through Uruguay — a transit visa is reportedly only required if you leave the airport transit area or your layover exceeds the 24-hour limit at Carrasco International Airport; purely airside connections under 24 hours reportedly don''t need one.',
    'Up to 24 hours airside at Carrasco International Airport without a visa; longer or landside transit needs a transit visa',
    'Apply at the Embassy of Uruguay, New Delhi only if your specific connection requires it (leaving the transit area or exceeding 24 hours)',
    1,
    'NOT independently confirmed this session — treat as approximate; confirm with the embassy whether your specific itinerary requires a transit visa',
    'Embassy of Uruguay, New Delhi (B-8/3, Vasant Vihar)',
    'Check your connection time and whether you must leave the transit area at Carrasco International Airport\nIf a transit visa is needed, submit the initial visa request to the embassy\nAwait DNM pre-authorization, then attend the embassy appointment\nCollect your passport with the visa',
    '/assets/images/visa-heroes/uruguay.webp',
    'Triangulated via WebSearch summaries on Uruguay airport transit rules — official gub.uy pages returned EGRESS_BLOCKED on direct fetch this session', 'https://migracion.minterior.gub.uy/', '2026-09-17'
);
SET @ury6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ury6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ury6, 'Core Documents', 'Required if a transit visa is genuinely needed.', 1);
SET @ury6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ury6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ury6s1, 'Onward/Connecting Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ury6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @ury6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ury6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(207, 6, NULL, 'USD', 'Confirmed After Assessment', 'Fee, when a transit visa is genuinely required, was NOT independently confirmed this session — likely follows the same fee treatment as the Tourist consular visa, but verify before applying.', '2026-09-01', NOW(), 'https://migracion.minterior.gub.uy/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a transit visa for a short layover in Uruguay?', 'Reportedly not, if you stay airside at Carrasco International Airport for under 24 hours. A transit visa is only needed if you must leave the transit area or your layover exceeds that window — confirm with the embassy for your specific itinerary.', 207, 6, 20706, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Consular Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    207, 7, 'URY-MED-IN-07', '2026.09', 'published',
    'Travel to Uruguay for medical treatment.',
    'Indian nationals travelling for treatment — same consular-visa requirement as Tourist, with a certificate/invitation from the treating Uruguayan institution and proof of funds for treatment as the differentiating documents.',
    'Up to 90 days per entry; single or multiple entry depending on the visa granted',
    'Apply directly at the Embassy of Uruguay, New Delhi, with a medical certificate; DNM pre-authorization required before booking',
    1,
    'Reported range 15-30 working days total including DNM pre-authorization',
    'Embassy of Uruguay, New Delhi (B-8/3, Vasant Vihar)',
    'Obtain a certificate/invitation from the treating Uruguayan doctor or institution\nGather proof of funds for treatment\nSubmit the initial visa request to the embassy\nAwait DNM pre-authorization, then attend the embassy appointment\nCollect your passport with the visa',
    '/assets/images/visa-heroes/uruguay.webp',
    'Triangulated via WebSearch across visa-agency secondary sourcing (structure inferred from the general consular-visa process; medical-specific detail NOT independently confirmed this session) — official gub.uy pages returned EGRESS_BLOCKED on direct fetch', 'https://migracion.minterior.gub.uy/', '2026-09-17'
);
SET @ury7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ury7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ury7, 'Core Documents', 'Required from every applicant.', 1);
SET @ury7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ury7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ury7s1, 'Medical Certificate/Institution Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ury7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @ury7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ury7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@ury7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2),
(@ury7s2, 'Attendant/Companion Documents (If Applicable)', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(207, 7, 0.00, 'USD', 'Consular Visa Fee (Reported Waived for Indian Nationals)', 'Assumed same fee structure as Tourist — standard USD 42 for most nationalities, reported as waived for Indian nationals per multiple secondary sources; medical-specific fee treatment NOT independently confirmed this session.', '2026-09-01', NOW(), 'https://migracion.minterior.gub.uy/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a companion/attendant covered under the same Medical visa?', 'A companion generally needs their own separate visa application with equivalent documentation — this specific point was NOT independently confirmed this session, so verify directly with the embassy.', 207, 7, 20707, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Consular Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    207, 8, 'URY-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, congresses, and trade fairs in Uruguay.',
    'Indian nationals attending a conference — same consular-visa requirement as Tourist/Business, with a conference invitation or registration confirmation from the hosting Uruguayan institution or organizer.',
    'Up to 90 days per entry; single or multiple entry depending on the visa granted',
    'Apply directly at the Embassy of Uruguay, New Delhi, with a conference invitation; DNM pre-authorization required before booking',
    1,
    'Reported range 15-30 working days total including DNM pre-authorization',
    'Embassy of Uruguay, New Delhi (B-8/3, Vasant Vihar)',
    'Obtain a conference invitation or registration confirmation from the Uruguayan host/organizer\nGather proof of accommodation and return travel\nSubmit the initial visa request to the embassy\nAwait DNM pre-authorization, then attend the embassy appointment\nCollect your passport with the visa',
    '/assets/images/visa-heroes/uruguay.webp',
    'Triangulated via WebSearch across the general consular-visa/Business-visa process — official gub.uy pages returned EGRESS_BLOCKED on direct fetch; conference-specific detail NOT independently confirmed this session', 'https://migracion.minterior.gub.uy/', '2026-09-17'
);
SET @ury8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ury8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ury8, 'Core Documents', 'Required from every applicant.', 1);
SET @ury8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ury8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ury8s1, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ury8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @ury8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ury8s2, 'Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@ury8s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(207, 8, 0.00, 'USD', 'Consular Visa Fee (Reported Waived for Indian Nationals)', 'Assumed same fee structure as Tourist/Business — standard USD 42 for most nationalities, reported as waived for Indian nationals per multiple secondary sources; conference-specific fee treatment NOT independently confirmed this session.', '2026-09-01', NOW(), 'https://migracion.minterior.gub.uy/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Conference visa processed differently from a Business visa?', 'The underlying consular-visa process and pre-authorization requirement appear to be the same; only the differentiating document (conference invitation vs. business invitation) changes. This was not exhaustively confirmed this session.', 207, 8, 20708, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Consular Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    207, 9, 'URY-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in Uruguay.',
    'Indian nationals competing or officiating — same consular-visa requirement as Tourist/Conference, generally needing an invitation from the host event organizer plus a letter from the Indian sports association confirming role and no-employment status.',
    'Up to 90 days per entry; single or multiple entry depending on the visa granted',
    'Apply directly at the Embassy of Uruguay, New Delhi, with organizer and association letters; DNM pre-authorization required before booking',
    1,
    'Reported range 15-30 working days total including DNM pre-authorization; sports-specific timeline NOT independently confirmed this session',
    'Embassy of Uruguay, New Delhi (B-8/3, Vasant Vihar)',
    'Obtain an invitation letter from the host event organizer in Uruguay\nObtain a letter from your Indian sports association confirming role and no-employment status\nSubmit the initial visa request to the embassy\nAwait DNM pre-authorization, then attend the embassy appointment\nCollect your passport with the visa',
    '/assets/images/visa-heroes/uruguay.webp',
    'Structure inferred from the general consular-visa/Conference-visa process via WebSearch; sports-specific detail NOT independently confirmed this session — official gub.uy pages returned EGRESS_BLOCKED on direct fetch', 'https://migracion.minterior.gub.uy/', '2026-09-17'
);
SET @ury9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ury9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ury9, 'Core Documents', 'Required from every applicant.', 1);
SET @ury9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ury9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ury9s1, 'Host Event Organizer Invitation Letter', NULL, 'original', 1, 0, 1, 2),
(@ury9s1, 'Indian Sports Association Letter', 'Confirms role and no-employment status.', 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ury9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @ury9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ury9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(207, 9, 0.00, 'USD', 'Consular Visa Fee (Reported Waived for Indian Nationals)', 'Assumed same fee structure as Tourist/Conference — standard USD 42 for most nationalities, reported as waived for Indian nationals per multiple secondary sources; sports-specific fee treatment NOT independently confirmed this session.', '2026-09-01', NOW(), 'https://migracion.minterior.gub.uy/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What letters does a Sports visa applicant need beyond a standard invitation?', 'Typically two: one from the host event organizer in Uruguay, and one from the applicant''s Indian sports association confirming their role and that they are not taking up paid employment.', 207, 9, 20709, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Family Reunification
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    207, 10, 'URY-DEP-IN-10', '2026.09', 'published',
    'Spouse, minor children, or dependent family members joining a Uruguayan resident or permanent resident.',
    'Family members of a person who is a Uruguayan permanent resident, or in the process of becoming one, with legally accredited income on file with DNM and the Uruguay-based family member''s express consent. This route reportedly leads directly to permanent residency, without needing to pass through temporary residency first.',
    'Entry visa: single entry, valid 180 days to use, with a 30-day stay to begin in-country residency processing',
    'Apply for the entry visa at the Embassy of Uruguay, New Delhi, then register for residency with DNM in Uruguay within 30 days of arrival',
    1,
    'Entry-visa stage reported at 15-30 working days; in-country residency-stage timeline NOT independently confirmed this session',
    'Embassy of Uruguay, New Delhi for the entry visa; Dirección Nacional de Migración (Montevideo) for residency afterward',
    'Confirm the sponsor''s status as, or path to, Uruguayan permanent residency, with income accredited to DNM\nGather apostilled proof of relationship (marriage/birth certificate) and a copy of the sponsor''s Uruguayan ID\nApply for the entry visa at the Embassy of Uruguay, New Delhi\nEnter Uruguay within the visa''s validity window\nApply for residency with DNM within 30 days of arrival',
    '/assets/images/visa-heroes/uruguay.webp',
    'Triangulated via WebSearch across family-reunification guidance (Embassy of Uruguay in the US, ResidenciasUy) — official gub.uy/migracion.minterior.gub.uy pages returned EGRESS_BLOCKED on direct fetch this session', 'https://migracion.minterior.gub.uy/', '2026-09-17'
);
SET @ury10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ury10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ury10, 'Core Documents', 'Required from every applicant.', 1);
SET @ury10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ury10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@ury10s1, 'Apostilled Marriage/Birth Certificate', 'Proves the family relationship to the sponsor.', 'original', 1, 0, 1, 2),
(@ury10s1, 'Copy of Sponsor''s Uruguayan Identification Document', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ury10, 'Supporting Documents', 'Evidence tied to the sponsor''s status and income.', 2);
SET @ury10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ury10s2, 'Sponsor''s Proof of Legally Accredited Income', 'Filed with DNM by the Uruguay-based sponsor.', 'copy', 1, 0, 0, 1),
(@ury10s2, 'Sponsor''s Written Consent to the Reunification', NULL, 'original', 1, 0, 0, 2),
(@ury10s2, 'Police Clearance Certificate', NULL, 'original', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(207, 10, NULL, 'USD', 'Confirmed After Assessment', 'DNM family-reunification residency fees are set in Unidades Reajustables/Indexadas and vary; a comparable figure from a different route (Independent Means Visa) was reported at roughly USD 200-400, but the family-reunification fee itself was NOT independently confirmed this session.', '2026-09-01', NOW(), 'https://migracion.minterior.gub.uy/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Family Reunification go through temporary residency first?', 'Reportedly no — this route is described as a direct bridge to permanent residency, bypassing the temporary-residency step that other routes require. Confirm the current rule with DNM for your specific case.', 207, 10, 20710, 1),
('Who can sponsor a Family Reunification applicant?', 'Reportedly a Uruguayan permanent resident, or someone in the process of becoming one, who has accredited income to DNM and gives express consent to the reunification — eligible relations include parents, spouses, minor unmarried children, and adult children with disabilities.', 207, 10, 20711, 1);
