-- National Location SEO — Phase 3: the next batch of 8 states/UTs
-- (Punjab, Kerala, Haryana, Andhra Pradesh, Goa, Assam, Madhya
-- Pradesh, Odisha), covering all 6 Indian zones for the first time
-- (Phase 2 had no Central/Northeast coverage). Same pattern as
-- Phase 1/2 (schema-location-seo.sql): real, distinct hand-written
-- content per state, one fully-authored primary city each, real
-- unauthored city-name stubs, office_address left NULL throughout
-- (none of these is a real Visagiri office). Run after
-- seed-location-seo.sql and seed-location-seo-phase2.sql.

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Punjab, a state with one of India''s longest histories of international migration, particularly to Canada, the UK, and Australia. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nGiven Punjab''s deep and long-standing diaspora ties abroad, we regularly assist with student-visa applications, family-visit and settlement-related documentation, and work-visa assistance, alongside tourist visas.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from across Punjab can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Punjab | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Punjab. Enquire online.'
WHERE slug = 'punjab';

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Kerala, a state with one of India''s largest expatriate populations, particularly across the Gulf region. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nGiven Kerala''s established ties to the UAE, Saudi Arabia, and other Gulf countries, we regularly assist with work-visa documentation for Gulf employment alongside our standard visa services, as well as student and tourist-visa applications for other global destinations.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from across Kerala can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Kerala | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Kerala. Enquire online.'
WHERE slug = 'kerala';

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Haryana, including Gurugram, part of the Delhi-NCR corporate and multinational business corridor. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nGurugram''s large base of multinational companies and corporate offices generates steady demand for business and work-visa assistance, alongside tourist and student-visa applications from across the state.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from across Haryana can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Haryana | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Haryana, including Gurugram. Enquire online.'
WHERE slug = 'haryana';

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Andhra Pradesh, including the port city of Visakhapatnam and a state with a long-established Telugu community abroad, particularly in the USA. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nGiven the state''s strong ties to the US technology and academic sectors, we regularly assist with student and work-visa applications, alongside tourist and family-visit visas.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from across Andhra Pradesh can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Andhra Pradesh | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Andhra Pradesh. Enquire online.'
WHERE slug = 'andhra-pradesh';

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Goa, one of India''s most visited destinations and a state with a strong tourism and hospitality economy. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nGoa''s tourism and hospitality sector, along with its seafaring and merchant-navy community, generates a mix of tourist, work, and travel-document related enquiries that our team regularly assists with.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from across Goa can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Goa | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Goa. Enquire online.'
WHERE slug = 'goa';

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Assam, including Guwahati, the principal gateway city for Northeast India. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nAs travel and study-abroad awareness grows across the Northeast, we assist applicants from Assam with tourist, student, and work-visa documentation, along with document apostille and attestation.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from across Assam can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Assam | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Assam, including Guwahati. Enquire online.'
WHERE slug = 'assam';

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Madhya Pradesh, including Indore, the state''s largest and fastest-growing commercial city. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nIndore''s growing trade, education, and business sectors mean we assist with a broad mix of business, student, and tourist-visa applications from across the state.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from across Madhya Pradesh can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Madhya Pradesh | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Madhya Pradesh, including Indore. Enquire online.'
WHERE slug = 'madhya-pradesh';

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Odisha, including Bhubaneswar, an emerging IT and education hub in Eastern India. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nBhubaneswar''s growing technology and education sectors mean we increasingly assist with student and work-visa applications, alongside tourist and family-visit visas from across the state.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from across Odisha can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Odisha | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Odisha, including Bhubaneswar. Enquire online.'
WHERE slug = 'odisha';

-- Primary indexable city per state (real content, office_address
-- left NULL — none of these are real Visagiri offices) plus real,
-- unauthored stub city names for the "Cities We Serve" list.

INSERT INTO cities (state_id, name, slug, is_major, is_indexable, intro_content, meta_title, meta_description) VALUES
((SELECT id FROM states WHERE slug = 'punjab'), 'Jalandhar', 'jalandhar', 1, 1,
 'Visagiri assists applicants in Jalandhar, one of Punjab''s most active hubs for international travel and study-abroad enquiries, with visa consultancy and application-management support. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa applications for destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore.\n\nGiven Jalandhar''s strong culture of international migration and study abroad, we regularly assist with student-visa documentation for Canada, the UK, and Australia, alongside family-visit and tourist-visa applications. We also help with document apostille and attestation.\n\nAs with every Visagiri service, we assist with preparation and process — the visa decision itself is always made by the relevant embassy, consulate, or government immigration authority, and we never guarantee approval or a specific processing time.',
 'Visa Consultant & Visa Agency in Jalandhar | Visagiri',
 'Visagiri offers visa consultancy, application assistance, and document attestation support for applicants in Jalandhar. Enquire online.'),
((SELECT id FROM states WHERE slug = 'punjab'), 'Ludhiana', 'ludhiana', 1, 0, NULL, NULL, NULL),
((SELECT id FROM states WHERE slug = 'punjab'), 'Amritsar', 'amritsar', 1, 0, NULL, NULL, NULL),

((SELECT id FROM states WHERE slug = 'kerala'), 'Kochi', 'kochi', 1, 1,
 'Visagiri assists applicants in Kochi, Kerala''s major commercial hub and a key departure point for Gulf-bound travel, with visa consultancy and application-management support. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa applications for destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore.\n\nGiven Kochi''s strong ties to the Gulf region, we regularly assist with work-visa documentation for UAE and Saudi Arabia employment, alongside student and tourist-visa applications for other destinations. We also help with document apostille and attestation.\n\nAs with every Visagiri service, we assist with preparation and process — the visa decision itself is always made by the relevant embassy, consulate, or government immigration authority, and we never guarantee approval or a specific processing time.',
 'Visa Consultant & Visa Agency in Kochi | Visagiri',
 'Visagiri offers visa consultancy, application assistance, and document attestation support for applicants in Kochi. Enquire online.'),
((SELECT id FROM states WHERE slug = 'kerala'), 'Thiruvananthapuram', 'thiruvananthapuram', 1, 0, NULL, NULL, NULL),
((SELECT id FROM states WHERE slug = 'kerala'), 'Kozhikode', 'kozhikode', 1, 0, NULL, NULL, NULL),

((SELECT id FROM states WHERE slug = 'haryana'), 'Gurugram', 'gurugram', 1, 1,
 'Visagiri assists applicants in Gurugram, part of the Delhi-NCR corporate and multinational business corridor, with visa consultancy and application-management support. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa applications for destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore.\n\nGiven Gurugram''s large base of multinational companies, we regularly assist with business and work-visa documentation, alongside tourist and student-visa applications. We also help with document apostille and attestation.\n\nAs with every Visagiri service, we assist with preparation and process — the visa decision itself is always made by the relevant embassy, consulate, or government immigration authority, and we never guarantee approval or a specific processing time.',
 'Visa Consultant & Visa Agency in Gurugram | Visagiri',
 'Visagiri offers visa consultancy, application assistance, and document attestation support for applicants in Gurugram. Enquire online.'),
((SELECT id FROM states WHERE slug = 'haryana'), 'Faridabad', 'faridabad', 1, 0, NULL, NULL, NULL),
((SELECT id FROM states WHERE slug = 'haryana'), 'Panchkula', 'panchkula', 1, 0, NULL, NULL, NULL),

((SELECT id FROM states WHERE slug = 'andhra-pradesh'), 'Visakhapatnam', 'visakhapatnam', 1, 1,
 'Visagiri assists applicants in Visakhapatnam, Andhra Pradesh''s largest city and a major port and business centre, with visa consultancy and application-management support. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa applications for destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore.\n\nGiven the state''s strong ties to the US technology and academic sectors, we regularly assist with student and work-visa applications from Visakhapatnam, alongside tourist and family-visit visas. We also help with document apostille and attestation.\n\nAs with every Visagiri service, we assist with preparation and process — the visa decision itself is always made by the relevant embassy, consulate, or government immigration authority, and we never guarantee approval or a specific processing time.',
 'Visa Consultant & Visa Agency in Visakhapatnam | Visagiri',
 'Visagiri offers visa consultancy, application assistance, and document attestation support for applicants in Visakhapatnam. Enquire online.'),
((SELECT id FROM states WHERE slug = 'andhra-pradesh'), 'Vijayawada', 'vijayawada', 1, 0, NULL, NULL, NULL),
((SELECT id FROM states WHERE slug = 'andhra-pradesh'), 'Guntur', 'guntur', 1, 0, NULL, NULL, NULL),

((SELECT id FROM states WHERE slug = 'goa'), 'Panaji', 'panaji', 1, 1,
 'Visagiri assists applicants in Panaji and across Goa, one of India''s most visited destinations, with visa consultancy and application-management support. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa applications for destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore.\n\nGiven Goa''s tourism, hospitality, and merchant-navy community, we assist with a mix of tourist, work, and travel-document related enquiries. We also help with document apostille and attestation.\n\nAs with every Visagiri service, we assist with preparation and process — the visa decision itself is always made by the relevant embassy, consulate, or government immigration authority, and we never guarantee approval or a specific processing time.',
 'Visa Consultant & Visa Agency in Panaji, Goa | Visagiri',
 'Visagiri offers visa consultancy, application assistance, and document attestation support for applicants in Panaji, Goa. Enquire online.'),
((SELECT id FROM states WHERE slug = 'goa'), 'Margao', 'margao', 1, 0, NULL, NULL, NULL),
((SELECT id FROM states WHERE slug = 'goa'), 'Vasco da Gama', 'vasco-da-gama', 1, 0, NULL, NULL, NULL),

((SELECT id FROM states WHERE slug = 'assam'), 'Guwahati', 'guwahati', 1, 1,
 'Visagiri assists applicants in Guwahati, the principal gateway city for Northeast India, with visa consultancy and application-management support. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa applications for destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore.\n\nAs travel and study-abroad awareness grows across the Northeast, we assist Guwahati-based applicants with tourist, student, and work-visa documentation. We also help with document apostille and attestation.\n\nAs with every Visagiri service, we assist with preparation and process — the visa decision itself is always made by the relevant embassy, consulate, or government immigration authority, and we never guarantee approval or a specific processing time.',
 'Visa Consultant & Visa Agency in Guwahati | Visagiri',
 'Visagiri offers visa consultancy, application assistance, and document attestation support for applicants in Guwahati. Enquire online.'),
((SELECT id FROM states WHERE slug = 'assam'), 'Dibrugarh', 'dibrugarh', 1, 0, NULL, NULL, NULL),
((SELECT id FROM states WHERE slug = 'assam'), 'Silchar', 'silchar', 1, 0, NULL, NULL, NULL),

((SELECT id FROM states WHERE slug = 'madhya-pradesh'), 'Indore', 'indore', 1, 1,
 'Visagiri assists applicants in Indore, Madhya Pradesh''s largest and fastest-growing commercial city, with visa consultancy and application-management support. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa applications for destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore.\n\nIndore''s growing trade, education, and business sectors mean we assist with a broad mix of business, student, and tourist-visa applications. We also help with document apostille and attestation.\n\nAs with every Visagiri service, we assist with preparation and process — the visa decision itself is always made by the relevant embassy, consulate, or government immigration authority, and we never guarantee approval or a specific processing time.',
 'Visa Consultant & Visa Agency in Indore | Visagiri',
 'Visagiri offers visa consultancy, application assistance, and document attestation support for applicants in Indore. Enquire online.'),
((SELECT id FROM states WHERE slug = 'madhya-pradesh'), 'Bhopal', 'bhopal', 1, 0, NULL, NULL, NULL),
((SELECT id FROM states WHERE slug = 'madhya-pradesh'), 'Jabalpur', 'jabalpur', 1, 0, NULL, NULL, NULL),

((SELECT id FROM states WHERE slug = 'odisha'), 'Bhubaneswar', 'bhubaneswar', 1, 1,
 'Visagiri assists applicants in Bhubaneswar, an emerging IT and education hub in Eastern India, with visa consultancy and application-management support. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa applications for destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore.\n\nBhubaneswar''s growing technology and education sectors mean we increasingly assist with student and work-visa applications, alongside tourist and family-visit visas. We also help with document apostille and attestation.\n\nAs with every Visagiri service, we assist with preparation and process — the visa decision itself is always made by the relevant embassy, consulate, or government immigration authority, and we never guarantee approval or a specific processing time.',
 'Visa Consultant & Visa Agency in Bhubaneswar | Visagiri',
 'Visagiri offers visa consultancy, application assistance, and document attestation support for applicants in Bhubaneswar. Enquire online.'),
((SELECT id FROM states WHERE slug = 'odisha'), 'Cuttack', 'cuttack', 1, 0, NULL, NULL, NULL),
((SELECT id FROM states WHERE slug = 'odisha'), 'Rourkela', 'rourkela', 1, 0, NULL, NULL, NULL);

-- Location FAQs — genuinely different questions per state/city, not
-- the same FAQ with the name swapped.
INSERT INTO location_faqs (question, answer, state_id, city_id, sort_order) VALUES
('Can Visagiri help with Canada or UK study-visa applications from Punjab?', 'Yes. Given Punjab''s strong tradition of international study and migration, we regularly assist applicants with student-visa documentation for Canada, the UK, and Australia, alongside other visa categories.', (SELECT id FROM states WHERE slug = 'punjab'), NULL, 1),

('Does Visagiri assist with Gulf work-visa documentation from Kerala?', 'Yes. Given Kerala''s established ties to the UAE, Saudi Arabia, and other Gulf countries, we assist with work-visa documentation for Gulf employment alongside our standard visa services.', (SELECT id FROM states WHERE slug = 'kerala'), NULL, 1),

('Does Visagiri assist multinational company employees in Gurugram with business visas?', 'Yes. Given Gurugram''s large base of multinational companies, we regularly help with business and work-visa documentation and application management.', NULL, (SELECT id FROM cities WHERE slug = 'gurugram'), 1),

('Can Visagiri help students from Andhra Pradesh apply for US study visas?', 'Yes. Given the state''s strong ties to US academic institutions, we assist with student-visa documentation and application management for the USA and other destinations.', (SELECT id FROM states WHERE slug = 'andhra-pradesh'), NULL, 1),

('Does Visagiri help with travel documentation for Goa''s merchant-navy and tourism workforce?', 'Yes. We assist applicants connected to Goa''s tourism, hospitality, and merchant-navy sectors with travel-document preparation alongside our standard visa services.', (SELECT id FROM states WHERE slug = 'goa'), NULL, 1),

('Does Visagiri serve applicants from smaller cities and towns in Assam, not just Guwahati?', 'Yes. While our nearest full-service coverage is centred on Guwahati, we assist applicants from across Assam, including Dibrugarh and Silchar, through remote consultation and online document handling.', (SELECT id FROM states WHERE slug = 'assam'), NULL, 1),

('Can Visagiri help Indore-based businesses with visa applications for overseas trips?', 'Yes. Given Indore''s growing trade and business community, we assist with business-visa documentation and application management for a range of international destinations.', NULL, (SELECT id FROM cities WHERE slug = 'indore'), 1),

('Does Visagiri assist students in Bhubaneswar with study-visa applications?', 'Yes. Given Bhubaneswar''s growing education sector, we assist students with visa documentation and application management for study destinations including the USA, UK, Canada, and Australia.', NULL, (SELECT id FROM cities WHERE slug = 'bhubaneswar'), 1);
