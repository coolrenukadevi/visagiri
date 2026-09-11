-- Germany Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search, same standard as Mexico/Singapore/
-- France/Japan/USA/Australia/Canada (see AUDIT.md). Germany is a
-- Schengen state like France, but its real Germany-specific facts are
-- genuinely different, not a copy-paste of France's content:
--   - Three distinct national-visa fee tiers, not one: EUR 90 Schengen
--     short-stay (Tourist/Business/Family Visit/Medical/Conference/
--     Sports) vs EUR 75 national long-stay (Student/Work/Dependent).
--   - Indian students face a mandatory APS Certificate (Academic
--     Evaluation Centre credential-verification step) BEFORE the visa
--     mission will even process a Student visa — a real, India-specific
--     gate not present for many other nationalities.
--   - Work has three genuinely distinct pathways: the EU Blue Card
--     (degree + binding job offer, real 2026 salary thresholds), a
--     general Employment Visa, and the Opportunity Card (Chancenkarte)
--     — a genuinely different, points-based job-SEEKER visa needing no
--     job offer at all, introduced 1 June 2024.
--   - Family Visit requires a Verpflichtungserklärung — a formal legal
--     declaration of commitment the German host signs at their LOCAL
--     Ausländerbehörde (not the applicant's consulate), a materially
--     different mechanism from a simple invitation letter.
--   - A genuinely time-sensitive fact: effective 3 June 2026, Indian
--     passport holders no longer need an Airport Transit Visa (ATV)
--     through Germany's major international transit zones (Frankfurt,
--     Munich, Berlin Brandenburg; Düsseldorf/Hamburg carry limitations)
--     — a Germany-specific easing, not automatically true for other
--     Schengen airports (France's own transit exemption, effective 10
--     April 2026, is a separate, earlier rule).
--   - Dependent (Familiennachzug) sponsor income is calculated
--     case-by-case via Existenzsicherung rates, not one fixed number —
--     stated honestly as a calculation, not a flat figure.
--
-- country_id 119 = Germany. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.
--
-- hero_image_url points at the real Brandenburg Gate/Berlin and German
-- flag photo supplied by the client for this hero.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — Schengen short-stay (Type C)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    119, 1, 'DEU-TOUR-IN-01', '2026.09', 'published',
    'Leisure travel, sightseeing, and short personal visits to Germany and the wider Schengen area.',
    'Indian passport holders must obtain a Schengen visa before travelling. If Germany is where you will spend the most time/nights among Schengen states, the German mission has jurisdiction over your application — otherwise apply through your main destination''s mission instead.',
    'Up to 90 days within any 180-day period (Schengen short-stay)',
    'Short-stay Schengen visa (Type C), submitted via VFS Global with biometrics',
    1,
    'Processing typically runs 15 working days, longer in peak season',
    'VFS Global Germany Visa Application Centre, India',
    'Initial consultation to confirm Tourist Visa and German jurisdiction are correct\nGather documents against this checklist, including a day-by-day itinerary\nBook your VFS Global appointment\nAttend in person for biometrics (mandatory for first-time applicants)\nSubmission of your application and documents\nSupport responding to any additional-information request\nDecision — visa sticker affixed to your passport once approved',
    '/assets/images/visa-heroes/germany.jpg',
    'German Federal Foreign Office (auswaertiges-amt.de) and German Missions India Schengen visa guidance', 'https://www.auswaertiges-amt.de/en/visa-service/215870-215870', '2026-09-11'
);
SET @dt1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dt1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dt1, 'Core Documents', 'Every applicant needs these.', 1);
SET @dt1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dt1s1, 'Valid Passport', 'Valid at least 3 months beyond intended departure, with at least 2 blank pages.', 'original', 1, 0, 1, 1),
(@dt1s1, 'Passport Photographs', 'Two recent colour photos, 35x45mm, white background.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dt1, 'Financial & Travel Documents', 'Evidence you can support your trip.', 2);
SET @dt1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dt1s2, 'Bank Statements', 'Last 3 months.', 'copy', 1, 0, 1, 1),
(@dt1s2, 'Schengen Travel Insurance', 'Minimum EUR 30,000 medical coverage, valid across the whole Schengen area.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dt1, 'Application Documents', 'Your formal application paperwork.', 3);
SET @dt1s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dt1s3, 'Completed Schengen Visa Application Form', NULL, 'original', 1, 0, 0, 1),
(@dt1s3, 'Proof Germany Is Your Main Destination', 'Hotel bookings/itinerary showing most nights spent in Germany.', 'original', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dt1, 'Appointment & Submission', 'Booking and attending your VFS appointment.', 4);
SET @dt1s4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dt1s4, 'VFS Appointment & Biometrics', 'Mandatory in-person biometric data collection, valid 59 months once captured.', 'original', 1, 0, 0, 1),
(@dt1s4, 'Visa Fee Payment Receipt', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(119, 1, 90.00, 'EUR', 'Schengen Short-Stay Visa Fee', 'EUR 90 for adults, EUR 45 for children aged 6-12, free under 6. VFS Global''s separate service charge is additional — we confirm the full total before you apply.', '2026-06-01', NOW(), 'https://www.auswaertiges-amt.de/en/visa-service/215870-215870', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Which Schengen country should I apply through if I am visiting several?', 'The mission of whichever Schengen country is your main destination — where you will spend the most nights — has jurisdiction. If Germany is not your main stop, apply through that country''s mission instead.', 119, 1, 890, 1),
('How long is my biometric data valid?', 'Once captured, your biometric data is valid for 59 months, so you may not need to re-attend in person for a repeat application within that window.', 119, 1, 891, 1),
('Is there a discount for children?', 'Yes — EUR 45 for children aged 6-12, and the fee is waived entirely for children under 6.', 119, 1, 892, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — Schengen short-stay (Type C)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    119, 2, 'DEU-BUS-IN-02', '2026.09', 'published',
    'Short business visits — meetings, negotiations, and factory visits — to Germany.',
    'The invitation letter is central: it must be on official German company letterhead, bear the company stamp and an authorized signatory''s signature, state the commercial register number/court of registration, and specify the actual business purpose — vague "business discussions" wording is a common cause of delay.',
    'Up to 90 days within any 180-day period (Schengen short-stay)',
    'Short-stay Schengen visa (Type C), submitted via VFS Global with biometrics',
    1,
    'Processing typically runs 15 working days, longer in peak season',
    'VFS Global Germany Visa Application Centre, India',
    'Initial consultation to confirm the trip is a genuine business visit\nObtain a detailed invitation letter with company registration details from your German host\nGather documents against this checklist\nBook your VFS Global appointment\nAttend in person for biometrics\nSubmission of your application and documents\nCollect your passport from VFS once approved',
    '/assets/images/visa-heroes/germany.jpg',
    'German Federal Foreign Office Schengen business visa guidance', 'https://www.auswaertiges-amt.de/en/visa-service/215870-215870', '2026-09-11'
);
SET @dt2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dt2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dt2, 'Core Documents', 'Every applicant needs these.', 1);
SET @dt2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dt2s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@dt2s1, 'Passport Photographs', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dt2, 'Business Invitation & Purpose', 'Evidence of who you are meeting and why.', 2);
SET @dt2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dt2s2, 'Invitation Letter from German Host Company', 'On letterhead, with commercial register number, signed by an authorized signatory, dated within 3 months.', 'original', 1, 0, 1, 1),
(@dt2s2, 'Covering Letter from Indian Employer', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dt2, 'Financial & Travel Documents', 'Evidence you can support your trip.', 3);
SET @dt2s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dt2s3, 'Bank Statements', 'Last 3 months.', 'copy', 1, 0, 0, 1),
(@dt2s3, 'Schengen Travel Insurance', 'Minimum EUR 30,000 coverage.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(119, 2, 90.00, 'EUR', 'Schengen Short-Stay Visa Fee', 'Same fee structure as Tourist — Business is the same Schengen short-stay visa.', '2026-06-01', NOW(), 'https://www.auswaertiges-amt.de/en/visa-service/215870-215870', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What makes a German business invitation letter acceptable?', 'It must be on official letterhead, carry the company stamp and an authorized signatory''s signature, state the commercial register number, and clearly specify the business purpose — generic wording is a common cause of delay.', 119, 2, 893, 1),
('How recent must the invitation letter be?', 'Generally dated within 3 months of your application.', 119, 2, 894, 1),
('Is this a separate visa category from Tourist?', 'No — it uses the same Schengen short-stay Type C visa, distinguished only by the business-purpose documents.', 119, 2, 895, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — National Student Visa (Type D)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    119, 3, 'DEU-STU-IN-03', '2026.09', 'published',
    'Full-time study at a German university or higher-education institution.',
    'A mandatory APS Certificate (Academic Evaluation Centre) is required for Indian applicants to verify the authenticity of academic credentials BEFORE the mission will process the visa — a genuine India-specific gate, not a generic requirement applied to every nationality.',
    'Duration of your study program (national long-stay visa, convertible to a residence permit in Germany)',
    'National long-stay visa (Type D), increasingly submitted via the digital Consular Services Portal (CSP)',
    1,
    'APS processing takes roughly 3-4 weeks once documents reach the Delhi APS office, before the visa application itself can proceed',
    'VFS Global / German Mission India, with APS Certificate obtained from the Delhi APS office beforehand',
    'Obtain your APS Certificate from the Academic Evaluation Centre in Delhi\nSecure your university admission letter\nOpen a blocked account (Sperrkonto) with the required funds\nGather documents against this checklist\nSubmit your application via the Consular Services Portal or VFS\nAttend biometrics\nDecision once processed',
    '/assets/images/visa-heroes/germany.jpg',
    'German Federal Foreign Office National Visa guidance and APS Certificate requirement', 'https://india.diplo.de/in-en/service/2755482-2755482', '2026-09-11'
);
SET @dt3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dt3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dt3, 'Core Documents', 'Every applicant needs these.', 1);
SET @dt3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dt3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@dt3s1, 'APS Certificate', 'From the Academic Evaluation Centre, mandatory for Indian applicants before the visa can be processed.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dt3, 'Academic Documents', 'Evidence of your admission.', 2);
SET @dt3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dt3s2, 'University Admission Letter', NULL, 'original', 1, 0, 1, 1),
(@dt3s2, 'Academic Transcripts', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dt3, 'Financial Documents', 'Evidence you can fund your studies.', 3);
SET @dt3s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dt3s3, 'Blocked Account (Sperrkonto)', 'Currently EUR 11,904/year (EUR 992/month) for 2026.', 'original', 1, 0, 0, 1),
(@dt3s3, 'Health Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(119, 3, 75.00, 'EUR', 'National Visa Fee', 'EUR 75 for adults, EUR 37.50 for minors. Separate from the APS Certificate fee (approx. INR 18,000) and the Sperrkonto deposit.', '2026-09-01', NOW(), 'https://www.auswaertiges-amt.de/en/visa-service/215870-215870', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is the APS Certificate and why do I need it?', 'A mandatory credential-verification certificate from the Academic Evaluation Centre, required specifically for Indian applicants to confirm your academic documents are genuine, before the mission will process your student visa.', 119, 3, 896, 1),
('How much do I need in my blocked account?', 'Currently EUR 11,904/year (EUR 992/month) for 2026, covering your living costs — separate from tuition fees.', 119, 3, 897, 1),
('Is the Student Visa the same fee as Tourist?', 'No — it is a national long-stay visa at EUR 75, not the EUR 90 Schengen short-stay fee.', 119, 3, 898, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — EU Blue Card / Employment Visa / Opportunity Card
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    119, 4, 'DEU-WORK-IN-04', '2026.09', 'published',
    'Skilled employment in Germany, via one of three genuinely distinct pathways.',
    'Three real routes exist, not one: the EU Blue Card (degree + binding job offer, 2026 minimum salary EUR 50,700 standard / EUR 45,934.20 shortage occupations), a general Employment Visa for skilled workers without a Blue Card-eligible degree, or the Opportunity Card (Chancenkarte) — a points-based job-seeker visa requiring NO job offer, valid up to 12 months with limited part-time work rights while job-hunting.',
    'EU Blue Card/Employment Visa: tied to contract, renewable. Opportunity Card: up to 12 months',
    'National long-stay visa (Type D), increasingly submitted via the digital Consular Services Portal (CSP)',
    1,
    'Processing time depends on the pathway and any Federal Employment Agency approval required',
    'VFS Global / German Mission India',
    'Determine the right pathway: EU Blue Card, Employment Visa, or Opportunity Card\nGather documents against this checklist for your specific pathway\nSubmit your application via the Consular Services Portal or VFS\nAttend biometrics\nSupport responding to any additional-information request\nDecision once processed',
    '/assets/images/visa-heroes/germany.jpg',
    'German Federal Foreign Office EU Blue Card, Employment Visa, and Opportunity Card (Chancenkarte) guidance', 'https://www.auswaertiges-amt.de/en/visa-service/215870-215870', '2026-09-11'
);
SET @dt4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dt4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dt4, 'Core Documents', 'Every applicant needs these.', 1);
SET @dt4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dt4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@dt4s1, 'Educational Credentials', 'Degree certificate, with recognition evaluation where required.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dt4, 'EU Blue Card / Employment Visa Documents', 'For applicants with a binding job offer.', 2);
SET @dt4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dt4s2, 'Employment Contract/Job Offer', 'Meeting the applicable 2026 salary threshold for Blue Card, if applicable.', 'copy', 0, 1, 1, 1),
(@dt4s2, 'Federal Employment Agency Approval', 'Required for some general Employment Visa cases.', 'copy', 0, 1, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dt4, 'Opportunity Card Documents', 'For applicants without a job offer, applying via the points-based route.', 3);
SET @dt4s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dt4s3, 'Points-Grid Evidence', 'Qualifications, recent work experience, German/English language level, age, and prior Germany stays.', 'copy', 0, 1, 0, 1),
(@dt4s3, 'Proof of Funds (Opportunity Card)', 'At least EUR 1,091/month (EUR 13,092/year).', 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(119, 4, 75.00, 'EUR', 'National Visa Fee', 'EUR 75 across all three work pathways (EU Blue Card, Employment Visa, Opportunity Card) — the difference is in eligibility criteria, not this application fee.', '2026-09-01', NOW(), 'https://www.auswaertiges-amt.de/en/visa-service/215870-215870', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is the Opportunity Card (Chancenkarte)?', 'A genuinely different, points-based job-seeker national visa introduced 1 June 2024, requiring no job offer at all — eligibility is via a recognized qualification or a points-grid score, valid up to 12 months with limited part-time work rights while job-hunting.', 119, 4, 899, 1),
('What is the 2026 EU Blue Card salary threshold?', 'EUR 50,700/year for standard occupations, or EUR 45,934.20/year for shortage occupations (IT, engineering, natural sciences, mathematics, medicine), effective for applications from 1 January 2026.', 119, 4, 900, 1),
('Which pathway should I choose?', 'It depends on whether you already have a binding job offer (EU Blue Card or Employment Visa) or are job-hunting without one yet (Opportunity Card) — we assess your specific circumstances to recommend the right route.', 119, 4, 901, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — Schengen short-stay (Type C)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    119, 5, 'DEU-FAM-IN-05', '2026.09', 'published',
    'Visiting family or friends in Germany.',
    'Requires a Verpflichtungserklärung — a formal legal declaration of commitment your German host signs at their LOCAL Ausländerbehörde (immigration office), not simply a letter they write themselves. The host formally commits to cover all costs of your visit, backed by their own income/asset evidence.',
    'Up to 90 days within any 180-day period (Schengen short-stay)',
    'Short-stay Schengen visa (Type C), submitted via VFS Global with biometrics',
    1,
    'The Verpflichtungserklärung must be obtained by your host in Germany before you can apply, so plan this step early',
    'VFS Global Germany Visa Application Centre, India',
    'Your German host obtains the Verpflichtungserklärung from their local Ausländerbehörde\nGather documents against this checklist, including relationship proof\nBook your VFS Global appointment\nAttend in person for biometrics\nSubmission of your application and documents\nCollect your passport from VFS once approved',
    '/assets/images/visa-heroes/germany.jpg',
    'German Federal Foreign Office Verpflichtungserklärung (declaration of commitment) guidance', 'https://www.auswaertiges-amt.de/de/service/fragenkatalog-node/13-verpflichtungserklaerung-606492', '2026-09-11'
);
SET @dt5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dt5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dt5, 'Core Documents', 'Every applicant needs these.', 1);
SET @dt5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dt5s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@dt5s1, 'Passport Photographs', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dt5, 'Host Commitment Documents', 'Evidence of your host''s formal commitment.', 2);
SET @dt5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dt5s2, 'Verpflichtungserklärung', 'Issued by the host''s local Ausländerbehörde, valid 6 months from signature.', 'original', 1, 0, 1, 1),
(@dt5s2, 'Relationship Proof', 'Birth/marriage certificates or other evidence of your relationship.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dt5, 'Travel & Insurance Documents', 'Evidence you can support your trip.', 3);
SET @dt5s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dt5s3, 'Schengen Travel Insurance', 'Minimum EUR 30,000 coverage.', 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(119, 5, 90.00, 'EUR', 'Schengen Short-Stay Visa Fee', 'Your German host also separately pays EUR 29 to their Ausländerbehörde to obtain the Verpflichtungserklärung.', '2026-06-01', NOW(), 'https://www.auswaertiges-amt.de/de/service/fragenkatalog-node/13-verpflichtungserklaerung-606492', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is a Verpflichtungserklärung?', 'A formal legal declaration your German host signs at their local Ausländerbehörde, committing to cover all costs of your visit — a materially different, more formal mechanism than a simple invitation letter.', 119, 5, 902, 1),
('Who pays for the Verpflichtungserklärung?', 'Your German host, EUR 29, payable at their local immigration office when they obtain it.', 119, 5, 903, 1),
('Is giving false information on this declaration serious?', 'Yes — it is a criminal offence under German law, so hosts should ensure all details are accurate.', 119, 5, 904, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Airport Transit Visa (Type A)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    119, 6, 'DEU-TRANS-IN-06', '2026.09', 'published',
    'Passing through a German international airport en route to a third country.',
    'A genuinely time-sensitive fact: effective 3 June 2026, Indian passport holders no longer need an Airport Transit Visa (ATV) through the international transit zones of Frankfurt, Munich, and Berlin Brandenburg (Düsseldorf and Hamburg carry airline/time-specific limitations, so check with your airline). Anyone actually entering Germany, not staying airside, still needs a standard Schengen visa.',
    'Strictly for the duration of your airside connection',
    'No application needed for eligible airside connections; standard Schengen visa required if leaving the transit zone',
    0,
    'Confirm your specific routing and airport qualify for the exemption before assuming no visa is needed',
    'Not applicable for eligible transit; VFS Global Germany centre if a full Schengen visa is required instead',
    'Confirm your connecting airport and routing qualify for the June 2026 ATV exemption\nIf eligible, no visa application is needed — proceed with your connecting flight\nIf leaving the transit zone or the exemption does not apply, apply for a standard Schengen visa instead',
    '/assets/images/visa-heroes/germany.jpg',
    'German Missions India — Travel Facilitation at German Airports for Indian Nationals (June 2026 update)', 'https://india.diplo.de/in-en/2773896-2773896', '2026-09-11'
);
SET @dt6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dt6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dt6, 'Core Documents', 'For eligible airside connections.', 1);
SET @dt6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dt6s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@dt6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dt6, 'If the Exemption Does Not Apply', 'Fall back to a standard Schengen visa.', 2);
SET @dt6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dt6s2, 'Standard Schengen Visa Application', 'Required if leaving the transit zone or your airport/routing is not covered by the exemption.', 'original', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(119, 6, 0.00, 'EUR', 'No Fee for Eligible Airport Transit', 'No visa or fee is needed for a qualifying airside connection under the June 2026 exemption. A standard EUR 90 Schengen visa fee applies only if you must leave the transit zone or your routing is not covered.', '2026-06-03', NOW(), 'https://india.diplo.de/in-en/2773896-2773896', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need an Airport Transit Visa for Germany?', 'Not since 3 June 2026, for eligible airside connections through Frankfurt, Munich, or Berlin Brandenburg — Düsseldorf and Hamburg carry limitations, so check with your airline.', 119, 6, 905, 1),
('What if I need to leave the transit zone?', 'Then you need a standard Schengen visa — the exemption only covers staying airside within the international transit zone.', 119, 6, 906, 1),
('Is this the same as France''s transit exemption?', 'No — Germany''s exemption took effect 3 June 2026, a separate and later rule from France''s own 10 April 2026 exemption, each specific to that country''s airports.', 119, 6, 907, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — Schengen Medical Treatment Visa
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    119, 7, 'DEU-MED-IN-07', '2026.09', 'published',
    'Travelling to Germany to receive medical treatment.',
    'A confirmation letter from the treating German hospital/clinic stating diagnosis, planned treatment, and appointment date is central, alongside proof of ability to finance the entire treatment cost (often a bank guarantee or hospital prepayment confirmation) — your Schengen insurance covers complications, not the treatment itself.',
    'Up to 90 days (can convert to a national visa if treatment exceeds 90 days)',
    'Short-stay Schengen visa (Type C), submitted via VFS Global with biometrics',
    1,
    'Processing depends on the completeness of medical and financial documentation',
    'VFS Global Germany Visa Application Centre, India',
    'Obtain a confirmation letter from the treating German hospital/clinic\nArrange your financing/bank guarantee for the treatment cost\nGather documents against this checklist\nBook your VFS Global appointment and attend biometrics\nSubmission of your application and documents\nCollect your passport from VFS once approved',
    '/assets/images/visa-heroes/germany.jpg',
    'German Federal Foreign Office Schengen Medical Treatment Visa guidance', 'https://www.auswaertiges-amt.de/en/visa-service/215870-215870', '2026-09-11'
);
SET @dt7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dt7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dt7, 'Core Documents', 'Every applicant needs these.', 1);
SET @dt7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dt7s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@dt7s1, 'Passport Photographs', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dt7, 'Medical Documents', 'Evidence of your treatment plan.', 2);
SET @dt7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dt7s2, 'German Hospital/Clinic Confirmation Letter', 'Diagnosis, planned treatment, first appointment date.', 'original', 1, 0, 1, 1),
(@dt7s2, 'Medical Certificate from Home-Country Doctor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dt7, 'Financial Documents', 'Evidence you can pay for treatment.', 3);
SET @dt7s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dt7s3, 'Bank Guarantee or Hospital Prepayment Confirmation', NULL, 'copy', 1, 0, 0, 1),
(@dt7s3, 'Schengen Travel Insurance', 'Minimum EUR 30,000 for complications, not the treatment itself.', 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(119, 7, 90.00, 'EUR', 'Schengen Short-Stay Visa Fee', 'Same base fee as Tourist; converts to a national-visa fee if treatment genuinely exceeds 90 days.', '2026-06-01', NOW(), 'https://www.auswaertiges-amt.de/en/visa-service/215870-215870', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does my Schengen insurance cover the treatment itself?', 'No — the minimum EUR 30,000 Schengen insurance covers complications and emergencies, not the planned treatment cost itself, which must be separately financed or guaranteed.', 119, 7, 908, 1),
('What if my treatment takes longer than 90 days?', 'Your visa can convert to a national (long-stay) visa if treatment genuinely requires a longer stay.', 119, 7, 909, 1),
('What does the hospital confirmation letter need?', 'Your diagnosis, planned treatment, and the first appointment date, issued directly by the treating German hospital or clinic.', 119, 7, 910, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — Schengen Business Visa (conference purpose)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    119, 8, 'DEU-CONF-IN-08', '2026.09', 'published',
    'Attending or presenting at a conference or seminar in Germany.',
    'Treated as a subtype of the Schengen business visa rather than a separate visa product — the conference invitation/registration confirmation and registration-fee proof are the differentiating documents.',
    'Up to 90 days within any 180-day period (Schengen short-stay)',
    'Short-stay Schengen visa (Type C), submitted via VFS Global with biometrics',
    1,
    'Processing typically runs 15 working days, longer in peak season',
    'VFS Global Germany Visa Application Centre, India',
    'Obtain your conference invitation or registration confirmation\nGather documents against this checklist\nBook your VFS Global appointment and attend biometrics\nSubmission of your application and documents\nCollect your passport from VFS once approved',
    '/assets/images/visa-heroes/germany.jpg',
    'German Federal Foreign Office Schengen business visa (conference purpose) guidance', 'https://www.auswaertiges-amt.de/en/visa-service/215870-215870', '2026-09-11'
);
SET @dt8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dt8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dt8, 'Core Documents', 'Every applicant needs these.', 1);
SET @dt8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dt8s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@dt8s1, 'Passport Photographs', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dt8, 'Conference Documents', 'Evidence of the event and your role.', 2);
SET @dt8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dt8s2, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 1),
(@dt8s2, 'Employer Letter from India', 'Confirming purpose and return travel.', 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dt8, 'Financial & Travel Documents', 'Evidence you can support your trip.', 3);
SET @dt8s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dt8s3, 'Bank Statements', 'Last 3 months.', 'copy', 1, 0, 0, 1),
(@dt8s3, 'Schengen Travel Insurance', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(119, 8, 90.00, 'EUR', 'Schengen Short-Stay Visa Fee', 'Same fee as Business — Conference is a business-purpose Schengen visa, not a separate product.', '2026-06-01', NOW(), 'https://www.auswaertiges-amt.de/en/visa-service/215870-215870', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is Conference a separate visa category?', 'No — it is treated as a subtype of the Schengen business visa, using the same application and fee, distinguished only by the conference-specific documents.', 119, 8, 911, 1),
('Do I need proof of registration fee payment?', 'Where applicable, yes — proof of your registration fee payment supports the genuineness of your conference attendance.', 119, 8, 912, 1),
('Can I combine a conference visit with some tourism?', 'The visa purpose should reflect your primary reason for travel — discuss your specific itinerary with us before applying.', 119, 8, 913, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — Schengen Visa (sports/cultural events purpose)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    119, 9, 'DEU-SPORT-IN-09', '2026.09', 'published',
    'Participating in a sporting event or competition in Germany.',
    'No distinct sports-visa category exists — this is handled under the Schengen visa''s "cultural, sports and religious events" purpose. A letter from your national sports federation confirming your role and event participation, plus an explicit guarantee that you will not seek paid employment in Germany, are the key documents.',
    'Up to 90 days within any 180-day period (Schengen short-stay)',
    'Short-stay Schengen visa (Type C), submitted via VFS Global with biometrics',
    1,
    'Processing typically runs 15 working days, longer in peak season',
    'VFS Global Germany Visa Application Centre, India',
    'Obtain a letter from your national sports federation confirming your role and event\nConfirm who bears costs (organizer or applicant)\nGather documents against this checklist\nBook your VFS Global appointment and attend biometrics\nSubmission of your application and documents\nCollect your passport from VFS once approved',
    '/assets/images/visa-heroes/germany.jpg',
    'German Federal Foreign Office Schengen visa (cultural, sports, religious events) guidance', 'https://www.auswaertiges-amt.de/en/visa-service/215870-215870', '2026-09-11'
);
SET @dt9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dt9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dt9, 'Core Documents', 'Every applicant needs these.', 1);
SET @dt9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dt9s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@dt9s1, 'Passport Photographs', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dt9, 'Sports Event Documents', 'Evidence of your role and the event.', 2);
SET @dt9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dt9s2, 'National Sports Federation Letter', 'Confirming your role, event participation, and no-paid-employment guarantee.', 'original', 1, 0, 1, 1),
(@dt9s2, 'Event Invitation/Tickets', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dt9, 'Financial & Travel Documents', 'Evidence you can support your trip.', 3);
SET @dt9s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dt9s3, 'Bank Statements', 'Unless the organizer bears all costs.', 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(119, 9, 90.00, 'EUR', 'Schengen Short-Stay Visa Fee', 'Same fee as Tourist — Sports is a purpose category within the general Schengen visa, not a separate product.', '2026-06-01', NOW(), 'https://www.auswaertiges-amt.de/en/visa-service/215870-215870', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Germany have a distinct Sports Visa?', 'No — it is handled under the Schengen visa''s "cultural, sports and religious events" purpose, not a separate visa category.', 119, 9, 914, 1),
('What must the sports federation letter confirm?', 'Your role, your event participation, and an explicit guarantee that you will not seek paid employment in Germany during your stay.', 119, 9, 915, 1),
('Who typically covers costs for sports event travel?', 'Either the event organizer or the applicant — your application should clearly state which, backed by supporting evidence.', 119, 9, 916, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Family Reunification (Familiennachzug)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    119, 10, 'DEU-DEP-IN-10', '2026.09', 'published',
    'Joining a spouse, registered partner, or parent who holds a German visa or residence permit (Familiennachzug).',
    'German authorities calculate the sponsor''s "secured livelihood" (Existenzsicherung) case-by-case using standard-need rates plus actual rent and insurance costs for the whole household — a real calculation, not one fixed national income figure. Spouses generally also need basic German (A1) language proof, though joining a Blue Card holder or highly qualified worker often waives this.',
    'Matches the validity of the sponsor''s visa/residence permit',
    'National long-stay visa (Type D), increasingly submitted via the digital Consular Services Portal (CSP)',
    1,
    'Processing depends on the sponsor''s status and the household income calculation',
    'VFS Global / German Mission India',
    'Confirm the sponsor''s visa/residence permit status in Germany\nArrange A1 German language proof, if required (check for exemptions)\nGather documents against this checklist, including relationship proof\nSubmit your application via the Consular Services Portal or VFS\nAttend biometrics\nDecision once processed',
    '/assets/images/visa-heroes/germany.jpg',
    'German Federal Foreign Office Family Reunification (Familiennachzug) guidance', 'https://digital.diplo.de/navigator/en/visa/overview/ergebnis-familiennachzug', '2026-09-11'
);
SET @dt10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@dt10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dt10, 'Core Documents', 'Every applicant needs these.', 1);
SET @dt10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dt10s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@dt10s1, 'Sponsor''s Visa/Residence Permit Copy', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dt10, 'Relationship & Language Documents', 'Evidence of your relationship and (where required) German language ability.', 2);
SET @dt10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dt10s2, 'Marriage/Partnership Certificate', NULL, 'copy', 1, 0, 1, 1),
(@dt10s2, 'A1 German Language Certificate', 'Required for most spouses; exemptions apply for some sponsor categories (e.g. Blue Card holders).', 'original', 0, 1, 0, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@dt10, 'Financial Documents', 'Evidence the sponsor meets the household income calculation.', 3);
SET @dt10s3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@dt10s3, 'Sponsor''s Income & Rent Evidence', 'Assessed against Existenzsicherung standard-need rates for the full household.', 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(119, 10, 75.00, 'EUR', 'National Visa Fee', 'The sponsor''s required income is calculated case-by-case (Existenzsicherung), not a fixed national figure, in addition to this application fee.', '2026-09-01', NOW(), 'https://digital.diplo.de/navigator/en/visa/overview/ergebnis-familiennachzug', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('How is the sponsor''s required income calculated?', 'Case-by-case, using standard-need rates (Existenzsicherung) for each household member plus actual rent and health insurance costs — not one fixed national figure.', 119, 10, 917, 1),
('Do I need to prove German language ability?', 'Most spouses do, typically at A1 level, though exemptions apply for some sponsor categories, such as joining an EU Blue Card holder or highly qualified worker.', 119, 10, 918, 1),
('Is this the same fee as the Student Visa?', 'Yes — both are national long-stay visas at EUR 75, distinct from the EUR 90 Schengen short-stay fee.', 119, 10, 919, 1);
