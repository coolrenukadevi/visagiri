-- North Korea (DPRK) Visa Checklist Engine content for all 10 visa
-- types — built fresh this session via web search.
--
-- North Korea's real, distinctive facts verified this session:
--   - Independent travel is not permitted at all. Indian citizens can
--     only enter North Korea on a pre-approved guided tour arranged by
--     an authorized international tour operator — there is no
--     embassy-direct, VOA, or eVisa route.
--   - The "visa" itself is not a traditional visa stamped in the
--     passport — it is a separate government travel-permit approval,
--     issued as a standalone paper visa card (typically collected in
--     Beijing before departure). The passport is not stamped on entry
--     or exit.
--   - Approval typically takes 3-6 weeks through the tour operator.
--   - The US maintains a Level 4 "Do Not Travel" advisory (updated
--     April 2025) for North Korea; entry itself is significantly
--     restricted and in some cases not possible at all, independent
--     of the tour-operator process.
--   - An official, current MEA-specific advisory statement for North
--     Korea was not located in sources reviewed this session — this
--     is flagged as a gap rather than assumed to not exist.
--
-- country_id 85 = North Korea. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    85, 1, 'PRK-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to North Korea (DPRK).',
    'Independent tourist travel is not permitted. Indian citizens may only enter on a pre-approved guided tour arranged by an authorized international tour operator — entry is significantly restricted, and in some cases not possible.',
    'Per approved tour itinerary',
    'Book through an authorized DPRK tour operator, who arranges the travel-permit approval',
    0,
    'The "visa" is a separate paper travel-permit card, not a passport stamp — typically collected in Beijing before departure. Approval takes 3-6 weeks.',
    'No direct embassy application — travel-permit approval is arranged entirely through an authorized tour operator',
    'Research and book with a reputable, authorized DPRK tour operator\nSubmit your passport details and application through the tour operator\nAllow 3-6 weeks for travel-permit approval\nCollect your paper visa card as directed (typically in Beijing)\nFollow all tour-operator guidance strictly throughout your visit',
    '/assets/images/visa-heroes/north-korea.webp',
    'flywelltours.com and akbartravels.com secondary sourcing', 'https://flywelltours.com/visa/north-korea-visa/', '2026-09-19'
);
SET @prk1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@prk1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@prk1, 'Core Documents', 'Required from every applicant.', 1);
SET @prk1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@prk1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@prk1s1, 'Confirmed Authorized Tour Booking', NULL, 'copy', 1, 0, 1, 2),
(@prk1s1, 'Separate Paper Travel-Permit Visa Card', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@prk1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @prk1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@prk1s2, 'Passport-Size Photographs', NULL, 'original', 1, 0, 0, 1),
(@prk1s2, 'Full Tour Itinerary from Operator', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(85, 1, 50.00, 'USD', 'Visa/Travel-Permit Fee (Indicative)', 'Agency sourcing cites a starting figure of USD 50; actual cost is typically bundled into the authorized tour package price.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/northkorea-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian citizens travel to North Korea independently?', 'No — independent travel is not permitted. Entry is only possible on a pre-approved guided tour arranged by an authorized international tour operator.', 85, 1, 8500, 1),
('Does North Korea stamp the passport for entry?', 'No — the visa is issued as a separate paper travel-permit card, typically collected in Beijing before departure. The passport itself is not stamped on entry or exit.', 85, 1, 8501, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    85, 2, 'PRK-BUS-IN-01', '2026.09', 'published',
    'Business meetings and commercial activity in North Korea.',
    'Business travel to North Korea is exceptionally restricted and requires formal sponsorship/invitation coordinated through specialized agencies — not a routine visa process.',
    'Per approved itinerary',
    'Coordinate through a specialized DPRK business-travel agency with formal North Korean sponsor invitation',
    0,
    'Not independently confirmed this session: exact business-visa process — this is a highly specialized, low-volume channel distinct from tourism.',
    'No direct embassy application — arranged through specialized business-travel agencies',
    'Secure a formal invitation from a North Korean sponsoring entity\nEngage a specialized DPRK business-travel agency\nSubmit your passport and application through the agency\nAllow several weeks for approval\nFollow all agency/sponsor guidance strictly throughout your visit',
    '/assets/images/visa-heroes/north-korea.webp',
    'flywelltours.com secondary sourcing', 'https://flywelltours.com/visa/north-korea-visa/', '2026-09-19'
);
SET @prk2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@prk2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@prk2, 'Core Documents', 'Required from every applicant.', 1);
SET @prk2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@prk2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@prk2s1, 'Formal Sponsor Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@prk2, 'Supporting Documents', 'Evidence of your business purpose.', 2);
SET @prk2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@prk2s2, 'Company Documentation', NULL, 'copy', 1, 0, 0, 1),
(@prk2s2, 'Passport-Size Photographs', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(85, 2, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Business-visa fees were not independently confirmed this session — a highly specialized, low-volume process.', '2026-01-01', NOW(), 'https://flywelltours.com/visa/north-korea-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian citizens travel to North Korea for business?', 'Only with a formal invitation from a North Korean sponsoring entity, coordinated through a specialized business-travel agency — not a routine visa process.', 85, 2, 8520, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    85, 3, 'PRK-STU-IN-01', '2026.09', 'published',
    'Academic study at a North Korean educational institution.',
    'Sources reviewed this session found no evidence of a practical student-visa pathway for Indian citizens — North Korea does not maintain an open international education system comparable to other destinations.',
    'Not applicable — no established pathway identified',
    'Not independently confirmed this session — no established application process identified',
    1,
    'Not independently confirmed this session whether any student-visa pathway genuinely exists for Indian citizens — flagged as a significant gap rather than assumed unavailable.',
    'No established consular pathway identified',
    'Verify directly with the Ministry of External Affairs and any DPRK diplomatic contact whether a student pathway exists\nDo not rely on informal or unofficial claims of a student-visa route\nIf a pathway is confirmed, expect an exceptionally lengthy and specialized process\nConsult the MEA travel advisory before pursuing this option',
    '/assets/images/visa-heroes/north-korea.webp',
    'general sourcing gap — no dedicated student-visa pathway identified', 'https://flywelltours.com/visa/north-korea-visa/', '2026-09-19'
);
SET @prk3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@prk3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@prk3, 'Core Documents', 'Not independently confirmed this session.', 1);
SET @prk3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@prk3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@prk3, 'Supporting Documents', 'Not independently confirmed this session.', 2);
SET @prk3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@prk3s2, 'Any Available Admission Documentation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(85, 3, 0.00, 'USD', 'Fee Not Independently Confirmed', 'No established student-visa pathway or fee was identified in sources reviewed this session.', '2026-01-01', NOW(), 'https://flywelltours.com/visa/north-korea-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian students study in North Korea?', 'Not independently confirmed this session — no established, practical student-visa pathway was identified in sources reviewed.', 85, 3, 8530, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    85, 4, 'PRK-WORK-IN-01', '2026.09', 'published',
    'Employment in North Korea.',
    'Sources reviewed this session found no evidence of a practical employment pathway for Indian citizens in North Korea — employment there is exceptionally restricted and largely limited to specific diplomatic/NGO contexts.',
    'Not applicable — no established pathway identified',
    'Not independently confirmed this session — no established application process identified',
    1,
    'Not independently confirmed this session whether any work-visa pathway genuinely exists for ordinary Indian citizens.',
    'No established consular pathway identified',
    'Verify directly with the Ministry of External Affairs whether any employment pathway exists\nDo not rely on informal or unofficial claims of a work-visa route\nConsult the MEA travel advisory before pursuing any employment in North Korea',
    '/assets/images/visa-heroes/north-korea.webp',
    'general sourcing gap — no dedicated work-visa pathway identified', 'https://flywelltours.com/visa/north-korea-visa/', '2026-09-19'
);
SET @prk4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@prk4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@prk4, 'Core Documents', 'Not independently confirmed this session.', 1);
SET @prk4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@prk4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@prk4, 'Supporting Documents', 'Not independently confirmed this session.', 2);
SET @prk4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@prk4s2, 'Any Available Sponsorship Documentation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(85, 4, 0.00, 'USD', 'Fee Not Independently Confirmed', 'No established work-visa pathway or fee was identified in sources reviewed this session.', '2026-01-01', NOW(), 'https://flywelltours.com/visa/north-korea-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian citizens work in North Korea?', 'Not independently confirmed this session — no established, practical work-visa pathway for ordinary employment was identified.', 85, 4, 8540, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    85, 5, 'PRK-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in North Korea.',
    'Given North Korea\'s tightly controlled entry system, even family visits are expected to require the same authorized-tour-operator process as tourism, since independent travel is not permitted.',
    'Per approved tour itinerary',
    'Book through an authorized DPRK tour operator, who arranges the travel-permit approval',
    0,
    'Not independently confirmed this session whether a distinct family-visit process exists outside the standard tour-operator route.',
    'No direct embassy application — travel-permit approval is arranged entirely through an authorized tour operator',
    'Research and book with a reputable, authorized DPRK tour operator\nSubmit your passport details and application through the tour operator\nAllow 3-6 weeks for travel-permit approval\nCollect your paper visa card as directed\nFollow all tour-operator guidance strictly throughout your visit',
    '/assets/images/visa-heroes/north-korea.webp',
    'flywelltours.com secondary sourcing', 'https://flywelltours.com/visa/north-korea-visa/', '2026-09-19'
);
SET @prk5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@prk5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@prk5, 'Core Documents', 'Required from every applicant.', 1);
SET @prk5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@prk5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@prk5s1, 'Confirmed Authorized Tour Booking', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@prk5, 'Supporting Documents', 'Evidence of your travel plans.', 2);
SET @prk5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@prk5s2, 'Proof of Relationship to Family Contact', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(85, 5, 50.00, 'USD', 'Visa/Travel-Permit Fee (Indicative)', 'Same indicative figure as the tourist visa applies; typically bundled into tour package pricing.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/northkorea-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian citizens visit family in North Korea independently?', 'No — independent travel is not permitted for any purpose. Even family visits are expected to route through the authorized-tour-operator process.', 85, 5, 8550, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    85, 6, 'PRK-TRAN-IN-01', '2026.09', 'published',
    'Transit through North Korea en route to another destination.',
    'Given North Korea\'s tightly controlled entry system and the US Level 4 "Do Not Travel" advisory, transit through North Korea should be avoided entirely wherever an alternative routing exists.',
    'Not recommended',
    'Seek alternative routing avoiding North Korea entirely',
    0,
    'Not independently confirmed this session whether any transit option exists — given the severity of restrictions, alternative routing is strongly preferable.',
    'No established consular pathway identified',
    'Seek alternative routing avoiding North Korea entirely\nConsult the current MEA and international travel advisories\nDo not attempt informal or unofficial transit arrangements',
    '/assets/images/visa-heroes/north-korea.webp',
    'traveladvisory.io secondary sourcing', 'https://www.traveladvisory.io/advisory/north-korea', '2026-09-19'
);
SET @prk6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@prk6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@prk6, 'Core Documents', 'Not independently confirmed this session.', 1);
SET @prk6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@prk6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(85, 6, 0.00, 'USD', 'Fee Not Independently Confirmed', 'No established transit pathway was identified — avoid entirely if possible.', '2026-01-01', NOW(), 'https://www.traveladvisory.io/advisory/north-korea', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian citizens transit through North Korea?', 'Strongly not recommended — seek alternative routing avoiding North Korea entirely, given the severity of entry restrictions and travel advisories.', 85, 6, 8560, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    85, 7, 'PRK-MED-IN-01', '2026.09', 'published',
    'Medical treatment in North Korea.',
    'North Korea is not a recognized destination for inbound medical travel; no evidence of a practical medical-visa pathway for Indian citizens was found in sources reviewed this session.',
    'Not applicable — no established pathway identified',
    'Not independently confirmed this session — no established application process identified',
    1,
    'Not independently confirmed this session; this is not a recommended destination for medical travel.',
    'No established consular pathway identified',
    'Verify directly with the Ministry of External Affairs whether any medical-travel pathway exists\nConsult the current MEA travel advisory before considering this option',
    '/assets/images/visa-heroes/north-korea.webp',
    'general sourcing gap — no dedicated medical-visa pathway identified', 'https://flywelltours.com/visa/north-korea-visa/', '2026-09-19'
);
SET @prk7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@prk7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@prk7, 'Core Documents', 'Not independently confirmed this session.', 1);
SET @prk7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@prk7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(85, 7, 0.00, 'USD', 'Fee Not Independently Confirmed', 'No established medical-visa pathway or fee was identified in sources reviewed this session.', '2026-01-01', NOW(), 'https://flywelltours.com/visa/north-korea-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for North Korea?', 'Not applicable — North Korea is not a recognized destination for inbound medical travel; no practical pathway was identified.', 85, 7, 8570, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    85, 8, 'PRK-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in North Korea.',
    'Any conference attendance would need to route through an authorized tour operator or specialized business-travel agency with formal sponsor invitation, similar to business travel.',
    'Per approved itinerary',
    'Coordinate through a specialized DPRK business-travel agency with formal North Korean sponsor invitation',
    0,
    'Not independently confirmed this session: exact conference-visa process — a highly specialized, low-volume channel.',
    'No direct embassy application — arranged through specialized business-travel agencies',
    'Secure a formal invitation from a North Korean sponsoring/hosting entity\nEngage a specialized DPRK business-travel agency\nSubmit your passport and application through the agency\nAllow several weeks for approval\nFollow all agency/sponsor guidance strictly throughout your visit',
    '/assets/images/visa-heroes/north-korea.webp',
    'flywelltours.com secondary sourcing', 'https://flywelltours.com/visa/north-korea-visa/', '2026-09-19'
);
SET @prk8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@prk8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@prk8, 'Core Documents', 'Required from every applicant.', 1);
SET @prk8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@prk8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@prk8s1, 'Formal Sponsor/Host Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@prk8, 'Supporting Documents', 'Evidence of your conference purpose.', 2);
SET @prk8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@prk8s2, 'Conference Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(85, 8, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Conference-visa fees were not independently confirmed this session.', '2026-01-01', NOW(), 'https://flywelltours.com/visa/north-korea-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian citizens attend conferences in North Korea?', 'Only with a formal sponsor/host invitation, coordinated through a specialized business-travel agency — not a routine visa process.', 85, 8, 8580, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    85, 9, 'PRK-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in North Korea.',
    'Any sports-related visit would route through the authorized-tour-operator process, similar to tourism, given the tightly controlled entry system.',
    'Per approved tour itinerary',
    'Book through an authorized DPRK tour operator, who arranges the travel-permit approval',
    0,
    'Not independently confirmed this session: any dedicated sports-event provisions.',
    'No direct embassy application — travel-permit approval is arranged entirely through an authorized tour operator',
    'Research and book with a reputable, authorized DPRK tour operator\nConfirm the specific event is included in an approved itinerary\nSubmit your passport details and application through the tour operator\nAllow 3-6 weeks for travel-permit approval\nFollow all tour-operator guidance strictly throughout your visit',
    '/assets/images/visa-heroes/north-korea.webp',
    'flywelltours.com secondary sourcing', 'https://flywelltours.com/visa/north-korea-visa/', '2026-09-19'
);
SET @prk9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@prk9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@prk9, 'Core Documents', 'Required from every applicant.', 1);
SET @prk9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@prk9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@prk9s1, 'Confirmed Authorized Tour Booking', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@prk9, 'Supporting Documents', 'Evidence of your event participation.', 2);
SET @prk9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@prk9s2, 'Event Participation Confirmation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(85, 9, 50.00, 'USD', 'Visa/Travel-Permit Fee (Indicative)', 'Same indicative figure as the tourist visa applies; typically bundled into tour package pricing.', '2026-01-01', NOW(), 'https://www.akbartravels.com/visa/northkorea-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can Indian athletes attend sporting events in North Korea?', 'Only through the authorized-tour-operator process, with the specific event confirmed as part of an approved itinerary.', 85, 9, 8590, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    85, 10, 'PRK-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent with an established presence in North Korea.',
    'Given the absence of an established work/employment pathway for ordinary Indian citizens, a dependent-visa pathway was not identified in sources reviewed this session.',
    'Not applicable — no established pathway identified',
    'Not independently confirmed this session — no established application process identified',
    1,
    'Not independently confirmed this session whether any dependant pathway genuinely exists.',
    'No established consular pathway identified',
    'Verify directly with the Ministry of External Affairs whether any dependant pathway exists\nDo not rely on informal or unofficial claims of a dependant-visa route\nConsult the MEA travel advisory before pursuing this option',
    '/assets/images/visa-heroes/north-korea.webp',
    'general sourcing gap — no dedicated dependant-visa pathway identified', 'https://flywelltours.com/visa/north-korea-visa/', '2026-09-19'
);
SET @prk10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@prk10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@prk10, 'Core Documents', 'Not independently confirmed this session.', 1);
SET @prk10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@prk10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(85, 10, 0.00, 'USD', 'Fee Not Independently Confirmed', 'No established dependant-visa pathway or fee was identified in sources reviewed this session.', '2026-01-01', NOW(), 'https://flywelltours.com/visa/north-korea-visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can dependants accompany a permit holder to North Korea?', 'Not independently confirmed this session — no established, practical dependant-visa pathway was identified given the absence of an ordinary employment route.', 85, 10, 8500, 1);
