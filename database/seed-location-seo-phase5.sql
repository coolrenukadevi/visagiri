-- National Location SEO — Phase 5 (final batch): the last 9
-- states/UTs (Ladakh, Andaman and Nicobar Islands, Lakshadweep,
-- Arunachal Pradesh, Manipur, Meghalaya, Mizoram, Nagaland, Sikkim).
-- Deliberately handled last and separately from Phases 2-4: these are
-- the smallest-population entities in the seed, so each one's content
-- is anchored to a single, specific, well-documented real fact rather
-- than a generic "growing demand" claim repeated nine times — and for
-- the smallest (Lakshadweep especially), the copy stays modest rather
-- than implying a business volume this build has no basis for
-- claiming. The 3 union territories (Ladakh, Andaman and Nicobar
-- Islands, Lakshadweep) get no separate city page, same reasoning as
-- Chandigarh/Puducherry in Phase 4 — each is a single administrative
-- hub already fully represented by its own state-level page. The 6
-- full states each get one real primary city (their capital).
-- office_address stays NULL throughout — none of these is a real
-- Visagiri office. Run after seed-location-seo-phase4.sql. This
-- completes all 36 states/UTs (some indexable, some still draft).

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Ladakh, a high-altitude Himalayan union territory known for adventure tourism and its Buddhist monastic heritage. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nWe assist applicants based in Ladakh remotely through phone, WhatsApp, and online document submission, helping with visa documentation for study, work, tourism, and family-visit purposes.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from across Ladakh can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Ladakh | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Ladakh. Enquire online.'
WHERE slug = 'ladakh';

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across the Andaman and Nicobar Islands, an island territory known for tourism and its historic Cellular Jail. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nWe assist applicants based in the Andaman and Nicobar Islands remotely through phone, WhatsApp, and online document submission, helping with visa documentation for study, work, tourism, and family-visit purposes.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from across the territory can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Andaman and Nicobar Islands | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across the Andaman and Nicobar Islands. Enquire online.'
WHERE slug = 'andaman-and-nicobar-islands';

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Lakshadweep, India''s smallest union territory, a coral island archipelago in the Arabian Sea. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nGiven Lakshadweep''s small population and geographic distance from the mainland, we assist applicants entirely remotely, through phone, WhatsApp, and online document submission, for whatever visa category their travel requires.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from Lakshadweep can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Lakshadweep | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Lakshadweep. Enquire online.'
WHERE slug = 'lakshadweep';

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Arunachal Pradesh, including Itanagar, the largest of India''s Northeastern states by area. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nAs travel and study-abroad awareness grows across Arunachal Pradesh, we assist applicants with tourist, student, and work-visa documentation, along with document apostille and attestation.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from across Arunachal Pradesh can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Arunachal Pradesh | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Arunachal Pradesh, including Itanagar. Enquire online.'
WHERE slug = 'arunachal-pradesh';

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Manipur, including Imphal, a state widely known for producing many of India''s top international athletes. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nGiven Manipur''s strong sporting culture, we assist with sports-visa documentation for international competitions and training programmes, alongside tourist, student, and work-visa applications.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from across Manipur can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Manipur | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Manipur, including Imphal. Enquire online.'
WHERE slug = 'manipur';

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Meghalaya, including Shillong, a major tourism destination known for its high rainfall and distinct matrilineal culture. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nGiven Shillong''s tourism economy and growing student interest in studying abroad, we assist applicants with tourist and student-visa documentation, alongside work and family-visit visas.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from across Meghalaya can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Meghalaya | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Meghalaya, including Shillong. Enquire online.'
WHERE slug = 'meghalaya';

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Mizoram, including Aizawl, a state with one of India''s highest literacy rates. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nGiven Mizoram''s strong education outcomes, we assist a growing number of applicants with student-visa documentation, alongside tourist, work, and family-visit visas.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from across Mizoram can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Mizoram | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Mizoram, including Aizawl. Enquire online.'
WHERE slug = 'mizoram';

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Nagaland, including Kohima, a state known for its distinct tribal culture and the annual Hornbill Festival. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nAs international travel and study-abroad awareness grows across Nagaland, we assist applicants with tourist, student, and work-visa documentation, along with document apostille and attestation.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from across Nagaland can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Nagaland | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Nagaland, including Kohima. Enquire online.'
WHERE slug = 'nagaland';

UPDATE states SET is_indexable = 1,
  intro_content = 'Visagiri provides visa consultancy and application-management assistance to applicants across Sikkim, including Gangtok, India''s first fully organic-farming state and a major Himalayan tourism destination. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nGiven Gangtok''s tourism and hospitality economy, we assist applicants with tourist and work-visa documentation, alongside a growing number of student-visa applications.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from across Sikkim can reach our team for a consultation, document checklist, and application-status support.',
  meta_title = 'Visa Consultant & Visa Agency in Sikkim | Visagiri',
  meta_description = 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Sikkim, including Gangtok. Enquire online.'
WHERE slug = 'sikkim';

-- Primary indexable city for the 6 full states (office_address left
-- NULL — none is a real Visagiri office). Ladakh, Andaman and
-- Nicobar Islands, and Lakshadweep get no separate city row — each
-- is a single administrative hub already fully represented by its
-- own state/UT page.

INSERT INTO cities (state_id, name, slug, is_major, is_indexable, intro_content, meta_title, meta_description) VALUES
((SELECT id FROM states WHERE slug = 'arunachal-pradesh'), 'Itanagar', 'itanagar', 1, 1,
 'Visagiri assists applicants in Itanagar and across Arunachal Pradesh with visa consultancy and application-management support. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa applications for destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore.\n\nWe assist Itanagar-based applicants with documentation and application management for study, work, tourism, and family-visit purposes, along with document apostille and attestation.\n\nAs with every Visagiri service, we assist with preparation and process — the visa decision itself is always made by the relevant embassy, consulate, or government immigration authority, and we never guarantee approval or a specific processing time.',
 'Visa Consultant & Visa Agency in Itanagar | Visagiri',
 'Visagiri offers visa consultancy, application assistance, and document attestation support for applicants in Itanagar. Enquire online.'),

((SELECT id FROM states WHERE slug = 'manipur'), 'Imphal', 'imphal', 1, 1,
 'Visagiri assists applicants in Imphal, a city widely known for producing many of India''s top international athletes, with visa consultancy and application-management support. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa applications for destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore.\n\nGiven Imphal''s strong sporting culture, we assist with sports-visa documentation for international competitions and training programmes, alongside our other visa services. We also help with document apostille and attestation.\n\nAs with every Visagiri service, we assist with preparation and process — the visa decision itself is always made by the relevant embassy, consulate, or government immigration authority, and we never guarantee approval or a specific processing time.',
 'Visa Consultant & Visa Agency in Imphal | Visagiri',
 'Visagiri offers visa consultancy, application assistance, and document attestation support for applicants in Imphal. Enquire online.'),

((SELECT id FROM states WHERE slug = 'meghalaya'), 'Shillong', 'shillong', 1, 1,
 'Visagiri assists applicants in Shillong, a major tourism destination known for its high rainfall and distinct matrilineal culture, with visa consultancy and application-management support. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa applications for destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore.\n\nGiven Shillong''s tourism economy and growing student interest in studying abroad, we assist with tourist and student-visa documentation, alongside work and family-visit visas. We also help with document apostille and attestation.\n\nAs with every Visagiri service, we assist with preparation and process — the visa decision itself is always made by the relevant embassy, consulate, or government immigration authority, and we never guarantee approval or a specific processing time.',
 'Visa Consultant & Visa Agency in Shillong | Visagiri',
 'Visagiri offers visa consultancy, application assistance, and document attestation support for applicants in Shillong. Enquire online.'),

((SELECT id FROM states WHERE slug = 'mizoram'), 'Aizawl', 'aizawl', 1, 1,
 'Visagiri assists applicants in Aizawl, a city in a state with one of India''s highest literacy rates, with visa consultancy and application-management support. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa applications for destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore.\n\nGiven the region''s strong education outcomes, we assist a growing number of Aizawl-based applicants with student-visa documentation, alongside tourist, work, and family-visit visas. We also help with document apostille and attestation.\n\nAs with every Visagiri service, we assist with preparation and process — the visa decision itself is always made by the relevant embassy, consulate, or government immigration authority, and we never guarantee approval or a specific processing time.',
 'Visa Consultant & Visa Agency in Aizawl | Visagiri',
 'Visagiri offers visa consultancy, application assistance, and document attestation support for applicants in Aizawl. Enquire online.'),

((SELECT id FROM states WHERE slug = 'nagaland'), 'Kohima', 'kohima', 1, 1,
 'Visagiri assists applicants in Kohima, home to the annual Hornbill Festival, with visa consultancy and application-management support. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa applications for destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore.\n\nWe assist Kohima-based applicants with documentation and application management for study, work, tourism, and family-visit purposes, along with document apostille and attestation.\n\nAs with every Visagiri service, we assist with preparation and process — the visa decision itself is always made by the relevant embassy, consulate, or government immigration authority, and we never guarantee approval or a specific processing time.',
 'Visa Consultant & Visa Agency in Kohima | Visagiri',
 'Visagiri offers visa consultancy, application assistance, and document attestation support for applicants in Kohima. Enquire online.'),

((SELECT id FROM states WHERE slug = 'sikkim'), 'Gangtok', 'gangtok', 1, 1,
 'Visagiri assists applicants in Gangtok, capital of India''s first fully organic-farming state and a major Himalayan tourism destination, with visa consultancy and application-management support. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa applications for destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore.\n\nGiven Gangtok''s tourism and hospitality economy, we assist with tourist and work-visa documentation, alongside a growing number of student-visa applications. We also help with document apostille and attestation.\n\nAs with every Visagiri service, we assist with preparation and process — the visa decision itself is always made by the relevant embassy, consulate, or government immigration authority, and we never guarantee approval or a specific processing time.',
 'Visa Consultant & Visa Agency in Gangtok | Visagiri',
 'Visagiri offers visa consultancy, application assistance, and document attestation support for applicants in Gangtok. Enquire online.');

-- Location FAQs — genuinely different questions per state/city, kept
-- modest and honest for the smallest-population entities rather than
-- implying a demand level this build has no basis for claiming.
INSERT INTO location_faqs (question, answer, state_id, city_id, sort_order) VALUES
('Does Visagiri serve applicants in remote parts of Ladakh?', 'Yes. We assist applicants across Ladakh entirely remotely, through phone, WhatsApp, and online document submission, regardless of which town or village they are based in.', (SELECT id FROM states WHERE slug = 'ladakh'), NULL, 1),

('Can Visagiri help island residents in Lakshadweep apply for a visa without visiting an office in person?', 'Yes. Given the distance from the mainland, our entire process for Lakshadweep-based applicants is handled remotely — consultation, document review, and application management, all online or by phone.', (SELECT id FROM states WHERE slug = 'lakshadweep'), NULL, 1),

('Does Visagiri assist Manipur-based athletes with sports-visa applications?', 'Yes. Given Manipur''s strong sporting culture, we assist with sports-visa documentation for international competitions and training programmes.', NULL, (SELECT id FROM cities WHERE slug = 'imphal'), 1),

('Does Visagiri assist Meghalaya students with study-visa applications?', 'Yes. We assist students from Shillong and across Meghalaya with visa documentation and application management for study destinations including the UK, Canada, and Australia.', NULL, (SELECT id FROM cities WHERE slug = 'shillong'), 1),

('Does Visagiri assist Nagaland residents travelling for the Hornbill Festival''s international visitors or related events abroad?', 'We assist Nagaland-based applicants with tourist, business, and other visa categories for international travel, including documentation related to cultural exchange and event travel.', NULL, (SELECT id FROM cities WHERE slug = 'kohima'), 1),

('Does Visagiri serve applicants from smaller towns across Sikkim, not just Gangtok?', 'Yes. We assist applicants from across Sikkim through remote consultation and online document handling, regardless of which town they are based in.', (SELECT id FROM states WHERE slug = 'sikkim'), NULL, 1);
