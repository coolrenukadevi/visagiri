-- Netherlands Visa Checklist Engine content for all 10 visa types —
-- built fresh this session via web search, same standard as every
-- other country built this session (see AUDIT.md). hero_image_url
-- points at the real Kinderdijk windmills photo supplied by the
-- client for this hero.
--
-- The Netherlands is Schengen, structurally similar to France/Germany/
-- Italy (already built), but its real, Netherlands-SPECIFIC facts are
-- genuinely different, not a copy-paste of those countries:
--   - A genuinely positive distinctive fact: Indian passport holders
--     are generally EXEMPT from the Netherlands' own Airport Transit
--     Visa for airside connections through Schiphol — unlike France,
--     Germany, Spain, and the Czech Republic, which DO mandate an ATV
--     for Indian nationals. This is the opposite pattern from most
--     other Schengen transit rules built this session (which grant a
--     2026 exemption date), and is stated as the Netherlands' own
--     long-standing policy rather than a new exemption.
--   - Student is structurally distinctive: almost all recognised Dutch
--     higher-education institutions are IND-recognised sponsors and
--     submit the ENTIRE visa/residence-permit application to the IND
--     on the student's behalf — the student deals with the
--     university's international office, not the embassy/IND
--     directly, a real and materially different process from most
--     other countries built this session.
--   - Work uses the Highly Skilled Migrant (Kennismigrant) scheme with
--     real, tiered 2026 salary thresholds (EUR 5,942/month age 30+;
--     EUR 4,357/month under 30; a reduced EUR 3,122/month for Dutch
--     graduates and Orientation Year permit holders converting to HSM
--     status) — plus a genuinely distinct product, the Orientation
--     Year (Zoekjaar) visa, giving recent graduates 12 months of
--     unrestricted labour-market access with no work-permit
--     requirement for the employer.
--   - Family Visit requires a specific Dutch legal instrument — the
--     "Bewijs van garantstelling" (IND form 1310) — legalised by the
--     host's Dutch municipality, making the host financially liable,
--     a materially different mechanism from a simple invitation
--     letter.
--   - Dependent (Gezinshereniging) sponsor income is pegged to a real,
--     current Dutch statutory minimum-wage figure (EUR 2,294.40/month
--     excluding holiday allowance, EUR 2,477.95 including it, as of
--     January 2026), not a generic fabricated threshold.
--
-- country_id 136 = Netherlands. visa_type_id: 1=Tourist, 2=Business,
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
    136, 1, 'NLD-TOUR-IN-01', '2026.09', 'published',
    'Leisure travel, sightseeing, and short personal visits to the Netherlands and the wider Schengen area.',
    'Indian passport holders must obtain a Schengen visa before travelling. Applications are submitted via VFS Global with mandatory biometric data collection at one of 8 Indian cities (Delhi, Mumbai, Bangalore, Chennai, Hyderabad, Kolkata, Ahmedabad, Pune).',
    'Up to 90 days within any 180-day period (Schengen short-stay)',
    'Short-stay Schengen visa (Type C), submitted via VFS Global with biometrics',
    1,
    'Most Indian applications are processed in 10-15 days',
    'VFS Global Netherlands Visa Application Centre, India',
    'Initial consultation to confirm Tourist Visa is the right category\nGather documents against this checklist, including a day-by-day itinerary\nBook your VFS Global appointment\nAttend in person for biometrics (mandatory for first-time applicants)\nSubmission of your application and documents\nDecision — visa sticker affixed to your passport once approved',
    '/assets/images/visa-heroes/netherlands.jpg',
    'Netherlands Worldwide (netherlandsworldwide.nl) Schengen visa guidance, cross-checked via VFS Global Netherlands India sourcing', 'https://www.netherlandsworldwide.nl/', '2026-09-11'
);
SET @nl1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nl1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nl1, 'Core Documents', 'Every applicant needs these.', 1);
SET @nl1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nl1s1, 'Valid Passport', 'Valid at least 3 months beyond intended departure, with at least 2 blank pages.', 'original', 1, 0, 1, 1),
(@nl1s1, 'Passport Photographs', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nl1, 'Financial & Travel Documents', 'Evidence you can support your trip.', 2);
SET @nl1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nl1s2, 'Bank Statements & ITRs', NULL, 'copy', 1, 0, 1, 1),
(@nl1s2, 'Schengen Travel Insurance', 'Minimum EUR 30,000 medical coverage.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nl1, 'Application Documents', 'Your formal application paperwork.', 3);
SET @nl1s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nl1s3, 'Flight Itinerary & Hotel Booking', NULL, 'original', 1, 0, 0, 1),
(@nl1s3, 'Employer NOC', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nl1, 'Appointment & Submission', 'Booking and attending your VFS appointment.', 4);
SET @nl1s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nl1s4, 'VFS Appointment & Biometrics', 'Mandatory in-person biometric data collection, valid 59 months once captured.', 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(136, 1, 90.00, 'EUR', 'Schengen Short-Stay Visa Fee', 'EUR 90 for adults, EUR 45 for children aged 6-11, free under 6. VFS Global''s separate service charge is additional.', '2026-01-01', NOW(), 'https://www.netherlandsworldwide.nl/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How many VFS Global centres process Netherlands visas in India?', 'Eight: Delhi, Mumbai, Bangalore, Chennai, Hyderabad, Kolkata, Ahmedabad, and Pune.', 136, 1, 1160, 1),
('How long is my biometric data valid?', '59 months once captured, so repeat applicants within that window may not need to re-enrol.', 136, 1, 1161, 1),
('How long does processing typically take?', 'Most Indian applications are processed in 10-15 days.', 136, 1, 1162, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Schengen Short-Stay (Type C)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    136, 2, 'NLD-BUS-IN-02', '2026.09', 'published',
    'Short business visits — meetings, negotiations, and trade fairs — to the Netherlands.',
    'An invitation letter from the Dutch host company on letterhead is the standard supporting document, stating purpose, dates, and who bears costs. Where no formal invitation exists — for example, an independent trade-fair visit — contracts, paid invoices, or admission tickets can substitute.',
    'Up to 90 days within any 180-day period (Schengen short-stay)',
    'Short-stay Schengen visa (Type C), submitted via VFS Global with biometrics',
    1,
    'Applications can be submitted up to 6 months before travel',
    'VFS Global Netherlands Visa Application Centre, India',
    'Initial consultation to confirm the trip is a genuine business visit\nObtain an invitation letter, or contracts/invoices/admission tickets if no formal invitation exists\nGather documents against this checklist\nBook your VFS Global appointment and attend biometrics\nSubmission of your application and documents\nCollect your passport from VFS once approved',
    '/assets/images/visa-heroes/netherlands.jpg',
    'Netherlands Worldwide checklist for Schengen business/official visits', 'https://www.netherlandsworldwide.nl/visa-the-netherlands/checklist-schengen-visa-business-official-visit', '2026-09-11'
);
SET @nl2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nl2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nl2, 'Core Documents', 'Every applicant needs these.', 1);
SET @nl2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nl2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@nl2s1, 'Passport Photographs', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nl2, 'Business Invitation & Purpose', 'Evidence of who you are meeting and why.', 2);
SET @nl2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nl2s2, 'Invitation Letter from Dutch Host Company', 'Or contracts/invoices/admission tickets if no formal invitation exists.', 'original', 1, 0, 1, 1),
(@nl2s2, 'Covering Letter from Indian Employer', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nl2, 'Financial & Travel Documents', 'Evidence you can support your trip.', 3);
SET @nl2s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nl2s3, 'Bank Statements', NULL, 'copy', 1, 0, 0, 1),
(@nl2s3, 'Schengen Travel Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(136, 2, 90.00, 'EUR', 'Schengen Short-Stay Visa Fee', 'Same fee structure as Tourist — Business is the same Schengen short-stay visa.', '2026-01-01', NOW(), 'https://www.netherlandsworldwide.nl/visa-the-netherlands/checklist-schengen-visa-business-official-visit', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What if my Dutch host cannot provide a formal invitation letter?', 'Contracts, paid invoices, or admission tickets (e.g. for a trade fair) can substitute, as accepted under Netherlands Worldwide''s own guidance.', 136, 2, 1163, 1),
('How far in advance can I apply?', 'Up to 6 months before your planned travel date.', 136, 2, 1164, 1),
('Is Business a separate visa product from Tourist?', 'No — it uses the same Schengen short-stay Type C visa, distinguished by business-purpose documents.', 136, 2, 1165, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — MVV + VVR (via TEV Procedure)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    136, 3, 'NLD-STU-IN-03', '2026.09', 'published',
    'Full-time study at a Dutch higher-education institution.',
    'A structurally distinctive process: almost all recognised Dutch institutions are IND-recognised sponsors and submit the ENTIRE MVV (provisional residence visa) plus residence-permit application to the IND on your behalf — you deal with the university''s international office, not the embassy/IND directly.',
    'Duration of your study program (residence permit)',
    'Combined MVV + residence permit via the "TEV" procedure, submitted by your Dutch institution as your recognised sponsor',
    1,
    'Statutory IND processing time is up to 90 days, though around 8 weeks is typical in practice',
    'MVV collected at the Dutch embassy/consulate; residence card issued upon arrival',
    'Secure admission from a recognised Dutch institution acting as your sponsor\nThe institution submits your combined MVV + residence permit application to the IND on your behalf\nGather documents your institution requests against this checklist\nCollect your MVV at the Dutch embassy/consulate\nCollect your residence card upon arrival in the Netherlands',
    '/assets/images/visa-heroes/netherlands.jpg',
    'IND (Immigration and Naturalisation Service) Student visa (TEV procedure) guidance', 'https://ind.nl/en/', '2026-09-11'
);
SET @nl3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nl3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nl3, 'Core Documents', 'Every applicant needs these.', 1);
SET @nl3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nl3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@nl3s1, 'Admission/Enrolment Confirmation', 'From your recognised Dutch institution, which submits your application as sponsor.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nl3, 'Financial Documents', 'Evidence you can fund your studies.', 2);
SET @nl3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nl3s2, 'Proof of Funds', 'As required by your institution as sponsor.', 'copy', 1, 0, 0, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nl3, 'Post-Arrival Documents', 'Completed after arrival.', 3);
SET @nl3s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nl3s3, 'Residence Card Collection', NULL, 'original', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(136, 3, NULL, 'EUR', 'Confirmed After Assessment', 'The MVV + residence permit fee is typically arranged/forwarded by your Dutch institution as sponsor rather than paid directly by you — confirm the exact current figure with your institution.', '2026-09-01', NOW(), 'https://ind.nl/en/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I apply directly to the embassy or IND?', 'No — almost all recognised Dutch institutions are IND-recognised sponsors and submit the entire application on your behalf; you deal with the university''s international office instead.', 136, 3, 1166, 1),
('How long does processing take?', 'Statutory IND processing time is up to 90 days, though around 8 weeks is typical in practice.', 136, 3, 1167, 1),
('Where do I collect my visa/permit?', 'The MVV is collected at the Dutch embassy/consulate before travel, and the residence card is collected upon arrival in the Netherlands.', 136, 3, 1168, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — Highly Skilled Migrant (Kennismigrant)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    136, 4, 'NLD-WORK-IN-04', '2026.09', 'published',
    'Skilled employment in the Netherlands under the Highly Skilled Migrant (Kennismigrant) scheme.',
    'Your employer must be an IND-recognised sponsor. Real, tiered 2026 minimum gross monthly salary thresholds apply: EUR 5,942 for migrants aged 30+, EUR 4,357 for under-30, and a reduced EUR 3,122 for graduates of Dutch institutions and Orientation Year permit holders converting to HSM status.',
    'Tied to your employment contract, renewable',
    'Employer (IND-recognised sponsor) submits your application; you then collect your MVV/residence permit',
    1,
    'Processing timelines depend on the sponsor and individual circumstances',
    'VFS Global Netherlands Visa Application Centre, India, for MVV collection',
    'Confirm your employer is an IND-recognised sponsor\nEmployer submits your Highly Skilled Migrant application to the IND\nGather documents against this checklist\nCollect your MVV and attend biometrics\nCollect your residence permit upon arrival',
    '/assets/images/visa-heroes/netherlands.jpg',
    'IND Highly Skilled Migrant residence permit guidance and 2026 salary thresholds', 'https://business.gov.nl/coming-to-the-netherlands/permits-and-visa/residence-permit-for-highly-skilled-migrant/', '2026-09-11'
);
SET @nl4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nl4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nl4, 'Core Documents', 'Every applicant needs these.', 1);
SET @nl4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nl4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@nl4s1, 'IND Sponsor Confirmation', 'Confirming your employer is an IND-recognised sponsor.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nl4, 'Employer Sponsorship Documents', 'Evidence of your job offer and salary.', 2);
SET @nl4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nl4s2, 'Employment Contract', 'Confirming your salary meets the applicable age-tier threshold.', 'copy', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nl4, 'Qualification Documents', 'Evidence you meet the role''s requirements.', 3);
SET @nl4s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nl4s3, 'Educational Credentials', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(136, 4, 423.00, 'EUR', 'IND Application Fee (Employer-Paid)', 'EUR 423, paid by your employer via direct debit (non-refundable if refused). An accompanying partner costs an additional EUR 254, and a child under 18 costs EUR 85.', '2026-01-01', NOW(), 'https://www.jobbatical.com/blog/netherlands-ind-application-fees', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What are the 2026 Highly Skilled Migrant salary thresholds?', 'EUR 5,942/month for migrants aged 30+, EUR 4,357/month for under-30, and a reduced EUR 3,122/month for graduates of Dutch institutions and Orientation Year permit holders converting to HSM status.', 136, 4, 1169, 1),
('Is there an option for recent graduates without a job offer yet?', 'Yes — the separate Orientation Year (Zoekjaar) visa gives recent graduates/researchers 12 months of unrestricted labour-market access, with no work-permit requirement for the employer, applied for within 3 years of graduating.', 136, 4, 1170, 1),
('Who pays the IND application fee?', 'Your employer, via direct debit — EUR 423 for the main applicant, plus EUR 254 for an accompanying partner and EUR 85 per child under 18.', 136, 4, 1171, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Schengen Short-Stay (Type C)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    136, 5, 'NLD-FAM-IN-05', '2026.09', 'published',
    'Visiting family or friends in the Netherlands.',
    'Requires a "Bewijs van garantstelling en/of particuliere logiesverstrekking" (Proof of Sponsorship and/or Private Accommodation, IND form 1310) when your Dutch host guarantees your costs or provides lodging — the host''s signature must be legalised by their Dutch municipality, valid 3 months, making the host financially liable for you.',
    'Up to 90 days within any 180-day period (Schengen short-stay)',
    'Short-stay Schengen visa (Type C), submitted via VFS Global with biometrics',
    1,
    'Your host must obtain the Bewijs van garantstelling before you can apply, so plan this step early',
    'VFS Global Netherlands Visa Application Centre, India',
    'Your Dutch host obtains the Bewijs van garantstelling (IND form 1310), legalised by their municipality\nGather documents against this checklist, including relationship proof\nBook your VFS Global appointment and attend biometrics\nSubmission of your application and documents\nCollect your passport from VFS once approved',
    '/assets/images/visa-heroes/netherlands.jpg',
    'IND form 1310 (Bewijs van garantstelling en/of particuliere logiesverstrekking) guidance', 'https://ind.nl/en/forms/1310.pdf', '2026-09-11'
);
SET @nl5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nl5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nl5, 'Core Documents', 'Every applicant needs these.', 1);
SET @nl5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nl5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@nl5s1, 'Passport Photographs', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nl5, 'Host Sponsorship Documents', 'Evidence of your host''s formal commitment.', 2);
SET @nl5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nl5s2, 'Bewijs van Garantstelling (IND Form 1310)', 'Legalised by the host''s Dutch municipality, valid 3 months.', 'original', 1, 0, 1, 1),
(@nl5s2, 'Relationship Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nl5, 'Travel & Insurance Documents', 'Evidence you can support your trip.', 3);
SET @nl5s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nl5s3, 'Schengen Travel Insurance', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(136, 5, 90.00, 'EUR', 'Schengen Short-Stay Visa Fee', 'Same fee structure as Tourist, plus your host''s legalisation cost for the Bewijs van garantstelling at their municipality.', '2026-01-01', NOW(), 'https://ind.nl/en/forms/1310.pdf', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is a "Bewijs van garantstelling"?', 'A formal Dutch sponsorship declaration (IND form 1310) your host signs, legalised by their local municipality, making them financially liable for your visit — a materially different mechanism from a simple invitation letter.', 136, 5, 1172, 1),
('How long is this document valid?', 'Valid 3 months from the host''s legalised signature.', 136, 5, 1173, 1),
('Is this required for every family visit?', 'It is required when your host is guaranteeing your costs and/or providing private accommodation — check with your host whether this applies to your specific visit.', 136, 5, 1174, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Generally Exempt for Indian Passport Holders
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    136, 6, 'NLD-TRANS-IN-06', '2026.09', 'published',
    'Passing through Schiphol Airport en route to a third country.',
    'A genuinely positive fact: Indian passport holders are generally EXEMPT from the Netherlands'' own Airport Transit Visa for airside connections — unlike France, Germany, Spain, and the Czech Republic, which DO mandate one for Indian nationals. A visa is only needed if the itinerary requires exiting the airside transit area (e.g. terminal change through passport control) or collecting and rechecking baggage.',
    'Strictly for the duration of your airside connection',
    'No application needed for eligible airside connections; standard Schengen visa required if exiting the transit area',
    0,
    'Confirm your specific routing before assuming no visa is needed, especially if baggage must be rechecked',
    'Not applicable for eligible transit; VFS Global Netherlands centre if a full Schengen visa is required instead',
    'Confirm your connection stays airside without exiting through passport control\nIf eligible, no visa application is needed — proceed with your connecting flight\nIf exiting the transit area or collecting baggage, apply for a standard Schengen visa instead',
    '/assets/images/visa-heroes/netherlands.jpg',
    'Netherlands Airport Transit Visa exemption for Indian passport holders guidance', 'https://schengenvisainfo.com/news/explaining-transit-schengen-visa-requirement-for-indians/', '2026-09-11'
);
SET @nl6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nl6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nl6, 'Core Documents', 'For eligible airside connections.', 1);
SET @nl6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nl6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@nl6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nl6, 'If Exiting the Transit Area', 'Fall back to a standard Schengen visa.', 2);
SET @nl6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nl6s2, 'Standard Schengen Visa Application', 'Required if exiting through passport control or rechecking baggage.', 'original', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(136, 6, 0.00, 'EUR', 'No Fee for Exempt Airport Transit', 'No visa or fee is needed for a qualifying airside connection through Schiphol. A standard EUR 90 Schengen visa fee applies only if you must exit the transit area.', '2026-01-01', NOW(), 'https://schengenvisainfo.com/news/explaining-transit-schengen-visa-requirement-for-indians/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need an Airport Transit Visa for the Netherlands?', 'Generally no — Indian passport holders are exempt from the Netherlands'' own Airport Transit Visa for airside connections through Schiphol, unlike France, Germany, Spain, and the Czech Republic.', 136, 6, 1175, 1),
('Is this a new 2026 exemption?', 'No — this is the Netherlands'' long-standing own policy, not a recent time-limited exemption like some other Schengen states'' 2026 transit-rule changes.', 136, 6, 1176, 1),
('What if I need to recheck my baggage during my layover?', 'That would require exiting through passport control, so a standard Schengen visa would be needed.', 136, 6, 1177, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Schengen Medical Treatment Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    136, 7, 'NLD-MED-IN-07', '2026.09', 'published',
    'Travelling to the Netherlands to receive medical treatment.',
    'Requires an official hospital/clinic appointment letter confirming treatment necessity, proof of funds to cover treatment costs (plus prepayment proof where applicable), and proof of accommodation — a rental/hotel booking, or a declaration from the medical institution if lodging on-site.',
    'Up to 90 days (Schengen short-stay)',
    'Short-stay Schengen visa (Type C), submitted via VFS Global with biometrics',
    1,
    'Processing depends on the completeness of medical and financial documentation',
    'VFS Global Netherlands Visa Application Centre, India',
    'Obtain an official appointment letter from the Dutch hospital/clinic\nArrange proof of funds and accommodation\nGather documents against this checklist\nBook your VFS Global appointment and attend biometrics\nSubmission of your application and documents\nCollect your passport from VFS once approved',
    '/assets/images/visa-heroes/netherlands.jpg',
    'Netherlands Worldwide checklist for Schengen medical-reason visa applications', 'https://www.netherlandsworldwide.nl/visa-the-netherlands/checklist-schengen-visa-medical', '2026-09-11'
);
SET @nl7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nl7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nl7, 'Core Documents', 'Every applicant needs these.', 1);
SET @nl7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nl7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@nl7s1, 'Passport Photographs', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nl7, 'Medical Documents', 'Evidence of your treatment plan.', 2);
SET @nl7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nl7s2, 'Hospital/Clinic Appointment Letter', 'Confirming treatment necessity.', 'original', 1, 0, 1, 1),
(@nl7s2, 'Proof of Accommodation', 'Rental/hotel booking, or a declaration from the medical institution if lodging on-site.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nl7, 'Financial & Insurance Documents', 'Evidence you can pay for treatment.', 3);
SET @nl7s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nl7s3, 'Proof of Funds / Prepayment', NULL, 'copy', 1, 0, 0, 1),
(@nl7s3, 'Schengen Travel Insurance', 'Minimum EUR 30,000.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(136, 7, 90.00, 'EUR', 'Schengen Short-Stay Visa Fee', 'Same base fee as Tourist.', '2026-01-01', NOW(), 'https://www.netherlandsworldwide.nl/visa-the-netherlands/checklist-schengen-visa-medical', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What must the hospital appointment letter confirm?', 'The necessity of your treatment, alongside proof of funds and, where applicable, prepayment evidence.', 136, 7, 1178, 1),
('Do I need separate accommodation proof if I''m staying at the hospital?', 'No — a declaration from the medical institution confirming on-site lodging can substitute for a rental/hotel booking.', 136, 7, 1179, 1),
('Is Medical treatment a separate visa from Tourist?', 'No — it uses the same Schengen short-stay Type C visa, with medical-specific supporting documents.', 136, 7, 1180, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Schengen Business Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    136, 8, 'NLD-CONF-IN-08', '2026.09', 'published',
    'Attending a conference or congress in the Netherlands.',
    'Falls under the Schengen "business" visa category. Requires an invitation from the conference organiser or hosting company; absent one, registration confirmation/admission ticket for the congress plus proof of professional ties suffices.',
    'Up to 90 days (Schengen short-stay)',
    'Short-stay Schengen visa (Type C), submitted via VFS Global with biometrics',
    1,
    'Processing typically runs 10-15 days',
    'VFS Global Netherlands Visa Application Centre, India',
    'Obtain your conference invitation, or registration confirmation/admission ticket\nGather documents against this checklist\nBook your VFS Global appointment and attend biometrics\nSubmission of your application and documents\nCollect your passport from VFS once approved',
    '/assets/images/visa-heroes/netherlands.jpg',
    'Netherlands Worldwide Schengen business visa (conference) guidance', 'https://www.netherlandsworldwide.nl/visa-the-netherlands/checklist-schengen-visa-business-official-visit', '2026-09-11'
);
SET @nl8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nl8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nl8, 'Core Documents', 'Every applicant needs these.', 1);
SET @nl8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nl8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@nl8s1, 'Passport Photographs', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nl8, 'Conference Documents', 'Evidence of the event and your role.', 2);
SET @nl8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nl8s2, 'Conference Invitation or Registration Confirmation', NULL, 'original', 1, 0, 1, 1),
(@nl8s2, 'Proof of Professional Ties', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nl8, 'Financial Documents', 'Evidence of funds.', 3);
SET @nl8s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nl8s3, 'Bank Statements', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(136, 8, 90.00, 'EUR', 'Schengen Short-Stay Visa Fee', 'Same fee as Business — Conference is a business-purpose Schengen visa.', '2026-01-01', NOW(), 'https://www.netherlandsworldwide.nl/visa-the-netherlands/checklist-schengen-visa-business-official-visit', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Conference a separate visa category?', 'No — it falls under the same Schengen business visa category as Business, distinguished by conference-specific documents.', 136, 8, 1181, 1),
('What if the conference doesn''t issue formal invitations?', 'Registration confirmation or an admission ticket for the congress, plus proof of professional ties, can substitute.', 136, 8, 1182, 1),
('What proves my professional ties?', 'A letter from your employer or evidence of your role relevant to the conference topic.', 136, 8, 1183, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Schengen Visa (Sports Purpose)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    136, 9, 'NLD-SPORT-IN-09', '2026.09', 'published',
    'Participating in a sporting event in the Netherlands.',
    'No separate Dutch sports-visa product exists — participants apply under the general Schengen short-stay visa citing "cultural, sporting or religious event" as the travel purpose, supported by an invitation from the event organiser or sporting federation.',
    'Up to 90 days (Schengen short-stay)',
    'Short-stay Schengen visa (Type C), submitted via VFS Global with biometrics',
    1,
    'Processing typically runs 10-15 days',
    'VFS Global Netherlands Visa Application Centre, India',
    'Obtain an invitation from the event organiser/sporting federation\nGather documents against this checklist\nBook your VFS Global appointment and attend biometrics\nSubmission of your application and documents\nCollect your passport from VFS once approved',
    '/assets/images/visa-heroes/netherlands.jpg',
    'Netherlands Schengen visa (sports/cultural event purpose) guidance', 'https://www.netherlandsworldwide.nl/', '2026-09-11'
);
SET @nl9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nl9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nl9, 'Core Documents', 'Every applicant needs these.', 1);
SET @nl9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nl9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@nl9s1, 'Passport Photographs', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nl9, 'Sports Event Documents', 'Evidence of your role and the event.', 2);
SET @nl9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nl9s2, 'Invitation from Event Organiser/Federation', NULL, 'original', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nl9, 'Financial & Travel Documents', 'Evidence you can support your trip.', 3);
SET @nl9s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nl9s3, 'Bank Statements', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(136, 9, 90.00, 'EUR', 'Schengen Short-Stay Visa Fee', 'Same fee as Tourist — Sports is a purpose category within the general Schengen visa, not a separate product.', '2026-01-01', NOW(), 'https://www.netherlandsworldwide.nl/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does the Netherlands have a distinct Sports Visa?', 'No — participants use the general Schengen short-stay visa citing "cultural, sporting or religious event" as the purpose.', 136, 9, 1184, 1),
('What invitation do I need?', 'One from the event organiser or the relevant sporting federation.', 136, 9, 1185, 1),
('Is the fee different from Tourist?', 'No — the same EUR 90 Schengen short-stay fee applies.', 136, 9, 1186, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Family Reunification (Gezinshereniging)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    136, 10, 'NLD-DEP-IN-10', '2026.09', 'published',
    'Joining a spouse, registered partner, or parent who holds a Dutch visa/residence permit (Gezinshereniging, family reunification).',
    'The Dutch sponsor (referent) must show sufficient, durable, independent income at or above the statutory minimum wage — EUR 2,294.40/month excluding holiday allowance (EUR 2,477.95 including 8% holiday allowance) as of January 2026 — with an employment contract running at least 12 months from the application date.',
    'Matches the validity of the sponsor''s visa/residence permit',
    'Combined MVV + residence permit via the "TEV" procedure, submitted by your Dutch sponsor',
    1,
    'Processing depends on the sponsor''s income documentation and the household''s specific circumstances',
    'MVV collected at the Dutch embassy/consulate; residence card issued upon arrival',
    'Confirm your sponsor meets the statutory minimum income requirement\nSponsor submits the combined MVV + residence permit application to the IND\nGather documents against this checklist, including relationship proof\nCollect your MVV at the Dutch embassy/consulate\nCollect your residence card upon arrival',
    '/assets/images/visa-heroes/netherlands.jpg',
    'IND Family Reunification (Gezinshereniging) income requirement guidance', 'https://ind.nl/en/required-amounts-income-requirements', '2026-09-11'
);
SET @nl10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@nl10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nl10, 'Core Documents', 'Every applicant needs these.', 1);
SET @nl10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nl10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@nl10s1, 'Sponsor''s Visa/Residence Permit Copy', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nl10, 'Relationship Documents', 'Evidence of your relationship to the sponsor.', 2);
SET @nl10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nl10s2, 'Marriage/Partnership Certificate', 'For a spouse/partner applicant.', 'copy', 0, 1, 1, 1),
(@nl10s2, 'Birth Certificate', 'For a minor child applicant.', 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@nl10, 'Financial Documents', 'Evidence the sponsor meets the income requirement.', 3);
SET @nl10s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@nl10s3, 'Sponsor''s Employment Contract & Income Evidence', 'At or above EUR 2,294.40/month, contract running at least 12 months from the application date.', 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(136, 10, 254.00, 'EUR', 'Family Reunification Fee (Partner/Adult)', 'EUR 254 for a partner/adult family member, EUR 85 for a minor child joining a parent.', '2026-01-01', NOW(), 'https://ind.nl/en/required-amounts-income-requirements', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is the current sponsor income requirement?', 'EUR 2,294.40/month excluding holiday allowance (EUR 2,477.95 including 8% holiday allowance), as of January 2026, with an employment contract running at least 12 months from the application date.', 136, 10, 1187, 1),
('How much does a Dependent visa cost?', 'EUR 254 for a partner/adult family member, EUR 85 for a minor child.', 136, 10, 1188, 1),
('Who submits the application?', 'Your Dutch sponsor, via the combined MVV + residence permit "TEV" procedure.', 136, 10, 1189, 1);
