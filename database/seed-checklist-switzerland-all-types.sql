-- Switzerland Visa Checklist Engine content for all 10 visa types —
-- built fresh this session via web search, same standard as every
-- other country built this session (see AUDIT.md). hero_image_url
-- points at the real Matterhorn photo supplied by the client for
-- this hero.
--
-- Switzerland is Schengen (though not EU), structurally similar to
-- France/Germany/Italy/Netherlands/Spain, but its real, Switzerland-
-- SPECIFIC facts are genuinely different, not a copy-paste of those
-- countries:
--   - Work uses a genuinely distinctive annual CANTONAL quota system
--     for non-EU/EFTA third-country nationals — real 2026 figures held
--     flat versus 2025 (8,500 total units: 4,500 B long-term permits
--     + 4,000 L short-term permits, allocated across the 26 cantons
--     plus a federal reserve). The employer, not the applicant, files
--     with the CANTONAL labour-market authority, which runs a genuine
--     labour-market test via RAV/EURES job postings before the canton
--     forwards the file to SEM for federal authorization.
--   - Family Visit requires a "Verpflichtungserklärung" (Declaration
--     of Sponsorship/Guarantee) — a Swiss-specific instrument only
--     obtainable from the Swiss representation, under which the host
--     guarantees up to CHF 30,000 for the visitor (or a group of up to
--     10), stamped by the host's Swiss municipal (commune) authority —
--     materially different from a simple invitation letter.
--   - Switzerland genuinely does NOT require an Airport Transit Visa
--     from Indian passport holders for eligible airside connections
--     (max 48 hours, confirmed onward ticket, valid visa for the
--     destination where required) — its own long-standing policy,
--     confirmed and reaffirmed around 10 April 2026.
--   - Conference and Sports both reflect Switzerland's real status as
--     host to numerous international-organization headquarters and
--     sports federations (Geneva multilateral bodies; FIFA, IOC, CAS
--     and many Olympic federations as Swiss-law associations based
--     mainly around Lausanne/Zurich) — a "note verbale" or federation
--     invitation can substitute for a standard company invitation
--     letter, and a distinct Cultural & Sports work-permit framework
--     exists for project-based athlete/coach engagements.
--   - Dependent (family reunification) is a genuinely different
--     process from a Schengen visa — a residence-permit process via
--     SEM/cantonal migration offices, and for sponsors who are Swiss
--     citizens, C-permit holders, or employed B-permit holders,
--     reunification of a spouse/registered partner and children under
--     18 is NOT subject to an income threshold by rule — a real,
--     favourable distinction from most other countries built this
--     session, stated honestly rather than assuming a fabricated
--     threshold applies universally.
--
-- country_id 150 = Switzerland. visa_type_id: 1=Tourist, 2=Business,
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
    150, 1, 'CHE-TOUR-IN-01', '2026.09', 'published',
    'Leisure travel, sightseeing, and short personal visits to Switzerland and the wider Schengen area.',
    'Indian passport holders must obtain a Schengen visa before travelling. Applications are submitted via VFS Global with mandatory biometric data collection.',
    'Up to 90 days within any 180-day period (Schengen short-stay)',
    'Short-stay Schengen visa (Type C), submitted via VFS Global with biometrics',
    1,
    'Biometric data, once captured, is valid 59 months',
    'VFS Global Switzerland Visa Application Centre, India',
    'Initial consultation to confirm Tourist Visa is the right category\nGather documents against this checklist, including a confirmed itinerary\nBook your VFS Global appointment\nAttend in person for biometrics (mandatory for first-time applicants)\nSubmission of your application and documents\nDecision — visa sticker affixed to your passport once approved',
    '/assets/images/visa-heroes/switzerland.jpg',
    'Swiss State Secretariat for Migration (SEM) and Swiss Embassy India Schengen visa guidance', 'https://www.sem.admin.ch/', '2026-09-11'
);
SET @ch1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ch1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ch1, 'Core Documents', 'Every applicant needs these.', 1);
SET @ch1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ch1s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ch1s1, 'Passport Photographs', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ch1, 'Financial & Travel Documents', 'Evidence you can support your trip.', 2);
SET @ch1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ch1s2, 'Bank Statements (3 Months)', NULL, 'copy', 1, 0, 1, 1),
(@ch1s2, 'Schengen Travel Insurance', 'Minimum EUR 30,000 medical coverage, valid across the whole Schengen area.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ch1, 'Application Documents', 'Your formal application paperwork.', 3);
SET @ch1s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ch1s3, 'Confirmed Itinerary & Hotel/Host Address', NULL, 'original', 1, 0, 0, 1),
(@ch1s3, 'Employer Leave Letter / ITR', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ch1, 'Appointment & Submission', 'Booking and attending your VFS appointment.', 4);
SET @ch1s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ch1s4, 'VFS Appointment & Biometrics', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(150, 1, 97.00, 'CHF', 'Schengen Short-Stay Visa Fee', 'Approximately CHF 96-98 for adults (children 6-11: roughly CHF 48-49), following a Swiss-specific franc-indexation update around 1 May 2026. VFS Global''s separate service charge is additional. Exact same-day CHF figures fluctuate with EUR/CHF exchange rates.', '2026-05-01', NOW(), 'https://www.sem.admin.ch/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Why is the fee in CHF rather than a fixed EUR figure?', 'Switzerland bills the uniform Schengen fee in CHF at a rate its embassies reset periodically to track EUR/CHF exchange rates — we confirm the exact current CHF figure before you apply.', 150, 1, 1250, 1),
('How long is my biometric data valid?', '59 months once captured, so repeat applicants within that window may not need to re-enrol.', 150, 1, 1251, 1),
('Where do I apply in India?', 'Through VFS Global, Switzerland''s official outsourced visa partner in India.', 150, 1, 1252, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Schengen Short-Stay (Type C)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    150, 2, 'CHE-BUS-IN-02', '2026.09', 'published',
    'Short business visits — meetings, negotiations, and site visits — to Switzerland.',
    'The invitation letter from your Swiss host company must be on the company''s letterhead, in German, French, or Italian, signed by a person named in the Swiss commercial register (Handelsregister), with a Handelsregister extract attached showing the signatory.',
    'Up to 90 days within any 180-day period (Schengen short-stay)',
    'Short-stay Schengen visa (Type C), submitted via VFS Global with biometrics',
    1,
    'Biometric data, once captured, is valid 59 months',
    'VFS Global Switzerland Visa Application Centre, India',
    'Initial consultation to confirm the trip is a genuine business visit\nObtain an invitation letter with a Handelsregister extract from your Swiss host\nGather documents against this checklist\nBook your VFS Global appointment and attend biometrics\nSubmission of your application and documents\nCollect your passport once approved',
    '/assets/images/visa-heroes/switzerland.jpg',
    'VFS Global Switzerland Business Visa checklist guidance', 'https://visa.vfsglobal.com/one-pager/switzerland/india/english/pdf/Checklist_Busines_snew.pdf', '2026-09-11'
);
SET @ch2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ch2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ch2, 'Core Documents', 'Every applicant needs these.', 1);
SET @ch2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ch2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ch2s1, 'Passport Photographs', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ch2, 'Business Invitation & Purpose', 'Evidence of who you are meeting and why.', 2);
SET @ch2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ch2s2, 'Invitation Letter (German/French/Italian) with Handelsregister Extract', 'Signed by a person named in the Swiss commercial register.', 'original', 1, 0, 1, 1),
(@ch2s2, 'Covering Letter from Indian Employer', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ch2, 'Financial Documents', 'Evidence of funds.', 3);
SET @ch2s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ch2s3, 'Bank Statements', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(150, 2, 97.00, 'CHF', 'Schengen Short-Stay Visa Fee', 'Same fee structure as Tourist.', '2026-05-01', NOW(), 'https://visa.vfsglobal.com/one-pager/switzerland/india/english/pdf/Checklist_Busines_snew.pdf', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What language must the invitation letter be in?', 'German, French, or Italian — Switzerland''s official languages — signed by a person named in the Swiss commercial register.', 150, 2, 1253, 1),
('What is a Handelsregister extract?', 'An official Swiss commercial register document showing the signatory''s authority, required alongside the invitation letter.', 150, 2, 1254, 1),
('Is Business a separate visa product from Tourist?', 'No — it uses the same Schengen short-stay Type C visa, distinguished by business-purpose documents.', 150, 2, 1255, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — National Long-Stay Visa (Type D)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    150, 3, 'CHE-STU-IN-03', '2026.09', 'published',
    'Full-time study at a Swiss institution.',
    'A National (long-stay) Type D visa, NOT a Schengen visa — issued by the Swiss embassy but requiring cantonal migration office pre-clearance, so the file routes through both the canton and SEM (State Secretariat for Migration) before approval.',
    'Duration of your study program',
    'National long-stay visa (Type D), requiring cantonal migration office pre-clearance',
    1,
    'Processing takes roughly 8-12 weeks since the file routes through the canton and SEM',
    'Swiss Embassy/Consulate, India, after cantonal pre-clearance',
    'Secure admission and confirm enrollment\nArrange proof of funds (roughly CHF 21,000-24,000/year, canton-dependent)\nGather documents against this checklist\nSubmit your application, routed through the canton and SEM\nAfter arrival: register with your local commune and apply for a cantonal residence permit within 14 days',
    '/assets/images/visa-heroes/switzerland.jpg',
    'VFS Global Switzerland Student Visa (long-stay) checklist guidance', 'https://www.vfsglobal.com/one-pager/switzerland/india/english/pdf/D-Checklist_Student_more_than_90_days-EN.pdf', '2026-09-11'
);
SET @ch3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ch3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ch3, 'Core Documents', 'Every applicant needs these.', 1);
SET @ch3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ch3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ch3s1, 'Confirmed Enrollment/Admission Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ch3, 'Financial Documents', 'Evidence you can fund your studies.', 2);
SET @ch3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ch3s2, 'Proof of Funds', 'Roughly CHF 21,000-24,000/year, canton-dependent, covering living costs separately from tuition.', 'copy', 1, 0, 1, 1),
(@ch3s2, 'Proof of Accommodation', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ch3, 'Post-Arrival Documents', 'Required within 14 days of arrival.', 3);
SET @ch3s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ch3s3, 'Commune Registration & Cantonal Residence Permit Application', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(150, 3, NULL, 'CHF', 'Confirmed After Assessment', 'National visa fee varies by canton and consulate — confirmed once your specific institution and canton are known.', '2026-09-01', NOW(), 'https://www.vfsglobal.com/one-pager/switzerland/india/english/pdf/D-Checklist_Student_more_than_90_days-EN.pdf', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Student visa a Schengen visa?', 'No — it is a National (long-stay) Type D visa requiring cantonal migration office pre-clearance, a genuinely different process from the short-stay Schengen visa.', 150, 3, 1256, 1),
('What must I do within 14 days of arrival?', 'Register with your local commune and apply for a cantonal residence permit — a Swiss-specific administrative step beyond the visa itself.', 150, 3, 1257, 1),
('How much do I need to show in funds?', 'Roughly CHF 21,000-24,000/year, though the exact figure is canton-dependent, covering living costs separately from tuition.', 150, 3, 1258, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Cantonal Quota Work Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    150, 4, 'CHE-WORK-IN-04', '2026.09', 'published',
    'Employer-sponsored employment in Switzerland, allocated via an annual cantonal quota for non-EU/EFTA nationals.',
    'A genuinely distinctive cantonal quota system: 2026 figures held flat versus 2025 at 8,500 total units (4,500 B long-term permits + 4,000 L short-term permits), allocated across the 26 cantons plus a federal reserve, applying only to first-time permits. Your employer, not you, files with the cantonal labour authority, which runs a real labour-market test via RAV/EURES job postings.',
    'B permits: long-term, renewable. L permits: short-term',
    'Employer files with the cantonal labour authority; canton forwards to SEM for federal authorization; employee then applies for the entry visa',
    1,
    'Quota utilization has historically run under 80%, but availability varies by canton and timing',
    'Swiss Embassy/Consulate, India, after cantonal and federal authorization',
    'Employer files your case with the cantonal labour-market authority\nCanton runs a labour-market test via RAV/EURES postings\nCanton forwards the approved file to SEM for federal authorization\nGather documents against this checklist\nApply for your entry visa (Type D) and attend biometrics\nDecision once processed',
    '/assets/images/visa-heroes/switzerland.jpg',
    'Swiss cantonal work-permit quota guidance for 2026, cross-checked via independent immigration-law sourcing', 'https://www.fragomen.com/insights/swiss-immigration-quotas-for-2026-what-employers-and-workers-need-to-know.html', '2026-09-11'
);
SET @ch4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ch4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ch4, 'Core Documents', 'Every applicant needs these.', 1);
SET @ch4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ch4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ch4s1, 'Cantonal & Federal (SEM) Authorization', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ch4, 'Employer Sponsorship Documents', 'Evidence of your job offer and the labour-market test.', 2);
SET @ch4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ch4s2, 'Employment Contract', NULL, 'copy', 1, 0, 1, 1),
(@ch4s2, 'RAV/EURES Job-Posting Evidence', 'Showing no suitable EU/EFTA or domestic candidate was available.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ch4, 'Qualification Documents', 'Evidence you meet the role''s requirements.', 3);
SET @ch4s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ch4s3, 'Educational Credentials & Resume', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(150, 4, NULL, 'CHF', 'Confirmed After Assessment', 'Fee varies by canton and permit type (B or L) — confirmed once your specific canton and role are known.', '2026-09-01', NOW(), 'https://www.fragomen.com/insights/swiss-immigration-quotas-for-2026-what-employers-and-workers-need-to-know.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is Switzerland''s 2026 work-permit quota?', '8,500 total units — 4,500 B (long-term residence) permits and 4,000 L (short-term) permits — held flat versus 2025, allocated across the 26 cantons plus a federal reserve.', 150, 4, 1259, 1),
('Who applies for the work permit — me or my employer?', 'Your employer files with the cantonal labour-market authority; you apply for the entry visa only after cantonal and federal (SEM) authorization is granted.', 150, 4, 1260, 1),
('What is the labour-market test?', 'Your employer must show, via job postings on Regional Employment Centres (RAV) and the EURES network, that no suitable EU/EFTA or domestic candidate was available for the role.', 150, 4, 1261, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Schengen Short-Stay (Type C)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    150, 5, 'CHE-FAM-IN-05', '2026.09', 'published',
    'Visiting family or friends in Switzerland.',
    'Where funds are in doubt, requires a "Verpflichtungserklärung" (Declaration of Sponsorship/Guarantee) — a Swiss-specific instrument obtainable only from the Swiss representation, under which the host guarantees up to CHF 30,000 for the visitor (or a group of up to 10), stamped by the host''s Swiss municipal (commune) authority.',
    'Up to 90 days within any 180-day period (Schengen short-stay)',
    'Short-stay Schengen visa (Type C), submitted via VFS Global with biometrics',
    1,
    'Eligible sponsors are generally Swiss citizens or C/B permit holders; L-permit sponsors face heightened scrutiny',
    'VFS Global Switzerland Visa Application Centre, India',
    'Confirm whether your host needs to provide a Verpflichtungserklärung\nYour host obtains and stamps the declaration at their Swiss commune authority\nGather documents against this checklist, including relationship proof\nBook your VFS Global appointment and attend biometrics\nSubmission of your application and documents',
    '/assets/images/visa-heroes/switzerland.jpg',
    'Swiss Verpflichtungserklärung (Declaration of Sponsorship) guidance', 'https://www.sem.admin.ch/dam/sem/en/data/einreise/merkblatt_einreise/mb-einladungsschreiben-e.pdf.download.pdf/mb-einladungsschreiben-e.pdf', '2026-09-11'
);
SET @ch5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ch5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ch5, 'Core Documents', 'Every applicant needs these.', 1);
SET @ch5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ch5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ch5s1, 'Passport Photographs', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ch5, 'Host Sponsorship Documents', 'Evidence of your host''s formal guarantee.', 2);
SET @ch5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ch5s2, 'Verpflichtungserklärung', 'Guaranteeing up to CHF 30,000, stamped by the host''s Swiss commune authority.', 'original', 0, 1, 1, 1),
(@ch5s2, 'Relationship Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ch5, 'Travel & Insurance Documents', 'Evidence you can support your trip.', 3);
SET @ch5s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ch5s3, 'Schengen Travel Insurance', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(150, 5, 97.00, 'CHF', 'Schengen Short-Stay Visa Fee', 'Same fee structure as Tourist, plus your host''s costs for the Verpflichtungserklärung where applicable.', '2026-05-01', NOW(), 'https://www.sem.admin.ch/dam/sem/en/data/einreise/merkblatt_einreise/mb-einladungsschreiben-e.pdf.download.pdf/mb-einladungsschreiben-e.pdf', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is a Verpflichtungserklärung?', 'A Swiss-specific Declaration of Sponsorship/Guarantee, obtainable only from the Swiss representation, under which your host guarantees up to CHF 30,000 for you (or a group of up to 10 people).', 150, 5, 1262, 1),
('Who can be an eligible sponsor?', 'Generally Swiss citizens or C/B permit holders; L-permit sponsors face heightened scrutiny.', 150, 5, 1263, 1),
('Do I always need this declaration?', 'It is generally required where funds are in doubt — check with us whether your specific case needs it.', 150, 5, 1264, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — No ATV Required (Eligible Connections)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    150, 6, 'CHE-TRANS-IN-06', '2026.09', 'published',
    'Passing through a Swiss international airport en route to a third country.',
    'Switzerland genuinely does not require an Airport Transit Visa (ATV) from Indian passport holders for eligible airside connections, provided the layover stays within 48 hours, you hold a confirmed onward ticket, and (where required) a valid visa for your final destination — its own long-standing policy, confirmed and reaffirmed around 10 April 2026.',
    'Up to 48 hours, airside only',
    'No application needed for eligible airside connections through Zurich or Geneva',
    0,
    'Confirm your specific routing qualifies before assuming no visa is needed',
    'Not applicable for eligible transit; VFS Global Switzerland centre if a full Schengen visa is required instead',
    'Confirm your connection stays airside within 48 hours with a confirmed onward ticket\nCheck your final destination''s own visa requirement, if any\nIf eligible, no visa application is needed — proceed with your connecting flight\nIf leaving the transit zone, apply for a standard Schengen visa instead',
    '/assets/images/visa-heroes/switzerland.jpg',
    'Swiss transit policy for Indian passport holders, reaffirmed April 2026', 'https://www.travelandtourworld.com/news/article/2sxrqqjshh9m/', '2026-09-11'
);
SET @ch6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ch6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ch6, 'Core Documents', 'For eligible airside connections.', 1);
SET @ch6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ch6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ch6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ch6, 'Destination Documents', 'Evidence of your final destination.', 2);
SET @ch6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ch6s2, 'Valid Visa for Final Destination', 'If required.', 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(150, 6, 0.00, 'CHF', 'No Fee for Eligible Airport Transit', 'No visa or fee is needed for a qualifying airside connection through Zurich or Geneva. A standard Schengen visa fee applies only if you must leave the transit zone.', '2026-04-10', NOW(), 'https://www.travelandtourworld.com/news/article/2sxrqqjshh9m/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need an Airport Transit Visa for Switzerland?', 'No — Switzerland does not require an ATV from Indian passport holders for eligible airside connections up to 48 hours, its own long-standing policy.', 150, 6, 1265, 1),
('What airports does this apply to?', 'Switzerland''s main international hubs, Zurich and Geneva.', 150, 6, 1266, 1),
('What if my layover exceeds 48 hours?', 'You would need a standard Schengen visa if leaving the transit zone.', 150, 6, 1267, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Schengen Medical Treatment Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    150, 7, 'CHE-MED-IN-07', '2026.09', 'published',
    'Travelling to Switzerland to receive medical treatment.',
    'Requires an invitation/appointment letter from the Swiss hospital or clinic on official letterhead, plus a justification letter from your home-country physician explaining why treatment specifically in Switzerland is needed, alongside financial proof or a Verpflichtungserklärung.',
    'Up to 90 days (Schengen short-stay)',
    'Short-stay Schengen visa (Type C), submitted via VFS Global with biometrics',
    1,
    'A separate guarantee letter covering unforeseen medical costs is also typically required',
    'VFS Global Switzerland Visa Application Centre, India',
    'Obtain an invitation/appointment letter from the Swiss hospital or clinic\nObtain a justification letter from your home-country physician\nGather documents against this checklist\nBook your VFS Global appointment and attend biometrics\nSubmission of your application and documents',
    '/assets/images/visa-heroes/switzerland.jpg',
    'Swiss consular Schengen medical-treatment visa guidance', 'https://www.sem.admin.ch/', '2026-09-11'
);
SET @ch7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ch7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ch7, 'Core Documents', 'Every applicant needs these.', 1);
SET @ch7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ch7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ch7s1, 'Passport Photographs', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ch7, 'Medical Documents', 'Evidence of your treatment plan.', 2);
SET @ch7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ch7s2, 'Swiss Hospital/Clinic Appointment Letter', NULL, 'original', 1, 0, 1, 1),
(@ch7s2, 'Justification Letter from Home-Country Physician', 'Explaining why treatment specifically in Switzerland is needed.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ch7, 'Financial Documents', 'Evidence you can pay for treatment.', 3);
SET @ch7s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ch7s3, 'Financial Proof or Verpflichtungserklärung', NULL, 'copy', 1, 0, 0, 1),
(@ch7s3, 'Unforeseen Medical Costs Guarantee Letter', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(150, 7, 97.00, 'CHF', 'Schengen Short-Stay Visa Fee', 'Same base fee as Tourist.', '2026-05-01', NOW(), 'https://www.sem.admin.ch/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Why do I need a letter from my own doctor in India?', 'To justify why treatment specifically in Switzerland is needed, alongside the Swiss hospital''s own appointment letter.', 150, 7, 1268, 1),
('What is the unforeseen medical costs guarantee?', 'A separate letter of financial guarantee covering unexpected medical complications, in addition to your main financial proof.', 150, 7, 1269, 1),
('Is Medical treatment a separate visa from Tourist?', 'No — it uses the same Schengen short-stay Type C visa, with medical-specific supporting documents.', 150, 7, 1270, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Schengen Business Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    150, 8, 'CHE-CONF-IN-08', '2026.09', 'published',
    'Attending a conference in Switzerland, including multilateral conferences hosted by international organizations headquartered in Geneva.',
    'Handled as a Schengen Business visa with conference purpose. A genuinely distinctive alternative exists for delegates attending conferences hosted by international organizations with a Swiss headquarters agreement: a "note verbale" from the sending state, or an invitation from the organization itself, can substitute for a standard company invitation letter.',
    'Up to 90 days (Schengen short-stay)',
    'Short-stay Schengen visa (Type C), submitted via VFS Global with biometrics',
    1,
    'Confirm whether your conference qualifies for the note verbale route before assuming a standard company invitation is needed',
    'VFS Global Switzerland Visa Application Centre, India',
    'Obtain either a conference invitation, or a note verbale if attending a multilateral organization''s event\nGather documents against this checklist\nBook your VFS Global appointment and attend biometrics\nSubmission of your application and documents\nCollect your passport once approved',
    '/assets/images/visa-heroes/switzerland.jpg',
    'Swiss consular guidance on Schengen visas for Geneva-based international organization conferences', 'https://www.mission-geneve.dfae.admin.ch/en/visas-and-procedures-for-entering-switzerland', '2026-09-11'
);
SET @ch8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ch8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ch8, 'Core Documents', 'Every applicant needs these.', 1);
SET @ch8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ch8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ch8s1, 'Passport Photographs', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ch8, 'Conference Documents', 'Evidence of the event and your role.', 2);
SET @ch8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ch8s2, 'Conference Invitation or Note Verbale', 'Note verbale for multilateral-organization events with a Swiss headquarters agreement.', 'original', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ch8, 'Financial Documents', 'Evidence of funds.', 3);
SET @ch8s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ch8s3, 'Bank Statements', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(150, 8, 97.00, 'CHF', 'Schengen Short-Stay Visa Fee', 'Same fee as Business — Conference is a business-purpose Schengen visa.', '2026-05-01', NOW(), 'https://www.mission-geneve.dfae.admin.ch/en/visas-and-procedures-for-entering-switzerland', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is a "note verbale"?', 'A formal diplomatic note from the sending state that can substitute for a standard company invitation letter, used for delegates attending conferences hosted by Geneva-based international organizations.', 150, 8, 1271, 1),
('Does this apply to all Swiss conferences?', 'No — it specifically applies to events hosted by international organizations with a Swiss headquarters agreement; other conferences use a standard invitation letter.', 150, 8, 1272, 1),
('Is Conference a separate visa category?', 'No — it is handled as a Schengen Business visa with conference purpose.', 150, 8, 1273, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Schengen Visa / Cultural & Sports Work-Permit Framework
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    150, 9, 'CHE-SPORT-IN-09', '2026.09', 'published',
    'Attending or competing in a sporting event in Switzerland, home to many major international sports federations.',
    'Spectators and short-term competitors use the general Schengen visa. Switzerland is distinctively the seat of major international sports federations (FIFA, IOC, CAS, and many Olympic federations, mostly Swiss-law associations based around Lausanne/Zurich), and maintains a separate Cultural & Sports work-permit framework for athletes/coaches/teams on project-based engagements tied to a specific event or season.',
    'Short-stay competitions: up to 90 days (Schengen). Project-based engagements: tied to the Cultural & Sports work permit',
    'Short-stay: Schengen Type C via VFS Global. Project-based: Cultural & Sports work-permit application',
    1,
    'Federation-issued invitations can carry similar evidentiary weight to the note verbale used for conferences',
    'VFS Global Switzerland Visa Application Centre, India',
    'Confirm whether your engagement is a short competition or a project-based season engagement\nObtain a federation invitation, or apply for the Cultural & Sports work permit for longer engagements\nGather documents against this checklist for the applicable pathway\nAttend biometrics\nDecision once processed',
    '/assets/images/visa-heroes/switzerland.jpg',
    'Swiss Cultural & Sports work-permit framework guidance', 'https://www.richmondchambers.ch/swiss-private-client-immigration/swiss-cultural-&-sports-permits', '2026-09-11'
);
SET @ch9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ch9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ch9, 'Core Documents', 'Every applicant needs these.', 1);
SET @ch9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ch9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ch9s1, 'Passport Photographs', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ch9, 'Short-Stay Event Documents', 'For spectators/short-term competitors.', 2);
SET @ch9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ch9s2, 'Federation Invitation/Event Documentation', NULL, 'original', 0, 1, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ch9, 'Cultural & Sports Work Permit Documents', 'For project-based engagements.', 3);
SET @ch9s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ch9s3, 'Event/Season Contract', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(150, 9, NULL, 'CHF', 'Confirmed After Assessment', 'CHF 97 (Schengen) for short-stay competitors, or the Cultural & Sports work-permit fee for project-based engagements — confirmed once your specific status is known.', '2026-09-01', NOW(), 'https://www.richmondchambers.ch/swiss-private-client-immigration/swiss-cultural-&-sports-permits', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Why is Switzerland distinctive for sports visas?', 'It is the seat of major international sports federations (FIFA, IOC, CAS, and many Olympic federations), mostly constituted as Swiss-law associations based around Lausanne/Zurich.', 150, 9, 1274, 1),
('What is the Cultural & Sports work-permit framework?', 'A separate permit route for athletes/coaches/teams on project-based engagements tied to a specific event or season, distinct from the short-stay Schengen visa used by spectators.', 150, 9, 1275, 1),
('Can a federation invitation replace a standard document?', 'Yes — federation-issued invitations can carry similar evidentiary weight to the note verbale used for international-organization conferences.', 150, 9, 1276, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Family Reunification (Residence Permit)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    150, 10, 'CHE-DEP-IN-10', '2026.09', 'published',
    'Joining a spouse/registered partner or parent who holds a Swiss residence permit.',
    'A genuinely different process from a Schengen visa — a residence-permit process via SEM/cantonal migration offices. For sponsors who are Swiss citizens, C-permit holders, or employed B-permit holders, reunification of a spouse/registered partner and children under 18 is NOT subject to an income threshold by rule.',
    'Matches the validity of the sponsor''s residence permit',
    'Residence-permit application via SEM/cantonal migration offices, not a Schengen visa',
    1,
    'Self-employed or economically inactive sponsors must show sufficient means and suitable accommodation instead',
    'Swiss Embassy/Consulate, India, after cantonal pre-clearance',
    'Confirm the sponsor''s permit type (Swiss citizen, C-permit, or employed B-permit)\nGather documents against this checklist, including relationship proof\nSubmit your application, routed through the canton and SEM\nAttend biometrics\nDecision once processed',
    '/assets/images/visa-heroes/switzerland.jpg',
    'SEM family reunification (Familiennachzug) guidance for Swiss citizens/C-permit/B-permit sponsors', 'https://www.sem.admin.ch/dam/sem/en/data/eu/fza/personenfreizuegigkeit/factsheets/fs-familiennachzug-e.pdf.download.pdf/fs-familiennachzug-e.pdf', '2026-09-11'
);
SET @ch10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@ch10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ch10, 'Core Documents', 'Every applicant needs these.', 1);
SET @ch10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ch10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@ch10s1, 'Sponsor''s Residence Permit Copy', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ch10, 'Relationship Documents', 'Evidence of your relationship to the sponsor.', 2);
SET @ch10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ch10s2, 'Marriage/Registered Partnership Certificate', NULL, 'copy', 0, 1, 1, 1),
(@ch10s2, 'Birth Certificate', 'For a child applicant under 18.', 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@ch10, 'Financial Documents (Where Applicable)', 'Only for self-employed/economically inactive sponsors.', 3);
SET @ch10s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@ch10s3, 'Sponsor''s Means & Accommodation Evidence', 'Only required if the sponsor is self-employed or economically inactive.', 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(150, 10, NULL, 'CHF', 'Confirmed After Assessment', 'Fee varies by canton — confirmed once your sponsor''s specific canton is known.', '2026-09-01', NOW(), 'https://www.sem.admin.ch/dam/sem/en/data/eu/fza/personenfreizuegigkeit/factsheets/fs-familiennachzug-e.pdf.download.pdf/fs-familiennachzug-e.pdf', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there an income requirement for my Swiss sponsor?', 'Not by rule, if the sponsor is a Swiss citizen, C-permit holder, or employed B-permit holder — reunification of a spouse/registered partner and children under 18 is not subject to an income threshold in that case.', 150, 10, 1277, 1),
('When does an income requirement apply?', 'For self-employed or economically inactive sponsors, who must instead show sufficient means (no reliance on social assistance) and suitable accommodation.', 150, 10, 1278, 1),
('Is this a Schengen visa application?', 'No — it is a residence-permit process via SEM and cantonal migration offices, genuinely different from a short-stay Schengen visa.', 150, 10, 1279, 1);
