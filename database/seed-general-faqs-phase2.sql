-- General FAQ expansion — Phase 2 of the public redesign. The 5
-- existing general FAQs (database/seed.sql) cover visa requirements,
-- processing time, documents, the approval-guarantee disclaimer, and
-- tracking. These 10 add real ground not already covered — apostille
-- vs. attestation, group/corporate applications, remote consultation,
-- and reapplication support — using only facts already established
-- elsewhere on the site (attestation pages, corporate-services.php,
-- process.php). No specific fees, day-counts, or country-specific
-- claims are invented here; visa_faqs has no unique key, so each
-- insert is guarded by a NOT EXISTS check on the question text to
-- stay idempotent on re-run.

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active)
SELECT * FROM (SELECT
  'What is the difference between apostille and embassy attestation?' AS question,
  'Apostille is a single-step certification recognised by all countries that are members of the Hague Apostille Convention. Embassy or consulate attestation is a multi-step process required for non-member countries, where the destination country''s embassy directly certifies the document. Which one you need depends on your destination country — see our Attestation services page for details.' AS answer,
  NULL AS country_id, NULL AS visa_type_id, 6 AS sort_order, 1 AS is_active
) AS t WHERE NOT EXISTS (SELECT 1 FROM visa_faqs WHERE question = 'What is the difference between apostille and embassy attestation?');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active)
SELECT * FROM (SELECT
  'What is the difference between a tourist visa and a business visa?' AS question,
  'A tourist visa is for leisure travel, sightseeing, or visiting family and friends, and generally doesn''t permit paid work or formal business activity. A business visa is for attending meetings, conferences, or short-term commercial activity, and typically requires supporting documents like an invitation letter from the host company. Choosing the wrong category for your actual purpose of travel can lead to complications — our team can help you confirm the right one.' AS answer,
  NULL AS country_id, NULL AS visa_type_id, 7 AS sort_order, 1 AS is_active
) AS t WHERE NOT EXISTS (SELECT 1 FROM visa_faqs WHERE question = 'What is the difference between a tourist visa and a business visa?');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active)
SELECT * FROM (SELECT
  'Can Visagiri help with visas for a family or group application?' AS question,
  'Yes. We coordinate applications for families and groups travelling together, with document review and submission assistance for every applicant under one point of contact. See our Corporate Visa Services page for how we manage multi-applicant coordination.' AS answer,
  NULL AS country_id, NULL AS visa_type_id, 8 AS sort_order, 1 AS is_active
) AS t WHERE NOT EXISTS (SELECT 1 FROM visa_faqs WHERE question = 'Can Visagiri help with visas for a family or group application?');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active)
SELECT * FROM (SELECT
  'Does Visagiri offer corporate or business travel visa support?' AS question,
  'Yes. Businesses sending employees on work travel get the same consultant-led process every applicant receives — eligibility guidance, document review, and submission assistance — coordinated across the whole team. See our Corporate Visa Services page for more.' AS answer,
  NULL AS country_id, NULL AS visa_type_id, 9 AS sort_order, 1 AS is_active
) AS t WHERE NOT EXISTS (SELECT 1 FROM visa_faqs WHERE question = 'Does Visagiri offer corporate or business travel visa support?');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active)
SELECT * FROM (SELECT
  'Can I complete the visa consultancy process without visiting an office in person?' AS question,
  'Yes. Our consultancy process is designed to work remotely — you can reach us via WhatsApp, phone, or the enquiry form, and submit documents online. Any in-person steps required by the embassy or consulate itself (such as biometrics) are separate from our own process and are scheduled by the relevant authority.' AS answer,
  NULL AS country_id, NULL AS visa_type_id, 10 AS sort_order, 1 AS is_active
) AS t WHERE NOT EXISTS (SELECT 1 FROM visa_faqs WHERE question = 'Can I complete the visa consultancy process without visiting an office in person?');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active)
SELECT * FROM (SELECT
  'Do I need travel insurance for my visa application?' AS question,
  'Some countries, particularly within the Schengen Area, require proof of travel insurance as part of the visa application. Requirements vary by destination — check the specific visa page for your destination, or ask your consultant to confirm what''s required for your case.' AS answer,
  NULL AS country_id, NULL AS visa_type_id, 11 AS sort_order, 1 AS is_active
) AS t WHERE NOT EXISTS (SELECT 1 FROM visa_faqs WHERE question = 'Do I need travel insurance for my visa application?');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active)
SELECT * FROM (SELECT
  'Can Visagiri help if my visa application was previously rejected?' AS question,
  'Yes, we can help you understand what may have contributed to a previous refusal and assist with preparing a stronger reapplication where one is possible. We can''t guarantee a different outcome — that decision remains with the relevant embassy, consulate, or immigration authority — but we can help make sure your documentation and application are as complete and accurate as possible.' AS answer,
  NULL AS country_id, NULL AS visa_type_id, 12 AS sort_order, 1 AS is_active
) AS t WHERE NOT EXISTS (SELECT 1 FROM visa_faqs WHERE question = 'Can Visagiri help if my visa application was previously rejected?');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active)
SELECT * FROM (SELECT
  'What happens after I submit an enquiry with Visagiri?' AS question,
  'Our team reviews your destination, visa type, and travel plans, confirms eligibility and the exact documents your application needs, then reviews your documents before submission to the relevant embassy, consulate, or authority. See our Visa Consultancy & Application Management Services page for the full process.' AS answer,
  NULL AS country_id, NULL AS visa_type_id, 13 AS sort_order, 1 AS is_active
) AS t WHERE NOT EXISTS (SELECT 1 FROM visa_faqs WHERE question = 'What happens after I submit an enquiry with Visagiri?');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active)
SELECT * FROM (SELECT
  'How do I know which documents are mandatory for my specific application?' AS question,
  'Required documents vary by destination country, visa type, and your individual circumstances. Once you share your destination and purpose of travel, our team confirms the exact document checklist for your case — see our Documentation Assistance page for general guidance in the meantime.' AS answer,
  NULL AS country_id, NULL AS visa_type_id, 14 AS sort_order, 1 AS is_active
) AS t WHERE NOT EXISTS (SELECT 1 FROM visa_faqs WHERE question = 'How do I know which documents are mandatory for my specific application?');

INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active)
SELECT * FROM (SELECT
  'Does Visagiri charge government or embassy fees directly?' AS question,
  'No. Government fees, visa centre fees, and Visagiri''s own professional service fees are always shown separately and confirmed by your assigned consultant before you proceed — we don''t bundle or mark up government charges, and nothing is charged automatically.' AS answer,
  NULL AS country_id, NULL AS visa_type_id, 15 AS sort_order, 1 AS is_active
) AS t WHERE NOT EXISTS (SELECT 1 FROM visa_faqs WHERE question = 'Does Visagiri charge government or embassy fees directly?');
