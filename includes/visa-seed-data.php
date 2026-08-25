<?php
/**
 * Structured content definitions for country x visa-category pages, consumed
 * by visa_seed_page() in includes/visa-content-db.php. Each entry is one
 * fully-researched page. Deliberately a small, quality-gated batch — not all
 * 200+ countries — per the spec's own instruction against blind bulk
 * generation and against inventing facts (fees/processing times/eligibility
 * rules left as honest "check official source" fallbacks where they change
 * often; only stable, well-documented structural facts are populated).
 *
 * Add new entries here as more countries/categories are researched and
 * verified — visa_content_db() loops over this array on every bootstrap.
 */
function visa_seed_pages_def(): array
{
    return [
        // ---------------------------------------------------------------
        // Australia — Tourist Visa (original Phase 3 sample, migrated here)
        // ---------------------------------------------------------------
        [
            'page_slug' => 'australia-tourist-visa',
            'country_slug' => 'australia',
            'category_slug' => 'tourist-visa',
            'country_enrich' => [
                'official_name' => 'Commonwealth of Australia', 'iso2' => 'AU', 'iso3' => 'AUS',
                'capital' => 'Canberra', 'sub_region' => 'Australia and New Zealand',
                'currency' => 'Australian Dollar', 'currency_code' => 'AUD', 'popularity' => 90,
            ],
            'official_visa_name' => 'Visitor visa (subclass 600) — Tourist stream',
            'visa_subclass_code' => 'Subclass 600 (Tourist stream)',
            'intro_html' => "The Visitor visa (subclass 600), Tourist stream, is Australia's standard visa category for Indian citizens travelling for a holiday, sightseeing or to visit family and friends. Indian passport holders are not eligible for Australia's ETA or eVisitor visas, so tourist travel requires this online visa application through the Department of Home Affairs. VisaAgency.in helps you prepare a complete, well-documented application.",
            'typical_stay' => 'Typically 3, 6 or 12 months, as specified on your visa grant',
            'entry_type' => 'Single or multiple entry, as granted',
            'validity_text' => 'As specified on your visa grant notice',
            'application_method' => 'Online via ImmiAccount (Department of Home Affairs)',
            'interview_required' => 'Not usually, but may be requested in individual cases',
            'biometric_required' => 'May be required at a Visa Application Centre — check when you apply',
            'application_centre' => 'VFS Global Australia Visa Application Centre (India)',
            'authority_name' => 'Australian Government Department of Home Affairs',
            'authority_url' => 'https://immi.homeaffairs.gov.au/visas/getting-a-visa/visa-listing/visitor-600',
            'eligibility_html' => '<p>The Visitor visa (subclass 600), Tourist stream, is generally available to Indian passport holders who:</p>
<ul>
<li>Are travelling for genuine tourism &mdash; holidays, sightseeing, or visiting family and friends informally</li>
<li>Can demonstrate they intend to stay temporarily (the Department assesses this as part of the Genuine Temporary Entrant consideration)</li>
<li>Have sufficient funds to support themselves during the visit</li>
<li>Meet health and character requirements</li>
<li>Can show reasonable ties to India (employment, business, family or property) supporting an intention to return</li>
</ul>
<p>This is general guidance, not a guarantee of approval &mdash; every application is individually assessed by the Department of Home Affairs.</p>',
            'indian_applicant_html' => '<p>Indian citizens cannot use the ETA or eVisitor visa (these are limited to specific passport holders) and must apply for the Visitor visa (subclass 600) online through ImmiAccount. Commonly requested supporting evidence for Indian applicants includes:</p>
<ul>
<li>Bank statements and income tax returns showing financial capacity</li>
<li>Salary slips and an employer leave-approval letter (for salaried applicants), or business registration and financial documents (for self-employed applicants)</li>
<li>Evidence of ties to India, such as property, family or ongoing employment/business</li>
<li>Previous international travel history, where available</li>
<li>An invitation or contact details of family/friends in Australia, if visiting them</li>
</ul>
<p>Our consultants review your specific profile and help you present this evidence clearly before submission.</p>',
            'seo_title' => 'Australia Tourist Visa from India | Requirements, Documents &amp; Application',
            'meta_description' => 'Apply for an Australia Tourist Visa from India. Check eligibility, documents, application process, fees, processing information and visa assistance.',
            'og_title' => 'Australia Tourist Visa from India — Visa Agency',
            'og_description' => 'Everything Indian travellers need for the Australia Visitor visa (subclass 600) Tourist stream: eligibility, documents, fees, processing and application steps.',
            'documents' => [
                ['Basic Documents', "Valid passport (at least 6 months' validity beyond intended stay)"],
                ['Basic Documents', 'Recent passport-style photograph'],
                ['Basic Documents', 'Completed online application via ImmiAccount'],
                ['Basic Documents', 'Government-issued identity documents (e.g. Aadhaar, PAN)'],
                ['Financial Documents', 'Bank statements (typically last 6 months)'],
                ['Financial Documents', 'Income tax returns (ITR)'],
                ['Financial Documents', 'Salary slips (salaried applicants) or business financial documents (self-employed)'],
                ['Travel Documents', 'Tentative travel itinerary'],
                ['Travel Documents', 'Hotel booking or accommodation details'],
                ['Travel Documents', 'Travel insurance (recommended)'],
                ['Supporting Documents', 'Employment leave-approval letter'],
                ['Supporting Documents', 'Evidence of ties to India (property, family, employment/business)'],
                ['Supporting Documents', 'Previous visa or international travel history, if applicable'],
                ['Supporting Documents', 'Invitation or host details, if visiting family or friends'],
            ],
            'steps' => [
                ['Check Eligibility', 'Confirm the Visitor visa (subclass 600) Tourist stream is the right category for your trip.'],
                ['Create an ImmiAccount', "Register on the Department of Home Affairs' online portal to begin your application."],
                ['Prepare Documents', 'Gather your passport, financial evidence, travel itinerary and supporting documents.'],
                ['Lodge Application Online', 'Complete and submit your subclass 600 application with supporting documents through ImmiAccount.'],
                ['Pay the Visa Application Charge', 'Pay the government visa application charge as part of lodgement.'],
                ['Biometrics, If Requested', 'Provide biometrics at a Visa Application Centre if the Department requests it.'],
                ['Application Processing', 'The Department assesses your application — track status through ImmiAccount.'],
                ['Visa Decision &amp; Travel', 'Once granted, review your visa conditions (stay period, entries, work restrictions) before travelling.'],
            ],
            'faqs' => [
                ['Do Indian citizens need a visa for Australia?', 'Yes. All Indian passport holders need a visa before travelling to Australia for tourism — Indians are not eligible for the ETA or eVisitor visa, which are limited to specific passport holders.'],
                ['Which visa should Indian tourists apply for?', 'The Visitor visa (subclass 600), Tourist stream, is the standard visa category for Indian citizens travelling to Australia for a holiday or to visit family and friends.'],
                ['How do I apply for an Australia Tourist Visa from India?', "Applications are lodged online through the Department of Home Affairs' ImmiAccount portal, with supporting documents uploaded electronically."],
                ['What documents are required?', 'A valid passport, photograph, financial evidence, travel itinerary and supporting documents demonstrating genuine tourism intent and ties to India — see the Documents section above for the full checklist.'],
                ['How long does processing take?', "Processing times vary by application volume and individual circumstances. Check the Department of Home Affairs' current published processing times before planning your travel dates."],
                ['How much does the visa cost?', "The government visa application charge is set by the Department of Home Affairs and may change — check their official fee estimator at the time you apply. VisaAgency's service fee is charged separately from the government fee."],
                ['Is an interview required?', 'An interview is not usually required, though the Department may request one or ask for additional information in individual cases.'],
                ['Are biometrics required?', 'Biometrics may be required depending on your application and location. Check current requirements when you apply, or ask your Visa Agency consultant.'],
                ['How long can I stay in Australia on this visa?', 'Stay duration is specified on your visa grant notice — typically 3, 6 or 12 months, depending on what is granted.'],
                ['Can I travel for business on a tourist visa?', 'No. The Tourist stream is intended for genuine tourism. Business activities such as meetings or conferences fall under the Business Visitor stream of the same subclass 600 visa — see our Australia Business Visa page.'],
                ['Can I extend an Australia Tourist Visa?', 'Extension is not automatic. You would generally need to lodge a new Visitor visa application before your current visa expires, meeting the same eligibility and document requirements again.'],
                ['What happens if my visa is refused?', 'If refused, the Department of Home Affairs will provide the reason. Depending on the circumstances, you may be able to reapply and address the concerns raised. Visa approval is solely at the discretion of the Department.'],
            ],
            'fees' => [
                ['Base Application Charge', 'Check the official Visa Pricing Estimator — changes periodically', 1],
                ['Visa Agency Service Fee', 'Contact us for current pricing for this visa category', 0],
            ],
            'source' => [
                'authority' => 'Australian Government Department of Home Affairs',
                'url' => 'https://immi.homeaffairs.gov.au/visas/getting-a-visa/visa-listing/visitor-600',
                'notes' => 'Subclass 600 Tourist stream — general visa category, eligibility and process information.',
            ],
        ],

        // ---------------------------------------------------------------
        // United Kingdom — Tourist Visa (Standard Visitor visa)
        // ---------------------------------------------------------------
        [
            'page_slug' => 'uk-tourist-visa',
            'country_slug' => 'uk',
            'category_slug' => 'tourist-visa',
            'country_enrich' => [
                'official_name' => 'United Kingdom of Great Britain and Northern Ireland', 'iso2' => 'GB', 'iso3' => 'GBR',
                'capital' => 'London', 'sub_region' => 'Northern Europe',
                'currency' => 'Pound Sterling', 'currency_code' => 'GBP', 'popularity' => 88,
            ],
            'official_visa_name' => 'Standard Visitor visa',
            'visa_subclass_code' => null,
            'intro_html' => 'The Standard Visitor visa is the UK immigration category for Indian citizens travelling for tourism, sightseeing, or to visit family and friends. It is applied for entirely online through the UK government portal, with biometric enrolment at a visa application centre in India. VisaAgency.in helps you prepare a complete, well-evidenced application.',
            'typical_stay' => 'Usually up to 6 months per visit',
            'entry_type' => 'Multiple entry within the visa validity period',
            'validity_text' => '6 months, or a long-term Standard Visitor visa of 2, 5 or 10 years (stay per visit is still capped, commonly at 6 months)',
            'application_method' => 'Online via GOV.UK, with biometrics at a Visa Application Centre',
            'interview_required' => 'Not usually required',
            'biometric_required' => 'Yes — fingerprints and a photograph at a Visa Application Centre',
            'application_centre' => 'VFS Global or TLScontact Visa Application Centre (India)',
            'authority_name' => 'UK Visas and Immigration (UKVI), Home Office',
            'authority_url' => 'https://www.gov.uk/standard-visitor',
            'eligibility_html' => '<p>The Standard Visitor visa is generally available to Indian passport holders who:</p>
<ul>
<li>Intend to visit the UK for tourism, leisure, or to see family and friends</li>
<li>Plan to fund their trip themselves, or be funded by a relative or friend, without accessing public funds</li>
<li>Intend to leave the UK at the end of their visit</li>
<li>Can show enough money to cover their trip, or evidence it will be covered by a host/sponsor</li>
<li>Meet UK Visas and Immigration&rsquo;s general suitability requirements</li>
</ul>
<p>This is general guidance, not a guarantee of approval &mdash; every application is individually assessed by UK Visas and Immigration.</p>',
            'indian_applicant_html' => '<p>Indian applicants apply online through the GOV.UK visa portal and then attend a Visa Application Centre in India for biometrics and document submission. Commonly requested supporting evidence includes:</p>
<ul>
<li>Bank statements and income tax returns showing financial capacity</li>
<li>Salary slips and an employer leave-approval letter, or business registration and financial documents for self-employed applicants</li>
<li>Evidence of ties to India, such as property, family or ongoing employment/business</li>
<li>A cover letter outlining the purpose and itinerary of the visit</li>
<li>An invitation letter, if visiting family or friends in the UK</li>
</ul>
<p>Our consultants review your specific profile and help you present this evidence clearly before you submit your application.</p>',
            'seo_title' => 'UK Tourist Visa from India | Standard Visitor Visa Requirements &amp; Documents',
            'meta_description' => 'Apply for a UK Tourist Visa (Standard Visitor visa) from India. Check eligibility, documents, application process and visa assistance from Visa Agency.',
            'og_title' => 'UK Tourist Visa from India — Visa Agency',
            'og_description' => 'Everything Indian travellers need for the UK Standard Visitor visa: eligibility, documents, application steps and fees.',
            'documents' => [
                ['Basic Documents', "Valid passport (with at least one blank page)"],
                ['Basic Documents', 'Recent passport-style photograph'],
                ['Basic Documents', 'Completed online visa application form'],
                ['Basic Documents', 'Biometric enrolment at a Visa Application Centre'],
                ['Financial Documents', 'Bank statements (typically last 6 months)'],
                ['Financial Documents', 'Income tax returns (ITR)'],
                ['Financial Documents', 'Salary slips or self-employment/business financial documents'],
                ['Travel Documents', 'Travel itinerary and return flight details'],
                ['Travel Documents', 'Hotel booking or accommodation details'],
                ['Travel Documents', 'Travel insurance (recommended)'],
                ['Supporting Documents', 'Employer leave-approval letter'],
                ['Supporting Documents', 'Evidence of ties to India (property, family, employment/business)'],
                ['Supporting Documents', 'Cover letter explaining the purpose of the visit'],
                ['Supporting Documents', 'Invitation letter from UK host, if applicable'],
            ],
            'steps' => [
                ['Check Eligibility', 'Confirm the Standard Visitor visa is the right category for your trip.'],
                ['Complete the Online Application', 'Fill in the visa application form on the GOV.UK portal.'],
                ['Pay the Visa Fee', 'Pay the government visa fee as part of the online application.'],
                ['Book a Biometric Appointment', 'Schedule an appointment at a Visa Application Centre in India.'],
                ['Attend the Appointment', 'Submit biometrics and supporting documents at the Visa Application Centre.'],
                ['Application Processing', 'UK Visas and Immigration assesses your application.'],
                ['Visa Decision', 'Receive your passport back with the visa decision.'],
                ['Travel', 'Review your visa conditions (validity, permitted stay) before travelling.'],
            ],
            'faqs' => [
                ['Do Indian citizens need a visa for the UK?', 'Yes. All Indian passport holders need a visa before travelling to the UK for tourism.'],
                ['Which visa should Indian tourists apply for?', 'The Standard Visitor visa is the standard category for Indian citizens travelling to the UK for tourism, sightseeing, or to visit family and friends.'],
                ['How do I apply for a UK Tourist Visa from India?', 'Applications are submitted online via GOV.UK, followed by a biometric appointment at a Visa Application Centre in India.'],
                ['What documents are required?', 'A valid passport, financial evidence, travel itinerary and supporting documents demonstrating genuine visit intent and ties to India — see the Documents section above.'],
                ['How long does processing take?', 'Processing times vary by application volume and time of year. Check UK Visas and Immigration&rsquo;s current published processing times before planning your travel dates.'],
                ['How much does the visa cost?', 'The government visa fee is set by UK Visas and Immigration and depends on the visa length chosen (6 months, or a 2/5/10-year long-term visa) — check the official fee page at the time you apply. VisaAgency&rsquo;s service fee is charged separately.'],
                ['Is an interview required?', 'An interview is not usually required, though UKVI may request additional documents or information in individual cases.'],
                ['Are biometrics required?', 'Yes. All applicants must provide fingerprints and a photograph at a Visa Application Centre as part of the application.'],
                ['How long can I stay in the UK on this visa?', 'Usually up to 6 months per visit, even if you hold a longer-validity (2, 5 or 10-year) Standard Visitor visa.'],
                ['Can I work in the UK on a Standard Visitor visa?', 'No. The Standard Visitor visa does not permit employment in the UK; it is intended for tourism, visiting family/friends, and limited permitted business activities such as attending meetings or conferences.'],
                ['Can I extend a UK Tourist Visa?', 'Extension from within the UK is not generally available for Standard Visitor visas; you would typically need to apply for a fresh visa before a future visit.'],
                ['What happens if my visa is refused?', 'If refused, UK Visas and Immigration will state the reason. Depending on the circumstances, you may be able to reapply and address the concerns raised. Visa approval is solely at UKVI&rsquo;s discretion.'],
            ],
            'fees' => [
                ['Standard Visitor Visa Fee', 'Check the official GOV.UK visa fees page — varies by visa length (6 months / 2 / 5 / 10 years)', 1],
                ['Visa Agency Service Fee', 'Contact us for current pricing for this visa category', 0],
            ],
            'source' => [
                'authority' => 'UK Visas and Immigration (UKVI), Home Office',
                'url' => 'https://www.gov.uk/standard-visitor',
                'notes' => 'Standard Visitor visa — general visa category, eligibility and process information.',
            ],
        ],

        // ---------------------------------------------------------------
        // United States — Tourist Visa (B-2 Visitor Visa)
        // ---------------------------------------------------------------
        [
            'page_slug' => 'usa-tourist-visa',
            'country_slug' => 'usa',
            'category_slug' => 'tourist-visa',
            'country_enrich' => [
                'official_name' => 'United States of America', 'iso2' => 'US', 'iso3' => 'USA',
                'capital' => 'Washington, D.C.', 'sub_region' => 'North America',
                'currency' => 'US Dollar', 'currency_code' => 'USD', 'popularity' => 92,
            ],
            'official_visa_name' => 'B-2 Visitor Visa (often issued as a combined B-1/B-2 visa)',
            'visa_subclass_code' => 'B-2 (Visitor for Pleasure)',
            'intro_html' => 'The B-2 Visitor Visa is the US nonimmigrant visa category for Indian citizens travelling for tourism, sightseeing, or to visit family and friends; it is frequently issued as a combined B-1/B-2 visa covering both business and tourism purposes. Unlike many countries, the US application process requires an in-person interview at the Embassy or a Consulate. VisaAgency.in helps you prepare a complete application and interview-ready documentation.',
            'typical_stay' => 'Determined by the U.S. Customs and Border Protection officer at the port of entry, not by the visa itself',
            'entry_type' => 'Usually multiple entry, as printed on the visa',
            'validity_text' => 'Often up to 10 years for Indian citizens, though the permitted stay per visit is set separately at the port of entry',
            'application_method' => 'Online DS-160 form, followed by a mandatory in-person interview',
            'interview_required' => 'Yes — a visa interview is mandatory for almost all applicants',
            'biometric_required' => 'Yes — fingerprints are taken at the interview appointment',
            'application_centre' => 'U.S. Embassy New Delhi, or U.S. Consulates in Mumbai, Chennai, Kolkata or Hyderabad',
            'authority_name' => 'U.S. Department of State, via the U.S. Embassy and Consulates in India',
            'authority_url' => 'https://in.usembassy.gov/visas/nonimmigrant-visas/',
            'eligibility_html' => '<p>The B-2 Visitor Visa is generally available to Indian passport holders who:</p>
<ul>
<li>Intend to visit the United States temporarily for tourism, pleasure, or to visit family and friends</li>
<li>Plan to stay for a specific, limited period</li>
<li>Have a residence outside the US which they do not intend to abandon, and other ties that will ensure their return</li>
<li>Have sufficient funds to cover their trip</li>
<li>Are otherwise admissible under US immigration law</li>
</ul>
<p>This is general guidance, not a guarantee of approval &mdash; every application is individually assessed by a consular officer at the interview.</p>',
            'indian_applicant_html' => '<p>Indian applicants complete the online DS-160 form, pay the visa fee, and then attend a mandatory in-person interview at the Embassy in New Delhi or a Consulate in Mumbai, Chennai, Kolkata or Hyderabad. Commonly requested supporting evidence includes:</p>
<ul>
<li>Bank statements and income tax returns showing financial capacity</li>
<li>Salary slips and an employer leave-approval letter, or business registration and financial documents for self-employed applicants</li>
<li>Evidence of strong ties to India, such as property, family or ongoing employment/business</li>
<li>A clear travel itinerary and purpose of visit</li>
<li>Previous US or international travel history, where available</li>
</ul>
<p>Interview appointment wait times vary significantly through the year &mdash; check the Embassy&rsquo;s current estimated wait times before planning your travel dates. Our consultants help you prepare your DS-160, documentation and interview readiness.</p>',
            'seo_title' => 'USA Tourist Visa from India | B-2 Visitor Visa Requirements &amp; Interview',
            'meta_description' => 'Apply for a USA Tourist Visa (B-2 Visitor Visa) from India. Check eligibility, DS-160 process, interview requirements, documents and visa assistance.',
            'og_title' => 'USA Tourist Visa from India — Visa Agency',
            'og_description' => 'Everything Indian travellers need for the US B-2 Visitor Visa: DS-160, interview preparation, documents and application steps.',
            'documents' => [
                ['Basic Documents', "Valid passport (valid for travel to the US, with at least one blank page)"],
                ['Basic Documents', 'Recent passport-style photograph meeting US visa photo requirements'],
                ['Basic Documents', 'DS-160 confirmation page'],
                ['Basic Documents', 'Visa interview appointment confirmation'],
                ['Financial Documents', 'Bank statements (typically last 6 months)'],
                ['Financial Documents', 'Income tax returns (ITR)'],
                ['Financial Documents', 'Salary slips or self-employment/business financial documents'],
                ['Travel Documents', 'Tentative travel itinerary'],
                ['Travel Documents', 'Evidence of accommodation arrangements, if available'],
                ['Travel Documents', 'Previous US visas or travel history, if any'],
                ['Supporting Documents', 'Employer leave-approval letter'],
                ['Supporting Documents', 'Evidence of ties to India (property, family, employment/business)'],
                ['Supporting Documents', 'Invitation letter from a US host, if visiting family or friends'],
                ['Supporting Documents', 'Any additional documents requested by the consular officer'],
            ],
            'steps' => [
                ['Check Eligibility', 'Confirm the B-2 (or combined B-1/B-2) visa is the right category for your trip.'],
                ['Complete the DS-160 Form', 'Fill in the online nonimmigrant visa application form.'],
                ['Pay the Visa Application Fee', 'Pay the MRV (machine-readable visa) fee.'],
                ['Schedule Your Interview', 'Book a visa interview appointment at the Embassy or a Consulate.'],
                ['Prepare Your Documents', 'Gather financial, travel and supporting documents for the interview.'],
                ['Attend the Interview', 'Attend the mandatory in-person interview and biometrics.'],
                ['Application Processing', 'Some applications require administrative processing after the interview.'],
                ['Visa Issuance &amp; Travel', 'Once issued, review your visa validity and the permitted stay given by CBP at entry.'],
            ],
            'faqs' => [
                ['Do Indian citizens need a visa for the USA?', 'Yes. All Indian passport holders need a visa before travelling to the United States for tourism.'],
                ['Which visa should Indian tourists apply for?', 'The B-2 Visitor Visa, often issued as a combined B-1/B-2 visa, is the standard category for Indian citizens travelling to the US for tourism or to visit family and friends.'],
                ['Is a visa interview mandatory for the USA?', 'Yes. Unlike many countries, almost all US visa applicants must attend an in-person interview at the Embassy or a Consulate.'],
                ['How do I apply for a USA Tourist Visa from India?', 'Applicants complete the online DS-160 form, pay the visa fee, and then attend a scheduled interview at the Embassy in New Delhi or a Consulate in Mumbai, Chennai, Kolkata or Hyderabad.'],
                ['What documents are required?', 'A valid passport, DS-160 confirmation, financial evidence, and supporting documents demonstrating ties to India and genuine visit intent — see the Documents section above.'],
                ['How long does the interview wait take?', 'Interview appointment wait times vary significantly depending on the time of year and demand. Check the Embassy&rsquo;s current published wait times before planning your travel dates.'],
                ['How much does the visa cost?', 'The MRV application fee is set by the US Department of State and may be revised — check the official fee page at the time you apply. VisaAgency&rsquo;s service fee is charged separately.'],
                ['Are biometrics required?', 'Yes. Fingerprints are collected as part of the visa interview appointment.'],
                ['How long can I stay in the US on a B-2 visa?', 'Permitted stay is decided by the Customs and Border Protection officer at the port of entry, not by the visa validity itself — it is stamped in your passport or noted electronically on arrival.'],
                ['Can I work in the US on a B-2 visa?', 'No. The B-2 visa does not permit employment in the United States; it is intended for tourism, pleasure travel, and visiting family or friends.'],
                ['Can I extend a US Tourist Visa stay?', 'An extension of stay may be requested from within the US in limited circumstances, filed with US Citizenship and Immigration Services before the authorized stay expires — this is separate from the visa itself.'],
                ['What happens if my visa is refused?', 'If refused, the consular officer will generally state the ground for refusal. Depending on the circumstances, you may be able to reapply and address the concerns raised. Visa issuance is solely at the consular officer&rsquo;s discretion.'],
            ],
            'fees' => [
                ['MRV Application Fee', 'Check the official U.S. Department of State visa fee page — subject to change', 1],
                ['Visa Agency Service Fee', 'Contact us for current pricing for this visa category', 0],
            ],
            'source' => [
                'authority' => 'U.S. Department of State, via the U.S. Embassy and Consulates in India',
                'url' => 'https://in.usembassy.gov/visas/nonimmigrant-visas/',
                'notes' => 'B-2 (and combined B-1/B-2) Visitor Visa — general visa category, eligibility and interview process information.',
            ],
        ],

        // ---------------------------------------------------------------
        // Canada — Tourist Visa (Temporary Resident Visa / Visitor visa)
        // ---------------------------------------------------------------
        [
            'page_slug' => 'canada-tourist-visa',
            'country_slug' => 'canada',
            'category_slug' => 'tourist-visa',
            'country_enrich' => [
                'official_name' => 'Canada', 'iso2' => 'CA', 'iso3' => 'CAN',
                'capital' => 'Ottawa', 'sub_region' => 'North America',
                'currency' => 'Canadian Dollar', 'currency_code' => 'CAD', 'popularity' => 85,
            ],
            'official_visa_name' => 'Temporary Resident Visa (Visitor visa)',
            'visa_subclass_code' => null,
            'intro_html' => "The Temporary Resident Visa, commonly called a Visitor visa, is Canada's immigration category for Indian citizens travelling for tourism, sightseeing, or to visit family and friends. It is applied for online through an IRCC secure account, with biometric enrolment at a Visa Application Centre in India. VisaAgency.in helps you prepare a complete, well-documented application.",
            'typical_stay' => 'Usually up to 6 months per visit, as determined by the border services officer on arrival',
            'entry_type' => 'Most Indian applicants are granted multiple entry',
            'validity_text' => 'Often valid up to 10 years or until passport expiry, whichever is earlier — stay per visit is still set on arrival',
            'application_method' => 'Online via an IRCC secure account, with biometrics at a Visa Application Centre',
            'interview_required' => 'Not usually required',
            'biometric_required' => 'Yes — fingerprints and a photograph at a Visa Application Centre',
            'application_centre' => 'VFS Global Visa Application Centre (India)',
            'authority_name' => 'Immigration, Refugees and Citizenship Canada (IRCC)',
            'authority_url' => 'https://www.canada.ca/en/immigration-refugees-citizenship/services/visit-canada/apply-visitor-visa.html',
            'eligibility_html' => '<p>The Visitor visa is generally available to Indian passport holders who:</p>
<ul>
<li>Intend to visit Canada temporarily for tourism, sightseeing, or to visit family and friends</li>
<li>Have a valid travel document and are in good health</li>
<li>Have no criminal or immigration-related history that would make them inadmissible</li>
<li>Can satisfy an officer that they will leave Canada at the end of their visit</li>
<li>Have sufficient funds to support themselves and any accompanying family during the visit</li>
</ul>
<p>This is general guidance, not a guarantee of approval &mdash; every application is individually assessed by Immigration, Refugees and Citizenship Canada.</p>',
            'indian_applicant_html' => '<p>Indian applicants apply online through an IRCC secure account and then attend a Visa Application Centre in India for biometrics. Commonly requested supporting evidence includes:</p>
<ul>
<li>Bank statements and income tax returns showing financial capacity</li>
<li>Salary slips and an employer leave-approval letter, or business registration and financial documents for self-employed applicants</li>
<li>Evidence of ties to India, such as property, family or ongoing employment/business</li>
<li>A letter of invitation, if visiting family or friends in Canada</li>
<li>Travel history and any previous Canadian visas, if applicable</li>
</ul>
<p>If you are travelling to visit parents or grandparents specifically, Canada also offers a separate long-stay Super Visa category under our Family Visa services &mdash; ask our consultants which route fits your situation.</p>',
            'seo_title' => 'Canada Tourist Visa from India | Visitor Visa Requirements &amp; Documents',
            'meta_description' => 'Apply for a Canada Tourist Visa (Temporary Resident Visitor visa) from India. Check eligibility, documents, application process and visa assistance.',
            'og_title' => 'Canada Tourist Visa from India — Visa Agency',
            'og_description' => 'Everything Indian travellers need for the Canada Temporary Resident Visa (Visitor visa): eligibility, documents, application steps and fees.',
            'documents' => [
                ['Basic Documents', "Valid passport (with at least one blank page)"],
                ['Basic Documents', 'Recent passport-style photograph'],
                ['Basic Documents', 'Completed online application via an IRCC secure account'],
                ['Basic Documents', 'Biometric enrolment at a Visa Application Centre'],
                ['Financial Documents', 'Bank statements (typically last 6 months)'],
                ['Financial Documents', 'Income tax returns (ITR)'],
                ['Financial Documents', 'Salary slips or self-employment/business financial documents'],
                ['Travel Documents', 'Tentative travel itinerary'],
                ['Travel Documents', 'Hotel booking or accommodation details'],
                ['Travel Documents', 'Travel insurance (recommended)'],
                ['Supporting Documents', 'Employer leave-approval letter'],
                ['Supporting Documents', 'Evidence of ties to India (property, family, employment/business)'],
                ['Supporting Documents', 'Letter of invitation from Canadian host, if applicable'],
                ['Supporting Documents', 'Previous visa or international travel history, if any'],
            ],
            'steps' => [
                ['Check Eligibility', 'Confirm the Visitor visa is the right category for your trip.'],
                ['Create an IRCC Secure Account', "Register online to begin your Temporary Resident Visa application."],
                ['Prepare Documents', 'Gather your passport, financial evidence, travel itinerary and supporting documents.'],
                ['Submit Application Online', 'Complete and submit your application with supporting documents through your IRCC account.'],
                ['Pay the Application Fee', 'Pay the government processing fee and, where applicable, the biometrics fee.'],
                ['Give Biometrics', 'Attend a Visa Application Centre in India to provide fingerprints and a photograph.'],
                ['Application Processing', 'IRCC assesses your application — track status through your online account.'],
                ['Visa Decision &amp; Travel', 'Once approved, review your visa validity and entry conditions before travelling.'],
            ],
            'faqs' => [
                ['Do Indian citizens need a visa for Canada?', 'Yes. All Indian passport holders need a Temporary Resident Visa (Visitor visa) before travelling to Canada for tourism.'],
                ['Which visa should Indian tourists apply for?', 'The Temporary Resident Visa (Visitor visa) is the standard category for Indian citizens travelling to Canada for tourism or to visit family and friends.'],
                ['How do I apply for a Canada Tourist Visa from India?', 'Applications are submitted online through an IRCC secure account, followed by biometric enrolment at a Visa Application Centre in India.'],
                ['What documents are required?', 'A valid passport, financial evidence, travel itinerary and supporting documents demonstrating genuine visit intent and ties to India — see the Documents section above.'],
                ['How long does processing take?', 'Processing times vary by application volume and visa office. Check IRCC&rsquo;s current published processing times before planning your travel dates.'],
                ['How much does the visa cost?', 'The government processing fee (and biometrics fee, where applicable) is set by IRCC and may change — check the official fee page at the time you apply. VisaAgency&rsquo;s service fee is charged separately.'],
                ['Is an interview required?', 'An interview is not usually required, though IRCC may request additional documents or an interview in individual cases.'],
                ['Are biometrics required?', 'Yes. Most visitor visa applicants must provide fingerprints and a photograph at a Visa Application Centre.'],
                ['How long can I stay in Canada on this visa?', 'Usually up to 6 months per visit, as determined by the border services officer when you arrive — even if your visa itself is valid for up to 10 years.'],
                ['Is there a separate visa for visiting parents or grandparents in Canada?', 'Yes. Canada offers a Super Visa, a long-stay multiple-entry option specifically for parents and grandparents of Canadian citizens or permanent residents — this falls under our Family Visa services rather than the standard Tourist Visitor visa.'],
                ['Can I extend a Canada Tourist Visa stay?', 'You may apply to extend your stay from within Canada before your authorized stay expires, though approval is not guaranteed and is assessed individually by IRCC.'],
                ['What happens if my visa is refused?', 'If refused, IRCC will provide the reason. Depending on the circumstances, you may be able to reapply and address the concerns raised. Visa approval is solely at IRCC&rsquo;s discretion.'],
            ],
            'fees' => [
                ['Temporary Resident Visa Processing Fee', 'Check the official IRCC fee list — biometrics fee may also apply', 1],
                ['Visa Agency Service Fee', 'Contact us for current pricing for this visa category', 0],
            ],
            'source' => [
                'authority' => 'Immigration, Refugees and Citizenship Canada (IRCC)',
                'url' => 'https://www.canada.ca/en/immigration-refugees-citizenship/services/visit-canada/apply-visitor-visa.html',
                'notes' => 'Temporary Resident Visa (Visitor visa) — general visa category, eligibility and process information.',
            ],
        ],

        // ---------------------------------------------------------------
        // New Zealand — Tourist Visa (Visitor Visa)
        // ---------------------------------------------------------------
        [
            'page_slug' => 'new-zealand-tourist-visa',
            'country_slug' => 'new-zealand',
            'category_slug' => 'tourist-visa',
            'country_enrich' => [
                'official_name' => 'New Zealand', 'iso2' => 'NZ', 'iso3' => 'NZL',
                'capital' => 'Wellington', 'sub_region' => 'Australia and New Zealand',
                'currency' => 'New Zealand Dollar', 'currency_code' => 'NZD', 'popularity' => 70,
            ],
            'official_visa_name' => 'Visitor Visa',
            'visa_subclass_code' => null,
            'intro_html' => "The Visitor Visa is New Zealand's standard immigration category for Indian citizens travelling for tourism, sightseeing, or to visit family and friends. India is not on New Zealand's visa-waiver list, so the short-stay NZeTA is not sufficient for Indian passport holders &mdash; a full Visitor Visa application is required. VisaAgency.in helps you prepare a complete, well-documented application through Immigration New Zealand.",
            'typical_stay' => 'As specified on your visa grant, commonly up to 9 months',
            'entry_type' => 'Single or multiple entry, as granted',
            'validity_text' => 'As specified on your visa grant notice',
            'application_method' => 'Online via Immigration New Zealand (INZ) / RealMe account',
            'interview_required' => 'Not usually required',
            'biometric_required' => 'May be required at a Visa Application Centre — check when you apply',
            'application_centre' => 'VFS Global Visa Application Centre (India)',
            'authority_name' => 'Immigration New Zealand (INZ)',
            'authority_url' => 'https://www.immigration.govt.nz/new-zealand-visas/apply-for-a-visa/about-visa/visitor-visa',
            'eligibility_html' => '<p>The Visitor Visa is generally available to Indian passport holders who:</p>
<ul>
<li>Are travelling for genuine tourism, sightseeing, or to visit family and friends</li>
<li>Intend to leave New Zealand before their visa expires</li>
<li>Have a valid passport and, where required, a return or onward ticket</li>
<li>Have sufficient funds to support themselves during the visit, or evidence of sponsorship</li>
<li>Meet health and character requirements</li>
</ul>
<p>This is general guidance, not a guarantee of approval &mdash; every application is individually assessed by Immigration New Zealand.</p>',
            'indian_applicant_html' => '<p>India is not on New Zealand&rsquo;s visa-waiver country list, so Indian citizens must apply for a full Visitor Visa &mdash; the short-stay NZeTA available to waiver-country travellers does not apply. Applications are lodged online through an INZ/RealMe account. Commonly requested supporting evidence includes:</p>
<ul>
<li>Bank statements and income tax returns showing financial capacity</li>
<li>Salary slips and an employer leave-approval letter, or business registration and financial documents for self-employed applicants</li>
<li>Evidence of ties to India, such as property, family or ongoing employment/business</li>
<li>A clear travel itinerary and return or onward travel arrangements</li>
<li>An invitation letter, if visiting family or friends in New Zealand</li>
</ul>
<p>Our consultants review your specific profile and help you present this evidence clearly before submission.</p>',
            'seo_title' => 'New Zealand Tourist Visa from India | Visitor Visa Requirements &amp; Documents',
            'meta_description' => 'Apply for a New Zealand Tourist Visa (Visitor Visa) from India. Check eligibility, documents, application process and visa assistance from Visa Agency.',
            'og_title' => 'New Zealand Tourist Visa from India — Visa Agency',
            'og_description' => 'Everything Indian travellers need for the New Zealand Visitor Visa: eligibility, documents, application steps and fees.',
            'documents' => [
                ['Basic Documents', "Valid passport (with at least one blank page)"],
                ['Basic Documents', 'Recent passport-style photograph'],
                ['Basic Documents', 'Completed online application via INZ/RealMe account'],
                ['Basic Documents', 'Biometric enrolment at a Visa Application Centre, if requested'],
                ['Financial Documents', 'Bank statements (typically last 6 months)'],
                ['Financial Documents', 'Income tax returns (ITR)'],
                ['Financial Documents', 'Salary slips or self-employment/business financial documents'],
                ['Travel Documents', 'Return or onward travel itinerary'],
                ['Travel Documents', 'Hotel booking or accommodation details'],
                ['Travel Documents', 'Travel/medical insurance (recommended)'],
                ['Supporting Documents', 'Employer leave-approval letter'],
                ['Supporting Documents', 'Evidence of ties to India (property, family, employment/business)'],
                ['Supporting Documents', 'Invitation letter from New Zealand host, if applicable'],
                ['Supporting Documents', 'Previous visa or international travel history, if any'],
            ],
            'steps' => [
                ['Check Eligibility', 'Confirm the Visitor Visa is the right category for your trip (note: NZeTA alone is not sufficient for Indian passport holders).'],
                ['Create an INZ/RealMe Account', 'Register online to begin your Visitor Visa application.'],
                ['Prepare Documents', 'Gather your passport, financial evidence, travel itinerary and supporting documents.'],
                ['Submit Application Online', 'Complete and submit your application with supporting documents through your INZ account.'],
                ['Pay the Visa Fee', 'Pay the government visa application fee (and IVL, where applicable) as part of lodgement.'],
                ['Biometrics, If Requested', 'Attend a Visa Application Centre in India if biometrics are requested.'],
                ['Application Processing', 'Immigration New Zealand assesses your application — track status through your online account.'],
                ['Visa Decision &amp; Travel', 'Once granted, review your visa conditions (stay period, entries) before travelling.'],
            ],
            'faqs' => [
                ['Do Indian citizens need a visa for New Zealand?', 'Yes. India is not on New Zealand&rsquo;s visa-waiver list, so Indian passport holders need a full Visitor Visa, not just the short-stay NZeTA.'],
                ['Which visa should Indian tourists apply for?', 'The Visitor Visa is the standard category for Indian citizens travelling to New Zealand for tourism or to visit family and friends.'],
                ['How do I apply for a New Zealand Tourist Visa from India?', 'Applications are submitted online through an Immigration New Zealand (INZ) / RealMe account, with supporting documents uploaded electronically.'],
                ['What documents are required?', 'A valid passport, financial evidence, travel itinerary and supporting documents demonstrating genuine visit intent and ties to India — see the Documents section above.'],
                ['How long does processing take?', 'Processing times vary by application volume and individual circumstances. Check Immigration New Zealand&rsquo;s current published processing times before planning your travel dates.'],
                ['How much does the visa cost?', 'The government visa fee (and International Visitor Levy, where applicable) is set by Immigration New Zealand and may change — check the official fee page at the time you apply. VisaAgency&rsquo;s service fee is charged separately.'],
                ['Is an interview required?', 'An interview is not usually required, though Immigration New Zealand may request additional documents or information in individual cases.'],
                ['Are biometrics required?', 'Biometrics may be required depending on your application and location. Check current requirements when you apply, or ask your Visa Agency consultant.'],
                ['How long can I stay in New Zealand on this visa?', 'Stay duration is specified on your visa grant notice — commonly up to 9 months, depending on what is granted.'],
                ['Can I work in New Zealand on a Visitor Visa?', 'No. The Visitor Visa does not generally permit employment in New Zealand; it is intended for tourism and visiting family or friends.'],
                ['Can I extend a New Zealand Tourist Visa?', 'Extension is not automatic. You would generally need to apply for a further visa before your current visa expires, meeting the same eligibility and document requirements again.'],
                ['What happens if my visa is refused?', 'If refused, Immigration New Zealand will provide the reason. Depending on the circumstances, you may be able to reapply and address the concerns raised. Visa approval is solely at Immigration New Zealand&rsquo;s discretion.'],
            ],
            'fees' => [
                ['Visitor Visa Application Fee', 'Check the official Immigration New Zealand fees page — International Visitor Levy may also apply', 1],
                ['Visa Agency Service Fee', 'Contact us for current pricing for this visa category', 0],
            ],
            'source' => [
                'authority' => 'Immigration New Zealand (INZ)',
                'url' => 'https://www.immigration.govt.nz/new-zealand-visas/apply-for-a-visa/about-visa/visitor-visa',
                'notes' => 'Visitor Visa — general visa category, eligibility and process information.',
            ],
        ],
    ];
}
