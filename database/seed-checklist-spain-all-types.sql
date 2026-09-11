-- Spain Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search, same standard as every other
-- country built this session (see AUDIT.md). hero_image_url points at
-- the real Seville photo supplied by the client for this hero.
--
-- Spain is Schengen, structurally similar to France/Germany/Italy/
-- Netherlands (already built), but its real, Spain-SPECIFIC facts are
-- genuinely different, not a copy-paste of those countries:
--   - Student carries a real, distinctive two-step Spanish ID process:
--     an NIE (foreigner ID number) is automatically assigned when the
--     visa is approved, but the student must SEPARATELY apply for a
--     physical TIE card at the local Oficina de Extranjería/police
--     station within 30 days of arrival — a genuinely different final
--     step from other Schengen states built this session.
--   - Work has no Italy-style annual flow-quota (Decreto Flussi).
--     Instead the employer must obtain a real "autorización de
--     trabajo" via a genuine labour-market test (advertising through
--     SEPE, Spain's public employment service) — UNLESS the role
--     appears on Spain's own shortage-occupation list (Catálogo de
--     Ocupaciones de Difícil Cobertura), which exempts the test
--     entirely. A separate, genuinely distinct fast-track exists:
--     UGE-CE (Unidad de Grandes Empresas y Colectivos Estratégicos), a
--     centralized Madrid unit for highly qualified professionals/Blue
--     Card/intra-company transfers/large strategic companies, deciding
--     within 20 business days with "positive administrative silence"
--     (deemed-approved if no response) and bypassing the labour-market
--     test.
--   - Transit is the OPPOSITE of the Netherlands' own exemption: Spain
--     genuinely requires an Airport Transit Visa (ATV) for Indian
--     passport holders even when staying airside, listing India among
--     a short set of nationalities subject to this rule — stated
--     honestly as Spain's own stricter policy, not assumed to match
--     the Netherlands' exemption just because both are Schengen.
--   - Family Visit requires a "carta de invitación" typically
--     formalized by the Spanish host at their local police station
--     (Comisaría) or via municipal registration (empadronamiento) — a
--     materially different formalization mechanism from a simple
--     letter.
--   - Dependent (Reagrupación Familiar) sponsor income is pegged to
--     Spain's real IPREM benchmark (frozen at EUR 600/month through
--     2026), not a generic fabricated threshold — 150% IPREM for the
--     first family member plus 50% IPREM per additional dependent,
--     reduced to the national minimum wage (SMI) level when minors are
--     among the dependents.
--
-- country_id 148 = Spain. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Schengen Short-Stay (Type C)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    148, 1, 'ESP-TOUR-IN-01', '2026.09', 'published',
    'Leisure travel, sightseeing, and short personal visits to Spain and the wider Schengen area.',
    'Indian passport holders must obtain a Schengen visa before travelling. Applications are submitted via BLS International (Spain''s official outsourced visa partner in India) with mandatory biometric data collection.',
    'Up to 90 days within any 180-day period (Schengen short-stay)',
    'Short-stay Schengen visa (Type C), submitted via BLS International with biometrics',
    1,
    'Biometric data, once captured, is valid 5 years in the EU''s Visa Information System (VIS)',
    'BLS International Spain Visa Application Centre, India',
    'Initial consultation to confirm Tourist Visa is the right category\nGather documents against this checklist, including a confirmed round-trip itinerary\nBook your BLS International appointment\nAttend in person for biometrics (mandatory for first-time applicants)\nSubmission of your application and documents\nDecision — visa sticker affixed to your passport once approved',
    '/assets/images/visa-heroes/spain.jpg',
    'Spanish Ministry of Foreign Affairs (exteriores.gob.es) Schengen visa guidance, cross-checked via BLS International Spain India sourcing', 'https://www.exteriores.gob.es/', '2026-09-11'
);
SET @es1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@es1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es1, 'Core Documents', 'Every applicant needs these.', 1);
SET @es1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es1s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@es1s1, 'Passport Photographs', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es1, 'Financial & Travel Documents', 'Evidence you can support your trip.', 2);
SET @es1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es1s2, 'Bank Statements (3 Months)', NULL, 'copy', 1, 0, 1, 1),
(@es1s2, 'Schengen Travel Insurance', 'Minimum EUR 30,000 medical coverage.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es1, 'Application Documents', 'Your formal application paperwork.', 3);
SET @es1s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es1s3, 'Confirmed Round-Trip Itinerary & Hotel Bookings', NULL, 'original', 1, 0, 0, 1),
(@es1s3, 'Employer NOC / ITR', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es1, 'Appointment & Submission', 'Booking and attending your BLS appointment.', 4);
SET @es1s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es1s4, 'BLS Appointment & Biometrics', 'Mandatory in-person biometric data collection.', 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(148, 1, 90.00, 'EUR', 'Schengen Short-Stay Visa Fee', 'EUR 90 for adults 12+, EUR 45 for children 6-11. A separate BLS International service charge (roughly INR 1,500) is additional.', '2024-06-11', NOW(), 'https://www.exteriores.gob.es/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Where do I apply for a Spain visa in India?', 'Through BLS International, Spain''s official outsourced visa partner in India, with centres in Delhi, Mumbai, Bengaluru, Chennai, and Kolkata.', 148, 1, 1190, 1),
('How long is my biometric data valid?', '5 years in the EU''s Visa Information System (VIS), so repeat applicants within that window may not need to re-enrol.', 148, 1, 1191, 1),
('Is there an extra service charge beyond the visa fee?', 'Yes — BLS International charges a separate service fee (roughly INR 1,500) on top of the EUR 90 Schengen fee.', 148, 1, 1192, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Schengen Short-Stay (Type C)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    148, 2, 'ESP-BUS-IN-02', '2026.09', 'published',
    'Short business visits — meetings, negotiations, and site visits — to Spain.',
    'The invitation letter from your Spanish host company must carry the company''s CIF (tax ID) number, the authorized signatory''s name and designation, company stamp, and purpose/dates of visit — often required bilingually in English and Spanish.',
    'Up to 90 days within any 180-day period (Schengen short-stay)',
    'Short-stay Schengen visa (Type C), submitted via BLS International with biometrics',
    1,
    'Biometric data, once captured, is valid 5 years in VIS',
    'BLS International Spain Visa Application Centre, India',
    'Initial consultation to confirm the trip is a genuine business visit\nObtain an invitation letter with your Spanish host''s CIF number and signatory details\nGather documents against this checklist\nBook your BLS International appointment and attend biometrics\nSubmission of your application and documents\nCollect your passport once approved',
    '/assets/images/visa-heroes/spain.jpg',
    'Spanish Embassy New Delhi Schengen visa specific documentation requirements', 'https://www.exteriores.gob.es/DocumentosSC/India/NUEVA%20DELHI%20(E)/Visados/1%20LIST%20SPECIFIC%20DOCUMENTATION%20REQUESTED.%20SCHENGEN%20VISAS.pdf', '2026-09-11'
);
SET @es2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@es2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es2, 'Core Documents', 'Every applicant needs these.', 1);
SET @es2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@es2s1, 'Passport Photographs', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es2, 'Business Invitation & Purpose', 'Evidence of who you are meeting and why.', 2);
SET @es2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es2s2, 'Invitation Letter with CIF Number', 'Signatory name/designation, company stamp, bilingual where required.', 'original', 1, 0, 1, 1),
(@es2s2, 'Company Registration Proof', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es2, 'Financial Documents', 'Evidence of funds.', 3);
SET @es2s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es2s3, 'ITRs / Employer NOC', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(148, 2, 90.00, 'EUR', 'Schengen Short-Stay Visa Fee', 'Same fee structure as Tourist — Business is the same Schengen short-stay visa.', '2024-06-11', NOW(), 'https://www.exteriores.gob.es/DocumentosSC/India/NUEVA%20DELHI%20(E)/Visados/1%20LIST%20SPECIFIC%20DOCUMENTATION%20REQUESTED.%20SCHENGEN%20VISAS.pdf', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What must the Spanish invitation letter include?', 'The company''s CIF (tax ID) number, the authorized signatory''s name and designation, company stamp, and the purpose/dates of your visit — often required bilingually.', 148, 2, 1193, 1),
('Is Business a separate visa product from Tourist?', 'No — it uses the same Schengen short-stay Type C visa, distinguished by business-purpose documents.', 148, 2, 1194, 1),
('Do I need proof of the commercial relationship?', 'Yes — a description of the commercial relationship between the Indian and Spanish companies is typically required alongside the invitation.', 148, 2, 1195, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — National Long-Stay Visa (Type D)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    148, 3, 'ESP-STU-IN-03', '2026.09', 'published',
    'Full-time study at a Spanish institution, regardless of course duration.',
    'A real, distinctive two-step Spanish ID process: your NIE (foreigner ID number) is automatically assigned when the visa is approved and stamped on the visa, but you must SEPARATELY apply for a physical TIE card at the local Oficina de Extranjería/police station within 30 days of arrival.',
    'Duration of your course (National Type D visa)',
    'National long-stay visa (Type D), regardless of course duration',
    1,
    'Average processing runs around 4 weeks',
    'Spanish Embassy/Consulate, India (BLS International for biometrics)',
    'Secure admission with tuition paid in full\nArrange proof of funds (EUR 600/month) and accommodation\nGather documents against this checklist, including insurance and (for 6+ month stays) an apostilled criminal record certificate\nSubmit your application and attend biometrics\nAfter arrival: apply for your physical TIE card within 30 days',
    '/assets/images/visa-heroes/spain.jpg',
    'BLS International Spain Student Visa guidance', 'https://www.blsinternational.com/india/spain/student-visa.php', '2026-09-11'
);
SET @es3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@es3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es3, 'Core Documents', 'Every applicant needs these.', 1);
SET @es3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@es3s1, 'Admission Letter (Tuition Paid in Full)', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es3, 'Financial Documents', 'Evidence you can fund your studies.', 2);
SET @es3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es3s2, 'Bank Statements (3 Months, No Large Recent Deposits)', 'At least EUR 600/month, roughly EUR 7,200/year.', 'copy', 1, 0, 1, 1),
(@es3s2, 'Proof of Accommodation', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es3, 'Additional Documents (Stays Over 6 Months)', 'Required for longer courses.', 3);
SET @es3s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es3s3, 'Apostilled Criminal Record Certificate', 'Translated into Spanish, required for stays over 6 months.', 'original', 0, 1, 0, 1),
(@es3s3, 'Comprehensive Health Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(148, 3, 91.00, 'EUR', 'National Long-Stay Visa Fee', 'Approximately EUR 91, distinct from the EUR 90 short-stay Schengen fee.', '2026-01-01', NOW(), 'https://www.blsinternational.com/india/spain/student-visa.php', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is the NIE and how do I get it?', 'A foreigner ID number automatically assigned when your visa is approved, stamped directly on the visa — no separate application needed for the NIE itself.', 148, 3, 1196, 1),
('What is the TIE card and is it different from the NIE?', 'Yes — the TIE is a physical residence card you must separately apply for at the local Oficina de Extranjería/police station within 30 days of arrival, a genuinely distinct second step.', 148, 3, 1197, 1),
('How much do I need to show in funds?', 'At least EUR 600/month (roughly EUR 7,200/year), shown via 3 months of bank statements without large recent deposits.', 148, 3, 1198, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Autorización de Trabajo + National Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    148, 4, 'ESP-WORK-IN-04', '2026.09', 'published',
    'Employer-sponsored employment in Spain.',
    'Spain has no Italy-style annual flow-quota — your employer must obtain a work authorization ("autorización de trabajo") via a labour-market test through SEPE, unless your role is on Spain''s shortage-occupation list. A separate fast-track, UGE-CE, exists for highly qualified professionals/Blue Card/intra-company transfers/large companies, deciding within 20 business days with "positive administrative silence."',
    'Initially 1 year (standard route) or 3 years (UGE-CE highly qualified professional route), renewable',
    'Employer obtains work authorization (standard labour-market-tested route or UGE-CE fast-track); employee then applies for the National (Type D) visa',
    1,
    'Total process: 1-8 months depending on route',
    'Spanish Embassy/Consulate, India, after employer''s work authorization is granted',
    'Employer applies for work authorization — standard route (SEPE labour-market test, unless shortage-occupation exempt) or UGE-CE fast-track\nOnce granted, gather documents against this checklist\nSubmit your National (Type D) visa application and attend biometrics\nDecision once processed\nAfter arrival: apply for your TIE card',
    '/assets/images/visa-heroes/spain.jpg',
    'UGE-CE (Unidad de Grandes Empresas y Colectivos Estratégicos) fast-track work-visa guidance', 'https://www.immigrationstartguide.com/blog/uge-ce-spain-explained', '2026-09-11'
);
SET @es4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@es4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es4, 'Core Documents', 'Every applicant needs these.', 1);
SET @es4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@es4s1, 'Work Authorization Approval', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es4, 'Employer Sponsorship Documents', 'Evidence of your role and salary.', 2);
SET @es4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es4s2, 'Employment Contract', 'Matching your sector''s collective bargaining rate (convenio colectivo).', 'copy', 1, 0, 1, 1),
(@es4s2, 'SEPE Labour-Market Test Evidence', 'Not required if your role is on the shortage-occupation list.', 'copy', 0, 1, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es4, 'Qualification Documents', 'Evidence you meet the role''s requirements.', 3);
SET @es4s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es4s3, 'Educational Credentials & Resume', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(148, 4, 91.00, 'EUR', 'National Visa Fee', 'Approximately EUR 91, plus separate residence/work-permit administrative fees (EUR 11-215 range).', '2026-01-01', NOW(), 'https://www.immigrationstartguide.com/blog/uge-ce-spain-explained', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Spain use an annual work-visa quota like Italy?', 'No — Spain has no Italy-style Decreto Flussi. Instead your employer obtains work authorization via a labour-market test, unless your role is on Spain''s shortage-occupation list.', 148, 4, 1199, 1),
('What is UGE-CE?', 'A fast-track unit for highly qualified professionals, EU Blue Card holders, intra-company transfers, and large strategic companies, deciding within 20 business days with "positive administrative silence" and bypassing the labour-market test.', 148, 4, 1200, 1),
('What salary must my employment contract show?', 'Your sector''s collective bargaining rate (convenio colectivo), which must be above Spain''s minimum wage (SMI) of roughly EUR 1,134/month.', 148, 4, 1201, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Schengen Short-Stay (Type C)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    148, 5, 'ESP-FAM-IN-05', '2026.09', 'published',
    'Visiting family or friends in Spain.',
    'Requires a "carta de invitación" (invitation letter), typically formalized by your Spanish host at their local police station (Comisaría) or via municipal registration (empadronamiento) — a materially different formalization mechanism from a simple letter written and signed alone.',
    'Up to 90 days within any 180-day period (Schengen short-stay)',
    'Short-stay Schengen visa (Type C), submitted via BLS International with biometrics',
    1,
    'Your host should formalize the invitation before you apply',
    'BLS International Spain Visa Application Centre, India',
    'Your Spanish host formalizes the carta de invitación at their local police station or via empadronamiento\nGather documents against this checklist, including relationship proof\nBook your BLS International appointment and attend biometrics\nSubmission of your application and documents\nCollect your passport once approved',
    '/assets/images/visa-heroes/spain.jpg',
    'Spanish consular guidance on family/friend visit invitations', 'https://www.exteriores.gob.es/', '2026-09-11'
);
SET @es5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@es5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es5, 'Core Documents', 'Every applicant needs these.', 1);
SET @es5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@es5s1, 'Passport Photographs', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es5, 'Host Documents', 'Evidence of your host''s formalized invitation.', 2);
SET @es5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es5s2, 'Carta de Invitación', 'Formalized at the host''s local police station or via empadronamiento.', 'original', 1, 0, 1, 1),
(@es5s2, 'Host''s DNI/NIE/Residence Card Copy', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es5, 'Financial & Insurance Documents', 'Evidence you can support your trip.', 3);
SET @es5s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es5s3, 'Schengen Travel Insurance', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(148, 5, 90.00, 'EUR', 'Schengen Short-Stay Visa Fee', 'Same fee structure as Tourist — the difference is your host''s formalized carta de invitación.', '2024-06-11', NOW(), 'https://www.exteriores.gob.es/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is a "carta de invitación"?', 'An invitation letter your Spanish host must formalize at their local police station (Comisaría) or via municipal registration (empadronamiento) — not just a signed letter alone.', 148, 5, 1202, 1),
('What documents does my host need to provide?', 'A copy of their DNI (national ID), NIE (foreigner ID), or residence card, alongside the formalized invitation.', 148, 5, 1203, 1),
('Is this different from other Schengen countries'' invitation requirements?', 'Yes — the formal police-station or empadronamiento step is a distinctly Spanish formalization mechanism.', 148, 5, 1204, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Airport Transit Visa (ATV)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    148, 6, 'ESP-TRANS-IN-06', '2026.09', 'published',
    'Passing through a Spanish international airport en route to a third country.',
    'Unlike several other Schengen states built this session, Spain genuinely REQUIRES an Airport Transit Visa (ATV) for Indian passport holders, even when staying airside without leaving the transit area — India is explicitly listed among a short set of nationalities subject to this rule. Exemptions apply for holders of valid Schengen/Bulgaria/Romania/Cyprus visas or residence permits, and valid US, Canada, Japan, or UK BRP documents (with some US Advance Parole exclusions).',
    'Strictly for the duration of your airside connection',
    'Airport Transit Visa (Type A) via BLS International, unless an exemption applies',
    1,
    'Confirm whether you qualify for an exemption before assuming you need to apply',
    'BLS International Spain Visa Application Centre, India',
    'Confirm whether you hold a document that exempts you (e.g. valid Schengen visa/residence, US/Canada/Japan visa, UK BRP)\nIf not exempt, gather documents against this checklist\nApply for the Airport Transit Visa (Type A) at BLS International\nAttend biometrics\nDecision once processed',
    '/assets/images/visa-heroes/spain.jpg',
    'Spanish Embassy Malabo Airport Transit Visa guidance', 'https://www.exteriores.gob.es/Embajadas/malabo/en/ServiciosConsulares/Paginas/Consular/Visado-de-transito-aeroportuario.aspx', '2026-09-11'
);
SET @es6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@es6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es6, 'Core Documents', 'Every applicant needs these.', 1);
SET @es6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@es6s1, 'Confirmed Onward Ticket to Non-Schengen Destination', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es6, 'Exemption Documents', 'If you qualify for an ATV exemption.', 2);
SET @es6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es6s2, 'Valid Schengen/US/Canada/Japan Visa or UK BRP', 'Qualifies you for an ATV exemption.', 'copy', 0, 1, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es6, 'Application Documents (If Not Exempt)', 'Standard ATV application.', 3);
SET @es6s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es6s3, 'Completed ATV Application Form', NULL, 'original', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(148, 6, 90.00, 'EUR', 'Airport Transit Visa Fee', 'Same EUR 90 fee tier as other Schengen short-stay categories, if you do not qualify for an exemption.', '2024-06-11', NOW(), 'https://www.exteriores.gob.es/Embajadas/malabo/en/ServiciosConsulares/Paginas/Consular/Visado-de-transito-aeroportuario.aspx', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need an Airport Transit Visa for Spain?', 'Yes, generally — Spain explicitly lists India among a short set of nationalities requiring an ATV even for airside-only connections, a stricter policy than several other Schengen states.', 148, 6, 1205, 1),
('Are there exemptions?', 'Yes — holders of a valid Schengen/Bulgaria/Romania/Cyprus visa or residence permit, or valid US, Canada, Japan visas, or a UK BRP, are generally exempt (with some US Advance Parole exclusions).', 148, 6, 1206, 1),
('Is this different from other Schengen countries built on this site?', 'Yes — the Netherlands, for example, generally exempts Indian passport holders from its own ATV requirement, the opposite of Spain''s policy.', 148, 6, 1207, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Schengen Medical Treatment Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    148, 7, 'ESP-MED-IN-07', '2026.09', 'published',
    'Travelling to Spain to receive medical treatment.',
    'Requires an official appointment/admission letter from a Spanish hospital or clinic confirming treatment dates and estimated cost, along with proof of funds or insurance covering that treatment.',
    'Up to 90 days (Schengen short-stay)',
    'Short-stay Schengen visa (Type C), submitted via BLS International with biometrics',
    1,
    'Consulates retain discretion to waive/reduce fees in humanitarian cases',
    'BLS International Spain Visa Application Centre, India',
    'Obtain an appointment/admission letter from the Spanish hospital or clinic\nGather documents against this checklist\nBook your BLS International appointment and attend biometrics\nSubmission of your application and documents\nCollect your passport once approved',
    '/assets/images/visa-heroes/spain.jpg',
    'Spanish consular Schengen medical-treatment visa guidance', 'https://www.exteriores.gob.es/', '2026-09-11'
);
SET @es7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@es7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es7, 'Core Documents', 'Every applicant needs these.', 1);
SET @es7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@es7s1, 'Passport Photographs', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es7, 'Medical Documents', 'Evidence of your treatment plan.', 2);
SET @es7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es7s2, 'Hospital/Clinic Admission Letter', 'Confirming treatment dates and estimated cost.', 'original', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es7, 'Financial Documents', 'Evidence you can pay for treatment.', 3);
SET @es7s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es7s3, 'Proof of Funds or Insurance Covering Treatment', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(148, 7, 90.00, 'EUR', 'Schengen Short-Stay Visa Fee', 'Same base fee as Tourist; consulates may waive/reduce fees in humanitarian cases.', '2024-06-11', NOW(), 'https://www.exteriores.gob.es/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What must the hospital admission letter include?', 'Confirmation of your treatment dates and estimated cost, issued by the Spanish hospital or clinic.', 148, 7, 1208, 1),
('Can the fee be waived for medical cases?', 'Consulates retain Visa-Code discretion to waive or reduce fees in humanitarian cases.', 148, 7, 1209, 1),
('Is Medical treatment a separate visa from Tourist?', 'No — it uses the same Schengen short-stay Type C visa, with medical-specific supporting documents.', 148, 7, 1210, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Schengen Business Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    148, 8, 'ESP-CONF-IN-08', '2026.09', 'published',
    'Attending a conference or exhibition in Spain.',
    'Handled under the Business (Type C) visa category. Requires an invitation/registration confirmation from the conference organizer, proof of registration fee payment, and accommodation/flight bookings.',
    'Up to 90 days (Schengen short-stay)',
    'Short-stay Schengen visa (Type C), submitted via BLS International with biometrics',
    1,
    'Processing depends on individual circumstances',
    'BLS International Spain Visa Application Centre, India',
    'Obtain your conference invitation/registration confirmation\nGather documents against this checklist\nBook your BLS International appointment and attend biometrics\nSubmission of your application and documents\nCollect your passport once approved',
    '/assets/images/visa-heroes/spain.jpg',
    'Spanish consular guidance on Schengen business visas (conference/exhibition purpose)', 'https://www.exteriores.gob.es/', '2026-09-11'
);
SET @es8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@es8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es8, 'Core Documents', 'Every applicant needs these.', 1);
SET @es8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@es8s1, 'Passport Photographs', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es8, 'Conference Documents', 'Evidence of the event and your registration.', 2);
SET @es8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es8s2, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 1),
(@es8s2, 'Registration Fee Payment Proof', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es8, 'Travel Documents', 'Evidence of your trip.', 3);
SET @es8s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es8s3, 'Accommodation & Flight Bookings', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(148, 8, 90.00, 'EUR', 'Schengen Short-Stay Visa Fee', 'Same fee as Business — Conference is handled under the same category.', '2024-06-11', NOW(), 'https://www.exteriores.gob.es/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Conference a separate visa category for Spain?', 'No — it is handled under the same Schengen Business (Type C) visa category.', 148, 8, 1211, 1),
('What does the conference documentation need to show?', 'An invitation or registration confirmation from the organizer, proof of registration fee payment, and your accommodation/flight bookings.', 148, 8, 1212, 1),
('Is there a separate fee for conference attendance?', 'No — it uses the same EUR 90 Schengen short-stay fee.', 148, 8, 1213, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Schengen Visa / National Type D (Long Stays)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    148, 9, 'ESP-SPORT-IN-09', '2026.09', 'published',
    'Competing in a sporting event in Spain, or signing a longer-term professional contract.',
    'No separate Spain "sports visa" product exists for short competitions — these use the Schengen Type C visa with a letter from your national sports federation confirming role, dates, and no remuneration/employment sought. Longer stays (e.g. a professional athlete''s contract) instead require a National Type D visa under Spain''s specific professional-athlete/highly-qualified residence permit route.',
    'Short competitions: up to 90 days (Schengen). Professional contracts: National Type D, tied to the contract',
    'Short competitions: Schengen Type C via BLS International. Professional contracts: National Type D visa',
    1,
    'Confirm whether your engagement is a short competition or a longer professional contract before applying',
    'BLS International Spain Visa Application Centre, India',
    'Confirm whether you are competing short-term or signing a longer professional contract\nObtain a letter from your national sports federation\nGather documents against this checklist for the applicable pathway\nSubmit your application and attend biometrics\nDecision once processed',
    '/assets/images/visa-heroes/spain.jpg',
    'Spanish consular guidance on Schengen sports-event visas and professional athlete residence permits', 'https://www.exteriores.gob.es/', '2026-09-11'
);
SET @es9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@es9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es9, 'Core Documents', 'Every applicant needs these.', 1);
SET @es9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@es9s1, 'Passport Photographs', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es9, 'Sports Event Documents (Short Competitions)', 'Evidence of your role and the event.', 2);
SET @es9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es9s2, 'National Federation Letter', 'Role, dates, and confirmation of no remuneration sought.', 'original', 0, 1, 1, 1),
(@es9s2, 'Past Competition Results/Rankings', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es9, 'Professional Contract Documents (Longer Stays)', 'For professional athletes.', 3);
SET @es9s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es9s3, 'Professional Contract', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(148, 9, NULL, 'EUR', 'Confirmed After Assessment', 'EUR 90 (Schengen) for short competitions, or the National Type D visa fee for professional contracts — confirmed once your specific engagement is known.', '2026-09-01', NOW(), 'https://www.exteriores.gob.es/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Spain have a distinct Sports Visa?', 'No — short competitions use the general Schengen Type C visa with a federation letter; longer professional contracts require a National Type D visa under a specific athlete residence route.', 148, 9, 1214, 1),
('What must the federation letter confirm?', 'Your role, event dates, and confirmation that no remuneration or employment is being sought.', 148, 9, 1215, 1),
('What if I sign a professional contract with a Spanish club?', 'That requires the National Type D visa route rather than a repeated short-stay Schengen visa.', 148, 9, 1216, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Reagrupación Familiar
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    148, 10, 'ESP-DEP-IN-10', '2026.09', 'published',
    'Joining a spouse or parent who holds a valid Spanish residence permit (Reagrupación Familiar, family reunification).',
    'Sponsor must already hold a valid Spanish residence permit (generally held 1+ year, authorized to remain another year). Income is pegged to Spain''s IPREM benchmark (frozen at EUR 600/month through 2026): sponsor needs at least 150% IPREM (EUR 900/month) for the first family member, plus 50% IPREM (EUR 300/month) per additional dependent — reduced to just the national minimum wage (SMI) level when minors are among the dependents.',
    'Tied to the sponsor''s residence permit validity',
    'National (Type D) visa via Spanish Embassy/Consulate, requires sponsor''s prior residence-permit standing',
    1,
    'Also requires proof of adequate housing ("informe de vivienda adecuada")',
    'Spanish Embassy/Consulate, India',
    'Confirm the sponsor''s residence-permit status and duration\nArrange sponsor''s income evidence against the IPREM-based thresholds\nGather documents against this checklist, including relationship and housing proof\nSubmit your application and attend biometrics\nDecision once processed',
    '/assets/images/visa-heroes/spain.jpg',
    'Spanish family reunification (Reagrupación Familiar) IPREM income-threshold guidance', 'https://www.exteriores.gob.es/', '2026-09-11'
);
SET @es10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@es10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es10, 'Core Documents', 'Every applicant needs these.', 1);
SET @es10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@es10s1, 'Sponsor''s Residence Permit Copy', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es10, 'Relationship Documents', 'Evidence of your relationship to the sponsor.', 2);
SET @es10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es10s2, 'Marriage Certificate', 'For a spouse applicant.', 'copy', 0, 1, 1, 1),
(@es10s2, 'Birth Certificate', 'For a child applicant.', 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@es10, 'Financial & Housing Documents', 'Evidence of income and accommodation.', 3);
SET @es10s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@es10s3, 'Sponsor''s Income Evidence (IPREM-Based)', '150% IPREM for the first member, plus 50% IPREM per additional dependent.', 'copy', 1, 0, 0, 1),
(@es10s3, 'Informe de Vivienda Adecuada', 'Housing adequacy report.', 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(148, 10, 91.00, 'EUR', 'National Visa Fee', 'Approximately EUR 91, the same National (Type D) visa fee tier as Student and Work.', '2026-01-01', NOW(), 'https://www.exteriores.gob.es/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is IPREM and how does it affect the income requirement?', 'Spain''s public income indicator, frozen at EUR 600/month through 2026 — your sponsor needs at least 150% IPREM (EUR 900/month) for the first family member, plus 50% IPREM (EUR 300/month) per additional dependent.', 148, 10, 1217, 1),
('Does the threshold change if minors are involved?', 'Yes — it is reduced to just the national minimum wage (SMI) level when minors are among the dependents.', 148, 10, 1218, 1),
('How long must the sponsor have held their residence permit?', 'Generally at least 1 year, with authorization to remain in Spain for at least another year.', 148, 10, 1219, 1);
