-- Zambia Visa Checklist Engine content for all 10 visa types —
-- built fresh this session via web search. hero_image_url left NULL at
-- authoring time (no photo bundle supplied yet for this batch).
--
-- IMPORTANT SOURCING CAVEAT: the official zambiaimmigration.gov.zm,
-- zambiatourism.com, evisa/ZamServices (eservices.gov.zm) and
-- hcizambia.gov.in domains were NOT directly fetchable this session
-- (egress-proxy blocked on every attempted fetch) — all findings below
-- were triangulated from web-search-indexed snippets of those same
-- official domains plus secondary visa-agency sourcing (iVisa, Teleport,
-- VisasNews, Travel Saga, JSDBiz, Akbar Travels, Rivermate, G-P,
-- Playroll). Fee and processing-time figures vary across secondary
-- sources and are flagged as approximate where triangulation disagreed.
-- The WebSearch tool budget was exhausted mid-session, so a small number
-- of category-specific facts (Conference/Sports/Medical visa document
-- specifics, exact business-visa invitation-letter wording) could not be
-- independently deep-searched and are marked "NOT independently
-- confirmed this session" below — those categories are still filled in
-- with best-effort structure built from the confirmed general visa
-- framework (Zambia does not appear to run Schengen-style category
-- fragmentation; Ordinary/Business/Conference/Sports purposes share one
-- visa instrument differentiated mainly by supporting documents).
--
-- Zambia's real, distinctive, dated facts verified this session:
--   - Zambia raised its visa fees economy-wide effective 1 January 2026:
--     single-entry visa USD 25 -> USD 50, double-entry USD 40 -> USD 80,
--     multiple-entry USD 75 -> USD 80, transit visa USD 50, day-tripper
--     visa unchanged at USD 10, and the KAZA UniVisa held flat at
--     USD 50 (source: zambiatourism.com "Updated Visa Fees for 2026",
--     cross-checked against VisasNews reporting).
--   - Indian passport holders are NOT eligible for visa-on-arrival at
--     Zambian ports of entry — an e-Visa or mission-issued visa must be
--     secured before departure, confirmed consistently across multiple
--     2025-2026 secondary sources.
--   - The KAZA UniVisa (USD 50) is a genuine two-country instrument
--     covering both Zambia and Zimbabwe on one multi-entry visa,
--     including day-trip access to Botswana via the Kazungula border —
--     directly relevant to Victoria Falls itineraries that straddle the
--     Zambia/Zimbabwe side of the falls.
--   - Zambia has moved several immigration services fully online via the
--     government's ZamServices portal (eservices.gov.zm / zamportal.gov.zm)
--     — Employment Permits and Study Permits are described as "fully
--     electronic" end-to-end, including online payment and digital
--     permit-card issuance, a genuinely distinctive digitised-government
--     detail versus many peer African immigration systems.
--   - Dependants of Employment Permit holders are issued individual
--     "Dependants Permits" as Digital Permit Cards; a dependent spouse
--     may reside but generally may NOT work in Zambia unless they
--     separately qualify for their own Employment Permit in their own
--     right — dependant status alone does not carry work rights.
--   - Zambia's Employment Permit (long-term, >6 months) carries a
--     statutory private-sector fee reported at ZMW 24,000 and is
--     extendable up to a maximum of 10 years; a separate Temporary
--     Employment Permit covers business visitors staying beyond 30 days,
--     and a Short-Term Work Permit covers up to 3 months (renewable once,
--     for a 6-month ceiling).
--   - India has a genuinely large, longstanding resident community in
--     Zambia: roughly 25,000-30,000 Persons of Indian Origin/OCIs (per
--     the High Commission of India, Lusaka fact sheet, search-indexed),
--     concentrated in trade, pharmaceuticals, copper-adjacent industry,
--     and agriculture, with roots mostly in Gujarat — relevant context
--     for Business and Work visa applicants following established trade
--     and family links.
--   - Zambia's High Commission in India is at 7 Poorvi Marg, Vasant
--     Vihar, New Delhi, with additional honorary consular presence
--     reported in Chennai and Kolkata — a wider in-India footprint than
--     several peer missions that route everything through Delhi alone.
--   - A land-transit visa (max 7 days validity) is reported at USD 50;
--     travellers who stay airside at Kenneth Kaunda International
--     Airport, Lusaka, without clearing immigration reportedly do not
--     require a transit visa at all.
--
-- country_id 53 = Zambia. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — e-Visa / KAZA UniVisa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    53, 1, 'ZMB-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Zambia, including Victoria Falls, South Luangwa and Lower Zambezi safaris.',
    'Indian passport holders are not eligible for visa-on-arrival, so a Zambia e-Visa (or KAZA UniVisa for Zambia/Zimbabwe/Botswana Victoria Falls itineraries) must be obtained online before departure.',
    'Single entry up to 90 days; KAZA UniVisa is multiple-entry within its validity window for Zambia/Zimbabwe travel',
    'Apply online via the Zambia e-Visa/ZamServices portal; choose the KAZA UniVisa option if also visiting Victoria Falls from the Zimbabwe side',
    0,
    'Reported 3-5 working days standard, with faster paid options (reportedly as fast as 1 business day) mentioned by some agencies pending confirmation',
    'Zambia Department of Immigration (online e-Visa/ZamServices decision) — no in-person appearance required for the e-Visa itself',
    'Create an account on the Zambia e-Visa/ZamServices portal\nChoose Single-Entry, Double-Entry, or KAZA UniVisa depending on itinerary\nUpload passport bio page, photo, and itinerary/accommodation proof\nPay the visa fee online\nPrint the e-Visa approval and carry it alongside your passport on arrival',
    '/assets/images/visa-heroes/zambia.webp',
    'Cross-checked against zambiatourism.com fee-update reporting and multiple visa-agency secondary sources (iVisa, Teleport, Travel Saga, VisasNews), triangulated against official domains not directly fetchable this session', 'https://www.zambiatourism.com/updated-visa-fees-for-2026/', '2026-09-17'
);
SET @zmb1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@zmb1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@zmb1, 'Core Documents', 'Required from every applicant.', 1);
SET @zmb1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@zmb1s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'original', 1, 0, 1, 1),
(@zmb1s1, 'Recent Passport-Size Photograph', NULL, 'copy', 1, 0, 1, 2),
(@zmb1s1, 'Completed Online e-Visa/KAZA UniVisa Application', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@zmb1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @zmb1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@zmb1s2, 'Confirmed Accommodation Booking', NULL, 'copy', 1, 0, 0, 1),
(@zmb1s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2),
(@zmb1s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 3),
(@zmb1s2, 'Yellow Fever Vaccination Certificate', 'Required if arriving from, or having transited through, a yellow-fever-endemic country.', 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(53, 1, 50.00, 'USD', 'Single-Entry e-Visa Fee (Effective 1 Jan 2026)', 'Raised from USD 25 to USD 50 effective 1 January 2026; the KAZA UniVisa remained flat at USD 50 and a double-entry visa is now USD 80. Confirm the current tier on the official portal before paying.', '2026-01-01', NOW(), 'https://www.zambiatourism.com/updated-visa-fees-for-2026/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I get a Zambia visa on arrival as an Indian citizen?', 'No — Indian passport holders are not eligible for visa-on-arrival at Zambian ports of entry. You must obtain an e-Visa (or KAZA UniVisa) online before you travel.', 53, 1, 5300, 1),
('Should I get the KAZA UniVisa instead of a standard e-Visa?', 'If your itinerary includes Victoria Falls from both the Zambian and Zimbabwean sides, or a day trip into Botswana via Kazungula, the KAZA UniVisa (USD 50, multiple-entry) is generally more convenient than a standard single-entry e-Visa.', 53, 1, 5301, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — e-Visa with Invitation Letter
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    53, 2, 'ZMB-BUS-IN-02', '2026.09', 'published',
    'Trade meetings, negotiations, factory/mine visits, and commercial activity in Zambia.',
    'Indian nationals travelling for business — the same e-Visa instrument as Tourist, differentiated by a Zambian host-company invitation letter; India''s longstanding trade-linked community in Zambia means many applicants already have an established local contact or employer.',
    'Single or double entry, typically up to 90 days per visit',
    'Apply online via the Zambia e-Visa portal with a business invitation letter; a Temporary Employment Permit applies for stays beyond 30 days',
    0,
    'Reported 3-5 working days standard for the e-Visa component',
    'Zambia Department of Immigration (online e-Visa decision); High Commission of Zambia, New Delhi for mission-route applications',
    'Obtain an invitation letter from the Zambian host company\nGather your Indian employer''s forwarding/sponsorship letter\nComplete the online e-Visa application, selecting Business purpose\nUpload documents and pay the fee online\nIf staying beyond 30 days, apply separately for a Temporary Employment Permit via ZamServices',
    '/assets/images/visa-heroes/zambia.webp',
    'Cross-checked against Zambia Department of Immigration permit-type reporting (ZamServices/ZamPortal) and secondary business-visa sourcing, triangulated against official domains not directly fetchable this session', 'https://zamportal.gov.zm/service-category/for-employees/', '2026-09-17'
);
SET @zmb2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@zmb2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@zmb2, 'Core Documents', 'Required from every applicant.', 1);
SET @zmb2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@zmb2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@zmb2s1, 'Invitation Letter from Zambian Host Company', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@zmb2, 'Supporting Documents', 'Evidence of your own employment and financial responsibility.', 2);
SET @zmb2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@zmb2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@zmb2s2, 'Business Registration/Company Profile Proof', NULL, 'copy', 0, 1, 0, 2),
(@zmb2s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(53, 2, 50.00, 'USD', 'Single-Entry e-Visa Fee (Effective 1 Jan 2026)', 'Same fee tier as Tourist for the e-Visa itself; if the stay converts to a Temporary Employment Permit (beyond 30 days), a separate permit fee applies and should be confirmed on ZamServices.', '2026-01-01', NOW(), 'https://www.zambiatourism.com/updated-visa-fees-for-2026/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a work permit for a short Zambia business trip?', 'Not for a standard business visit — the e-Visa with an invitation letter covers typical trade/meeting trips. If your business stay exceeds 30 days, a Temporary Employment Permit is reported as the applicable route instead.', 53, 2, 5310, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Study Permit (ZamServices)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    53, 3, 'ZMB-STU-IN-03', '2026.09', 'published',
    'Full-time or part-time enrollment at a recognized Zambian educational institution.',
    'Indian nationals admitted to a Zambian institution apply for a Study Permit, which the Zambia Department of Immigration describes as a fully electronic ZamServices process from application through to digital permit issuance.',
    'Tied to course/programme duration, renewable through ZamServices',
    'Apply online via the ZamServices portal (eservices.gov.zm) for the Study Permit; entry visa arranged separately if required for travel to Zambia',
    0,
    'Not independently confirmed this session — secondary sourcing describes the process as "fully electronic" but did not surface a specific working-day figure',
    'Zambia Department of Immigration, via the ZamServices online portal',
    'Secure admission at a recognized Zambian institution\nGather academic transcripts and proof of funds\nApply for the Study Permit online via ZamServices\nUpload documents and pay the applicable fee online\nCollect the digital permit and arrange entry-visa/travel formalities',
    '/assets/images/visa-heroes/zambia.webp',
    'Cross-checked against zamportal.gov.zm "For Students" service-category listing describing the Study Permit as a fully electronic ZamServices product, triangulated against official domains not directly fetchable this session', 'https://zamportal.gov.zm/service-category/for-students/', '2026-09-17'
);
SET @zmb3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@zmb3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@zmb3, 'Core Documents', 'Required from every applicant.', 1);
SET @zmb3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@zmb3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@zmb3s1, 'Unconditional Admission Letter from Zambian Institution', NULL, 'original', 1, 0, 1, 2),
(@zmb3s1, 'Proof of Tuition Payment/Fee Receipt', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@zmb3, 'Supporting Documents', 'Evidence of your academic background and funds.', 2);
SET @zmb3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@zmb3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@zmb3s2, 'Proof of Funds/Sponsor Bank Statement', NULL, 'copy', 1, 0, 0, 2),
(@zmb3s2, 'Passport-Size Photographs', NULL, 'copy', 1, 0, 0, 3),
(@zmb3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(53, 3, NULL, 'ZMW', 'Confirmed After Assessment', 'Study Permit fee was not independently confirmed this session; apply via ZamServices (eservices.gov.zm) to see the current online fee schedule before paying.', '2026-09-01', NOW(), 'https://zamportal.gov.zm/service-category/for-students/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is the Zambia Study Permit fully online for Indian applicants?', 'Zambia''s Department of Immigration describes the Study Permit as a fully electronic ZamServices product — application, document upload, payment, and permit issuance are all designed to run through the eservices.gov.zm portal.', 53, 3, 5320, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Employment Permit (ZamServices)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    53, 4, 'ZMB-WORK-IN-04', '2026.09', 'published',
    'Employment with a Zambian employer for a period exceeding six months, via the Employment Permit.',
    'Indian nationals with a confirmed Zambian job offer apply for the Employment Permit, a fully electronic ZamServices product; a private-sector statutory fee of ZMW 24,000 is reported, with permits extendable up to a maximum of 10 years. Shorter engagements (up to 3 months, renewable once) use the Short-Term Work Permit instead.',
    'Long-term Employment Permit extendable up to a maximum of 10 years; Short-Term Work Permit capped at 6 months (initial 3 months plus one renewal)',
    'Employer-driven; apply online via ZamServices (eservices.gov.zm) — designed as a fully electronic application, upload, and payment process',
    0,
    'Not independently confirmed this session for a specific working-day figure; the process is described as fully electronic end-to-end',
    'Zambia Department of Immigration, via ZamServices online portal',
    'Secure a job offer/contract from a Zambian employer\nEmployer initiates the Employment Permit application on ZamServices\nUpload qualifications, police clearance, and passport documents\nPay the statutory fee online (reported ZMW 24,000 for private-sector long-term permits)\nReceive the digital Employment Permit card and travel',
    '/assets/images/visa-heroes/zambia.webp',
    'Cross-checked against Rivermate/G-P/Playroll work-permit guides and the Zambia Department of Immigration "Permit Types" listing (search-indexed), triangulated against official domains not directly fetchable this session', 'https://www.zambiaimmigration.gov.zm/permit-types/', '2026-09-17'
);
SET @zmb4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@zmb4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@zmb4, 'Core Documents', 'Required from every applicant.', 1);
SET @zmb4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@zmb4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@zmb4s1, 'Employment Contract/Job Offer', NULL, 'copy', 1, 0, 1, 2),
(@zmb4s1, 'Employer''s Company Registration Documents', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@zmb4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @zmb4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@zmb4s2, 'Academic/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@zmb4s2, 'Police Clearance Certificate (India)', NULL, 'original', 1, 0, 0, 2),
(@zmb4s2, 'Medical Fitness Certificate', NULL, 'original', 0, 1, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(53, 4, 24000.00, 'ZMW', 'Employment Permit Statutory Fee (Private Sector, Approximate)', 'Reported figure for the long-term Employment Permit (stays exceeding 6 months); Short-Term Work Permits (up to 3 months, one renewal) and Temporary Employment Permits for business visitors carry separate fee schedules — confirm the current figure on ZamServices.', '2026-09-01', NOW(), 'https://www.zambiaimmigration.gov.zm/permit-types/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How long can a Zambia Employment Permit be renewed for?', 'The long-term Employment Permit is reported as extendable up to a maximum of 10 years, subject to continued employer sponsorship and permit renewal through ZamServices.', 53, 4, 5330, 1),
('Can my family come with me on a Zambia work permit?', 'Yes — an Employment Permit is reported to allow the holder''s spouse and dependants to join, issued their own Dependants Permit, though a dependent spouse generally cannot work unless they separately qualify for their own Employment Permit.', 53, 4, 5331, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    53, 5, 'ZMB-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives resident in Zambia, including members of Zambia''s established Indian-origin community.',
    'Indian nationals with family in Zambia (Zambia''s resident Indian-origin community is reported at roughly 25,000-30,000 people) use the same e-Visa instrument as Tourist, with a host invitation letter and relationship proof as the differentiating documents.',
    'Single or double entry, typically up to 90 days per visit',
    'Apply online via the Zambia e-Visa/ZamServices portal with a host invitation letter attached',
    0,
    'Reported 3-5 working days standard for the e-Visa component',
    'Zambia Department of Immigration (online e-Visa decision)',
    'Obtain an invitation letter from your host/relative in Zambia\nGather documents proving the family relationship\nComplete the online e-Visa application, selecting the appropriate purpose\nUpload documents and pay the fee online',
    '/assets/images/visa-heroes/zambia.webp',
    'Cross-checked against Zambia e-Visa secondary sourcing and High Commission of India, Lusaka community fact-sheet reporting, triangulated against official domains not directly fetchable this session', 'https://www.hcizambia.gov.in/page/fact-sheet-on-zambia/', '2026-09-17'
);
SET @zmb5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@zmb5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@zmb5, 'Core Documents', 'Required from every applicant.', 1);
SET @zmb5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@zmb5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@zmb5s1, 'Invitation Letter from Host in Zambia', NULL, 'original', 1, 0, 1, 2),
(@zmb5s1, 'Proof of Relationship', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@zmb5, 'Supporting Documents', 'Evidence of your own means.', 2);
SET @zmb5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@zmb5s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 1),
(@zmb5s2, 'Return/Onward Flight Ticket', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(53, 5, 50.00, 'USD', 'Single-Entry e-Visa Fee (Effective 1 Jan 2026)', 'Same e-Visa fee tier as Tourist; a double-entry visa is USD 80 if multiple visits are planned within validity.', '2026-01-01', NOW(), 'https://www.zambiatourism.com/updated-visa-fees-for-2026/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Family Visit visa category in Zambia?', 'Zambia does not appear to run a distinct Family Visit visa product — applicants use the standard e-Visa, with a host invitation letter and relationship proof supporting the family-visit purpose.', 53, 5, 5340, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Transit Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    53, 6, 'ZMB-TRAN-IN-06', '2026.09', 'published',
    'Passing through Zambia, typically via Kenneth Kaunda International Airport, Lusaka, or by land, en route to a third country.',
    'A distinct Transit Visa, valid up to 7 days, needed only by travellers who clear Zambian immigration; passengers who remain airside at the airport without clearing immigration are reported to not require this visa at all.',
    'Maximum 7 days validity per transit',
    'Apply online via the Zambia e-Visa/ZamServices portal, or on arrival for land-border transit, if you will clear immigration',
    0,
    'Not independently confirmed this session for a specific working-day figure; land-border transit visas are reported as obtainable at the port of entry',
    'Zambia Department of Immigration (online e-Visa or port-of-entry, transit only)',
    'Confirm whether your specific connection requires clearing immigration (airside-only transfers reportedly do not)\nIf required, apply online for the transit visa or obtain it at the land border\nCarry your onward ticket and visa (if required) for the destination country',
    '/assets/images/visa-heroes/zambia.webp',
    'Cross-checked against Zambia Department of Immigration transit-visa secondary sourcing and Lusaka airport visitor-information pages, triangulated against official domains not directly fetchable this session', 'https://www.zambiaimmigration.gov.zm/for-visitors/', '2026-09-17'
);
SET @zmb6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@zmb6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@zmb6, 'Core Documents', 'Required if a transit visa is genuinely needed.', 1);
SET @zmb6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@zmb6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@zmb6s1, 'Onward Flight Ticket/Travel Itinerary', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@zmb6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @zmb6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@zmb6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(53, 6, 50.00, 'USD', 'Transit Visa Fee (Land Transit, up to 7 Days)', 'Reported figure for land-based transit; travellers who remain airside at the airport without clearing immigration reportedly do not need this visa at all.', '2026-01-01', NOW(), 'https://www.zambiaimmigration.gov.zm/for-visitors/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a transit visa if I never leave Lusaka airport?', 'Reportedly no — travellers transiting through Kenneth Kaunda International Airport who remain within the airport precincts and do not clear Zambian immigration are not required to appear before an immigration officer or hold a transit visa.', 53, 6, 5350, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    53, 7, 'ZMB-MED-IN-07', '2026.09', 'published',
    'Travel to Zambia for medical treatment.',
    'Indian nationals travelling for treatment use the same e-Visa instrument as Tourist, supported by a letter from the treating Zambian hospital/doctor confirming the need for specific treatment.',
    'Single or double entry, typically up to 90 days',
    'Apply online via the Zambia e-Visa/ZamServices portal with a medical facility letter attached',
    0,
    'Reported 3-5 working days standard for the e-Visa component; NOT independently confirmed this session whether medical applications receive expedited handling',
    'Zambia Department of Immigration (online e-Visa decision)',
    'Obtain a letter from the treating Zambian hospital/doctor confirming the need for treatment\nArrange travel/medical insurance\nComplete the online e-Visa application, selecting the appropriate purpose\nUpload documents and pay the fee online',
    '/assets/images/visa-heroes/zambia.webp',
    'Cross-checked against the general Zambia e-Visa framework confirmed this session; medical-visa-specific processing details NOT independently confirmed this session', 'https://www.zambiatourism.com/updated-visa-fees-for-2026/', '2026-09-17'
);
SET @zmb7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@zmb7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@zmb7, 'Core Documents', 'Required from every applicant.', 1);
SET @zmb7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@zmb7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@zmb7s1, 'Letter from Treating Zambian Hospital/Doctor', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@zmb7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @zmb7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@zmb7s2, 'Medical Records/Referral from India', NULL, 'copy', 1, 0, 0, 1),
(@zmb7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(53, 7, 50.00, 'USD', 'Single-Entry e-Visa Fee (Effective 1 Jan 2026)', 'Same fee tier as Tourist; Zambia does not appear to run a separately priced medical-visa category, based on this session''s research.', '2026-01-01', NOW(), 'https://www.zambiatourism.com/updated-visa-fees-for-2026/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Medical visa fee for Zambia?', 'This was not independently confirmed this session — the available evidence points to the standard e-Visa fee tier applying, with a hospital/doctor letter as the differentiating document. Confirm directly with the Zambia e-Visa portal before applying.', 53, 7, 5360, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    53, 8, 'ZMB-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, trade fairs, and official meetings in Zambia.',
    'Indian nationals attending a conference use the same e-Visa instrument as Tourist/Business, supported by a conference invitation or registration confirmation.',
    'Single or double entry, typically up to 90 days',
    'Apply online via the Zambia e-Visa/ZamServices portal with a conference invitation/registration confirmation attached',
    0,
    'Reported 3-5 working days standard for the e-Visa component',
    'Zambia Department of Immigration (online e-Visa decision)',
    'Obtain a conference invitation or registration confirmation\nGather proof of accommodation and return travel\nComplete the online e-Visa application, selecting the appropriate purpose\nUpload documents and pay the fee online',
    '/assets/images/visa-heroes/zambia.webp',
    'Cross-checked against the general Zambia e-Visa framework confirmed this session; Conference-visa-specific document nuances NOT independently confirmed this session', 'https://www.zambiatourism.com/updated-visa-fees-for-2026/', '2026-09-17'
);
SET @zmb8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@zmb8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@zmb8, 'Core Documents', 'Required from every applicant.', 1);
SET @zmb8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@zmb8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@zmb8s1, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@zmb8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @zmb8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@zmb8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@zmb8s2, 'Bank Statement (Last 3-6 Months)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(53, 8, 50.00, 'USD', 'Single-Entry e-Visa Fee (Effective 1 Jan 2026)', 'Same fee tier as Tourist; Zambia does not appear to run a separately priced Conference-visa category, based on this session''s research.', '2026-01-01', NOW(), 'https://www.zambiatourism.com/updated-visa-fees-for-2026/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Conference and Business visas share the same application route in Zambia?', 'Yes — both route through the standard e-Visa, differentiated mainly by the invitation letter attached (conference invitation vs. business host invitation), rather than separate visa products.', 53, 8, 5370, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — e-Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    53, 9, 'ZMB-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in Zambia.',
    'Indian nationals competing or officiating use the same e-Visa instrument as Tourist/Conference, supported by a letter from the host event organizer confirming participation.',
    'Single or double entry, typically up to 90 days',
    'Apply online via the Zambia e-Visa/ZamServices portal with a host event organizer invitation attached',
    0,
    'Reported 3-5 working days standard for the e-Visa component',
    'Zambia Department of Immigration (online e-Visa decision)',
    'Obtain an invitation letter from the host event organizer with event details\nGather a letter from your home sports association confirming your role\nComplete the online e-Visa application, selecting the appropriate purpose\nUpload documents and pay the fee online',
    '/assets/images/visa-heroes/zambia.webp',
    'Cross-checked against the general Zambia e-Visa framework confirmed this session; Sports-visa-specific document nuances NOT independently confirmed this session', 'https://www.zambiatourism.com/updated-visa-fees-for-2026/', '2026-09-17'
);
SET @zmb9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@zmb9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@zmb9, 'Core Documents', 'Required from every applicant.', 1);
SET @zmb9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@zmb9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@zmb9s1, 'Host Event Organizer Invitation Letter', NULL, 'original', 1, 0, 1, 2),
(@zmb9s1, 'Home-Country Sports Association Letter', 'Confirms role/participation.', 'original', 0, 1, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@zmb9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @zmb9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@zmb9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(53, 9, 50.00, 'USD', 'Single-Entry e-Visa Fee (Effective 1 Jan 2026)', 'Same fee tier as Tourist; Zambia does not appear to run a separately priced Sports-visa category, based on this session''s research.', '2026-01-01', NOW(), 'https://www.zambiatourism.com/updated-visa-fees-for-2026/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Sports visa fee for Zambia?', 'This was not independently confirmed this session — evidence points to the standard e-Visa fee tier applying, with an event-organizer invitation letter as the differentiating document.', 53, 9, 5380, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Dependants Permit
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    53, 10, 'ZMB-DEP-IN-10', '2026.09', 'published',
    'Spouse and minor children joining an Indian Employment Permit or other long-term permit holder in Zambia.',
    'Family members of an Indian national holding a qualifying Employment Permit or other long-term residence permit; each dependant is issued an individual Dependants Permit as a Digital Permit Card. A dependent spouse generally may reside but may NOT work unless they separately qualify for their own Employment Permit.',
    'Tied to the sponsor''s Employment/residence permit validity',
    'Apply online via the ZamServices portal (eservices.gov.zm), tied to the principal permit holder''s application',
    0,
    'Not independently confirmed this session for a specific working-day figure',
    'Zambia Department of Immigration, via the ZamServices online portal',
    'Confirm the sponsor holds a qualifying long-term Employment/residence permit\nGather relationship proof (marriage/birth certificates) and the sponsor''s permit copy\nApply for the Dependants Permit online via ZamServices\nUpload documents and pay the applicable fee online\nReceive the Digital Permit Card',
    '/assets/images/visa-heroes/zambia.webp',
    'Cross-checked against Rivermate/G-P/Playroll dependant-permit guidance describing individual Digital Permit Cards and work-right restrictions for dependants, triangulated against official domains not directly fetchable this session', 'https://rivermate.com/guides/zambia/work-permits-and-visas', '2026-09-17'
);
SET @zmb10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@zmb10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@zmb10, 'Core Documents', 'Required from every applicant.', 1);
SET @zmb10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@zmb10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@zmb10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@zmb10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @zmb10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@zmb10s2, 'Sponsor''s Employment Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@zmb10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(53, 10, NULL, 'ZMW', 'Confirmed After Assessment', 'Dependants Permit fee was not independently confirmed this session; apply via ZamServices (eservices.gov.zm) to see the current online fee schedule before paying.', '2026-09-01', NOW(), 'https://zamportal.gov.zm/service-category/for-immigrants/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse work in Zambia on a Dependants Permit?', 'Generally no — a dependent spouse can reside in Zambia on a Dependants Permit but is reported to be restricted from working unless they separately qualify for their own Employment Permit in their own right.', 53, 10, 5390, 1);
