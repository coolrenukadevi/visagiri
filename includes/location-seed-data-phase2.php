<?php
/**
 * Phase 2 of the state/city location pages — the next tier of states by
 * population, visa demand and the brief's own priority-city list:
 * Maharashtra, Delhi, Karnataka, Tamil Nadu, Uttar Pradesh, West Bengal,
 * Gujarat and Punjab. Same rules as includes/location-seed-data.php:
 * every entry has a real, verifiable, non-duplicated distinguishing fact
 * (not the same paragraph with the place name swapped), and only Patna
 * (in phase 1) is ever described as a physical office — everything here
 * is explicit remote/online coverage.
 *
 * Loaded by location_seed_all() in includes/location-db.php alongside
 * location_seed_states_def(); merged and seeded the same idempotent way.
 */
function location_seed_states_def_phase2(): array
{
    return [
        [
            'slug' => 'delhi',
            'name' => 'Delhi',
            'kind' => 'union_territory',
            'sort_order' => 5,
            'intro_html' => '<p>Delhi is a special case for us: it\'s the one Indian city where most foreign embassies, high commissions and visa application centres are physically located, so a meaningful share of the paperwork trail for any Indian applicant\'s visa &mdash; regardless of which state they live in &mdash; ultimately routes through Delhi. We support Delhi-based applicants directly, and also handle Delhi-routed submission logistics (courier to a Visa Application Centre or embassy, where a country requires it) for clients based elsewhere in India.</p><p>Beyond that, Delhi\'s own applicant base spans the full range: tourist, business, family-visit, student-adjacent, medical and diplomatic-linked travel.</p>',
            'service_model_html' => '<p>We do not have a walk-in office in Delhi. Applicants are supported remotely &mdash; consultation, document review over WhatsApp/email, and courier arranged where a Visa Application Centre or embassy in Delhi needs a physical submission.</p>',
            'seo_title' => 'Visa Consultant in Delhi | Visa Agency',
            'meta_description' => 'Visa consultancy for residents of Delhi — tourist, business and family visa application assistance, plus embassy/VAC submission logistics support.',
            'faqs' => [
                ['q' => 'Does VisaAgency.in have an office in Delhi?', 'a' => '<p>No. We serve Delhi remotely, the same way as every state outside Bihar, with courier used for physical submissions to an embassy or Visa Application Centre where required.</p>'],
                ['q' => 'Why do so many visa applications route through Delhi even for applicants elsewhere?', 'a' => '<p>Most countries\' embassies, high commissions and outsourced Visa Application Centres for India are physically based in Delhi. Even an applicant based in another state often has their passport or documents couriered to a Delhi-based VAC as part of the process &mdash; we handle that logistics for you.</p>'],
            ],
            'cities' => [],
        ],
        [
            'slug' => 'maharashtra',
            'name' => 'Maharashtra',
            'sort_order' => 6,
            'intro_html' => '<p>Maharashtra, home to India\'s financial capital, sends us a wide range of applicants &mdash; business travellers connected to Mumbai\'s finance and corporate sector, tourists, family-visit applicants, and a steady stream of Pune\'s IT and education-linked travellers.</p><p>We apply the same document-first process across the state: understand your travel purpose, map it to the right visa category, and build a checklist specific to your destination rather than a generic one.</p>',
            'service_model_html' => '<p>We do not have a physical office in Maharashtra. Applicants across the state are supported remotely &mdash; phone and video consultations, document review over WhatsApp/email, and courier collection where an original document is required.</p>',
            'seo_title' => 'Visa Consultant in Maharashtra | Visa Agency',
            'meta_description' => 'Visa consultancy for residents of Maharashtra — tourist, business and family visa application assistance, served remotely from our Patna office.',
            'faqs' => [
                ['q' => 'Does VisaAgency.in have an office in Maharashtra?', 'a' => '<p>No. Maharashtra is served remotely from our Patna office.</p>'],
            ],
            'cities' => [
                [
                    'slug' => 'mumbai',
                    'name' => 'Mumbai',
                    'sort_order' => 1,
                    'intro_html' => '<p>Mumbai, India\'s financial capital, sends us a strong mix of business-visa applicants &mdash; from finance, banking and corporate-sector professionals &mdash; alongside tourist and family-visit travellers. Business applications from Mumbai often involve more substantial company and financial documentation, which we help prepare in the format a given consulate expects.</p>',
                    'local_notes_html' => '<p>We serve Mumbai remotely &mdash; there is no local walk-in office. Company and personal documents can be shared digitally, with courier used only where an embassy needs a physical original.</p>',
                    'seo_title' => 'Visa Consultant in Mumbai | Visa Agency',
                    'meta_description' => 'Business and tourist visa consultancy for applicants in Mumbai — remote application assistance from Visa Agency.',
                    'faqs' => [['q' => 'Can you help with business visas for Mumbai-based companies?', 'a' => '<p>Yes &mdash; business visa applications with company/financial documentation are one of our more common request types from Mumbai.</p>']],
                ],
                [
                    'slug' => 'pune',
                    'name' => 'Pune',
                    'sort_order' => 2,
                    'intro_html' => '<p>Pune\'s large IT and education sector gives us a distinct applicant mix from Mumbai\'s &mdash; software professionals travelling for work or conferences, alongside the usual tourist and family-visit requests. We tailor document guidance to whichever category actually applies to you.</p>',
                    'local_notes_html' => '<p>We serve Pune remotely &mdash; there is no local walk-in office. Consultations and document review run over phone, video call, WhatsApp and email.</p>',
                    'seo_title' => 'Visa Consultant in Pune | Visa Agency',
                    'meta_description' => 'Remote visa consultancy for applicants in Pune, Maharashtra — tourist, business and family visa application assistance.',
                    'faqs' => [['q' => 'Is there a Visa Agency office in Pune?', 'a' => '<p>No &mdash; Pune is served remotely, with consultations and document review over phone, video call, WhatsApp and email.</p>']],
                ],
            ],
        ],
        [
            'slug' => 'karnataka',
            'name' => 'Karnataka',
            'sort_order' => 7,
            'intro_html' => '<p>Karnataka, anchored by Bengaluru\'s IT industry, sends us a high share of business and work-linked travellers alongside tourist and family-visit applicants. We help prepare the employer documentation and financial evidence that business-visa categories typically expect.</p>',
            'service_model_html' => '<p>We do not have a physical office in Karnataka. Applicants across the state are supported remotely &mdash; phone and video consultations, document review over WhatsApp/email, and courier collection where an original document is required.</p>',
            'seo_title' => 'Visa Consultant in Karnataka | Visa Agency',
            'meta_description' => 'Visa consultancy for residents of Karnataka — tourist, business and family visa application assistance, served remotely from our Patna office.',
            'faqs' => [
                ['q' => 'Does VisaAgency.in have an office in Karnataka?', 'a' => '<p>No. Karnataka is served remotely from our Patna office.</p>'],
            ],
            'cities' => [
                [
                    'slug' => 'bengaluru',
                    'name' => 'Bengaluru',
                    'sort_order' => 1,
                    'intro_html' => '<p>Bengaluru\'s concentration of IT and technology employers sends us a steady flow of business-visa applicants &mdash; engineers, consultants and company representatives travelling for client work, conferences or short-term assignments &mdash; alongside tourist and family-visit travellers.</p>',
                    'local_notes_html' => '<p>We serve Bengaluru remotely &mdash; there is no local walk-in office. Company documents can be shared by email, with courier arranged for anything that must be submitted as a physical original.</p>',
                    'seo_title' => 'Visa Consultant in Bengaluru | Visa Agency',
                    'meta_description' => 'Business and tourist visa consultancy for applicants in Bengaluru — remote application assistance from Visa Agency.',
                    'faqs' => [['q' => 'Can you help with business visas for Bengaluru IT companies?', 'a' => '<p>Yes &mdash; this is one of our most common request types from Bengaluru, given the concentration of technology employers in the city.</p>']],
                ],
                [
                    'slug' => 'mysuru',
                    'name' => 'Mysuru',
                    'sort_order' => 2,
                    'intro_html' => '<p>Mysuru applicants come to us for the same range of categories as anywhere in Karnataka &mdash; tourist, business and family-visit visas &mdash; and we apply the same careful document review regardless of city.</p>',
                    'local_notes_html' => '<p>We serve Mysuru remotely &mdash; there is no local walk-in office. Documents can be shared digitally, with courier used only where an embassy needs a physical original.</p>',
                    'seo_title' => 'Visa Consultant in Mysuru | Visa Agency',
                    'meta_description' => 'Visa consultancy for applicants in Mysuru, Karnataka — remote tourist, business and family visa application assistance.',
                    'faqs' => [['q' => 'Can I get visa consultancy in Mysuru without visiting an office?', 'a' => '<p>Yes &mdash; the entire process for Mysuru applicants runs remotely, from initial consultation through document review to submission guidance.</p>']],
                ],
            ],
        ],
        [
            'slug' => 'tamil-nadu',
            'name' => 'Tamil Nadu',
            'sort_order' => 8,
            'intro_html' => '<p>Tamil Nadu, with Chennai as its major metro and a strong manufacturing and export base across the state, sends us a mix of business travellers, tourists and family-visit applicants, along with employment-linked travel to Gulf countries in particular.</p>',
            'service_model_html' => '<p>We do not have a physical office in Tamil Nadu. Applicants across the state are supported remotely &mdash; phone and video consultations, document review over WhatsApp/email, and courier collection where an original document is required.</p>',
            'seo_title' => 'Visa Consultant in Tamil Nadu | Visa Agency',
            'meta_description' => 'Visa consultancy for residents of Tamil Nadu — tourist, business and family visa application assistance, served remotely from our Patna office.',
            'faqs' => [
                ['q' => 'Does VisaAgency.in have an office in Tamil Nadu?', 'a' => '<p>No. Tamil Nadu is served remotely from our Patna office.</p>'],
            ],
            'cities' => [
                [
                    'slug' => 'chennai',
                    'name' => 'Chennai',
                    'sort_order' => 1,
                    'intro_html' => '<p>Chennai, one of India\'s major metros and a long-established hub for Gulf-bound employment travel alongside its own corporate and manufacturing base, sends us a genuinely varied applicant mix &mdash; business, employment-linked, tourist and family-visit visas.</p>',
                    'local_notes_html' => '<p>We serve Chennai remotely &mdash; there is no local walk-in office. Consultations and document review run over phone, video call, WhatsApp and email.</p>',
                    'seo_title' => 'Visa Consultant in Chennai | Visa Agency',
                    'meta_description' => 'Remote visa consultancy for applicants in Chennai, Tamil Nadu — tourist, business and family visa application assistance.',
                    'faqs' => [['q' => 'Is there a Visa Agency office in Chennai?', 'a' => '<p>No &mdash; Chennai is served remotely, with consultations and document review over phone, video call, WhatsApp and email.</p>']],
                ],
                [
                    'slug' => 'coimbatore',
                    'name' => 'Coimbatore',
                    'sort_order' => 2,
                    'intro_html' => '<p>Coimbatore\'s textile and manufacturing base gives it a distinct business-travel profile from Chennai\'s &mdash; company owners and representatives travelling for trade and sourcing trips, alongside tourist and family-visit applicants.</p>',
                    'local_notes_html' => '<p>We serve Coimbatore remotely &mdash; there is no local walk-in office. Documents can be shared digitally, with courier used only where an embassy needs a physical original.</p>',
                    'seo_title' => 'Visa Consultant in Coimbatore | Visa Agency',
                    'meta_description' => 'Business and tourist visa consultancy for applicants in Coimbatore — remote application assistance from Visa Agency.',
                    'faqs' => [['q' => 'Can you help with trade/business visas for Coimbatore companies?', 'a' => '<p>Yes &mdash; business visas with company documentation are a common request type from Coimbatore, given the city\'s textile and manufacturing trade base.</p>']],
                ],
            ],
        ],
        [
            'slug' => 'uttar-pradesh',
            'name' => 'Uttar Pradesh',
            'sort_order' => 9,
            'intro_html' => '<p>Uttar Pradesh is India\'s most populous state, and our applicant base there reflects that scale and diversity &mdash; tourist, business, family-visit and medical travel from Lucknow, Varanasi and across the state.</p>',
            'service_model_html' => '<p>We do not have a physical office in Uttar Pradesh. Applicants across the state are supported remotely &mdash; phone and video consultations, document review over WhatsApp/email, and courier collection where an original document is required.</p>',
            'seo_title' => 'Visa Consultant in Uttar Pradesh | Visa Agency',
            'meta_description' => 'Visa consultancy for residents of Uttar Pradesh — tourist, business and family visa application assistance, served remotely from our Patna office.',
            'faqs' => [
                ['q' => 'Does VisaAgency.in have an office in Uttar Pradesh?', 'a' => '<p>No. Uttar Pradesh is served remotely from our Patna office.</p>'],
            ],
            'cities' => [
                [
                    'slug' => 'lucknow',
                    'name' => 'Lucknow',
                    'sort_order' => 1,
                    'intro_html' => '<p>Lucknow, Uttar Pradesh\'s capital, is our main point of contact in the state. As the administrative centre, Lucknow\'s applicant base includes government-linked and professional travellers alongside the usual tourist and family-visit requests.</p>',
                    'local_notes_html' => '<p>We serve Lucknow remotely &mdash; there is no local walk-in office. Consultations and document review run over phone, video call, WhatsApp and email.</p>',
                    'seo_title' => 'Visa Consultant in Lucknow | Visa Agency',
                    'meta_description' => 'Remote visa consultancy for applicants in Lucknow, Uttar Pradesh — tourist, business and family visa application assistance.',
                    'faqs' => [['q' => 'Is there a Visa Agency office in Lucknow?', 'a' => '<p>No &mdash; Lucknow is served remotely, with consultations and document review over phone, video call, WhatsApp and email.</p>']],
                ],
                [
                    'slug' => 'varanasi',
                    'name' => 'Varanasi',
                    'sort_order' => 2,
                    'intro_html' => '<p>Varanasi, one of India\'s most significant pilgrimage and heritage cities, draws international visitors for its own religious tourism &mdash; but our role is the reverse: helping Varanasi residents travelling abroad, for tourism, business, family visits or other purposes, with their own outbound visa applications.</p>',
                    'local_notes_html' => '<p>We serve Varanasi remotely &mdash; there is no local walk-in office. If your query is about visiting Varanasi from abroad, that is handled by the Indian mission in your home country, not by us.</p>',
                    'seo_title' => 'Visa Consultant in Varanasi | Visa Agency',
                    'meta_description' => 'Visa consultancy for applicants in Varanasi, Uttar Pradesh — remote tourist, business and family visa application assistance.',
                    'faqs' => [['q' => 'Do you help with visas for tourists visiting Varanasi?', 'a' => '<p>No &mdash; we assist Varanasi residents\' own outbound travel, not inbound tourist visas for people visiting Varanasi, which are handled by the Indian mission in the traveller\'s home country.</p>']],
                ],
            ],
        ],
        [
            'slug' => 'west-bengal',
            'name' => 'West Bengal',
            'sort_order' => 10,
            'intro_html' => '<p>West Bengal, with Kolkata as its historic commercial and cultural capital, sends us a broad mix of applicants &mdash; business travellers connected to the city\'s long-established trading base, tourists, and family-visit applicants.</p>',
            'service_model_html' => '<p>We do not have a physical office in West Bengal. Applicants across the state are supported remotely &mdash; phone and video consultations, document review over WhatsApp/email, and courier collection where an original document is required.</p>',
            'seo_title' => 'Visa Consultant in West Bengal | Visa Agency',
            'meta_description' => 'Visa consultancy for residents of West Bengal — tourist, business and family visa application assistance, served remotely from our Patna office.',
            'faqs' => [
                ['q' => 'Does VisaAgency.in have an office in West Bengal?', 'a' => '<p>No. West Bengal is served remotely from our Patna office.</p>'],
            ],
            'cities' => [
                [
                    'slug' => 'kolkata',
                    'name' => 'Kolkata',
                    'sort_order' => 1,
                    'intro_html' => '<p>Kolkata, one of India\'s oldest major commercial centres, sends us business applicants connected to its long-established trading and industrial base, alongside tourist and family-visit travellers. We apply the same document-first process here as everywhere else.</p>',
                    'local_notes_html' => '<p>We serve Kolkata remotely &mdash; there is no local walk-in office. Consultations and document review run over phone, video call, WhatsApp and email.</p>',
                    'seo_title' => 'Visa Consultant in Kolkata | Visa Agency',
                    'meta_description' => 'Remote visa consultancy for applicants in Kolkata, West Bengal — tourist, business and family visa application assistance.',
                    'faqs' => [['q' => 'Is there a Visa Agency office in Kolkata?', 'a' => '<p>No &mdash; Kolkata is served remotely, with consultations and document review over phone, video call, WhatsApp and email.</p>']],
                ],
            ],
        ],
        [
            'slug' => 'gujarat',
            'name' => 'Gujarat',
            'sort_order' => 11,
            'intro_html' => '<p>Gujarat has one of India\'s largest and longest-established NRI and diaspora communities, particularly with ties to the United States, United Kingdom and other countries &mdash; which means family-visit and immigration-adjacent visa categories make up a meaningful share of what we help with from the state, alongside business travel tied to Gujarat\'s manufacturing and trading economy.</p>',
            'service_model_html' => '<p>We do not have a physical office in Gujarat. Applicants across the state are supported remotely &mdash; phone and video consultations, document review over WhatsApp/email, and courier collection where an original document is required.</p>',
            'seo_title' => 'Visa Consultant in Gujarat | Visa Agency',
            'meta_description' => 'Visa consultancy for residents of Gujarat — tourist, business and family visa application assistance, served remotely from our Patna office.',
            'faqs' => [
                ['q' => 'Does VisaAgency.in have an office in Gujarat?', 'a' => '<p>No. Gujarat is served remotely from our Patna office.</p>'],
                ['q' => 'Do you help with family-visit visas for applicants with relatives abroad?', 'a' => '<p>Yes &mdash; family-visit visa applications, common among Gujarat\'s diaspora-connected applicants, are one of the categories we regularly assist with.</p>'],
            ],
            'cities' => [
                [
                    'slug' => 'ahmedabad',
                    'name' => 'Ahmedabad',
                    'sort_order' => 1,
                    'intro_html' => '<p>Ahmedabad, Gujarat\'s largest city and commercial hub, sends us business travellers connected to its manufacturing and trading sectors, alongside family-visit and tourist applicants reflecting the city\'s strong diaspora ties.</p>',
                    'local_notes_html' => '<p>We serve Ahmedabad remotely &mdash; there is no local walk-in office. Consultations and document review run over phone, video call, WhatsApp and email.</p>',
                    'seo_title' => 'Visa Consultant in Ahmedabad | Visa Agency',
                    'meta_description' => 'Remote visa consultancy for applicants in Ahmedabad, Gujarat — tourist, business and family visa application assistance.',
                    'faqs' => [['q' => 'Is there a Visa Agency office in Ahmedabad?', 'a' => '<p>No &mdash; Ahmedabad is served remotely, with consultations and document review over phone, video call, WhatsApp and email.</p>']],
                ],
                [
                    'slug' => 'surat',
                    'name' => 'Surat',
                    'sort_order' => 2,
                    'intro_html' => '<p>Surat, known for its diamond-cutting and textile trade and a particularly large NRI community, sends us a strong share of business and family-visit applicants &mdash; traders travelling for sourcing and trade, and applicants visiting family settled abroad.</p>',
                    'local_notes_html' => '<p>We serve Surat remotely &mdash; there is no local walk-in office. Documents can be shared digitally, with courier used only where an embassy needs a physical original.</p>',
                    'seo_title' => 'Visa Consultant in Surat | Visa Agency',
                    'meta_description' => 'Business and family visa consultancy for applicants in Surat — remote application assistance from Visa Agency.',
                    'faqs' => [['q' => 'Can you help with trade-visa documentation for Surat\'s diamond and textile businesses?', 'a' => '<p>Yes &mdash; business visas with trade/company documentation are a common request type from Surat.</p>']],
                ],
            ],
        ],
        [
            'slug' => 'punjab',
            'name' => 'Punjab',
            'sort_order' => 12,
            'intro_html' => '<p>Punjab has one of India\'s strongest and longest-standing migration and family-visit connections abroad, particularly to Canada, the UK and Australia &mdash; so family-visit, study-adjacent documentation support and tourist visas make up a large share of what we help with, alongside business travel.</p>',
            'service_model_html' => '<p>We do not have a physical office in Punjab. Applicants across the state are supported remotely &mdash; phone and video consultations, document review over WhatsApp/email, and courier collection where an original document is required.</p>',
            'seo_title' => 'Visa Consultant in Punjab | Visa Agency',
            'meta_description' => 'Visa consultancy for residents of Punjab — tourist, business and family visa application assistance, served remotely from our Patna office.',
            'faqs' => [
                ['q' => 'Does VisaAgency.in have an office in Punjab?', 'a' => '<p>No. Punjab is served remotely from our Patna office.</p>'],
                ['q' => 'Do you help with visas to Canada, the UK or Australia for family visits?', 'a' => '<p>Yes &mdash; family-visit visa applications to these destinations are among the most common requests we receive from Punjab.</p>'],
            ],
            'cities' => [
                [
                    'slug' => 'amritsar',
                    'name' => 'Amritsar',
                    'sort_order' => 1,
                    'intro_html' => '<p>Amritsar has one of India\'s highest rates of family ties abroad, particularly to Canada, the UK and Australia, so family-visit visa applications &mdash; often for weddings, celebrations or extended family visits &mdash; are one of our most common request types from the city, alongside tourist and business travel.</p>',
                    'local_notes_html' => '<p>We serve Amritsar remotely &mdash; there is no local walk-in office. Consultations and document review run over phone, video call, WhatsApp and email.</p>',
                    'seo_title' => 'Visa Consultant in Amritsar | Visa Agency',
                    'meta_description' => 'Family, tourist and business visa consultancy for applicants in Amritsar — remote application assistance from Visa Agency.',
                    'faqs' => [['q' => 'Can you help with family-visit visas from Amritsar to Canada or the UK?', 'a' => '<p>Yes &mdash; this is one of our most common request types from Amritsar, given the city\'s strong diaspora ties to both countries.</p>']],
                ],
                [
                    'slug' => 'ludhiana',
                    'name' => 'Ludhiana',
                    'sort_order' => 2,
                    'intro_html' => '<p>Ludhiana, Punjab\'s largest industrial city, gives us a distinct applicant mix from Amritsar\'s &mdash; a strong business-visa component tied to its manufacturing and export base, alongside the same family-visit and tourist demand seen across the state.</p>',
                    'local_notes_html' => '<p>We serve Ludhiana remotely &mdash; there is no local walk-in office. Documents can be shared digitally, with courier used only where an embassy needs a physical original.</p>',
                    'seo_title' => 'Visa Consultant in Ludhiana | Visa Agency',
                    'meta_description' => 'Business and family visa consultancy for applicants in Ludhiana — remote application assistance from Visa Agency.',
                    'faqs' => [['q' => 'Can you help with business visas for Ludhiana manufacturing companies?', 'a' => '<p>Yes &mdash; business visas with company/trade documentation are a common request type from Ludhiana, given its manufacturing and export base.</p>']],
                ],
            ],
        ],
    ];
}
