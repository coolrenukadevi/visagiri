-- Real, researched Singapore visa content — the first country to use
-- the country_content/visa_requirements rich-content fields added in
-- schema-country-content.sql. Facts here are grounded in Singapore's
-- Immigration & Checkpoints Authority (ICA) framework and Ministry of
-- Manpower (MOM) work-pass framework as publicly described by ICA/MOM
-- and corroborated across multiple independent visa-agency sources in
-- September 2026 (ICA's own site could not be fetched directly from
-- this environment — see AUDIT.md). Time-sensitive figures (fees,
-- processing times) are deliberately NOT hardcoded as fixed facts:
-- government_fee/service_fee are left NULL and explained in fee_notes
-- instead, since no primary-source figure could be directly verified.
-- last_reviewed_at marks when this content was written so it can be
-- flagged for re-review later.

-- Singapore doesn't offer a distinct "Sports Visa" category in
-- practice (sporting event travel is handled as a business/social
-- visit pass) — hide that card on the Singapore hub rather than
-- linking to a category with no real content behind it.
UPDATE country_visa_types
SET is_available = 0
WHERE country_id = 92 AND visa_type_id = 9;

-- ---------------------------------------------------------------------
-- Country hub content (/visa/singapore/)
-- ---------------------------------------------------------------------
INSERT INTO country_content
    (country_id, hero_tagline, overview, who_needs_visa, services_across_india, local_seo_patna, common_mistakes, source_url, last_reviewed_at)
VALUES (
    92,
    'Technology-driven Singapore visa consultancy for Indian travellers, students, professionals, and businesses — with dedicated support for applicants in Patna and across Bihar.',
    'Singapore is one of the most visited destinations for Indian travellers, students, and business professionals, and nearly every Indian passport holder needs an approved visa before travelling there — Singapore does not offer visa-free or visa-on-arrival entry to Indian citizens. Visagiri helps Indian applicants prepare and submit Singapore visa applications end to end: reviewing your documents against the right visa category, preparing your application through Singapore''s ICA-linked SAVE system via an authorised visa agent, and keeping you informed at every stage. We are a visa consultancy, not the Immigration & Checkpoints Authority of Singapore (ICA) or any Singapore government body — every visa decision is made solely by ICA (or, for work and dependent passes, Singapore''s Ministry of Manpower).',
    'Almost all Indian ordinary-passport holders require an approved visa or e-Pass before entering Singapore for tourism, business, study, work, or family visits — there is no general visa-free entry for Indian citizens. The one narrow exception is Singapore''s Visa Free Transit Facility (VFTF), which allows a short visa-free stopover for eligible travellers connecting through Changi Airport onward to a third country, subject to specific conditions — see our Transit Visa page for details. Outside that exception, which visa or pass you need depends on your purpose of travel: short tourism or business visits use a Visit Pass/visa issued by ICA, study uses a Student''s Pass, and employment or accompanying family on a work pass uses passes issued by the Ministry of Manpower (MOM) rather than ICA.',
    'Visagiri assists Indian applicants for Singapore visas nationwide, not only from our home base. Alongside dedicated local support for Patna and Bihar, we regularly assist applicants from Delhi, Mumbai, Kolkata, Hyderabad, Chennai, Bengaluru, Ahmedabad, Pune, Jaipur, Lucknow, Ranchi, Bhubaneswar, Guwahati, Chandigarh, Indore, Nagpur, Surat, Vadodara, Visakhapatnam, Coimbatore, and Kochi. Because document collection, review, and submission are handled digitally, you don''t need to be near a physical office — our team coordinates document scrutiny, application preparation, and submission support by WhatsApp, call, and email wherever you''re based in India.',
    'For applicants in Patna and across Bihar, Visagiri works as a Singapore visa consultant, agent, and consultancy without requiring an in-person office visit — documents can be shared digitally for review, and our consultants talk you through eligibility, required paperwork, and the SAVE application process over WhatsApp or a phone consultation. This is especially useful for Singapore tourist and business visa applicants from Patna, where the nearest Singapore visa application infrastructure is otherwise based out of larger metro cities. We don''t claim any official or embassy-authorised status in Patna specifically — our role is the same visa consultancy and application-assistance service we provide nationwide, just with attention to the practical realities (courier timelines, document formats, local bank-statement conventions) of applying from Bihar.',
    'The most common reasons Singapore visa applications face delays or refusal are avoidable with careful preparation: incomplete or mismatched financial documents, passport validity that doesn''t clearly clear the required window, missing or inconsistent supporting documents (invitation letters, accommodation proof, employment/business proof), unclear or inconsistent travel itineraries, and applying too close to the travel date to allow for a request for additional information. ICA (and, for work/dependent passes, MOM) makes the final decision on every application, and Visagiri cannot influence or guarantee that outcome — our role is to help you present a complete, well-documented application so avoidable mistakes don''t become the reason for a delay.',
    'https://www.ica.gov.sg/enter-transit-depart/entering-singapore/visa_requirements/visa-detail-page/india',
    '2026-09-10'
);

-- ---------------------------------------------------------------------
-- Tourist Visa (visa_type_id = 1)
-- ---------------------------------------------------------------------
INSERT INTO visa_requirements
    (country_id, visa_type_id, overview, who_should_apply, eligibility, documents_required, application_process, processing_time, currency, fee_notes, validity_period, stay_duration, entry_type, biometrics_required, interview_required, common_mistakes, local_notes, source_url, last_verified_at)
VALUES (
    92, 1,
    'A Singapore Tourist Visa (issued as a Visit Pass/e-visa through ICA''s SAVE system) covers leisure travel — sightseeing, holidays, and visiting Singapore as a tourist. It is the most commonly applied-for Singapore visa category for Indian travellers.',
    'Leisure travellers, first-time visitors to Singapore, and Indian nationals visiting for holidays or short personal trips should apply for a Tourist Visa. If your trip also involves business meetings, apply under the Business Visa category instead — see our Business Visa page for the distinction.',
    'A genuine tourist-intent application generally needs: a passport valid well beyond your planned stay, evidence of sufficient funds for the trip, a confirmed return or onward travel booking, and no history of overstaying or adverse immigration action in Singapore or elsewhere. ICA assesses each application individually — meeting these factors supports an application but does not guarantee approval.',
    'Passport (original, valid at least 6 months beyond intended departure from Singapore, with at least one blank page)\nRecent passport-size photograph meeting Singapore visa photo specifications\nConfirmed return or onward flight tickets\nProof of accommodation in Singapore (hotel booking or, if staying with a host, an invitation letter from the host)\nBank statement for the last 3-6 months showing sufficient funds for the trip\nProof of employment (ID card/appointment letter) or business registration proof for self-employed applicants\nCompleted SAVE/ICA visa application form\nCover letter and travel itinerary',
    '1. Initial consultation with a Visagiri visa consultant to confirm this is the right visa category for your trip\n2. Visa category selection and confirmation of documents you''ll need\n3. Document assessment — we review what you have and flag gaps before submission\n4. Application preparation — form filling and document formatting\n5. Document verification against ICA''s current checklist\n6. Submission through an ICA-authorised Singapore visa agent via the SAVE system\n7. Support responding to any additional-information request ICA raises\n8. Decision — your e-visa is issued as an electronic PDF once approved\n9. Travel preparation — including Singapore''s free SG Arrival Card, submitted online within 3 days of departure',
    'Commonly quoted at around 3-5 working days by Singapore visa agents once a complete application is submitted, though ICA does not publish a guaranteed turnaround — apply well ahead of your travel date, especially during peak travel seasons.',
    'INR',
    'The Singapore government visa fee and any third-party agent charges shown by other providers can change without notice — Visagiri does not set ICA''s government fee. Get a current, itemised quote (government fee plus our service fee) from our team before you apply; we will never bill you without first confirming the total in writing.',
    'Typically usable within a set window from the date of issue (commonly around two months) — the exact validity is shown on your issued e-visa.',
    'Commonly up to 30 days per entry for short tourist visits, though the exact permitted stay is set by the ICA officer at entry, not guaranteed in advance.',
    'Single or multiple entry, depending on what is approved.',
    0, 0,
    'The most avoidable mistakes we see: bank statements that don''t clearly show the applicant''s own name and sufficient balance, missing or unclear proof of return travel, an accommodation booking that doesn''t match the trip dates on the application, and submitting an application too close to the travel date to leave room for ICA to request more information.',
    'Applicants from Patna, Bihar, and across India can complete document review and submission entirely online with our team — no need to travel to a metro city for a Tourist Visa application.',
    'https://www.ica.gov.sg/enter-transit-depart/entering-singapore/visa_requirements/visa-detail-page/india',
    '2026-09-10'
);

-- ---------------------------------------------------------------------
-- Business Visa (visa_type_id = 2)
-- ---------------------------------------------------------------------
INSERT INTO visa_requirements
    (country_id, visa_type_id, overview, who_should_apply, eligibility, documents_required, application_process, processing_time, currency, fee_notes, validity_period, stay_duration, entry_type, biometrics_required, interview_required, common_mistakes, local_notes, source_url, last_verified_at)
VALUES (
    92, 2,
    'A Singapore Business Visa covers short commercial visits — meetings, negotiations, trade fairs, and similar business activity permitted on a visit basis. It is issued under the same ICA Visit Pass framework as the Tourist Visa, but with business-specific supporting documents, and does not by itself authorise employment or being paid by a Singapore entity — that requires a work pass from Singapore''s Ministry of Manpower (see our Employment/Work Visa page).',
    'Company employees, directors, and consultants travelling to Singapore for meetings, contract discussions, trade fairs, exhibitions, or client visits should apply under this category. Applicants intending to actually work for or be paid by a Singapore employer should look at the Employment/Work Visa page instead, since that is a materially different pass issued by a different authority.',
    'A credible business-visit application generally needs a genuine, documented business purpose (an invitation from the Singapore host company, or clear evidence of the trade event/meeting), your employer''s or own company''s supporting letter, sufficient funds for the trip, and a confirmed return itinerary. Longer or more frequent business travellers may be considered for a multiple-entry visa where the pattern of travel supports it.',
    'Passport (original, valid at least 6 months beyond intended departure, with a blank page)\nRecent passport-size photograph\nInvitation letter from the Singapore host company (on letterhead, stating purpose, dates, and contact details) or trade-event/conference registration confirmation\nCovering letter from your employer in India confirming your role, purpose of travel, and that your salary/expenses continue during the trip\nCompany registration proof (for self-employed or business-owner applicants)\nConfirmed return or onward flight tickets\nBank statement for the last 3-6 months\nCompleted SAVE/ICA visa application form',
    '1. Initial consultation to confirm your trip is a genuine business visit and identify the right supporting documents\n2. Visa category selection and confirmation you don''t need a work pass instead\n3. Document assessment against ICA''s business-visit checklist\n4. Application preparation, including formatting the invitation and covering letters\n5. Document verification\n6. Submission through an ICA-authorised Singapore visa agent\n7. Support responding to any additional-information request\n8. Decision — e-visa issued as a PDF once approved\n9. Travel preparation, including the SG Arrival Card',
    'Commonly quoted at around 3-5 working days for a complete application, though ICA does not guarantee a fixed timeline — corporate travellers on tight schedules should apply as early as possible.',
    'INR',
    'Government visa fees can change without notice. Ask our team for a current, written quote covering both the ICA government fee and Visagiri''s service fee before you commit.',
    'Typically usable within a set window from issue (commonly around two months) — check your issued e-visa for the exact date.',
    'Commonly up to 30 days per entry for standard business visits; frequent business travellers with a strong travel history may be considered for longer multiple-entry validity, at ICA''s discretion.',
    'Single or multiple entry, depending on what is approved.',
    0, 0,
    'Common issues we help avoid: an invitation letter that doesn''t match the applicant''s actual job role, a business purpose that reads more like tourism without supporting documentation, and applying under a Business Visa for what is actually paid employment in Singapore — which needs a Ministry of Manpower work pass instead, not a visit-pass business visa.',
    'We support corporate travel desks and individual business travellers from Patna and Bihar the same way we support applicants anywhere in India — document coordination and submission support entirely online, so your travel desk doesn''t need a Singapore-visa specialist on staff.',
    'https://www.ica.gov.sg/enter-transit-depart/entering-singapore/visa_requirements/visa-detail-page/india',
    '2026-09-10'
);

-- ---------------------------------------------------------------------
-- Student Visa (visa_type_id = 3) — Singapore's Student's Pass, via SOLAR
-- ---------------------------------------------------------------------
INSERT INTO visa_requirements
    (country_id, visa_type_id, overview, who_should_apply, eligibility, documents_required, application_process, processing_time, currency, fee_notes, validity_period, stay_duration, entry_type, biometrics_required, interview_required, common_mistakes, local_notes, source_url, last_verified_at)
VALUES (
    92, 3,
    'Studying in Singapore requires a Student''s Pass issued by ICA, applied for through ICA''s SOLAR system — and unlike a tourist or business visa, the application is initiated by your Singapore institution of higher learning (IHL) on your behalf, not filed independently by the student. Visagiri helps you prepare everything your institution needs and guides you through what happens after approval.',
    'Indian students admitted to a Singapore school, polytechnic, or university (an IHL registered to sponsor Student''s Pass applications) should use this pathway. If you''re travelling to Singapore only to attend a short course, workshop, or exchange programme without a formal Student''s Pass requirement, check with your institution and Visagiri whether a Visit Pass is more appropriate instead.',
    'You must hold a genuine offer of admission from a Singapore institution registered with ICA''s SOLAR system, be able to show the institution and (where relevant) yourself can support the required processing steps, and meet whatever additional conditions your specific institution or course sets. The final Student''s Pass decision rests with ICA, not with Visagiri or your institution.',
    'Offer/admission letter from your Singapore institution\nCompleted eForm16 (submitted via SOLAR by your institution)\nPassport (valid well beyond your course duration)\nRecent passport-size photograph\nAcademic transcripts and certificates from your previous education\nProof of funds/financial support for tuition and living costs\nMedical examination report (required after arrival, before the pass is issued, for most students)\nIn-Principle Approval (IPA) letter once issued — required for travel to Singapore',
    '1. Initial consultation once you have (or are close to receiving) your Singapore institution offer\n2. Confirming your institution will initiate the SOLAR application on your behalf\n3. Document assessment — gathering academic and financial documents your institution''s SOLAR submission needs\n4. Application preparation — completing eForm16 details and supporting paperwork\n5. Document verification before your institution submits\n6. Submission support while your institution files via SOLAR\n7. Support through ICA''s processing, including any additional-document requests\n8. In-Principle Approval (IPA) — travel to Singapore is only possible once this is issued\n9. Travel preparation and guidance on the in-Singapore steps (medical check and Student''s Pass issuance at ICA) after arrival',
    'ICA''s own guidance suggests allowing several weeks for SOLAR processing once your institution submits — apply as early as your institution allows, and never later than your institution''s own SOLAR deadline, since late applications risk missing your intake.',
    'INR',
    'SOLAR processing carries its own ICA/institution fees separate from Visagiri''s consultancy fee — we''ll confirm both clearly before you proceed. Government-set fees can change; always confirm the current figure with your institution or ICA.',
    'Tied to your course duration and IPA terms — confirm with your institution.',
    'Matches your enrolled course duration, subject to your Student''s Pass remaining valid and in good standing.',
    'Multiple entry for the duration of a valid Student''s Pass.',
    1, 0,
    'The most common avoidable issue is timing — starting the process too close to your institution''s SOLAR deadline. Other frequent gaps: incomplete financial-support documentation, and travelling to Singapore before your In-Principle Approval letter is actually issued, which is not permitted.',
    'We support Indian students from Patna, Bihar, and across the country the same way — coordinating with your Singapore institution and helping you assemble the right documents on your timeline, wherever you''re currently based.',
    'https://www.ica.gov.sg/enter-transit-depart/entering-singapore/visa_requirements/visa-detail-page/india',
    '2026-09-10'
);

-- ---------------------------------------------------------------------
-- Family Visit Visa (visa_type_id = 5)
-- ---------------------------------------------------------------------
INSERT INTO visa_requirements
    (country_id, visa_type_id, overview, who_should_apply, eligibility, documents_required, application_process, processing_time, currency, fee_notes, validity_period, stay_duration, entry_type, biometrics_required, interview_required, common_mistakes, local_notes, source_url, last_verified_at)
VALUES (
    92, 5,
    'A Family Visit Visa covers short visits to family members already living in or based in Singapore — this is a short-stay Visit Pass, and is a different category from the long-term Dependent''s Pass that lets immediate family of certain work-pass holders actually reside in Singapore (see our Dependent Visa page for that longer-term category).',
    'Indian nationals visiting family, relatives, or a partner who is living in Singapore (as a citizen, permanent resident, or long-term pass holder) for a short trip should apply here. If you intend to live in Singapore long-term alongside a family member holding a Singapore work pass, the Dependent''s Pass pathway is the relevant one instead, not this short-visit category.',
    'A credible family-visit application generally needs a genuine, verifiable relationship to your host in Singapore, an invitation letter from that host, evidence of their residence status in Singapore, and — as with any short visit — sufficient funds and a confirmed return itinerary.',
    'Passport (valid at least 6 months beyond intended departure)\nRecent passport-size photograph\nInvitation letter from your family member/host in Singapore, including their contact details and residence status\nProof of your host''s Singapore residence status (citizenship, PR, or valid long-term pass copy)\nProof of the family relationship (e.g. marriage or birth certificate, where relevant)\nConfirmed return or onward flight tickets\nBank statement for the last 3-6 months\nCompleted SAVE/ICA visa application form',
    '1. Initial consultation to confirm the relationship and purpose fit this category\n2. Visa category selection\n3. Document assessment, including your host''s residence-status proof\n4. Application preparation\n5. Document verification\n6. Submission through an ICA-authorised Singapore visa agent\n7. Support responding to any additional-information request\n8. Decision — e-visa issued as a PDF once approved\n9. Travel preparation, including the SG Arrival Card',
    'Commonly quoted at around 3-5 working days for a complete application, though ICA does not guarantee a fixed timeline.',
    'INR',
    'Government visa fees can change without notice. We''ll confirm the current total (government fee plus our service fee) before you apply.',
    'Typically usable within a set window from issue (commonly around two months) — check your issued e-visa.',
    'Commonly up to 30 days per entry for a short family visit, at ICA''s discretion.',
    'Single or multiple entry, depending on what is approved.',
    0, 0,
    'The most common issue is an invitation letter or relationship proof that doesn''t clearly establish both the relationship and the host''s Singapore residence status — both need to be evidenced, not just asserted.',
    'We help Indian families in Patna, Bihar, and nationwide prepare visit applications to see relatives in Singapore, including guidance on what your host needs to provide from their end.',
    'https://www.ica.gov.sg/enter-transit-depart/entering-singapore/visa_requirements/visa-detail-page/india',
    '2026-09-10'
);

-- ---------------------------------------------------------------------
-- Medical Visa (visa_type_id = 7)
-- ---------------------------------------------------------------------
INSERT INTO visa_requirements
    (country_id, visa_type_id, overview, who_should_apply, eligibility, documents_required, application_process, processing_time, currency, fee_notes, validity_period, stay_duration, entry_type, biometrics_required, interview_required, common_mistakes, local_notes, source_url, last_verified_at)
VALUES (
    92, 7,
    'Travelling to Singapore for medical treatment is generally handled through the same Visit Pass framework as tourism or business travel, supported by medical-specific documentation from your Singapore hospital or clinic — Singapore does not require or offer medical advice through this process; Visagiri assists only with the visa application, not with treatment decisions.',
    'Patients travelling to Singapore for medical consultation or treatment, and an accompanying attendant travelling with them, should apply under this category, using appointment or admission documentation from the treating hospital.',
    'A credible medical-visit application generally needs confirmed appointment or admission documentation from a recognised Singapore hospital or clinic, proof of funds sufficient for the treatment and stay (or a letter confirming payment arrangements), and — for an accompanying attendant — proof of their relationship to the patient.',
    'Passport (valid at least 6 months beyond intended departure) for the patient and any accompanying attendant\nRecent passport-size photographs\nAppointment or admission letter from the treating Singapore hospital/clinic, including estimated treatment dates\nMedical reports/referral summary supporting the treatment being sought\nProof of funds for treatment and stay, or payment-guarantee documentation\nProof of relationship for any accompanying attendant\nConfirmed return or onward flight tickets (where the treatment plan allows a fixed return date)\nCompleted SAVE/ICA visa application form',
    '1. Initial consultation once you have (or are arranging) a hospital appointment in Singapore\n2. Visa category selection for patient and attendant applications\n3. Document assessment of your hospital documentation and financial proof\n4. Application preparation\n5. Document verification\n6. Submission through an ICA-authorised Singapore visa agent\n7. Support responding to any additional-information request\n8. Decision — e-visa issued as a PDF once approved\n9. Travel preparation, including the SG Arrival Card and any hospital pre-admission steps',
    'Commonly quoted at around 3-5 working days for a complete application; treatment that is time-sensitive should have the visa application started as early as your hospital appointment allows.',
    'INR',
    'Government visa fees can change without notice. We''ll confirm the current total before you apply. Treatment costs themselves are set by your Singapore hospital, not by Visagiri or ICA.',
    'Typically usable within a set window from issue (commonly around two months) — check your issued e-visa.',
    'Commonly up to 30 days per entry, though ICA may consider the treatment plan when assessing stay duration.',
    'Single or multiple entry, depending on what is approved.',
    0, 0,
    'The most common issue is incomplete hospital documentation — an appointment confirmation alone is often not enough; a clear treatment summary and estimated timeline from the hospital strengthens the application.',
    'We assist patients and attendants travelling from Patna, Bihar, and across India, coordinating between your hospital''s documentation and the visa application so you can focus on the medical arrangements themselves.',
    'https://www.ica.gov.sg/enter-transit-depart/entering-singapore/visa_requirements/visa-detail-page/india',
    '2026-09-10'
);

-- ---------------------------------------------------------------------
-- Transit Visa (visa_type_id = 6)
-- ---------------------------------------------------------------------
INSERT INTO visa_requirements
    (country_id, visa_type_id, overview, who_should_apply, eligibility, documents_required, application_process, processing_time, currency, fee_notes, validity_period, stay_duration, entry_type, biometrics_required, interview_required, common_mistakes, local_notes, source_url, last_verified_at)
VALUES (
    92, 6,
    'Whether you need a visa to transit through Singapore depends on how you''re transiting. Indian passport holders connecting through Changi Airport without leaving the transit area generally do not need a separate transit visa. Travellers who want to briefly leave the airport during a longer connection may qualify for Singapore''s Visa Free Transit Facility (VFTF) instead of applying for a full visa — but VFTF has specific eligibility conditions, and travellers who don''t meet them need a standard Visit Pass/visa like any other entry.',
    'Travellers connecting through Singapore with a layover long enough that they want to leave the airport — but not long enough, or not matching VFTF''s conditions, to justify a full Tourist Visa — should check this category. Travellers staying airside the whole time typically don''t need anything from this page at all.',
    'For the Visa Free Transit Facility specifically, published conditions generally include: a valid passport with sufficient remaining validity, a confirmed onward ticket to a third country (not back to your starting point) departing within a set window (commonly cited as up to 96 hours), and — for many nationalities using VFTF, though requirements can differ by passport — a valid visa or residence permit for certain countries such as the US, UK, Canada, Australia, or similar. Eligibility is ultimately assessed by an ICA officer at the checkpoint, not guaranteed in advance by any agent.',
    'Passport (valid at least 6 months beyond your travel dates)\nConfirmed onward ticket to a third country within the eligible transit window\nEvidence of the qualifying visa/residence permit, if applying under VFTF conditions that require one\nProof of accommodation or clear itinerary for the transit period, if leaving the airport\nIf VFTF conditions are not met: the same documents as a standard Tourist Visa application (see our Tourist Visa page)',
    '1. Initial consultation to work out whether you qualify for visa-free transit or need a standard visa\n2. Eligibility check against current VFTF conditions for your itinerary\n3. Document assessment for whichever pathway applies\n4. Application preparation, if a standard visa is needed\n5. Document verification\n6. Submission through an ICA-authorised Singapore visa agent, where a visa application is required\n7. Support responding to any additional-information request\n8. Outcome — either VFTF entry assessed at the checkpoint, or a decision on your submitted visa application\n9. Travel preparation, including the SG Arrival Card',
    'For a standard transit visa application, commonly quoted at around 3-5 working days; VFTF eligibility itself is assessed at the checkpoint on arrival, not through advance processing.',
    'INR',
    'If you qualify for VFTF, there is no government visa fee for that specific facility — but if you don''t meet its conditions, standard visa fees apply and can change without notice. We''ll confirm which pathway applies to your itinerary before quoting any fee.',
    'VFTF has no separate visa validity since no visa is issued; a standard transit visa follows the same validity pattern as other Visit Pass visas.',
    'VFTF permits a short stay strictly within the eligible transit window (commonly cited as up to 96 hours) with no extension; a standard visa''s stay duration is set by ICA at entry.',
    'Single entry for transit purposes.',
    0, 0,
    'The most common mistake is assuming visa-free transit applies without checking the current conditions for your specific itinerary and passport — VFTF eligibility depends on your connecting flights, layover length, and sometimes on holding a valid visa for certain other countries. Always confirm before assuming you don''t need a visa.',
    'We help travellers from Patna, Bihar, and across India work out whether their specific Singapore connection qualifies for visa-free transit before they book, so there are no surprises at Changi.',
    'https://www.ica.gov.sg/enter-transit-depart/entering-singapore/visa_requirements/visa-detail-page/india',
    '2026-09-10'
);

-- ---------------------------------------------------------------------
-- Conference Visa (visa_type_id = 8)
-- ---------------------------------------------------------------------
INSERT INTO visa_requirements
    (country_id, visa_type_id, overview, who_should_apply, eligibility, documents_required, application_process, processing_time, currency, fee_notes, validity_period, stay_duration, entry_type, biometrics_required, interview_required, common_mistakes, local_notes, source_url, last_verified_at)
VALUES (
    92, 8,
    'Attending a conference, exhibition, trade fair, or professional event in Singapore is handled through the same ICA Visit Pass framework as business travel, supported by your event registration and any sponsoring-company documentation.',
    'Delegates, exhibitors, and speakers attending conferences, trade fairs, or professional events in Singapore should apply under this category, distinct from a general Business Visa where there''s no specific event to document.',
    'A credible conference-visit application generally needs event registration confirmation, an invitation letter (from the event organiser or your Singapore-based host company where relevant), and — as with any short visit — sufficient funds and a confirmed return itinerary.',
    'Passport (valid at least 6 months beyond intended departure)\nRecent passport-size photograph\nConference/event registration confirmation, including dates and venue\nInvitation letter from the event organiser or hosting company, where available\nCovering letter from your employer confirming your attendance is work-related\nConfirmed return or onward flight tickets\nBank statement for the last 3-6 months\nCompleted SAVE/ICA visa application form',
    '1. Initial consultation once your conference registration is confirmed\n2. Visa category selection\n3. Document assessment of your registration and invitation documents\n4. Application preparation\n5. Document verification\n6. Submission through an ICA-authorised Singapore visa agent\n7. Support responding to any additional-information request\n8. Decision — e-visa issued as a PDF once approved\n9. Travel preparation, including the SG Arrival Card',
    'Commonly quoted at around 3-5 working days for a complete application — apply as soon as your conference registration and travel dates are confirmed, especially for large trade events with high visa demand.',
    'INR',
    'Government visa fees can change without notice. We''ll confirm the current total before you apply.',
    'Typically usable within a set window from issue (commonly around two months) — check your issued e-visa.',
    'Commonly up to 30 days per entry, or matched to the event duration plus reasonable travel days, at ICA''s discretion.',
    'Single or multiple entry, depending on what is approved.',
    0, 0,
    'The most common issue is applying with only a generic hotel/flight itinerary and no actual proof of conference registration — event confirmation is what distinguishes this from a standard business or tourist visit.',
    'We support conference delegates and exhibitors from Patna, Bihar, and across India, including coordinating with event organisers for the confirmation documents ICA expects to see.',
    'https://www.ica.gov.sg/enter-transit-depart/entering-singapore/visa_requirements/visa-detail-page/india',
    '2026-09-10'
);

-- ---------------------------------------------------------------------
-- Work Visa (visa_type_id = 4) — Employment Pass, via Ministry of Manpower
-- ---------------------------------------------------------------------
INSERT INTO visa_requirements
    (country_id, visa_type_id, overview, who_should_apply, eligibility, documents_required, application_process, processing_time, currency, fee_notes, validity_period, stay_duration, entry_type, biometrics_required, interview_required, common_mistakes, local_notes, source_url, last_verified_at)
VALUES (
    92, 4,
    'Working in Singapore is not covered by a tourist or business visit pass at all — it requires a work pass issued by Singapore''s Ministry of Manpower (MOM), most commonly the Employment Pass (EP) for professionals, managers, and executives with a confirmed job offer. This is a materially different process, authority, and set of eligibility criteria from ICA''s short-visit visas, and Visagiri is clear about that distinction rather than calling every Singapore work-related trip a "work visa" loosely.',
    'Professionals, managers, executives, and company directors with a confirmed job offer from a Singapore-registered employer, where that employer intends to sponsor an Employment Pass, should use this pathway. The application is employer-sponsored — an individual cannot apply for an Employment Pass on their own behalf without a Singapore employer initiating it.',
    'Employment Pass eligibility is assessed by MOM against its published points-based framework (covering salary, qualifications, and other factors that MOM reviews and updates from time to time), alongside your employer meeting its own sponsorship obligations. Because MOM''s exact eligibility criteria and salary thresholds are reviewed periodically, we point applicants to MOM''s own published guidance for the current framework rather than quoting figures here that could go stale.',
    'Passport (valid well beyond your intended employment period)\nConfirmed job offer/employment contract from your Singapore-registered employer\nEducational qualification certificates and transcripts\nProfessional/employment history documentation (resume, past employer references)\nRecent passport-size photograph\nYour employer''s MOM Employment Pass application submission (via MOM''s EP Online system) — this step is completed by the employer, not the applicant directly\nAny additional supporting documents MOM requests during assessment',
    '1. Initial consultation once you have (or are close to receiving) a Singapore job offer\n2. Confirming with your employer that they will sponsor and submit the Employment Pass application via MOM''s EP Online system\n3. Document assessment — gathering your qualification and employment-history documents\n4. Application preparation, supporting your employer''s submission\n5. Document verification before submission\n6. Submission support while your employer files with MOM\n7. Support through MOM''s assessment, including any additional-document requests\n8. Decision — MOM issues the Employment Pass (or an In-Principle Approval) once approved\n9. Travel and onboarding preparation once your pass is confirmed',
    'MOM does not publish a fixed turnaround; employer-submitted Employment Pass applications commonly take several weeks to process, and can take longer if MOM requests additional information — plan employment start dates with this in mind.',
    'INR',
    'MOM sets its own government processing fees for Employment Pass applications, paid by the sponsoring employer, separate from Visagiri''s consultancy fee for helping you prepare your side of the application — we''ll confirm our fee clearly before you engage us.',
    'Commonly issued for up to two years for first-time Employment Pass holders, renewable subject to meeting MOM''s criteria at renewal — confirm current terms with MOM or your employer''s HR/immigration team.',
    'Matches your Employment Pass validity, for as long as your employment and the pass remain valid.',
    'Multiple entry for the duration of a valid Employment Pass.',
    1, 0,
    'The most common issue we see is applicants (or smaller employers) assuming this works like a visit-pass business visa — it doesn''t. The employer must initiate and sponsor the application through MOM''s system; an individual cannot self-apply for an Employment Pass the way they can apply for a tourist or business visit visa.',
    'We help Indian professionals from Patna, Bihar, and across the country prepare the applicant-side documentation their Singapore employer needs for an Employment Pass submission, and explain clearly what falls to the employer versus what we can help you prepare.',
    'https://www.mfa.gov.sg/Overseas-Mission/Mumbai/Consular-Services/Employment-Pass--Dependent-Pass',
    '2026-09-10'
);

-- ---------------------------------------------------------------------
-- Dependent Visa (visa_type_id = 10) — Dependant's Pass, via Ministry of Manpower
-- ---------------------------------------------------------------------
INSERT INTO visa_requirements
    (country_id, visa_type_id, overview, who_should_apply, eligibility, documents_required, application_process, processing_time, currency, fee_notes, validity_period, stay_duration, entry_type, biometrics_required, interview_required, common_mistakes, local_notes, source_url, last_verified_at)
VALUES (
    92, 10,
    'A Dependant''s Pass (DP) is a long-term pass issued by Singapore''s Ministry of Manpower (MOM), separate from ICA''s short-visit Family Visit Visa, that lets the immediate family of certain work-pass holders — married spouses and children under 21 — live in Singapore alongside them. It is sponsored by the work-pass holder, not applied for independently.',
    'Spouses and children under 21 of an Employment Pass or S Pass holder who wants to bring family to live with them in Singapore should use this pathway. If you''re only visiting family in Singapore for a short trip rather than relocating, the Family Visit Visa (a short-stay ICA visit pass) is the relevant category instead — see our Family Visit Visa page.',
    'The sponsoring Employment Pass or S Pass holder generally needs to meet MOM''s minimum qualifying salary for dependant sponsorship (a threshold MOM reviews periodically, so we point applicants to MOM''s current published figure rather than quoting one that could go stale), and the relationship (marriage or parentage) needs to be clearly documented. The Dependant''s Pass is tied to the sponsor''s work pass — if the sponsor''s pass ends, the DP ends with it.',
    'Passport of the dependant (spouse/child) valid well beyond the intended stay\nProof of relationship — marriage certificate for a spouse, birth certificate for a child\nSponsor''s Employment Pass/S Pass details and proof of current employment\nSponsor''s salary documentation supporting the minimum qualifying threshold\nRecent passport-size photograph of the dependant\nCompleted MOM Dependant''s Pass application (submitted by or on behalf of the sponsor)',
    '1. Initial consultation with the sponsoring work-pass holder to confirm dependant eligibility\n2. Confirming the sponsor meets MOM''s current qualifying-salary threshold for dependant sponsorship\n3. Document assessment — relationship proof and sponsor employment documentation\n4. Application preparation\n5. Document verification before submission\n6. Submission support for the MOM Dependant''s Pass application\n7. Support through MOM''s assessment, including any additional-document requests\n8. Decision — MOM issues the Dependant''s Pass once approved\n9. Travel and settling-in preparation once the pass is confirmed',
    'MOM does not publish a fixed turnaround for Dependant''s Pass applications; plan for several weeks and avoid booking irreversible travel before approval is confirmed.',
    'INR',
    'MOM sets its own government fees for Dependant''s Pass applications, separate from Visagiri''s consultancy fee for helping prepare the application — we''ll confirm our fee clearly before you engage us.',
    'Tied to the sponsor''s Employment Pass/S Pass validity.',
    'Matches the sponsor''s work-pass validity, for as long as both remain valid and the relationship continues to qualify.',
    'Multiple entry for the duration of a valid Dependant''s Pass.',
    1, 0,
    'The most common issue is assuming a Dependant''s Pass and a short-visit Family Visit Visa are the same thing, or applying before confirming the sponsor actually meets MOM''s current qualifying-salary threshold — both are worth checking before you start.',
    'We help sponsoring professionals from Patna, Bihar, and across India prepare the family-side documentation MOM''s Dependant''s Pass process needs, working around your and your family''s schedule.',
    'https://www.mfa.gov.sg/Overseas-Mission/Mumbai/Consular-Services/Employment-Pass--Dependent-Pass',
    '2026-09-10'
);
