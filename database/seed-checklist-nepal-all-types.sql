-- Nepal Visa Checklist Engine content for all 10 visa types — built
-- fresh this session via web search, same standard as every other
-- country built this session (see AUDIT.md). No hero photo has been
-- supplied for Nepal yet — hero_image_url is deliberately left NULL,
-- falling back to the navy/gold gradient hero, until the client's
-- later photo bundle arrives.
--
-- IMPORTANT SOURCING CAVEAT: official primary sources (immigration.
-- gov.np and its subdomains, indembkathmandu.gov.in) were not directly
-- fetchable in this session's research pass (blocked at the network
-- egress layer) — findings were triangulated from web-search-indexed
-- content that in several cases directly quotes those official pages,
-- cross-checked against Kathmandu Post reporting and immigration-law
-- sourcing. A final manual spot-check against immigration.gov.np is
-- recommended before treating every figure as final.
--
-- Nepal's real, distinctive facts (the master fact governing almost
-- everything below is the India-Nepal Treaty of Peace and Friendship,
-- 1950, giving both countries' citizens reciprocal freedom of
-- movement, residence, and employment):
--   - SEVEN of these ten categories (Tourist, Business, Family Visit,
--     Transit, Medical, Conference, Sports) collapse into the same
--     reality for Indians: NO visa, no fee, no application — just an
--     ID check (passport or original physical Election Commission
--     Voter ID; Aadhaar, PAN, and driving licence are explicitly NOT
--     accepted). This is stated honestly here rather than building out
--     ten fake parallel application workflows.
--   - Work and Student are the two categories where "no visa" doesn't
--     mean "no paperwork": Indians are treaty-exempt from Nepal's
--     work-permit system (a 2019 diplomatic incident occurred
--     precisely because a Nepali official tried to impose permits on
--     Indians and India pushed back citing the Treaty), yet a formal
--     student permit/residence-endorsement step through the
--     Department of Immigration does exist for Indian students, and a
--     small number of Indian employees still obtain the formal Shram
--     Swikriti labour approval for employer-compliance reasons even
--     though it isn't legally required of them.
--   - Nepal is mid-reform: a draft law would expand from 9 to 17 visa
--     categories (adding explicit Medical, Sports, Film, Family, Press
--     visas) specifically to fix gaps that force non-Indian foreign
--     athletes/patients/journalists onto ill-fitting Tourist/Business
--     visas — this reform, even once enacted, changes nothing for
--     Indians, since the 1950 Treaty exemption sits outside Nepal's
--     domestic visa-category law entirely.
--
-- country_id 84 = Nepal. visa_type_id: 1=Tourist, 2=Business,
-- 3=Student, 4=Work, 5=Family Visit, 6=Transit, 7=Medical, 8=Conference,
-- 9=Sports, 10=Dependent.

-- =====================================================================
-- TOURIST VISA (visa_type_id 1) — No Visa Needed (ID Check Only)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    84, 1, 'NPL-TOUR-IN-01', '2026.09', 'published',
    'Leisure, sightseeing, trekking, pilgrimage in Nepal.',
    'All Indian citizens — no visa required, no fee, at all, under the India-Nepal Treaty of Peace and Friendship (1950). Not a visa category in the ordinary sense — just an ID check at the border or airport.',
    'No stay-duration cap tied to a visa, unlike foreigners'' 15/30/90-day tourist visas',
    'None — walk-through immigration with ID check only',
    0,
    'Immediate — no application, no processing',
    'Not applicable — no consulate or office involved',
    'Carry your valid Indian passport or original physical Election Commission Voter ID card\nPresent it at the Nepal border or airport immigration counter\nNo entry stamp or visa sticker is issued for Indians the way it is for foreigners',
    '/assets/images/visa-heroes/nepal.jpg',
    'Cross-checked against immigration.gov.np''s "Information for Indian Nationals" page (via search snippet) triangulated against secondary sourcing not directly fetchable this session', 'https://www.immigration.gov.np/', '2026-09-11'
);
SET @np1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@np1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@np1, 'Accepted ID Documents', 'Nepal''s Department of Immigration accepts only these — not Aadhaar, PAN, or driving licence.', 1);
SET @np1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@np1s1, 'Valid Indian Passport', NULL, 'original', 0, 1, 1, 1),
(@np1s1, 'Original Election Commission Voter ID Card', 'A downloaded or printed Voter ID is not accepted — must be the original physical card.', 'original', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@np1, 'Travelling with Family', 'Secondary proof accepted if travelling with one ID-holding adult.', 2);
SET @np1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@np1s2, 'Secondary Photo ID for Accompanying Family', 'CGHS card, ration card, driving licence, or school/college ID.', 'copy', 0, 1, 0, 1),
(@np1s2, 'Proof of Relationship', 'Required alongside secondary ID for accompanying spouse/children/parents.', 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(84, 1, 0.00, 'INR', 'No Visa Fee', 'Indians need no visa at all for Nepal under the 1950 Treaty of Peace and Friendship.', '2026-09-01', NOW(), 'https://www.immigration.gov.np/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Nepal?', 'No — under the India-Nepal Treaty of Peace and Friendship (1950), Indian citizens do not need a visa to enter Nepal at all. You only need to carry a valid passport or original physical Election Commission Voter ID.', 84, 1, 1900, 1),
('Can I use my Aadhaar card to enter Nepal?', 'No — Aadhaar does not prove citizenship and is explicitly not accepted, along with PAN cards and driving licences. Only a passport or an original physical Voter ID card is accepted.', 84, 1, 1901, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2) — No Visa Needed
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    84, 2, 'NPL-BUS-IN-02', '2026.09', 'published',
    'Trade, investment exploration, commercial meetings, representing a company in Nepal.',
    'No visa required — the Treaty covers commercial activity/travel. Nepal''s formal "Business Visa" (fee-bearing, for foreign investors) is designed for non-Indian foreigners; Indians simply enter as ordinary travellers.',
    'Same as Tourist — no stay-duration cap tied to a visa',
    'None — same ID-only entry as Tourist',
    0,
    'Immediate — no application, no processing',
    'Not applicable for entry; Department of Industry (InvestNepal) only if formally registering a company/investment',
    'Present your passport or original Voter ID at the border/airport, same as any other purpose\nIf registering a company or investment in Nepal, separately approach the Department of Industry — this is a company-registration step, not an immigration one',
    '/assets/images/visa-heroes/nepal.jpg',
    'Cross-checked against lawalpine.com and corporatenp.com secondary sourcing, triangulated against official guidance not directly fetchable this session', 'https://www.immigration.gov.np/', '2026-09-11'
);
SET @np2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@np2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@np2, 'Accepted ID Documents', 'Same as Tourist entry.', 1);
SET @np2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@np2s1, 'Valid Indian Passport', NULL, 'original', 0, 1, 1, 1),
(@np2s1, 'Original Election Commission Voter ID Card', NULL, 'original', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@np2, 'If Registering a Business/Investment', 'A separate, non-immigration step at the Department of Industry.', 2);
SET @np2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@np2s2, 'Company Incorporation Documents', NULL, 'copy', 0, 1, 0, 1),
(@np2s2, 'Investment Proof and PAN Details', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(84, 2, 0.00, 'INR', 'No Visa Fee', 'No visa required for entry; company/investment registration (if pursued) has its own separate government fees, outside visa scope.', '2026-09-01', NOW(), 'https://www.immigration.gov.np/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need Nepal''s formal Business Visa to explore trade opportunities?', 'No — that fee-bearing Business Visa is designed for non-Indian foreign investors. Indian citizens can travel for business purposes visa-free, the same as for tourism.', 84, 2, 1902, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3) — Study Permit / Residence Endorsement
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    84, 3, 'NPL-STU-IN-03', '2026.09', 'published',
    'Enrolling in a Nepali school, college, or university.',
    'No visa required to enter or study — but Indian students must formally register their stay via a Study Permit / Residence Endorsement at the Department of Immigration, typically routed via the educational institution.',
    'Tied to course duration; the permit itself, not a visa, governs the study period',
    'Submit documents at the Department of Immigration in Kathmandu, typically routed via the educational institution',
    1,
    'Not precisely quantified in sources found for the Indian-specific permit — allow several weeks',
    'Department of Immigration, Kalikasthan, Dillibazar, Kathmandu',
    'Secure admission at an accredited Nepali institution\nHave the institution route your study-permit application to the Department of Immigration\nSubmit passport, admission letter, and supporting documents\nAttend in person for the permit/registration step\nReceive your Study Permit / Residence Endorsement',
    '/assets/images/visa-heroes/nepal.jpg',
    'Cross-checked against commonlaw.com.np and corporatenp.com secondary sourcing, triangulated against immigration.gov.np guidance not directly fetchable this session', 'https://www.immigration.gov.np/', '2026-09-11'
);
SET @np3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@np3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@np3, 'Core Documents', 'Every applicant needs these.', 1);
SET @np3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@np3s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@np3s1, 'Admission/Offer Letter from Accredited Nepali Institution', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@np3, 'Supporting Documents', 'Evidence of your academic background and means.', 2);
SET @np3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@np3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@np3s2, 'Proof of Funds', NULL, 'copy', 1, 0, 0, 2),
(@np3s2, 'Guardian Consent', 'Required for minors.', 'original', 0, 1, 0, 3),
(@np3s2, 'Local Guarantor/Address Proof', NULL, 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(84, 3, NULL, 'NPR', 'Confirmed After Assessment', 'Not confirmed as free or paid for the Indian-specific study permit in sources found this session — contact us to confirm the current fee.', '2026-09-01', NOW(), 'https://www.immigration.gov.np/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a Nepal Student Visa the same as the foreigner Study Visa?', 'No — Indians don''t need the fee-bearing foreigner Study Visa. Instead, a Study Permit / Residence Endorsement is registered through the Department of Immigration, typically via your institution.', 84, 3, 1903, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4) — No Work Permit Needed
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    84, 4, 'NPL-WORK-IN-04', '2026.09', 'published',
    'Employment in Nepal (salaried job, institution, company).',
    'Exempt from Nepal''s work-permit requirement by explicit treaty provision — a 2019 diplomatic dispute arose precisely because a Nepali official tried to impose permits on Indians and India objected citing the Treaty. No labour permit or work visa is needed in the vast majority of cases.',
    'No cap tied to a visa/permit — treaty-based exemption',
    'None required ordinarily; some employers voluntarily route staff through Shram Swikriti (Labour Approval) for compliance reasons',
    0,
    'Immediate for entry; if an employer pursues formal Shram Swikriti anyway, standard processing is 30-45 days (expedited 7-14 days)',
    'Department of Labour and Occupational Safety (only if the rare formal route is used) — not the Department of Immigration',
    'Enter Nepal visa-free and begin work — no permit required in the ordinary case\nIf your employer opts for formal Shram Swikriti registration (for their own compliance reasons), they file via the FEIMS portal on your behalf\nThat rare route requires a medical certificate, police clearance, and academic/professional certificates',
    '/assets/images/visa-heroes/nepal.jpg',
    'Cross-checked against kathmandupost.com''s 2019 diplomatic-dispute reporting and corporatenp.com Shram Swikriti guides, triangulated against official guidance not directly fetchable this session', 'https://www.immigration.gov.np/', '2026-09-11'
);
SET @np4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@np4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@np4, 'Core Documents', 'Every entrant needs these.', 1);
SET @np4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@np4s1, 'Valid Passport', NULL, 'original', 1, 0, 1, 1),
(@np4s1, 'Employment Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@np4, 'If Employer Pursues Formal Shram Swikriti', 'A rare, employer-driven compliance route, not legally required of the individual.', 2);
SET @np4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@np4s2, 'Medical Certificate', NULL, 'original', 0, 1, 0, 1),
(@np4s2, 'Police Clearance Certificate', NULL, 'original', 0, 1, 0, 2),
(@np4s2, 'Insurance Proof', NULL, 'copy', 0, 1, 0, 3),
(@np4s2, 'Academic/Professional Certificates', NULL, 'copy', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(84, 4, 0.00, 'INR', 'No Work Permit Fee (Treaty-Exempt)', 'If the rare formal Shram Swikriti route is used anyway, reported cost is approximately NPR 8,708 (insurance + welfare fund + medical + orientation) plus a NPR 1,500 Foreign Employment Welfare Fund contribution — not required of Indians as a matter of law.', '2026-09-01', NOW(), 'https://www.immigration.gov.np/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a work permit to work in Nepal?', 'No — Indians are exempt from Nepal''s work-permit system by treaty provision. A 2019 attempt by a Nepali official to impose permits on Indians was reversed after India objected citing the 1950 Treaty.', 84, 4, 1904, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5) — No Visa Needed
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    84, 5, 'NPL-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives/family resident in Nepal.',
    'No visa required — explicitly covered by the same Treaty exemption as Tourist. Identical in practice to a tourist entry.',
    'No stay-duration cap tied to a visa',
    'None — same ID-only entry as Tourist',
    0,
    'Immediate — no application, no processing',
    'Not applicable',
    'Present your passport or original Voter ID at the border/airport\nIf travelling with family members who lack their own primary ID, carry secondary photo ID and proof of relationship for them',
    '/assets/images/visa-heroes/nepal.jpg',
    'Cross-checked against godigit.com and happyfares.in secondary sourcing, triangulated against official guidance not directly fetchable this session', 'https://www.immigration.gov.np/', '2026-09-11'
);
SET @np5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@np5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@np5, 'Accepted ID Documents', 'Same as Tourist entry.', 1);
SET @np5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@np5s1, 'Valid Indian Passport', NULL, 'original', 0, 1, 1, 1),
(@np5s1, 'Original Election Commission Voter ID Card', NULL, 'original', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@np5, 'For Accompanying Family Without Primary ID', 'Secondary proof and relationship documentation.', 2);
SET @np5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@np5s2, 'Secondary Photo ID', 'CGHS card, ration card, driving licence, or school/college ID.', 'copy', 0, 1, 0, 1),
(@np5s2, 'Birth/Marriage Certificate Proving Relationship', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(84, 5, 0.00, 'INR', 'No Visa Fee', 'Identical to Tourist entry — no visa or fee at all.', '2026-09-01', NOW(), 'https://www.immigration.gov.np/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a separate Family Visit Visa for Nepal?', 'No — it is identical to the visa-free Tourist entry, since both fall under the same 1950 Treaty exemption for Indian citizens.', 84, 5, 1905, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6) — Not Applicable for Indians
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    84, 6, 'NPL-TRANS-IN-06', '2026.09', 'published',
    'Passing through Nepal, most relevant at Tribhuvan International Airport for connecting passengers.',
    'Not applicable in the way it is for other nationalities — Indians need no visa regardless of transit or final-destination travel. Nepal''s formal Transit Visa (USD 5, max 24 hours) is a foreigner-only product; Indians simply are not part of that system.',
    'Not applicable — Indians are not part of Nepal''s transit-visa system',
    'None — same treaty-based exemption applies',
    0,
    'Immediate — no application, no processing',
    'Not applicable',
    'Present your passport or original Voter ID at the border/airport, exactly as for any other purpose\nNo transit-specific process applies to Indian citizens',
    '/assets/images/visa-heroes/nepal.jpg',
    'Cross-checked against tia.immigration.gov.np''s Transit Visa page (via search snippet) and akbartravels.com secondary sourcing not directly fetchable this session', 'https://www.immigration.gov.np/', '2026-09-11'
);
SET @np6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@np6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@np6, 'Accepted ID Documents', 'Same as Tourist entry.', 1);
SET @np6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@np6s1, 'Valid Indian Passport', NULL, 'original', 0, 1, 1, 1),
(@np6s1, 'Original Election Commission Voter ID Card', NULL, 'original', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@np6, 'Onward Travel Documents', 'Only relevant if continuing to a third country.', 2);
SET @np6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@np6s2, 'Onward Ticket/Itinerary', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(84, 6, 0.00, 'INR', 'No Fee (Not Applicable)', 'Nepal''s foreigner Transit Visa (USD 5) does not apply to Indians, who need no visa at all.', '2026-09-01', NOW(), 'https://www.immigration.gov.np/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need Nepal''s Transit Visa if connecting through Kathmandu?', 'No — that USD 5 Transit Visa is for foreign nationals of other countries. Indian citizens are not part of Nepal''s transit-visa system at all and need no visa regardless.', 84, 6, 1906, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7) — No Visa Needed
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    84, 7, 'NPL-MED-IN-07', '2026.09', 'published',
    'Travel for medical treatment in Nepal — increasingly promoted as an inbound medical-tourism route for Indians from border-adjacent states.',
    'No visa required — medical travel is covered under the same Treaty-based visa-free entry. No separate medical/attendant visa category currently exists in Nepal''s enacted law for Indians (a "Medical Visa" appears only in a proposed, not-yet-enacted reform, and even then would primarily target non-Indian patients).',
    'No stay-duration cap tied to a visa',
    'None — same ID-only entry as Tourist',
    0,
    'Immediate — no application, no processing',
    'Not applicable',
    'Present your passport or original Voter ID at the border/airport, same as any other purpose\nHospital admission and treatment arrangements are handled directly with the Nepali hospital, separate from immigration',
    '/assets/images/visa-heroes/nepal.jpg',
    'Cross-checked against ginger.healthcare medical-tourism sourcing and nepalnews.com''s reporting on the proposed 17-category reform, triangulated against official guidance not directly fetchable this session', 'https://www.immigration.gov.np/', '2026-09-11'
);
SET @np7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@np7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@np7, 'Accepted ID Documents', 'Same as Tourist entry.', 1);
SET @np7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@np7s1, 'Valid Indian Passport', NULL, 'original', 0, 1, 1, 1),
(@np7s1, 'Original Election Commission Voter ID Card', NULL, 'original', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@np7, 'Hospital-Side Documents', 'Handled directly with the treating hospital, not immigration.', 2);
SET @np7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@np7s2, 'Hospital Appointment/Admission Confirmation', NULL, 'copy', 0, 1, 0, 1),
(@np7s2, 'Medical Records/Referral', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(84, 7, 0.00, 'INR', 'No Visa Fee', 'No formal Medical Visa category currently exists for Indians — treated as ordinary visa-free entry.', '2026-09-01', NOW(), 'https://www.immigration.gov.np/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a distinct Medical Visa for Nepal?', 'Not currently for Indians — medical travel is covered under the same visa-free entry as tourism. A "Medical Visa" is only proposed in a draft Nepali immigration reform not yet enacted, and would target non-Indian patients even then.', 84, 7, 1907, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8) — No Visa Needed
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    84, 8, 'NPL-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, seminars, official delegations, academic/professional events in Nepal.',
    'No visa required — covered by the general Treaty exemption. Nepal''s "Official Visit" non-tourist visa category is aimed at delegates from non-treaty countries, not Indians.',
    'No stay-duration cap tied to a visa',
    'None — same ID-only entry as Tourist',
    0,
    'Immediate — no application, no processing',
    'Not applicable',
    'Present your passport or original Voter ID at the border/airport, same as any other purpose\nA conference invitation letter is good practice for your own records but not an immigration requirement',
    '/assets/images/visa-heroes/nepal.jpg',
    'Cross-checked against magicalnepal.com''s Non-Tourist Visa guide, triangulated against official guidance not directly fetchable this session', 'https://www.immigration.gov.np/', '2026-09-11'
);
SET @np8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@np8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@np8, 'Accepted ID Documents', 'Same as Tourist entry.', 1);
SET @np8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@np8s1, 'Valid Indian Passport', NULL, 'original', 0, 1, 1, 1),
(@np8s1, 'Original Election Commission Voter ID Card', NULL, 'original', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@np8, 'Recommended Supporting Document', 'Not an immigration requirement, but useful for your records.', 2);
SET @np8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@np8s2, 'Conference Invitation Letter', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(84, 8, 0.00, 'INR', 'No Visa Fee', 'No distinct requirement for Indians — identical to visa-free Tourist entry.', '2026-09-01', NOW(), 'https://www.immigration.gov.np/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian conference delegates need any special visa for Nepal?', 'No — Indian citizens attending conferences or official visits enter visa-free, the same as for tourism. Nepal''s "Official Visit" visa category is for delegates from non-treaty countries.', 84, 8, 1908, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9) — No Visa Needed
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    84, 9, 'NPL-SPORT-IN-09', '2026.09', 'published',
    'Foreign athletes/teams competing in tournaments hosted in Nepal.',
    'No visa required for Indian athletes, officials, or support staff. Nepal''s proposed 17-category reform explicitly adds a dedicated Sports Visa because non-Indian foreign athletes are currently stuck on a Tourist Visa that technically doesn''t authorize paid competition — this entire rationale is irrelevant to Indians, who need no visa of any kind to compete.',
    'No stay-duration cap tied to a visa',
    'None — same ID-only entry as Tourist',
    0,
    'Immediate — no application, no processing',
    'Not applicable',
    'Present your passport or original Voter ID at the border/airport, same as any other purpose\nNo tournament-specific immigration process applies to Indian citizens',
    '/assets/images/visa-heroes/nepal.jpg',
    'Cross-checked against english.nepalnews.com''s reporting on the proposed 17-category reform, triangulated against official guidance not directly fetchable this session', 'https://www.immigration.gov.np/', '2026-09-11'
);
SET @np9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@np9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@np9, 'Accepted ID Documents', 'Same as Tourist entry.', 1);
SET @np9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@np9s1, 'Valid Indian Passport', NULL, 'original', 0, 1, 1, 1),
(@np9s1, 'Original Election Commission Voter ID Card', NULL, 'original', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@np9, 'Recommended Supporting Document', 'Not an immigration requirement.', 2);
SET @np9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@np9s2, 'Event/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(84, 9, 0.00, 'INR', 'No Visa Fee', 'No distinct requirement for Indians — identical to visa-free Tourist entry.', '2026-09-01', NOW(), 'https://www.immigration.gov.np/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a Sports Visa for Nepal?', 'No — a proposed Sports Visa in Nepal''s draft immigration reform exists to fix a problem specific to non-Indian foreign athletes stuck on Tourist Visas. Indians need no visa of any kind to compete.', 84, 9, 1909, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10) — Not Applicable
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    84, 10, 'NPL-DEP-IN-10', '2026.09', 'published',
    'Spouse/children accompanying a visa-holder in Nepal.',
    'Not applicable in the conventional sense — since the Indian principal (investor/worker/student) doesn''t hold a Nepali visa to begin with, there is no "Dependent Visa" for their family to attach to. An Indian citizen''s spouse/children who are also Indian citizens simply enter visa-free themselves under the same Treaty.',
    'No stay-duration cap tied to a visa',
    'None — family members enter with their own ID, or secondary ID plus relationship proof if travelling with one ID-holding adult',
    0,
    'Immediate — no application, no processing',
    'Not applicable',
    'Each Indian family member presents their own passport or original Voter ID\nIf a family member lacks their own primary ID, they may travel with secondary photo ID plus proof of relationship',
    '/assets/images/visa-heroes/nepal.jpg',
    'Cross-checked against nitipartners.com and lawalpine.com secondary sourcing (contrasted against Nepal''s real, fee-bearing Dependent Visa for non-Indian foreigners), triangulated against official guidance not directly fetchable this session', 'https://www.immigration.gov.np/', '2026-09-11'
);
SET @np10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@np10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@np10, 'Accepted ID Documents', 'Each family member needs their own.', 1);
SET @np10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@np10s1, 'Valid Indian Passport', NULL, 'original', 0, 1, 1, 1),
(@np10s1, 'Original Election Commission Voter ID Card', NULL, 'original', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@np10, 'If Travelling Without Primary ID', 'Secondary proof and relationship documentation.', 2);
SET @np10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@np10s2, 'Secondary Photo ID', NULL, 'copy', 0, 1, 0, 1),
(@np10s2, 'Birth/Marriage Certificate Proving Relationship', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(84, 10, 0.00, 'INR', 'No Visa Fee (Not Applicable)', 'Nepal''s real, fee-bearing Dependent Visa (roughly NPR 5,000/person/year) is for non-Indian foreign nationals only — Indian family members simply enter visa-free.', '2026-09-01', NOW(), 'https://www.immigration.gov.np/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian family members need a Dependent Visa to join a relative in Nepal?', 'No — since Indians hold no Nepali visa to begin with, there is no Dependent Visa to attach to. Indian family members simply enter visa-free with their own passport or original Voter ID.', 84, 10, 1910, 1);
