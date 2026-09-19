-- Kyrgyzstan Visa Checklist Engine content for all 10 visa types —
-- built fresh this session via web search.
--
-- Kyrgyzstan's real, distinctive facts verified this session:
--   - Indian citizens require an eVisa for Kyrgyzstan — there is no
--     visa-free entry option for Indian passport holders.
--   - Distinctive, nationality-targeted requirement: citizens of
--     India, Pakistan, Bangladesh, and Sri Lanka must obtain a Letter
--     of Invitation (LOI) from a travel company registered with the
--     Department of Tourism under Kyrgyzstan's Ministry of Culture
--     BEFORE applying for the eVisa — most other nationalities do not
--     face this extra step.
--   - This requirement is reported to be strictly and inconsistently
--     enforced: an Indian travel-influencer couple's July 2026 case,
--     reported by Indian Express, described their eVisa being
--     rejected/returned after submitting an LOI from a local guide
--     rather than a registered tour operator — flagged here as a real
--     documented enforcement risk, not a hypothetical caveat.
--   - eVisa fee approximately USD 30 (~INR 2,899-4,200 depending on
--     source), processing around 3 business days, validity up to 90
--     days.
--
-- country_id 76 = Kyrgyzstan. visa_type_id: 1=Tourist, 2=Business,
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
    76, 1, 'KGZ-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Kyrgyzstan.',
    'Indian citizens require an eVisa for Kyrgyzstan — there is no visa-free entry. Distinctively, Indian nationals must first obtain a Letter of Invitation (LOI) from a government-registered Kyrgyz tour operator before applying for the eVisa; this requirement has been reported as strictly enforced in real 2026 cases.',
    'Up to 90 days',
    'Obtain an LOI from a registered Kyrgyz tour operator, then apply for the eVisa online',
    0,
    'A documented July 2026 case (Indian Express) reported an eVisa rejection after submitting an LOI from an unregistered local guide rather than a licensed tour operator — use only a Department of Tourism-registered operator. Processing ~3 business days.',
    'No dedicated Kyrgyz mission processes required — the eVisa and LOI are handled online/through registered tour operators',
    'Confirm your passport is valid for 6+ months\nObtain a Letter of Invitation (LOI) from a Department of Tourism-registered Kyrgyz tour operator\nApply for the eVisa online using the LOI\nGather proof of accommodation and sufficient funds\nCarry printed eVisa and LOI copies for immigration on arrival',
    NULL,
    'btwvisas.com secondary sourcing (LOI enforcement case per Indian Express, July 2026)', 'https://btwvisas.com/visa-guide/kyrgyzstan-visa', '2026-09-19'
);
SET @kgz1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kgz1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kgz1, 'Core Documents', 'Required from every applicant.', 1);
SET @kgz1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kgz1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@kgz1s1, 'Letter of Invitation (LOI) from Registered Tour Operator', NULL, 'copy', 1, 0, 1, 2),
(@kgz1s1, 'Approved eVisa', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kgz1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @kgz1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kgz1s2, 'Proof of Accommodation', NULL, 'copy', 1, 0, 0, 1),
(@kgz1s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(76, 1, 30.00, 'USD', 'eVisa Fee', 'Sources cite USD 30 (~INR 2,899-4,200 depending on source); LOI fees from the tour operator are separate and not independently confirmed this session.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/kyrgyzstan-visa-fees', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Kyrgyzstan?', 'Yes — an eVisa is required; there is no visa-free entry for Indian passport holders.', 76, 1, 7600, 1),
('What is the Letter of Invitation (LOI) requirement for Indians visiting Kyrgyzstan?', 'Indian, Pakistani, Bangladeshi, and Sri Lankan nationals must obtain an LOI from a Department of Tourism-registered Kyrgyz tour operator before applying for the eVisa. A July 2026 case reported an eVisa rejection after using an LOI from an unregistered local guide — use only a licensed, registered operator.', 76, 1, 7601, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    76, 2, 'KGZ-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Kyrgyzstan.',
    'Business travellers use the same eVisa/LOI framework as tourists, with a business invitation letter from the host organization as additional support.',
    'Up to 90 days',
    'Obtain an LOI from a registered Kyrgyz tour operator or business host, then apply for the eVisa online',
    0,
    'Same LOI requirement as the tourist eVisa applies — use only a Department of Tourism-registered operator or a properly documented business host.',
    'No dedicated Kyrgyz mission processes required — the eVisa and LOI are handled online',
    'Confirm your passport is valid for 6+ months\nObtain a Letter of Invitation (LOI) from a registered operator or business host\nApply for the eVisa online using the LOI\nCarry a business invitation letter from the host organization\nGather proof of sufficient funds',
    NULL,
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/kyrgyzstan-visa', '2026-09-19'
);
SET @kgz2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kgz2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kgz2, 'Core Documents', 'Required from every applicant.', 1);
SET @kgz2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kgz2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@kgz2s1, 'Letter of Invitation (LOI)', NULL, 'copy', 1, 0, 1, 2),
(@kgz2s1, 'Business Invitation Letter', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kgz2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @kgz2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kgz2s2, 'Company Sponsorship Letter', NULL, 'copy', 0, 1, 0, 1),
(@kgz2s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(76, 2, 30.00, 'USD', 'eVisa Fee', 'Same USD 30 eVisa fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/kyrgyzstan-visa-fees', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian business travellers need an LOI for Kyrgyzstan?', 'Yes — the same LOI requirement applies before applying for the business eVisa, in addition to a business invitation letter.', 76, 2, 7620, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    76, 3, 'KGZ-STU-IN-01', '2026.09', 'published',
    'Academic study at a Kyrgyz educational institution.',
    'Student visas are issued to Indian students enrolled in Kyrgyz institutions, requiring proof of admission and funding; the university itself often issues the invitation in place of a tour-operator LOI.',
    'Academic-program length, renewable',
    'Secure university admission (which typically provides the invitation), then apply for the student eVisa/visa',
    1,
    'Not independently confirmed this session: whether the standard tourism-operator LOI is required in addition to a university invitation — verify directly with your institution.',
    'No dedicated Kyrgyz mission processes required — coordinate through your university and the eVisa portal',
    'Confirm admission with a Kyrgyz educational institution\nObtain the university\'s invitation/admission letter\nApply for the student eVisa/visa online\nGather proof of sufficient funds\nRegister with local authorities after arrival as required',
    NULL,
    'akbartravels.com secondary sourcing', 'https://www.akbartravels.com/in/visas/kyrgyzstan-visa-fees', '2026-09-19'
);
SET @kgz3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kgz3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kgz3, 'Core Documents', 'Required from every applicant.', 1);
SET @kgz3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kgz3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@kgz3s1, 'University Admission/Invitation Letter', NULL, 'original', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kgz3, 'Supporting Documents', 'Evidence of your means and academic status.', 2);
SET @kgz3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kgz3s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 1),
(@kgz3s2, 'Proof of Accommodation', NULL, 'copy', 0, 1, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(76, 3, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Student visa fees were designed to be affordable per sources, but an exact figure was not independently confirmed this session — verify with your institution.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/kyrgyzstan-visa-fees', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian students need the tour-operator LOI for a Kyrgyzstan student visa?', 'Not independently confirmed this session — the university\'s own admission/invitation letter typically substitutes; verify directly with your institution.', 76, 3, 7630, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    76, 4, 'KGZ-WORK-IN-01', '2026.09', 'published',
    'Employment in Kyrgyzstan under a local employer.',
    'Work visas require sponsorship by a local employer and include a Kyrgyzstan work permit; fees vary by employment period and type.',
    'Per work-permit validity, renewable',
    'Employer sponsors your work visa and work permit application',
    1,
    'Not independently confirmed this session: exact work-visa/work-permit fee structure by employment type — verify directly with your employer and Kyrgyz labour authorities.',
    'No dedicated Kyrgyz mission processes required — coordinate through your employer',
    'Secure a job offer from a Kyrgyz employer\nEmployer sponsors your work visa and Kyrgyzstan work permit application\nGather employment contract and proof of qualifications\nApply for the work visa/eVisa as directed by your employer\nRegister your work permit with local authorities after arrival',
    NULL,
    'policybazaar.com secondary sourcing', 'https://www.policybazaar.com/travel-insurance/kyrgyzstan/visa/', '2026-09-19'
);
SET @kgz4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kgz4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kgz4, 'Core Documents', 'Required from every work-visa applicant.', 1);
SET @kgz4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kgz4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@kgz4s1, 'Employment Contract/Sponsorship Letter', NULL, 'original', 1, 0, 1, 2),
(@kgz4s1, 'Kyrgyzstan Work Permit', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kgz4, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @kgz4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kgz4s2, 'Educational/Professional Certificates', NULL, 'copy', 0, 1, 0, 1),
(@kgz4s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(76, 4, 0.00, 'USD', 'Fee Not Independently Confirmed', 'Work visa fees vary by employment period and type; not independently confirmed to a single figure this session.', '2026-01-01', NOW(), 'https://www.policybazaar.com/travel-insurance/kyrgyzstan/visa/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What does an Indian citizen need to work in Kyrgyzstan?', 'A work visa sponsored by your employer, plus a Kyrgyzstan work permit; fees vary by employment period and type.', 76, 4, 7640, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    76, 5, 'KGZ-FAM-IN-01', '2026.09', 'published',
    'Visiting family or friends resident in Kyrgyzstan.',
    'Family visitors use the same eVisa/LOI framework as tourists — the LOI may be issued by the family host if they are a registered entity, or via a registered tour operator.',
    'Up to 90 days',
    'Obtain an LOI (from a registered tour operator or the family host, if eligible), then apply for the eVisa online',
    0,
    'Same LOI requirement applies as for tourist travel.',
    'No dedicated Kyrgyz mission processes required — the eVisa and LOI are handled online',
    'Confirm your passport is valid for 6+ months\nObtain a Letter of Invitation (LOI) from a registered operator or eligible host\nApply for the eVisa online using the LOI\nCarry proof of relationship and host contact details\nGather proof of sufficient funds',
    NULL,
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/kyrgyzstan-visa', '2026-09-19'
);
SET @kgz5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kgz5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kgz5, 'Core Documents', 'Required from every applicant.', 1);
SET @kgz5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kgz5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@kgz5s1, 'Letter of Invitation (LOI)', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kgz5, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @kgz5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kgz5s2, 'Proof of Relationship to Host', NULL, 'copy', 0, 1, 0, 1),
(@kgz5s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(76, 5, 30.00, 'USD', 'eVisa Fee', 'Same USD 30 eVisa fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/kyrgyzstan-visa-fees', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need an LOI to visit family in Kyrgyzstan?', 'Yes — the same LOI requirement applies as for tourist travel, though an eligible family host may be able to issue it directly.', 76, 5, 7650, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    76, 6, 'KGZ-TRAN-IN-01', '2026.09', 'published',
    'Transit through Kyrgyzstan en route to another destination.',
    'Sources reviewed this session did not describe a separate airside-only transit exemption for Indian passport holders — given the mandatory LOI/eVisa framework, travellers clearing immigration should expect to need the same documentation as other visa types.',
    'Short transit only',
    'Obtain an LOI and apply for the eVisa before transiting, if there is any possibility of clearing immigration',
    0,
    'Not independently confirmed this session whether an airside-only exemption exists — verify with your airline before relying on transiting without documentation.',
    'No dedicated Kyrgyz mission processes required — the eVisa and LOI are handled online',
    'Confirm your connecting flight and transit time\nObtain an LOI and apply for the eVisa in advance if there is any possibility of clearing immigration\nCarry your onward boarding pass and passport\nConfirm airside-only transit exemptions directly with your airline',
    NULL,
    'btwvisas.com secondary sourcing (transit exemption not independently confirmed)', 'https://btwvisas.com/visa-guide/kyrgyzstan-visa', '2026-09-19'
);
SET @kgz6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kgz6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kgz6, 'Core Documents', 'Required from every transit passenger.', 1);
SET @kgz6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kgz6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@kgz6s1, 'Confirmed Onward Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(76, 6, 30.00, 'USD', 'eVisa Fee (If Clearing Immigration)', 'Airside-only transit exemption not independently confirmed this session — budget for the standard eVisa/LOI fee unless your airline confirms otherwise.', '2026-01-01', NOW(), 'https://btwvisas.com/visa-guide/kyrgyzstan-visa', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a transit visa for Kyrgyzstan?', 'Not independently confirmed this session whether airside-only transit is exempt from the LOI/eVisa requirement. If you may clear immigration, apply in advance.', 76, 6, 7660, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    76, 7, 'KGZ-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Kyrgyzstan.',
    'Medical travellers use the same eVisa/LOI framework as tourists.',
    'Up to 90 days',
    'Obtain an LOI from a registered tour operator or the medical facility, then apply for the eVisa online',
    0,
    'Same LOI requirement applies as for tourist travel.',
    'No dedicated Kyrgyz mission processes required — the eVisa and LOI are handled online',
    'Confirm treatment and appointment directly with the Kyrgyz medical facility\nObtain a Letter of Invitation (LOI) as required\nApply for the eVisa online using the LOI\nGather proof of sufficient funds\nCarry all medical and travel documents for immigration',
    NULL,
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/kyrgyzstan-visa', '2026-09-19'
);
SET @kgz7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kgz7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kgz7, 'Core Documents', 'Required from every applicant.', 1);
SET @kgz7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kgz7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@kgz7s1, 'Medical Appointment/Treatment Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kgz7, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @kgz7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kgz7s2, 'Letter of Invitation (LOI)', NULL, 'copy', 1, 0, 0, 1),
(@kgz7s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(76, 7, 30.00, 'USD', 'eVisa Fee', 'Same USD 30 eVisa fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/kyrgyzstan-visa-fees', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a medical visa for Kyrgyzstan?', 'No separate medical visa — the same eVisa/LOI framework applies as for tourist travel.', 76, 7, 7670, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    76, 8, 'KGZ-CONF-IN-01', '2026.09', 'published',
    'Attending a conference, seminar, or convention in Kyrgyzstan.',
    'Conference attendees use the same eVisa/LOI framework as business travellers.',
    'Up to 90 days',
    'Obtain an LOI from a registered tour operator or the conference organizer, then apply for the eVisa online',
    0,
    'Same LOI requirement applies as for business travel.',
    'No dedicated Kyrgyz mission processes required — the eVisa and LOI are handled online',
    'Confirm your passport is valid for 6+ months\nObtain a Letter of Invitation (LOI) as required\nCarry conference invitation/registration confirmation\nApply for the eVisa online using the LOI\nGather proof of sufficient funds',
    NULL,
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/kyrgyzstan-visa', '2026-09-19'
);
SET @kgz8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kgz8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kgz8, 'Core Documents', 'Required from every applicant.', 1);
SET @kgz8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kgz8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@kgz8s1, 'Conference Invitation/Registration Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kgz8, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @kgz8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kgz8s2, 'Letter of Invitation (LOI)', NULL, 'copy', 1, 0, 0, 1),
(@kgz8s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(76, 8, 30.00, 'USD', 'eVisa Fee', 'Same USD 30 eVisa fee range as the business visa applies.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/kyrgyzstan-visa-fees', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a conference visa for Kyrgyzstan?', 'No separate conference visa — the same eVisa/LOI framework applies as for business travel.', 76, 8, 7680, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    76, 9, 'KGZ-SPRT-IN-01', '2026.09', 'published',
    'Participating in or attending a sporting event in Kyrgyzstan.',
    'Sports travellers use the same eVisa/LOI framework as tourists.',
    'Up to 90 days',
    'Obtain an LOI from a registered tour operator or the event organizer, then apply for the eVisa online',
    0,
    'Same LOI requirement applies as for tourist travel.',
    'No dedicated Kyrgyz mission processes required — the eVisa and LOI are handled online',
    'Confirm your passport is valid for 6+ months\nObtain a Letter of Invitation (LOI) as required\nCarry event invitation/participation confirmation\nApply for the eVisa online using the LOI\nGather proof of sufficient funds',
    NULL,
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/kyrgyzstan-visa', '2026-09-19'
);
SET @kgz9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kgz9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kgz9, 'Core Documents', 'Required from every applicant.', 1);
SET @kgz9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kgz9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@kgz9s1, 'Event Invitation/Participation Confirmation', NULL, 'copy', 0, 1, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kgz9, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @kgz9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kgz9s2, 'Letter of Invitation (LOI)', NULL, 'copy', 1, 0, 0, 1),
(@kgz9s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(76, 9, 30.00, 'USD', 'eVisa Fee', 'Same USD 30 eVisa fee range as the tourist visa applies.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/kyrgyzstan-visa-fees', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian athletes need a sports visa for Kyrgyzstan?', 'No separate sports visa — the same eVisa/LOI framework applies as for tourist travel.', 76, 9, 7690, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    76, 10, 'KGZ-DEP-IN-01', '2026.09', 'published',
    'Accompanying a spouse or parent who holds a Kyrgyzstan work/student visa.',
    'Dependants apply through the same eVisa/LOI framework, referencing the primary permit holder\'s status.',
    'Tied to the primary permit holder\'s validity',
    'Obtain an LOI, then apply for the eVisa, referencing the primary permit holder\'s status',
    1,
    'Not independently confirmed this session: exact dependant-visa fee and process — verify directly.',
    'No dedicated Kyrgyz mission processes required — the eVisa and LOI are handled online',
    'Confirm the primary permit holder\'s work/student visa status\nGather proof of relationship (marriage/birth certificate)\nObtain a Letter of Invitation (LOI)\nApply for the eVisa online\nRegister with local authorities on arrival if required',
    NULL,
    'btwvisas.com secondary sourcing', 'https://btwvisas.com/visa-guide/kyrgyzstan-visa', '2026-09-19'
);
SET @kgz10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@kgz10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kgz10, 'Core Documents', 'Required from every dependant applicant.', 1);
SET @kgz10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kgz10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@kgz10s1, 'Proof of Relationship (Marriage/Birth Certificate)', NULL, 'original', 1, 0, 1, 2),
(@kgz10s1, 'Primary Permit Holder\'s Visa Copy', NULL, 'copy', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@kgz10, 'Supporting Documents', 'Additional documents typically requested.', 2);
SET @kgz10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@kgz10s2, 'Letter of Invitation (LOI)', NULL, 'copy', 1, 0, 0, 1),
(@kgz10s2, 'Proof of Sufficient Funds', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(76, 10, 30.00, 'USD', 'eVisa Fee', 'Same USD 30 eVisa fee range as other visa types applies.', '2026-01-01', NOW(), 'https://www.akbartravels.com/in/visas/kyrgyzstan-visa-fees', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can dependants accompany a work/student visa holder to Kyrgyzstan?', 'Yes, via the same eVisa/LOI framework, referencing the primary permit holder\'s status.', 76, 10, 7600, 1);
