-- Georgia (country) Visa Checklist Engine content for all 10 visa types —
-- built fresh this session via web search. hero_image_url set to the
-- existing georgia.webp hero image for all 10 rows.
--
-- IMPORTANT SOURCING CAVEAT: WebFetch (direct page retrieval) was blocked
-- by the network egress proxy for essentially every domain attempted this
-- session, including evisa.gov.ge, geoconsul.gov.ge, india.mfa.gov.ge,
-- matsne.gov.ge, en.wikipedia.org, visa.vfsglobal.com, and multiple
-- visa-agency/news sites. All findings below were instead triangulated
-- through WebSearch result snippets (visa agencies, education
-- consultancies, immigration-law firms including Andersen and a KPMG
-- Flash Alert, and embassy pages surfaced in search but not independently
-- fetched in full). Fee figures in particular vary across secondary
-- sources and are flagged as approximate throughout. Several narrower
-- points (exact relationship-proof standards for Family Visit, a formal
-- hospital-invitation requirement for Medical, the exact new Special
-- Labour Permit fee for Work) could not be independently confirmed this
-- session and are flagged inline in their FAQ/notes rather than stated
-- as fact.
--
-- Georgia's real, distinctive, dated facts verified this session:
--   - Georgia is NOT blanket visa-free for Indian citizens. A short-stay
--     e-Visa (evisa.gov.ge) is required for tourism/business/medical/
--     conference/sports/transit purposes. HOWEVER, Indian passport
--     holders who already hold a valid visa or residence permit from the
--     US, UK, Schengen Area, Canada, Australia, Japan, South Korea, New
--     Zealand, Israel, Ireland, or the GCC states (UAE, Saudi Arabia,
--     Qatar, Bahrain, Oman, Kuwait) may instead enter Georgia visa-free
--     for up to 90 days in any 180-day period — a genuine dual-track
--     system, reaffirmed for 2025-2026.
--   - New for 2026: a mandatory "DuVerify" identity-verification step
--     (USD 15, completed within 24 hours of paying the consular fee) was
--     added to the e-Visa flow, and since January 1, 2026 all tourists
--     must carry health/accident travel insurance of at least
--     GEL 30,000 (~USD 11,000).
--   - Georgia's well-known "Individual Entrepreneur" / Small Business
--     Status regime (1% tax on gross revenue up to GEL 500,000/year),
--     long popular with remote workers and digital nomads, is no longer
--     self-sufficient on its own: from March 1, 2026, under Resolution
--     No. 70 and the amended Law on Labor Migration, self-employed
--     foreigners AND regular employees alike must separately obtain a
--     "right to work" (Special Labour Permit) from the State Employment
--     Support Agency (via labourmigration.moh.gov.ge) before working —
--     a residence permit alone is no longer enough. Non-compliance is
--     reportedly finable at GEL 2,000.
--   - Long-stay "D-category" visas (D1 work, D3 study, D4 family
--     reunification, D2 professional/sports/cultural missions, etc.) are
--     NOT available through the e-Visa portal at all — they require an
--     in-person application at the Embassy of Georgia, New Delhi, with a
--     reported minimum processing time of around 2 months, in sharp
--     contrast to the e-Visa portal's 5-7 working days.
--   - Georgia's D2 visa category officially bundles scientific, sports,
--     cultural, educational, and voluntary missions together under one
--     long-term visa type — reflected here by the overlap between the
--     Conference and Sports checklists for longer/sponsored trips.
--
-- country_id 65 = Georgia. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Short-Stay e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    65, 1, 'GEO-TOUR-IN-01', '2026.09', 'published',
    'Leisure, sightseeing, and short personal travel to Georgia.',
    'Indian passport holders travelling for tourism apply for Georgia''s e-Visa online. Travellers who already hold a valid US, UK, Schengen, Canada, Australia, Japan, South Korea, New Zealand, Israel, Ireland, or GCC visa/residence permit may instead enter visa-free for up to 90 days in any 180-day period.',
    'Up to 30 days per entry on the standard e-Visa (120-day validity); visa-free entrants get up to 90 days in any 180-day period',
    'Apply online via the official Georgia e-Visa portal (evisa.gov.ge); no embassy visit needed',
    0,
    'Standard e-Visa processing is reported at 5-7 working days; mandatory DuVerify identity check (new for 2026) must be completed within 24 hours of payment',
    'Georgia e-Visa Portal (evisa.gov.ge); Embassy of Georgia to the Republic of India, New Delhi handles long-stay/D-visa categories only',
    'Check eligibility for visa-free entry via a qualifying third-country visa/residence permit\nIf not eligible, register on evisa.gov.ge and complete the online application\nUpload passport scan, photo, and supporting documents\nPay the consular fee, service fee, and complete DuVerify identity verification within 24 hours\nReceive the e-Visa by email and carry a printed copy while travelling',
    '/assets/images/visa-heroes/georgia.webp',
    'Cross-checked against Georgian e-Visa portal secondary sourcing and visa-agency reporting on the 2026 DuVerify/insurance rule changes; evisa.gov.ge itself not directly fetchable this session', 'https://evisa.gov.ge/en/', '2026-09-17'
);
SET @geo1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@geo1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@geo1, 'Core Documents', 'Required from every applicant.', 1);
SET @geo1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@geo1s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@geo1s1, 'Completed Online e-Visa Application', NULL, 'copy', 1, 0, 1, 2),
(@geo1s1, 'Mandatory Travel/Health Insurance (Min. GEL 30,000)', 'Required for all tourists since January 1, 2026.', 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@geo1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @geo1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@geo1s2, 'Confirmed Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 1),
(@geo1s2, 'Hotel Booking or Accommodation Proof', NULL, 'copy', 1, 0, 0, 2),
(@geo1s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 3),
(@geo1s2, 'DuVerify Identity Verification Confirmation', 'Completed within 24 hours of paying the consular fee.', 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(65, 1, 20.00, 'USD', 'e-Visa Consular Fee (Plus Service Charge & DuVerify)', 'USD 20 consular fee, plus a 2% service charge and a mandatory USD 15 DuVerify verification fee (new for 2026) — all-in total reported around USD 35-37.', '2026-01-01', NOW(), 'https://evisa.gov.ge/en/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do all Indian citizens need a visa to enter Georgia?', 'Not always — an e-Visa is required for most Indian tourists, but if you already hold a valid visa or residence permit from the US, UK, Schengen Area, Canada, Australia, Japan, South Korea, New Zealand, Israel, Ireland, or a GCC country, you can enter Georgia visa-free for up to 90 days in any 180-day period.', 65, 1, 6500, 1),
('What is DuVerify and is it really mandatory?', 'Yes — DuVerify is a mandatory identity-verification step added to the Georgia e-Visa process for 2026. After paying the consular fee, you receive a DuVerify link by email and must complete verification (and pay a USD 15 fee) within 24 hours, or your application may be affected.', 65, 1, 6501, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Short-Stay e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    65, 2, 'GEO-BUS-IN-02', '2026.09', 'published',
    'Trade meetings, negotiations, and short commercial visits to Georgia.',
    'Indian business travellers apply for the same e-Visa as Tourist, adding a notarized invitation letter from a registered Georgian company. Travellers with a qualifying US/UK/Schengen/Canada/Australia/Japan/South Korea/New Zealand/Israel/Ireland/GCC visa may instead enter visa-free.',
    'Up to 30 days per entry (120-day e-Visa validity); visa-free entrants up to 90 days in any 180-day period',
    'Apply online via evisa.gov.ge with a notarized company invitation letter; VFS Global sticker-visa is also reported as an alternative channel',
    0,
    'Standard e-Visa processing 5-7 working days; DuVerify identity check must be completed within 24 hours of payment',
    'Georgia e-Visa Portal (evisa.gov.ge); Embassy of Georgia to the Republic of India, New Delhi handles long-stay/D-visa categories only',
    'Obtain a notarized invitation letter from the Georgian host company\nRegister on evisa.gov.ge and complete the online business-purpose application\nUpload passport scan, photo, invitation letter, and employer NOC\nPay fees and complete DuVerify verification within 24 hours\nReceive the e-Visa by email and carry a printed copy while travelling',
    '/assets/images/visa-heroes/georgia.webp',
    'Cross-checked against Georgian e-Visa portal secondary sourcing and visa-agency reporting on business-visa invitation-letter requirements; evisa.gov.ge itself not directly fetchable this session', 'https://evisa.gov.ge/en/', '2026-09-17'
);
SET @geo2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@geo2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@geo2, 'Core Documents', 'Required from every applicant.', 1);
SET @geo2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@geo2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@geo2s1, 'Notarized Invitation Letter from Georgian Host Company', NULL, 'original', 1, 0, 1, 2),
(@geo2s1, 'Mandatory Travel/Health Insurance (Min. GEL 30,000)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@geo2, 'Supporting Documents', 'Evidence of your own employment and financial responsibility.', 2);
SET @geo2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@geo2s2, 'Forwarding Letter/NOC from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@geo2s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2),
(@geo2s2, 'Business/Company Registration Proof', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(65, 2, 20.00, 'USD', 'e-Visa Consular Fee (Plus Service Charge & DuVerify)', 'Same fee structure as Tourist (USD 20 + 2% service charge + USD 15 DuVerify); one 2025-26 source reports an all-in total around ₹3,030 (~USD 37).', '2026-01-01', NOW(), 'https://evisa.gov.ge/en/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does the Georgian invitation letter need to be notarized?', 'Secondary sourcing reports that business e-Visa invitation letters are expected to be notarized and should include the host company''s stamp, signature, and details of the business relationship — confirm current formatting requirements before applying.', 65, 2, 6510, 1),
('Can I apply for a Georgia business visa through VFS Global instead of the e-Visa portal?', 'Some sourcing mentions a VFS Global sticker-visa route as an alternative to the online e-Visa for Indian applicants, requiring physical document submission — the e-Visa portal remains the primary, fastest channel.', 65, 2, 6511, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — D3 Long-Term Study Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    65, 3, 'GEO-STU-IN-03', '2026.09', 'published',
    'Enrolling in a recognized Georgian university or educational institution.',
    'Indian students admitted to a Georgian institution apply for the D3 long-term study visa directly at the Embassy of Georgia, New Delhi — not via the e-Visa portal — then convert to a Temporary Residence Permit (TRC) after arrival.',
    'D3 visa valid 90 days to enter Georgia; convert to a renewable Temporary Residence Permit (TRC) for the course duration',
    'D3 visa: apply in person at the Embassy of Georgia, New Delhi. Not available via the e-Visa portal',
    1,
    'Reported minimum ~2 months for embassy-issued long-term visas; recommended to apply 45-60 days before intended travel',
    'Embassy of Georgia to the Republic of India, 169 Jor Bagh, New Delhi',
    'Secure admission at a recognized Georgian university/institution\nGather proof of funds, health insurance, and a medical certificate\nBook an appointment and apply in person at the Embassy of Georgia, New Delhi\nSubmit documents and attend any required interview\nAfter arrival, visit a Public Service Hall within 45 days to apply for a Temporary Residence Permit (TRC)',
    '/assets/images/visa-heroes/georgia.webp',
    'Cross-checked against Georgian immigration-law secondary sourcing and multiple Indian study-abroad consultancy guides on the D3 process; india.mfa.gov.ge not directly fetchable this session', 'https://india.mfa.gov.ge/en', '2026-09-17'
);
SET @geo3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@geo3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@geo3, 'Core Documents', 'Required from every applicant.', 1);
SET @geo3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@geo3s1, 'Valid Passport (Issued Within Last 10 Years)', NULL, 'original', 1, 0, 1, 1),
(@geo3s1, 'Letter of Acceptance from Georgian Institution', NULL, 'original', 1, 0, 1, 2),
(@geo3s1, 'Completed D3 Visa Application Form', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@geo3, 'Supporting Documents', 'Evidence of your academic background, funds, and health cover.', 2);
SET @geo3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@geo3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@geo3s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2),
(@geo3s2, 'Health Insurance Valid in Georgia', NULL, 'original', 1, 0, 0, 3),
(@geo3s2, 'Medical Certificate/Health Condition Form', NULL, 'original', 1, 0, 0, 4),
(@geo3s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 5),
(@geo3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 6);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(65, 3, 20.00, 'USD', 'D3 Student Visa Fee (Approximate)', 'Reported at approximately USD 20 (~₹1,800-2,100); a separate Temporary Residence Permit (TRC) fee applies after arrival — confirm current figures with the Embassy.', '2026-09-01', NOW(), 'https://india.mfa.gov.ge/en', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need to reapply once the 90-day D3 visa expires?', 'No new visa application is needed for the standard program — instead, within 45 days of arriving in Georgia you must visit a Public Service Hall and apply for a Temporary Residence Permit (TRC), which then covers your stay for the course duration and is renewable.', 65, 3, 6520, 1),
('How far in advance should I apply for a Georgia student visa?', 'Apply roughly 45-60 days before your intended travel date — embassy-issued D3 visas reportedly take a minimum of around 2 months to process, notably longer than the e-Visa portal''s 5-7 working days.', 65, 3, 6521, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — D1 Visa + Special Labour Permit (2026 Reform)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    65, 4, 'GEO-WORK-IN-04', '2026.09', 'published',
    'Employment or self-employed/entrepreneurial business activity in Georgia under the D1 visa category.',
    'Indian nationals with a confirmed Georgian job offer, or planning self-employment/individual-entrepreneur activity, apply for the D1 visa. Since March 1, 2026, a new law also requires a separate "right to work" (Special Labour Permit) from the State Employment Support Agency for both employees and the self-employed — a residence permit alone is no longer sufficient.',
    'D1 visa/initial residence permit valid up to 1 year, renewable for up to 5 years',
    'D1 visa: in-person at Embassy of Georgia, New Delhi. Labour Permit: online via labourmigration.moh.gov.ge',
    1,
    'D1 visa: reported minimum ~2 months at the embassy. Special Labour Permit (new since March 2026): processed via a dedicated electronic portal; confirm current timelines directly',
    'Embassy of Georgia to the Republic of India, New Delhi (D1 visa); State Employment Support Agency, Georgia (Special Labour Permit, online)',
    'Secure a Georgian job offer, or plan qualifying self-employed/entrepreneurial activity\nApply for the "right to work" (Special Labour Permit) via labourmigration.moh.gov.ge, required since March 1, 2026 for employees and the self-employed alike\nApply for the D1 visa in person at the Embassy of Georgia, New Delhi\nTravel to Georgia and apply for a Residence Permit at a Public Service Hall\nRenew the Residence Permit annually, up to a maximum of 5 years',
    '/assets/images/visa-heroes/georgia.webp',
    'Cross-checked against immigration-law firm summaries (Andersen, Nomos Georgia, KPMG Flash Alert) of the March 2026 Special Labour Permit reform and D1 visa secondary sourcing; india.mfa.gov.ge not directly fetchable this session', 'https://india.mfa.gov.ge/en', '2026-09-17'
);
SET @geo4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@geo4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@geo4, 'Core Documents', 'Required from every applicant.', 1);
SET @geo4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@geo4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@geo4s1, 'Employment Contract or Business/Entrepreneur Registration', 'Employment contract for employees; business registration for self-employed applicants.', 'copy', 1, 0, 1, 2),
(@geo4s1, 'Special Labour Permit ("Right to Work") Approval', 'Mandatory since March 1, 2026 for both employees and the self-employed.', 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@geo4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @geo4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@geo4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@geo4s2, 'Proof of Financial Means', NULL, 'copy', 1, 0, 0, 2),
(@geo4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 3),
(@geo4s2, 'Proof of Accommodation in Georgia', NULL, 'copy', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(65, 4, NULL, 'USD', 'Confirmed After Assessment', 'D1 visa fee reported around USD 20 at the embassy; the new Special Labour Permit (in force since March 1, 2026) carries its own separate government fee not yet consistently reported across sources as of Sept 2026 — contact us to confirm current figures.', '2026-03-01', NOW(), 'https://india.mfa.gov.ge/en', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Georgia''s popular Individual Entrepreneur remote-worker regime still enough on its own?', 'No, not any more. As of March 1, 2026, holding a residence permit or Small Business Status alone is no longer sufficient. Self-employed foreigners, including sole proprietors under the 1% Individual Entrepreneur tax regime, must now separately obtain a "right to work" (Special Labour Permit) from the State Employment Support Agency before working or trading, alongside their D1 visa/work residence permit.', 65, 4, 6530, 1),
('What happens if I work without the new Special Labour Permit?', 'Georgian authorities can reportedly fine the employer, employee, or self-employed worker GEL 2,000 for labour activity carried out without the required "right to work," under the framework introduced from March 1, 2026 (Resolution No. 70).', 65, 4, 6531, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Short-Stay e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    65, 5, 'GEO-FAM-IN-05', '2026.09', 'published',
    'Short visits to relatives or friends resident in Georgia.',
    'Indian nationals visiting family/friends apply for the same short-stay e-Visa as Tourist, adding an invitation letter and proof of relationship with the host in Georgia. Travellers with a qualifying US/UK/Schengen/GCC etc. visa may instead enter visa-free.',
    'Up to 30 days per entry (120-day e-Visa validity); visa-free entrants up to 90 days in any 180-day period',
    'Apply online via evisa.gov.ge with a host invitation letter and relationship proof',
    0,
    'Standard e-Visa processing 5-7 working days; DuVerify identity check required within 24 hours of payment',
    'Georgia e-Visa Portal (evisa.gov.ge); Embassy of Georgia to the Republic of India, New Delhi handles long-stay/D-visa categories only',
    'Obtain an invitation letter from your host/relative resident in Georgia\nGather documents proving the family relationship\nRegister on evisa.gov.ge and complete the online application\nUpload documents, pay fees, and complete DuVerify verification\nReceive the e-Visa by email and carry a printed copy while travelling',
    '/assets/images/visa-heroes/georgia.webp',
    'Cross-checked against Georgian e-Visa portal secondary sourcing; evisa.gov.ge itself not directly fetchable this session — relationship-proof evidentiary standard not independently confirmed', 'https://evisa.gov.ge/en/', '2026-09-17'
);
SET @geo5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@geo5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@geo5, 'Core Documents', 'Required from every applicant.', 1);
SET @geo5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@geo5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@geo5s1, 'Invitation Letter from Host in Georgia', NULL, 'original', 1, 0, 1, 2),
(@geo5s1, 'Proof of Relationship to Host', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@geo5, 'Supporting Documents', 'Evidence of your own means.', 2);
SET @geo5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@geo5s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 1),
(@geo5s2, 'Mandatory Travel/Health Insurance (Min. GEL 30,000)', NULL, 'original', 1, 0, 0, 2),
(@geo5s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(65, 5, 20.00, 'USD', 'e-Visa Consular Fee (Plus Service Charge & DuVerify)', 'Same fee structure as Tourist (USD 20 + 2% service charge + USD 15 DuVerify).', '2026-01-01', NOW(), 'https://evisa.gov.ge/en/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What counts as proof of relationship for a Georgia Family Visit e-Visa?', 'Typically documents such as birth or marriage certificates establishing the family relationship, though the exact evidentiary standard for the e-Visa portal was not independently confirmed this session — verify current requirements directly on evisa.gov.ge before applying.', 65, 5, 6540, 1),
('Does my host in Georgia need to be a Georgian citizen?', 'This was not independently confirmed this session — hosts are commonly Georgian citizens or foreign residents holding a valid Georgian residence permit; confirm your specific case with the e-Visa portal or Embassy.', 65, 5, 6541, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Transit e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    65, 6, 'GEO-TRAN-IN-06', '2026.09', 'published',
    'Passing through a Georgian airport toward an onward destination.',
    'No visa is needed if you remain airside in the international transit area. If you must clear immigration and exit the transit zone (e.g. an overnight layover), Indian nationals apply for a transit e-Visa, valid for a stay of up to 72 hours.',
    'Up to 72 hours if exiting the international transit zone; no visa needed for a purely airside connection',
    'Apply online via evisa.gov.ge (transit category), only if you need to exit the international transit area',
    0,
    'Reported processing time of 5-7 working days for the transit e-Visa',
    'Georgia e-Visa Portal (evisa.gov.ge)',
    'Confirm whether your specific connection requires leaving the international transit area\nIf required, register on evisa.gov.ge for the transit e-Visa category\nUpload passport scan, photo, and confirmed onward ticket\nPay fees and complete DuVerify verification\nReceive the e-Visa by email and carry a printed copy while travelling',
    '/assets/images/visa-heroes/georgia.webp',
    'Cross-checked against Georgian e-Visa portal secondary sourcing on transit rules and the international-transit-zone exception; evisa.gov.ge itself not directly fetchable this session', 'https://evisa.gov.ge/en/', '2026-09-17'
);
SET @geo6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@geo6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@geo6, 'Core Documents', 'Required if a transit visa is genuinely needed.', 1);
SET @geo6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@geo6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@geo6s1, 'Confirmed Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@geo6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @geo6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@geo6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1),
(@geo6s2, 'Hotel Booking (If Overnight Layover)', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(65, 6, 20.00, 'USD', 'Transit e-Visa Fee (Approximate)', 'Reported consistent with the standard e-Visa fee structure (USD 20 + 2% service charge + USD 15 DuVerify) — confirm current figures at evisa.gov.ge.', '2026-01-01', NOW(), 'https://evisa.gov.ge/en/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa just to change planes in Georgia?', 'No — if you stay within the international transit area and do not clear immigration, no visa is required. A transit e-Visa (valid up to 72 hours) is only needed if you must exit the transit zone, for example for an overnight layover.', 65, 6, 6550, 1),
('Is the transit e-Visa fee the same as the tourist e-Visa fee?', 'Sourcing found this session reports the same USD 20 + 2% service charge + USD 15 DuVerify structure for the transit category, but treat this as approximate and confirm on evisa.gov.ge before applying.', 65, 6, 6551, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Short-Stay e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    65, 7, 'GEO-MED-IN-07', '2026.09', 'published',
    'Travel to Georgia to receive medical treatment.',
    'Indian nationals travelling for treatment apply for the same short-stay e-Visa as Tourist, supported by medical documentation such as a Health Condition Form and evidence of funds for treatment. Longer treatment courses may require a different long-stay category.',
    'Up to 30 days per entry (120-day e-Visa validity); longer treatment may require a different long-stay category — confirm with the Embassy',
    'Apply online via evisa.gov.ge with medical/health condition documentation',
    0,
    'Standard e-Visa processing 5-7 working days; DuVerify identity check required within 24 hours of payment',
    'Georgia e-Visa Portal (evisa.gov.ge); Embassy of Georgia to the Republic of India, New Delhi handles long-stay/D-visa categories only',
    'Gather a Health Condition Form/medical history summary and, if available, a hospital invitation letter\nArrange travel insurance covering medical treatment, hospitalization, and repatriation\nRegister on evisa.gov.ge and complete the online application\nUpload documents, pay fees, and complete DuVerify verification\nReceive the e-Visa by email and carry a printed copy while travelling',
    '/assets/images/visa-heroes/georgia.webp',
    'Cross-checked against Georgian e-Visa portal secondary sourcing on Type C medical-purpose travel; evisa.gov.ge itself not directly fetchable this session — hospital-invitation requirement not independently confirmed', 'https://evisa.gov.ge/en/', '2026-09-17'
);
SET @geo7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@geo7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@geo7, 'Core Documents', 'Required from every applicant.', 1);
SET @geo7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@geo7s1, 'Valid Passport (3+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@geo7s1, 'Health Condition Form/Medical History Summary', NULL, 'original', 1, 0, 1, 2),
(@geo7s1, 'Travel/Medical Insurance Covering Treatment', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@geo7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @geo7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@geo7s2, 'Hospital Invitation Letter (If Available)', NULL, 'copy', 0, 1, 0, 1),
(@geo7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(65, 7, 20.00, 'USD', 'e-Visa Consular Fee (Plus Service Charge & DuVerify)', 'Same fee structure as Tourist (USD 20 + 2% service charge + USD 15 DuVerify).', '2026-01-01', NOW(), 'https://evisa.gov.ge/en/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a hospital invitation letter mandatory for a Georgia medical e-Visa?', 'A general e-Visa documentation set was consistently found this session, but a formal hospital-invitation-letter requirement specific to medical-purpose travel was not independently confirmed. Include one if your treating hospital provides it, and verify current requirements with evisa.gov.ge before applying.', 65, 7, 6560, 1),
('Can I extend my stay if treatment takes longer than 30 days?', 'This was not independently confirmed this session — for treatment expected to exceed the standard e-Visa stay, contact the Embassy of Georgia, New Delhi, about whether a different long-stay category applies to your case.', 65, 7, 6561, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — e-Visa (Short) / D2 (Longer Missions)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    65, 8, 'GEO-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, seminars, and official professional missions in Georgia.',
    'Short conference visits typically use the same short-stay e-Visa as Tourist/Business with an event invitation letter. Longer or officially sponsored scientific/professional missions fall under Georgia''s D2 long-term visa category, applied for at the Embassy.',
    'Up to 30 days per entry on the e-Visa (120-day validity); D2 long-term missions follow separate validity terms set by the Embassy',
    'e-Visa (evisa.gov.ge) for short visits; D2 visa in person at Embassy of Georgia, New Delhi for longer missions',
    0,
    'e-Visa: 5-7 working days. D2 embassy processing: reported minimum ~2 months, consistent with other long-term categories',
    'Georgia e-Visa Portal (short visits) or Embassy of Georgia to the Republic of India, New Delhi (D2 long-term missions)',
    'Obtain a conference/event invitation or registration confirmation\nDetermine whether an e-Visa (short visit) or D2 visa (longer official mission) applies to your trip\nRegister on evisa.gov.ge, or book an embassy appointment for the D2 route\nSubmit documents and pay applicable fees\nReceive the e-Visa by email, or collect the D2 visa from the Embassy',
    '/assets/images/visa-heroes/georgia.webp',
    'Cross-checked against the D2 professional/scientific/cultural mission category and e-Visa short-stay sourcing; evisa.gov.ge and india.mfa.gov.ge not directly fetchable this session', 'https://evisa.gov.ge/en/', '2026-09-17'
);
SET @geo8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@geo8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@geo8, 'Core Documents', 'Required from every applicant.', 1);
SET @geo8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@geo8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@geo8s1, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@geo8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @geo8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@geo8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@geo8s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2),
(@geo8s2, 'Mandatory Travel/Health Insurance (For e-Visa Route)', NULL, 'original', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(65, 8, NULL, 'USD', 'Confirmed After Assessment', 'The e-Visa route follows the standard USD 20 + 2% service charge + USD 15 DuVerify structure for short visits; the D2 visa fee for longer official missions was not consistently reported across sources — confirm with the Embassy.', '2026-09-01', NOW(), 'https://india.mfa.gov.ge/en', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Which visa category covers conference attendance — e-Visa or D2?', 'It depends on the trip: a short conference visit within e-Visa stay limits (up to 30 days) typically uses the same short-stay e-Visa as Tourist/Business. A longer, officially sponsored scientific or professional mission instead falls under Georgia''s D2 long-term visa category, applied for at the Embassy of Georgia, New Delhi.', 65, 8, 6570, 1),
('Does Georgia bundle Conference visas with other purposes?', 'Yes — Georgia''s D2 long-term visa category officially groups scientific, sports, cultural, educational, and voluntary missions together under one visa type, so requirements overlap with the Sports checklist for longer, sponsored trips.', 65, 8, 6571, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — e-Visa (Short) / D2 (Longer Missions)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    65, 9, 'GEO-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in or supporting sporting events in Georgia.',
    'Georgia''s D2 long-term visa category explicitly covers sports missions alongside scientific, cultural, and educational activities. Short single-event trips more commonly use the standard e-Visa with an event/federation invitation letter.',
    'e-Visa: up to 30 days per entry (120-day validity); D2 sports missions follow separate, longer validity terms set by the Embassy',
    'e-Visa (evisa.gov.ge) for short trips; D2 visa in person at Embassy of Georgia, New Delhi for longer missions',
    0,
    'e-Visa: 5-7 working days. D2 embassy processing: reported minimum ~2 months',
    'Georgia e-Visa Portal (short visits) or Embassy of Georgia to the Republic of India, New Delhi (D2 sports missions)',
    'Obtain a letter from your sports federation/association confirming your role\nObtain an invitation letter from the host event organizer in Georgia\nDetermine whether an e-Visa or D2 visa applies based on trip length and sponsorship\nRegister on evisa.gov.ge, or book an embassy appointment for the D2 route\nSubmit documents, pay fees, and travel',
    '/assets/images/visa-heroes/georgia.webp',
    'Cross-checked against the D2 professional/scientific/sports/cultural mission category and e-Visa short-stay sourcing; evisa.gov.ge and india.mfa.gov.ge not directly fetchable this session', 'https://evisa.gov.ge/en/', '2026-09-17'
);
SET @geo9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@geo9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@geo9, 'Core Documents', 'Required from every applicant.', 1);
SET @geo9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@geo9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@geo9s1, 'Sports Federation/Association Letter', 'Confirms role and event participation.', 'original', 1, 0, 1, 2),
(@geo9s1, 'Host Event Organizer Invitation Letter', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@geo9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @geo9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@geo9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1),
(@geo9s2, 'Mandatory Travel/Health Insurance (For e-Visa Route)', NULL, 'original', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(65, 9, NULL, 'USD', 'Confirmed After Assessment', 'The e-Visa route follows the standard USD 20 + 2% service charge + USD 15 DuVerify structure for short trips; the D2 visa fee for longer sponsored sports missions was not consistently reported across sources — confirm with the Embassy.', '2026-09-01', NOW(), 'https://india.mfa.gov.ge/en', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Sports specifically named as its own Georgian visa category?', 'Not as a standalone category — Georgia''s D2 long-term visa explicitly groups sports missions together with scientific, cultural, and educational activities, while short single-event trips typically use the general short-stay e-Visa instead.', 65, 9, 6580, 1),
('Do I need two separate invitation letters for a sports trip?', 'Commonly yes in practice — one letter from your sports federation/association confirming your role, and a separate invitation letter from the host event organizer in Georgia detailing the event and arrangements.', 65, 9, 6581, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — D4 Family Reunification Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    65, 10, 'GEO-DEP-IN-10', '2026.09', 'published',
    'Spouse, minor children, or dependents joining an Indian national working or residing in Georgia.',
    'Family members of an Indian D1/work-permit holder or Georgian resident apply for the D4 family reunification visa. The D4 visa is issued for 90 days; the applicant must then apply for a matching residence permit at a Public Service Hall within 45 days of arrival.',
    'D4 visa valid 90 days to enter; residence permit thereafter matches the sponsor''s permit validity (typically 1 year, renewable)',
    'D4 visa: apply in person at the Embassy of Georgia, New Delhi. Not available via the e-Visa portal',
    1,
    'Reported minimum ~2 months for embassy-issued long-term visas, consistent with other D-category applications',
    'Embassy of Georgia to the Republic of India, 169 Jor Bagh, New Delhi',
    'Confirm the sponsor holds a qualifying Georgian work/residence permit\nGather relationship proof (marriage/birth certificates, apostilled and translated into Georgian)\nBook an appointment and apply in person at the Embassy of Georgia, New Delhi\nSubmit documents including proof of the sponsor''s funds (reported minimum GEL 6,000 bank balance)\nAfter arrival, apply for a matching Residence Permit at a Public Service Hall within 45 days',
    '/assets/images/visa-heroes/georgia.webp',
    'Cross-checked against Georgian family-reunification residence-permit secondary sourcing (D4 category) and immigration-law firm guidance; india.mfa.gov.ge not directly fetchable this session', 'https://india.mfa.gov.ge/en', '2026-09-17'
);
SET @geo10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@geo10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@geo10, 'Core Documents', 'Required from every applicant.', 1);
SET @geo10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@geo10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@geo10s1, 'Proof of Relationship (Apostilled, Translated into Georgian)', 'Marriage certificate for spouses, birth certificate for children.', 'original', 1, 0, 1, 2),
(@geo10s1, 'Copy of Sponsor''s D1 Visa/Residence Permit', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@geo10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit and finances.', 2);
SET @geo10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@geo10s2, 'Proof of Sponsor''s Funds (Min. GEL 6,000 Reported)', NULL, 'copy', 1, 0, 0, 1),
(@geo10s2, 'Health Insurance Valid in Georgia', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(65, 10, 20.00, 'USD', 'D4 Family Reunification Visa Fee (Approximate)', 'Reported consistent with other D-category visas at around USD 20; a separate Residence Permit fee applies after arrival — confirm current figures with the Embassy.', '2026-09-01', NOW(), 'https://india.mfa.gov.ge/en', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How soon after arrival must dependents register for a residence permit?', 'Within 45 days of entering Georgia on the D4 visa, at a Public Service Hall, per Georgia''s standard family-reunification process.', 65, 10, 6590, 1),
('Is there a minimum financial requirement for family reunification?', 'Secondary sourcing on Georgian family-reunification residence permits reports a minimum bank balance around GEL 6,000 — this was not directly verified against a primary government source this session, so confirm the current figure with the Embassy before applying.', 65, 10, 6591, 1);
