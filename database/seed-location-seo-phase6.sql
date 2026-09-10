-- National Location SEO — Phase 6: the last 2 of the original 15 target
-- cities that were still noindexed (Delhi and Chandigarh are already
-- indexable as of Phase 2/4 — an earlier audit misread the static seed
-- files without tracing their later UPDATE statements; verified
-- directly against the database before writing this file). Pune
-- (Maharashtra) and Lucknow (Uttar Pradesh) both already have real
-- city rows and indexable parent states (Location SEO Phase 2) — only
-- their own city-page content was still NULL. Same honest pattern as
-- every prior phase: no Visagiri office in either city (offices are
-- Patna, Bihar and Noida, Uttar Pradesh only), so both pages state
-- "served remotely" rather than implying a local office, and no
-- fabricated statistics are used — only well-established, defensible
-- characterizations of each city (Pune's IT/education/manufacturing
-- base, Lucknow's role as UP's administrative and education capital).
-- Run after seed-location-seo.sql and seed-location-seo-phase2.sql.

UPDATE cities SET is_indexable = 1,
  intro_content = 'Visagiri assists applicants in Pune, one of India''s major IT, education, and manufacturing hubs, with visa consultancy and application-management support. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa applications for destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore.\n\nPune''s large IT and engineering workforce, combined with its status as one of India''s biggest education centres, generates steady demand for work-visa and student-visa assistance alongside tourist and business-visa applications. We also help with document apostille and attestation.\n\nAs with every Visagiri service, we assist with preparation and process — the visa decision itself is always made by the relevant embassy, consulate, or government immigration authority, and we never guarantee approval or a specific processing time.',
  meta_title = 'Visa Consultant & Visa Agency in Pune | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation support for applicants in Pune. Enquire online.'
WHERE slug = 'pune' AND state_id = (SELECT id FROM states WHERE slug = 'maharashtra');

UPDATE cities SET is_indexable = 1,
  intro_content = 'Visagiri assists applicants in Lucknow, the capital of Uttar Pradesh and one of North India''s major administrative and education centres, with visa consultancy and application-management support. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa applications for destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore.\n\nAs a state capital with a large student population and a growing base of professionals travelling for work and business, Lucknow generates consistent demand for student, work, and business-visa assistance alongside tourist and family-visit applications. We also help with document apostille and attestation.\n\nAs with every Visagiri service, we assist with preparation and process — the visa decision itself is always made by the relevant embassy, consulate, or government immigration authority, and we never guarantee approval or a specific processing time.',
  meta_title = 'Visa Consultant & Visa Agency in Lucknow | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation support for applicants in Lucknow. Enquire online.'
WHERE slug = 'lucknow' AND state_id = (SELECT id FROM states WHERE slug = 'uttar-pradesh');

INSERT INTO location_faqs (question, answer, state_id, city_id, sort_order)
SELECT * FROM (SELECT
  'Does Visagiri have a physical office in Pune?' AS question,
  'No. Visagiri''s offices are in Patna, Bihar and Noida, Uttar Pradesh. We assist Pune-based applicants remotely through phone, WhatsApp, and online document submission — the same process used for every applicant regardless of location.' AS answer,
  NULL AS state_id,
  (SELECT id FROM cities WHERE slug = 'pune' AND state_id = (SELECT id FROM states WHERE slug = 'maharashtra')) AS city_id,
  1 AS sort_order
) AS t
WHERE NOT EXISTS (SELECT 1 FROM location_faqs WHERE question = 'Does Visagiri have a physical office in Pune?');

INSERT INTO location_faqs (question, answer, state_id, city_id, sort_order)
SELECT * FROM (SELECT
  'Can Visagiri help IT professionals in Pune with work-visa applications?' AS question,
  'Yes. Given Pune''s large IT and engineering workforce, we regularly assist with work-visa documentation for destinations including the UAE, Singapore, and Gulf countries, alongside student and business-visa applications.' AS answer,
  NULL AS state_id,
  (SELECT id FROM cities WHERE slug = 'pune' AND state_id = (SELECT id FROM states WHERE slug = 'maharashtra')) AS city_id,
  2 AS sort_order
) AS t
WHERE NOT EXISTS (SELECT 1 FROM location_faqs WHERE question = 'Can Visagiri help IT professionals in Pune with work-visa applications?');

INSERT INTO location_faqs (question, answer, state_id, city_id, sort_order)
SELECT * FROM (SELECT
  'Does Visagiri have a physical office in Lucknow?' AS question,
  'No. Visagiri''s offices are in Patna, Bihar and Noida, Uttar Pradesh. We assist Lucknow-based applicants remotely through phone, WhatsApp, and online document submission — the same process used for every applicant regardless of location.' AS answer,
  NULL AS state_id,
  (SELECT id FROM cities WHERE slug = 'lucknow' AND state_id = (SELECT id FROM states WHERE slug = 'uttar-pradesh')) AS city_id,
  1 AS sort_order
) AS t
WHERE NOT EXISTS (SELECT 1 FROM location_faqs WHERE question = 'Does Visagiri have a physical office in Lucknow?');

INSERT INTO location_faqs (question, answer, state_id, city_id, sort_order)
SELECT * FROM (SELECT
  'Can Visagiri help students in Lucknow with study-visa documentation?' AS question,
  'Yes. As a major education centre, Lucknow has a large student population, and we regularly assist with student-visa documentation for the USA, UK, Canada, and Australia, alongside work and tourist-visa applications.' AS answer,
  NULL AS state_id,
  (SELECT id FROM cities WHERE slug = 'lucknow' AND state_id = (SELECT id FROM states WHERE slug = 'uttar-pradesh')) AS city_id,
  2 AS sort_order
) AS t
WHERE NOT EXISTS (SELECT 1 FROM location_faqs WHERE question = 'Can Visagiri help students in Lucknow with study-visa documentation?');
