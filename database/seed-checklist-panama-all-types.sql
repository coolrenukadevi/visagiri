-- Panama Visa Checklist Engine content for all 10 visa types — built
-- this session via web search (WebFetch was blocked by network egress
-- for the primary official domains: indianembassypanama.gov.in,
-- fragomen.com, embassyofpanama.org, panamamissionindia.com — all
-- findings below are triangulated from WebSearch result snippets and
-- indexed secondary sourcing, not direct page fetches). hero_image_url
-- left NULL at authoring time.
--
-- IMPORTANT SOURCING CAVEAT: figures and dates below come from search
-- snippets of the Indian Embassy in Panama's advisory, a Fragomen
-- immigration-law bulletin, the Panama Consulate Mumbai site, and
-- several visa-agency/law-firm pages, none of which could be directly
-- fetched and cross-verified this session. The Medical, Conference,
-- and Sports visa categories in particular have NO dedicated Panama
-- government guidance findable via search — they are built on Panama's
-- general Category C "Consulted Visa" framework by extrapolation and
-- are flagged NOT INDEPENDENTLY CONFIRMED as distinct categories.
--
-- Panama's real, distinctive, search-verified facts:
--   - Panama's Servicio Nacional de Migracion sorts nationalities into
--     Category A/B (visa-exempt) and Category C ("Visa Consultada" /
--     Consulted Visa). India is Category C, meaning ordinary Indian
--     passport holders must obtain a physical stamped visa before
--     travel, applied for only through the Consulate General of Panama
--     in Mumbai — the sole Panama mission handling Indian applicants.
--   - Genuinely notable and current: per a Fragomen bulletin (first
--     reported November 2022) and search results describing the
--     situation as of August 2026, Panama's Ministry of Foreign
--     Affairs has suspended issuance of new stamped Tourist and
--     Business Visitor visas for Indian nationals, with no announced
--     resumption date. This is a live, unresolved suspension, not a
--     historical footnote — treat Tourist/Business content here as
--     describing a currently-blocked route plus the known workaround.
--   - The documented workaround: an Indian national holding a valid,
--     previously-used, multiple-entry visa (min. 6 months' remaining
--     validity) issued by the US, UK, Canada, Australia, Japan, South
--     Korea, Singapore, or an EU/Schengen member state may enter
--     Panama visa-free as a tourist without a separate Panama visa.
--   - A narrow carve-out survives the suspension: applicants who need
--     a tourist visa specifically to then apply for a Dependent
--     (family reunification) residence permit in Panama may apply
--     directly at the National Immigration Service (SNM) office in
--     Panama City, through an authorized/licensed immigration
--     attorney, bypassing the suspended Mumbai consulate route.
--   - India is explicitly NOT on Panama's Friendly Nations Visa list
--     (the popular fast-track residency program for ~50 named
--     countries) — Indian applicants for Work and Dependent status
--     must use the standard employer-sponsored labor-permit route or
--     the Family Reunification permit instead of that shortcut.
--   - Under Panama's Decree Law No. 3 of 2008 (Article 28), residency-
--     type applications (Student, Work, Dependent/Family Reunification)
--     must be filed through a licensed Panamanian immigration attorney
--     — applicants cannot self-file these directly with SNM.
--   - Panama's Labor Code Article 17 caps foreign employees at 10% of
--     a company's headcount/payroll (15% for specialized/technical
--     roles), which is why an employer-side justification is a
--     standard part of the Work-visa documentary bundle.
--
-- country_id 174 = Panama. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) - Category C Consulted Visa (currently suspended)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    174, 1, 'PAN-TOUR-IN-01', '2026.09', 'published',
    'Leisure, sightseeing, and personal travel to Panama.',
    'Indian passport holders are Category C (''Visa Consultada'') under Panama''s nationality classification. The Consulate General of Panama in Mumbai has suspended issuing stamped Tourist/Business visas since November 2022 with no confirmed resumption date; most Indian tourists currently rely on the visa-free workaround via a qualifying third-country visa instead.',
    'Up to 90 days if a stamped visa is ever issued; visa-free entry via a qualifying visa is commonly capped at 30 days', 'Stamped visa suspended since Nov 2022; workaround is visa-free entry on a valid US/UK/Schengen/Canada/Australia/Japan/Korea/Singapore visa',
    1,
    'New stamped-visa applications are not currently being accepted; the Consulate will announce reinstatement on its own website when it happens',
    'Consulate General of Panama, Mumbai (sole Panama mission handling Indian applicants)',
    'Check whether you already hold a valid, previously-used, multiple-entry visa (6+ months remaining) from the US, UK, Canada, Australia, Japan, South Korea, Singapore, or an EU/Schengen state
If yes, travel using that visa-free route (commonly reported as up to 30 days)
If no qualifying visa is held, contact the Consulate General of Panama, Mumbai directly, as stamped-visa applications remain suspended and no self-service alternative exists
Monitor the Consulate''s website for any announcement reinstating the stamped-visa process',
    '/assets/images/visa-heroes/panama.webp', 'Indian Embassy Panama advisory and a Fragomen immigration bulletin on the Tourist/Business visa suspension, triangulated via search snippets (direct fetch blocked this session)', 'https://www.fragomen.com/insights/panama-temporary-suspension-of-visitor-visas-for-indian-nationals.html', '2026-09-17'
);
SET @pan1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pan1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pan1, 'Core Documents', 'Required if the Consulate ever reinstates stamped Tourist visa applications.', 1);
SET @pan1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pan1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pan1s1, 'Completed Visa Application Form', NULL, 'copy', 1, 0, 1, 2),
(@pan1s1, 'Two Recent Passport-Size Photographs', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pan1, 'Supporting Documents', 'Evidence of your travel plans, funds, and the visa-free workaround if applicable.', 2);
SET @pan1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pan1s2, 'Confirmed Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 1),
(@pan1s2, 'Hotel Booking or Accommodation Proof', NULL, 'copy', 1, 0, 0, 2),
(@pan1s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3),
(@pan1s2, 'Valid Multiple-Entry US/UK/Schengen/Canada/Australia/Japan/Korea/Singapore Visa', 'Used to enter Panama visa-free instead of the currently suspended stamped visa; must be previously used with 6+ months remaining validity.', 'if_applicable', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(174, 1, 60.00, 'USD', 'Consulted Visa Fee (Historic Figure - Applications Suspended)', 'Reported historically as $50 visa fee + $10 consular charge by the Mumbai consulate; other sources cite differing INR figures. Not currently collectible while stamped-visa applications remain suspended - treat as approximate and pending reconfirmation.', '2022-11-01', NOW(), 'https://panamamissionindia.com/visa/visa-information/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian passport holders still get a Panama Tourist visa right now?', 'New stamped Tourist visa applications for Indian nationals have been suspended by Panama''s Ministry of Foreign Affairs since November 2022, per an Indian Embassy Panama advisory and Fragomen immigration bulletin, with no confirmed resumption date as of September 2026. Most travellers instead use the visa-free workaround described below.', 174, 1, 17400, 1),
('How can I visit Panama without the suspended stamped visa?', 'If you hold a valid, previously-used, multiple-entry visa from the US, UK, Canada, Australia, Japan, South Korea, Singapore, or an EU/Schengen state with at least 6 months'' remaining validity, you can reportedly enter Panama visa-free as a tourist - confirm current terms with the Consulate before travel.', 174, 1, 17401, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) - Category C Consulted Visa (currently suspended)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    174, 2, 'PAN-BUS-IN-02', '2026.09', 'published',
    'Trade meetings, negotiations, and commercial activity in Panama.',
    'Indian nationals travelling for business use the same Category C ''Visa Consultada'' as Tourist. Fragomen and the Indian Embassy in Panama both confirm the November 2022 suspension explicitly covers Business Visitor visas alongside Tourist, so the same visa-free workaround applies in practice.',
    'Up to 90 days if a stamped visa is ever issued; visa-free entry via a qualifying visa is commonly capped at 30 days', 'Stamped visa applications suspended since Nov 2022 (explicitly includes Business); workaround is visa-free entry on a qualifying third-country visa',
    1,
    'New stamped-visa applications are not currently being accepted; the Consulate will announce reinstatement on its own website when it happens',
    'Consulate General of Panama, Mumbai (sole Panama mission handling Indian applicants)',
    'Check whether you already hold a valid, previously-used, multiple-entry visa (6+ months remaining) from the US, UK, Canada, Australia, Japan, South Korea, Singapore, or an EU/Schengen state
If yes, travel using that visa-free route with your business invitation letter in hand
If no qualifying visa is held, contact the Consulate General of Panama, Mumbai directly, as stamped Business visa applications remain suspended
Monitor the Consulate''s website for any announcement reinstating the stamped-visa process',
    '/assets/images/visa-heroes/panama.webp', 'Indian Embassy Panama advisory and a Fragomen immigration bulletin on the Tourist/Business visa suspension, triangulated via search snippets (direct fetch blocked this session)', 'https://www.fragomen.com/insights/panama-temporary-suspension-of-visitor-visas-for-indian-nationals.html', '2026-09-17'
);
SET @pan2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pan2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pan2, 'Core Documents', 'Required if the Consulate ever reinstates stamped Business visa applications.', 1);
SET @pan2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pan2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pan2s1, 'Invitation Letter from Panama Host Company', NULL, 'original', 1, 0, 1, 2),
(@pan2s1, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pan2, 'Supporting Documents', 'Evidence of your employment and the visa-free workaround if applicable.', 2);
SET @pan2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pan2s2, 'Company Registration/Business Proof (Indian Employer)', NULL, 'copy', 0, 1, 0, 1),
(@pan2s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2),
(@pan2s2, 'Valid Multiple-Entry US/UK/Schengen/Canada/Australia/Japan/Korea/Singapore Visa', 'Used to enter Panama visa-free instead of the currently suspended stamped visa.', 'if_applicable', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(174, 2, 60.00, 'USD', 'Consulted Visa Fee (Historic Figure - Applications Suspended)', 'Same historic $50 visa + $10 consular charge structure reported for Tourist; not currently collectible while stamped-visa applications remain suspended - treat as approximate.', '2022-11-01', NOW(), 'https://panamamissionindia.com/visa/visa-information/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Business visa suspension the same as the Tourist visa suspension?', 'Yes - search-indexed reporting confirms Panama''s Ministry of Foreign Affairs suspension explicitly covers both Tourist and Business Visitor visas for Indian nationals together, not just Tourist.', 174, 2, 17402, 1),
('Do I still need a Panama-side invitation letter if I use the visa-free workaround?', 'Immigration officers may still ask for proof of your business purpose at the port of entry, so carrying your host company''s invitation letter and employer forwarding letter is recommended even when entering visa-free.', 174, 2, 17403, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) - Study Permit via Licensed Immigration Attorney
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    174, 3, 'PAN-STU-IN-03', '2026.09', 'published',
    'Enrolling in an accredited Panamanian university or institution.',
    'Indian nationals admitted to an accredited Panamanian institution apply for a Student visa/permit through Panama''s National Immigration Service (SNM). Under Decree Law No. 3 of 2008 (Article 28), the application must be filed by a licensed Panamanian immigration attorney, not self-filed by the applicant.',
    'Valid for the academic program duration, generally renewable annually', 'Filed by a licensed Panamanian immigration attorney with SNM; applicants also typically need consular clearance at Panama''s Mumbai Consulate',
    0,
    'Reported total timeline of roughly 6-12 weeks including document apostille and attorney filing; apply at least 3 months before your intended start date',
    'National Immigration Service (SNM), Panama City, filed via a licensed immigration attorney; Consulate General of Panama, Mumbai for consular clearance',
    'Secure admission at an accredited Panamanian institution
Apostille your academic transcripts, police clearance certificate, and other civil documents in India
Engage a licensed Panamanian immigration attorney (legally required to file the application)
Attorney files the Student visa/permit application with SNM in Panama City
Complete any required consular formality at the Mumbai Consulate given India''s Category C status
Renew annually for multi-year programs',
    '/assets/images/visa-heroes/panama.webp', 'Panama immigration-law-firm guidance on Decree Law No. 3 of 2008 and SNM residency procedure, triangulated via search snippets (direct fetch blocked this session)', 'https://indianembassypanama.gov.in/eoipa_pages/MzEz', '2026-09-17'
);
SET @pan3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pan3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pan3, 'Core Documents', 'Required from every applicant.', 1);
SET @pan3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pan3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@pan3s1, 'Apostilled Letter of Acceptance from Accredited Institution', NULL, 'original', 1, 0, 1, 2),
(@pan3s1, 'Power of Attorney for Licensed Panamanian Immigration Attorney', 'Legally required under Decree Law No. 3 of 2008, Article 28.', 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pan3, 'Supporting Documents', 'Evidence of your academic background, funds, and health cover.', 2);
SET @pan3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pan3s2, 'Apostilled Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@pan3s2, 'Apostilled Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2),
(@pan3s2, 'Proof of Funds/Sponsorship Letter', NULL, 'copy', 1, 0, 0, 3),
(@pan3s2, 'Health/Medical Insurance Valid in Panama', NULL, 'original', 1, 0, 0, 4),
(@pan3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 5);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(174, 3, NULL, 'USD', 'Confirmed After Assessment', 'SNM government permit fees plus mandatory licensed-attorney fees vary by case and law firm; figures were not consistently reported across sources - contact us to confirm current totals.', '2026-09-01', NOW(), 'https://indianembassypanama.gov.in/eoipa_pages/MzEz', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I file my own Panama Student visa application without an attorney?', 'No - under Panama''s Decree Law No. 3 of 2008 (Article 28), visa and residency-type applications including Student permits must be filed through a licensed Panamanian immigration attorney; self-filing directly with SNM is not permitted.', 174, 3, 17404, 1),
('Can I work while studying in Panama on a Student visa?', 'Panama''s Student permit is generally tied to your enrolment status and does not automatically grant open work authorization the way some other countries'' student visas do - confirm current work-eligibility rules with your immigration attorney before taking up any paid work.', 174, 3, 17405, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) - Employer-Sponsored Labor + Immigration Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    174, 4, 'PAN-WORK-IN-04', '2026.09', 'published',
    'Employment with a Panama-registered employer via the two-part labor and immigration permit process.',
    'Indian nationals with a confirmed job offer from a Panama-registered employer. India is not on Panama''s Friendly Nations Visa list, so the standard route applies: a Ministry of Labor (MITRADEL) labor permit plus a National Immigration Service (SNM) immigration permit, filed via a licensed immigration attorney. Panama''s Labor Code Article 17 caps foreign staff at 10% of headcount/payroll (15% for specialists).',
    'Tied to the employment contract and permit validity; renewable while employment continues', 'Employer-driven two-part process (MITRADEL labor permit, then SNM immigration permit), filed by a licensed Panamanian immigration attorney',
    0,
    'MITRADEL labor-permit review reported at roughly 1-3 months; the subsequent SNM immigration-permit stage adds further time',
    'Ministry of Labor (MITRADEL) and National Immigration Service (SNM), Panama City, filed via a licensed immigration attorney',
    'Secure a job offer from a Panama-registered employer able to justify hiring a foreign worker under the 10%/15% foreign-headcount cap
Employer/attorney files the labor permit petition with MITRADEL
Once the labor permit is approved, the immigration permit application is filed with SNM
Gather apostilled educational/professional certificates and police clearance
Attend biometrics/interview as required
Register the employment contract with Panama''s Social Security fund on approval',
    '/assets/images/visa-heroes/panama.webp', 'Panama immigration-law-firm guidance on Decree Law No. 3 of 2008 and SNM residency procedure, triangulated via search snippets (direct fetch blocked this session)', 'https://indianembassypanama.gov.in/eoipa_pages/MzEz', '2026-09-17'
);
SET @pan4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pan4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pan4, 'Core Documents', 'Required from every applicant.', 1);
SET @pan4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pan4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@pan4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2),
(@pan4s1, 'Employer''s Foreign-Hire Justification/MITRADEL Filing', 'Confirms compliance with the Labor Code Article 17 90/10 foreign-headcount cap.', 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pan4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @pan4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pan4s2, 'Apostilled Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@pan4s2, 'Apostilled Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2),
(@pan4s2, 'Power of Attorney for Licensed Panamanian Immigration Attorney', 'Legally required under Decree Law No. 3 of 2008, Article 28.', 'original', 1, 0, 0, 3),
(@pan4s2, 'Social Security Registration of Employment Contract', NULL, 'copy', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(174, 4, NULL, 'USD', 'Confirmed After Assessment', 'MITRADEL labor-permit and SNM immigration-permit government fees, plus mandatory licensed-attorney fees, vary by permit type and were not consistently reported - contact us to confirm current totals.', '2026-09-01', NOW(), 'https://indianembassypanama.gov.in/eoipa_pages/MzEz', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is India covered by Panama''s Friendly Nations Visa fast track for work?', 'No - search results confirm India is explicitly not on Panama''s Friendly Nations Visa list of roughly 50 eligible countries, so Indian applicants must use the standard employer-sponsored MITRADEL/SNM labor-and-immigration-permit route instead.', 174, 4, 17406, 1),
('Is there a limit on how many foreign employees a Panama company can hire?', 'Yes - Panama''s Labor Code Article 17 generally caps foreign employees at 10% of a company''s total headcount and payroll, rising to 15% for specialized or technical roles, which is why employers must justify foreign hires as part of the labor-permit filing.', 174, 4, 17407, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) - Category C Consulted Visa (suspension status ambiguous)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    174, 5, 'PAN-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives resident in Panama on a short-term, non-immigrant basis.',
    'Indian nationals visiting family use the same Category C ''Visa Consultada'' route as Tourist, plus an invitation letter and relationship proof. Sources confirm the Tourist/Business suspension explicitly; whether short Family Visit trips are separately processed was NOT independently confirmed this session - treat as likely following the same suspended route pending confirmation.',
    'Up to 90 days if a stamped visa is issued; visa-free entry via a qualifying visa is commonly capped at 30 days', 'Category C consulted-visa route via Consulate General of Panama, Mumbai; may be affected by the Tourist/Business suspension - not confirmed',
    1,
    'Contact the Consulate General of Panama, Mumbai directly to confirm current Family Visit processing status given the ongoing Tourist/Business suspension',
    'Consulate General of Panama, Mumbai (sole Panama mission handling Indian applicants)',
    'Obtain an invitation letter from your family member resident in Panama
Gather documents proving the family relationship (birth/marriage certificates)
Confirm current processing status with the Consulate General of Panama, Mumbai, given the ongoing Tourist/Business suspension
If a stamped visa cannot be issued, consider the visa-free workaround via a qualifying third-country visa if you hold one',
    '/assets/images/visa-heroes/panama.webp', 'Not independently confirmed this session - extrapolated from the Category C consulted-visa framework and the confirmed Tourist/Business suspension', 'https://indianembassypanama.gov.in/eoipa_pages/MzEz', '2026-09-17'
);
SET @pan5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pan5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pan5, 'Core Documents', 'Required if the Consulate accepts a Family Visit application.', 1);
SET @pan5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pan5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pan5s1, 'Invitation Letter from Family Member in Panama', NULL, 'original', 1, 0, 1, 2),
(@pan5s1, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pan5, 'Supporting Documents', 'Evidence of your own means and travel plans.', 2);
SET @pan5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pan5s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 1),
(@pan5s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2),
(@pan5s2, 'Valid Multiple-Entry US/UK/Schengen/Canada/Australia/Japan/Korea/Singapore Visa', 'Alternative entry route if the stamped visa route is unavailable.', 'if_applicable', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(174, 5, NULL, 'USD', 'Confirmed After Assessment', 'Family Visit fee not separately confirmed this session; historic Tourist/Business figures ($50 visa + $10 consular charge) may serve as a rough reference pending confirmation.', '2026-09-01', NOW(), 'https://panamamissionindia.com/visa/visa-information/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Family Visit visa affected by the Tourist/Business suspension?', 'This was NOT independently confirmed this session. The confirmed suspension explicitly names Tourist and Business Visitor visas; whether short family-visit trips are processed separately was not established from available sources - contact the Consulate General of Panama, Mumbai directly to confirm.', 174, 5, 17408, 1),
('What if my family member in Panama is themselves a foreign resident, not a citizen?', 'An invitation letter from any Panama-resident family member, along with relationship proof, is the general expectation - if your host is on a residence permit rather than a citizen, also include a copy of their permit.', 174, 5, 17409, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) - International Transit Zone / Resolution No. 24430
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    174, 6, 'PAN-TRAN-IN-06', '2026.09', 'published',
    'Passing through Tocumen International Airport, Panama City, en route to a third country.',
    'Indian nationals may transit for up to 12 hours within Tocumen Airport''s international transit zone without a Panama visa. Leaving the transit zone, or a longer layover, requires a transit visa; Indian nationals are admitted for transit only where they meet the conditions of Resolution No. 24430.',
    'Up to 12 hours visa-free within the international transit zone; a transit visa covers longer or landside connections', 'Visa-free for pure airside transit under 12 hours; otherwise apply via the Consulate General of Panama, Mumbai under Resolution No. 24430 conditions',
    1,
    'Not separately confirmed this session; likely follows general Consulted Visa processing given India''s Category C status',
    'Consulate General of Panama, Mumbai (sole Panama mission handling Indian applicants)',
    'Confirm whether your connection stays within Tocumen Airport''s international transit zone and under 12 hours - if so, no visa is required
If you must leave the transit zone or your layover exceeds 12 hours, confirm you meet Resolution No. 24430''s admission conditions
If a transit visa is required, apply via the Consulate General of Panama, Mumbai with your onward ticket and visa for the final destination
Carry proof of your confirmed onward itinerary at all times',
    '/assets/images/visa-heroes/panama.webp', 'Not independently confirmed in full - the 12-hour transit-zone exemption and Resolution No. 24430 reference are search-verified; fee and full processing detail were not found', 'https://indianembassypanama.gov.in/eoipa_pages/MzEz', '2026-09-17'
);
SET @pan6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pan6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pan6, 'Core Documents', 'Required only if you must leave the international transit zone or your layover exceeds 12 hours.', 1);
SET @pan6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pan6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@pan6s1, 'Onward Flight Ticket to Final Destination', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pan6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @pan6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pan6s2, 'Valid Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1),
(@pan6s2, 'Proof of Confirmed Return/Onward Itinerary', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(174, 6, NULL, 'USD', 'Confirmed After Assessment', 'Transit visa fee was not separately documented in sources found this session, distinct from the Tourist/Business figures - contact us to confirm before travel.', '2026-09-01', NOW(), 'https://panamamissionindia.com/visa/visa-information/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa just to connect through Panama City airport?', 'Not if you stay within Tocumen International Airport''s international transit zone for up to 12 hours - no Panama visa is required for that scenario, per search-verified guidance.', 174, 6, 17410, 1),
('What is Resolution No. 24430 and why does it matter for Indian transit passengers?', 'It is the Panamanian regulation governing which foreign nationals, including Indians, may be admitted for transit beyond the visa-free airside window, subject to specified conditions - confirm your specific case meets those conditions before relying on transit-only entry.', 174, 6, 17411, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) - Category C Consulted Visa (general framework, not independently confirmed as distinct)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    174, 7, 'PAN-MED-IN-07', '2026.09', 'published',
    'Travel to Panama to receive medical treatment.',
    'No dedicated Panama government guidance for a distinct Medical visa category was found this session. This entry extrapolates from Panama''s general Category C ''Consulted Visa'' framework used for Tourist/Business, adding a treatment-confirmation letter. NOT INDEPENDENTLY CONFIRMED as a formally distinct visa category - verify directly with the Consulate before relying on this content.',
    'Not independently confirmed; likely follows the general Category C stay allowance (up to 90 days) if issued', 'Not independently confirmed; likely follows the Consulate General of Panama, Mumbai route used for Tourist/Business, which remains suspended',
    1,
    'Not independently confirmed this session - contact the Consulate General of Panama, Mumbai directly for current Medical-purpose processing guidance',
    'Consulate General of Panama, Mumbai (sole Panama mission handling Indian applicants)',
    'Obtain a written confirmation from the treating Panamanian hospital or doctor
Gather medical records and referral documentation
Arrange travel/medical insurance covering your treatment period
Contact the Consulate General of Panama, Mumbai directly to confirm current processing given the ongoing Tourist/Business suspension',
    '/assets/images/visa-heroes/panama.webp', 'NOT independently confirmed this session - no dedicated Panama Medical visa guidance was found; extrapolated from the general Category C framework', 'https://indianembassypanama.gov.in/eoipa_pages/MzEz', '2026-09-17'
);
SET @pan7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pan7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pan7, 'Core Documents', 'Best-effort list pending direct Consulate confirmation.', 1);
SET @pan7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pan7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pan7s1, 'Treatment Confirmation Letter from Panamanian Hospital/Doctor', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pan7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @pan7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pan7s2, 'Medical Records/Referral from Treating Physician in India', NULL, 'copy', 1, 0, 0, 1),
(@pan7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2),
(@pan7s2, 'Travel/Medical Insurance', NULL, 'original', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(174, 7, NULL, 'USD', 'Confirmed After Assessment', 'No dedicated Medical visa fee was found this session; contact the Consulate General of Panama, Mumbai directly to confirm the current fee structure.', '2026-09-01', NOW(), 'https://panamamissionindia.com/visa/visa-information/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Panama have a separate Medical visa category for Indian patients?', 'This was NOT independently confirmed this session - no dedicated Panama government guidance for a distinct Medical visa category was found. Contact the Consulate General of Panama, Mumbai directly before travelling for treatment.', 174, 7, 17412, 1),
('Is the Medical visa affected by the Tourist/Business suspension?', 'Not independently confirmed - if Panama processes Medical-purpose travel under the same Category C consulted-visa route as Tourist/Business, it may be similarly affected. Confirm directly with the Consulate.', 174, 7, 17413, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) - Category C Consulted Visa (general framework, not independently confirmed as distinct)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    174, 8, 'PAN-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, congresses, or trade fairs in Panama.',
    'No dedicated Panama government guidance for a distinct Conference visa category was found this session. This entry extrapolates from the general Category C ''Consulted Visa'' framework used for Business, adding a conference invitation letter. NOT INDEPENDENTLY CONFIRMED as a formally distinct visa category - verify directly with the Consulate before relying on this content.',
    'Not independently confirmed; likely follows the general Category C stay allowance (up to 90 days) if issued', 'Not independently confirmed; likely follows the same Consulate General of Panama, Mumbai route as Business, which remains suspended',
    1,
    'Not independently confirmed this session - contact the Consulate General of Panama, Mumbai directly for current Conference-purpose processing guidance',
    'Consulate General of Panama, Mumbai (sole Panama mission handling Indian applicants)',
    'Obtain a conference invitation or registration confirmation from the host organizer in Panama
Gather your employer''s forwarding letter and proof of accommodation
Contact the Consulate General of Panama, Mumbai directly to confirm current processing given the ongoing Business visa suspension
If a stamped visa cannot be issued, consider the visa-free workaround via a qualifying third-country visa if you hold one',
    '/assets/images/visa-heroes/panama.webp', 'NOT independently confirmed this session - no dedicated Panama Conference visa guidance was found; extrapolated from the general Category C framework', 'https://indianembassypanama.gov.in/eoipa_pages/MzEz', '2026-09-17'
);
SET @pan8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pan8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pan8, 'Core Documents', 'Best-effort list pending direct Consulate confirmation.', 1);
SET @pan8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pan8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pan8s1, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pan8, 'Supporting Documents', 'Additional employer-side and travel evidence.', 2);
SET @pan8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pan8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@pan8s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2),
(@pan8s2, 'Valid Multiple-Entry US/UK/Schengen/Canada/Australia/Japan/Korea/Singapore Visa', 'Alternative entry route if the stamped visa route is unavailable.', 'if_applicable', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(174, 8, NULL, 'USD', 'Confirmed After Assessment', 'No dedicated Conference visa fee was found this session; contact the Consulate General of Panama, Mumbai directly to confirm the current fee structure.', '2026-09-01', NOW(), 'https://panamamissionindia.com/visa/visa-information/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Panama have a separate Conference visa category for Indian delegates?', 'This was NOT independently confirmed this session - no dedicated Panama government guidance for a distinct Conference visa category was found; it is treated here as following the general Business/Category C route.', 174, 8, 17414, 1),
('Can I use the visa-free workaround to attend a Panama conference?', 'If you hold a valid, previously-used, multiple-entry visa from a qualifying country (US, UK, Canada, Australia, Japan, South Korea, Singapore, or an EU/Schengen state), the same workaround reported for Tourist/Business travel may apply - confirm before booking.', 174, 8, 17415, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) - Category C Consulted Visa (general framework, not independently confirmed as distinct)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    174, 9, 'PAN-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing or officiating in Panama.',
    'No dedicated Panama government guidance for a distinct Sports visa category was found this session. This entry extrapolates from the general Category C ''Consulted Visa'' framework, adding a sports-federation letter and event organizer invitation. NOT INDEPENDENTLY CONFIRMED as a formally distinct visa category - verify directly with the Consulate before relying on this content.',
    'Not independently confirmed; likely follows the general Category C stay allowance (up to 90 days) if issued', 'Not independently confirmed; likely follows the same Consulate General of Panama, Mumbai route as Tourist/Business, which remains suspended',
    1,
    'Not independently confirmed this session - contact the Consulate General of Panama, Mumbai directly for current Sports-purpose processing guidance',
    'Consulate General of Panama, Mumbai (sole Panama mission handling Indian applicants)',
    'Obtain a letter from your resident-country sports federation/association confirming your role
Obtain an invitation letter from the host event organizer in Panama with event details
Contact the Consulate General of Panama, Mumbai directly to confirm current processing given the ongoing Tourist/Business suspension
If a stamped visa cannot be issued, consider the visa-free workaround via a qualifying third-country visa if you hold one',
    '/assets/images/visa-heroes/panama.webp', 'NOT independently confirmed this session - no dedicated Panama Sports visa guidance was found; extrapolated from the general Category C framework', 'https://indianembassypanama.gov.in/eoipa_pages/MzEz', '2026-09-17'
);
SET @pan9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pan9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pan9, 'Core Documents', 'Best-effort list pending direct Consulate confirmation.', 1);
SET @pan9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pan9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@pan9s1, 'Home-Country Sports Federation/Association Letter', NULL, 'original', 1, 0, 1, 2),
(@pan9s1, 'Host Event Organizer Invitation Letter', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pan9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @pan9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pan9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1),
(@pan9s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(174, 9, NULL, 'USD', 'Confirmed After Assessment', 'No dedicated Sports visa fee was found this session; contact the Consulate General of Panama, Mumbai directly to confirm the current fee structure.', '2026-09-01', NOW(), 'https://panamamissionindia.com/visa/visa-information/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Panama have a separate Sports visa category for Indian athletes?', 'This was NOT independently confirmed this session - no dedicated Panama government guidance for a distinct Sports visa category was found; it is treated here as following the general Category C route with sports-specific supporting letters.', 174, 9, 17416, 1),
('What documentation is specific to a sports delegation vs. a generic tourist visit?', 'Best-effort guidance suggests a letter from your home-country sports federation confirming your role plus a host event organizer''s invitation, similar to how other countries structure this category - confirm exact requirements with the Consulate directly.', 174, 9, 17417, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) - Family Reunification Residence Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    174, 10, 'PAN-DEP-IN-10', '2026.09', 'published',
    'Spouse, minor children, or dependent parents joining an Indian citizen/resident sponsor in Panama.',
    'Family members of a Panama citizen or legal resident. Since India is not on Panama''s Friendly Nations Visa list, the Family Reunification Visa is the standard route: applicants first obtain a two-year provisional residence permit, then apply for permanent residence, filed via a licensed immigration attorney under Decree Law No. 3 of 2008.',
    'Two-year provisional residence permit, then eligible to apply for permanent residence', 'Filed by a licensed Panamanian immigration attorney with the National Immigration Service (SNM), Panama City',
    0,
    'Provisional residence permit stage reported at multiple months; a narrow carve-out lets applicants get the entry tourist visa directly from SNM in Panama City (via attorney), bypassing the suspended Mumbai consulate route',
    'National Immigration Service (SNM), Panama City, filed via a licensed immigration attorney',
    'Confirm the Panama-based sponsor''s citizenship or qualifying residence status
Gather apostilled relationship proof (marriage/birth certificates) and the sponsor''s residence/citizenship documents
Engage a licensed Panamanian immigration attorney (legally required under Decree Law No. 3 of 2008)
If a tourist-visa entry is needed first, apply directly at SNM in Panama City through the attorney, which is exempt from the general Mumbai-consulate suspension for this specific purpose
Attorney files the two-year provisional residence permit application with SNM
Apply for permanent residence after completing the provisional period and meeting requirements',
    '/assets/images/visa-heroes/panama.webp', 'Panama immigration-law-firm guidance on Decree Law No. 3 of 2008 and SNM residency procedure, triangulated via search snippets (direct fetch blocked this session)', 'https://indianembassypanama.gov.in/eoipa_pages/MzEz', '2026-09-17'
);
SET @pan10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@pan10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pan10, 'Core Documents', 'Required from every applicant.', 1);
SET @pan10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pan10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@pan10s1, 'Apostilled Proof of Relationship to Sponsor', NULL, 'original', 1, 0, 1, 2),
(@pan10s1, 'Sponsor''s Panama Citizenship/Residence Permit Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@pan10, 'Supporting Documents', 'Additional evidence tied to the residence application.', 2);
SET @pan10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@pan10s2, 'Power of Attorney for Licensed Panamanian Immigration Attorney', 'Legally required under Decree Law No. 3 of 2008, Article 28.', 'original', 1, 0, 0, 1),
(@pan10s2, 'Apostilled Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2),
(@pan10s2, 'Proof of Sponsor''s Financial Means', NULL, 'copy', 1, 0, 0, 3),
(@pan10s2, 'Proof of Full-Time Enrollment (Dependent Students Under 25)', NULL, 'copy', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(174, 10, NULL, 'USD', 'Confirmed After Assessment', 'SNM provisional residence permit government fees plus mandatory licensed-attorney fees vary by case and law firm; figures were not consistently reported - contact us to confirm current totals.', '2026-09-01', NOW(), 'https://indianembassypanama.gov.in/eoipa_pages/MzEz', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I get a Panama tourist visa specifically to apply for a Dependent permit, even though tourist visas are suspended?', 'Yes - a narrow exception reported alongside the Tourist/Business suspension allows applicants who need a tourist visa specifically to then apply for a Dependent residence permit to apply directly at the National Immigration Service (SNM) office in Panama City, through a licensed attorney, bypassing the suspended Mumbai consulate route.', 174, 10, 17418, 1),
('Is India eligible for Panama''s Friendly Nations Visa as a faster route to bring dependents?', 'No - India is explicitly not on Panama''s Friendly Nations Visa list of roughly 50 eligible countries, so Indian sponsors and their dependents use the standard Family Reunification two-year provisional residence permit route instead.', 174, 10, 17419, 1);

