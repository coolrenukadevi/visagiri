-- National Location SEO — Phase 4: the next batch of 9 states/UTs
-- (Chandigarh, Himachal Pradesh, Jammu and Kashmir, Uttarakhand,
-- Puducherry, Jharkhand, Dadra and Nagar Haveli and Daman and Diu,
-- Chhattisgarh, Tripura). Same pattern as Phases 1-3
-- (schema-location-seo.sql): real, distinct content per state,
-- office_address left NULL throughout. Four of these (Chandigarh,
-- Puducherry, Dadra and Nagar Haveli and Daman and Diu, Tripura) get
-- no separate city page — each is either a single-city UT (like
-- Delhi in Phase 2) or, for Tripura, has no second city with enough
-- distinct real material to avoid duplicating the state page. Run
-- after seed-location-seo-phase3.sql.

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Chandigarh, India''s first planned city and joint capital of Punjab and Haryana. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nChandigarh shares the same strong, long-standing culture of international migration as the wider Punjab region, particularly toward Canada, the UK, and Australia, and we regularly assist with student-visa applications, family-visit and settlement-related documentation, and work-visa assistance from applicants based here.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from Chandigarh can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Chandigarh | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants in Chandigarh. Enquire online.'
WHERE slug = 'chandigarh';

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Himachal Pradesh, a major Himalayan tourism destination with a growing number of residents pursuing study and work abroad. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nAlongside the state''s tourism and hospitality economy, we assist a growing number of Himachal Pradesh applicants with student-visa documentation for the UK, Canada, and Australia, and with work-visa applications.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from across Himachal Pradesh can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Himachal Pradesh | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Himachal Pradesh. Enquire online.'
WHERE slug = 'himachal-pradesh';

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Jammu and Kashmir. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nWe assist applicants from across Jammu and Kashmir with visa documentation and application management for study, work, tourism, and family-visit purposes, along with document apostille and attestation.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from across Jammu and Kashmir can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Jammu and Kashmir | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Jammu and Kashmir. Enquire online.'
WHERE slug = 'jammu-and-kashmir';

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Uttarakhand, including Dehradun, a well-established education hub with numerous schools and colleges. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nDehradun''s strong education sector generates steady student-visa demand for the UK, Canada, and Australia, and the state''s hill districts have long-standing family and community ties abroad, similar in pattern to neighbouring Punjab and Himachal Pradesh.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from across Uttarakhand can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Uttarakhand | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Uttarakhand, including Dehradun. Enquire online.'
WHERE slug = 'uttarakhand';

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Puducherry, a former French colonial territory with a distinct cultural and historical connection to France. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nPuducherry''s historic ties to France mean we regularly assist local applicants with France and wider Schengen-area visa documentation, alongside our full range of visa services for other destinations.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from Puducherry can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Puducherry | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants in Puducherry. Enquire online.'
WHERE slug = 'puducherry';

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Jharkhand, including Ranchi, a state built around a substantial steel, mining, and industrial economy. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nJharkhand''s industrial base, centred around cities like Jamshedpur and Ranchi, means we assist with a mix of business-visa documentation for company travel, alongside tourist, student, and family-visit visa applications.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from across Jharkhand can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Jharkhand | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Jharkhand, including Ranchi. Enquire online.'
WHERE slug = 'jharkhand';

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Dadra and Nagar Haveli and Daman and Diu, a small union territory with a significant manufacturing base and, in Daman and Diu, a former Portuguese colonial history. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nThe territory''s manufacturing and industrial base generates business-visa demand alongside tourist and family-visit visa applications from residents.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from across the territory can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Dadra and Nagar Haveli and Daman and Diu | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Dadra and Nagar Haveli and Daman and Diu. Enquire online.'
WHERE slug = 'dadra-and-nagar-haveli-and-daman-and-diu';

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Chhattisgarh, including Raipur, a state built around a substantial steel, mining, and power-generation economy. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nChhattisgarh''s industrial base means we assist with business-visa documentation for company travel, alongside tourist, student, and family-visit visa applications from across the state.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from across Chhattisgarh can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Chhattisgarh | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Chhattisgarh, including Raipur. Enquire online.'
WHERE slug = 'chhattisgarh';

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Tripura, including Agartala, a border state with a distinct regional history and a growing agriculture and trade economy. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nAs international travel and study-abroad awareness grows across Tripura, we assist applicants with tourist, student, and work-visa documentation, along with document apostille and attestation.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from across Tripura can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Tripura | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Tripura, including Agartala. Enquire online.'
WHERE slug = 'tripura';

-- Primary indexable city for the 5 states with a genuinely distinct
-- capital/hub city (office_address left NULL — none is a real
-- Visagiri office). Chandigarh, Puducherry, Dadra and Nagar Haveli
-- and Daman and Diu, and Tripura get no separate city row this phase
-- — each is either a single-city UT already fully represented by its
-- state page, or (Tripura) has no second city with enough distinct
-- real material to avoid duplicating the state page.

INSERT INTO cities (state_id, name, slug, is_major, is_indexable, intro_content, meta_title, meta_description) VALUES
((SELECT id FROM states WHERE slug = 'himachal-pradesh'), 'Shimla', 'shimla', 1, 1,
 'Visagiri assists applicants in Shimla and across Himachal Pradesh with visa consultancy and application-management support. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa applications for destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore.\n\nAlongside Shimla''s tourism economy, we assist a growing number of applicants with student-visa documentation for the UK, Canada, and Australia. We also help with document apostille and attestation.\n\nAs with every Visagiri service, we assist with preparation and process — the visa decision itself is always made by the relevant embassy, consulate, or government immigration authority, and we never guarantee approval or a specific processing time.',
 'Visa Consultant & Visa Agency in Shimla | Visagiri',
 'Visagiri offers visa consultancy, application assistance, and document attestation support for applicants in Shimla. Enquire online.'),
((SELECT id FROM states WHERE slug = 'himachal-pradesh'), 'Dharamshala', 'dharamshala', 1, 0, NULL, NULL, NULL),
((SELECT id FROM states WHERE slug = 'himachal-pradesh'), 'Manali', 'manali', 1, 0, NULL, NULL, NULL),

((SELECT id FROM states WHERE slug = 'jammu-and-kashmir'), 'Srinagar', 'srinagar', 1, 1,
 'Visagiri assists applicants in Srinagar and across Jammu and Kashmir with visa consultancy and application-management support. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa applications for destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore.\n\nWe assist Srinagar-based applicants with documentation and application management for study, work, tourism, and family-visit purposes. We also help with document apostille and attestation.\n\nAs with every Visagiri service, we assist with preparation and process — the visa decision itself is always made by the relevant embassy, consulate, or government immigration authority, and we never guarantee approval or a specific processing time.',
 'Visa Consultant & Visa Agency in Srinagar | Visagiri',
 'Visagiri offers visa consultancy, application assistance, and document attestation support for applicants in Srinagar. Enquire online.'),
((SELECT id FROM states WHERE slug = 'jammu-and-kashmir'), 'Jammu', 'jammu', 1, 0, NULL, NULL, NULL),

((SELECT id FROM states WHERE slug = 'uttarakhand'), 'Dehradun', 'dehradun', 1, 1,
 'Visagiri assists applicants in Dehradun, a well-established education hub, with visa consultancy and application-management support. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa applications for destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore.\n\nGiven Dehradun''s strong education sector, we regularly assist with student-visa documentation for the UK, Canada, and Australia, alongside tourist and family-visit visa applications. We also help with document apostille and attestation.\n\nAs with every Visagiri service, we assist with preparation and process — the visa decision itself is always made by the relevant embassy, consulate, or government immigration authority, and we never guarantee approval or a specific processing time.',
 'Visa Consultant & Visa Agency in Dehradun | Visagiri',
 'Visagiri offers visa consultancy, application assistance, and document attestation support for applicants in Dehradun. Enquire online.'),
((SELECT id FROM states WHERE slug = 'uttarakhand'), 'Haridwar', 'haridwar', 1, 0, NULL, NULL, NULL),
((SELECT id FROM states WHERE slug = 'uttarakhand'), 'Rishikesh', 'rishikesh', 1, 0, NULL, NULL, NULL),

((SELECT id FROM states WHERE slug = 'jharkhand'), 'Ranchi', 'ranchi', 1, 1,
 'Visagiri assists applicants in Ranchi and across Jharkhand''s industrial belt with visa consultancy and application-management support. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa applications for destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore.\n\nGiven the region''s steel and mining industry, we regularly assist with business-visa documentation for company travel, alongside tourist and student-visa applications. We also help with document apostille and attestation.\n\nAs with every Visagiri service, we assist with preparation and process — the visa decision itself is always made by the relevant embassy, consulate, or government immigration authority, and we never guarantee approval or a specific processing time.',
 'Visa Consultant & Visa Agency in Ranchi | Visagiri',
 'Visagiri offers visa consultancy, application assistance, and document attestation support for applicants in Ranchi. Enquire online.'),
((SELECT id FROM states WHERE slug = 'jharkhand'), 'Jamshedpur', 'jamshedpur', 1, 0, NULL, NULL, NULL),
((SELECT id FROM states WHERE slug = 'jharkhand'), 'Dhanbad', 'dhanbad', 1, 0, NULL, NULL, NULL),

((SELECT id FROM states WHERE slug = 'chhattisgarh'), 'Raipur', 'raipur', 1, 1,
 'Visagiri assists applicants in Raipur and across Chhattisgarh''s industrial belt with visa consultancy and application-management support. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa applications for destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore.\n\nGiven the region''s steel, mining, and power industry, we regularly assist with business-visa documentation for company travel, alongside tourist and student-visa applications. We also help with document apostille and attestation.\n\nAs with every Visagiri service, we assist with preparation and process — the visa decision itself is always made by the relevant embassy, consulate, or government immigration authority, and we never guarantee approval or a specific processing time.',
 'Visa Consultant & Visa Agency in Raipur | Visagiri',
 'Visagiri offers visa consultancy, application assistance, and document attestation support for applicants in Raipur. Enquire online.'),
((SELECT id FROM states WHERE slug = 'chhattisgarh'), 'Bhilai', 'bhilai', 1, 0, NULL, NULL, NULL),
((SELECT id FROM states WHERE slug = 'chhattisgarh'), 'Bilaspur', 'bilaspur', 1, 0, NULL, NULL, NULL);

-- Location FAQs — genuinely different questions per state/city.
INSERT INTO location_faqs (question, answer, state_id, city_id, sort_order) VALUES
('Can Visagiri help with Canada or UK study-visa applications from Chandigarh?', 'Yes. Chandigarh shares the same strong culture of international migration as the wider Punjab region, and we regularly assist applicants with student-visa documentation for Canada, the UK, and Australia.', (SELECT id FROM states WHERE slug = 'chandigarh'), NULL, 1),

('Does Visagiri assist Himachal Pradesh applicants with study-visa applications?', 'Yes. We assist applicants from across Himachal Pradesh with student-visa documentation for the UK, Canada, and Australia, alongside tourist and work-visa applications.', NULL, (SELECT id FROM cities WHERE slug = 'shimla'), 1),

('Can Visagiri help with tourist-visa applications from Srinagar?', 'Yes. We assist Srinagar-based applicants with tourist-visa documentation and application management for a range of international destinations.', NULL, (SELECT id FROM cities WHERE slug = 'srinagar'), 1),

('Does Visagiri assist Dehradun students with study-visa applications?', 'Yes. Given Dehradun''s strong education sector, we regularly assist students with visa documentation for the UK, Canada, and Australia.', NULL, (SELECT id FROM cities WHERE slug = 'dehradun'), 1),

('Does Visagiri assist France or Schengen visa applicants from Puducherry?', 'Yes. Given Puducherry''s historic ties to France, we regularly assist local applicants with France and wider Schengen-area visa documentation, alongside our full range of visa services.', (SELECT id FROM states WHERE slug = 'puducherry'), NULL, 1),

('Does Visagiri assist Jharkhand-based businesses with visa applications for overseas trips?', 'Yes. Given the region''s steel and mining industry, we assist with business-visa documentation and application management for a range of international destinations.', NULL, (SELECT id FROM cities WHERE slug = 'ranchi'), 1),

('Does Visagiri serve applicants from Dadra and Nagar Haveli and Daman and Diu?', 'Yes. We assist applicants from across the territory remotely through phone, WhatsApp, and online document submission, including business, tourist, and family-visit visa applications.', (SELECT id FROM states WHERE slug = 'dadra-and-nagar-haveli-and-daman-and-diu'), NULL, 1),

('Does Visagiri assist Chhattisgarh-based businesses with visa applications for overseas trips?', 'Yes. Given the region''s steel, mining, and power industry, we assist with business-visa documentation and application management for a range of international destinations.', NULL, (SELECT id FROM cities WHERE slug = 'raipur'), 1),

('Does Visagiri serve applicants from smaller towns in Tripura, not just Agartala?', 'Yes. We assist applicants from across Tripura through remote consultation and online document handling, regardless of which town or district they are based in.', (SELECT id FROM states WHERE slug = 'tripura'), NULL, 1);
