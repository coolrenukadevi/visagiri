-- Singapore visa FAQs — hub-level (country_id = 92, visa_type_id NULL)
-- plus one distinct set per visa type (country_id = 92, visa_type_id =
-- the real catalog id). Written to reflect genuine search intent per
-- category rather than generic filler, and answers are qualified
-- rather than absolute where the true answer depends on individual
-- circumstances or official discretion — see AUDIT.md for sourcing
-- notes (same sources as seed-country-content-singapore.sql).

-- ---------------------------------------------------------------------
-- Hub-level FAQs (/visa/singapore/)
-- ---------------------------------------------------------------------
INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do Indian citizens need a visa for Singapore?', 'Yes. Indian ordinary-passport holders generally need an approved visa or pass before entering Singapore — there is no general visa-free or visa-on-arrival entry for Indian citizens. The one narrow exception is Singapore''s Visa Free Transit Facility for certain eligible airport connections; see our Transit Visa page for details.', 92, NULL, 100, 1),
('How can I apply for a Singapore visa from India?', 'Singapore visa applications from India are submitted through an ICA-authorised visa agent using ICA''s SAVE system, not filed directly by individuals at a counter. Visagiri prepares and reviews your documents, then submits your application as an authorised agent on your behalf.', 92, NULL, 101, 1),
('Can I apply for a Singapore visa from Patna?', 'Yes. Visagiri works with applicants across Patna and Bihar the same way we do nationwide — documents can be shared digitally for review, and we handle preparation and submission without requiring an in-person office visit.', 92, NULL, 102, 1),
('How long does Singapore visa processing take?', 'Standard visit-pass applications (tourist, business, family, medical, conference) are commonly quoted at around 3-5 working days once a complete application is submitted, though ICA does not guarantee a fixed timeline. Student''s Pass and work-pass applications (Employment Pass, Dependant''s Pass) typically take longer — often several weeks — since they go through separate ICA (SOLAR) or MOM processes.', 92, NULL, 103, 1),
('What documents are required for a Singapore visa?', 'Requirements vary by visa category, but most short-visit applications need a passport valid at least 6 months beyond your trip, a recent photograph, proof of funds, a confirmed return ticket, and category-specific documents (accommodation proof for tourism, an invitation letter for business, hospital documentation for medical travel, and so on). See each visa category''s page for its specific checklist.', 92, NULL, 104, 1),
('Can I apply for a Singapore visa through a visa consultant?', 'Yes — most Indian applicants apply through an ICA-authorised visa agent rather than directly, since individual applicants don''t submit through SAVE themselves. Visagiri is a visa consultancy that prepares your application and submits it as an authorised agent; final decisions remain with ICA (or MOM for work/dependant passes).', 92, NULL, 105, 1),
('What financial documents may be required for a Singapore visa?', 'Most applications ask for bank statements from the last 3-6 months showing sufficient funds for your trip, alongside proof of income or employment. Exact requirements depend on your visa category and individual profile — our team reviews this with you before submission.', 92, NULL, 106, 1),
('Can self-employed applicants apply for a Singapore visa?', 'Yes. Self-employed applicants typically provide business registration proof and financial statements in place of an employer letter — we''ll guide you on what documentation works best for your specific business structure.', 92, NULL, 107, 1),
('Can business travellers apply for a Singapore visa?', 'Yes, under the Business Visa category, which uses the same ICA visit-pass framework as tourism but with business-specific documents like an invitation letter and employer covering letter. It does not, on its own, authorise employment in Singapore — that needs a work pass. See our Business Visa and Employment/Work Visa pages.', 92, NULL, 108, 1),
('Can students apply for a Singapore visa?', 'Students admitted to a Singapore institution apply for a Student''s Pass through ICA''s SOLAR system, initiated by the institution rather than the student directly. See our Student Visa page for the full process.', 92, NULL, 109, 1),
('Can families apply together for a Singapore visa?', 'Yes, family members can apply together for a short Family Visit Visa to see relatives already in Singapore. Note this is different from the long-term Dependant''s Pass, which lets immediate family live alongside a work-pass holder — see our Family Visit Visa and Dependent Visa pages for the distinction.', 92, NULL, 110, 1),
('Can I travel to Singapore for medical treatment?', 'Yes, medical travel to Singapore is generally handled through the same visit-pass framework as tourism, supported by appointment or admission documentation from your treating hospital. See our Medical Visa page. Visagiri assists only with the visa application, not with medical advice or treatment arrangements.', 92, NULL, 111, 1),
('What happens if ICA requests additional documents for my Singapore visa application?', 'This is a normal part of the process for some applications. Visagiri supports you in preparing and submitting whatever additional information ICA (or MOM, for work/dependant passes) requests, to keep your application moving without unnecessary delay.', 92, NULL, 112, 1),
('What are common reasons Singapore visa applications are delayed or refused?', 'Incomplete or inconsistent financial documents, unclear or missing supporting documents, mismatched information across documents, and applying too close to the travel date are the most common avoidable issues. The final decision is always ICA''s (or MOM''s); Visagiri cannot guarantee approval, but we help you avoid the avoidable mistakes.', 92, NULL, 113, 1),
('How early should I apply for a Singapore visa?', 'As early as your travel plans allow, and well before your trip — especially for Student''s Pass and work-pass categories, which can take several weeks and involve your institution or employer''s own timelines. For short-visit categories, applying at least a couple of weeks ahead gives room for any additional-document requests.', 92, NULL, 114, 1);

-- ---------------------------------------------------------------------
-- Tourist Visa FAQs (visa_type_id = 1)
-- ---------------------------------------------------------------------
INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is a Singapore Tourist Visa?', 'It''s a short-stay Visit Pass, issued electronically through ICA''s SAVE system, that covers leisure travel — sightseeing and holidays — in Singapore.', 92, 1, 200, 1),
('How long can I stay in Singapore on a Tourist Visa?', 'Stay duration is set by the ICA officer at entry, commonly up to around 30 days for a standard tourist visit — it is not fixed in advance by the visa itself.', 92, 1, 201, 1),
('Do I need a hotel booking to apply for a Singapore Tourist Visa?', 'You need proof of accommodation — either a hotel booking or, if you''re staying with a host, an invitation letter from that host in Singapore.', 92, 1, 202, 1),
('Can I apply for a Singapore Tourist Visa without a return ticket booked?', 'A confirmed return or onward ticket is generally expected as part of a complete tourist-visa application, since it supports your genuine tourist intent.', 92, 1, 203, 1),
('Can Visagiri review my Singapore Tourist Visa documents before submission?', 'Yes — document review before submission is a core part of our process, specifically to catch gaps (like inconsistent bank statements or accommodation dates) before ICA sees the application.', 92, 1, 204, 1),
('Is a Singapore Tourist Visa the same for a family group?', 'Family members travelling together for tourism generally each need their own visit-pass application, though documents like the itinerary and accommodation proof can often be shared or cross-referenced across the group''s applications.', 92, 1, 205, 1);

-- ---------------------------------------------------------------------
-- Business Visa FAQs (visa_type_id = 2)
-- ---------------------------------------------------------------------
INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is a Singapore Business Visa?', 'It''s a short-stay visit pass for genuine business activity — meetings, negotiations, trade fairs, and client visits — issued under the same ICA framework as the Tourist Visa but with business-specific supporting documents.', 92, 2, 210, 1),
('Does a Singapore Business Visa let me work for a Singapore company?', 'No. A Business Visa covers short visit-based business activity only; actually working for or being paid by a Singapore employer requires an Employment Pass from the Ministry of Manpower — see our Employment/Work Visa page.', 92, 2, 211, 1),
('Do I need an invitation letter for a Singapore Business Visa?', 'Generally yes — an invitation letter from your Singapore host company (or trade-event registration confirmation) is a standard part of a business-visa application, alongside a covering letter from your own employer.', 92, 2, 212, 1),
('Can a self-employed business owner apply for a Singapore Business Visa?', 'Yes, using business registration proof and financial documentation in place of an employer covering letter.', 92, 2, 213, 1),
('Can frequent business travellers get a multiple-entry Singapore visa?', 'Travellers with a genuine pattern of repeat business travel to Singapore may be considered for longer multiple-entry validity, at ICA''s discretion — there is no automatic entitlement.', 92, 2, 214, 1),
('How is a Singapore Business Visa different from a Conference Visa?', 'A Conference Visa is for attending a specific documented event (with registration confirmation), while a Business Visa covers broader business activity like client meetings that isn''t tied to a single event — see our Conference Visa page for that category specifically.', 92, 2, 215, 1);

-- ---------------------------------------------------------------------
-- Student Visa FAQs (visa_type_id = 3)
-- ---------------------------------------------------------------------
INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is Singapore''s Student''s Pass?', 'It''s the long-term pass ICA issues to international students admitted to a registered Singapore institution, applied for through ICA''s SOLAR system.', 92, 3, 220, 1),
('Do I apply for the Singapore Student''s Pass myself?', 'No — your Singapore institution initiates the SOLAR application on your behalf once you''ve been admitted; you don''t file it independently the way you would a tourist visa.', 92, 3, 221, 1),
('When should I start my Singapore Student''s Pass application?', 'As soon as you have your institution''s admission offer, and always within your institution''s own SOLAR submission deadline — starting late risks missing your intake.', 92, 3, 222, 1),
('Can I travel to Singapore before my Student''s Pass In-Principle Approval is issued?', 'No — travel should wait until your In-Principle Approval (IPA) letter is issued, since it''s required for entry as a student.', 92, 3, 223, 1),
('What financial proof does a Singapore Student''s Pass application need?', 'Evidence you (or your sponsor) can support tuition and living costs for your course — exact documentation depends on your institution''s requirements, which we''ll help you confirm.', 92, 3, 224, 1),
('Can Visagiri help with my Singapore Student''s Pass even though my institution files it?', 'Yes — we help you gather and prepare the academic and financial documents your institution''s SOLAR submission needs, and guide you through the steps after arrival (medical check, pass issuance).', 92, 3, 225, 1);

-- ---------------------------------------------------------------------
-- Family Visit Visa FAQs (visa_type_id = 5)
-- ---------------------------------------------------------------------
INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is a Singapore Family Visit Visa?', 'A short-stay visit pass for visiting family members who are already living in or based in Singapore, distinct from the long-term Dependant''s Pass.', 92, 5, 230, 1),
('How is the Family Visit Visa different from a Dependant''s Pass?', 'The Family Visit Visa is a short visit; the Dependant''s Pass is a long-term pass sponsored by a work-pass holder that lets immediate family actually live in Singapore. See our Dependent Visa page for that category.', 92, 5, 231, 1),
('What proof do I need of my relationship to my host in Singapore?', 'Documentation like a marriage or birth certificate, plus proof of your host''s residence status in Singapore (citizenship, PR, or a valid long-term pass).', 92, 5, 232, 1),
('Can my whole family apply together to visit relatives in Singapore?', 'Yes, though each family member generally submits their own application, with shared supporting documents like the host''s invitation letter.', 92, 5, 233, 1),
('Does my Singapore-based host need to provide anything for my Family Visit Visa?', 'Yes — typically an invitation letter along with proof of their own residence status in Singapore.', 92, 5, 234, 1),
('How long can I stay in Singapore on a Family Visit Visa?', 'Stay duration is set by ICA at entry, commonly up to around 30 days for a short family visit.', 92, 5, 235, 1);

-- ---------------------------------------------------------------------
-- Medical Visa FAQs (visa_type_id = 7)
-- ---------------------------------------------------------------------
INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Does Singapore have a separate Medical Visa?', 'Medical travel is generally handled through the same visit-pass framework as tourism, supported by hospital appointment/admission documentation rather than a legally distinct visa category.', 92, 7, 240, 1),
('What hospital documents do I need for a Singapore medical-visit application?', 'An appointment or admission letter from the treating hospital, including estimated treatment dates, plus a medical summary supporting the visit.', 92, 7, 241, 1),
('Can an attendant travel with a patient to Singapore?', 'Yes — an accompanying attendant can apply alongside the patient, with proof of their relationship to the patient included in the application.', 92, 7, 242, 1),
('Does Visagiri arrange hospital appointments in Singapore?', 'No — we assist only with the visa application itself. Hospital appointments, treatment planning, and medical decisions are between you and your chosen Singapore hospital.', 92, 7, 243, 1),
('What if my treatment plan changes after my visa is issued?', 'Contact us as soon as possible — depending on the change, you may need updated hospital documentation or, in some cases, a fresh application; we''ll advise based on your specific situation.', 92, 7, 244, 1),
('How early should I apply for a Singapore medical-visit visa?', 'As soon as your hospital appointment is confirmed, since treatment dates are often time-sensitive and processing takes time to complete properly.', 92, 7, 245, 1);

-- ---------------------------------------------------------------------
-- Transit Visa FAQs (visa_type_id = 6)
-- ---------------------------------------------------------------------
INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Do I need a visa to transit through Singapore Changi Airport?', 'If you stay airside and don''t leave the transit area, you generally don''t need a separate transit visa. Leaving the airport, or a longer connection, may require either the Visa Free Transit Facility (if you meet its conditions) or a standard visa.', 92, 6, 250, 1),
('What is Singapore''s Visa Free Transit Facility (VFTF)?', 'A facility that allows certain eligible travellers with a confirmed onward ticket to a third country, connecting within a set window, to enter Singapore briefly without a separate visa — conditions vary by passport and itinerary, and eligibility is assessed by ICA at the checkpoint.', 92, 6, 251, 1),
('Does every traveller qualify for Singapore''s visa-free transit facility?', 'No — eligibility depends on factors like your onward destination, connection time, and sometimes holding a valid visa for certain other countries. Not meeting the conditions means a standard visa is needed instead.', 92, 6, 252, 1),
('Can I extend my stay under the Visa Free Transit Facility?', 'No — VFTF does not allow an extension of stay; it''s strictly for the transit window itself.', 92, 6, 253, 1),
('What if I don''t qualify for visa-free transit through Singapore?', 'You would need a standard Visit Pass/visa (typically the Tourist Visa category) for your layover, following the same documentation and application process.', 92, 6, 254, 1),
('Can Visagiri check if my Singapore layover qualifies for visa-free transit?', 'Yes — we review your specific flight itinerary and passport against current VFTF conditions before you travel, so you know which pathway applies.', 92, 6, 255, 1);

-- ---------------------------------------------------------------------
-- Conference Visa FAQs (visa_type_id = 8)
-- ---------------------------------------------------------------------
INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is a Singapore Conference Visa?', 'A short-stay visit pass for attending a conference, trade fair, exhibition, or professional event in Singapore, supported by your event registration.', 92, 8, 260, 1),
('What proof of conference attendance is needed?', 'Registration confirmation from the event, including dates and venue, and typically an invitation letter from the organiser or your hosting company.', 92, 8, 261, 1),
('How is a Conference Visa different from a Business Visa?', 'A Conference Visa ties to a specific documented event; a Business Visa covers broader business activity, like client meetings, not tied to one event. See our Business Visa page.', 92, 8, 262, 1),
('Can exhibitors and speakers apply under the Conference Visa category?', 'Yes — delegates, exhibitors, and speakers with event documentation all fall under this category.', 92, 8, 263, 1),
('How early should I apply for a Singapore Conference Visa?', 'As soon as your event registration and travel dates are confirmed, particularly for large trade events where visa demand is high.', 92, 8, 264, 1),
('Can my employer''s covering letter support a Conference Visa application?', 'Yes — a covering letter from your employer confirming your attendance is work-related strengthens the application alongside your event registration.', 92, 8, 265, 1);

-- ---------------------------------------------------------------------
-- Work Visa FAQs (visa_type_id = 4) — Employment Pass
-- ---------------------------------------------------------------------
INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('Is a Singapore work visa the same as a Singapore tourist or business visa?', 'No. Working in Singapore requires an Employment Pass issued by the Ministry of Manpower (MOM), a completely different process and authority from ICA''s short-visit tourist/business visa framework.', 92, 4, 270, 1),
('Can I apply for a Singapore Employment Pass myself?', 'No — the application must be sponsored and submitted by your Singapore-registered employer through MOM''s EP Online system; you cannot self-apply.', 92, 4, 271, 1),
('What does Visagiri help with for a Singapore Employment Pass?', 'We help you prepare the applicant-side documentation (qualifications, employment history, supporting paperwork) your employer needs for their MOM submission, and explain clearly what falls to your employer versus what we can assist with.', 92, 4, 272, 1),
('How long does a Singapore Employment Pass take to process?', 'MOM does not publish a fixed turnaround; employer-submitted applications commonly take several weeks, longer if MOM requests additional information.', 92, 4, 273, 1),
('How long is a Singapore Employment Pass valid?', 'Commonly up to two years for first-time holders, renewable subject to meeting MOM''s criteria at renewal — confirm current terms with MOM or your employer.', 92, 4, 274, 1),
('Can my family join me in Singapore on my Employment Pass?', 'Eligible immediate family (spouse and children under 21) may be sponsored separately for a Dependant''s Pass, subject to your Employment Pass meeting MOM''s qualifying-salary threshold for sponsorship — see our Dependent Visa page.', 92, 4, 275, 1);

-- ---------------------------------------------------------------------
-- Dependent Visa FAQs (visa_type_id = 10) — Dependant's Pass
-- ---------------------------------------------------------------------
INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES
('What is Singapore''s Dependant''s Pass?', 'A long-term pass issued by the Ministry of Manpower (MOM) that lets the immediate family — spouse and children under 21 — of certain work-pass holders live in Singapore with them.', 92, 10, 280, 1),
('Who can sponsor a Singapore Dependant''s Pass?', 'An Employment Pass or S Pass holder who meets MOM''s current minimum qualifying salary for dependant sponsorship.', 92, 10, 281, 1),
('Is a Dependant''s Pass the same as a Family Visit Visa?', 'No — the Dependant''s Pass is a long-term pass for living in Singapore, tied to the sponsor''s work pass; the Family Visit Visa is a short-stay ICA visit pass for visiting family. See our Family Visit Visa page.', 92, 10, 282, 1),
('Can a Dependant''s Pass holder work in Singapore?', 'Not automatically — a Dependant''s Pass alone doesn''t grant the right to work. Holders who want to work generally need a Letter of Consent or their own separate work pass.', 92, 10, 283, 1),
('What happens to a Dependant''s Pass if the sponsor''s work pass ends?', 'The Dependant''s Pass is tied to the sponsor''s Employment Pass/S Pass — if that pass is cancelled or expires, the Dependant''s Pass ends with it.', 92, 10, 284, 1),
('What documents does a Singapore Dependant''s Pass application need?', 'Proof of the relationship (marriage or birth certificate), the sponsor''s current work-pass and salary documentation, and the dependant''s own passport and photograph.', 92, 10, 285, 1);
