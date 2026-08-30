<?php
/**
 * Content model for every non-country page.
 *
 * One entry = one real, indexable page rendered by page.php. This is what
 * replaces the `todo: true` "#" placeholders in the navigation — the spec's
 * hard rule is that every menu item must resolve to a real page.
 *
 * HONESTY RULES BAKED IN:
 *  - 'needs_input' => [...] renders a visible, clearly-labelled block listing
 *    facts only the company can supply (real leadership names, partner logos,
 *    open roles, registered policy wording). We show the page structure and
 *    say plainly what's outstanding rather than inventing people, partners or
 *    legal terms.
 *  - 'legal' => true adds a review notice. Baseline policy text here is
 *    ordinary, accurate boilerplate for this kind of business; it is NOT a
 *    substitute for a lawyer, and it claims nothing about approvals,
 *    government status or regulatory credentials.
 *  - No page asserts embassy affiliation, approval guarantees or success rates.
 */
declare(strict_types=1);

/** Shared disclosure used across service pages. */
const NOT_A_GOVERNMENT_BODY = 'Convercession is an independent visa management and technology service provider. We are not a government authority, embassy, consulate or visa application centre. Visa decisions are made solely by the relevant government authority.';

function page_definitions(): array
{
    return [

// ─────────────────────────────── CORE ───────────────────────────────
'about' => [
  'nav_group' => 'Company',
  'title' => 'About Convercession — AI-Powered Visa & Global Mobility Platform',
  'h1' => 'About Convercession',
  'lede' => 'Convercession is a visa management and global mobility platform. We combine visa intelligence, document management and application tracking with experienced human consultants.',
  'sections' => [
    ['h2' => 'What we do', 'body' => [
      'Convercession helps individuals, families and businesses understand and manage visa applications. The platform brings together the information you need (requirements, documents, fees, processing times, where to apply) and the workflow around it (document preparation, appointment planning, application tracking).',
      'We are a unit of Tripgation® Private Limited, an established travel management company. Convercession focuses specifically on visa and mobility services rather than general travel booking.',
    ]],
    ['h2' => 'How we work', 'cards' => [
      ['Visa intelligence', 'Requirements, documents, fees and processing information organised per country and visa type, with the source and last-reviewed date shown.'],
      ['Document management', 'A structured checklist per application so nothing is missed, with a place to collect and review documents before submission.'],
      ['Application tracking', 'A clear view of where an application is in the process, and what the next step is.'],
      ['Human consultants', 'Technology handles the repetitive parts. A consultant reviews the application and answers the questions software cannot.'],
    ]],
    ['h2' => 'What we do not do', 'body' => [
      NOT_A_GOVERNMENT_BODY,
      'We do not guarantee visa approval, and we are cautious about publishing figures we cannot substantiate. Where visa information on this site has not yet been verified against an official source, the page says so.',
    ]],
  ],
  'cta' => ['How the platform works', '/technology', 'Talk to a consultant', '/contact'],
],

'contact' => [
  'nav_group' => 'Company',
  'title' => 'Contact Convercession — Visa Consultants',
  'h1' => 'Contact us',
  'lede' => 'Talk to a visa consultant about your application, or send us a question. We respond from our Patna office.',
  'contact_block' => true,
  'sections' => [
    ['h2' => 'Send an enquiry', 'body' => ['Use the form below and a consultant will follow up. Include your destination country and visa type so we can give you a specific answer rather than a generic one.']],
  ],
  'enquiry' => true,
],

'visa-finder' => [
  'nav_group' => 'Core',
  'title' => 'Visa Finder — Check Visa Requirements by Country',
  'h1' => 'Visa Finder',
  'lede' => 'Tell us where you are going and what kind of trip it is. We will take you to the requirements, documents, fees and processing information for that visa.',
  'search_console' => true,
  'sections' => [
    ['h2' => 'How the finder works', 'steps' => [
      ['Choose your destination', 'Pick from 216 countries and territories.'],
      ['Choose your visa type', 'Tourist, business, student, work, family, transit, medical or conference.'],
      ['Review the requirements', 'Documents, eligibility, fees, processing time, where to apply and FAQs — on one page.'],
    ]],
    ['h2' => 'Important', 'body' => ['Visa rules are nationality-specific and change frequently. Always confirm current requirements with the relevant government authority before booking non-refundable travel. ' . NOT_A_GOVERNMENT_BODY]],
  ],
],

'track-visa' => [
  'nav_group' => 'Core',
  'title' => 'Track Your Visa Application',
  'h1' => 'Track your visa application',
  'lede' => 'Check where your application has reached using your Convercession reference number.',
  'track_form' => true,
  'sections' => [
    ['h2' => 'Application stages', 'stages' => [
      'Enquiry received', 'Documents being prepared', 'Document review',
      'Application prepared', 'Appointment booked', 'Submitted to embassy/VAC',
      'In processing', 'Decision received', 'Passport ready', 'Completed',
    ]],
    ['h2' => 'Do not have a reference number?', 'body' => ['A reference number (format VISA-YYYYMMDD-0000) is issued when your enquiry is registered. If you cannot find yours, contact your consultant and we will look it up against your registered email or mobile number.']],
  ],
  'cta' => ['Contact my consultant', '/contact', 'Start a new enquiry', '/visa/request-info'],
],

// ─────────────────────── VISA MANAGEMENT / TECHNOLOGY ───────────────────────
'application-management' => [
  'nav_group' => 'Visa Management',
  'title' => 'Visa Application Management',
  'h1' => 'Visa application management',
  'lede' => 'One place to see every application, what stage it is at, and what is needed next.',
  'sections' => [
    ['h2' => 'What it covers', 'cards' => [
      ['Application record', 'Destination, visa type, applicant, travel date, current stage and assigned consultant in one record.'],
      ['Stage tracking', 'A defined workflow from enquiry through to passport return, so nobody has to ask "where is this?".'],
      ['Task list', 'What the applicant needs to do next, and what we are handling.'],
      ['Document collection', 'Requirements pulled from the relevant country and visa type, tracked as a checklist.'],
    ]],
    ['h2' => 'For families and groups', 'body' => ['Related applications can be grouped so a family or a travelling team is managed together rather than as unconnected cases.']],
  ],
  'cta' => ['Start an application', '/visa/request-info', 'Track an application', '/track-visa'],
],

'document-verification' => [
  'nav_group' => 'Visa Management',
  'title' => 'Visa Document Verification & Checklists',
  'h1' => 'Document verification',
  'lede' => 'A consultant reviews your documents against the destination country requirements before anything is submitted.',
  'sections' => [
    ['h2' => 'What gets checked', 'cards' => [
      ['Completeness', 'Every document on the checklist for that country and visa type is present.'],
      ['Validity dates', 'Passport validity, insurance cover dates and financial statement periods fall inside the required windows.'],
      ['Consistency', 'Names, dates and travel details match across documents — a common cause of avoidable delays.'],
      ['Format', 'Photographs and scans meet the destination\'s specification.'],
    ]],
    ['h2' => 'Where technology helps, and where it does not', 'body' => [
      'Automated checks are good at the mechanical parts: is a document missing, has something expired, do two dates disagree. They are labelled as automated assistance.',
      'Judgement calls — whether a particular financial profile or travel history is likely to satisfy a specific consulate — are made by a consultant, not by software. We do not claim an automated check predicts a visa outcome.',
    ]],
  ],
  'cta' => ['Talk to a consultant', '/contact', 'See document checklists', '/countries'],
],

'visa-status-tracking' => [
  'nav_group' => 'Visa Management',
  'title' => 'Visa Status Tracking & Alerts',
  'h1' => 'Visa status tracking',
  'lede' => 'Know where your application is without having to chase anyone.',
  'sections' => [
    ['h2' => 'How tracking works', 'body' => ['Each application moves through defined stages. When the stage changes, the record updates and you are notified. Where the destination authority publishes its own tracking, we point you to that official source rather than duplicating it.']],
    ['h2' => 'Alerts you can receive', 'cards' => [
      ['Stage changes', 'When your application moves to the next stage.'],
      ['Document reminders', 'When something is missing or about to expire.'],
      ['Appointment reminders', 'Ahead of a biometrics or interview appointment.'],
      ['Decision and collection', 'When a decision is available and when your passport is ready.'],
    ]],
  ],
  'cta' => ['Track my visa', '/track-visa', 'Talk to a consultant', '/contact'],
],

'appointment-management' => [
  'nav_group' => 'Visa Management',
  'title' => 'Visa Appointment & Biometrics Management',
  'h1' => 'Appointment & biometrics management',
  'lede' => 'Help with booking, preparing for and keeping track of embassy, consulate and visa application centre appointments.',
  'sections' => [
    ['h2' => 'What we help with', 'cards' => [
      ['Finding the right centre', 'Which embassy, consulate or VAC handles your application, based on the destination and where you are applying from.'],
      ['Booking guidance', 'How appointment slots are released and booked for that destination, and what you need in hand before booking.'],
      ['Biometrics', 'Whether biometrics are required, where they are collected and what to bring.'],
      ['Interview preparation', 'Where an interview is part of the process, what it typically covers.'],
    ]],
    ['h2' => 'Please note', 'body' => ['Appointment availability is controlled entirely by the relevant embassy, consulate or visa application centre. We help you navigate and prepare for their process — we cannot create, reserve or expedite official appointment slots. ' . NOT_A_GOVERNMENT_BODY]],
  ],
  'cta' => ['Talk to a consultant', '/contact', 'Find embassy details', '/embassies'],
],

'technology' => [
  'nav_group' => 'Company',
  'title' => 'Our Technology — Convercession Visa Platform',
  'h1' => 'Our technology',
  'lede' => 'What the platform actually does, described plainly.',
  'sections' => [
    ['h2' => 'The building blocks', 'cards' => [
      ['Visa knowledge base', 'Structured records per country and visa type: requirements, documents, fees, processing information and where to apply — with the source and last-reviewed date attached.'],
      ['Search and routing', 'Type-ahead search across 216 countries and every visa category, routing you to the right page rather than a list of results.'],
      ['Document checklists', 'Generated from the destination and visa type instead of a generic list, so the checklist matches the application.'],
      ['Application workflow', 'Defined stages, tasks and status tracking behind each application.'],
    ]],
    ['h2' => 'On "AI"', 'body' => [
      'We use the term specifically. Automated assistance means structured guidance generated from our knowledge base — suggested checklists, completeness checks, expiry detection and plain-language answers to common questions.',
      'Anything automated is labelled as automated assistance and is reviewable by a consultant. Automated output does not decide, predict or guarantee a visa outcome, and we do not present it as authoritative where an official source exists.',
    ]],
    ['h2' => 'Data handling', 'body' => ['Passport and supporting documents are sensitive. Documents are transmitted over encrypted connections, access is restricted to the people working on your application, and private documents are never exposed through public or guessable URLs.']],
  ],
  'cta' => ['See the visa finder', '/visa-finder', 'Talk to us', '/contact'],
],

'ai-visa-assistant' => [
  'nav_group' => 'Technology',
  'title' => 'AI Visa Assistant — Guided Visa Answers',
  'h1' => 'AI visa assistant',
  'lede' => 'Ask a visa question in plain language and get a structured answer drawn from our visa knowledge base.',
  'status_note' => 'The assistant is being rolled out. Until it is live on this page, send your question to a consultant and you will get a written answer.',
  'sections' => [
    ['h2' => 'What it can answer', 'cards' => [
      ['Requirements', 'What a given country requires for a given visa type.'],
      ['Documents', 'What belongs in your application and what each document is for.'],
      ['Process', 'How the application, appointment and biometrics steps fit together.'],
      ['Status meaning', 'What a particular application stage actually means.'],
    ]],
    ['h2' => 'Limits we hold ourselves to', 'body' => [
      'Answers are grounded in our visa knowledge base and point to the official source where one exists. Where we cannot verify something, the assistant says so instead of guessing.',
      'The assistant will not tell you whether your visa will be approved. It does not assess your personal likelihood of success, and its guidance may require confirmation by a consultant or the relevant authority.',
    ]],
  ],
  'cta' => ['Ask a consultant', '/contact', 'How the platform works', '/technology'],
],

// ─────────────────────────── GLOBAL MOBILITY ───────────────────────────
'global-mobility' => [
  'nav_group' => 'Global Mobility',
  'title' => 'Global Mobility Services for Businesses',
  'h1' => 'Global mobility',
  'lede' => 'Visa and mobility support for organisations moving people across borders — for meetings, projects, postings and relocations.',
  'sections' => [
    ['h2' => 'Where we help', 'cards' => [
      ['Business travel', 'Short-term business visas for meetings, conferences, negotiations and site visits.'],
      ['Project and assignment travel', 'Work permits and employment visas for staff on overseas assignments.'],
      ['Group movements', 'Teams travelling together for an event, a project or a relocation.'],
      ['Renewals and extensions', 'Tracking expiry dates and managing renewals before they become urgent.'],
    ]],
    ['h2' => 'How a company works with us', 'steps' => [
      ['Tell us the movement', 'Destination, purpose, dates and how many people.'],
      ['We map the requirements', 'Which visa category applies, what each traveller needs, and how long it typically takes.'],
      ['We manage the applications', 'Documents collected and reviewed, appointments planned, applications tracked to conclusion.'],
    ]],
  ],
  'cta' => ['Talk to our corporate team', '/contact', 'Corporate visa management', '/corporate-visa-management'],
],

'corporate-visa-management' => [
  'nav_group' => 'Global Mobility',
  'title' => 'Corporate Visa Management',
  'h1' => 'Corporate visa management',
  'lede' => 'A managed service for organisations with recurring visa needs, rather than one-off applications.',
  'sections' => [
    ['h2' => 'What a managed account includes', 'cards' => [
      ['Single point of contact', 'A named consultant who knows your travel patterns and destinations.'],
      ['Employee records', 'Passport and visa validity tracked per employee so expiries are seen coming.'],
      ['Consolidated visibility', 'All live applications across the organisation in one view.'],
      ['Consolidated billing', 'One invoice rather than per-application payments.'],
    ]],
    ['h2' => 'Roles and access', 'body' => ['Different people need different visibility: an HR or mobility manager overseeing all cases, a travel desk booking around visa timelines, and employees seeing only their own application. Access is scoped accordingly, so personal documents are not visible organisation-wide by default.']],
  ],
  'cta' => ['Discuss a corporate account', '/contact', 'Group applications', '/group-visa-management'],
],

'group-visa-management' => [
  'nav_group' => 'Global Mobility',
  'title' => 'Group & Family Visa Applications',
  'h1' => 'Group & family applications',
  'lede' => 'Applications for several people travelling together, managed as one case rather than separate ones.',
  'sections' => [
    ['h2' => 'Typical groups', 'cards' => [
      ['Families', 'Parents and children, or a family visiting relatives abroad.'],
      ['Corporate teams', 'Colleagues travelling to the same event or project.'],
      ['Conference delegations', 'Groups attending the same conference or exhibition.'],
      ['Tour groups', 'Organised leisure groups travelling on a shared itinerary.'],
    ]],
    ['h2' => 'Why group handling matters', 'body' => ['Group applications share an itinerary and often a sponsor or invitation, but each traveller still needs their own complete document set. Managing them together keeps shared documents consistent and makes it obvious which individual is holding the group up.']],
  ],
  'cta' => ['Start a group enquiry', '/visa/request-info', 'Talk to a consultant', '/contact'],
],

'employee-immigration' => [
  'nav_group' => 'Global Mobility',
  'title' => 'Employee Immigration & Work Visa Support',
  'h1' => 'Employee immigration',
  'lede' => 'Support for employers moving staff into roles abroad, and for the employees making the move.',
  'sections' => [
    ['h2' => 'What we support', 'cards' => [
      ['Work visa applications', 'Employer-sponsored and skilled-worker categories, depending on the destination.'],
      ['Dependent visas', 'Applications for a spouse and children travelling with the employee.'],
      ['Document preparation', 'Employment contracts, qualification evidence and sponsorship documents assembled correctly.'],
      ['Renewals', 'Tracking permit validity and starting renewals with time to spare.'],
    ]],
    ['h2' => 'A realistic note on timelines', 'body' => ['Employment visa categories are usually the slowest and most document-heavy route, and requirements differ substantially between countries. We will give you a realistic timeline for the specific destination rather than an optimistic general one — and we will tell you when a destination\'s current processing times make a planned start date unrealistic.']],
  ],
  'cta' => ['Discuss a relocation', '/contact', 'Browse country requirements', '/countries'],
],

'business-travel-compliance' => [
  'nav_group' => 'Global Mobility',
  'title' => 'Business Travel Compliance',
  'h1' => 'Business travel compliance',
  'lede' => 'Keeping frequent business travel inside the rules of the visa the traveller actually holds.',
  'sections' => [
    ['h2' => 'Common risk areas', 'cards' => [
      ['Wrong visa category', 'Doing work that the business visa held does not permit.'],
      ['Stay limits', 'Exceeding permitted days, including cumulative limits across multiple trips.'],
      ['Expiry timing', 'Passport or visa validity running out mid-trip.'],
      ['Documentation at the border', 'Arriving without the invitation or supporting documents the category assumes.'],
    ]],
    ['h2' => 'How we help', 'body' => ['We map each planned trip to the right visa category before travel, track validity and stay limits across trips, and flag when a traveller is approaching a limit. This is practical guidance on visa categories and conditions — it is not legal or immigration-law advice, and for complex cases we will tell you to take specialist legal advice.']],
  ],
  'cta' => ['Talk to our corporate team', '/contact', 'Global mobility overview', '/global-mobility'],
],

// ─────────────────────────────── RESOURCES ───────────────────────────────
'embassies' => [
  'nav_group' => 'Resources',
  'title' => 'Embassy, Consulate & Visa Application Centre Information',
  'h1' => 'Embassy & consulate information',
  'lede' => 'Where visa applications are submitted, by destination country and the city you are applying from.',
  'directory' => 'embassies',
  'sections' => [
    ['h2' => 'How to find your submission location', 'body' => ['Open the country you are travelling to and look at the "Embassy / Consulate Details" and "Visa Application Centres" sections of that guide. Which location handles your application usually depends on where you live, not on which centre is most convenient.']],
    ['h2' => 'A caution about contact details', 'body' => ['Embassy addresses, phone numbers, opening hours and appointment systems change, and unofficial listings go stale quickly. Always confirm details against the mission\'s own official website before travelling to a location or relying on a phone number. Where we have not verified a detail, the page says so rather than presenting it as confirmed.']],
  ],
  'cta' => ['Browse countries', '/countries', 'Ask a consultant', '/contact'],
],

'visa-requirements' => [
  'nav_group' => 'Resources',
  'title' => 'Visa Requirements by Country',
  'h1' => 'Visa requirements',
  'lede' => 'Requirements, eligibility and documents for 216 countries and territories.',
  'directory' => 'countries',
  'sections' => [
    ['h2' => 'Requirements depend on your nationality', 'body' => ['The same destination treats different passports differently — the visa one nationality needs may not be required for another, and the documents can differ too. Use the guides as a starting point and confirm the requirement for your specific passport before you book.']],
  ],
],

'visa-fees' => [
  'nav_group' => 'Resources',
  'title' => 'Visa Fees by Country',
  'h1' => 'Visa fees',
  'lede' => 'Government and service fee information per destination, alongside what each charge covers.',
  'directory' => 'countries',
  'sections' => [
    ['h2' => 'What makes up the total cost', 'cards' => [
      ['Government visa fee', 'Paid to the destination authority. Set by them and non-refundable in most cases, including refusals.'],
      ['Visa application centre fee', 'Charged by the centre handling submission and biometrics, where one is used.'],
      ['Convercession service charge', 'Our fee for managing the application. Separate from the above and shown before you commit.'],
      ['Optional extras', 'Courier, photographs, insurance or translations where required.'],
    ]],
    ['h2' => 'Currency', 'body' => ['Government fees are usually set in the destination\'s currency or in USD/EUR, so the amount in rupees moves with the exchange rate. The live rates shown above the footer are indicative — confirm the amount with your bank or card issuer at the time you pay.']],
  ],
  'cta' => ['See our payment methods', '/payments', 'Browse countries', '/countries'],
],

'processing-times' => [
  'nav_group' => 'Resources',
  'title' => 'Visa Processing Times by Country',
  'h1' => 'Visa processing times',
  'lede' => 'Indicative processing information per destination, and why it varies.',
  'directory' => 'countries',
  'sections' => [
    ['h2' => 'Why processing time is never a fixed number', 'body' => [
      'Processing time is controlled by the destination authority, not by us or by any agent. It moves with application volume, season, staffing, your nationality, the visa category and whether your case needs extra checks.',
      'Anyone offering a guaranteed processing time for a standard visa is over-promising. Plan against the slower end of the published range, and avoid non-refundable bookings until you have a decision.',
    ]],
    ['h2' => 'Planning guidance', 'cards' => [
      ['Start early', 'Begin as soon as your travel is firm — appointment slots are often the real bottleneck, not the decision itself.'],
      ['Check peak periods', 'Summer, festive periods and academic intake months are consistently slower.'],
      ['Keep documents current', 'A document that expires mid-process restarts part of the work.'],
      ['Book refundable where possible', 'Until the visa is issued, keep flexibility in flights and accommodation.'],
    ]],
  ],
  'cta' => ['Check a country', '/countries', 'Talk to a consultant', '/contact'],
],

'visa-guides' => [
  'nav_group' => 'Resources',
  'title' => 'Visa Guides & How-To Articles',
  'h1' => 'Visa guides',
  'lede' => 'Practical guidance on preparing an application properly.',
  'guide_list' => true,
  'sections' => [],
  'cta' => ['Browse country guides', '/countries', 'Ask a question', '/contact'],
],

'visa-rejection-guide' => [
  'nav_group' => 'Resources',
  'title' => 'Visa Refusal — Common Reasons & What To Do Next',
  'h1' => 'Visa refusal guide',
  'lede' => 'Why applications are commonly refused, and the sensible next steps if yours is.',
  'sections' => [
    ['h2' => 'Frequently cited reasons', 'cards' => [
      ['Incomplete documentation', 'A required document missing, unsigned, untranslated or outside its validity window.'],
      ['Insufficient evidence of funds', 'Financial evidence that does not cover the trip, or that cannot be explained.'],
      ['Weak ties to home country', 'Not enough evidence the applicant intends to return — a common ground in visitor categories.'],
      ['Inconsistent information', 'Details that disagree across the form, the documents and any interview.'],
      ['Unclear purpose of travel', 'An itinerary or explanation that does not hold together.'],
      ['Previous immigration history', 'Earlier overstays, refusals or violations that were not addressed.'],
    ]],
    ['h2' => 'If you are refused', 'steps' => [
      ['Read the refusal notice carefully', 'It normally states the ground relied on. That ground determines what you do next.'],
      ['Do not immediately re-apply unchanged', 'Re-submitting the same application usually produces the same outcome and costs another fee.'],
      ['Fix the actual gap', 'Address the specific ground — better evidence, a clearer explanation, or a different visa category if the one chosen was wrong.'],
      ['Check appeal or review rights', 'Some countries and categories allow an appeal or administrative review within a fixed deadline; many do not.'],
    ]],
    ['h2' => 'An honest caveat', 'body' => ['A consulate is not obliged to explain its reasoning in detail, and two similar applications can be decided differently. Nobody can promise a refusal will be overturned, and you should be sceptical of anyone who does.']],
  ],
  'cta' => ['Talk through a refusal', '/contact', 'Review requirements', '/countries'],
],

'travel-advisories' => [
  'nav_group' => 'Resources',
  'title' => 'Travel Advisories',
  'h1' => 'Travel advisories',
  'lede' => 'Safety, health and entry advisories affecting travel — and where to read the authoritative version.',
  'sections' => [
    ['h2' => 'Always use an official source', 'body' => [
      'Advisories change quickly and carry real consequences for safety and insurance validity. We deliberately do not republish advisory text here, because a cached copy of a safety advisory is worse than no copy at all.',
      'Check the advisory issued by your own government for the country you are travelling to, plus the destination\'s own entry and health requirements, close to your departure date.',
    ]],
    ['h2' => 'What to check before you travel', 'cards' => [
      ['Your government\'s advisory', 'The security and safety guidance issued to citizens of your country.'],
      ['Destination entry rules', 'Current entry, health and documentation requirements at the border.'],
      ['Health requirements', 'Vaccination or health certificate requirements for that destination.'],
      ['Insurance validity', 'Whether your travel insurance remains valid given the current advisory level.'],
    ]],
  ],
  'cta' => ['Check country guides', '/countries', 'Ask a consultant', '/contact'],
],

'visa-news' => [
  'nav_group' => 'Resources',
  'title' => 'Visa News & Policy Updates',
  'h1' => 'Visa news & updates',
  'lede' => 'Changes to visa rules, fees and processes that affect applicants.',
  'needs_input' => [
    'Published news items — this page is built and ready, but we have not written articles on your behalf. Visa policy reporting has to be sourced and dated accurately; inventing news items would be actively harmful.',
    'Editorial owner and publishing cadence.',
  ],
  'sections' => [
    ['h2' => 'What belongs here', 'body' => ['Rule changes, fee revisions, new eVisa systems, appointment or processing changes, and mission-specific notices — each dated, attributed to its official source and linked to the country guides it affects.']],
  ],
  'cta' => ['Browse country guides', '/countries', 'Ask about a change', '/contact'],
],

'visa-faqs' => [
  'nav_group' => 'Resources',
  'title' => 'Visa FAQs — Common Questions Answered',
  'h1' => 'Frequently asked questions',
  'lede' => 'General questions about visas and about working with Convercession.',
  'faqs' => [
    ['Do you guarantee my visa will be approved?', 'No. Visa decisions are made solely by the relevant government authority. We help you submit a complete, accurate, well-prepared application — that is what we can influence. Be cautious of anyone who guarantees approval.'],
    ['Are you a government body or an embassy?', NOT_A_GOVERNMENT_BODY],
    ['How long does a visa take?', 'It depends on the destination, your nationality, the visa category and the time of year. Each country guide shows indicative processing information. Treat it as a planning range, not a promise, and avoid non-refundable bookings until you have a decision.'],
    ['What does it cost?', 'There are usually three separate charges: the government visa fee, any visa application centre fee, and our service charge. See the visa fees page for what each covers.'],
    ['Do I need to apply in person?', 'It varies. Some destinations run fully online eVisa systems; others require biometrics or an interview in person at an embassy, consulate or visa application centre. The country guide for your destination sets this out.'],
    ['Can I apply if my passport expires soon?', 'Most destinations require validity beyond your intended departure — commonly six months. If your passport is close to expiry, renew it first; applying on a nearly-expired passport usually causes problems.'],
    ['What happens if I am refused?', 'Read the ground given, fix that specific issue, and only then consider re-applying or appealing where that right exists. Our refusal guide covers this in more detail.'],
    ['Is my passport information secure?', 'Documents are transmitted over encrypted connections, access is limited to the people working on your application, and private documents are never exposed through public or guessable URLs.'],
  ],
  'cta' => ['Ask something else', '/contact', 'Find your visa', '/visa-finder'],
],

// ─────────────────────────────── COMPANY ───────────────────────────────
'leadership' => [
  'nav_group' => 'Company',
  'title' => 'Leadership — Convercession',
  'h1' => 'Leadership',
  'lede' => 'The people responsible for Convercession.',
  'needs_input' => [
    'Names, roles and short biographies of the leadership team.',
    'Photographs (optional) and any professional profile links.',
    'Confirmation of which Tripgation® Private Limited directors should be shown here.',
  ],
  'needs_input_reason' => 'We have deliberately not written biographies. Inventing named executives for a real registered company would be fabrication, and it is the kind of detail visitors and partners verify.',
  'cta' => ['Contact us', '/contact', 'About Convercession', '/about'],
],

'partners' => [
  'nav_group' => 'Company',
  'title' => 'Partners — Convercession',
  'h1' => 'Partners',
  'lede' => 'Organisations we work with.',
  'needs_input' => [
    'List of partner organisations, with written permission to display each name or logo.',
    'The nature of each relationship (technology, referral, service delivery).',
  ],
  'needs_input_reason' => 'Partner and accreditation claims are exactly the kind of thing that must be true and permitted. We have not listed any organisation you have not confirmed.',
  'cta' => ['Discuss a partnership', '/contact', 'About Convercession', '/about'],
],

'global-network' => [
  'nav_group' => 'Company',
  'title' => 'Global Network — Convercession',
  'h1' => 'Global network',
  'lede' => 'Where we operate from, and the destinations we support.',
  'sections' => [
    ['h2' => 'Our office', 'office_block' => true],
    ['h2' => 'Destinations we cover', 'body' => ['We provide visa guidance for 216 countries and territories, with applications typically submitted through embassies, consulates and visa application centres in Delhi, Mumbai, Chennai, Kolkata, Hyderabad, Bengaluru, Ahmedabad, Kochi, Chandigarh, Pune, Jaipur and Lucknow.']],
  ],
  'needs_input' => ['Any additional offices or representative locations to list. We show only the Patna office confirmed in your existing company details — listing international offices that do not exist is a common and damaging piece of template filler.'],
  'cta' => ['Browse all countries', '/countries', 'Contact us', '/contact'],
],

'careers' => [
  'nav_group' => 'Company',
  'title' => 'Careers at Convercession',
  'h1' => 'Careers',
  'lede' => 'Work with us on visa and global mobility technology.',
  'needs_input' => [
    'Current open roles, with location and employment type.',
    'The email address or applicant system that applications should go to.',
  ],
  'needs_input_reason' => 'We have not invented job openings. Advertising roles that do not exist wastes applicants\' time and damages trust.',
  'sections' => [
    ['h2' => 'Speculative applications', 'body' => ['If nothing is listed and you think you would be a good fit, write to us with your CV and what you would want to work on.']],
  ],
  'cta' => ['Send a CV', '/contact', 'About Convercession', '/about'],
],

// ─────────────────────────────── LEGAL ───────────────────────────────
'privacy-policy' => [
  'nav_group' => 'Legal', 'legal' => true,
  'title' => 'Privacy Policy — Convercession',
  'h1' => 'Privacy policy',
  'lede' => 'How we collect, use and protect your personal information.',
  'sections' => [
    ['h2' => 'Information we collect', 'body' => ['Contact details you give us (name, email, phone, nationality, country of residence), travel details relevant to your application (destination, visa type, dates, number of travellers), documents you upload for your application, and basic technical information such as IP address and browser type recorded when you use the site.']],
    ['h2' => 'How we use it', 'body' => ['To respond to your enquiry, prepare and manage your visa application, communicate with you about its progress, meet our record-keeping obligations, and improve our service. We do not sell your personal information.']],
    ['h2' => 'Sharing', 'body' => ['Where your application requires it, information and documents are shared with the relevant embassy, consulate or visa application centre. We may use service providers (for example email, hosting or payment processing) who handle data on our behalf under contract.']],
    ['h2' => 'Document security', 'body' => ['Passport and supporting documents are treated as sensitive. They are transmitted over encrypted connections, stored with restricted access, and are never made available through public or guessable URLs.']],
    ['h2' => 'Retention', 'body' => ['We keep application records for as long as needed to provide the service and to meet legal and accounting obligations, after which they are deleted or anonymised.']],
    ['h2' => 'Your rights', 'body' => ['You can ask what personal data we hold about you, ask us to correct it, or ask us to delete it where we are not required to keep it. Contact us using the details on this site.']],
  ],
  'needs_input' => ['Data retention periods to state specifically.', 'Named data protection contact.', 'Confirmation of the third-party processors actually in use (email provider, hosting, payment gateway, analytics).'],
],

'terms' => [
  'nav_group' => 'Legal', 'legal' => true,
  'title' => 'Terms & Conditions — Convercession',
  'h1' => 'Terms & conditions',
  'lede' => 'The terms on which we provide visa management services.',
  'sections' => [
    ['h2' => 'Our role', 'body' => [NOT_A_GOVERNMENT_BODY, 'We provide information, document preparation, application management and support services. We do not decide visa applications and cannot influence a decision.']],
    ['h2' => 'No guarantee of outcome', 'body' => ['We do not guarantee that any visa will be granted, or that it will be granted within any particular period. Fees for our services are for the work performed and are not contingent on the outcome of the application.']],
    ['h2' => 'Your responsibilities', 'body' => ['You are responsible for the accuracy and completeness of the information and documents you give us. Providing false or misleading information to an immigration authority is a serious matter and can result in refusal or a future ban.']],
    ['h2' => 'Fees', 'body' => ['Our service charge is separate from government visa fees and any visa application centre charges. Government fees are set by the relevant authority and are generally non-refundable, including where an application is refused.']],
    ['h2' => 'Information on this site', 'body' => ['Visa information published here is provided in good faith for general guidance. Requirements change frequently and are nationality-specific. Confirm current requirements with the relevant authority before relying on them or making non-refundable bookings.']],
  ],
  'needs_input' => ['Governing law and jurisdiction clause.', 'Limitation of liability wording appropriate to your insurance and risk position.', 'Cancellation and termination terms.'],
],

'refund-policy' => [
  'nav_group' => 'Legal', 'legal' => true,
  'title' => 'Refund Policy — Convercession',
  'h1' => 'Refund policy',
  'lede' => 'When our service charges can and cannot be refunded.',
  'sections' => [
    ['h2' => 'Government and centre fees', 'body' => ['Visa fees paid to a government authority, and fees paid to a visa application centre, are outside our control. These are generally non-refundable once an application is submitted — including if the application is refused. We cannot refund money we have not received.']],
    ['h2' => 'Our service charge', 'body' => ['Our charge covers the work of preparing and managing your application. Where we have not yet begun that work, a refund is normally possible. Once documents have been reviewed and the application prepared, the work has been performed and the charge is generally not refundable.']],
    ['h2' => 'Refusals', 'body' => ['A refusal is not in itself a ground for refund of our service charge, because the charge is for the service performed rather than for a particular outcome.']],
    ['h2' => 'How to request a refund', 'body' => ['Contact your consultant with your reference number and the reason for the request.']],
  ],
  'needs_input' => ['Exact refund percentages by stage.', 'Processing time for approved refunds.', 'Whether payment-gateway charges are deducted.'],
],

'cookie-policy' => [
  'nav_group' => 'Legal', 'legal' => true,
  'title' => 'Cookie Policy — Convercession',
  'h1' => 'Cookie policy',
  'lede' => 'How this site uses cookies and similar storage.',
  'sections' => [
    ['h2' => 'What we currently use', 'body' => ['This site uses your browser\'s local storage to remember pages you have recently viewed and pages you have saved, so those features work when you return. That information stays in your browser and is not transmitted to us.']],
    ['h2' => 'Analytics and third-party cookies', 'body' => ['If analytics or marketing tags are added to the site, they will be described here, and consent will be requested where the applicable law requires it.']],
    ['h2' => 'Controlling cookies', 'body' => ['You can clear or block cookies and local storage in your browser settings. Doing so may reset the recently-viewed and saved-page features.']],
  ],
  'needs_input' => ['Confirmation of which analytics/marketing tools will be enabled (e.g. Google Analytics 4, Tag Manager, advertising pixels), so each can be listed with its purpose and retention.'],
],

'disclaimer' => [
  'nav_group' => 'Legal', 'legal' => true,
  'title' => 'Disclaimer — Convercession',
  'h1' => 'Disclaimer',
  'lede' => 'The basis on which information on this website is provided.',
  'sections' => [
    ['h2' => 'General information only', 'body' => ['Visa information on this website is general guidance, not legal or immigration advice. It is not tailored to your circumstances and may not reflect the most recent rule changes.']],
    ['h2' => 'Verify before you rely on it', 'body' => ['Visa requirements are nationality-specific and change frequently, sometimes without notice. Always confirm current requirements with the relevant embassy, consulate or immigration authority before applying or making non-refundable bookings. Where a page on this site carries a notice that its content has not been verified against an official source, treat it as illustrative only.']],
    ['h2' => 'No affiliation with government bodies', 'body' => [NOT_A_GOVERNMENT_BODY]],
    ['h2' => 'External links', 'body' => ['Where we link to official government or embassy websites, we do not control that content and are not responsible for it.']],
  ],
],

'service-agreement' => [
  'nav_group' => 'Legal', 'legal' => true,
  'title' => 'Service Agreement — Convercession',
  'h1' => 'Service agreement',
  'lede' => 'What we will do, and what we need from you, on an engaged application.',
  'sections' => [
    ['h2' => 'Our commitments', 'body' => ['Advise on the appropriate visa category for your stated purpose; provide a document checklist for your destination and category; review the documents you supply and flag gaps; prepare and manage the application; keep you informed of its status; and be available to answer questions through your consultant.']],
    ['h2' => 'What we need from you', 'body' => ['Accurate and complete information; genuine, valid documents supplied in reasonable time; prompt responses when something is needed; and attendance at any appointment or interview the authority requires.']],
    ['h2' => 'Limits of the engagement', 'body' => ['We cannot influence the decision, create or expedite official appointment slots, or shorten an authority\'s processing time. Where a destination\'s rules make your plan unrealistic, we will tell you rather than proceed regardless.']],
  ],
  'needs_input' => ['Signature/acceptance mechanism.', 'Service levels and response times you want to commit to contractually.'],
],

'accessibility' => [
  'nav_group' => 'Legal',
  'title' => 'Accessibility — Convercession',
  'h1' => 'Accessibility',
  'lede' => 'Our approach to making this site usable for everyone.',
  'sections' => [
    ['h2' => 'What we have built in', 'cards' => [
      ['Keyboard navigation', 'Menus, search, tabs and forms can be operated without a mouse, with a visible focus indicator.'],
      ['Semantic structure', 'Proper heading order, landmarks and labelled form fields so screen readers can navigate the page.'],
      ['Contrast', 'Text and interface colours chosen to remain readable, in both light and dark display modes.'],
      ['Reduced motion', 'Animation is minimal and respects the operating system\'s reduced-motion setting.'],
      ['Responsive layout', 'Pages work from small phones up to large desktops without horizontal scrolling.'],
      ['Text alternatives', 'Meaningful images carry alternative text; decorative graphics are hidden from assistive technology.'],
    ]],
    ['h2' => 'Known limitations', 'body' => ['We have not yet completed a formal WCAG 2.1 AA audit by an external assessor, so we are not claiming a conformance level we have not had verified.']],
    ['h2' => 'Tell us about a problem', 'body' => ['If something on this site is difficult to use with assistive technology, contact us and describe what you were trying to do. We will fix it and tell you when it is done.']],
  ],
  'cta' => ['Report an accessibility issue', '/contact', '', ''],
],

    ];
}
