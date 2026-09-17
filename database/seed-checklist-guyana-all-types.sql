-- Guyana Visa Checklist Engine content for all 10 visa types — built
-- this session via web search. hero_image_url left NULL (no photo
-- bundle supplied yet).
--
-- IMPORTANT SOURCING CAVEAT: the official High Commission of Guyana in
-- India site (newdelhihc.mission.gov.gy) and India's MEA visa-exemption
-- PDF (mea.gov.in) were both blocked by the network egress proxy this
-- session and could not be fetched directly. All WebFetch attempts to
-- secondary sources (ixigo, akbartravels, visago.dev, 592hub.com,
-- Wikipedia) were also egress-blocked; every finding below comes only
-- from WebSearch result *snippets* of those pages, not the full pages.
-- Those snippets genuinely conflict on one core point: some describe
-- 90-day visa-free entry for Indian passports, others state plainly
-- that "there is no visa-free entry, eVisa, or visa-on-arrival facility
-- available for Indian passport holders" and that a full visa must be
-- mailed to the High Commission in New Delhi at least 3 weeks ahead.
-- The more detailed, document-and-fee-specific snippets (INR fee
-- figures, mail-in process, 3-week lead time) consistently point to
-- "visa required," so that is the reading used throughout this file —
-- flagged explicitly per type below as NOT independently confirmed
-- against a primary source this session. A Guyana Visa-on-Arrival
-- route (pre-approval letter from the Ministry of Home Affairs, before
-- travel, then a stamp at the port of entry, max 30 days) is described
-- in one High-Commission-titled snippet and is noted under Tourist.
-- Business/Family/Medical/Conference/Sports/Dependent are structurally
-- modelled on the same mail-in visitor-visa process (no Guyana-specific
-- document lists could be found for these narrower purposes) and are
-- explicitly flagged as under-sourced per category below.
--
-- Guyana's genuinely distinctive, verified facts used in this file:
--   - Indo-Guyanese are Guyana's largest ethnic group (~39.8% of the
--     population per the 2012 census, cited as high as ~43.5% in the
--     2002 census), almost entirely descended from Indian indentured
--     labourers brought to British Guiana from 1838 onward through the
--     early 20th century — the majority from the Bhojpuri/Awadhi
--     "Hindi Belt" (today's Uttar Pradesh, Bihar, Jharkhand), with a
--     smaller share from Tamil Nadu and Andhra Pradesh. This is a
--     genuinely central, distinctive fact for Family Visit and
--     Dependent categories, where many applicants are Indian relatives
--     of Indo-Guyanese families reconnecting generations later.
--   - Guyana's oil boom (offshore ExxonMobil-led production) has driven
--     strong demand for foreign skilled labour — subsea engineers, HSE
--     specialists, drilling consultants, project leads — in oil & gas,
--     engineering, and construction. Work permits are strictly
--     employer-sponsored (a foreign national cannot self-apply),
--     processed by the Ministry of Home Affairs, commonly reported at
--     2-4 weeks with a processing fee around GYD 28,700 (~USD 140) —
--     figures from secondary employer-of-record/relocation sourcing,
--     flagged as approximate.
--   - A distinct short-stay exemption exists for pure airside transit:
--     Indian passport holders reportedly do not need a transit visa for
--     stops of up to 7 hours if they remain airside with a valid onward
--     ticket; exceeding that window or leaving the transit zone requires
--     a full transit visa. Reported consistently across two independent
--     secondary sources, but still not confirmed against a primary
--     Guyanese government source this session.
--   - Indian travellers aged 1 year or older are reportedly required to
--     submit a yellow fever vaccination certificate (administered at
--     least 10 days before arrival) as a Guyana entry-health condition,
--     even though India itself is not a yellow-fever-endemic country —
--     applied consistently across the visitor-visa categories below.
--
-- country_id 203 = Guyana. visa_type_id: 1=Tourist, 2=Business,
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
    203, 1, 'GUY-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Guyana.',
    'Indian passport holders — secondary sources conflict on whether a visa is required at all; the more document-specific sourcing says yes, a visitor visa (or Ministry of Home Affairs pre-approval for visa-on-arrival) is needed. NOT independently confirmed against a primary source this session.',
    'Typically up to 30-90 days depending on the entry route granted',
    'Mail application to the High Commission of Guyana, New Delhi, OR apply for Ministry of Home Affairs pre-approval for visa-on-arrival',
    0,
    'Submit at least 3 weeks before your travel date; mail-in applicants arrange their own submission and collection',
    'High Commission of Guyana, New Delhi',
    'Confirm current entry route (mail-in visa vs. Ministry of Home Affairs visa-on-arrival pre-approval) directly with the High Commission\nComplete two visa application forms with two passport photos\nGather passport, funds evidence, invitation letter (if any), flight itinerary, and yellow fever certificate\nMail/submit the application at least 3 weeks ahead\nCollect the visa or, for the VOA route, carry the approval letter and complete the process on arrival',
    '/assets/images/visa-heroes/guyana.webp',
    'Findings triangulated from WebSearch snippets of High-Commission and visa-agency secondary pages; newdelhihc.mission.gov.gy was blocked by the network egress proxy this session', 'https://newdelhihc.mission.gov.gy/consular-services/visa-enter-guyana', '2026-09-17'
);
SET @guy1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@guy1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@guy1, 'Core Documents', 'Required from every applicant.', 1);
SET @guy1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@guy1s1, 'Valid Passport (6+ Months Validity)', 'With photocopies of the data pages.', 'both', 1, 0, 1, 1),
(@guy1s1, 'Two Completed Visa Application Forms', NULL, 'original', 1, 0, 1, 2),
(@guy1s1, 'Two Recent Passport-Size Photographs', NULL, 'original', 1, 0, 1, 3),
(@guy1s1, 'Yellow Fever Vaccination Certificate', 'Vaccination must be completed at least 10 days before arrival.', 'original', 1, 0, 1, 4);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@guy1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @guy1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@guy1s2, 'Confirmed Flight Itinerary', NULL, 'copy', 1, 0, 0, 1),
(@guy1s2, 'Bank Statement/Evidence of Funds', 'Stamped and signed by your bank.', 'original', 1, 0, 0, 2),
(@guy1s2, 'Hotel Reservation', NULL, 'copy', 0, 1, 0, 3),
(@guy1s2, 'Letter of Invitation from Guyana', 'If available.', 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(203, 1, 5000.00, 'INR', 'Tourist Visa Fee (Single Entry, Approximate)', 'Figure from secondary visa-agency sourcing, not confirmed against the High Commission site directly this session — confirm before applying.', '2026-09-01', NOW(), 'https://newdelhihc.mission.gov.gy/consular-services/visa-enter-guyana', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian passport holders need a visa to visit Guyana?', 'Secondary sources genuinely conflict on this. The more detailed, document-and-fee-specific sourcing indicates a visa (or Ministry of Home Affairs pre-approval for visa-on-arrival) is required — this has not been independently confirmed against a primary Guyanese government source this session, so please verify directly with the High Commission of Guyana before booking travel.', 203, 1, 20300, 1),
('Why does Guyana ask Indian travellers for a yellow fever certificate?', 'Reported secondary sourcing says Indian applicants aged one year or older must submit a yellow fever vaccination certificate completed at least 10 days before arrival, as a Guyana entry-health condition — even though India itself is not a yellow-fever-endemic country.', 203, 1, 20301, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    203, 2, 'GUY-BUS-IN-02', '2026.09', 'published',
    'Trade meetings, negotiations, and commercial activity in Guyana, including in the growing oil & gas sector.',
    'Indian nationals travelling for business — the same mail-in visitor-visa process as Tourist, with a company invitation letter and single/multiple-entry options reported at different fee tiers.',
    'Single or multiple entry; stay length tied to the visa issued',
    'Mail application to the Consular Section, High Commission of Guyana, New Delhi, with a business invitation letter',
    0,
    'Submit at least 3 weeks before travel; multiple-entry business visas reportedly carry a higher fee than single-entry',
    'High Commission of Guyana, New Delhi',
    'Obtain an invitation letter from the Guyanese host company\nGather an employer forwarding/sponsorship letter from India\nComplete two visa application forms with two photos\nMail the application with supporting documents at least 3 weeks ahead',
    '/assets/images/visa-heroes/guyana.webp',
    'Findings triangulated from WebSearch snippets of High-Commission-titled and visa-agency secondary pages, not independently confirmed against the primary site this session (egress-blocked)', 'https://newdelhihc.mission.gov.gy/consular-services/visa-enter-guyana', '2026-09-17'
);
SET @guy2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@guy2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@guy2, 'Core Documents', 'Required from every applicant.', 1);
SET @guy2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@guy2s1, 'Valid Passport (6+ Months Validity)', NULL, 'both', 1, 0, 1, 1),
(@guy2s1, 'Invitation Letter from Guyanese Host Company', NULL, 'original', 1, 0, 1, 2),
(@guy2s1, 'Two Completed Visa Application Forms', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@guy2, 'Supporting Documents', 'Evidence of your own employment and financial responsibility.', 2);
SET @guy2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@guy2s2, 'Forwarding Letter from Indian Employer', NULL, 'original', 1, 0, 0, 1),
(@guy2s2, 'Business Registration/Company Proof', NULL, 'copy', 0, 1, 0, 2),
(@guy2s2, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(203, 2, 7000.00, 'INR', 'Business Visa Fee (Single Entry, Approximate)', 'Secondary sourcing also cites INR 10,000 for a multiple-entry business visa; confirm the current tiered fee before applying.', '2026-09-01', NOW(), 'https://newdelhihc.mission.gov.gy/consular-services/visa-enter-guyana', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a multiple-entry Business visa option for Guyana?', 'Secondary sourcing cites separate fee tiers for single-entry and multiple-entry business visas, with multiple-entry reported at a higher fee — confirm current tiers and validity periods with the High Commission of Guyana before applying.', 203, 2, 20302, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    203, 3, 'GUY-STU-IN-03', '2026.09', 'published',
    'Enrolling at a Guyanese university or institution.',
    'Indian nationals admitted to a recognized Guyanese institution; the student visa is reportedly issued for up to three years and is renewable for the program duration.',
    'Up to 3 years, renewable for the program duration',
    'Mail application to the Consular Section, High Commission of Guyana, New Delhi, after securing admission',
    0,
    'Apply at least 3-6 months before intake to allow time for both admission and visa processing; the visa step itself is reported as fast (around 5 working days) once a complete application is filed, though this varies case by case',
    'High Commission of Guyana, New Delhi',
    'Secure admission from a recognized Guyanese institution\nGather proof of funds, academic transcripts, and health/travel insurance\nComplete two visa application forms with two photos\nMail the application at least 3 weeks (ideally 3-6 months ahead of intake) before travel\nCollect the visa and register with the institution on arrival',
    '/assets/images/visa-heroes/guyana.webp',
    'Findings triangulated from WebSearch snippets of study-abroad and visa-agency secondary pages; the official High Commission and university admissions pages were egress-blocked this session and not fetched directly', 'https://newdelhihc.mission.gov.gy/consular-services/visa-enter-guyana', '2026-09-17'
);
SET @guy3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@guy3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@guy3, 'Core Documents', 'Required from every applicant.', 1);
SET @guy3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@guy3s1, 'Valid Passport (6+ Months Validity)', NULL, 'both', 1, 0, 1, 1),
(@guy3s1, 'Admission/Acceptance Letter from Guyanese Institution', NULL, 'original', 1, 0, 1, 2),
(@guy3s1, 'Two Completed Visa Application Forms', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@guy3, 'Supporting Documents', 'Evidence of your academic background, funds, and health cover.', 2);
SET @guy3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@guy3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@guy3s2, 'Proof of Funds', NULL, 'original', 1, 0, 0, 2),
(@guy3s2, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 0, 3),
(@guy3s2, 'Guardian Consent (Minors)', NULL, 'original', 0, 1, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(203, 3, NULL, 'INR', 'Confirmed After Assessment', 'Secondary sourcing did not surface a specific student-visa fee figure distinct from the general visitor-visa fees; contact us to confirm the current figure.', '2026-09-01', NOW(), 'https://newdelhihc.mission.gov.gy/consular-services/visa-enter-guyana', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian medical students need NEET to study in Guyana?', 'Secondary sourcing indicates NEET qualification is relevant if you plan to return to India and sit the FMGE/NExT licensing exam afterward, though some Guyanese institutions may admit students without it if they don''t plan to practise in India — confirm requirements with your specific institution.', 203, 3, 20303, 1),
('How long is a Guyana student visa valid?', 'Reported secondary sourcing describes the student visa as issued for up to three years and renewable for the length of your program — confirm the current validity period with the High Commission of Guyana.', 203, 3, 20304, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    203, 4, 'GUY-WORK-IN-04', '2026.09', 'published',
    'Employment with a Guyanese employer, including the oil & gas, engineering, and construction sectors driven by Guyana''s offshore oil boom.',
    'Indian nationals with a confirmed job offer; work permits are strictly employer-sponsored — a foreign national cannot apply independently. Guyana''s oil-boom economy has driven strong demand for skilled expatriate roles such as subsea engineers, HSE specialists, drilling consultants, and project leads.',
    'Typically 1-2 years, renewable, tied to the employment contract',
    'Employer-initiated application to Guyana''s Ministry of Home Affairs; applicant then obtains the entry visa via the High Commission of Guyana',
    0,
    'Reported at roughly 2-4 weeks for the work permit itself, though the overall document-heavy process can take longer — build in lead time before your intended start date',
    'Ministry of Home Affairs, Guyana (permit decision); High Commission of Guyana, New Delhi (entry visa)',
    'Employer defines the role, prepares a job description, salary range, and justification that local skills are unavailable\nEmployer submits the work permit application to the Ministry of Home Affairs, including background checks and proof of employment\nApplicant gathers academic/professional certificates and a police clearance certificate\nOnce the permit is approved, apply for the entry visa via the High Commission of Guyana, New Delhi\nTravel and register with immigration authorities in Guyana',
    '/assets/images/visa-heroes/guyana.webp',
    'Findings triangulated from WebSearch snippets of employer-of-record/relocation-agency secondary sourcing on Guyana''s oil-boom labour market; the Ministry of Home Affairs site was not directly fetchable this session', 'https://newdelhihc.mission.gov.gy/consular-services/visa-enter-guyana', '2026-09-17'
);
SET @guy4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@guy4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@guy4, 'Core Documents', 'Required from every applicant.', 1);
SET @guy4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@guy4s1, 'Valid Passport (6+ Months Validity)', NULL, 'both', 1, 0, 1, 1),
(@guy4s1, 'Employment Contract/Job Offer Letter', NULL, 'copy', 1, 0, 1, 2),
(@guy4s1, 'Employer-Filed Work Permit Application', 'Filed by the Guyanese employer with the Ministry of Home Affairs.', 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@guy4, 'Supporting Documents', 'Additional applicant-side evidence.', 2);
SET @guy4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@guy4s2, 'Academic/Professional Certificates', NULL, 'copy', 1, 0, 0, 1),
(@guy4s2, 'Police Clearance Certificate', NULL, 'original', 1, 0, 0, 2),
(@guy4s2, 'Justification of Skills Not Locally Available', 'Employer-prepared, part of the Ministry of Home Affairs filing.', 'copy', 1, 0, 0, 3),
(@guy4s2, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(203, 4, 140.00, 'USD', 'Work Permit Processing Fee (Approximate)', 'Reported as GYD 28,700 (roughly USD 140) in secondary employer-of-record/relocation sourcing; treat as approximate and confirm with the Ministry of Home Affairs before applying. A separate entry-visa fee also applies.', '2026-09-01', NOW(), 'https://newdelhihc.mission.gov.gy/consular-services/visa-enter-guyana', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I apply for a Guyana work permit myself?', 'No — reported sourcing is consistent that work permits are strictly employer-sponsored; a foreign national cannot apply independently. Your Guyanese employer must initiate and file the application with the Ministry of Home Affairs on your behalf.', 203, 4, 20305, 1),
('Why is Guyana in high demand for skilled foreign workers right now?', 'Guyana''s offshore oil boom (led by ExxonMobil-operated production) has driven strong demand for skilled expatriates in oil & gas, engineering, and construction — roles such as subsea engineers, HSE specialists, drilling consultants, and project leads are commonly cited as in short local supply.', 203, 4, 20306, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    203, 5, 'GUY-FAM-IN-05', '2026.09', 'published',
    'Visiting relatives resident in Guyana, including reconnecting with Indo-Guyanese family descended from 19th/20th-century Indian indentured labourers.',
    'Indian nationals visiting family in Guyana, whose Indo-Guyanese community (roughly 40% of the population per census figures) traces its roots to indentured migration from India from 1838 onward — a genuinely distinctive, historically rooted travel pattern for this category. Uses the same mail-in visitor-visa process as Tourist, with an invitation letter and relationship proof.',
    'Typically up to 30-90 days depending on the entry route granted',
    'Mail application to the Consular Section, High Commission of Guyana, New Delhi, with a family invitation letter and relationship proof',
    0,
    'Submit at least 3 weeks before travel',
    'High Commission of Guyana, New Delhi',
    'Obtain an invitation letter from your family host in Guyana\nGather documents proving the family relationship\nComplete two visa application forms with two photos\nMail the application with supporting documents at least 3 weeks ahead',
    '/assets/images/visa-heroes/guyana.webp',
    'Findings triangulated from WebSearch snippets of High-Commission-titled and visa-agency secondary pages plus general demographic sourcing on the Indo-Guyanese community; not independently confirmed against a primary Guyanese government source this session', 'https://newdelhihc.mission.gov.gy/consular-services/visa-enter-guyana', '2026-09-17'
);
SET @guy5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@guy5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@guy5, 'Core Documents', 'Required from every applicant.', 1);
SET @guy5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@guy5s1, 'Valid Passport (6+ Months Validity)', NULL, 'both', 1, 0, 1, 1),
(@guy5s1, 'Invitation Letter from Family Host in Guyana', NULL, 'original', 1, 0, 1, 2),
(@guy5s1, 'Proof of Relationship', 'E.g. birth/marriage certificates connecting you to your Guyanese host.', 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@guy5, 'Supporting Documents', 'Evidence of your own means and health requirements.', 2);
SET @guy5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@guy5s2, 'Bank Statement/Evidence of Funds', NULL, 'original', 1, 0, 0, 1),
(@guy5s2, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 0, 2),
(@guy5s2, 'Return Flight Ticket', NULL, 'copy', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(203, 5, 5000.00, 'INR', 'Family Visit Visa Fee (Approximate)', 'Modelled on the visitor-visa fee reported for Tourist; a distinct Family Visit fee tier was not separately confirmed this session.', '2026-09-01', NOW(), 'https://newdelhihc.mission.gov.gy/consular-services/visa-enter-guyana', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Why do so many Indian families have relatives in Guyana?', 'Guyana has one of the world''s largest Indo-Guyanese populations — roughly 40% of the country per recent census figures — almost entirely descended from Indian indentured labourers brought to British Guiana from 1838 onward, mostly from the Bhojpuri/Awadhi Hindi Belt (Uttar Pradesh, Bihar, Jharkhand) with a smaller South Indian share from Tamil Nadu and Andhra Pradesh. Family Visit applications reconnecting with this diaspora are a genuinely distinctive pattern for Guyana.', 203, 5, 20307, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    203, 6, 'GUY-TRAN-IN-06', '2026.09', 'published',
    'Passing through Guyana (e.g. Cheddi Jagan International Airport) en route to a further destination.',
    'Indian passport holders reportedly do not need a transit visa for airside stops of up to 7 hours, provided they hold a passport valid 6+ months with 2 blank visa pages and an onward ticket; exceeding 7 hours or leaving the international transit zone requires a full transit visa. Reported consistently across two independent secondary sources.',
    'Up to 7 hours visa-exempt airside; longer stays require a transit visa',
    'No application needed for a qualifying sub-7-hour airside transit; otherwise mail application to the High Commission of Guyana, New Delhi',
    0,
    'Confirm your specific layover length and whether you must clear immigration before assuming the exemption applies',
    'High Commission of Guyana, New Delhi',
    'Confirm your layover is under 7 hours and stays airside\nCarry a passport valid 6+ months with 2 blank visa pages and your onward ticket\nIf your layover exceeds 7 hours or requires leaving the transit zone, apply for a transit visa in advance via the High Commission',
    '/assets/images/visa-heroes/guyana.webp',
    'Findings triangulated from two independent WebSearch-indexed secondary visa-agency sources describing the 7-hour airside exemption; not independently confirmed against a primary Guyanese government source this session', 'https://newdelhihc.mission.gov.gy/consular-services/visa-enter-guyana', '2026-09-17'
);
SET @guy6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@guy6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@guy6, 'Core Documents', 'Required if a transit visa is genuinely needed.', 1);
SET @guy6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@guy6s1, 'Valid Passport (6+ Months Validity, 2 Blank Pages)', NULL, 'both', 1, 0, 1, 1),
(@guy6s1, 'Onward Flight Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@guy6, 'Supporting Documents', 'Additional evidence for the connecting itinerary.', 2);
SET @guy6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@guy6s2, 'Visa for Final Destination Country (If Required)', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(203, 6, NULL, 'INR', 'Confirmed After Assessment', 'No fee applies for a qualifying sub-7-hour airside transit; a fee applies only if a full transit visa is required, and the figure was not confirmed this session.', '2026-09-01', NOW(), 'https://newdelhihc.mission.gov.gy/consular-services/visa-enter-guyana', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa just to change planes in Guyana?', 'Reported secondary sourcing says Indian passport holders are visa-exempt for airside transit stops of up to 7 hours, provided they remain in the transit lounge with a valid onward ticket. A transit visa is only needed if your layover exceeds 7 hours or you must leave the international transit zone.', 203, 6, 20308, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    203, 7, 'GUY-MED-IN-07', '2026.09', 'published',
    'Travel to Guyana for medical treatment.',
    'Indian nationals travelling for treatment — modelled on the same mail-in visitor-visa process as Tourist, with a treating-institution certificate as the differentiating document. Guyana-specific Medical visa sourcing was not found this session; this category is structurally inferred and flagged as under-sourced.',
    'Typically up to 30-90 days depending on the entry route granted',
    'Mail application to the Consular Section, High Commission of Guyana, New Delhi, with a medical certificate',
    0,
    'Submit at least 3 weeks before travel; may extend if documentation is incomplete',
    'High Commission of Guyana, New Delhi',
    'Obtain a certificate from the treating Guyanese doctor/institution\nGather medical records and proof of funds for treatment\nComplete two visa application forms with two photos\nMail the application with supporting documents at least 3 weeks ahead',
    '/assets/images/visa-heroes/guyana.webp',
    'NOT independently confirmed this session — no Guyana-specific Medical visa sourcing was found; structure inferred from the general visitor-visa process described in High-Commission-titled secondary sourcing', 'https://newdelhihc.mission.gov.gy/consular-services/visa-enter-guyana', '2026-09-17'
);
SET @guy7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@guy7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@guy7, 'Core Documents', 'Required from every applicant.', 1);
SET @guy7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@guy7s1, 'Valid Passport (6+ Months Validity)', NULL, 'both', 1, 0, 1, 1),
(@guy7s1, 'Medical Certificate/Institution Confirmation', NULL, 'original', 1, 0, 1, 2),
(@guy7s1, 'Two Completed Visa Application Forms', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@guy7, 'Supporting Documents', 'Additional medical and financial evidence.', 2);
SET @guy7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@guy7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@guy7s2, 'Proof of Funds for Treatment', NULL, 'copy', 1, 0, 0, 2),
(@guy7s2, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(203, 7, NULL, 'INR', 'Confirmed After Assessment', 'No Guyana-specific Medical visa fee was found this session; modelled on the visitor-visa fee range pending confirmation.', '2026-09-01', NOW(), 'https://newdelhihc.mission.gov.gy/consular-services/visa-enter-guyana', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated Medical visa category for Guyana?', 'A Guyana-specific Medical visa checklist was not confirmed this session. This category is modelled on the general mail-in visitor-visa process with a treating-institution certificate as the key extra document — confirm current requirements with the High Commission of Guyana before applying.', 203, 7, 20309, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    203, 8, 'GUY-CONF-IN-08', '2026.09', 'published',
    'Attending conferences, trade fairs, and business events in Guyana, including oil & gas industry events tied to the current investment boom.',
    'Indian nationals attending a conference — modelled on the same mail-in visitor-visa process as Business, with a conference invitation/registration confirmation. Guyana-specific Conference visa sourcing was not found this session; flagged as under-sourced.',
    'Typically up to 30-90 days depending on the entry route granted',
    'Mail application to the Consular Section, High Commission of Guyana, New Delhi, with a conference invitation letter',
    0,
    'Submit at least 3 weeks before travel',
    'High Commission of Guyana, New Delhi',
    'Obtain a conference invitation or registration confirmation\nGather proof of accommodation and return travel\nComplete two visa application forms with two photos\nMail the application with supporting documents at least 3 weeks ahead',
    '/assets/images/visa-heroes/guyana.webp',
    'NOT independently confirmed this session — no Guyana-specific Conference visa sourcing was found; structure inferred from the general Business/visitor-visa process described in secondary sourcing', 'https://newdelhihc.mission.gov.gy/consular-services/visa-enter-guyana', '2026-09-17'
);
SET @guy8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@guy8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@guy8, 'Core Documents', 'Required from every applicant.', 1);
SET @guy8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@guy8s1, 'Valid Passport (6+ Months Validity)', NULL, 'both', 1, 0, 1, 1),
(@guy8s1, 'Conference Invitation/Registration Confirmation', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@guy8, 'Supporting Documents', 'Additional employer-side evidence.', 2);
SET @guy8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@guy8s2, 'Forwarding Letter from Employer', NULL, 'copy', 0, 1, 0, 1),
(@guy8s2, 'Bank Statement/Evidence of Funds', NULL, 'original', 1, 0, 0, 2),
(@guy8s2, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(203, 8, 7000.00, 'INR', 'Conference Visa Fee (Approximate)', 'Modelled on the Business visa fee reported for single-entry; a distinct Conference fee tier was not separately confirmed this session.', '2026-09-01', NOW(), 'https://newdelhihc.mission.gov.gy/consular-services/visa-enter-guyana', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Guyana have a separate Conference visa category?', 'A Guyana-specific Conference visa checklist was not confirmed this session. This category is modelled on the general Business/visitor-visa process, with a conference invitation or registration confirmation as the key extra document — confirm with the High Commission of Guyana before applying.', 203, 8, 20310, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    203, 9, 'GUY-SPORT-IN-09', '2026.09', 'published',
    'Indian athletes, officials, or support staff competing in tournaments hosted in Guyana, including cricket fixtures given Guyana''s status as a Cricket West Indies venue.',
    'Indian nationals competing or officiating — modelled on the same mail-in visitor-visa process as Tourist/Conference, with a home-association and host-organizer letter as differentiating documents. Guyana-specific Sports visa sourcing was not found this session; flagged as under-sourced.',
    'Typically up to 30-90 days depending on the entry route granted',
    'Mail application to the Consular Section, High Commission of Guyana, New Delhi, with a home-association letter and host-organizer invitation',
    0,
    'Submit at least 3 weeks before travel',
    'High Commission of Guyana, New Delhi',
    'Obtain a letter from your resident-country sports association confirming your role\nObtain an invitation letter from the host event organizer in Guyana\nComplete two visa application forms with two photos\nMail the application with supporting documents at least 3 weeks ahead',
    '/assets/images/visa-heroes/guyana.webp',
    'NOT independently confirmed this session — no Guyana-specific Sports visa sourcing was found; structure inferred from the general visitor-visa process described in secondary sourcing', 'https://newdelhihc.mission.gov.gy/consular-services/visa-enter-guyana', '2026-09-17'
);
SET @guy9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@guy9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@guy9, 'Core Documents', 'Required from every applicant.', 1);
SET @guy9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@guy9s1, 'Valid Passport (6+ Months Validity)', NULL, 'both', 1, 0, 1, 1),
(@guy9s1, 'Home-Country Sports Association Letter', 'Confirms role and no-employment status.', 'original', 1, 0, 1, 2),
(@guy9s1, 'Host Event Organizer Invitation Letter', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@guy9, 'Supporting Documents', 'Additional delegation-side evidence.', 2);
SET @guy9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@guy9s2, 'Team/Delegation List', NULL, 'copy', 0, 1, 0, 1),
(@guy9s2, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(203, 9, 5000.00, 'INR', 'Sports Visa Fee (Approximate)', 'Modelled on the Tourist visa fee; a distinct Sports fee tier was not separately confirmed this session.', '2026-09-01', NOW(), 'https://newdelhihc.mission.gov.gy/consular-services/visa-enter-guyana', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Guyana have a separate Sports visa category?', 'A Guyana-specific Sports visa checklist was not confirmed this session. This category is modelled on the general visitor-visa process, requiring a home-association letter and a host-organizer invitation — confirm with the High Commission of Guyana before applying.', 203, 9, 20311, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    203, 10, 'GUY-DEP-IN-10', '2026.09', 'published',
    'Spouse and minor children joining an Indian national on a Guyana work permit or student visa.',
    'Family members of an Indian national holding a qualifying Guyana work permit or long-term student visa. Guyana-specific Dependent-visa sourcing was not found this session; this category is structurally inferred from the general mail-in visitor-visa process plus relationship proof and is flagged as under-sourced. Guyana''s established Indo-Guyanese community also means some dependants are themselves reconnecting with extended family already resident in the country.',
    'Tied to the sponsor''s work permit or student visa validity',
    'Mail application to the Consular Section, High Commission of Guyana, New Delhi, with the sponsor''s permit/visa copy and relationship proof',
    0,
    'Submit at least 3 weeks before travel; processing may run longer where the sponsor''s own permit is still finalizing',
    'High Commission of Guyana, New Delhi',
    'Confirm the sponsor holds a valid work permit or long-term student visa\nGather relationship proof (marriage/birth certificates) and the sponsor''s permit/visa copy\nComplete two visa application forms with two photos\nMail the application with supporting documents at least 3 weeks ahead\nRegister with immigration authorities in Guyana on arrival',
    '/assets/images/visa-heroes/guyana.webp',
    'NOT independently confirmed this session — no Guyana-specific Dependent visa sourcing was found; structure inferred from the general visitor-visa process plus the work-permit sponsorship model described in secondary sourcing', 'https://newdelhihc.mission.gov.gy/consular-services/visa-enter-guyana', '2026-09-17'
);
SET @guy10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@guy10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@guy10, 'Core Documents', 'Required from every applicant.', 1);
SET @guy10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@guy10s1, 'Valid Passport (6+ Months Validity)', NULL, 'both', 1, 0, 1, 1),
(@guy10s1, 'Proof of Relationship to Sponsor', 'E.g. marriage or birth certificate.', 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@guy10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit or visa.', 2);
SET @guy10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@guy10s2, 'Sponsor''s Work Permit/Student Visa Copy', NULL, 'copy', 1, 0, 0, 1),
(@guy10s2, 'Proof of Funds', NULL, 'original', 1, 0, 0, 2),
(@guy10s2, 'Yellow Fever Vaccination Certificate', NULL, 'original', 1, 0, 0, 3);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(203, 10, NULL, 'INR', 'Confirmed After Assessment', 'No Guyana-specific Dependent visa fee was found this session; contact us to confirm the current figure.', '2026-09-01', NOW(), 'https://newdelhihc.mission.gov.gy/consular-services/visa-enter-guyana', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my family join me while I''m on a Guyana work permit?', 'A Guyana-specific Dependent visa checklist was not confirmed this session. Based on the general employer-sponsored work-permit model and mail-in visitor-visa process, dependants would need relationship proof and a copy of your permit or visa — confirm the current family-reunification process with the High Commission of Guyana before applying.', 203, 10, 20312, 1);
