/*
 * Content for the country visa guides rendered by visa.php.
 *
 * HOW UNVERIFIED FIELDS ARE TREATED
 * Fee, processing time, validity and entry type are only PRINTED when the
 * visa type is marked `verified: true` — that is, when the figures came
 * through the import pipeline in data/import/ from a source somebody checked.
 * Everything else renders as an honest "confirmed for your nationality"
 * instead of a number (see visa_fact() in lib-php/data.php).
 *
 * This is why the old "(sample)" suffixes have gone. A reader skims past a
 * parenthetical; they do not skim past a figure, and a plausible wrong fee or
 * processing time is exactly the sort of thing people book non-refundable
 * travel around.
 *
 * The same rule applies to prose. Do not write a specific fee, duration or
 * threshold into an overview, FAQ or note unless it has been verified — hedge
 * or describe the mechanism instead.
 *
 * To add a country: add its name to data/all-countries.json (it gets a guide
 * automatically), and add a full entry here only if you have real content for
 * it. Then run `node tools/export-data.js`.
 */

const STANDARD_DOCS = {
  mandatory: [
    "Valid passport with at least 6 months' validity beyond the travel date and 2 blank pages",
    "Recent passport-size photograph (as per destination country's photo specification)",
    "Completed and signed visa application form",
    "Proof of travel — return flight reservation",
  ],
  supporting: [
    "Proof of financial means (bank statements, typically last 3–6 months)",
    "Confirmed hotel booking or accommodation proof",
    "Travel insurance covering the full duration of stay",
    "Cover letter explaining the purpose of travel",
  ],
  optional: [
    "Invitation letter (for business, family visit, or conference visas)",
    "Employer NOC / leave sanction letter",
    "Previous visa copies (if any)",
  ],
};

const EMBASSY_CITIES = ["New Delhi", "Mumbai", "Chennai", "Kolkata", "Hyderabad", "Bengaluru"];

const COUNTRIES = [
  {
    country: "Kenya", flag: "🇰🇪", slug: "kenya",
    visaTypes: [
      {
        visaType: "Tourist Visa", visaTypeSlug: "tourist-visa",
        heroSummary: "Everything you need to apply for a Kenya Tourist eVisa — eligibility, documents, fees, and processing time.",
        overview: "Kenya's Tourist Visa (available as an eVisa) is intended for leisure travel, sightseeing, safari holidays, and visiting friends or family. Most nationalities apply online before departure rather than at an embassy counter.",
        categories: ["Single-entry Tourist eVisa", "East Africa Tourist Visa (Kenya, Uganda, Rwanda — multi-entry)"],
        eligibility: [
          "Passport valid for at least 6 months from the date of entry",
          "Proof of return or onward travel",
          "Sufficient funds to cover the stay",
          "No history of visa violations in Kenya",
        ],
        processingTime: "3–5 business days (sample)", visaFee: "≈ USD 51 (sample)", validity: "90 days from issue (sample)", entryType: "Single entry (sample)",
        embassyName: "High Commission of Kenya", embassyPhone: "+91-11-XXXX-XXXX (sample)", embassyEmail: "info@kenyahighcommission.in (sample)",
        appointmentInfo: "Kenya's Tourist eVisa is processed online — no in-person embassy appointment is required for most applicants. Business and long-term visa categories may require an appointment at the High Commission.",
        procedureSteps: [
          "Create an account on Kenya's official eVisa portal",
          "Complete the online application and upload required documents",
          "Pay the visa fee online",
          "Receive the approved eVisa by email and carry a printed copy while travelling",
        ],
        faqs: [
          { q: "Can I apply for a Kenya visa on arrival?", a: "Kenya has moved to an eVisa-only system for most nationalities — apply online before you travel rather than on arrival." },
          { q: "How long can I stay in Kenya on a Tourist Visa?", a: "The permitted stay is whatever is printed on your approved eVisa, which is not always the maximum the category allows. Read the dates on the grant rather than assuming, and confirm the current rule with us before booking." },
          { q: "Is travel insurance mandatory for Kenya?", a: "It isn't always a strict eVisa requirement, but Convercession recommends travel insurance for every international trip." },
        ],
        importantNotes: ["Visa rules change periodically — always confirm current requirements with Convercession or the High Commission before booking travel.", "Yellow fever vaccination proof may be required depending on your travel history."],
        travelAdvisory: "Check the latest government travel advisory for Kenya before finalising travel plans.",
      },
      {
        visaType: "Business Visa", visaTypeSlug: "business-visa",
        heroSummary: "Kenya Business Visa requirements for meetings, conferences, and short-term corporate travel.",
        overview: "The Kenya Business Visa is for travellers attending meetings, conferences, negotiations, or exploring business opportunities — it does not permit local employment.",
        categories: ["Single-entry Business eVisa", "Multiple-entry Business Visa (select nationalities)"],
        eligibility: ["Valid passport (6+ months)", "Invitation letter from the Kenyan business host", "Proof of employment/business ownership in the home country", "Sufficient funds for the trip"],
        processingTime: "3–7 business days (sample)", visaFee: "≈ USD 51+ (sample)", validity: "90 days from issue (sample)", entryType: "Single or multiple entry (sample)",
        embassyName: "High Commission of Kenya", embassyPhone: "+91-11-XXXX-XXXX (sample)", embassyEmail: "info@kenyahighcommission.in (sample)",
        appointmentInfo: "Applied for online via the eVisa portal; multiple-entry business visas may require supporting documentation review at the High Commission.",
        procedureSteps: ["Gather invitation letter and supporting business documents", "Apply via the Kenya eVisa portal", "Pay the visa fee", "Receive and print the approved eVisa"],
        faqs: [
          { q: "Can a Business Visa be converted to a work permit?", a: "No — a Business Visa does not permit employment. A separate work permit application is required for employment in Kenya." },
        ],
        importantNotes: ["Carry the original invitation letter while travelling — immigration officers may request it on arrival."],
        travelAdvisory: "Check the latest government travel advisory for Kenya before finalising travel plans.",
      },
    ],
  },
  {
    country: "United States", flag: "🇺🇸", slug: "united-states",
    visaTypes: [
      {
        visaType: "Tourist Visa", visaTypeSlug: "tourist-visa",
        heroSummary: "US B-2 Tourist Visa guide — eligibility, DS-160 documents, interview process, and typical wait times.",
        overview: "The US B-2 Visitor Visa covers tourism, vacation, visiting family or friends, and medical treatment. Most applicants must complete form DS-160 and attend an in-person interview at a US Embassy or Consulate.",
        categories: ["B-2 Tourist/Visitor Visa", "B-1/B-2 Combined Business & Tourist Visa"],
        eligibility: ["Strong ties to home country (job, property, family)", "Sufficient funds for the trip", "Clear intent to return after the visit", "No prior visa violations"],
        processingTime: "Interview wait times vary widely by consulate (sample — check current wait times)", visaFee: "USD 185 non-refundable application fee (sample)", validity: "Typically issued for up to 10 years, multiple entry (varies by nationality)", entryType: "Multiple entry (typical)",
        embassyName: "US Embassy New Delhi / Consulates in Mumbai, Chennai, Kolkata, Hyderabad", embassyPhone: "Via official US visa appointment portal (sample)", embassyEmail: "support-india@ustraveldocs.com (sample)",
        appointmentInfo: "After submitting form DS-160, applicants schedule a biometrics appointment and an in-person interview at the nearest US Embassy or Consulate.",
        procedureSteps: ["Complete the DS-160 online application", "Pay the visa application fee", "Schedule your biometrics + interview appointment", "Attend the interview with all required documents", "Await passport return with visa (if approved)"],
        faqs: [
          { q: "Is the US visa fee refundable if rejected?", a: "No, the DS-160 application fee is non-refundable regardless of the interview outcome." },
          { q: "How far in advance should I apply?", a: "Given interview wait times can run several weeks to months depending on the consulate, apply well ahead of your intended travel date." },
        ],
        importantNotes: ["Interview wait times fluctuate significantly by consulate location and season — confirm current estimates before planning travel dates."],
        travelAdvisory: "Check the latest government travel advisory for the United States before finalising travel plans.",
      },
    ],
  },
  {
    country: "United Kingdom", flag: "🇬🇧", slug: "united-kingdom",
    visaTypes: [
      {
        visaType: "Student Visa", visaTypeSlug: "student-visa",
        heroSummary: "UK Student Visa (formerly Tier 4) requirements — CAS, financial proof, and application timeline.",
        overview: "The UK Student Visa is for applicants aged 16+ who have an unconditional offer from a licensed UK student sponsor, evidenced by a Confirmation of Acceptance for Studies (CAS).",
        categories: ["Student Visa (main applicant)", "Student dependant visa (for eligible family members)"],
        eligibility: ["Confirmation of Acceptance for Studies (CAS) from a licensed sponsor", "Proof of English language proficiency", "Sufficient funds for tuition and living costs", "Valid passport"],
        processingTime: "≈ 3 weeks standard processing outside the UK (sample)", visaFee: "GBP 490 (sample) + Immigration Health Surcharge", validity: "Length of course + standard grace period", entryType: "Single/multiple entry as per course duration",
        embassyName: "UK Visa Application Centre (VFS Global)", embassyPhone: "Via official UK visa online account (sample)", embassyEmail: "support (via UKVI online account)",
        appointmentInfo: "Biometric appointment booked at a Visa Application Centre after the online application is submitted.",
        procedureSteps: ["Receive your CAS from the university", "Complete the online student visa application", "Pay the visa fee and Immigration Health Surcharge", "Book and attend your biometric appointment", "Await a decision on your application"],
        faqs: [
          { q: "Can I work while on a UK Student Visa?", a: "Many student visa holders can work part-time during term, subject to conditions set by UKVI and your course level — confirm your specific conditions." },
        ],
        importantNotes: ["Financial proof must typically be held for a minimum consecutive period before applying — confirm the current requirement."],
        travelAdvisory: "Check the latest government travel advisory for the United Kingdom before finalising travel plans.",
      },
    ],
  },
  {
    country: "Australia", flag: "🇦🇺", slug: "australia",
    visaTypes: [
      {
        visaType: "Employment / Work Visa", visaTypeSlug: "employment-work-visa",
        heroSummary: "Australia Work Visa (Skilled/Employer-sponsored) overview — eligibility, points test, and required documents.",
        overview: "Australia offers several employment visa pathways, including employer-sponsored visas and points-tested skilled visas. Requirements vary significantly by visa subclass.",
        categories: ["Employer Nomination Scheme (subclass 186)", "Skilled Independent Visa (subclass 189)", "Temporary Skill Shortage Visa (subclass 482)"],
        eligibility: ["Occupation on the relevant skilled occupation list", "Skills assessment from the relevant assessing authority", "Meets points threshold (for points-tested subclasses)", "Employer sponsorship (for employer-sponsored subclasses)"],
        processingTime: "Varies significantly by subclass — from a few weeks to several months (sample)", visaFee: "From AUD 4,640 (sample, subclass-dependent)", validity: "Permanent or temporary depending on subclass", entryType: "Depends on subclass",
        embassyName: "Australian High Commission / Visa Application Centre", embassyPhone: "Via ImmiAccount online system (sample)", embassyEmail: "Via ImmiAccount online system",
        appointmentInfo: "Most employment visa applications are lodged entirely online via ImmiAccount; biometrics are collected at a Visa Application Centre.",
        procedureSteps: ["Confirm eligibility and occupation list status", "Complete a skills assessment (if required)", "Receive employer nomination or submit Expression of Interest", "Lodge the visa application via ImmiAccount", "Provide biometrics and supporting documents", "Await a decision"],
        faqs: [
          { q: "Do all Australian work visas lead to permanent residence?", a: "No — some subclasses are temporary only. Confirm the specific pathway and conditions of your subclass." },
        ],
        importantNotes: ["Skilled occupation lists and points thresholds change periodically — confirm current criteria before applying."],
        travelAdvisory: "Check the latest government travel advisory for Australia before finalising travel plans.",
      },
    ],
  },
  {
    country: "Canada", flag: "🇨🇦", slug: "canada",
    visaTypes: [
      {
        visaType: "Business Visa", visaTypeSlug: "business-visa",
        heroSummary: "Canada Business Visitor Visa — eligibility, documents, and application process for short business trips.",
        overview: "The Canada Business Visitor Visa allows travellers to attend meetings, conferences, and explore business opportunities without entering the Canadian labour market.",
        categories: ["Business Visitor visa (single/multiple entry)"],
        eligibility: ["Primary source of income and place of business outside Canada", "Proof of the business purpose of the visit", "Sufficient funds for the trip", "Clear intent to leave Canada after the visit"],
        processingTime: "Varies by application volume — check current IRCC processing times (sample)", visaFee: "CAD 100 (sample)", validity: "Up to 10 years, multiple entry (typical for eTA-eligible / visa-required nationals varies)", entryType: "Multiple entry (typical)",
        embassyName: "Canadian High Commission / Visa Application Centre", embassyPhone: "Via IRCC online portal (sample)", embassyEmail: "Via IRCC online portal",
        appointmentInfo: "Biometrics appointment booked at a Visa Application Centre after the online application is submitted.",
        procedureSteps: ["Create an IRCC online account", "Complete the visitor visa application", "Pay the application and biometrics fees", "Provide biometrics at a Visa Application Centre", "Await a decision"],
        faqs: [
          { q: "Can I attend meetings on a Business Visitor visa?", a: "Yes — attending meetings, conferences, and negotiations is permitted, but performing paid work in Canada is not." },
        ],
        importantNotes: ["Carry proof of your business purpose and ties to your home country to present at the port of entry."],
        travelAdvisory: "Check the latest government travel advisory for Canada before finalising travel plans.",
      },
    ],
  },
  {
    country: "Germany", flag: "🇩🇪", slug: "germany",
    visaTypes: [
      {
        visaType: "Employment / Work Visa", visaTypeSlug: "employment-work-visa",
        heroSummary: "Germany Employment Visa (national D-visa) requirements for skilled workers and job seekers.",
        overview: "Germany's national (D) visa for employment purposes covers skilled workers with a job offer, EU Blue Card applicants, and — under specific conditions — job seekers.",
        categories: ["Skilled Worker visa", "EU Blue Card", "Job Seeker visa"],
        eligibility: ["Recognised qualification relevant to the job offer", "Valid employment contract or job offer (for most categories)", "Proof of sufficient funds (job seeker category)", "Health insurance coverage"],
        processingTime: "Several weeks to a few months depending on the German mission and category (sample)", visaFee: "≈ EUR 75 (sample)", validity: "Matches employment contract / up to 6 months for job seeker visa", entryType: "National visa, convertible to residence permit in Germany",
        embassyName: "German Embassy / Consulate General", embassyPhone: "Via the embassy's online appointment system (sample)", embassyEmail: "Via the embassy's online appointment system",
        appointmentInfo: "Applications are lodged in person at the German Embassy or Consulate after booking an appointment online — early booking is strongly recommended given demand.",
        procedureSteps: ["Confirm your visa category and gather required documents", "Book an appointment at the German Embassy/Consulate", "Attend the appointment and submit your application", "Await processing", "Collect visa and register with local authorities on arrival in Germany"],
        faqs: [
          { q: "Do I need a recognised qualification for a German work visa?", a: "For most skilled worker categories, yes — your foreign qualification typically needs to be recognised as comparable to a German qualification." },
        ],
        importantNotes: ["Appointment slots at German missions can book out weeks in advance — start the process early."],
        travelAdvisory: "Check the latest government travel advisory for Germany before finalising travel plans.",
      },
    ],
  },
];

/*
 * ---------------------------------------------------------------------
 * Scale-up batch: every country explicitly named in the platform spec
 * that didn't already have a hand-authored entry above. These use a
 * shared content factory rather than bespoke prose per country — still
 * genuinely templated per country (name, flag, embassy cities all vary),
 * but the overview/eligibility/FAQ wording is intentionally generic.
 *
 * This is a legitimate way to prove the generator scales, but it is NOT
 * a substitute for real per-country content: templated boilerplate that
 * only swaps the country name is thin content in Google's eyes, and will
 * not rank well long-term. Before publishing any of these, replace the
 * generic paragraphs with country-specific detail the way the Kenya/
 * USA/UK/Australia/Canada/Germany entries above already do.
 * ---------------------------------------------------------------------
 */
function quickTouristVisa(country, flag, countrySlug, opts = {}) {
  return {
    country, flag, slug: countrySlug,
    visaTypes: [
      {
        visaType: opts.visaType || "Tourist Visa",
        visaTypeSlug: opts.visaTypeSlug || "tourist-visa",
        heroSummary: `Everything you need to apply for your ${country} ${(opts.visaType || "Tourist Visa").toLowerCase()} — eligibility, documents, fees, and processing time.`,
        overview: `The ${country} ${opts.visaType || "Tourist Visa"} covers ${opts.purpose || "leisure travel, sightseeing, and visiting friends or family"}. Requirements and application channels vary by nationality — Convercession's consultants confirm the exact process for your passport before you apply.`,
        categories: opts.categories || [`Single-entry ${opts.visaType || "Tourist Visa"}`, `Multiple-entry ${opts.visaType || "Tourist Visa"} (select nationalities)`],
        eligibility: opts.eligibility || [
          "Passport valid for at least 6 months from the date of entry",
          "Proof of return or onward travel",
          "Sufficient funds to cover the stay",
          "No history of visa violations in " + country,
        ],
        processingTime: opts.processingTime || "5–10 business days (sample)",
        visaFee: opts.visaFee || "Varies by nationality (sample — confirm current fee)",
        validity: opts.validity || "Varies by category (sample)",
        entryType: opts.entryType || "Single or multiple entry (sample)",
        embassyName: opts.embassyName || `Embassy / Consulate of ${country}`,
        embassyPhone: "Via official visa application channel (sample)",
        embassyEmail: "Via official visa application channel (sample)",
        appointmentInfo: opts.appointmentInfo || `Application method (online eVisa vs. in-person embassy appointment) depends on your nationality — confirm the current process for ${country} before applying.`,
        procedureSteps: opts.procedureSteps || [
          "Confirm the correct application channel for your nationality",
          "Gather required documents",
          "Submit the application online or at the Visa Application Centre",
          "Pay the applicable visa fee",
          "Track your application and collect your passport once processed",
        ],
        faqs: opts.faqs || [
          { q: `How long does a ${country} visa take to process?`, a: "Processing times vary by nationality and season — confirm current estimates with Convercession before booking non-refundable travel." },
          { q: `Is travel insurance required for ${country}?`, a: "Requirements vary — Convercession recommends travel insurance for every international trip regardless of whether it's mandatory." },
        ],
        importantNotes: opts.importantNotes || ["Visa rules change periodically — always confirm current requirements before booking travel."],
        travelAdvisory: `Check the latest government travel advisory for ${country} before finalising travel plans.`,
      },
      ...(opts.extraVisaTypes || []),
    ],
  };
}

const GENERATED_COUNTRIES = [
  quickTouristVisa("India", "🇮🇳", "india", {
    purpose: "tourism, sightseeing, and visiting family across India",
    extraVisaTypes: [{
      visaType: "Business Visa", visaTypeSlug: "business-visa",
      heroSummary: "India e-Business Visa requirements for meetings, trade fairs, and short-term business travel.",
      overview: "The India Business Visa is for attending meetings, exploring trade opportunities, or recruiting — available as an e-Visa for many nationalities.",
      categories: ["e-Business Visa", "Regular Business Visa (embassy)"],
      eligibility: ["Valid passport", "Business card or proof of business affiliation", "Invitation from an Indian company (for regular visa)"],
      processingTime: "3–5 business days for e-Visa (sample)", visaFee: "Varies by nationality (sample)", validity: "1 year, multiple entry (typical, sample)", entryType: "Multiple entry (typical)",
      embassyName: "Indian Mission / VFS Global centre", appointmentInfo: "Most business e-Visas are processed online without an in-person appointment.",
      procedureSteps: ["Apply via the India e-Visa portal", "Upload passport and business documents", "Pay the fee online", "Receive the e-Visa by email"],
      faqs: [{ q: "Can I do business meetings on an e-Business Visa?", a: "Yes — meetings, trade fairs, and recruitment are permitted; local employment is not." }],
      importantNotes: ["Carry a printed copy of your e-Visa and business invitation while travelling."],
      travelAdvisory: "Check the latest government travel advisory for India before finalising travel plans.",
    }],
  }),
  quickTouristVisa("France", "🇫🇷", "france", {
    purpose: "tourism and short stays within the Schengen Area",
    embassyName: "French Consulate / VFS Global (Schengen Visa)",
    processingTime: "≈ 15 calendar days (Schengen standard, sample)",
    visaFee: "≈ EUR 90 (Schengen visa fee, sample)",
    validity: "Up to 90 days within a 180-day period (Schengen short-stay)",
    faqs: [
      { q: "Does a France Schengen visa let me visit other EU countries?", a: "Yes — a Schengen visa permits travel across the Schengen Area, not just France, within its validity." },
    ],
  }),
  quickTouristVisa("Italy", "🇮🇹", "italy", {
    purpose: "tourism and short stays within the Schengen Area",
    embassyName: "Italian Consulate / VFS Global (Schengen Visa)",
    processingTime: "≈ 15 calendar days (Schengen standard, sample)",
    visaFee: "≈ EUR 90 (Schengen visa fee, sample)",
    validity: "Up to 90 days within a 180-day period (Schengen short-stay)",
  }),
  quickTouristVisa("Japan", "🇯🇵", "japan", {
    purpose: "tourism, sightseeing, and short business visits to Japan",
    processingTime: "5–7 business days (sample)",
    visaFee: "Varies by nationality — often free or low-cost for tourist single-entry (sample)",
    faqs: [
      { q: "Do I need a visa to visit Japan?", a: "It depends on your nationality — some passports enjoy visa-free short stays. Confirm your specific requirement with Convercession." },
    ],
  }),
  quickTouristVisa("South Korea", "🇰🇷", "south-korea", {
    purpose: "tourism and short business visits to South Korea",
    processingTime: "5–10 business days (sample)",
  }),
  quickTouristVisa("United Arab Emirates", "🇦🇪", "united-arab-emirates", {
    purpose: "tourism, shopping, and short leisure visits to the UAE",
    processingTime: "3–5 business days (sample)",
    visaFee: "Varies by duration (30/60/90-day options, sample)",
    extraVisaTypes: [{
      visaType: "Employment / Work Visa", visaTypeSlug: "employment-work-visa",
      heroSummary: "UAE Employment Visa process for employer-sponsored work permits.",
      overview: "The UAE Employment Visa is employer-sponsored — your UAE employer initiates the work permit and entry permit process on your behalf.",
      categories: ["Employer-sponsored Work Visa", "Golden Visa (long-term, for eligible categories)"],
      eligibility: ["Employment offer from a UAE-registered company", "Educational/professional qualifications matching the role", "Medical fitness test (post-arrival)"],
      processingTime: "2–4 weeks (sample)", visaFee: "Typically borne by the employer (sample)", validity: "2–3 years, renewable (typical)", entryType: "Employer-sponsored residence visa",
      embassyName: "Processed via UAE employer + Ministry of Human Resources", appointmentInfo: "Primarily processed by the sponsoring employer through UAE government channels; the employee typically doesn't attend an embassy appointment abroad.",
      procedureSteps: ["Receive a job offer and employment contract", "Employer applies for entry permit", "Travel to the UAE on the entry permit", "Complete medical test and Emirates ID registration", "Residence visa stamped in passport"],
      faqs: [{ q: "Who applies for a UAE work visa — me or my employer?", a: "The UAE employer initiates and largely drives the process; you provide documents and complete in-country steps like the medical test." }],
      importantNotes: ["Keep your employment contract and offer letter accessible — they're required at multiple steps."],
      travelAdvisory: "Check the latest government travel advisory for the UAE before finalising travel plans.",
    }],
  }),
  quickTouristVisa("Saudi Arabia", "🇸🇦", "saudi-arabia", {
    purpose: "tourism and Umrah/religious travel to Saudi Arabia",
    processingTime: "3–5 business days for eVisa (sample)",
    categories: ["Tourist eVisa", "Umrah Visa (religious travel)"],
  }),
  quickTouristVisa("Singapore", "🇸🇬", "singapore", {
    purpose: "tourism, shopping, and short business visits to Singapore",
    processingTime: "3–5 business days (sample)",
  }),
  quickTouristVisa("Malaysia", "🇲🇾", "malaysia", {
    purpose: "tourism and short leisure visits to Malaysia",
    processingTime: "3–5 business days (sample)",
  }),
  quickTouristVisa("Thailand", "🇹🇭", "thailand", {
    purpose: "tourism and short leisure visits to Thailand",
    processingTime: "3–5 business days for eVisa (sample)",
  }),
  quickTouristVisa("China", "🇨🇳", "china", {
    purpose: "tourism, sightseeing, and short business visits to China",
    processingTime: "4–7 business days (sample)",
    eligibility: [
      "Passport valid for at least 6 months with 2 blank pages",
      "Confirmed itinerary (flights + hotel bookings)",
      "Invitation letter (for business visits)",
      "No history of visa violations in China",
    ],
  }),
];

COUNTRIES.push(...GENERATED_COUNTRIES);

module.exports = { COUNTRIES, STANDARD_DOCS, EMBASSY_CITIES, quickTouristVisa };
