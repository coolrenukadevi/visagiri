-- SEO Wave 3 — page-specific meta_title/meta_description for the 15
-- highest-intent country+visa-type checklist pages that actually exist
-- in the live router (Tourist/Work/Student × USA/UK/Canada/Australia/
-- UAE — all 15 combinations exist and are published; none invented).
-- Requires database/schema-visa-checklist-seo.sql to have been applied
-- first (adds the meta_title/meta_description columns this depends on).
--
-- Every value below is drawn directly from that checklist row's own
-- existing purpose/application_method fields (DS-160, IRCC Portal,
-- ImmiAccount, MOHRE, CAS/CoS, etc.) — no fees, processing times, or
-- outcomes are stated since none of those are independently verified
-- figures in this database. Matched by `reference` (not `id`) so this
-- applies correctly regardless of auto-increment drift between
-- environments.

UPDATE visa_checklists SET meta_title = 'USA Tourist Visa from India: B1/B2 Requirements & DS-160 Process | Visagiri', meta_description = 'Applying for a US tourist visa from India? See the real B1/B2 document checklist, DS-160 steps, and embassy interview process — reviewed for Indian applicants.' WHERE reference = 'USA-TOUR-IN-01';
UPDATE visa_checklists SET meta_title = 'USA Student Visa (F-1) from India: Requirements & Process | Visagiri', meta_description = 'US F-1 student visa from India: SEVIS registration, I-20, DS-160 and the embassy interview explained, with the full document checklist for Indian applicants.' WHERE reference = 'USA-STU-IN-03';
UPDATE visa_checklists SET meta_title = 'USA Work Visa (H-1B) from India: Requirements & Process | Visagiri', meta_description = 'US H-1B work visa from India: the I-129 employer petition, DS-160 filing, and consulate interview — with the document checklist for Indian applicants.' WHERE reference = 'USA-WORK-IN-04';

UPDATE visa_checklists SET meta_title = 'Australia Tourist Visa from India: Documents & ImmiAccount Process | Visagiri', meta_description = 'Australia visitor visa from India: the online ImmiAccount application process and document checklist for Indian applicants — no VFS visit required for most cases.' WHERE reference = 'AUS-TOUR-IN-01';
UPDATE visa_checklists SET meta_title = 'Australia Student Visa from India: CoE, Documents & Process | Visagiri', meta_description = 'Australia student visa from India: what a CRICOS provider\'s Confirmation of Enrolment (CoE) unlocks for your ImmiAccount application, plus the document checklist.' WHERE reference = 'AUS-STU-IN-03';
UPDATE visa_checklists SET meta_title = 'Australia Work Visa from India: Employer Sponsorship & Process | Visagiri', meta_description = 'Australia skilled work visa from India: how employer sponsorship and nomination lead to your application, with the path toward permanent residence explained.' WHERE reference = 'AUS-WORK-IN-04';

UPDATE visa_checklists SET meta_title = 'Canada Tourist Visa from India: Documents & IRCC Process | Visagiri', meta_description = 'Canada visitor visa from India: the IRCC Portal application, VFS Global biometrics, and document checklist Indian applicants need before travelling to Canada.' WHERE reference = 'CAN-TOUR-IN-01';
UPDATE visa_checklists SET meta_title = 'Canada Student Visa from India: DLI, Documents & Process | Visagiri', meta_description = 'Canada study permit from India: applying through the IRCC Portal for a Designated Learning Institution (DLI), with biometrics and the document checklist explained.' WHERE reference = 'CAN-STU-IN-03';
UPDATE visa_checklists SET meta_title = 'Canada Work Visa from India: LMIA Process & Documents | Visagiri', meta_description = 'Canada work visa from India: how an employer-driven LMIA or job offer leads to your IRCC Portal application, with the document checklist for Indian applicants.' WHERE reference = 'CAN-WORK-IN-04';

UPDATE visa_checklists SET meta_title = 'UK Tourist Visa from India: Requirements & Application Process | Visagiri', meta_description = 'UK Standard Visitor visa from India: the gov.uk application steps, VFS Global biometrics, and document checklist for Indian tourists visiting the United Kingdom.' WHERE reference = 'GBR-TOUR-IN-01';
UPDATE visa_checklists SET meta_title = 'UK Student Visa from India: CAS, Documents & Process | Visagiri', meta_description = 'UK Student visa from India: what a Confirmation of Acceptance (CAS) unlocks, the gov.uk application, and VFS biometrics — full checklist for students.' WHERE reference = 'GBR-STU-IN-03';
UPDATE visa_checklists SET meta_title = 'UK Work Visa (Skilled Worker) from India: Requirements & Process | Visagiri', meta_description = 'UK Skilled Worker visa from India: how a sponsor\'s Certificate of Sponsorship leads to your gov.uk application, plus the document checklist.' WHERE reference = 'GBR-WORK-IN-04';

UPDATE visa_checklists SET meta_title = 'UAE Tourist Visa from India: eVisa Requirements & Process | Visagiri', meta_description = 'UAE tourist eVisa from India: 30 or 60-day options via a licensed sponsor, visa-on-arrival eligibility, and the document checklist for Indian travellers.' WHERE reference = 'ARE-TOUR-IN-01';
UPDATE visa_checklists SET meta_title = 'UAE Student Visa from India: Requirements & Process | Visagiri', meta_description = 'UAE student residence visa from India: the institution-sponsored entry permit, medical test, and Emirates ID process, with the document checklist explained.' WHERE reference = 'ARE-STU-IN-03';
UPDATE visa_checklists SET meta_title = 'UAE Work Visa from India: MOHRE Process & Documents | Visagiri', meta_description = 'UAE employment visa from India: the MOHRE work permit, entry permit, medical test, and Emirates ID steps — full document checklist for Indian applicants.' WHERE reference = 'ARE-WORK-IN-04';
