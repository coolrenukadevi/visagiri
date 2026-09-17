-- Belgium Visa Checklist Engine content for all 10 visa types — built
-- this session via WebSearch (WebFetch to india.diplomatie.belgium.be was
-- blocked by network egress). All facts below were cross-checked across
-- multiple independent secondary sources (VFS Global's own India-Belgium
-- portal, Belgian government sub-pages for other countries that mirror
-- the India page's structure, IBZ/dofi.ibz.be, FPS Employment, and
-- KPMG/EY 2026 mobility-fee alerts). Fee and processing-time figures are
-- flagged as approximate/reported where sources varied.
--
-- Belgium's real, distinctive, verified facts:
--   - Genuine regional complexity: labour migration for the Single
--     Permit (work + residence in one) is co-administered federally
--     (shared one-stop online portal since 2026) but assessed by
--     Flanders, Wallonia, or Brussels individually, each with its own
--     EU Blue Card salary threshold (reported ~EUR 63,586 Flanders,
--     ~EUR 56,112 Wallonia, ~EUR 61,011 Brussels), shortage-occupation
--     labour-market-test exemptions, and portal/fee specifics. Flanders
--     relaunched its own Single-Permit portal in January 2026 with
--     tighter criteria for some medium-skilled roles.
--   - CONFIRMED dated policy change: the Visa D (long-stay) handling fee
--     rose from EUR 180 to EUR 250 effective 1 July 2026, per multiple
--     independent sources (Belgian government notices, KPMG and EY 2026
--     mobility alerts) — applies to Student, Work/Single Permit, and
--     Dependent/family-reunification long-stay applications. Flanders
--     separately added a regional Single Permit retribution (reported
--     ~EUR 180) on top of this.
--   - Transit: Indian nationals are generally NOT on the EU Regulation
--     2018/1806 Annex I list of nationalities requiring Belgium's Type A
--     airport transit visa (that list names countries such as
--     Afghanistan, Bangladesh, and DRC), so most Indian travellers can
--     connect airside through a Belgian airport without one — a useful,
--     genuinely distinctive fact for this category.
--   - Family reunification (Dependent) processing is reported to run up
--     to approximately 9 months — notably longer than the short-stay
--     Schengen categories' 12-20 working day norm.
--   - Student visa holders must register at their local commune within
--     8 working days of arrival to receive the physical residence card.
--   - NOT independently confirmed this session (best-effort structure
--     only, flagged per-category above where relevant): the exact
--     applicant-facing cost breakdown/payer for the Single Permit
--     component of the Work visa (fee note explains why); the precise
--     Type A transit visa fee for the rare cases where one applies to
--     an Indian traveller; and any India-specific bilateral concession
--     beyond the general EU/Schengen and Belgian federal rules above.
--
-- country_id 110 = Belgium. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    110, 1, 'BEL-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Belgium.',
    'Indian passport holders — the standard Schengen C-type visa, applied via VFS Global, valid for travel across the wider Schengen area, not just Belgium.',
    'Single or multiple entry, up to 90 days within any 180-day period',
    'Apply via VFS Global (multiple Indian cities); online form plus in-person biometrics appointment',
    1,
    'Standard Schengen processing is typically 12-20 working days, longer in peak season (Apr-Sep)',
    'Embassy of Belgium, New Delhi / Consulate General of Belgium, Mumbai (decision authority), via VFS Global centres',
    'Book a VFS Global appointment
Complete the online Schengen visa application form
Gather supporting documents
Attend the appointment and submit biometrics (mandatory for first-time applicants)
Track status and collect your passport',
    '/assets/images/visa-heroes/belgium.webp',
    'Cross-checked against VFS Global India secondary sourcing and Schengen-visa agency guidance; the official india.diplomatie.belgium.be page was not directly fetchable this session (egress blocked)', 'https://visa.vfsglobal.com/ind/en/bel', '2026-09-17'
);
SET @bel1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bel1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bel1, 'Core Documents', 'Required from every applicant.', 1);
SET @bel1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bel1s1, 'Valid Passport (3+ Months Beyond Intended Stay, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@bel1s1, 'Completed Schengen Visa Application Form', NULL, 'copy', 1, 0, 1, 2),
(@bel1s1, 'Travel/Schengen Medical Insurance (Min. €30,000 Coverage)', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bel1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @bel1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bel1s2, 'Confirmed Hotel Booking', NULL, 'copy', 1, 0, 0, 1),
(@bel1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2),
(@bel1s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3),
(@bel1s2, 'Cover Letter Explaining Travel Purpose', NULL, 'copy', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(110, 1, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'EUR 90 is the standard uniform Schengen short-stay fee; a separate VFS Global service charge (reported roughly INR 1,900-3,100, which rose 15-20% in November 2025) also applies and is paid in INR at the centre.', '2026-09-01', NOW(), 'https://visa.vfsglobal.com/ind/en/bel', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does a Belgium Tourist visa let me travel elsewhere in Europe?', 'Yes — the Schengen C-type visa is valid for travel across the entire Schengen area, not just Belgium, subject to the standard 90-days-in-180 rule.', 110, 1, 11000, 1),
('Which Indian cities have a VFS Global centre for Belgium visas?', 'VFS Global operates Belgium visa application centres in several major Indian cities including New Delhi, Mumbai, Bengaluru, Chennai, Hyderabad, and Kolkata; confirm your nearest centre and jurisdiction on the VFS Global Belgium-India portal before booking.', 110, 1, 11001, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    110, 2, 'BEL-BUS-IN-02', '2026.09', 'published',
    'Trade, negotiations, and commercial meetings in Belgium.',
    'Indian nationals travelling for business — the same Schengen C-type visa as Tourist, with a company invitation letter and Indian employer sponsorship letter as the differentiating documents.',
    'Single, double, or multiple entry, up to 90 days within any 180-day period',
    'Apply via VFS Global with a business invitation letter and Indian employer forwarding letter',
    1,
    'Standard Schengen processing is typically 12-20 working days',
    'Embassy of Belgium, New Delhi / Consulate General of Belgium, Mumbai, via VFS Global centres',
    'Obtain an invitation letter from the Belgian host company
Gather Indian employer sponsorship/forwarding letter
Complete the online Schengen visa application
Submit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/belgium.webp',
    'Cross-checked against VFS Global India secondary sourcing; official Belgian diplomatic page not directly fetchable this session', 'https://visa.vfsglobal.com/ind/en/bel', '2026-09-17'
);
SET @bel2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bel2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bel2, 'Core Documents', 'Required from every applicant.', 1);
SET @bel2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bel2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bel2s1, 'Invitation Letter from Belgian Host Company', NULL, 'original', 1, 0, 1, 2),
(@bel2s1, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bel2, 'Supporting Documents', 'Evidence of your own employment and financial responsibility.', 2);
SET @bel2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bel2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@bel2s2, 'Business Registration Proof', NULL, 'copy', 0, 1, 0, 2),
(@bel2s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(110, 2, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge payable in INR.', '2026-09-01', NOW(), 'https://visa.vfsglobal.com/ind/en/bel', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need an invitation letter from a Belgian company for a Business visa?', 'Yes — a genuine invitation letter from the Belgian host company detailing the purpose and duration of your visit is a core requirement, alongside a forwarding letter from your Indian employer.', 110, 2, 11010, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Type D Long-Stay Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    110, 3, 'BEL-STU-IN-03', '2026.09', 'published',
    'Full-time enrolment at a recognized Belgian university or institution.',
    'Indian nationals with an unconditional admission letter from a Belgian institution, requiring the Type D long-stay national visa; must register at the local commune within 8 working days of arrival for a residence permit.',
    'Initial visa tied to the academic year, renewed via the commune for the full programme duration',
    'Apply in person at the Embassy of Belgium, New Delhi, or Consulate General of Belgium, Mumbai (jurisdiction depends on home state) — not via VFS',
    1,
    'Reported 15-30 working days from a complete file; apply well ahead of September or February intakes',
    'Embassy of Belgium, New Delhi / Consulate General of Belgium, Mumbai',
    'Secure an unconditional admission letter from a recognized Belgian institution
Arrange proof of funds (min. EUR 730/month) and health insurance
Complete required pre-departure medical test
Book an embassy/consulate appointment (not VFS)
Submit in person with biometrics
Register at the local commune within 8 working days of arrival for the A-card residence permit',
    '/assets/images/visa-heroes/belgium.webp',
    'Cross-checked against Belgian institution/student-visa secondary sourcing and Immigration Office (IBZ) long-stay visa guidance; official India-specific embassy page not directly fetchable this session', 'https://india.diplomatie.belgium.be/en/travel-belgium/visa-belgium', '2026-09-17'
);
SET @bel3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bel3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bel3, 'Core Documents', 'Required from every applicant.', 1);
SET @bel3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bel3s1, 'Valid Passport (Min. 12 Months Validity on Arrival)', NULL, 'original', 1, 0, 1, 1),
(@bel3s1, 'Unconditional Admission Letter from Belgian Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bel3, 'Supporting Documents', 'Evidence of your academic background, funds, and health cover.', 2);
SET @bel3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bel3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@bel3s2, 'Proof of Funds (Min. EUR 730/Month)', NULL, 'copy', 1, 0, 0, 2),
(@bel3s2, 'Health/Travel Insurance Valid in Belgium', NULL, 'original', 1, 0, 0, 3),
(@bel3s2, 'Pre-Departure Medical Certificate', NULL, 'original', 1, 0, 0, 4),
(@bel3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 5);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(110, 3, 250.00, 'EUR', 'Visa D Handling Fee (Effective 1 July 2026)', 'The Belgian Visa D handling fee rose from EUR 180 to EUR 250 effective 1 July 2026 (confirmed via KPMG/EY 2026 alerts); applicants with appointments on or after that date owe the new EUR 250 rate, including any top-up if the old fee was already paid.', '2026-09-01', NOW(), 'https://kpmg.com/xx/en/our-insights/gms-flash-alert/2026/flash-alert-2026-198.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can international students work while studying in Belgium?', 'Student visa/residence permit holders are generally permitted to work part-time (commonly reported as up to 20 hours per week) alongside their studies, subject to the terms of their residence card — confirm current limits with your commune.', 110, 3, 11020, 1),
('Has the Belgium student visa fee changed recently?', 'Yes — the Visa D handling fee increased from EUR 180 to EUR 250 effective 1 July 2026, per Belgian government notices and international mobility advisories (KPMG, EY).', 110, 3, 11021, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Single Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    110, 4, 'BEL-WORK-IN-04', '2026.09', 'published',
    'Employment with a Belgian employer for stays over 90 days, via the combined Single Permit (work authorization + residence permit).',
    'Indian nationals with a confirmed job offer from a Belgian employer. Since 2019 the Single Permit merges the work permit and residence card into one file; since 2026 applications route through a shared federal one-stop online portal, but salary thresholds, shortage-occupation lists, and regional charges genuinely differ by Flanders, Wallonia, and Brussels.',
    'Default validity up to 3 years, tied to the employer and role, renewable',
    'Employer files via the federal Single Permit portal; applicant then applies for the Visa D at the Embassy/Consulate — not VFS',
    1,
    'Legal ceiling is 4 months (reported average ~14 weeks) for first authorization; timelines vary by region',
    'Embassy of Belgium, New Delhi / Consulate General of Belgium, Mumbai (visa); regional authority (Flanders/Wallonia/Brussels) decides the permit',
    'Secure a job offer from a Belgian employer
Employer files the Single Permit application via the federal one-stop portal, routed to the region of employment
Regional authority assesses (labour market test unless exempt; salary thresholds and shortage lists vary by region)
Once approved, apply for the Visa D at the Embassy/Consulate in India
Travel to Belgium and collect the physical Single Permit card; register at the local commune',
    '/assets/images/visa-heroes/belgium.webp',
    'Cross-checked against FPS Employment (regional work-permit addresses), Flanders/Brussels/Wallonia regional-authority secondary sourcing, and 2026 KPMG fee-change alerts; official India embassy page not directly fetchable this session', 'https://employment.belgium.be/en/themes/international/posting/concept-and-formalities/formalities/work-permits-adresses-regional', '2026-09-17'
);
SET @bel4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bel4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bel4, 'Core Documents', 'Required from every applicant.', 1);
SET @bel4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bel4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bel4s1, 'Employment Contract', NULL, 'copy', 1, 0, 1, 2),
(@bel4s1, 'Single Permit Approval from Regional Authority', 'Filed by the employer via the federal one-stop portal; the applicant needs the approval confirmation to apply for the Visa D.', 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bel4, 'Supporting Documents', 'Additional applicant-side evidence; requirements can vary slightly by region.', 2);
SET @bel4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bel4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@bel4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2),
(@bel4s2, 'Labour Market Test Evidence (If Applicable)', 'Not required for shortage occupations or exempt permit categories in some regions.', 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(110, 4, NULL, 'EUR', 'Confirmed After Assessment', 'No single confirmed applicant-facing figure this session: the Visa D component is EUR 250 (effective 1 July 2026), and Flanders separately introduced an additional EUR 180 regional Single Permit retribution alongside its January 2026 portal relaunch — total cost and who bears it (employer vs employee) varies by region and employer policy. Contact us to confirm for your specific region.', '2026-09-01', NOW(), 'https://kpmg.com/xx/en/our-insights/gms-flash-alert/2026/flash-alert-2026-198.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Flanders, Wallonia, and Brussels have the same work-permit rules?', 'No — this is a genuine, notable complexity. Each region sets its own EU Blue Card salary thresholds (reported around EUR 63,586 in Flanders, EUR 56,112 in Wallonia, and EUR 61,011 in Brussels), its own shortage-occupation exemptions from the labour market test, and its own portal/fee details, even though applications are now filed through one shared federal one-stop system.', 110, 4, 11030, 1),
('Did the Single Permit application process change in 2026?', 'Yes — since 2026 all Single Permit applications, regardless of region, are submitted through one shared federal online portal, and Flanders separately launched an upgraded regional Single-Permit portal in January 2026 with tighter criteria for some medium-skilled roles and an added regional fee.', 110, 4, 11031, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    110, 5, 'BEL-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives or friends resident in Belgium.',
    'Indian nationals with family/friends in Belgium — the same Schengen C-type visa as Tourist, requiring an invitation letter (an "annexe 3bis" certificate of accommodation is often used) plus proof of relationship.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with an invitation letter/certificate of accommodation and relationship proof',
    1,
    'Standard Schengen processing is typically 12-20 working days',
    'Embassy of Belgium, New Delhi / Consulate General of Belgium, Mumbai, via VFS Global centres',
    'Obtain an invitation letter or certificate of accommodation from your host in Belgium (commune-certified "annexe 3bis" strengthens the application)
Gather documents proving the family relationship
Complete the online Schengen visa application
Submit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/belgium.webp',
    'Cross-checked against VFS Global India secondary sourcing; official Belgian diplomatic page not directly fetchable this session', 'https://visa.vfsglobal.com/ind/en/bel', '2026-09-17'
);
SET @bel5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bel5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bel5, 'Core Documents', 'Required from every applicant.', 1);
SET @bel5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bel5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bel5s1, 'Invitation Letter/Certificate of Accommodation from Host', NULL, 'original', 1, 0, 1, 2),
(@bel5s1, 'Proof of Relationship', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bel5, 'Supporting Documents', 'Evidence of your own means.', 2);
SET @bel5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bel5s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 1),
(@bel5s2, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(110, 5, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge payable in INR.', '2026-09-01', NOW(), 'https://visa.vfsglobal.com/ind/en/bel', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What strengthens a Belgium Family Visit invitation letter?', 'A certificate of accommodation registered with the host''s local commune (commonly referenced as ''annexe 3bis'') can strengthen the application, though a straightforward invitation letter with relationship proof may also be accepted — confirm current practice with VFS Global before applying.', 110, 5, 11040, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Type A Airport Transit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    110, 6, 'BEL-TRAN-IN-06', '2026.09', 'published',
    'Passing through a Belgian airport (e.g. Brussels) airside-to-airside toward a non-Schengen destination.',
    'A distinct Type A Airport Transit Visa, separate from the Type C short-stay visa. Indian nationals are generally NOT on the EU Annex I list of nationalities required to hold this visa (that list names countries such as Afghanistan, Bangladesh, and DRC) — most Indian travellers can transit airside without one, provided they hold a valid visa for the final destination if required.',
    'Only for the transit window; not required for Indian nationals in most cases if remaining airside',
    'Generally not required for Indian passport holders remaining airside; if genuinely needed for a specific itinerary, apply via VFS Global',
    1,
    'If required, standard Schengen-adjacent processing reported around 12-20 working days',
    'Embassy of Belgium, New Delhi / Consulate General of Belgium, Mumbai, via VFS Global centres',
    'Check your connection: Indian nationals are generally exempt from Belgium''s Type A transit visa requirement
Confirm you hold a valid visa/travel authorization for your final destination, if required
If a specific circumstance genuinely requires a Type A visa, apply via VFS Global with your itinerary and onward ticket',
    '/assets/images/visa-heroes/belgium.webp',
    'Cross-checked against Belgium''s Immigration Office (IBZ) Type A visa guidance (EU Regulation 2018/1806, Annex I nationality list); official India-specific page not directly fetchable this session', 'https://dofi.ibz.be/en/themes/entry/border-control/visa/visa-type-airport-transit-visa', '2026-09-17'
);
SET @bel6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bel6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bel6, 'Core Documents', 'Only relevant if a Type A visa genuinely applies to your circumstance.', 1);
SET @bel6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bel6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bel6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bel6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @bel6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bel6s2, 'Visa/Travel Authorization for Final Destination (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(110, 6, NULL, 'EUR', 'Not Applicable for Most Indian Travellers', 'Indian nationals are generally not on the EU Annex I list requiring a Belgium airport transit visa; no independently confirmed fee figure exists for the rare cases where one is required — contact us to confirm your specific itinerary.', '2026-09-01', NOW(), 'https://dofi.ibz.be/en/themes/entry/border-control/visa/visa-type-airport-transit-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian passport holders need a transit visa to change planes in Brussels?', 'Generally no — India is not among the nationalities listed in EU Regulation 2018/1806 Annex I that require a Belgium/Schengen airport transit visa, so most Indian travellers can connect airside without one. Always verify against your specific routing and any recent list changes before travel.', 110, 6, 11050, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    110, 7, 'BEL-MED-IN-07', '2026.09', 'published',
    'Travel to Belgium for medical treatment.',
    'Indian nationals travelling for treatment — the same Schengen C-type visa as Tourist, requiring a certificate from the treating Belgian doctor/hospital confirming the need for specific treatment.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with the medical certificate and Schengen-compliant insurance',
    1,
    'Standard Schengen processing is typically 12-20 working days, can extend if documentation is incomplete',
    'Embassy of Belgium, New Delhi / Consulate General of Belgium, Mumbai, via VFS Global centres',
    'Obtain a certificate from the treating Belgian doctor/hospital
Arrange Schengen-compliant travel insurance (min. EUR 30,000 cover)
Complete the online Schengen visa application
Submit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/belgium.webp',
    'Cross-checked against VFS Global India secondary sourcing; official Belgian diplomatic page not directly fetchable this session', 'https://visa.vfsglobal.com/ind/en/bel', '2026-09-17'
);
SET @bel7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bel7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bel7, 'Core Documents', 'Required from every applicant.', 1);
SET @bel7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bel7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bel7s1, 'Medical Certificate/Hospital Confirmation', NULL, 'original', 1, 0, 1, 2),
(@bel7s1, 'Travel/Schengen Medical Insurance', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bel7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @bel7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bel7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@bel7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2),
(@bel7s2, 'Attendant''s Documents (If Travelling With a Companion)', NULL, 'copy', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(110, 7, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist, plus a separate VFS Global service charge payable in INR.', '2026-09-01', NOW(), 'https://visa.vfsglobal.com/ind/en/bel', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does a Belgium Medical visa cover a travelling companion/attendant?', 'A companion generally needs their own visa application (often filed as a linked Medical or Family Visit application) with their own supporting documents — check current VFS Global guidance for joint filings.', 110, 7, 11060, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    110, 8, 'BEL-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, congresses, and trade fairs in Belgium (notably Brussels, home to many EU/international institutions).',
    'Indian nationals attending a conference — the same Schengen C-type visa as Business, requiring a conference invitation/registration confirmation from the organizer.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with a conference invitation/registration confirmation',
    1,
    'Standard Schengen processing is typically 12-20 working days',
    'Embassy of Belgium, New Delhi / Consulate General of Belgium, Mumbai, via VFS Global centres',
    'Obtain a conference invitation or registration confirmation
Gather proof of accommodation and return travel
Complete the online Schengen visa application
Submit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/belgium.webp',
    'Cross-checked against VFS Global India secondary sourcing; official Belgian diplomatic page not directly fetchable this session', 'https://visa.vfsglobal.com/ind/en/bel', '2026-09-17'
);
SET @bel8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bel8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bel8, 'Core Documents', 'Required from every applicant.', 1);
SET @bel8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bel8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bel8s1, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bel8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @bel8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bel8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@bel8s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(110, 8, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist/Business, plus a separate VFS Global service charge payable in INR.', '2026-09-01', NOW(), 'https://visa.vfsglobal.com/ind/en/bel', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a Conference visa different from a Business visa in Belgium?', 'Both use the same Schengen C-type visa category; the key difference is documentary — a Conference visa centres on the event invitation/registration confirmation rather than a business-meeting invitation letter.', 110, 8, 11070, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Schengen C-Type
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    110, 9, 'BEL-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in Belgium.',
    'Indian nationals competing or officiating — the same Schengen C-type visa as Tourist/Conference, typically requiring a letter from the home sports association and an invitation from the host event organizer.',
    'Up to 90 days within any 180-day period',
    'Apply via VFS Global with a sports-association letter and host-organizer invitation',
    1,
    'Standard Schengen processing is typically 12-20 working days',
    'Embassy of Belgium, New Delhi / Consulate General of Belgium, Mumbai, via VFS Global centres',
    'Obtain a letter from your home-country sports association confirming your role
Obtain an invitation letter from the host event organizer with event details
Complete the online Schengen visa application
Submit documents and biometrics at VFS Global',
    '/assets/images/visa-heroes/belgium.webp',
    'Cross-checked against general Schengen sports-visa documentary practice and VFS Global India secondary sourcing; not independently confirmed against a Belgium-specific sports-visa page this session', 'https://visa.vfsglobal.com/ind/en/bel', '2026-09-17'
);
SET @bel9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bel9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bel9, 'Core Documents', 'Required from every applicant.', 1);
SET @bel9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bel9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bel9s1, 'Home-Country Sports Association Letter', NULL, 'original', 1, 0, 1, 2),
(@bel9s1, 'Host Event Organizer Invitation Letter', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bel9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @bel9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bel9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1),
(@bel9s2, 'Bank Statement (Last 6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(110, 9, 90.00, 'EUR', 'Schengen C-Type Visa Fee', 'Same fee structure as Tourist/Conference, plus a separate VFS Global service charge payable in INR.', '2026-09-01', NOW(), 'https://visa.vfsglobal.com/ind/en/bel', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do team delegations apply individually for a Belgium Sports visa?', 'Each athlete/official typically submits an individual application with the standard biometric appointment, though a team/delegation list supporting the group booking is commonly requested by the organizer or VFS Global.', 110, 9, 11080, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Family Reunification (Visa D)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    110, 10, 'BEL-DEP-IN-10', '2026.09', 'published',
    'Spouse/partner and minor or dependent children joining an Indian national who holds a qualifying Belgian residence status (Single Permit, EU Blue Card, or long-term residence permit).',
    'Family members of an Indian sponsor with a valid Single Permit, EU Blue Card, or long-term residence permit. Eligible relatives: spouse/registered partner and unmarried children under 18 (or adult children dependent due to disability). Processing can run up to around 9 months.',
    'Tied to the sponsor''s permit validity',
    'Apply in person at the Embassy of Belgium, New Delhi, or Consulate General of Belgium, Mumbai — the Visa D long-stay route, not VFS',
    1,
    'Reported as taking up to approximately 9 months for a complete family-reunification file — notably longer than short-stay Schengen processing',
    'Embassy of Belgium, New Delhi / Consulate General of Belgium, Mumbai',
    'Confirm the sponsor holds a qualifying status (Single Permit/EU Blue Card/long-term residence permit)
Gather relationship proof (marriage/birth certificates) and the sponsor''s permit copy
Gather proof of the sponsor''s stable income and adequate accommodation in Belgium
Book an embassy/consulate appointment (not VFS)
Submit in person and allow for the extended processing window
Register at the local commune in Belgium on arrival',
    '/assets/images/visa-heroes/belgium.webp',
    'Cross-checked against Belgium''s Immigration Office (IBZ) family-reunification Visa D guidance and 2026 KPMG fee-change alerts; official India-specific embassy page not directly fetchable this session', 'https://dofi.ibz.be/en/themes/third-country-nationals/family-reunification/visa-d-application-family-reunification', '2026-09-17'
);
SET @bel10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@bel10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bel10, 'Core Documents', 'Required from every applicant.', 1);
SET @bel10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bel10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@bel10s1, 'Proof of Relationship to Sponsor (Marriage/Birth Certificate)', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@bel10, 'Supporting Documents', 'Evidence tied to the sponsor''s status and household in Belgium.', 2);
SET @bel10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@bel10s2, 'Sponsor''s Single Permit/EU Blue Card/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@bel10s2, 'Proof of Sponsor''s Stable, Regular Income', NULL, 'copy', 1, 0, 0, 2),
(@bel10s2, 'Proof of Adequate Accommodation (Lease/Property Title)', NULL, 'copy', 1, 0, 0, 3),
(@bel10s2, 'Health Insurance Covering the Joining Family Member', NULL, 'original', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(110, 10, 250.00, 'EUR', 'Visa D Handling Fee (Effective 1 July 2026)', 'The Belgian Visa D handling fee for family reunification rose from EUR 180 to EUR 250 effective 1 July 2026, alongside a separate administrative contribution ("redevance") payable to the Immigration Office where applicable and the VFS/consular service charge.', '2026-09-01', NOW(), 'https://kpmg.com/xx/en/our-insights/gms-flash-alert/2026/flash-alert-2026-198.html', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How long does Belgian family reunification processing usually take?', 'It can take up to approximately 9 months for a complete file, notably longer than the short-stay Schengen visas — plan well ahead if you intend to bring a spouse or children to join you in Belgium.', 110, 10, 11090, 1),
('Which of my family members can join me in Belgium?', 'Your spouse or registered partner and unmarried children under 18 generally qualify, and adult children who are dependent due to a physical or mental disability may also be eligible — confirm your specific case against current Immigration Office (IBZ) rules.', 110, 10, 11091, 1);

