-- Greenland Visa Checklist Engine content for all 10 visa types —
-- built fresh this session via web search.
--
-- Greenland's real, distinctive facts verified this session:
--   - Greenland is a Danish territory but is NOT part of the Schengen
--     Area — a standard Schengen visa does NOT cover entry to
--     Greenland. Indian citizens need a SEPARATE Greenland-specific
--     visa, which must carry the special wording "Valid for
--     Greenland" to be valid.
--   - Applications are handled ONLY at Danish consulates/embassies —
--     not any other Schengen country's mission — via the Danish
--     Embassy in New Delhi or VFS Global centres across India
--     (Mumbai, Pune, Chennai, Hyderabad, Kolkata, Bengaluru, and
--     others). Applicants must specifically inform VFS staff they are
--     travelling to Greenland/Faroe Islands.
--   - Since flights to Greenland typically transit through Denmark or
--     Iceland (both Schengen), a Schengen transit visa is usually
--     also needed — it is possible to request both in a single
--     application.
--   - Fee: EUR 90 (adults), following the standard Schengen fee
--     structure; EUR 45 for children 6-11, free under 6.
--   - Processing: up to 15 working days typically, up to 45 days in
--     complex cases.
--
-- country_id 166 = Greenland. visa_type_id: 1=Tourist, 2=Business,
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
    166, 1, 'GRL-TOUR-IN-01', '2026.09', 'published',
    'Leisure and sightseeing travel to Greenland.',
    'Indian citizens need a SEPARATE Greenland-specific visa — a standard Schengen visa does not cover Greenland, since Greenland is not part of the Schengen Area despite being Danish territory.',
    'As endorsed on the visa',
    'Apply at the Danish Embassy in New Delhi or a VFS Global centre in India, specifically requesting the Greenland-valid visa',
    1,
    'Up to 15 working days typically; up to 45 days in complex cases',
    'Danish Embassy, New Delhi (applications also via VFS Global centres across India)',
    'Book an appointment at the Danish Embassy or a VFS Global centre in India\nExplicitly inform staff you are travelling to Greenland (not just Denmark)\nGather passport, photos, and travel documents\nRequest the Schengen transit visa alongside if transiting via Denmark/Iceland\nEnsure the issued visa carries the special "Valid for Greenland" wording',
    '/assets/images/visa-heroes/greenland.webp',
    'Terrana, OneVasco, and schengenflightreservationvisa.com secondary sourcing', 'https://schengenflightreservationvisa.com/a-complete-handbook-about-greenland-visa-from-india/', '2026-09-19'
);
SET @grl1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@grl1, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grl1, 'Core Documents', 'Required from every applicant.', 1);
SET @grl1s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grl1s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@grl1s1, 'Completed Visa Application Form', NULL, 'original', 1, 0, 1, 2),
(@grl1s1, 'Recent Passport-Size Photographs', NULL, 'original', 1, 0, 1, 3);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grl1, 'Supporting Documents', 'Evidence of your travel plans and means.', 2);
SET @grl1s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grl1s2, 'Travel Insurance (Schengen-Compliant Coverage)', NULL, 'copy', 1, 0, 0, 1),
(@grl1s2, 'Proof of Accommodation in Greenland', NULL, 'copy', 1, 0, 0, 2),
(@grl1s2, 'Confirmed Return Flight Tickets', NULL, 'copy', 1, 0, 0, 3),
(@grl1s2, 'Bank Statements Showing Sufficient Funds', NULL, 'copy', 1, 0, 0, 4);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(166, 1, 90.00, 'EUR', 'Visa Fee (Standard Schengen-Tier Rate)', 'A separate Schengen transit visa fee may also apply if transiting through Denmark/Iceland, though both can often be requested in one application.', '2026-01-01', NOW(), 'https://schengenvisasupport.com/india/vfs-global-denmark/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does my Schengen visa let me visit Greenland?', 'No — Greenland is Danish territory but is NOT part of the Schengen Area. A separate Greenland-specific visa, carrying the special "Valid for Greenland" wording, is required.', 166, 1, 16600, 1),
('Where do Indian citizens apply for a Greenland visa?', 'Only at Danish consulates/embassies — via the Danish Embassy in New Delhi or authorised VFS Global centres across India. You must explicitly tell staff you are travelling to Greenland.', 166, 1, 16601, 1);

-- =====================================================================
-- BUSINESS VISA (visa_type_id 2)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    166, 2, 'GRL-BUS-IN-01', '2026.09', 'published',
    'Business meetings and short-term commercial activity in Greenland.',
    'Business travellers apply through the same Danish Embassy/VFS Global process as tourists, requesting the Greenland-valid visa and adding a business invitation letter.',
    'As endorsed on the visa',
    'Apply at the Danish Embassy in New Delhi or a VFS Global centre in India, specifically requesting the Greenland-valid visa',
    1,
    'Up to 15 working days typically; up to 45 days in complex cases',
    'Danish Embassy, New Delhi (applications also via VFS Global centres across India)',
    'Book an appointment at the Danish Embassy or a VFS Global centre in India\nExplicitly inform staff you are travelling to Greenland\nObtain a business invitation letter\nGather passport, photos, and supporting documents\nEnsure the issued visa carries the "Valid for Greenland" wording',
    '/assets/images/visa-heroes/greenland.webp',
    'Terrana and OneVasco secondary sourcing', 'https://schengenflightreservationvisa.com/a-complete-handbook-about-greenland-visa-from-india/', '2026-09-19'
);
SET @grl2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@grl2, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grl2, 'Core Documents', 'Required from every applicant.', 1);
SET @grl2s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grl2s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@grl2s1, 'Business Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grl2, 'Supporting Documents', 'Evidence of your business purpose and means.', 2);
SET @grl2s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grl2s2, 'Sponsoring Company''s Registration Proof (India)', NULL, 'copy', 1, 0, 0, 1),
(@grl2s2, 'Travel Insurance (Schengen-Compliant Coverage)', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(166, 2, 90.00, 'EUR', 'Visa Fee (Standard Schengen-Tier Rate)', 'A separate Schengen transit visa fee may also apply if transiting through Denmark/Iceland.', '2026-01-01', NOW(), 'https://schengenvisasupport.com/india/vfs-global-denmark/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can business travellers get a Greenland-valid visa alongside a Schengen visa?', 'Yes — it is possible to request both the Schengen transit visa (for Denmark/Iceland connections) and the Greenland-specific visa in a single application.', 166, 2, 16602, 1);

-- =====================================================================
-- STUDENT VISA (visa_type_id 3)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    166, 3, 'GRL-STUD-IN-01', '2026.09', 'published',
    'Academic study in Greenland.',
    'Not independently confirmed this session as a distinct standard category; likely requires a long-stay Danish/Greenland residence permit beyond the standard visa.',
    'Tied to the academic program duration',
    'Apply at the Danish Embassy in New Delhi, specifically requesting Greenland-valid documentation',
    1,
    'Not independently confirmed this session for a specific working-day figure beyond the standard 15-45 working days',
    'Danish Embassy, New Delhi',
    'Secure admission confirmation from the Greenlandic institution\nContact the Danish Embassy to confirm the long-stay process for Greenland\nGather proof of financial support\nSubmit the visa application with required documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/greenland.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://schengenflightreservationvisa.com/a-complete-handbook-about-greenland-visa-from-india/', '2026-09-19'
);
SET @grl3 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@grl3, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grl3, 'Core Documents', 'Required from every applicant.', 1);
SET @grl3s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grl3s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@grl3s1, 'Admission Confirmation from Institution', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grl3, 'Supporting Documents', 'Evidence of academic and financial standing.', 2);
SET @grl3s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grl3s2, 'Academic Transcripts/Certificates', NULL, 'copy', 1, 0, 0, 1),
(@grl3s2, 'Proof of Financial Support', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(166, 3, NULL, 'EUR', 'Confirm at Embassy', 'Student visa fee not independently confirmed this session; confirm with the Danish Embassy.', '2026-09-01', NOW(), 'https://schengenflightreservationvisa.com/a-complete-handbook-about-greenland-visa-from-india/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a separate student visa for Greenland?', 'Not independently confirmed this session — longer academic programs likely require a long-stay Danish/Greenland residence permit beyond the standard visa. Confirm with the Danish Embassy.', 166, 3, 16603, 1);

-- =====================================================================
-- WORK VISA (visa_type_id 4)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    166, 4, 'GRL-WORK-IN-01', '2026.09', 'published',
    'Employment with a Greenlandic company.',
    'Not independently confirmed this session as a distinct standard category; likely requires an employer-sponsored Danish/Greenland work permit beyond the standard visa.',
    'Tied to the employment contract duration',
    'Confirm with the employer and the Danish Embassy for the work-permit process',
    1,
    'Not independently confirmed this session for a specific working-day figure beyond the standard 15-45 working days',
    'Danish Embassy, New Delhi',
    'Secure a signed employment contract from the Greenlandic employer\nContact the Danish Embassy to confirm the work-permit process for Greenland\nGather proof of qualifications\nSubmit the visa application with required documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/greenland.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://schengenflightreservationvisa.com/a-complete-handbook-about-greenland-visa-from-india/', '2026-09-19'
);
SET @grl4 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@grl4, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grl4, 'Core Documents', 'Required from every applicant.', 1);
SET @grl4s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grl4s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@grl4s1, 'Signed Employment Contract', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grl4, 'Supporting Documents', 'Evidence of professional and employer standing.', 2);
SET @grl4s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grl4s2, 'Educational/Professional Qualification Certificates', NULL, 'copy', 1, 0, 0, 1),
(@grl4s2, 'Employer''s Registration Proof', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(166, 4, NULL, 'EUR', 'Confirm at Embassy', 'Work visa fee not independently confirmed this session; confirm with the Danish Embassy.', '2026-09-01', NOW(), 'https://schengenflightreservationvisa.com/a-complete-handbook-about-greenland-visa-from-india/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a work visa for Greenland beyond the standard visa?', 'Not independently confirmed this session — employment likely requires a separate employer-sponsored Danish/Greenland work permit. Confirm with the Danish Embassy.', 166, 4, 16604, 1);

-- =====================================================================
-- FAMILY VISIT VISA (visa_type_id 5)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    166, 5, 'GRL-FAM-IN-01', '2026.09', 'published',
    'Visiting family members residing in Greenland.',
    'Family visits use the same Danish Embassy/VFS Global process as tourism, requesting the Greenland-valid visa and adding an invitation letter.',
    'As endorsed on the visa',
    'Apply at the Danish Embassy in New Delhi or a VFS Global centre in India, specifically requesting the Greenland-valid visa',
    1,
    'Up to 15 working days typically; up to 45 days in complex cases',
    'Danish Embassy, New Delhi (applications also via VFS Global centres across India)',
    'Book an appointment at the Danish Embassy or a VFS Global centre in India\nExplicitly inform staff you are travelling to Greenland\nObtain an invitation letter from the resident family member\nGather passport, photos, and relationship proof\nEnsure the issued visa carries the "Valid for Greenland" wording',
    '/assets/images/visa-heroes/greenland.webp',
    'Terrana and OneVasco secondary sourcing', 'https://schengenflightreservationvisa.com/a-complete-handbook-about-greenland-visa-from-india/', '2026-09-19'
);
SET @grl5 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@grl5, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grl5, 'Core Documents', 'Required from every applicant.', 1);
SET @grl5s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grl5s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@grl5s1, 'Invitation Letter from Resident Family Member', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grl5, 'Supporting Documents', 'Evidence of the family relationship.', 2);
SET @grl5s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grl5s2, 'Proof of Relationship (Birth/Marriage Certificate)', NULL, 'copy', 1, 0, 0, 1),
(@grl5s2, 'Confirmed Return Flight Tickets', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(166, 5, 90.00, 'EUR', 'Visa Fee (Standard Schengen-Tier Rate)', 'A separate Schengen transit visa fee may also apply if transiting through Denmark/Iceland.', '2026-01-01', NOW(), 'https://schengenvisasupport.com/india/vfs-global-denmark/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can I visit family in Greenland on a standard Schengen visa?', 'No — Greenland is outside the Schengen Area. You need a separate Greenland-specific visa carrying the "Valid for Greenland" wording, requested at the Danish Embassy or VFS Global.', 166, 5, 16605, 1);

-- =====================================================================
-- TRANSIT VISA (visa_type_id 6)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    166, 6, 'GRL-TRAN-IN-01', '2026.09', 'published',
    'Transiting through Denmark or Iceland to reach Greenland.',
    'Since flights to Greenland typically connect through Denmark or Iceland (both Schengen), a Schengen transit visa is usually needed alongside the Greenland-specific visa — both can often be requested together.',
    'Short duration tied to the transit itinerary',
    'Request the Schengen transit visa together with the Greenland-valid visa at the Danish Embassy or VFS Global',
    1,
    'Up to 15 working days typically, processed alongside the main Greenland visa application',
    'Danish Embassy, New Delhi (applications also via VFS Global centres across India)',
    'Confirm your connecting flight routing through Denmark or Iceland\nRequest the Schengen transit visa together with the Greenland-valid visa in one application\nGather passport, photos, and onward ticket\nEnsure the Greenland visa carries the special "Valid for Greenland" wording\nConfirm requirements with your airline before travel',
    '/assets/images/visa-heroes/greenland.webp',
    'schengenflightreservationvisa.com secondary sourcing', 'https://schengenflightreservationvisa.com/a-complete-handbook-about-greenland-visa-from-india/', '2026-09-19'
);
SET @grl6 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@grl6, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grl6, 'Core Documents', 'Required from every applicant.', 1);
SET @grl6s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grl6s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@grl6s1, 'Onward/Connecting Ticket', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grl6, 'Supporting Documents', 'Evidence of onward travel plans.', 2);
SET @grl6s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grl6s2, 'Main Greenland-Valid Visa Application', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(166, 6, 90.00, 'EUR', 'Schengen Transit Visa Fee (Standard Tier)', 'Typically requested and paid alongside the main Greenland-valid visa application.', '2026-01-01', NOW(), 'https://schengenvisasupport.com/india/vfs-global-denmark/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a transit visa to reach Greenland?', 'Likely yes — flights to Greenland typically connect through Denmark or Iceland, both in the Schengen Area, so a Schengen transit visa is usually required alongside your Greenland-specific visa.', 166, 6, 16606, 1);

-- =====================================================================
-- MEDICAL VISA (visa_type_id 7)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    166, 7, 'GRL-MED-IN-01', '2026.09', 'published',
    'Medical treatment in Greenland.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard Greenland-valid visa with medical documentation.',
    'As endorsed on the visa',
    'Apply at the Danish Embassy in New Delhi or a VFS Global centre in India, specifically requesting the Greenland-valid visa',
    1,
    'Up to 15 working days typically; up to 45 days in complex cases',
    'Danish Embassy, New Delhi (applications also via VFS Global centres across India)',
    'Obtain a medical appointment/admission letter from the hospital\nBook an appointment at the Danish Embassy or a VFS Global centre\nExplicitly inform staff you are travelling to Greenland\nGather passport, photos, and medical documents\nEnsure the issued visa carries the "Valid for Greenland" wording',
    '/assets/images/visa-heroes/greenland.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://schengenflightreservationvisa.com/a-complete-handbook-about-greenland-visa-from-india/', '2026-09-19'
);
SET @grl7 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@grl7, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grl7, 'Core Documents', 'Required from every applicant.', 1);
SET @grl7s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grl7s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@grl7s1, 'Medical Appointment/Admission Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grl7, 'Supporting Documents', 'Evidence of medical necessity and financial means.', 2);
SET @grl7s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grl7s2, 'Medical Records/Referral', NULL, 'copy', 1, 0, 0, 1),
(@grl7s2, 'Proof of Financial Means for Treatment', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(166, 7, 90.00, 'EUR', 'Visa Fee (Standard Schengen-Tier Rate)', NULL, '2026-01-01', NOW(), 'https://schengenvisasupport.com/india/vfs-global-denmark/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated medical visa for Greenland?', 'A distinct standard "Medical Visa" category was not independently confirmed this session; medical travel is likely processed under the standard Greenland-valid visa with supporting medical documentation.', 166, 7, 16607, 1);

-- =====================================================================
-- CONFERENCE VISA (visa_type_id 8)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    166, 8, 'GRL-CONF-IN-01', '2026.09', 'published',
    'Attending conferences, seminars, or official meetings in Greenland.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the Business Greenland-valid visa with an event invitation.',
    'As endorsed on the visa',
    'Apply at the Danish Embassy in New Delhi or a VFS Global centre in India, specifically requesting the Greenland-valid visa',
    1,
    'Up to 15 working days typically; up to 45 days in complex cases',
    'Danish Embassy, New Delhi (applications also via VFS Global centres across India)',
    'Obtain an official event invitation letter\nBook an appointment at the Danish Embassy or a VFS Global centre\nExplicitly inform staff you are travelling to Greenland\nGather passport, photos, and event documents\nEnsure the issued visa carries the "Valid for Greenland" wording',
    '/assets/images/visa-heroes/greenland.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://schengenflightreservationvisa.com/a-complete-handbook-about-greenland-visa-from-india/', '2026-09-19'
);
SET @grl8 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@grl8, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grl8, 'Core Documents', 'Required from every applicant.', 1);
SET @grl8s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grl8s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@grl8s1, 'Official Event Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grl8, 'Supporting Documents', 'Evidence of the event.', 2);
SET @grl8s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grl8s2, 'Event Agenda/Registration Confirmation', NULL, 'copy', 1, 0, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(166, 8, 90.00, 'EUR', 'Visa Fee (Standard Schengen-Tier Rate)', NULL, '2026-01-01', NOW(), 'https://schengenvisasupport.com/india/vfs-global-denmark/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated conference visa for Greenland?', 'A distinct standard "Conference Visa" category was not independently confirmed this session; event travel is likely processed under the Business Greenland-valid visa with an official invitation letter.', 166, 8, 16608, 1);

-- =====================================================================
-- SPORTS VISA (visa_type_id 9)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    166, 9, 'GRL-SPRT-IN-01', '2026.09', 'published',
    'Participation in sporting events or tournaments in Greenland.',
    'Not independently confirmed this session as a distinct standard category — likely processed under the standard Greenland-valid visa with an event invitation.',
    'As endorsed on the visa',
    'Apply at the Danish Embassy in New Delhi or a VFS Global centre in India, specifically requesting the Greenland-valid visa',
    1,
    'Up to 15 working days typically; up to 45 days in complex cases',
    'Danish Embassy, New Delhi (applications also via VFS Global centres across India)',
    'Obtain an official invitation from the sporting federation/event organiser\nBook an appointment at the Danish Embassy or a VFS Global centre\nExplicitly inform staff you are travelling to Greenland\nGather passport, photos, and event documents\nEnsure the issued visa carries the "Valid for Greenland" wording',
    '/assets/images/visa-heroes/greenland.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://schengenflightreservationvisa.com/a-complete-handbook-about-greenland-visa-from-india/', '2026-09-19'
);
SET @grl9 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@grl9, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grl9, 'Core Documents', 'Required from every applicant.', 1);
SET @grl9s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grl9s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@grl9s1, 'Official Event/Federation Invitation Letter', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grl9, 'Supporting Documents', 'Evidence of the event and participant status.', 2);
SET @grl9s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grl9s2, 'Team/Federation Accreditation', NULL, 'copy', 0, 1, 0, 1);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(166, 9, 90.00, 'EUR', 'Visa Fee (Standard Schengen-Tier Rate)', NULL, '2026-01-01', NOW(), 'https://schengenvisasupport.com/india/vfs-global-denmark/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is there a dedicated sports visa for Greenland?', 'A distinct standard "Sports Visa" category was not independently confirmed this session; participation travel is likely processed under the standard Greenland-valid visa with a federation/event invitation.', 166, 9, 16609, 1);

-- =====================================================================
-- DEPENDENT VISA (visa_type_id 10)
-- =====================================================================
INSERT INTO visa_checklists (
    country_id, visa_type_id, reference, version, status,
    purpose, eligibility_summary, typical_stay, application_method, personal_appearance, processing_note, consular_office, application_steps,
    hero_image_url, source, source_url, last_reviewed_at
) VALUES (
    166, 10, 'GRL-DEP-IN-01', '2026.09', 'published',
    'Accompanying a family member who holds a valid Greenland work or residence permit.',
    'Not independently confirmed this session as a distinct standard category — likely requires a dependent application alongside the sponsor''s permit.',
    'Tied to the sponsor''s permit validity',
    'Confirm with the Danish Embassy for the dependent-visa process',
    1,
    'Not independently confirmed this session for a specific working-day figure',
    'Danish Embassy, New Delhi',
    'Confirm the sponsor holds a qualifying work/residence permit\nGather relationship proof and the sponsor''s permit copy\nApply at the Danish Embassy, specifying Greenland\nSubmit passport and supporting documents\nCarry all documents for immigration on arrival',
    '/assets/images/visa-heroes/greenland.webp',
    'Best-effort structure built from the confirmed general visa framework; category-specific detail not independently confirmed this session', 'https://schengenflightreservationvisa.com/a-complete-handbook-about-greenland-visa-from-india/', '2026-09-19'
);
SET @grl10 = LAST_INSERT_ID();
INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (@grl10, '2026.09', 'Initial published checklist.', 'Visagiri Content Team');

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grl10, 'Core Documents', 'Required from every applicant.', 1);
SET @grl10s1 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grl10s1, 'Valid Passport (6+ Months Validity)', NULL, 'original', 1, 0, 1, 1),
(@grl10s1, 'Proof of Relationship to Sponsor', NULL, 'copy', 1, 0, 1, 2);

INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (@grl10, 'Supporting Documents', 'Evidence tied to the sponsor''s permit.', 2);
SET @grl10s2 = LAST_INSERT_ID();
INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, display_order) VALUES
(@grl10s2, 'Sponsor''s Work/Residence Permit Copy', NULL, 'copy', 1, 0, 0, 1),
(@grl10s2, 'Proof of Sponsor''s Financial Capacity', NULL, 'copy', 1, 0, 0, 2);

INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by) VALUES
(166, 10, NULL, 'EUR', 'Confirm at Embassy', 'Dependent visa fee not independently confirmed this session; confirm with the Danish Embassy.', '2026-09-01', NOW(), 'https://schengenflightreservationvisa.com/a-complete-handbook-about-greenland-visa-from-india/', 'Visagiri Content Team');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Can my spouse accompany me on a dependent visa in Greenland?', 'Yes, in principle — the accompanying family member applies with proof of relationship and the sponsor''s valid work/residence permit. Confirm the exact procedure with the Danish Embassy.', 166, 10, 16610, 1);
