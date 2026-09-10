<?php
declare(strict_types=1);

/**
 * Content is assembled from two structured inputs — a category template
 * (what genuinely differs between a Business and a Transit visa) and
 * per-country facts (how that country's actual visa mechanism works) —
 * rather than one template with the country name swapped in. Fees and
 * processing times are indicative ranges; every rendered page carries a
 * "confirm with us / last reviewed" disclaimer rather than stating them
 * as guaranteed current fact.
 */

function visa_category_catalog(): array
{
    return [
        'tourist-visa' => [
            'name' => 'Tourist Visa',
            'purpose' => 'leisure travel, sightseeing, and informal visits to friends or family',
            'eligibility' => 'a valid passport, sufficient funds for the trip, a clear travel itinerary, and demonstrable intent to return home after the visit',
            'documents' => ['Passport valid for 6+ months beyond travel dates', 'Recent passport-size photographs', 'Confirmed flight itinerary', 'Hotel bookings or invitation letter', 'Bank statements (last 3-6 months)', 'Proof of employment or income (salary slips / ITR)', 'Cover letter stating purpose of visit'],
            'rejection_reasons' => ['Insufficient funds shown for the trip duration', 'Weak proof of ties to home country (job, property, family)', 'Incomplete or inconsistent itinerary', 'Previous visa refusals not properly explained'],
        ],
        'business-visa' => [
            'name' => 'Business Visa',
            'purpose' => 'meetings, site visits, contract negotiations, and trade fairs',
            'eligibility' => 'a documented business purpose, an inviting company in the destination country, and your employer\'s or company\'s good standing',
            'documents' => ['Passport valid for 6+ months', 'Invitation letter from the host company', 'Sponsor company authorisation / covering letter', 'Business registration or GST proof of your company', 'Company bank statements', 'Detailed meeting itinerary'],
            'rejection_reasons' => ['Invitation letter missing key details (host contact, purpose, dates)', 'Mismatch between applicant\'s role and stated business purpose', 'Insufficient evidence of the inviting company\'s legitimacy'],
        ],
        'transit-visa' => [
            'name' => 'Transit Visa',
            'purpose' => 'passing through the country en route to a third destination',
            'eligibility' => 'a confirmed onward ticket and, in most cases, a valid visa for your final destination if one is required',
            'documents' => ['Passport valid for 6+ months', 'Confirmed onward/connecting flight ticket', 'Visa for final destination (if applicable)', 'Proof of layover duration within permitted limits'],
            'rejection_reasons' => ['Layover exceeds the permitted transit window', 'Missing visa for the final destination where one is required', 'Itinerary inconsistent with a genuine transit purpose'],
        ],
        'medical-visa' => [
            'name' => 'Medical Visa',
            'purpose' => 'treatment at a recognised hospital or medical facility',
            'eligibility' => 'a confirmed appointment or treatment plan from a recognised hospital, and financial proof to cover the treatment and stay',
            'documents' => ['Passport valid for 6+ months', 'Hospital appointment letter / treatment plan', 'Medical reports from your home-country physician', 'Financial proof covering treatment and stay', 'Attendant visa documents, if a companion is travelling'],
            'rejection_reasons' => ['Treatment plan lacks detail from the receiving hospital', 'Insufficient financial proof for the estimated treatment cost'],
        ],
        'family-visa' => [
            'name' => 'Family Visa',
            'purpose' => 'visiting family members living in the destination country',
            'eligibility' => 'a verifiable family relationship and confirmation of your sponsor\'s legal status in the destination country',
            'documents' => ['Passport valid for 6+ months', 'Proof of relationship (birth/marriage certificate)', 'Invitation letter from the family member', 'Sponsor\'s residency/citizenship proof', 'Sponsor\'s financial support proof or your own funds'],
            'rejection_reasons' => ['Relationship documents not apostilled/attested where required', 'Sponsor\'s status or address in the destination country unverifiable'],
        ],
        'conference-visa' => [
            'name' => 'Conference Visa',
            'purpose' => 'attending conferences, seminars, and exhibitions',
            'eligibility' => 'proof of registration at the event and, typically, your employer\'s sponsorship of the trip',
            'documents' => ['Passport valid for 6+ months', 'Conference invitation / registration confirmation', 'Employer sponsorship letter', 'Detailed travel itinerary covering the event dates'],
            'rejection_reasons' => ['Registration confirmation does not match the applicant\'s details', 'Trip dates significantly exceed the event duration without explanation'],
        ],
        'employment-visa' => [
            'name' => 'Employment Visa',
            'purpose' => 'taking up paid work with a licensed employer',
            'eligibility' => 'a valid job offer from a licensed sponsoring employer and, where applicable, meeting the destination\'s skill or salary threshold',
            'documents' => ['Passport valid for 6+ months', 'Signed employment contract / offer letter', 'Employer sponsor licence reference', 'Educational and professional certificates', 'Medical examination report, where required', 'Police clearance certificate'],
            'rejection_reasons' => ['Employer not licensed to sponsor the relevant work visa route', 'Qualifications not recognised or insufficiently documented', 'Missing police clearance or medical exam where mandatory'],
        ],
        'dependent-visa' => [
            'name' => 'Dependent Visa',
            'purpose' => 'accompanying a spouse or parent who holds a valid work or study visa',
            'eligibility' => 'a documented relationship to the principal visa holder, whose own visa must remain valid through the dependent\'s stay',
            'documents' => ['Passport valid for 6+ months', 'Marriage certificate or birth certificate establishing relationship', 'Copy of the principal visa holder\'s visa/permit', 'Principal visa holder\'s proof of income'],
            'rejection_reasons' => ['Principal applicant\'s visa status insufficient to sponsor dependents', 'Relationship documents not properly attested'],
        ],
        'official-visa' => [
            'name' => 'Official / Diplomatic Visa',
            'purpose' => 'government or diplomatic assignments',
            'eligibility' => 'travel on behalf of a government body, supported by an official note verbale',
            'documents' => ['Official or diplomatic passport', 'Note verbale from the sponsoring ministry/government', 'Travel authorisation letter'],
            'rejection_reasons' => ['Note verbale missing required government letterhead/seal', 'Purpose of travel not clearly government-related'],
        ],
    ];
}

/**
 * Per-country visa-mechanism facts for the flagship destinations we carry
 * full content for. Everything here is an indicative range, not a quoted
 * guarantee — the page template renders it with a "confirm with us" note.
 */
function flagship_country_facts(): array
{
    $schengenNote = 'Schengen short-stay visa: valid for travel across all 29 Schengen states, permitting a stay of up to 90 days within any 180-day period.';

    return [
        'usa' => ['mode' => 'in-person interview at the U.S. Embassy/Consulate after an online DS-160 application', 'processing' => 'Interview wait times vary widely by consulate — typically 3-8 weeks for an appointment slot, plus processing after interview', 'fee' => 'Approx. ₹13,000-16,500 (~US$160-185) depending on visa category', 'validity' => 'Up to 10 years, multiple entry, subject to reciprocity with India', 'stay' => 'Duration granted by the CBP officer at entry, typically up to 180 days', 'categories' => ['tourist-visa', 'business-visa', 'transit-visa', 'medical-visa', 'family-visa', 'conference-visa', 'employment-visa', 'dependent-visa']],
        'uk' => ['mode' => 'online application with biometric enrolment at a visa application centre', 'processing' => 'Standard service: 3-6 weeks; priority services available at extra cost', 'fee' => 'Approx. ₹14,500-16,000 (~£115-127) depending on visa length', 'validity' => '6 months to 10 years depending on visa type', 'stay' => 'Up to 6 months per visit on a standard visitor visa', 'categories' => ['tourist-visa', 'business-visa', 'transit-visa', 'medical-visa', 'family-visa', 'employment-visa', 'dependent-visa']],
        'canada' => ['mode' => 'online application via the IRCC portal with biometrics at a visa application centre', 'processing' => 'Typically 4-8 weeks, longer in peak season', 'fee' => 'Approx. ₹7,500-8,500 (~CAD 100-185)', 'validity' => 'Up to 10 years or passport expiry, whichever is earlier, multiple entry', 'stay' => 'Up to 6 months per entry', 'categories' => ['tourist-visa', 'business-visa', 'family-visa', 'employment-visa', 'dependent-visa']],
        'australia' => ['mode' => 'online application through ImmiAccount', 'processing' => 'Typically 2-6 weeks depending on subclass and season', 'fee' => 'Approx. ₹9,000-13,000 (~AUD 150-190)', 'validity' => 'Up to 12 months, multiple entry (subclass 600)', 'stay' => 'Up to 3 months per visit on a standard tourist stream', 'categories' => ['tourist-visa', 'business-visa', 'family-visa', 'employment-visa', 'dependent-visa']],
        'france' => ['mode' => 'Schengen application through the visa application centre with biometrics', 'processing' => '15 calendar days standard, up to 30-45 in peak season', 'fee' => 'Approx. €90 standard adult fee', 'validity' => $schengenNote, 'stay' => 'Up to 90 days within any 180-day period, Schengen-wide', 'categories' => ['tourist-visa', 'business-visa', 'transit-visa', 'medical-visa', 'family-visa', 'conference-visa']],
        'germany' => ['mode' => 'Schengen application through the visa application centre with biometrics', 'processing' => '15-30 calendar days, longer in peak season', 'fee' => 'Approx. €90 standard adult fee', 'validity' => $schengenNote, 'stay' => 'Up to 90 days within any 180-day period, Schengen-wide', 'categories' => ['tourist-visa', 'business-visa', 'transit-visa', 'family-visa', 'conference-visa', 'employment-visa']],
        'italy' => ['mode' => 'Schengen application through the visa application centre with biometrics', 'processing' => '15-30 calendar days, longer in peak season', 'fee' => 'Approx. €90 standard adult fee', 'validity' => $schengenNote, 'stay' => 'Up to 90 days within any 180-day period, Schengen-wide', 'categories' => ['tourist-visa', 'business-visa', 'transit-visa', 'family-visa', 'conference-visa']],
        'spain' => ['mode' => 'Schengen application through the visa application centre with biometrics', 'processing' => '15-30 calendar days, longer in peak season', 'fee' => 'Approx. €90 standard adult fee', 'validity' => $schengenNote, 'stay' => 'Up to 90 days within any 180-day period, Schengen-wide', 'categories' => ['tourist-visa', 'business-visa', 'transit-visa', 'family-visa', 'conference-visa']],
        'netherlands' => ['mode' => 'Schengen application through the visa application centre with biometrics', 'processing' => '15-30 calendar days, longer in peak season', 'fee' => 'Approx. €90 standard adult fee', 'validity' => $schengenNote, 'stay' => 'Up to 90 days within any 180-day period, Schengen-wide', 'categories' => ['tourist-visa', 'business-visa', 'transit-visa', 'conference-visa']],
        'uae' => ['mode' => 'e-Visa applied for through an authorised agent, airline, or hotel/sponsor', 'processing' => 'Typically 3-5 working days', 'fee' => 'Approx. ₹8,500-11,000 depending on validity and entry type', 'validity' => '30 or 90 days from issue depending on the visa purchased', 'stay' => '30 or 90 days depending on visa type, single or multiple entry', 'categories' => ['tourist-visa', 'business-visa', 'transit-visa', 'family-visa', 'conference-visa', 'employment-visa']],
        'singapore' => ['mode' => 'online e-Visa application through an authorised agent', 'processing' => 'Typically 3-5 working days', 'fee' => 'Approx. ₹2,500-3,000', 'validity' => 'Up to 2 years multiple entry for eligible applicants', 'stay' => 'Up to 30 days per visit', 'categories' => ['tourist-visa', 'business-visa', 'transit-visa', 'conference-visa', 'employment-visa']],
        'thailand' => ['mode' => 'e-Visa online or application at the visa application centre', 'processing' => 'Typically 3-7 working days', 'fee' => 'Approx. ₹2,500-3,500 for a single-entry tourist visa', 'validity' => '90 days from date of issue', 'stay' => 'Up to 60 days per entry on a tourist visa', 'categories' => ['tourist-visa', 'business-visa', 'transit-visa', 'medical-visa']],
        'japan' => ['mode' => 'application through an IATA-accredited travel agency at the Consulate/VAC', 'processing' => 'Typically 5-10 working days', 'fee' => 'Approx. ₹800-2,500 depending on single/multiple entry (often discounted for group tours)', 'validity' => 'Per visa granted, single or multiple entry', 'stay' => 'Up to 90 days per visit on a short-stay visa', 'categories' => ['tourist-visa', 'business-visa', 'transit-visa', 'conference-visa']],
        'south-korea' => ['mode' => 'Consulate/VAC application, or K-ETA for select short eligible visits', 'processing' => 'Typically 5-10 working days', 'fee' => 'Approx. ₹2,000-4,500 depending on entry type', 'validity' => 'Per visa granted, single or multiple entry', 'stay' => 'Up to 90 days depending on visa type', 'categories' => ['tourist-visa', 'business-visa', 'transit-visa', 'conference-visa']],
        'malaysia' => ['mode' => 'eVISA / eNTRI online application', 'processing' => 'Typically 3-5 working days', 'fee' => 'Approx. ₹1,000-2,500', 'validity' => '30-90 days from date of issue', 'stay' => 'Up to 30 days per visit', 'categories' => ['tourist-visa', 'business-visa', 'transit-visa', 'employment-visa']],
        'switzerland' => ['mode' => 'Schengen application through the visa application centre with biometrics', 'processing' => '15-30 calendar days, longer in peak season', 'fee' => 'Approx. CHF 88 (Schengen-aligned standard fee)', 'validity' => $schengenNote, 'stay' => 'Up to 90 days within any 180-day period, Schengen-wide', 'categories' => ['tourist-visa', 'business-visa', 'transit-visa', 'conference-visa']],
        'ireland' => ['mode' => 'online AVATS application (Ireland is outside Schengen, separate from the UK)', 'processing' => 'Typically 4-8 weeks', 'fee' => 'Approx. €60-100 depending on category', 'validity' => 'Per visa granted', 'stay' => 'Up to 90 days on a short-stay visa', 'categories' => ['tourist-visa', 'business-visa', 'family-visa', 'employment-visa', 'dependent-visa']],
        'china' => ['mode' => 'Consulate/VAC application, business visas typically require a local invitation letter', 'processing' => 'Typically 4-7 working days on standard service', 'fee' => 'Approx. ₹4,500-8,000 depending on category', 'validity' => 'Per visa granted, single or multiple entry', 'stay' => 'Up to 30-60 days per entry depending on visa type', 'categories' => ['tourist-visa', 'business-visa', 'transit-visa', 'conference-visa', 'employment-visa']],
        'saudi-arabia' => ['mode' => 'e-Visa online for eligible nationalities/purposes; employment visas require an employer sponsor', 'processing' => 'e-Visa: often issued within a few working days; employment visas take longer pending sponsor approval', 'fee' => 'Approx. ₹9,000-12,000 for the tourist e-visa (varies)', 'validity' => 'Up to 1 year multiple entry (tourist e-visa)', 'stay' => 'Up to 90 days per visit, subject to an annual cumulative cap', 'categories' => ['tourist-visa', 'business-visa', 'transit-visa', 'family-visa', 'employment-visa', 'official-visa']],
        'new-zealand' => ['mode' => 'online application through Immigration New Zealand', 'processing' => 'Average 3-4 weeks', 'fee' => 'Approx. ₹8,000-9,500 (~NZD 145-180) plus the International Visitor Levy', 'validity' => 'Up to 9-24 months depending on category', 'stay' => 'Up to 9 months per visit on a visitor visa', 'categories' => ['tourist-visa', 'business-visa', 'family-visa', 'employment-visa']],
        'brazil' => ['mode' => 'e-Visa online application', 'processing' => 'Typically 5 working days', 'fee' => 'Approx. ₹3,500 (~US$40)', 'validity' => 'Multiple entry for up to 2 years from issue', 'stay' => 'Up to 90 days per visit, 180 days per year cumulative', 'categories' => ['tourist-visa', 'business-visa', 'transit-visa']],
        'south-africa' => ['mode' => 'online application via the visa application centre, biometrics required', 'processing' => 'Typically 5-15 working days', 'fee' => 'Approx. ₹1,800-2,500 depending on visa category', 'validity' => 'Per visa granted', 'stay' => 'Up to 90 days per entry', 'categories' => ['tourist-visa', 'business-visa', 'transit-visa', 'family-visa']],
        'egypt' => ['mode' => 'e-Visa online, or visa on arrival for eligible nationalities', 'processing' => 'e-Visa: typically 3-7 working days', 'fee' => 'Approx. ₹2,100 (~US$25) for a single-entry e-visa', 'validity' => '30 days from date of entry', 'stay' => 'Up to 30 days, extendable locally', 'categories' => ['tourist-visa', 'business-visa', 'transit-visa']],
    ];
}

function compose_visa_content(string $countrySlug, string $countryName, array $facts, string $categorySlug, array $category): array
{
    $overview = "Videshia helps travellers from India apply for a {$countryName} {$category['name']} for {$category['purpose']}. "
        . "Applications are processed via {$facts['mode']}. Our consultants review your case, prepare a complete document set, "
        . "and track your application through to a decision.";

    $processSteps = [
        'Free consultation to confirm the right visa category and eligibility',
        'Document checklist and preparation, reviewed by a Videshia consultant',
        'Application form completion and fee payment',
        'Biometric appointment scheduling, where required',
        'Application submission to the embassy / consulate / visa centre',
        'Real-time status tracking until a decision is issued',
    ];

    $importantNotes = rtrim($facts['validity'], '. ') . '. Fees and processing times above are indicative ranges and can change without notice — '
        . 'always confirm current fees and requirements with a Videshia consultant before applying.';

    return [
        'overview' => $overview,
        'eligibility' => 'You will generally need ' . $category['eligibility'] . '.',
        'documents_required' => json_encode($category['documents'], JSON_UNESCAPED_UNICODE),
        'process_steps' => json_encode($processSteps, JSON_UNESCAPED_UNICODE),
        'processing_time' => $facts['processing'],
        'visa_fee' => $facts['fee'],
        'validity' => $facts['validity'],
        'stay_duration' => $facts['stay'],
        'entry_requirements' => 'Passport valid for at least 6 months beyond your intended stay, with at least 2 blank pages.',
        'financial_requirements' => 'Bank statements or income proof showing sufficient funds to cover the trip, proportional to its length and purpose.',
        'common_rejection_reasons' => json_encode($category['rejection_reasons'], JSON_UNESCAPED_UNICODE),
        'important_notes' => $importantNotes,
        'seo_title' => "{$countryName} {$category['name']} from India — Fees, Process & Documents | Videshia",
        'seo_description' => "Apply for a {$countryName} {$category['name']} with Videshia. Real processing times, document checklist, fees and step-by-step guidance for Indian applicants.",
    ];
}

function visa_faqs_for(string $countryName, array $category, array $facts): array
{
    return [
        ["How long does the {$countryName} {$category['name']} take to process?", $facts['processing'] . '. Videshia tracks your application and updates you at every stage.'],
        ['What documents do I need?', 'A complete checklist is prepared for your specific case during your free consultation — the core requirements are listed above.'],
        ['Can Videshia guarantee visa approval?', 'No visa agency can guarantee approval — the decision rests entirely with the embassy or consulate. We maximise your chances by ensuring your application is complete, accurate and well-documented.'],
        ['What is the visa validity and permitted stay?', rtrim($facts['validity'], '. ') . '. ' . $facts['stay']],
    ];
}
