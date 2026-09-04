-- National Location SEO — Phase 2: the next batch of 8 states/UTs
-- (Delhi, Maharashtra, Karnataka, West Bengal, Telangana, Tamil Nadu,
-- Gujarat, Rajasthan), each with real, distinct hand-written content
-- and one fully-authored primary city, following the exact Phase 1
-- pattern (schema-location-seo.sql). None of these cities has a real
-- Visagiri office — office_address stays NULL for all of them, so
-- every new city page emits Service schema and honest "served
-- remotely" language, never LocalBusiness. Delhi is a UT that already
-- functions as a single city-state, so it gets no separate city row
-- (would just duplicate the state page's own content). Run after
-- schema-location-seo.sql and seed-location-seo.sql.

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Delhi, home to most foreign embassies and consulates in India. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nBecause so many embassies, high commissions, and visa application centres are based in Delhi, our team regularly assists applicants who need appointment guidance and document preparation ahead of an in-person submission. We are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department.\n\nWhile Visagiri''s own offices are in Patna (Bihar) and Noida (Uttar Pradesh), we assist Delhi-based applicants remotely through phone, WhatsApp, and online document submission, and can coordinate around your embassy appointment timelines.',
  meta_title = 'Visa Consultant & Visa Agency in Delhi | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Delhi. Enquire online.'
WHERE slug = 'delhi';

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Maharashtra, including Mumbai, India''s financial capital and a major hub for international business travel. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nMumbai''s large corporate, finance, and trading community means we regularly assist with business-visa documentation alongside individual tourist and family-visit applications, and Maharashtra''s coastal cities generate steady demand for Gulf and Southeast Asia work-visa assistance as well.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from across Maharashtra can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Maharashtra | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Maharashtra, including Mumbai. Enquire online.'
WHERE slug = 'maharashtra';

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Karnataka, including Bengaluru, India''s leading technology and IT-services hub. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nBengaluru''s large software and technology workforce generates significant demand for business and work-visa assistance, particularly for onsite assignments in the USA, UK, and Canada, alongside steady student-visa interest from applicants heading abroad for higher education.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from across Karnataka can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Karnataka | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Karnataka, including Bengaluru. Enquire online.'
WHERE slug = 'karnataka';

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across West Bengal, including Kolkata, a historic gateway for international travel from Eastern India. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nKolkata''s long-standing trade and education links abroad mean we regularly assist with both business-visa applications and student-visa documentation, alongside tourist and family-visit enquiries from across the state.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from across West Bengal can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in West Bengal | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across West Bengal, including Kolkata. Enquire online.'
WHERE slug = 'west-bengal';

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Telangana, including Hyderabad, a major hub for IT and pharmaceutical companies. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nHyderabad''s technology and life-sciences workforce generates steady demand for business and work-visa assistance, particularly for the USA and UK, alongside student-visa applications from those pursuing higher education abroad.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from across Telangana can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Telangana | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Telangana, including Hyderabad. Enquire online.'
WHERE slug = 'telangana';

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Tamil Nadu, including Chennai, a major centre for IT, manufacturing, and healthcare. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nChennai''s diverse industrial base and strong ties to Southeast Asia and the Gulf mean we assist with business and work-visa applications across a wide range of destinations, alongside tourist, medical-travel, and student-visa applications.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from across Tamil Nadu can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Tamil Nadu | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Tamil Nadu, including Chennai. Enquire online.'
WHERE slug = 'tamil-nadu';

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Gujarat, including Ahmedabad, home to a large and internationally-connected business community. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nGujarat''s strong trading and entrepreneurial community, with well-established family and business ties in the USA, UK, and East Africa, generates consistent demand for business, family-visit, and tourist visa assistance, alongside growing student-visa interest.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from across Gujarat can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Gujarat | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Gujarat, including Ahmedabad. Enquire online.'
WHERE slug = 'gujarat';

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Rajasthan, including Jaipur, one of India''s most visited tourist destinations. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nRajasthan''s tourism and hospitality sector, alongside a growing number of students and professionals travelling abroad, means we assist with a mix of tourist, student, and work-visa applications from across the state.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from across Rajasthan can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Rajasthan | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Rajasthan, including Jaipur. Enquire online.'
WHERE slug = 'rajasthan';

-- Primary indexable city per state (real content, office_address
-- left NULL — none of these are real Visagiri offices) plus real,
-- unauthored stub city names for the "Cities We Serve" list.

INSERT INTO cities (state_id, name, slug, is_major, is_indexable, intro_content, meta_title, meta_description) VALUES
((SELECT id FROM states WHERE slug = 'maharashtra'), 'Mumbai', 'mumbai', 1, 1,
 'Visagiri assists applicants in Mumbai, India''s financial capital, with visa consultancy and application-management support. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa applications for destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore.\n\nGiven Mumbai''s large corporate, finance, and trading workforce, we regularly assist with business-visa documentation, along with tourist and family-visit applications. We also help with document apostille and attestation for those relocating or travelling for work.\n\nAs with every Visagiri service, we assist with preparation and process — the visa decision itself is always made by the relevant embassy, consulate, or government immigration authority, and we never guarantee approval or a specific processing time.',
 'Visa Consultant & Visa Agency in Mumbai | Visagiri',
 'Visagiri offers visa consultancy, application assistance, and document attestation support for applicants in Mumbai. Enquire online.'),
((SELECT id FROM states WHERE slug = 'maharashtra'), 'Pune', 'pune', 1, 0, NULL, NULL, NULL),
((SELECT id FROM states WHERE slug = 'maharashtra'), 'Nagpur', 'nagpur', 1, 0, NULL, NULL, NULL),
((SELECT id FROM states WHERE slug = 'maharashtra'), 'Nashik', 'nashik', 1, 0, NULL, NULL, NULL),

((SELECT id FROM states WHERE slug = 'karnataka'), 'Bengaluru', 'bengaluru', 1, 1,
 'Visagiri assists applicants in Bengaluru, India''s leading technology hub, with visa consultancy and application-management support. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa applications for destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore.\n\nGiven Bengaluru''s large IT and software workforce, we regularly assist with business and work-visa documentation for onsite assignments, alongside student-visa applications for those pursuing higher education abroad. We also help with document apostille and attestation.\n\nAs with every Visagiri service, we assist with preparation and process — the visa decision itself is always made by the relevant embassy, consulate, or government immigration authority, and we never guarantee approval or a specific processing time.',
 'Visa Consultant & Visa Agency in Bengaluru | Visagiri',
 'Visagiri offers visa consultancy, application assistance, and document attestation support for applicants in Bengaluru. Enquire online.'),
((SELECT id FROM states WHERE slug = 'karnataka'), 'Mysuru', 'mysuru', 1, 0, NULL, NULL, NULL),
((SELECT id FROM states WHERE slug = 'karnataka'), 'Mangaluru', 'mangaluru', 1, 0, NULL, NULL, NULL),

((SELECT id FROM states WHERE slug = 'west-bengal'), 'Kolkata', 'kolkata', 1, 1,
 'Visagiri assists applicants in Kolkata, a historic gateway for international travel from Eastern India, with visa consultancy and application-management support. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa applications for destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore.\n\nKolkata''s long-standing trade and education links abroad mean we assist with both business and student-visa documentation, alongside tourist and family-visit applications. We also help with document apostille and attestation.\n\nAs with every Visagiri service, we assist with preparation and process — the visa decision itself is always made by the relevant embassy, consulate, or government immigration authority, and we never guarantee approval or a specific processing time.',
 'Visa Consultant & Visa Agency in Kolkata | Visagiri',
 'Visagiri offers visa consultancy, application assistance, and document attestation support for applicants in Kolkata. Enquire online.'),
((SELECT id FROM states WHERE slug = 'west-bengal'), 'Siliguri', 'siliguri', 1, 0, NULL, NULL, NULL),
((SELECT id FROM states WHERE slug = 'west-bengal'), 'Durgapur', 'durgapur', 1, 0, NULL, NULL, NULL),

((SELECT id FROM states WHERE slug = 'telangana'), 'Hyderabad', 'hyderabad', 1, 1,
 'Visagiri assists applicants in Hyderabad, a major hub for IT and pharmaceutical companies, with visa consultancy and application-management support. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa applications for destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore.\n\nGiven Hyderabad''s technology and life-sciences workforce, we regularly assist with business and work-visa documentation, alongside student-visa applications for those pursuing higher education abroad. We also help with document apostille and attestation.\n\nAs with every Visagiri service, we assist with preparation and process — the visa decision itself is always made by the relevant embassy, consulate, or government immigration authority, and we never guarantee approval or a specific processing time.',
 'Visa Consultant & Visa Agency in Hyderabad | Visagiri',
 'Visagiri offers visa consultancy, application assistance, and document attestation support for applicants in Hyderabad. Enquire online.'),
((SELECT id FROM states WHERE slug = 'telangana'), 'Warangal', 'warangal', 1, 0, NULL, NULL, NULL),

((SELECT id FROM states WHERE slug = 'tamil-nadu'), 'Chennai', 'chennai', 1, 1,
 'Visagiri assists applicants in Chennai, a major centre for IT, manufacturing, and healthcare, with visa consultancy and application-management support. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa applications for destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore.\n\nChennai''s diverse industrial base and strong ties to Southeast Asia and the Gulf mean we assist with business and work-visa applications across a wide range of destinations, alongside medical-travel and student-visa applications. We also help with document apostille and attestation.\n\nAs with every Visagiri service, we assist with preparation and process — the visa decision itself is always made by the relevant embassy, consulate, or government immigration authority, and we never guarantee approval or a specific processing time.',
 'Visa Consultant & Visa Agency in Chennai | Visagiri',
 'Visagiri offers visa consultancy, application assistance, and document attestation support for applicants in Chennai. Enquire online.'),
((SELECT id FROM states WHERE slug = 'tamil-nadu'), 'Coimbatore', 'coimbatore', 1, 0, NULL, NULL, NULL),
((SELECT id FROM states WHERE slug = 'tamil-nadu'), 'Madurai', 'madurai', 1, 0, NULL, NULL, NULL),

((SELECT id FROM states WHERE slug = 'gujarat'), 'Ahmedabad', 'ahmedabad', 1, 1,
 'Visagiri assists applicants in Ahmedabad, home to a large and internationally-connected business community, with visa consultancy and application-management support. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa applications for destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore.\n\nAhmedabad''s strong trading and entrepreneurial community, with well-established family and business ties abroad, generates consistent demand for business, family-visit, and tourist visa assistance, alongside growing student-visa interest. We also help with document apostille and attestation.\n\nAs with every Visagiri service, we assist with preparation and process — the visa decision itself is always made by the relevant embassy, consulate, or government immigration authority, and we never guarantee approval or a specific processing time.',
 'Visa Consultant & Visa Agency in Ahmedabad | Visagiri',
 'Visagiri offers visa consultancy, application assistance, and document attestation support for applicants in Ahmedabad. Enquire online.'),
((SELECT id FROM states WHERE slug = 'gujarat'), 'Surat', 'surat', 1, 0, NULL, NULL, NULL),
((SELECT id FROM states WHERE slug = 'gujarat'), 'Vadodara', 'vadodara', 1, 0, NULL, NULL, NULL),

((SELECT id FROM states WHERE slug = 'rajasthan'), 'Jaipur', 'jaipur', 1, 1,
 'Visagiri assists applicants in Jaipur, one of India''s most visited tourist destinations, with visa consultancy and application-management support. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa applications for destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore.\n\nGiven Jaipur''s strong tourism and hospitality sector, alongside a growing number of students and professionals travelling abroad, we assist with a mix of tourist, student, and work-visa applications. We also help with document apostille and attestation.\n\nAs with every Visagiri service, we assist with preparation and process — the visa decision itself is always made by the relevant embassy, consulate, or government immigration authority, and we never guarantee approval or a specific processing time.',
 'Visa Consultant & Visa Agency in Jaipur | Visagiri',
 'Visagiri offers visa consultancy, application assistance, and document attestation support for applicants in Jaipur. Enquire online.'),
((SELECT id FROM states WHERE slug = 'rajasthan'), 'Jodhpur', 'jodhpur', 1, 0, NULL, NULL, NULL),
((SELECT id FROM states WHERE slug = 'rajasthan'), 'Udaipur', 'udaipur', 1, 0, NULL, NULL, NULL);

-- Location FAQs — genuinely different questions per state/city, not
-- the same FAQ with the name swapped.
INSERT INTO location_faqs (question, answer, state_id, city_id, sort_order) VALUES
('Does Visagiri have a physical office in Delhi?', 'No. Visagiri''s offices are in Patna, Bihar and Noida, Uttar Pradesh. We assist Delhi-based applicants remotely through phone, WhatsApp, and online document submission, and can help coordinate around embassy appointment timelines given how many missions are based in Delhi.', (SELECT id FROM states WHERE slug = 'delhi'), NULL, 1),
('Can Visagiri help me prepare for an embassy appointment in Delhi?', 'Yes. We help applicants understand what to expect, organise required documents, and address common questions ahead of an in-person visa interview or biometric appointment at an embassy or visa application centre in Delhi.', (SELECT id FROM states WHERE slug = 'delhi'), NULL, 2),

('Does Visagiri assist with business visas for Mumbai-based companies?', 'Yes. We regularly help Mumbai-based professionals and businesses with business-visa documentation and application management for destinations including the USA, UK, and the Schengen Area.', NULL, (SELECT id FROM cities WHERE slug = 'mumbai'), 1),

('Does Visagiri assist with work visas for IT professionals in Bengaluru?', 'Yes. Given Bengaluru''s large technology workforce, we regularly help with work and business-visa documentation for onsite assignments in the USA, UK, and Canada, as well as student-visa applications.', NULL, (SELECT id FROM cities WHERE slug = 'bengaluru'), 1),

('Can Visagiri help with student visa applications from Kolkata?', 'Yes. We assist Kolkata-based students with document preparation and application management for study destinations including the USA, UK, Canada, and Australia.', NULL, (SELECT id FROM cities WHERE slug = 'kolkata'), 1),

('Does Visagiri assist pharmaceutical and IT professionals in Hyderabad with work visas?', 'Yes. We help Hyderabad-based professionals in the technology and life-sciences sectors with work and business-visa documentation for the USA, UK, and other destinations.', NULL, (SELECT id FROM cities WHERE slug = 'hyderabad'), 1),

('Can Visagiri help with medical-travel visa documentation from Chennai?', 'Yes. We assist applicants from Chennai with documentation for medical-visit visas, alongside our standard tourist, business, and student-visa services.', NULL, (SELECT id FROM cities WHERE slug = 'chennai'), 1),

('Does Visagiri assist Ahmedabad-based families with visit visas?', 'Yes. We regularly help applicants from Ahmedabad with family-visit and tourist-visa documentation for destinations with established Gujarati communities abroad, including the USA and UK.', NULL, (SELECT id FROM cities WHERE slug = 'ahmedabad'), 1),

('Can Visagiri help Jaipur-based applicants with tourist visas?', 'Yes. Given Jaipur''s strong tourism sector, we regularly assist with tourist-visa documentation for popular international destinations, alongside student and work-visa applications.', NULL, (SELECT id FROM cities WHERE slug = 'jaipur'), 1);
