<?php
/**
 * Structured content for the first phase of state/city location pages
 * (/visa-consultant/{state}/ and /visa-consultant/{state}/{city}/), consumed
 * by location_seed_all() in includes/location-db.php.
 *
 * Deliberately a small, quality-gated batch — the four states VisaAgency.in
 * already names in its own site-wide tagline (Patna, Ranchi, Raipur &
 * Bhopal) plus one genuinely distinct second city per state — rather than
 * all 28 states + 8 union territories at once. Each entry has its own
 * real, non-duplicated angle (a verifiable distinguishing fact about that
 * city) rather than the same paragraph with the city name swapped.
 *
 * Only Patna is marked is_hq — that's the only address VisaAgency.in
 * actually has on file (see includes/schema.php). Every other location
 * explicitly describes remote/online consultancy coverage, never a branch
 * office, per the brief's own instruction against fabricated LocalBusiness
 * claims.
 */
function location_seed_states_def(): array
{
    return [
        [
            'slug' => 'bihar',
            'name' => 'Bihar',
            'sort_order' => 1,
            'intro_html' => '<p>VisaAgency.in is headquartered in Patna, Bihar, and Bihar is where our visa consultancy began. We help applicants across the state &mdash; from Patna itself to smaller towns and districts &mdash; put together complete, well-documented visa applications for tourist, business, family, medical, student-adjacent and other travel to destinations worldwide.</p><p>Bihar sends a large number of travellers abroad every year for tourism, business, medical treatment, family visits and pilgrimage-linked travel (Bodh Gaya, in particular, connects the state to international Buddhist-heritage tourism). Whatever your reason for travel, our team can talk you through which visa category applies, what documents you will need, and what a realistic timeline looks like.</p>',
            'service_model_html' => '<p>Our office is based in Patna. Applicants from Patna and nearby areas are welcome to visit in person; applicants elsewhere in Bihar are supported the same way our Patna clients are &mdash; over phone, WhatsApp and email, with documents reviewed and couriered where needed. We do not operate branch offices in every Bihar district, and we will always tell you plainly whether a service is in-person or remote before you commit to anything.</p>',
            'seo_title' => 'Visa Consultant in Bihar | Visa Agency, Patna',
            'meta_description' => 'Visa consultancy and application assistance for residents of Bihar &mdash; tourist, business, family and other visa categories, from our Patna office and remotely across the state.',
            'faqs' => [
                ['q' => 'Does VisaAgency.in have an office outside Patna in Bihar?', 'a' => '<p>No. Our only physical office is in Patna. We support applicants elsewhere in Bihar remotely &mdash; by phone, WhatsApp and email, with documents reviewed digitally or couriered where original documents are required.</p>'],
                ['q' => 'Can I get visa help in Bihar if I don\'t live in Patna?', 'a' => '<p>Yes. Most of our Bihar clients outside Patna are served entirely remotely, the same way applicants in other states are. You do not need to travel to Patna unless you specifically want an in-person consultation.</p>'],
                ['q' => 'Which countries do you help Bihar residents apply to most often?', 'a' => '<p>Our most-requested destinations from Bihar are the United States, the United Kingdom, Canada, Australia and New Zealand, alongside Gulf countries for business and employment-linked travel. See our <a href="country-list">full country list</a> for visa information on a specific destination.</p>'],
                ['q' => 'Do you help with visas connected to Bodh Gaya pilgrimage travel?', 'a' => '<p>We assist with the applicant\'s own outbound travel documentation (for Indian residents travelling abroad) rather than inbound pilgrim visas into India. If your query is about travelling to Bodh Gaya from abroad, that is handled by the Indian mission in your home country, not by us.</p>'],
            ],
            'cities' => [
                [
                    'slug' => 'patna',
                    'name' => 'Patna',
                    'sort_order' => 1,
                    'is_hq' => true,
                    'office_address' => '#302, Sharda Mansion Apartment, Kailash Puri, Hanuman Nagar, Patna, Bihar 800020',
                    'intro_html' => '<p>Patna is home to VisaAgency.in&rsquo;s main office. If you&rsquo;re based in or around Patna, you can walk in for a consultation, drop off original documents in person, and get face-to-face guidance through your application &mdash; alongside the same phone/WhatsApp/email support we offer everywhere else.</p><p>We work with Patna-based applicants across the full range of visa categories: tourist and family visits, business travel, medical travel, and student-adjacent travel support (documentation guidance, not admissions counselling). Our consultants are familiar with the paperwork Indian banks and employers in Patna typically issue, and can tell you in advance if something you\'ve been given (a bank letter, an employer NOC) is likely to need reformatting for a particular embassy.</p>',
                    'local_notes_html' => '<p>Our office is easily reached from Kailash Puri/Hanuman Nagar and the surrounding Boring Road / Rajendra Nagar areas. If you\'re coming from further out in the district, we recommend booking a consultation slot in advance via <a href="contact">our contact page</a> so a consultant is free when you arrive.</p>',
                    'seo_title' => 'Visa Consultant in Patna | Visa Agency',
                    'meta_description' => 'Visa Agency\'s main office in Patna — in-person and remote visa consultancy for tourist, business, family and other visa categories.',
                    'faqs' => [
                        ['q' => 'Can I visit your Patna office without an appointment?', 'a' => '<p>Walk-ins are welcome, but booking ahead via <a href="contact">our contact page</a> or phone means a consultant is free to see you immediately rather than you waiting.</p>'],
                        ['q' => 'What should I bring to a first consultation in Patna?', 'a' => '<p>Your passport, a note of your intended travel dates and purpose, and any documents you already have (bank statements, employer letters, invitation letters) are enough for a first meeting &mdash; we\'ll tell you what else is needed for your specific case.</p>'],
                    ],
                ],
                [
                    'slug' => 'gaya',
                    'name' => 'Gaya',
                    'sort_order' => 2,
                    'is_hq' => false,
                    'intro_html' => '<p>Gaya &mdash; and nearby Bodh Gaya, a major international Buddhist pilgrimage site &mdash; is one of the districts we support outside Patna. We serve Gaya applicants remotely: consultations by phone or video call, document review over WhatsApp/email, and courier pickup for any original documents an embassy or consulate requires in physical form.</p><p>Applicants from Gaya come to us for the same range of reasons as anywhere else in Bihar &mdash; tourism, business travel, family visits and medical travel &mdash; and we apply the same document-preparation process regardless of whether you\'re able to visit our Patna office in person.</p>',
                    'local_notes_html' => '<p>We do not have a walk-in office in Gaya. If you\'d prefer an in-person meeting, our Patna office (about 100km away) is the option; otherwise every step of the process, from initial consultation to final document checklist, works over phone and courier.</p>',
                    'seo_title' => 'Visa Consultant in Gaya, Bihar | Visa Agency',
                    'meta_description' => 'Remote visa consultancy for applicants in Gaya, Bihar — tourist, business and family visa application assistance, supported by our Patna office.',
                    'faqs' => [
                        ['q' => 'Is there a Visa Agency office in Gaya?', 'a' => '<p>No &mdash; Gaya is served remotely from our Patna office. We handle document review, guidance and courier logistics without you needing to travel.</p>'],
                    ],
                ],
            ],
        ],
        [
            'slug' => 'jharkhand',
            'name' => 'Jharkhand',
            'sort_order' => 2,
            'intro_html' => '<p>We\'ve supported visa applicants across Jharkhand since early in VisaAgency.in\'s work outside Bihar, with Ranchi as our main point of contact in the state. Jharkhand\'s applicant base includes a significant share of business and corporate travellers &mdash; the state is home to major steel, mining and industrial employers &mdash; alongside the usual mix of tourist, family and medical travel.</p><p>Whether you need a straightforward tourist visa or a business visa with an employer invitation letter and company documentation to prepare, our consultants can walk you through exactly what a given country\'s visa process expects from an Indian applicant.</p>',
            'service_model_html' => '<p>We do not have a physical office in Jharkhand. Every applicant in the state is served remotely &mdash; consultation calls, document review over WhatsApp/email, and courier collection for original documents where an embassy requires them. This is the same remote-service model we use for every state outside Bihar, and we\'ll always be upfront that it\'s remote, not an in-person branch.</p>',
            'seo_title' => 'Visa Consultant in Jharkhand | Visa Agency',
            'meta_description' => 'Visa consultancy for residents of Jharkhand — tourist, business and family visa application assistance, served remotely from our Patna office.',
            'faqs' => [
                ['q' => 'Does VisaAgency.in have an office in Jharkhand?', 'a' => '<p>No. We serve Jharkhand entirely remotely from our Patna office &mdash; by phone, WhatsApp, email and courier for physical documents.</p>'],
                ['q' => 'Do you handle business visas for company employees in Jharkhand?', 'a' => '<p>Yes &mdash; business visa applications, including the employer invitation letters and company documentation many destinations require, are one of our more common request types from Jharkhand.</p>'],
                ['q' => 'How do I send you my documents from Jharkhand?', 'a' => '<p>Most documents can be reviewed as scans/photos over WhatsApp or email. Where a consulate needs an original (for verification or courier submission), we arrange pickup rather than asking you to travel.</p>'],
            ],
            'cities' => [
                [
                    'slug' => 'ranchi',
                    'name' => 'Ranchi',
                    'sort_order' => 1,
                    'is_hq' => false,
                    'intro_html' => '<p>Ranchi, Jharkhand\'s capital, is our main point of contact for applicants across the state. As a state capital and administrative centre, Ranchi has a steady flow of government-linked, corporate and academic travellers alongside tourist and family-visit applicants, and we\'re set up to support all of those categories remotely.</p><p>We work with Ranchi applicants the same way we do Patna clients who choose not to visit in person &mdash; full consultation, document checklist and review, and submission guidance, entirely over phone, video call, WhatsApp and courier.</p>',
                    'local_notes_html' => '<p>There is no walk-in Visa Agency office in Ranchi. Every step, from your first consultation to final document review, is handled remotely; courier is used only for the specific original documents an embassy or consulate requires.</p>',
                    'seo_title' => 'Visa Consultant in Ranchi | Visa Agency',
                    'meta_description' => 'Remote visa consultancy for applicants in Ranchi, Jharkhand — tourist, business and family visa application assistance.',
                    'faqs' => [
                        ['q' => 'Is there a Visa Agency branch in Ranchi?', 'a' => '<p>No &mdash; Ranchi is served remotely. Consultations, document review and guidance all happen over phone, video call, WhatsApp and email.</p>'],
                    ],
                ],
                [
                    'slug' => 'jamshedpur',
                    'name' => 'Jamshedpur',
                    'sort_order' => 2,
                    'is_hq' => false,
                    'intro_html' => '<p>Jamshedpur &mdash; home to Tata Steel\'s founding plant and one of eastern India\'s major industrial centres &mdash; sends us a noticeably higher share of business-visa applicants than most cities we serve: engineers, plant managers and company representatives travelling for work, alongside the usual tourist and family-visit requests.</p><p>For business travel specifically, we help you put together the employer invitation letter, company registration documents, and financial evidence that most business-visa categories expect, tailored to what the destination country\'s consulate actually asks for.</p>',
                    'local_notes_html' => '<p>We serve Jamshedpur remotely &mdash; there is no local walk-in office. Corporate applicants sending company documents can do so by email, with courier arranged for anything that must be submitted as a physical original.</p>',
                    'seo_title' => 'Visa Consultant in Jamshedpur | Visa Agency',
                    'meta_description' => 'Business and tourist visa consultancy for applicants in Jamshedpur — remote application assistance from Visa Agency.',
                    'faqs' => [
                        ['q' => 'Can you help with business visas for Jamshedpur company employees?', 'a' => '<p>Yes &mdash; this is one of our more common request types from Jamshedpur, given the concentration of industrial and corporate employers in the city.</p>'],
                    ],
                ],
            ],
        ],
        [
            'slug' => 'chhattisgarh',
            'name' => 'Chhattisgarh',
            'sort_order' => 3,
            'intro_html' => '<p>Chhattisgarh is one of the four states VisaAgency.in has served the longest outside Bihar, with Raipur as our main point of contact. Applicants from Chhattisgarh come to us across the usual range of categories &mdash; tourist, business, family-visit and medical travel &mdash; and, given the state\'s steel and power-sector employers, a fair number of business-visa cases with company documentation to prepare.</p><p>We take the same careful, document-first approach with Chhattisgarh applicants as we do everywhere: understand your travel purpose, map it to the right visa category, and build a checklist specific to the destination country rather than a generic one.</p>',
            'service_model_html' => '<p>We do not have a physical office in Chhattisgarh. Applicants across the state are supported remotely &mdash; phone and video consultations, document review over WhatsApp/email, and courier collection where an original document is required.</p>',
            'seo_title' => 'Visa Consultant in Chhattisgarh | Visa Agency',
            'meta_description' => 'Visa consultancy for residents of Chhattisgarh — tourist, business and family visa application assistance, served remotely from our Patna office.',
            'faqs' => [
                ['q' => 'Does VisaAgency.in have an office in Chhattisgarh?', 'a' => '<p>No. Chhattisgarh is served remotely from our Patna office, the same way as every state outside Bihar.</p>'],
                ['q' => 'Which visa categories do you handle most for Chhattisgarh applicants?', 'a' => '<p>Tourist and business visas are the most common, with business applications often involving employer or company documentation from the state\'s steel and power-sector employers.</p>'],
            ],
            'cities' => [
                [
                    'slug' => 'raipur',
                    'name' => 'Raipur',
                    'sort_order' => 1,
                    'is_hq' => false,
                    'intro_html' => '<p>Raipur, Chhattisgarh\'s capital, is our main point of contact for the state. As the administrative and commercial centre, Raipur applicants span the full range &mdash; tourist and family travel, business visas tied to the city\'s trading and industrial base, and occasional medical-travel cases.</p><p>Every Raipur applicant gets the same document-first process: a consultation to understand your travel purpose, a destination-specific checklist, and review before you submit.</p>',
                    'local_notes_html' => '<p>There is no walk-in Visa Agency office in Raipur; the city is served remotely by phone, video call, WhatsApp and courier for original documents.</p>',
                    'seo_title' => 'Visa Consultant in Raipur | Visa Agency',
                    'meta_description' => 'Remote visa consultancy for applicants in Raipur, Chhattisgarh — tourist, business and family visa application assistance.',
                    'faqs' => [
                        ['q' => 'Is there a Visa Agency office in Raipur?', 'a' => '<p>No &mdash; Raipur is served remotely, with consultations and document review over phone, video call, WhatsApp and email.</p>'],
                    ],
                ],
                [
                    'slug' => 'bilaspur',
                    'name' => 'Bilaspur',
                    'sort_order' => 2,
                    'is_hq' => false,
                    'intro_html' => '<p>Bilaspur &mdash; seat of the Chhattisgarh High Court and a significant railway and commercial hub in its own right &mdash; is a city we serve remotely alongside Raipur. Applicants here come to us for tourist, business and family-visit visas, and we apply the same careful document review regardless of city.</p><p>Legal and administrative professionals based in Bilaspur travelling for conferences or professional engagements are among the business-visa cases we\'ve supported from the city, alongside the more typical tourist and family-visit requests.</p>',
                    'local_notes_html' => '<p>We serve Bilaspur remotely &mdash; there is no local walk-in office. Documents can be shared digitally, with courier used only where an embassy needs a physical original.</p>',
                    'seo_title' => 'Visa Consultant in Bilaspur | Visa Agency',
                    'meta_description' => 'Visa consultancy for applicants in Bilaspur, Chhattisgarh — remote tourist, business and family visa application assistance.',
                    'faqs' => [
                        ['q' => 'Can I get visa consultancy in Bilaspur without visiting an office?', 'a' => '<p>Yes &mdash; the entire process for Bilaspur applicants runs remotely, from initial consultation through document review to submission guidance.</p>'],
                    ],
                ],
            ],
        ],
        [
            'slug' => 'madhya-pradesh',
            'name' => 'Madhya Pradesh',
            'sort_order' => 4,
            'intro_html' => '<p>Madhya Pradesh, with Bhopal as our main point of contact, is the fourth state VisaAgency.in names as a core service area. We support applicants across the state for tourist, business, family-visit and medical travel, with the same document-first process we use everywhere.</p><p>Madhya Pradesh is a large state with a genuinely diverse applicant base &mdash; from Bhopal\'s administrative and public-sector travellers to Indore\'s commercial and trading community &mdash; and we tailor the document checklist to your specific travel purpose and destination rather than using one generic list.</p>',
            'service_model_html' => '<p>We do not have a physical office in Madhya Pradesh. Applicants across the state are supported remotely &mdash; phone and video consultations, document review over WhatsApp/email, and courier collection where an original document is required.</p>',
            'seo_title' => 'Visa Consultant in Madhya Pradesh | Visa Agency',
            'meta_description' => 'Visa consultancy for residents of Madhya Pradesh — tourist, business and family visa application assistance, served remotely from our Patna office.',
            'faqs' => [
                ['q' => 'Does VisaAgency.in have an office in Madhya Pradesh?', 'a' => '<p>No. Madhya Pradesh is served remotely from our Patna office.</p>'],
                ['q' => 'Do you cover cities across Madhya Pradesh, not just Bhopal and Indore?', 'a' => '<p>Yes &mdash; our remote service model works the same way for applicants anywhere in the state, not only the cities we\'ve published dedicated pages for.</p>'],
            ],
            'cities' => [
                [
                    'slug' => 'bhopal',
                    'name' => 'Bhopal',
                    'sort_order' => 1,
                    'is_hq' => false,
                    'intro_html' => '<p>Bhopal, Madhya Pradesh\'s capital, is our main point of contact in the state. As the administrative centre, Bhopal\'s applicant base includes a significant share of government-linked and public-sector travellers alongside the usual tourist and family-visit requests.</p><p>We support Bhopal applicants with the same consultation-first process as every other city &mdash; understanding your travel purpose, mapping it to the right visa category, and preparing a destination-specific document checklist.</p>',
                    'local_notes_html' => '<p>There is no walk-in Visa Agency office in Bhopal; the city is served remotely by phone, video call, WhatsApp and courier for original documents.</p>',
                    'seo_title' => 'Visa Consultant in Bhopal | Visa Agency',
                    'meta_description' => 'Remote visa consultancy for applicants in Bhopal, Madhya Pradesh — tourist, business and family visa application assistance.',
                    'faqs' => [
                        ['q' => 'Is there a Visa Agency office in Bhopal?', 'a' => '<p>No &mdash; Bhopal is served remotely, with consultations and document review over phone, video call, WhatsApp and email.</p>'],
                    ],
                ],
                [
                    'slug' => 'indore',
                    'name' => 'Indore',
                    'sort_order' => 2,
                    'is_hq' => false,
                    'intro_html' => '<p>Indore, Madhya Pradesh\'s largest city and its commercial capital, sends us a strong mix of business-visa applicants &mdash; traders, manufacturers and company representatives &mdash; alongside tourist and family-visit travellers. It\'s a distinct applicant profile from Bhopal\'s more administratively-weighted mix, and we adjust our guidance accordingly.</p><p>For Indore\'s business travellers in particular, we help prepare the employer/company documentation, financial evidence and invitation letters that business-visa categories typically require.</p>',
                    'local_notes_html' => '<p>We serve Indore remotely &mdash; there is no local walk-in office. Company and personal documents can be shared digitally, with courier used only where an embassy needs a physical original.</p>',
                    'seo_title' => 'Visa Consultant in Indore | Visa Agency',
                    'meta_description' => 'Business and tourist visa consultancy for applicants in Indore — remote application assistance from Visa Agency.',
                    'faqs' => [
                        ['q' => 'Can you help with business visas for Indore-based companies?', 'a' => '<p>Yes &mdash; business visa applications with company/employer documentation are one of our more common request types from Indore, given the city\'s commercial base.</p>'],
                    ],
                ],
            ],
        ],
    ];
}
