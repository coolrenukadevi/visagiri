<?php
declare(strict_types=1);

/**
 * /document-templates/ — generic, fill-in-the-blank document formats
 * (cover letter, NOC, consent letter, etc.). These are standard
 * boilerplate formats any visa consultancy provides — not a claim
 * about any specific country's requirements — so unlike
 * visa_requirements this is real, hand-written content, not something
 * that needs a per-country source before it can go live.
 */

$templateSlug = $segments[1] ?? null;

$templates = [
    'cover-letter' => [
        'label' => 'Cover Letter',
        'summary' => 'A general-purpose cover letter format explaining your purpose of travel — adapt the bracketed sections for your specific trip.',
        'body' => "[Your Full Name]\n[Your Address]\n[Your Passport Number]\n[Date]\n\nTo,\nThe Visa Officer\n[Embassy / Consulate Name]\n[City, Country]\n\nSubject: Cover Letter for [Visa Type] Visa Application\n\nRespected Sir/Madam,\n\nI, [Your Full Name], holder of Indian Passport No. [Passport Number], am submitting this application for a [Visa Type] visa to [Destination Country].\n\nPurpose of Visit: [Describe purpose — tourism, business meeting, family visit, etc.]\nDuration of Stay: [Number of days], from [Start Date] to [End Date]\nAccommodation: [Hotel name / host address, if applicable]\nSponsor of Trip: [Self-funded / Sponsored by — name and relationship, if applicable]\n\nI assure you that I will abide by the visa conditions and return to India before my visa/permitted stay expires. I have enclosed all the required supporting documents for your kind reference.\n\nThank you for considering my application.\n\nYours sincerely,\n[Signature]\n[Your Full Name]",
    ],
    'noc' => [
        'label' => 'No Objection Certificate (NOC)',
        'summary' => 'An employer NOC confirming leave approval — used when your visa category requires proof your employer has no objection to your travel.',
        'body' => "[Company Letterhead]\n\nDate: [Date]\n\nTO WHOMSOEVER IT MAY CONCERN\n\nThis is to certify that Mr./Ms. [Employee Full Name], holding Employee ID [Employee ID], is working with [Company Name] as [Designation] since [Joining Date].\n\nWe have no objection to their travel to [Destination Country] from [Start Date] to [End Date] for the purpose of [Purpose of Travel].\n\nMr./Ms. [Employee Full Name] is granted leave for this period and is expected to resume duties on [Return-to-Work Date]. The company confirms this employee will remain in our service and has no plans to relocate abroad.\n\nThis certificate is issued upon the employee's request for visa application purposes.\n\nFor [Company Name]\n\n[Authorized Signatory Name]\n[Designation]\n[Company Seal/Stamp]\n[Contact Number] | [Email]",
    ],
    'consent-letter-minor' => [
        'label' => 'Consent Letter for Minor Travel',
        'summary' => 'Required when a minor is travelling without one or both parents/guardians.',
        'body' => "TO WHOMSOEVER IT MAY CONCERN\n\nDate: [Date]\n\nI/We, [Father's Full Name] and [Mother's Full Name], parents/legal guardians of [Minor's Full Name], holder of Indian Passport No. [Minor's Passport Number], hereby give our full consent for our child to travel to [Destination Country] from [Start Date] to [End Date].\n\nThe minor will be travelling [with (name, relationship) / unaccompanied / with the following parent only: (name)].\n\nWe confirm that we are aware of and approve this travel and take full responsibility for the arrangements made for our child during this trip.\n\nFather's Name: [Name]        Signature: [Signature]\nMother's Name: [Name]        Signature: [Signature]\n\nAttached: Copy of both parents' ID proof, copy of minor's passport, copy of birth certificate.\n\n[Notarization/attestation, if required by the destination country, should be arranged separately.]",
    ],
    'self-declaration' => [
        'label' => 'Self Declaration',
        'summary' => 'A general self-declaration format for facts not otherwise documented (e.g. relationship, purpose, or financial support).',
        'body' => "SELF DECLARATION\n\nDate: [Date]\n\nI, [Your Full Name], holder of Indian Passport No. [Passport Number], residing at [Your Address], hereby declare that:\n\n1. [Statement 1 — e.g. \"I am travelling to (Country) solely for the purpose of (tourism/business/medical treatment).\"]\n2. [Statement 2 — e.g. \"I will bear all my travel and accommodation expenses myself / I am being sponsored by (name, relationship).\"]\n3. [Statement 3 — e.g. \"I have no criminal record and have not been deported from any country previously.\"]\n4. [Add or remove statements as required by your specific application.]\n\nI declare that the above information is true to the best of my knowledge, and I take full responsibility if any information is found to be false.\n\nSignature: [Signature]\nName: [Your Full Name]\nPlace: [Place]",
    ],
    'sponsor-letter' => [
        'label' => 'Sponsor Letter / Financial Sponsorship Letter',
        'summary' => 'Used when a family member, relative, or organisation is financially sponsoring the applicant\'s trip.',
        'body' => "TO WHOMSOEVER IT MAY CONCERN\n\nDate: [Date]\n\nI, [Sponsor's Full Name], holder of [Sponsor's ID/Passport Number], residing at [Sponsor's Address], hereby declare that I am sponsoring the travel expenses of [Applicant's Full Name], who is my [relationship — e.g. son/daughter/spouse/sibling], for their visit to [Destination Country] from [Start Date] to [End Date].\n\nI confirm that I will bear the cost of [travel / accommodation / daily expenses — specify which], and I am enclosing my financial documents (bank statements, income proof) as evidence of my ability to support this sponsorship.\n\nRelationship Proof Enclosed: [e.g. Birth Certificate / Marriage Certificate]\n\nSponsor's Signature: [Signature]\nSponsor's Name: [Name]\nContact Number: [Number]",
    ],
    'travel-itinerary' => [
        'label' => 'Travel Itinerary Format',
        'summary' => 'A day-by-day itinerary format many embassies request alongside flight and hotel bookings.',
        'body' => "TRAVEL ITINERARY\n\nApplicant Name: [Your Full Name]\nPassport Number: [Passport Number]\nDestination: [Destination Country]\nTravel Dates: [Start Date] to [End Date]\n\n| Date       | City/Location        | Activity/Plan                          | Accommodation           |\n|------------|----------------------|------------------------------------------|--------------------------|\n| [Date 1]   | [City]               | Arrival, check-in                        | [Hotel Name, Address]   |\n| [Date 2]   | [City]               | [Sightseeing / meeting / etc.]           | [Hotel Name, Address]   |\n| [Date 3]   | [City]               | [Activity]                               | [Hotel Name, Address]   |\n| ...        | ...                  | ...                                       | ...                      |\n| [Last Date]| [City]               | Departure                                 | —                        |\n\nReturn Flight: [Flight Number, Date, Time]\n\n[Attach corresponding flight and hotel booking confirmations for each entry above.]",
    ],
];

if ($templateSlug === null) {
    $pageTitle = 'Document Templates - Visagiri';
    $pageDescription = 'Free downloadable formats for cover letters, NOC, consent letters, sponsor letters, self-declarations, and travel itineraries for your visa application.';
    $canonicalUrl = APP_URL . '/document-templates/';
    require __DIR__ . '/../includes/header.php';
    ?>
    <section class="visa-detail">
        <div class="container">
            <ul class="breadcrumb"><li><a href="/">Home</a></li><li>Document Templates</li></ul>
            <div class="visa-detail__header">
                <div>
                    <h1>Document Templates</h1>
                    <p style="margin-top:var(--space-3)">
                        General-purpose formats to help you prepare common supporting documents. These are starting
                        points — always confirm the exact wording and format your specific embassy or consulate
                        requires before submitting. Not sure which documents apply to you first?
                        See <a href="/documentation/">Documentation Assistance</a>.
                    </p>
                </div>
            </div>
            <div class="card-grid">
                <?php foreach ($templates as $slug => $tpl): ?>
                <a href="/document-templates/<?= e($slug) ?>/" class="card service-card">
                    <div class="card-title"><?= e($tpl['label']) ?></div>
                    <p><?= e($tpl['summary']) ?></p>
                </a>
                <?php endforeach; ?>
            </div>
        </div>
    </section>
    <?php
    require __DIR__ . '/../includes/footer.php';
    exit;
}

if (!isset($templates[$templateSlug])) {
    render_not_found("We couldn't find that document template.");
}

$tpl = $templates[$templateSlug];
$pageTitle = "{$tpl['label']} Format - Visagiri";
$pageDescription = $tpl['summary'];
$canonicalUrl = APP_URL . "/document-templates/{$templateSlug}/";
require __DIR__ . '/../includes/header.php';
?>
<section class="visa-detail">
    <div class="container" style="max-width:760px">
        <ul class="breadcrumb">
            <li><a href="/">Home</a></li>
            <li><a href="/document-templates/">Document Templates</a></li>
            <li><?= e($tpl['label']) ?></li>
        </ul>
        <div class="visa-detail__header">
            <div>
                <h1><?= e($tpl['label']) ?></h1>
                <p style="margin-top:var(--space-3)"><?= e($tpl['summary']) ?></p>
            </div>
        </div>
        <div class="card">
            <pre style="white-space:pre-wrap;font-family:inherit;font-size:var(--font-size-sm);line-height:1.7;margin:0"><?= e($tpl['body']) ?></pre>
        </div>
        <div class="button-group" style="margin-top:var(--space-5)">
            <button type="button" class="btn btn-primary" onclick="window.print()">Print / Save as PDF</button>
            <a href="/document-templates/" class="btn btn-outline">All Templates</a>
        </div>
        <p class="visa-detail__verified">This is a general format, not legal advice — always check your specific embassy/consulate's exact requirements before submitting.</p>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
