<?php
/**
 * Phase 3 of the state/city location pages — the next tier of larger
 * states not yet covered: Rajasthan, Haryana, Kerala, Telangana, Andhra
 * Pradesh, Odisha, Assam, Uttarakhand, Himachal Pradesh and Goa. Same
 * rules as phases 1-2: every entry has a real, verifiable distinguishing
 * fact, and every location explicitly discloses remote/online coverage
 * (only Patna, from phase 1, is ever described as a physical office).
 *
 * Loaded by location_seed_all() in includes/location-db.php.
 */
function location_seed_states_def_phase3(): array
{
    return [
        [
            'slug' => 'rajasthan',
            'name' => 'Rajasthan',
            'sort_order' => 13,
            'intro_html' => '<p>Rajasthan, one of India\'s most tourism-prominent states in its own right, also sends us a strong flow of outbound applicants &mdash; tourist, business and family-visit visas from Jaipur and across the state, alongside travellers connected to the state\'s gems, jewellery and handicrafts export trade.</p>',
            'service_model_html' => '<p>We do not have a physical office in Rajasthan. Applicants across the state are supported remotely &mdash; phone and video consultations, document review over WhatsApp/email, and courier collection where an original document is required.</p>',
            'seo_title' => 'Visa Consultant in Rajasthan | Visa Agency',
            'meta_description' => 'Visa consultancy for residents of Rajasthan — tourist, business and family visa application assistance, served remotely from our Patna office.',
            'faqs' => [['q' => 'Does VisaAgency.in have an office in Rajasthan?', 'a' => '<p>No. Rajasthan is served remotely from our Patna office.</p>']],
            'cities' => [
                [
                    'slug' => 'jaipur', 'name' => 'Jaipur', 'sort_order' => 1,
                    'intro_html' => '<p>Jaipur, Rajasthan\'s capital and a major international tourism draw itself, sends us business applicants connected to the state\'s gems, jewellery and handicrafts export trade, alongside tourist and family-visit travellers.</p>',
                    'local_notes_html' => '<p>We serve Jaipur remotely &mdash; there is no local walk-in office. Consultations and document review run over phone, video call, WhatsApp and email.</p>',
                    'seo_title' => 'Visa Consultant in Jaipur | Visa Agency',
                    'meta_description' => 'Remote visa consultancy for applicants in Jaipur, Rajasthan — tourist, business and family visa application assistance.',
                    'faqs' => [['q' => 'Is there a Visa Agency office in Jaipur?', 'a' => '<p>No &mdash; Jaipur is served remotely, with consultations and document review over phone, video call, WhatsApp and email.</p>']],
                ],
            ],
        ],
        [
            'slug' => 'haryana',
            'name' => 'Haryana',
            'sort_order' => 14,
            'intro_html' => '<p>Haryana, anchored by Gurugram\'s dense concentration of multinational corporate offices, sends us a high proportion of business and work-linked travellers alongside the usual tourist and family-visit applicants.</p>',
            'service_model_html' => '<p>We do not have a physical office in Haryana. Applicants across the state are supported remotely &mdash; phone and video consultations, document review over WhatsApp/email, and courier collection where an original document is required.</p>',
            'seo_title' => 'Visa Consultant in Haryana | Visa Agency',
            'meta_description' => 'Visa consultancy for residents of Haryana — tourist, business and family visa application assistance, served remotely from our Patna office.',
            'faqs' => [['q' => 'Does VisaAgency.in have an office in Haryana?', 'a' => '<p>No. Haryana is served remotely from our Patna office.</p>']],
            'cities' => [
                [
                    'slug' => 'gurugram', 'name' => 'Gurugram', 'sort_order' => 1,
                    'intro_html' => '<p>Gurugram\'s dense cluster of multinational corporate offices sends us a high share of business-visa applicants &mdash; company representatives, consultants and executives travelling for client work, conferences or short-term assignments.</p>',
                    'local_notes_html' => '<p>We serve Gurugram remotely &mdash; there is no local walk-in office. Company documents can be shared by email, with courier arranged for anything that must be submitted as a physical original.</p>',
                    'seo_title' => 'Visa Consultant in Gurugram | Visa Agency',
                    'meta_description' => 'Business and tourist visa consultancy for applicants in Gurugram — remote application assistance from Visa Agency.',
                    'faqs' => [['q' => 'Can you help with business visas for Gurugram-based multinational companies?', 'a' => '<p>Yes &mdash; this is one of our most common request types from Gurugram, given the concentration of corporate offices in the city.</p>']],
                ],
            ],
        ],
        [
            'slug' => 'kerala',
            'name' => 'Kerala',
            'sort_order' => 15,
            'intro_html' => '<p>Kerala has one of India\'s longest-established patterns of overseas employment migration, particularly to Gulf countries, so employment-linked and family-visit visa categories make up a significant share of what we help with, alongside tourist and business travel.</p>',
            'service_model_html' => '<p>We do not have a physical office in Kerala. Applicants across the state are supported remotely &mdash; phone and video consultations, document review over WhatsApp/email, and courier collection where an original document is required.</p>',
            'seo_title' => 'Visa Consultant in Kerala | Visa Agency',
            'meta_description' => 'Visa consultancy for residents of Kerala — tourist, business, employment-linked and family visa application assistance, served remotely.',
            'faqs' => [
                ['q' => 'Does VisaAgency.in have an office in Kerala?', 'a' => '<p>No. Kerala is served remotely from our Patna office.</p>'],
                ['q' => 'Do you help with Gulf-country employment-linked travel documentation?', 'a' => '<p>Yes &mdash; this is one of the categories we regularly assist with from Kerala, alongside tourist, business and family-visit visas.</p>'],
            ],
            'cities' => [
                [
                    'slug' => 'kochi', 'name' => 'Kochi', 'sort_order' => 1,
                    'intro_html' => '<p>Kochi, Kerala\'s major port city and commercial centre, sends us a mix of employment-linked travellers (particularly to Gulf countries), business applicants tied to the city\'s trading base, and tourist and family-visit travellers.</p>',
                    'local_notes_html' => '<p>We serve Kochi remotely &mdash; there is no local walk-in office. Consultations and document review run over phone, video call, WhatsApp and email.</p>',
                    'seo_title' => 'Visa Consultant in Kochi | Visa Agency',
                    'meta_description' => 'Remote visa consultancy for applicants in Kochi, Kerala — tourist, business and employment-linked visa application assistance.',
                    'faqs' => [['q' => 'Is there a Visa Agency office in Kochi?', 'a' => '<p>No &mdash; Kochi is served remotely, with consultations and document review over phone, video call, WhatsApp and email.</p>']],
                ],
            ],
        ],
        [
            'slug' => 'telangana',
            'name' => 'Telangana',
            'sort_order' => 16,
            'intro_html' => '<p>Telangana, with Hyderabad as its capital and a major IT and pharmaceutical industry base, sends us a strong share of business and work-linked travellers alongside tourist and family-visit applicants.</p>',
            'service_model_html' => '<p>We do not have a physical office in Telangana. Applicants across the state are supported remotely &mdash; phone and video consultations, document review over WhatsApp/email, and courier collection where an original document is required.</p>',
            'seo_title' => 'Visa Consultant in Telangana | Visa Agency',
            'meta_description' => 'Visa consultancy for residents of Telangana — tourist, business and family visa application assistance, served remotely from our Patna office.',
            'faqs' => [['q' => 'Does VisaAgency.in have an office in Telangana?', 'a' => '<p>No. Telangana is served remotely from our Patna office.</p>']],
            'cities' => [
                [
                    'slug' => 'hyderabad', 'name' => 'Hyderabad', 'sort_order' => 1,
                    'intro_html' => '<p>Hyderabad\'s IT and pharmaceutical industry base sends us a strong flow of business-visa applicants &mdash; technology and pharma professionals travelling for client work, conferences or short-term assignments &mdash; alongside tourist and family-visit travellers.</p>',
                    'local_notes_html' => '<p>We serve Hyderabad remotely &mdash; there is no local walk-in office. Company documents can be shared by email, with courier arranged for anything that must be submitted as a physical original.</p>',
                    'seo_title' => 'Visa Consultant in Hyderabad | Visa Agency',
                    'meta_description' => 'Business and tourist visa consultancy for applicants in Hyderabad — remote application assistance from Visa Agency.',
                    'faqs' => [['q' => 'Can you help with business visas for Hyderabad IT and pharma companies?', 'a' => '<p>Yes &mdash; this is one of our more common request types from Hyderabad, given the concentration of technology and pharmaceutical employers in the city.</p>']],
                ],
            ],
        ],
        [
            'slug' => 'andhra-pradesh',
            'name' => 'Andhra Pradesh',
            'sort_order' => 17,
            'intro_html' => '<p>Andhra Pradesh, with Visakhapatnam as its major port city and commercial centre, sends us business applicants connected to shipping, trade and industry, alongside tourist and family-visit travellers from across the state.</p>',
            'service_model_html' => '<p>We do not have a physical office in Andhra Pradesh. Applicants across the state are supported remotely &mdash; phone and video consultations, document review over WhatsApp/email, and courier collection where an original document is required.</p>',
            'seo_title' => 'Visa Consultant in Andhra Pradesh | Visa Agency',
            'meta_description' => 'Visa consultancy for residents of Andhra Pradesh — tourist, business and family visa application assistance, served remotely from our Patna office.',
            'faqs' => [['q' => 'Does VisaAgency.in have an office in Andhra Pradesh?', 'a' => '<p>No. Andhra Pradesh is served remotely from our Patna office.</p>']],
            'cities' => [
                [
                    'slug' => 'visakhapatnam', 'name' => 'Visakhapatnam', 'sort_order' => 1,
                    'intro_html' => '<p>Visakhapatnam, one of India\'s major port cities, sends us business applicants connected to shipping, trade and industry, alongside tourist and family-visit travellers.</p>',
                    'local_notes_html' => '<p>We serve Visakhapatnam remotely &mdash; there is no local walk-in office. Consultations and document review run over phone, video call, WhatsApp and email.</p>',
                    'seo_title' => 'Visa Consultant in Visakhapatnam | Visa Agency',
                    'meta_description' => 'Remote visa consultancy for applicants in Visakhapatnam, Andhra Pradesh — tourist, business and family visa application assistance.',
                    'faqs' => [['q' => 'Is there a Visa Agency office in Visakhapatnam?', 'a' => '<p>No &mdash; Visakhapatnam is served remotely, with consultations and document review over phone, video call, WhatsApp and email.</p>']],
                ],
            ],
        ],
        [
            'slug' => 'odisha',
            'name' => 'Odisha',
            'sort_order' => 18,
            'intro_html' => '<p>Odisha, with Bhubaneswar as its capital and a growing IT and education sector, sends us a mix of business, tourist and family-visit applicants across the state.</p>',
            'service_model_html' => '<p>We do not have a physical office in Odisha. Applicants across the state are supported remotely &mdash; phone and video consultations, document review over WhatsApp/email, and courier collection where an original document is required.</p>',
            'seo_title' => 'Visa Consultant in Odisha | Visa Agency',
            'meta_description' => 'Visa consultancy for residents of Odisha — tourist, business and family visa application assistance, served remotely from our Patna office.',
            'faqs' => [['q' => 'Does VisaAgency.in have an office in Odisha?', 'a' => '<p>No. Odisha is served remotely from our Patna office.</p>']],
            'cities' => [
                [
                    'slug' => 'bhubaneswar', 'name' => 'Bhubaneswar', 'sort_order' => 1,
                    'intro_html' => '<p>Bhubaneswar, Odisha\'s capital and a growing IT and education hub, sends us applicants across the same range of categories as anywhere in the state &mdash; tourist, business and family-visit visas.</p>',
                    'local_notes_html' => '<p>We serve Bhubaneswar remotely &mdash; there is no local walk-in office. Consultations and document review run over phone, video call, WhatsApp and email.</p>',
                    'seo_title' => 'Visa Consultant in Bhubaneswar | Visa Agency',
                    'meta_description' => 'Remote visa consultancy for applicants in Bhubaneswar, Odisha — tourist, business and family visa application assistance.',
                    'faqs' => [['q' => 'Is there a Visa Agency office in Bhubaneswar?', 'a' => '<p>No &mdash; Bhubaneswar is served remotely, with consultations and document review over phone, video call, WhatsApp and email.</p>']],
                ],
            ],
        ],
        [
            'slug' => 'assam',
            'name' => 'Assam',
            'sort_order' => 19,
            'intro_html' => '<p>Assam, with Guwahati as the main gateway city to Northeast India, sends us tourist, business and family-visit applicants from across the state.</p>',
            'service_model_html' => '<p>We do not have a physical office in Assam. Applicants across the state are supported remotely &mdash; phone and video consultations, document review over WhatsApp/email, and courier collection where an original document is required.</p>',
            'seo_title' => 'Visa Consultant in Assam | Visa Agency',
            'meta_description' => 'Visa consultancy for residents of Assam — tourist, business and family visa application assistance, served remotely from our Patna office.',
            'faqs' => [['q' => 'Does VisaAgency.in have an office in Assam?', 'a' => '<p>No. Assam is served remotely from our Patna office.</p>']],
            'cities' => [
                [
                    'slug' => 'guwahati', 'name' => 'Guwahati', 'sort_order' => 1,
                    'intro_html' => '<p>Guwahati, the main gateway city to Northeast India, sends us tourist, business and family-visit applicants, and we apply the same document-first process here as everywhere else.</p>',
                    'local_notes_html' => '<p>We serve Guwahati remotely &mdash; there is no local walk-in office. Consultations and document review run over phone, video call, WhatsApp and email.</p>',
                    'seo_title' => 'Visa Consultant in Guwahati | Visa Agency',
                    'meta_description' => 'Remote visa consultancy for applicants in Guwahati, Assam — tourist, business and family visa application assistance.',
                    'faqs' => [['q' => 'Is there a Visa Agency office in Guwahati?', 'a' => '<p>No &mdash; Guwahati is served remotely, with consultations and document review over phone, video call, WhatsApp and email.</p>']],
                ],
            ],
        ],
        [
            'slug' => 'uttarakhand',
            'name' => 'Uttarakhand',
            'sort_order' => 20,
            'intro_html' => '<p>Uttarakhand, with Dehradun as its capital and Haridwar as a major pilgrimage centre, sends us tourist, business and family-visit applicants from across the state. As with our Bihar/Varanasi work, our role for Haridwar-based applicants is helping their own outbound travel &mdash; not inbound pilgrim visas into India.</p>',
            'service_model_html' => '<p>We do not have a physical office in Uttarakhand. Applicants across the state are supported remotely &mdash; phone and video consultations, document review over WhatsApp/email, and courier collection where an original document is required.</p>',
            'seo_title' => 'Visa Consultant in Uttarakhand | Visa Agency',
            'meta_description' => 'Visa consultancy for residents of Uttarakhand — tourist, business and family visa application assistance, served remotely from our Patna office.',
            'faqs' => [['q' => 'Does VisaAgency.in have an office in Uttarakhand?', 'a' => '<p>No. Uttarakhand is served remotely from our Patna office.</p>']],
            'cities' => [
                [
                    'slug' => 'dehradun', 'name' => 'Dehradun', 'sort_order' => 1,
                    'intro_html' => '<p>Dehradun, Uttarakhand\'s capital, is our main point of contact in the state. Applicants here come to us for tourist, business and family-visit visas, and we apply the same careful document review regardless of city.</p>',
                    'local_notes_html' => '<p>We serve Dehradun remotely &mdash; there is no local walk-in office. Consultations and document review run over phone, video call, WhatsApp and email.</p>',
                    'seo_title' => 'Visa Consultant in Dehradun | Visa Agency',
                    'meta_description' => 'Remote visa consultancy for applicants in Dehradun, Uttarakhand — tourist, business and family visa application assistance.',
                    'faqs' => [['q' => 'Is there a Visa Agency office in Dehradun?', 'a' => '<p>No &mdash; Dehradun is served remotely, with consultations and document review over phone, video call, WhatsApp and email.</p>']],
                ],
            ],
        ],
        [
            'slug' => 'himachal-pradesh',
            'name' => 'Himachal Pradesh',
            'sort_order' => 21,
            'intro_html' => '<p>Himachal Pradesh, with Shimla as its capital and a major domestic and international tourism draw itself, sends us tourist, business and family-visit applicants for their own outbound travel.</p>',
            'service_model_html' => '<p>We do not have a physical office in Himachal Pradesh. Applicants across the state are supported remotely &mdash; phone and video consultations, document review over WhatsApp/email, and courier collection where an original document is required.</p>',
            'seo_title' => 'Visa Consultant in Himachal Pradesh | Visa Agency',
            'meta_description' => 'Visa consultancy for residents of Himachal Pradesh — tourist, business and family visa application assistance, served remotely.',
            'faqs' => [['q' => 'Does VisaAgency.in have an office in Himachal Pradesh?', 'a' => '<p>No. Himachal Pradesh is served remotely from our Patna office.</p>']],
            'cities' => [
                [
                    'slug' => 'shimla', 'name' => 'Shimla', 'sort_order' => 1,
                    'intro_html' => '<p>Shimla, Himachal Pradesh\'s capital, is our main point of contact in the state. Applicants here come to us for tourist, business and family-visit visas.</p>',
                    'local_notes_html' => '<p>We serve Shimla remotely &mdash; there is no local walk-in office. Consultations and document review run over phone, video call, WhatsApp and email.</p>',
                    'seo_title' => 'Visa Consultant in Shimla | Visa Agency',
                    'meta_description' => 'Remote visa consultancy for applicants in Shimla, Himachal Pradesh — tourist, business and family visa application assistance.',
                    'faqs' => [['q' => 'Is there a Visa Agency office in Shimla?', 'a' => '<p>No &mdash; Shimla is served remotely, with consultations and document review over phone, video call, WhatsApp and email.</p>']],
                ],
            ],
        ],
        [
            'slug' => 'goa',
            'name' => 'Goa',
            'sort_order' => 22,
            'intro_html' => '<p>Goa, India\'s smallest state by area but a major international tourism destination in its own right, sends us residents\' own outbound tourist, business and family-visit applications, plus a distinct maritime/shipping-linked applicant base given the state\'s port and cruise industry ties.</p>',
            'service_model_html' => '<p>We do not have a physical office in Goa. Applicants across the state are supported remotely &mdash; phone and video consultations, document review over WhatsApp/email, and courier collection where an original document is required.</p>',
            'seo_title' => 'Visa Consultant in Goa | Visa Agency',
            'meta_description' => 'Visa consultancy for residents of Goa — tourist, business, maritime and family visa application assistance, served remotely from our Patna office.',
            'faqs' => [
                ['q' => 'Does VisaAgency.in have an office in Goa?', 'a' => '<p>No. Goa is served remotely from our Patna office.</p>'],
                ['q' => 'Do you help with visas for seafarers/maritime workers from Goa?', 'a' => '<p>We assist with standard tourist, business and family-visit visa categories. Seafarer-specific visa/documentation (crew visas) is a category we handle case by case &mdash; get in touch to discuss your specific requirement.</p>'],
            ],
            'cities' => [],
        ],
    ];
}
