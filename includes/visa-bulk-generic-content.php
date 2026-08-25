<?php
/**
 * Category-level generic content templates used to bulk-generate every
 * remaining country x visa-category combination (the ~1,600 pages not yet
 * individually researched — see includes/visa-seed-data.php for the small
 * batch of fully fact-checked flagship pages).
 *
 * These templates are genuinely differentiated PER CATEGORY (8 distinct,
 * category-accurate content sets covering purpose, typical document types,
 * eligibility criteria and FAQs that are true in general for that visa
 * purpose) and interpolated with each country's real name/region, so no two
 * pages render identical text. What they deliberately do NOT contain is any
 * country-specific fact that could be wrong: official visa/subclass names,
 * exact fees, exact processing times and the immigration authority name/URL
 * are left unset so the page template's existing honest-fallback rendering
 * ("Varies by visa subclass/profile", "Check current official requirements
 * before applying") is used instead of inventing them — consistent with the
 * anti-hallucination rule applied to the hand-researched flagship pages.
 *
 * Country-specific pages can always be upgraded later with real researched
 * facts via the admin content editor (or a future visa-seed-data.php entry,
 * which takes precedence since it seeds first and this seeder skips any
 * page_slug that already exists).
 */
function visa_bulk_category_templates(): array
{
    return [
        'tourist-visa' => [
            'intro' => 'A %CATEGORY% for %COUNTRY% covers holiday, sightseeing and short leisure visits. Requirements, application steps and documents vary by destination and are set by %COUNTRY%\'s immigration authority — the information below is general guidance for Indian travellers planning a tourist trip to %COUNTRY%.',
            'eligibility' => '<p>Tourist visa eligibility generally depends on being able to show:</p>
<ul>
<li>A genuine intention to travel for tourism, sightseeing or leisure</li>
<li>Sufficient funds to support the trip</li>
<li>An intention to return to India at the end of the visit</li>
<li>A valid passport and, where required, supporting travel documents</li>
<li>No health or character concerns that would affect admissibility</li>
</ul>
<p>This is general guidance &mdash; exact criteria are set by %COUNTRY%&rsquo;s immigration authority and every application is individually assessed.</p>',
            'indian_applicant' => '<p>Indian citizens planning tourist travel to %COUNTRY% should check the current application method (online or through a visa application centre), prepare standard supporting documents, and allow sufficient time before travel for processing. Commonly requested evidence includes financial proof, a travel itinerary, and evidence of ties to India. Our consultants can confirm the current process for %COUNTRY% and help you prepare a complete application.</p>',
            'documents' => [
                ['Basic Documents', "Valid passport (with sufficient validity beyond the intended stay)"],
                ['Basic Documents', 'Recent passport-style photograph'],
                ['Basic Documents', 'Completed visa application form'],
                ['Financial Documents', 'Bank statements (typically last 3-6 months)'],
                ['Financial Documents', 'Income tax returns (ITR), where applicable'],
                ['Financial Documents', 'Salary slips or business/self-employment financial documents'],
                ['Travel Documents', 'Tentative travel itinerary'],
                ['Travel Documents', 'Hotel booking or accommodation details'],
                ['Travel Documents', 'Return or onward flight reservation'],
                ['Supporting Documents', 'Employer leave-approval letter, if employed'],
                ['Supporting Documents', 'Evidence of ties to India (property, family, employment/business)'],
                ['Supporting Documents', 'Travel insurance, where required or recommended'],
            ],
            'faqs' => [
                ['Do Indian citizens need a visa to visit %COUNTRY%?', 'Most destinations require Indian passport holders to obtain a visa before tourist travel. Check %COUNTRY%&rsquo;s current visa policy for Indian citizens, as requirements and any visa-free or visa-on-arrival arrangements can change.'],
                ['How do I apply for a %COUNTRY% Tourist Visa from India?', 'Application methods vary by destination — commonly online, through a visa application centre, or at the relevant embassy/consulate. Confirm the current method for %COUNTRY% before starting your application.'],
                ['What documents are required for a %COUNTRY% Tourist Visa?', 'Typically a valid passport, photograph, financial evidence, travel itinerary and supporting documents showing genuine tourism intent and ties to India — see the Documents section above for the general checklist.'],
                ['How long does processing take?', 'Processing times vary by destination, application volume and season. Check the relevant immigration authority&rsquo;s current published processing times before finalising travel dates.'],
                ['How much does a %COUNTRY% Tourist Visa cost?', 'Government visa fees are set by %COUNTRY%&rsquo;s immigration authority and can change — verify the current fee before applying. VisaAgency&rsquo;s service fee is charged separately from any government fee.'],
                ['Can I work in %COUNTRY% on a tourist visa?', 'Generally no. Tourist visas are intended for leisure travel and do not usually permit employment; check %COUNTRY%&rsquo;s specific visa conditions for confirmation.'],
                ['Can I extend a %COUNTRY% Tourist Visa?', 'Extension policies vary by country and are not guaranteed. See our Visa Extension information for %COUNTRY%, or contact us to check current rules.'],
                ['What happens if my tourist visa is refused?', 'If refused, the immigration authority will generally state a reason. Depending on the circumstances you may be able to reapply and address the concerns raised — visa approval is solely at the authority&rsquo;s discretion.'],
            ],
        ],

        'business-visa' => [
            'intro' => 'A %CATEGORY% for %COUNTRY% covers business meetings, conferences, negotiations and corporate visits — not local employment. It is a distinct category from a Tourist or Work visa. Requirements are set by %COUNTRY%\'s immigration authority; the information below is general guidance for Indian business travellers visiting %COUNTRY%.',
            'eligibility' => '<p>Business visa eligibility generally depends on being able to show:</p>
<ul>
<li>A genuine business purpose &mdash; meetings, conferences, negotiations or similar corporate activity, not local employment</li>
<li>An invitation or supporting documentation from the host company or event in %COUNTRY%, where required</li>
<li>Sufficient funds to support the trip, typically evidenced through the applicant&rsquo;s employer or business</li>
<li>An intention to return to India at the end of the visit</li>
<li>A valid passport and supporting business/employment documentation</li>
</ul>
<p>This is general guidance &mdash; exact criteria are set by %COUNTRY%&rsquo;s immigration authority and every application is individually assessed.</p>',
            'indian_applicant' => '<p>Indian professionals travelling to %COUNTRY% for business should confirm the current application method, gather company and invitation documentation, and clarify whether their specific activity qualifies as a business visit rather than requiring a work visa. Our consultants can help confirm the correct category and prepare the supporting documentation for %COUNTRY%.</p>',
            'documents' => [
                ['Basic Documents', "Valid passport (with sufficient validity beyond the intended stay)"],
                ['Basic Documents', 'Recent passport-style photograph'],
                ['Basic Documents', 'Completed visa application form'],
                ['Financial Documents', 'Bank statements (typically last 3-6 months)'],
                ['Financial Documents', 'Income tax returns (ITR), where applicable'],
                ['Financial Documents', 'Company financial documents, where self-employed or business owner'],
                ['Travel Documents', 'Business travel itinerary'],
                ['Travel Documents', 'Hotel booking or accommodation details'],
                ['Supporting Documents', 'Invitation letter from the host company or event organiser in %COUNTRY%'],
                ['Supporting Documents', 'Employer authorisation / letter confirming purpose of visit'],
                ['Supporting Documents', 'Company registration or business proof, where self-employed'],
                ['Supporting Documents', 'Conference/event registration, where applicable'],
            ],
            'faqs' => [
                ['Do Indian citizens need a business visa to visit %COUNTRY%?', 'Most destinations require a specific business visa (or business-eligible visitor visa) for Indian citizens travelling for meetings, conferences or corporate visits — check %COUNTRY%&rsquo;s current requirements.'],
                ['What is the difference between a Business Visa and a Work Visa for %COUNTRY%?', 'A Business Visa generally covers short-term activities like meetings, negotiations and conferences without taking up local employment; working or being paid locally usually requires a separate work visa/permit.'],
                ['Do I need an invitation letter for a %COUNTRY% Business Visa?', 'Many destinations require an invitation letter or supporting documentation from the host company or event organiser — confirm current requirements for %COUNTRY%.'],
                ['How long does processing take?', 'Processing times vary by destination, application volume and season. Check the relevant immigration authority&rsquo;s current published processing times before finalising travel dates.'],
                ['How much does a %COUNTRY% Business Visa cost?', 'Government visa fees are set by %COUNTRY%&rsquo;s immigration authority and can change — verify the current fee before applying. VisaAgency&rsquo;s service fee is charged separately.'],
                ['Can a Business Visa be multiple entry?', 'Some destinations issue multiple-entry business visas for frequent travellers; this depends on %COUNTRY%&rsquo;s specific policy and the applicant&rsquo;s profile.'],
                ['Can I extend a %COUNTRY% Business Visa?', 'Extension policies vary by country and are not guaranteed. Contact us to check current rules for %COUNTRY%.'],
                ['What happens if my business visa is refused?', 'If refused, the immigration authority will generally state a reason. Depending on the circumstances you may be able to reapply and address the concerns raised — visa approval is solely at the authority&rsquo;s discretion.'],
            ],
        ],

        'family-visa' => [
            'intro' => 'A %CATEGORY% for %COUNTRY% covers travel to visit relatives, or family-sponsored travel, and is generally assessed based on the relationship to the person being visited and their status in %COUNTRY%. The information below is general guidance for Indian citizens visiting family in %COUNTRY%.',
            'eligibility' => '<p>Family visa eligibility generally depends on being able to show:</p>
<ul>
<li>A genuine family relationship to the sponsor/host in %COUNTRY% (e.g. spouse, parent, child, sibling), supported by documentary proof</li>
<li>The sponsor&rsquo;s legal status in %COUNTRY% (citizen, permanent resident or valid visa holder, as required)</li>
<li>Sufficient funds to support the visit, from the applicant or the sponsoring family member</li>
<li>An intention to return to India at the end of the visit, where the visa is a temporary visit rather than a family-migration category</li>
<li>A valid passport and supporting relationship documentation</li>
</ul>
<p>This is general guidance &mdash; exact criteria are set by %COUNTRY%&rsquo;s immigration authority and every application is individually assessed.</p>',
            'indian_applicant' => '<p>Indian citizens visiting family in %COUNTRY% should confirm the current application method and gather relationship-proof documents (such as birth or marriage certificates) along with evidence of the sponsor&rsquo;s status in %COUNTRY%. Some destinations offer specific long-stay family/parent visit categories in addition to a standard visitor visa. Our consultants can help confirm which category fits your situation for %COUNTRY%.</p>',
            'documents' => [
                ['Basic Documents', "Valid passport (with sufficient validity beyond the intended stay)"],
                ['Basic Documents', 'Recent passport-style photograph'],
                ['Basic Documents', 'Completed visa application form'],
                ['Financial Documents', 'Bank statements (applicant and/or sponsor, as required)'],
                ['Financial Documents', 'Evidence of sponsor&rsquo;s income/financial capacity, where the sponsor is funding the visit'],
                ['Travel Documents', 'Travel itinerary'],
                ['Travel Documents', 'Return or onward flight reservation'],
                ['Supporting Documents', 'Proof of relationship (birth certificate, marriage certificate, or equivalent)'],
                ['Supporting Documents', 'Proof of sponsor&rsquo;s status in %COUNTRY% (citizenship, residency or visa copy)'],
                ['Supporting Documents', 'Invitation letter from the family member in %COUNTRY%'],
                ['Supporting Documents', 'Evidence of ties to India (property, employment/business)'],
            ],
            'faqs' => [
                ['Do I need a family visa to visit relatives in %COUNTRY%?', 'Depending on the destination and length of stay, visiting family may fall under a standard tourist/visitor visa or a specific family-visit category — check %COUNTRY%&rsquo;s current rules.'],
                ['What proof of relationship is required?', 'Typically a birth certificate, marriage certificate, or other official document establishing the relationship to the sponsor, alongside proof of the sponsor&rsquo;s status in %COUNTRY%.'],
                ['Does my sponsor need to provide documents?', 'Often yes — proof of the sponsor&rsquo;s citizenship/residency status and, in many cases, an invitation letter or financial support letter.'],
                ['How long does processing take?', 'Processing times vary by destination, application volume and season. Check the relevant immigration authority&rsquo;s current published processing times before finalising travel dates.'],
                ['How much does a %COUNTRY% Family Visa cost?', 'Government visa fees are set by %COUNTRY%&rsquo;s immigration authority and can change — verify the current fee before applying. VisaAgency&rsquo;s service fee is charged separately.'],
                ['Is there a long-stay option for visiting parents or grandparents?', 'Some countries offer extended-stay family/parent visit categories separate from a standard visitor visa — ask our consultants whether %COUNTRY% offers this.'],
                ['Can I extend a %COUNTRY% Family Visa?', 'Extension policies vary by country and are not guaranteed. Contact us to check current rules for %COUNTRY%.'],
                ['What happens if my family visa is refused?', 'If refused, the immigration authority will generally state a reason. Depending on the circumstances you may be able to reapply and address the concerns raised — visa approval is solely at the authority&rsquo;s discretion.'],
            ],
        ],

        'transit-visa' => [
            'intro' => 'A %CATEGORY% for %COUNTRY% applies to travellers connecting through %COUNTRY% en route to a final destination. Whether a transit visa is required at all depends on nationality, the airport/border used, whether you leave the transit area, and layover duration — the information below is general guidance for Indian travellers transiting through %COUNTRY%.',
            'eligibility' => '<p>Transit visa eligibility (where one is required) generally depends on being able to show:</p>
<ul>
<li>Confirmed onward travel with a valid ticket to a final destination</li>
<li>A valid visa for the final destination, where that destination requires one</li>
<li>A layover consistent with a genuine transit purpose (not an extended stay)</li>
<li>A valid passport with sufficient remaining validity</li>
</ul>
<p>This is general guidance &mdash; many countries do not require a transit visa for airside connections within a short window, while others do; exact rules are set by %COUNTRY%&rsquo;s immigration authority and every application/entry is individually assessed.</p>',
            'indian_applicant' => '<p>Indian citizens transiting through %COUNTRY% should confirm well in advance whether a transit visa is required for their specific routing and layover length &mdash; this varies significantly by airport and airline routing, and by whether you need to clear immigration and re-check in. Our consultants can check current transit requirements for your specific %COUNTRY% connection.</p>',
            'documents' => [
                ['Basic Documents', "Valid passport (with sufficient validity beyond the transit date)"],
                ['Basic Documents', 'Recent passport-style photograph'],
                ['Basic Documents', 'Completed visa application form, if a transit visa is required'],
                ['Travel Documents', 'Onward flight ticket/reservation to the final destination'],
                ['Travel Documents', 'Valid visa for the final destination, where required'],
                ['Supporting Documents', 'Proof of the return/onward journey beyond %COUNTRY%'],
                ['Supporting Documents', 'Evidence of purpose of travel to the final destination, if requested'],
            ],
            'faqs' => [
                ['Do I need a transit visa to connect through %COUNTRY%?', 'This depends on nationality, the specific airport, whether you leave the transit area, and layover length — check %COUNTRY%&rsquo;s current transit visa policy for Indian passport holders before booking.'],
                ['How long can I stay in %COUNTRY% on a transit visa?', 'Transit visas are generally issued for a short period matching the layover, not for extended stays — the exact permitted duration is set by %COUNTRY%&rsquo;s immigration authority.'],
                ['Do I need a transit visa if I stay airside and do not clear immigration?', 'Many airports allow airside transit without a visa if you remain in the international transit area and your layover is short, but this varies by airport and airline — verify for your specific routing.'],
                ['Do I need a visa for my final destination before transiting %COUNTRY%?', 'Often yes, particularly if you must clear immigration in %COUNTRY% or check in separately for your next flight — confirm the requirements for both legs of your journey.'],
                ['How much does a %COUNTRY% Transit Visa cost?', 'Government visa fees, where applicable, are set by %COUNTRY%&rsquo;s immigration authority and can change — verify the current fee before applying.'],
                ['Can I leave the airport during a transit stop in %COUNTRY%?', 'This depends on %COUNTRY%&rsquo;s specific transit visa rules — some permit leaving the airport with a valid transit visa, others restrict travellers to the transit area.'],
                ['What happens if my transit visa is refused?', 'If refused, the immigration authority will generally state a reason. Depending on the circumstances you may need to re-route your journey — visa approval is solely at the authority&rsquo;s discretion.'],
            ],
        ],

        'sports-visa' => [
            'intro' => 'A %CATEGORY% for %COUNTRY% is for athletes, coaches, officials and sporting delegations travelling to participate in a recognised sporting event in %COUNTRY%. It is typically linked to a specific event, invitation or accreditation. The information below is general guidance for Indian sportspersons and delegations travelling to %COUNTRY%.',
            'eligibility' => '<p>Sports visa eligibility generally depends on being able to show:</p>
<ul>
<li>Participation in a recognised sporting event, tournament or training programme in %COUNTRY%</li>
<li>An invitation or accreditation from the event organiser or the relevant sports federation</li>
<li>Sufficient funds to support the visit, or sponsorship/team funding documentation</li>
<li>Any required no-objection certificate from the applicant&rsquo;s sports federation or governing body in India, where applicable</li>
<li>A valid passport and supporting event documentation</li>
</ul>
<p>This is general guidance &mdash; exact criteria are set by %COUNTRY%&rsquo;s immigration authority and every application is individually assessed.</p>',
            'indian_applicant' => '<p>Indian athletes, coaches, officials and delegations travelling to %COUNTRY% should obtain formal invitation/accreditation documentation from the event organiser well in advance, and confirm whether a No-Objection Certificate from their national sports federation is required. Our consultants can help coordinate documentation for individual athletes as well as team/delegation applications for %COUNTRY%.</p>',
            'documents' => [
                ['Basic Documents', "Valid passport (with sufficient validity beyond the intended stay)"],
                ['Basic Documents', 'Recent passport-style photograph'],
                ['Basic Documents', 'Completed visa application form'],
                ['Financial Documents', 'Bank statements or sponsorship/team funding documentation'],
                ['Travel Documents', 'Travel itinerary aligned with the event schedule'],
                ['Travel Documents', 'Accommodation details for the duration of the event'],
                ['Supporting Documents', 'Invitation or accreditation letter from the event organiser/federation in %COUNTRY%'],
                ['Supporting Documents', 'No-Objection Certificate from the applicant&rsquo;s sports federation in India, where applicable'],
                ['Supporting Documents', 'Team list or delegation details, for group applications'],
            ],
            'faqs' => [
                ['Do Indian athletes need a special visa to compete in %COUNTRY%?', 'Most destinations expect athletes, coaches and officials to apply under a sports-specific visa category or an event-linked visitor visa — check %COUNTRY%&rsquo;s current requirements.'],
                ['Do I need a letter from the event organiser?', 'Yes, typically an invitation or accreditation letter from the event organiser or relevant sports federation is required as core supporting evidence.'],
                ['Is a No-Objection Certificate required from my Indian sports federation?', 'This depends on the sport and event — many federations require athletes to obtain an NOC before international travel; check with your federation and event organiser.'],
                ['Can a whole team apply together for a %COUNTRY% Sports Visa?', 'Many destinations accept group/delegation applications for teams travelling to the same event — confirm the process for %COUNTRY% with the event organiser or our consultants.'],
                ['How long does processing take?', 'Processing times vary by destination and event timeline — apply well in advance of the event given fixed competition dates.'],
                ['How much does a %COUNTRY% Sports Visa cost?', 'Government visa fees are set by %COUNTRY%&rsquo;s immigration authority and can change — verify the current fee before applying.'],
                ['How long is a Sports Visa valid for?', 'Validity is generally linked to the duration of the specific event or tournament, as reflected on the visa grant.'],
                ['What happens if my sports visa is refused?', 'If refused, the immigration authority will generally state a reason. Depending on the circumstances and event timeline, reapplication may not be possible before the event — apply as early as possible.'],
            ],
        ],

        'medical-visa' => [
            'intro' => 'A %CATEGORY% for %COUNTRY% is for patients travelling for medical treatment or consultation, and often for one accompanying attendant. It is generally linked to a confirmed hospital appointment or treatment plan in %COUNTRY%. The information below is general guidance for Indian patients seeking treatment in %COUNTRY%.',
            'eligibility' => '<p>Medical visa eligibility generally depends on being able to show:</p>
<ul>
<li>A confirmed appointment, referral or treatment plan with a recognised hospital or medical facility in %COUNTRY%</li>
<li>Sufficient funds to cover treatment and stay costs, or proof of payment/insurance arrangements</li>
<li>An intention to return to India once treatment is complete, for a temporary medical visit</li>
<li>Where an attendant is accompanying the patient, proof of relationship and the same financial/travel documentation</li>
<li>A valid passport and medical documentation</li>
</ul>
<p>This is general guidance &mdash; exact criteria are set by %COUNTRY%&rsquo;s immigration authority and every application is individually assessed.</p>',
            'indian_applicant' => '<p>Indian patients travelling to %COUNTRY% for treatment should obtain a formal appointment or admission letter from the treating hospital before applying, and confirm whether an attendant visa is available if a family member needs to accompany them. Our consultants can help coordinate hospital documentation and the visa application together for %COUNTRY%.</p>',
            'documents' => [
                ['Basic Documents', "Valid passport (with sufficient validity beyond the intended stay)"],
                ['Basic Documents', 'Recent passport-style photograph'],
                ['Basic Documents', 'Completed visa application form'],
                ['Financial Documents', 'Bank statements or proof of funds to cover treatment and stay'],
                ['Financial Documents', 'Treatment cost estimate or payment/insurance confirmation from the hospital'],
                ['Travel Documents', 'Travel itinerary aligned with the treatment schedule'],
                ['Supporting Documents', 'Medical appointment, admission or referral letter from the treating hospital in %COUNTRY%'],
                ['Supporting Documents', 'Relevant medical reports/records supporting the referral'],
                ['Supporting Documents', 'Attendant visa documentation and proof of relationship, if an attendant is accompanying the patient'],
            ],
            'faqs' => [
                ['Do I need a medical visa to receive treatment in %COUNTRY%?', 'Most destinations expect patients travelling specifically for treatment to apply under a medical visa category rather than a tourist visa — check %COUNTRY%&rsquo;s current requirements.'],
                ['What documents does the hospital need to provide?', 'Typically an appointment, admission or referral letter confirming the treatment plan, which forms the core supporting document for the visa application.'],
                ['Can a family member accompany me as an attendant?', 'Many destinations allow one accompanying attendant under a linked visa category, generally requiring proof of relationship — confirm %COUNTRY%&rsquo;s specific attendant visa rules.'],
                ['How long does processing take?', 'Processing times vary by destination and can sometimes be expedited for urgent medical cases — check with the relevant immigration authority or embassy.'],
                ['How much does a %COUNTRY% Medical Visa cost?', 'Government visa fees are set by %COUNTRY%&rsquo;s immigration authority and can change — verify the current fee before applying.'],
                ['Can a medical visa be extended if treatment takes longer than planned?', 'Some destinations allow extensions with updated medical documentation from the treating hospital — this is not guaranteed and depends on %COUNTRY%&rsquo;s specific rules.'],
                ['How long is a Medical Visa valid for?', 'Validity is generally linked to the expected duration of treatment, as supported by the hospital&rsquo;s documentation.'],
                ['What happens if my medical visa is refused?', 'If refused, the immigration authority will generally state a reason. Depending on the circumstances you may be able to reapply and address the concerns raised.'],
            ],
        ],

        'crew-visa' => [
            'intro' => 'A %CATEGORY% for %COUNTRY% is for airline and maritime crew members entering or transiting %COUNTRY% in connection with their employment. Requirements are generally linked to the crew member&rsquo;s employer and vessel/aircraft documentation. The information below is general guidance for Indian crew members travelling in connection with %COUNTRY%.',
            'eligibility' => '<p>Crew visa eligibility generally depends on being able to show:</p>
<ul>
<li>Current employment as crew with an airline or shipping/maritime company, evidenced by an employer letter or contract</li>
<li>A valid seaman&rsquo;s book, crew ID, or equivalent professional credential, where applicable</li>
<li>Confirmed joining/sign-off details, vessel or flight information</li>
<li>A valid passport with sufficient remaining validity</li>
</ul>
<p>This is general guidance &mdash; exact criteria are set by %COUNTRY%&rsquo;s immigration authority and every application/entry is individually assessed.</p>',
            'indian_applicant' => '<p>Indian crew members travelling in connection with %COUNTRY% should ensure their employer provides current employment and joining documentation, and that seaman&rsquo;s book/crew credentials are valid and up to date. Our consultants can assist with crew visa applications coordinated with the employer&rsquo;s documentation for %COUNTRY%.</p>',
            'documents' => [
                ['Basic Documents', "Valid passport (with sufficient validity beyond the intended stay)"],
                ['Basic Documents', 'Recent passport-style photograph'],
                ['Basic Documents', 'Completed visa application form'],
                ['Travel Documents', 'Confirmed joining/sign-off itinerary'],
                ['Supporting Documents', 'Employer letter confirming crew employment and assignment'],
                ['Supporting Documents', 'Seaman&rsquo;s book, pilot licence or equivalent crew credential, as applicable'],
                ['Supporting Documents', 'Employment contract with the airline or shipping company'],
                ['Supporting Documents', 'Vessel or flight details relevant to the crew assignment'],
            ],
            'faqs' => [
                ['Do Indian crew members need a special visa for %COUNTRY%?', 'Most destinations have a specific crew visa or crew-member entry category, distinct from standard tourist/business visas — check %COUNTRY%&rsquo;s current requirements.'],
                ['What documents does my employer need to provide?', 'Typically an employer letter confirming crew status and assignment, along with employment contract details and joining/sign-off information.'],
                ['Is a crew visa the same as a work visa?', 'No — crew visas are generally a distinct, employment-linked category for airline/maritime crew, separate from general work visas, though rules vary by country.'],
                ['How long is a crew visa valid for?', 'Validity is generally linked to the crew member&rsquo;s assignment/employment period, as reflected in the supporting employer documentation.'],
                ['How much does a %COUNTRY% Crew Visa cost?', 'Government visa fees are set by %COUNTRY%&rsquo;s immigration authority and can change — verify the current fee before applying.'],
                ['Do I need a crew visa for a short stopover as crew?', 'This depends on %COUNTRY%&rsquo;s specific policy for crew members in transit — check current requirements based on your airline/shipping company&rsquo;s guidance.'],
                ['How do I apply for a %COUNTRY% Crew Visa from India?', 'Applications are usually coordinated with the employer&rsquo;s documentation — check the current application method for %COUNTRY% before travel.'],
                ['What happens if my crew visa is refused?', 'If refused, the immigration authority will generally state a reason. Employers typically assist crew members in resolving documentation issues and reapplying.'],
            ],
        ],

        'visa-extension' => [
            'intro' => 'A %CATEGORY% for %COUNTRY% covers extending an existing, currently valid visa where %COUNTRY%\'s immigration rules permit it. Not all countries or visa categories allow extensions, and rules vary significantly — the information below is general guidance for Indian travellers already in, or already holding a visa for, %COUNTRY%.',
            'eligibility' => '<p>Visa extension eligibility generally depends on being able to show:</p>
<ul>
<li>A currently valid visa for %COUNTRY% that has not yet expired</li>
<li>A genuine, documented reason for extending the stay (e.g. medical, unavoidable travel disruption, ongoing treatment or business need)</li>
<li>Continued compliance with the original visa conditions</li>
<li>Sufficient funds to support the extended stay</li>
<li>That %COUNTRY%&rsquo;s specific visa category is one that permits extension &mdash; some categories in some countries do not</li>
</ul>
<p>This is general guidance &mdash; exact rules are set by %COUNTRY%&rsquo;s immigration authority and every application is individually assessed. Extensions are not guaranteed and should be applied for well before the current visa expires.</p>',
            'indian_applicant' => '<p>Indian citizens seeking to extend a stay in %COUNTRY% should check current extension rules for their specific visa category as early as possible, since not all visa types are extendable and processing takes time. Applying close to or after the original visa&rsquo;s expiry can create serious complications. Our consultants can help confirm whether extension is possible for your situation in %COUNTRY% and prepare the application.</p>',
            'documents' => [
                ['Basic Documents', 'Valid passport'],
                ['Basic Documents', 'Copy of the current, unexpired visa for %COUNTRY%'],
                ['Basic Documents', 'Completed extension application form'],
                ['Financial Documents', 'Bank statements or proof of funds to support the extended stay'],
                ['Supporting Documents', 'Letter explaining the reason for the extension request'],
                ['Supporting Documents', 'Supporting evidence for the reason given (e.g. medical letter, revised travel itinerary, business correspondence)'],
                ['Supporting Documents', 'Proof of continued accommodation arrangements'],
            ],
            'faqs' => [
                ['Can I extend my visa while I am in %COUNTRY%?', 'This depends on %COUNTRY%&rsquo;s specific rules for the visa category you hold — not all visa types or countries permit extension. Check before your current visa expires.'],
                ['How early should I apply for a %COUNTRY% Visa Extension?', 'As early as possible, and always before the current visa expires — extension processing takes time and overstaying can create serious immigration consequences.'],
                ['What reasons are accepted for a visa extension?', 'Commonly accepted reasons include medical treatment, unavoidable travel disruption, or a genuine ongoing need — acceptable reasons vary by destination and are assessed individually.'],
                ['Is a visa extension guaranteed?', 'No. Extension is discretionary and depends on %COUNTRY%&rsquo;s specific rules, the visa category held, and the reason provided — it is never guaranteed.'],
                ['How much does a %COUNTRY% Visa Extension cost?', 'Government fees for extension, where available, are set by %COUNTRY%&rsquo;s immigration authority and can change — verify the current fee before applying.'],
                ['What happens if my visa expires before I extend it?', 'Overstaying a visa can lead to penalties, bans on future entry, or other immigration consequences depending on %COUNTRY%&rsquo;s rules — always apply before expiry, not after.'],
                ['Can I extend a tourist visa indefinitely?', 'No. Extensions are generally limited in duration and number, and are not intended as a substitute for a longer-stay visa category.'],
                ['What happens if my extension request is refused?', 'If refused, you would generally need to depart %COUNTRY% before your current visa expires. The immigration authority will typically state the reason for refusal.'],
            ],
        ],
    ];
}
