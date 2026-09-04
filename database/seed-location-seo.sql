-- National Location SEO — Phase 1 seed. All 28 states + 8 union
-- territories are real geographic fact (name/slug/type/zone), safe to
-- seed in full immediately. Only Bihar and Uttar Pradesh ship
-- is_indexable = 1 with real, hand-written content in this phase —
-- every other row stays is_indexable = 0 (noindexed, admin-
-- previewable) until content is genuinely authored for it in a later
-- phase. Run after schema-location-seo.sql.

INSERT INTO states (name, slug, type, zone, is_indexable, intro_content, meta_title, meta_description) VALUES
('Andhra Pradesh', 'andhra-pradesh', 'state', 'South', 0, NULL, NULL, NULL),
('Arunachal Pradesh', 'arunachal-pradesh', 'state', 'Northeast', 0, NULL, NULL, NULL),
('Assam', 'assam', 'state', 'Northeast', 0, NULL, NULL, NULL),
('Bihar', 'bihar', 'state', 'East', 1,
 'Visagiri provides visa consultancy and application-management assistance to applicants across Bihar, with our team based in Patna. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Our role is to help you understand requirements, prepare documentation, and manage your application process correctly.\n\nApplicants from Patna, Gaya, Muzaffarpur, Bhagalpur, Darbhanga and other parts of Bihar can reach our team for a consultation, document checklist, and application-status support.',
 'Visa Consultant & Visa Agency in Bihar | Visagiri',
 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Bihar, with our team based in Patna. Enquire online.'),
('Chhattisgarh', 'chhattisgarh', 'state', 'Central', 0, NULL, NULL, NULL),
('Goa', 'goa', 'state', 'West', 0, NULL, NULL, NULL),
('Gujarat', 'gujarat', 'state', 'West', 0, NULL, NULL, NULL),
('Haryana', 'haryana', 'state', 'North', 0, NULL, NULL, NULL),
('Himachal Pradesh', 'himachal-pradesh', 'state', 'North', 0, NULL, NULL, NULL),
('Jharkhand', 'jharkhand', 'state', 'East', 0, NULL, NULL, NULL),
('Karnataka', 'karnataka', 'state', 'South', 0, NULL, NULL, NULL),
('Kerala', 'kerala', 'state', 'South', 0, NULL, NULL, NULL),
('Madhya Pradesh', 'madhya-pradesh', 'state', 'Central', 0, NULL, NULL, NULL),
('Maharashtra', 'maharashtra', 'state', 'West', 0, NULL, NULL, NULL),
('Manipur', 'manipur', 'state', 'Northeast', 0, NULL, NULL, NULL),
('Meghalaya', 'meghalaya', 'state', 'Northeast', 0, NULL, NULL, NULL),
('Mizoram', 'mizoram', 'state', 'Northeast', 0, NULL, NULL, NULL),
('Nagaland', 'nagaland', 'state', 'Northeast', 0, NULL, NULL, NULL),
('Odisha', 'odisha', 'state', 'East', 0, NULL, NULL, NULL),
('Punjab', 'punjab', 'state', 'North', 0, NULL, NULL, NULL),
('Rajasthan', 'rajasthan', 'state', 'North', 0, NULL, NULL, NULL),
('Sikkim', 'sikkim', 'state', 'Northeast', 0, NULL, NULL, NULL),
('Tamil Nadu', 'tamil-nadu', 'state', 'South', 0, NULL, NULL, NULL),
('Telangana', 'telangana', 'state', 'South', 0, NULL, NULL, NULL),
('Tripura', 'tripura', 'state', 'Northeast', 0, NULL, NULL, NULL),
('Uttar Pradesh', 'uttar-pradesh', 'state', 'North', 1,
 'Visagiri provides visa consultancy and application-management assistance to applicants across Uttar Pradesh, with our team based in Noida (Gautam Buddha Nagar), part of the Delhi-NCR region. We help with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories for popular destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore, along with document apostille and attestation support.\n\nBeing based in Noida means we work closely with the many corporate and IT-sector professionals in the NCR area who need business and work-visa assistance, alongside individual tourist and family-visit applicants from across the state.\n\nWe are a visa consultancy and application-assistance service, not the visa-issuing authority — every visa decision rests solely with the relevant embassy, consulate, or government immigration department. Applicants from Noida, Lucknow, Kanpur, Varanasi, Agra, Ghaziabad and other parts of Uttar Pradesh can reach our team for a consultation, document checklist, and application-status support.',
 'Visa Consultant & Visa Agency in Uttar Pradesh | Visagiri',
 'Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across Uttar Pradesh, with our team based in Noida. Enquire online.'),
('Uttarakhand', 'uttarakhand', 'state', 'North', 0, NULL, NULL, NULL),
('West Bengal', 'west-bengal', 'state', 'East', 0, NULL, NULL, NULL),
('Andaman and Nicobar Islands', 'andaman-and-nicobar-islands', 'union_territory', 'South', 0, NULL, NULL, NULL),
('Chandigarh', 'chandigarh', 'union_territory', 'North', 0, NULL, NULL, NULL),
('Dadra and Nagar Haveli and Daman and Diu', 'dadra-and-nagar-haveli-and-daman-and-diu', 'union_territory', 'West', 0, NULL, NULL, NULL),
('Delhi', 'delhi', 'union_territory', 'North', 0, NULL, NULL, NULL),
('Jammu and Kashmir', 'jammu-and-kashmir', 'union_territory', 'North', 0, NULL, NULL, NULL),
('Ladakh', 'ladakh', 'union_territory', 'North', 0, NULL, NULL, NULL),
('Lakshadweep', 'lakshadweep', 'union_territory', 'South', 0, NULL, NULL, NULL),
('Puducherry', 'puducherry', 'union_territory', 'South', 0, NULL, NULL, NULL);

-- Bihar cities: Patna is the fully-authored, indexable pilot with the
-- genuine office address; the rest are real city names listed on the
-- state page as served-but-not-yet-authored (is_indexable = 0, no
-- content yet, no fabricated detail).
INSERT INTO cities (state_id, name, slug, is_major, is_indexable, intro_content, office_address, meta_title, meta_description) VALUES
((SELECT id FROM states WHERE slug = 'bihar'), 'Patna', 'patna', 1, 1,
 'Visagiri''s office is located in Patna, and our team provides visa consultancy and application-management assistance to applicants throughout the city and the wider Patna district. We assist with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa applications for destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore.\n\nBeyond visa consultancy, we also help with document apostille and attestation — a frequent requirement for Patna applicants heading abroad for work or study — and can guide you through gathering, verifying, and organising the documents your application needs.\n\nAs with every Visagiri service, we assist with preparation and process — the visa decision itself is always made by the relevant embassy, consulate, or government immigration authority, and we never guarantee approval or a specific processing time.',
 '203, Sharda Mansion Apartment, Kailashpuri, Kankarbagh, Hanuman Nagar, Patna, Bihar 800020',
 'Visa Consultant & Visa Agency in Patna | Visagiri',
 'Visagiri''s office is in Patna. Get visa consultancy, application assistance, and document attestation support from our local team. Enquire online.'),
((SELECT id FROM states WHERE slug = 'bihar'), 'Gaya', 'gaya', 1, 0, NULL, NULL, NULL, NULL),
((SELECT id FROM states WHERE slug = 'bihar'), 'Muzaffarpur', 'muzaffarpur', 1, 0, NULL, NULL, NULL, NULL),
((SELECT id FROM states WHERE slug = 'bihar'), 'Bhagalpur', 'bhagalpur', 1, 0, NULL, NULL, NULL, NULL),
((SELECT id FROM states WHERE slug = 'bihar'), 'Darbhanga', 'darbhanga', 1, 0, NULL, NULL, NULL, NULL);

-- Uttar Pradesh cities: Noida is the fully-authored, indexable pilot
-- with the genuine office address; the rest are real city names
-- listed on the state page as served-but-not-yet-authored.
INSERT INTO cities (state_id, name, slug, is_major, is_indexable, intro_content, office_address, meta_title, meta_description) VALUES
((SELECT id FROM states WHERE slug = 'uttar-pradesh'), 'Noida', 'noida', 1, 1,
 'Visagiri''s office is located in Noida (Gautam Buddha Nagar), and our team provides visa consultancy and application-management assistance to applicants across Noida, Greater Noida, and the wider Delhi-NCR area. We assist with tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa applications for destinations including the USA, UK, Canada, the Schengen Area, Australia, the UAE, and Singapore.\n\nNoida''s large corporate and IT-sector workforce means we regularly help with business and work-visa applications alongside individual tourist and student visa assistance. We also support document apostille and attestation for applicants who need their educational or personal documents verified for use abroad.\n\nAs with every Visagiri service, we assist with preparation and process — the visa decision itself is always made by the relevant embassy, consulate, or government immigration authority, and we never guarantee approval or a specific processing time.',
 '#UG-5, Provica Homes, Tower-02, Sarfabad, Noida-73, Gautam Buddha Nagar, Uttar Pradesh 201301',
 'Visa Consultant & Visa Agency in Noida | Visagiri',
 'Visagiri''s office is in Noida. Get visa consultancy, application assistance, and document attestation support from our local team. Enquire online.'),
((SELECT id FROM states WHERE slug = 'uttar-pradesh'), 'Lucknow', 'lucknow', 1, 0, NULL, NULL, NULL, NULL),
((SELECT id FROM states WHERE slug = 'uttar-pradesh'), 'Kanpur', 'kanpur', 1, 0, NULL, NULL, NULL, NULL),
((SELECT id FROM states WHERE slug = 'uttar-pradesh'), 'Varanasi', 'varanasi', 1, 0, NULL, NULL, NULL, NULL),
((SELECT id FROM states WHERE slug = 'uttar-pradesh'), 'Agra', 'agra', 1, 0, NULL, NULL, NULL, NULL),
((SELECT id FROM states WHERE slug = 'uttar-pradesh'), 'Ghaziabad', 'ghaziabad', 1, 0, NULL, NULL, NULL, NULL);

-- Location-scoped FAQs (mirrors visa_faqs' nullable-scoping shape).
-- Genuinely different questions per pilot, not the same FAQ with the
-- city name swapped.
INSERT INTO location_faqs (question, answer, state_id, city_id, sort_order) VALUES
('Does Visagiri have a physical office in Patna?', 'Yes. Visagiri''s office is located in Patna, Bihar. You can reach out through our contact page to arrange a consultation.', (SELECT id FROM states WHERE slug = 'bihar'), (SELECT id FROM cities WHERE slug = 'patna'), 1),
('Can Visagiri help with visa applications from anywhere in Bihar, not just Patna?', 'Yes. While our office is based in Patna, we assist applicants from across Bihar, including Gaya, Muzaffarpur, Bhagalpur, and Darbhanga, through phone, WhatsApp, and online document submission.', (SELECT id FROM states WHERE slug = 'bihar'), NULL, 2),
('What documents are usually needed to start a visa application in Patna?', 'Requirements vary by destination and visa type, but commonly include a valid passport, passport-size photographs, proof of travel purpose, and financial and employment documents. Our team reviews your specific case and provides a checklist during consultation.', NULL, (SELECT id FROM cities WHERE slug = 'patna'), 3),
('Does Visagiri have a physical office in Noida?', 'Yes. Visagiri''s office is located in Noida (Gautam Buddha Nagar), Uttar Pradesh, serving the Delhi-NCR region. You can reach out through our contact page to arrange a consultation.', (SELECT id FROM states WHERE slug = 'uttar-pradesh'), (SELECT id FROM cities WHERE slug = 'noida'), 1),
('Can Visagiri assist with business or work visas for professionals based in Noida?', 'Yes. Given Noida''s large corporate and IT-sector presence, we regularly assist working professionals with business and work-visa documentation and application management.', (SELECT id FROM states WHERE slug = 'uttar-pradesh'), (SELECT id FROM cities WHERE slug = 'noida'), 2),
('Does Visagiri serve applicants from other Uttar Pradesh cities like Lucknow or Varanasi?', 'Yes. Our team, based in Noida, assists applicants across Uttar Pradesh, including Lucknow, Kanpur, Varanasi, Agra, and Ghaziabad, through remote consultation and online document handling.', (SELECT id FROM states WHERE slug = 'uttar-pradesh'), NULL, 3);
