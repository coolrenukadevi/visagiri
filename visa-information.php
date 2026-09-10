<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';
require __DIR__ . '/includes/db.php';
require __DIR__ . '/includes/seo.php';

$pdo = db();
$view = $_GET['view'] ?? 'hub';

if ($view === 'topic') {
    render_info_topic_view($pdo, $_GET['topic'] ?? '');
} else {
    render_info_hub_view($pdo);
}

function visa_info_topics(): array
{
    return [
        'visa-requirements' => ['title' => 'Visa Requirements', 'summary' => 'What determines the requirements for your visa, and the baseline documents almost every application needs.'],
        'visa-documents' => ['title' => 'Visa Documents', 'summary' => 'A general checklist of documents commonly requested across visa categories, before you check the specifics for your destination.'],
        'visa-checklist' => ['title' => 'Visa Checklist', 'summary' => 'A step-by-step checklist to work through before you submit any visa application.'],
        'visa-fees' => ['title' => 'Visa Fees', 'summary' => 'How visa fees are set, what affects them, and indicative ranges for popular destinations.'],
        'processing-time' => ['title' => 'Processing Time', 'summary' => 'What affects how long a visa takes to process, and how to plan your application timeline.'],
        'visa-appointment' => ['title' => 'Visa Appointment', 'summary' => 'What to expect at a visa or biometric appointment, and how Videshia helps you prepare.'],
        'visa-faqs' => ['title' => 'Visa FAQs', 'summary' => 'Answers to common questions about how the visa process works with Videshia.'],
    ];
}

function render_info_hub_view(PDO $pdo): void
{
    $topics = visa_info_topics();
    $breadcrumbs = [['Home', url('index.php')], ['Visa Information', null]];
    $pageTitle = 'Visa Information — Requirements, Documents, Fees & FAQs | Videshia';
    $pageDescription = 'Everything you need to know before applying for a visa: requirements, documents, checklists, fees, processing time, appointments and FAQs.';
    $schemaBlocks = [breadcrumb_schema($breadcrumbs)];
    require __DIR__ . '/includes/header.php';
    ?>
    <section class="page-hero">
        <div class="container">
            <span class="eyebrow">Visa Information</span>
            <h1>Visa information, explained</h1>
            <p>General guidance on how visa applications work — for exact requirements and fees, always check the specific country and visa type page.</p>
        </div>
    </section>

    <div class="container"><?= render_breadcrumbs($breadcrumbs) ?></div>

    <section class="section">
        <div class="container">
            <div class="grid-3">
                <?php foreach ($topics as $slug => $t): ?>
                <a class="card" href="<?= url('visa-information/' . $slug . '/') ?>" style="display:block;color:inherit">
                    <h3><?= e($t['title']) ?></h3>
                    <p><?= e($t['summary']) ?></p>
                    <span style="color:var(--teal-500);font-weight:600;font-size:13.5px">Read more &rarr;</span>
                </a>
                <?php endforeach; ?>
            </div>
            <p style="text-align:center;margin-top:28px">
                Looking for your destination's exact requirements? <a href="<?= url('visa-by-country/') ?>" style="color:var(--teal-500);font-weight:600">Browse Visa by Country &rarr;</a>
            </p>
        </div>
    </section>
    <?php
    require __DIR__ . '/includes/footer.php';
}

function render_info_topic_view(PDO $pdo, string $slug): void
{
    $topics = visa_info_topics();
    if (!isset($topics[$slug])) {
        http_response_code(404);
        require __DIR__ . '/404.php';
        return;
    }

    $topic = $topics[$slug];
    $breadcrumbs = [['Home', url('index.php')], ['Visa Information', url('visa-information/')], [$topic['title'], null]];
    $pageTitle = $topic['title'] . ' | Videshia Visa Information';
    $pageDescription = $topic['summary'];
    $schemaBlocks = [breadcrumb_schema($breadcrumbs)];

    $topicFaqs = visa_info_topic_faqs($slug);
    if ($topicFaqs) {
        $schemaBlocks[] = faq_schema(array_map(static fn($f) => ['question' => $f[0], 'answer' => $f[1]], $topicFaqs));
    }

    require __DIR__ . '/includes/header.php';
    ?>
    <section class="page-hero">
        <div class="container">
            <span class="eyebrow">Visa Information</span>
            <h1><?= e($topic['title']) ?></h1>
            <p><?= e($topic['summary']) ?></p>
        </div>
    </section>

    <div class="container"><?= render_breadcrumbs($breadcrumbs) ?></div>

    <section class="section">
        <div class="container" style="max-width:800px">
            <?php render_info_topic_body($pdo, $slug); ?>
        </div>
    </section>

    <?php if ($topicFaqs): ?>
    <section class="section section-alt" id="faqs">
        <div class="container" style="max-width:760px">
            <div class="section-head center"><span class="eyebrow">FAQs</span><h2><?= e($topic['title']) ?> FAQs</h2></div>
            <div style="display:flex;flex-direction:column;gap:14px">
                <?php foreach ($topicFaqs as [$q, $a]): ?>
                <div class="card"><h3 style="font-size:15.5px"><?= e($q) ?></h3><p style="margin:0"><?= e($a) ?></p></div>
                <?php endforeach; ?>
            </div>
        </div>
    </section>
    <?php endif; ?>

    <section class="section">
        <div class="container" style="max-width:800px;text-align:center">
            <div class="card card-dark" style="padding:36px">
                <h3>Still not sure what applies to you?</h3>
                <p>Share your destination and purpose of travel — a Videshia consultant will confirm the exact requirements for your case.</p>
                <a href="<?= url('enquiry/') ?>" class="btn btn-primary" style="margin-top:10px">Start Your Visa Enquiry</a>
            </div>
        </div>
    </section>
    <?php
    require __DIR__ . '/includes/footer.php';
}

function render_info_topic_body(PDO $pdo, string $slug): void
{
    switch ($slug) {
        case 'visa-requirements':
            ?>
            <p>Visa requirements are set independently by each destination's government and depend on three things: your nationality, the country you're travelling to, and your purpose of travel (the visa category). There is no single universal checklist — but almost every application is built around the same baseline.</p>
            <h2 style="margin-top:28px">What usually determines your requirements</h2>
            <ul style="display:flex;flex-direction:column;gap:10px;margin-top:14px">
                <?php foreach ([
                    'Your nationality and current country of residence',
                    'The destination country and its bilateral visa policy with India',
                    'Your visa category — tourist, business, employment, family, transit and others each have different rules',
                    'The length and purpose of your intended stay',
                ] as $item): ?>
                <li style="display:flex;gap:10px;font-size:14.5px;color:var(--navy-800)"><svg style="flex-shrink:0;margin-top:3px" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#17c3c9" stroke-width="3"><path d="M4 12l5 5L20 6"/></svg><?= e($item) ?></li>
                <?php endforeach; ?>
            </ul>
            <h2 style="margin-top:28px">Common baseline requirements</h2>
            <p>Most applications, regardless of destination, start with a valid passport, proof of funds, a travel itinerary and category-specific supporting documents. See <a href="<?= url('visa-information/visa-documents/') ?>" style="color:var(--teal-500)">Visa Documents</a> for the full general checklist.</p>
            <p style="margin-top:16px">Because exact requirements vary by country and category, the authoritative source on Videshia is always the specific <a href="<?= url('visa-by-country/') ?>" style="color:var(--teal-500)">country page</a> or <a href="<?= url('visa-services/') ?>" style="color:var(--teal-500)">visa type page</a> — this page is a general starting point, not a substitute for those.</p>
            <?php
            break;

        case 'visa-documents':
            ?>
            <p>Every destination and visa category has its own exact document list — always confirm the specifics on your country's visa page. That said, most applications draw from the same pool of commonly requested documents.</p>
            <h2 style="margin-top:28px">Commonly requested documents</h2>
            <div class="grid-2" style="margin-top:14px">
                <div class="card">
                    <h3 style="font-size:15px">Identity &amp; travel</h3>
                    <ul style="display:flex;flex-direction:column;gap:8px;margin-top:10px">
                        <?php foreach (['Passport valid 6+ months beyond travel, with blank pages', 'Recent passport-size photographs meeting the destination\'s spec', 'Confirmed or tentative flight itinerary', 'Hotel booking or invitation letter, as applicable'] as $d): ?>
                        <li style="font-size:14px;color:var(--navy-800)">&bull; <?= e($d) ?></li>
                        <?php endforeach; ?>
                    </ul>
                </div>
                <div class="card">
                    <h3 style="font-size:15px">Financial &amp; supporting</h3>
                    <ul style="display:flex;flex-direction:column;gap:8px;margin-top:10px">
                        <?php foreach (['Bank statements or proof of funds (typically last 3-6 months)', 'Income proof — salary slips, ITR or business documents', 'Employer NOC or leave letter, for salaried applicants', 'Category-specific documents — invitation letters, admission letters, medical records or event proof'] as $d): ?>
                        <li style="font-size:14px;color:var(--navy-800)">&bull; <?= e($d) ?></li>
                        <?php endforeach; ?>
                    </ul>
                </div>
            </div>
            <p style="margin-top:20px">Document requirements are reviewed for accuracy on each country and visa-type page, alongside processing times and fees. Our consultants confirm your exact document list once you share your destination and purpose of travel.</p>
            <?php
            break;

        case 'visa-checklist':
            $steps = [
                ['Confirm your visa category', 'Match your purpose of travel — tourism, business, work, study, family visit — to the right visa type before you do anything else.'],
                ['Check your passport validity', 'Most destinations require at least 6 months\' validity beyond your travel date, plus blank visa pages.'],
                ['Gather your documents', 'Use the requirements listed on your destination\'s country page as the source of truth, not a generic list.'],
                ['Check the fee and processing time', 'Government fees and processing windows are set by the destination and can change — confirm current figures before you plan your travel dates around them.'],
                ['Book your appointment, if required', 'Many destinations require an in-person or biometric appointment at a visa application centre or embassy.'],
                ['Submit your application', 'Double-check every document against the checklist before submission — incomplete applications are a common cause of delay.'],
                ['Track your application', 'Use your Videshia reference number to check status any time on the Track Application page.'],
            ];
            ?>
            <div style="display:flex;flex-direction:column;gap:16px">
                <?php foreach ($steps as $i => [$title, $desc]): ?>
                <div class="card" style="display:flex;gap:16px;align-items:flex-start">
                    <span style="flex-shrink:0;width:34px;height:34px;border-radius:50%;background:var(--teal-100);color:var(--navy-900);display:flex;align-items:center;justify-content:center;font-weight:700;font-family:var(--font-head)"><?= $i + 1 ?></span>
                    <div><h3 style="font-size:15.5px;margin:0 0 6px"><?= e($title) ?></h3><p style="margin:0"><?= e($desc) ?></p></div>
                </div>
                <?php endforeach; ?>
            </div>
            <p style="margin-top:20px;text-align:center"><a href="<?= url('track-application/') ?>" style="color:var(--teal-500);font-weight:600">Already applied? Track your application &rarr;</a></p>
            <?php
            break;

        case 'visa-fees':
            $feeStmt = $pdo->prepare(
                "SELECT c.name, c.slug, cvc.visa_fee, cvc.processing_time
                 FROM country_visa_categories cvc
                 JOIN countries c ON c.id = cvc.country_id
                 JOIN visa_categories vc ON vc.id = cvc.visa_category_id
                 WHERE vc.slug = 'tourist-visa' AND cvc.indexable = 1
                 ORDER BY c.name LIMIT 8"
            );
            $feeStmt->execute();
            $feeRows = $feeStmt->fetchAll();
            ?>
            <p>Visa fees are set by each destination's government or embassy, not by Videshia — they vary by nationality, visa category and sometimes by season. Fees are typically paid at the time of application or appointment and are generally non-refundable, whatever the outcome.</p>
            <h2 style="margin-top:28px">What affects the fee</h2>
            <ul style="display:flex;flex-direction:column;gap:10px;margin-top:14px">
                <?php foreach (['The destination country and its fee schedule for Indian nationals', 'The visa category — tourist, business and work visas are often priced differently', 'Single-entry vs. multiple-entry validity', 'Service or handling charges where a visa application centre is involved'] as $item): ?>
                <li style="display:flex;gap:10px;font-size:14.5px;color:var(--navy-800)"><svg style="flex-shrink:0;margin-top:3px" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#17c3c9" stroke-width="3"><path d="M4 12l5 5L20 6"/></svg><?= e($item) ?></li>
                <?php endforeach; ?>
            </ul>
            <?php if ($feeRows): ?>
            <h2 style="margin-top:28px">Indicative tourist visa fees</h2>
            <p>Reviewed periodically — always confirm the current figure on the country page before you apply.</p>
            <div class="table-wrap" style="overflow-x:auto;margin-top:14px">
                <table style="width:100%;border-collapse:collapse;font-size:14px">
                    <thead><tr style="text-align:left;border-bottom:1px solid var(--border)"><th style="padding:10px 12px">Destination</th><th style="padding:10px 12px">Indicative Fee</th><th style="padding:10px 12px">Processing Time</th></tr></thead>
                    <tbody>
                        <?php foreach ($feeRows as $r): ?>
                        <tr style="border-bottom:1px solid var(--border)">
                            <td style="padding:10px 12px"><a href="<?= url('visa-by-country/' . $r['slug'] . '/tourist-visa/') ?>" style="color:var(--navy-900);font-weight:600"><?= e($r['name']) ?></a></td>
                            <td style="padding:10px 12px"><?= e($r['visa_fee']) ?></td>
                            <td style="padding:10px 12px"><?= e($r['processing_time']) ?></td>
                        </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
            <p style="margin-top:12px"><a href="<?= url('visa-by-country/') ?>" style="color:var(--teal-500);font-weight:600">See fees for all destinations &rarr;</a></p>
            <?php endif; ?>
            <?php
            break;

        case 'processing-time':
            $timeStmt = $pdo->prepare(
                "SELECT c.name, c.slug, cvc.processing_time
                 FROM country_visa_categories cvc
                 JOIN countries c ON c.id = cvc.country_id
                 JOIN visa_categories vc ON vc.id = cvc.visa_category_id
                 WHERE vc.slug = 'tourist-visa' AND cvc.indexable = 1
                 ORDER BY c.name LIMIT 8"
            );
            $timeStmt->execute();
            $timeRows = $timeStmt->fetchAll();
            ?>
            <p>Processing time is the time a government or embassy takes to decide on a visa application once it's submitted — it does not include the time you spend preparing documents or waiting for an appointment slot.</p>
            <h2 style="margin-top:28px">What affects processing time</h2>
            <ul style="display:flex;flex-direction:column;gap:10px;margin-top:14px">
                <?php foreach (['How complete and accurate your application and documents are', 'Peak season demand at the embassy or visa application centre', 'The visa category — work and long-term visas often take longer than short-term tourist visas', 'Additional checks the embassy may choose to run on individual cases'] as $item): ?>
                <li style="display:flex;gap:10px;font-size:14.5px;color:var(--navy-800)"><svg style="flex-shrink:0;margin-top:3px" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#17c3c9" stroke-width="3"><path d="M4 12l5 5L20 6"/></svg><?= e($item) ?></li>
                <?php endforeach; ?>
            </ul>
            <p style="margin-top:16px"><strong>Our advice:</strong> apply as early as your destination allows, and never book non-refundable travel until your visa is in hand.</p>
            <?php if ($timeRows): ?>
            <h2 style="margin-top:28px">Indicative tourist visa processing times</h2>
            <div class="table-wrap" style="overflow-x:auto;margin-top:14px">
                <table style="width:100%;border-collapse:collapse;font-size:14px">
                    <thead><tr style="text-align:left;border-bottom:1px solid var(--border)"><th style="padding:10px 12px">Destination</th><th style="padding:10px 12px">Processing Time</th></tr></thead>
                    <tbody>
                        <?php foreach ($timeRows as $r): ?>
                        <tr style="border-bottom:1px solid var(--border)">
                            <td style="padding:10px 12px"><a href="<?= url('visa-by-country/' . $r['slug'] . '/tourist-visa/') ?>" style="color:var(--navy-900);font-weight:600"><?= e($r['name']) ?></a></td>
                            <td style="padding:10px 12px"><?= e($r['processing_time']) ?></td>
                        </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
            <?php endif; ?>
            <?php
            break;

        case 'visa-appointment':
            ?>
            <p>Many destinations require an in-person appointment — often for biometric data capture — at a visa application centre, consulate or embassy before your visa can be processed.</p>
            <h2 style="margin-top:28px">What to expect</h2>
            <ul style="display:flex;flex-direction:column;gap:10px;margin-top:14px">
                <?php foreach ([
                    'Appointment slots are booked through the destination\'s official visa application centre or embassy portal',
                    'You\'ll typically submit your physical documents and biometrics (fingerprints and photograph) at this appointment',
                    'Some categories allow document drop-off without an in-person visit — this varies by destination',
                    'Appointment availability can be limited during peak travel seasons, so book as early as your documents allow',
                ] as $item): ?>
                <li style="display:flex;gap:10px;font-size:14.5px;color:var(--navy-800)"><svg style="flex-shrink:0;margin-top:3px" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#17c3c9" stroke-width="3"><path d="M4 12l5 5L20 6"/></svg><?= e($item) ?></li>
                <?php endforeach; ?>
            </ul>
            <h2 style="margin-top:28px">How Videshia helps</h2>
            <p>Our consultants confirm which destinations require an appointment for your visa category, help you prepare a complete document set beforehand, and let you know what to expect on the day — so there are no surprises at the counter.</p>
            <?php
            break;

        case 'visa-faqs':
            ?>
            <p>Below are answers to the questions we hear most often about how the visa process itself works. For destination-specific questions, check the FAQs on your country's visa page.</p>
            <?php
            break;
    }
}

function visa_info_topic_faqs(string $slug): array
{
    $faqs = [
        'visa-requirements' => [
            ['Do visa requirements differ for the same country depending on my visa type?', 'Yes — a tourist visa, business visa and work visa for the same country can have entirely different requirements, validity and processing rules.'],
            ['Can Videshia tell me exactly what I need before I apply?', 'Yes. Share your destination and purpose of travel through our enquiry form and a consultant will confirm your exact requirements.'],
        ],
        'visa-documents' => [
            ['Do I need to get my documents translated or attested?', 'Some destinations and categories require translated or notarised documents — this is confirmed as part of your specific country and category checklist.'],
            ['What if I\'m missing a document from the list?', 'Tell your consultant early — in many cases there are acceptable alternative documents, and it\'s far better to resolve gaps before submission than after.'],
        ],
        'visa-checklist' => [
            ['How early should I start this checklist?', 'As soon as you know your travel dates — some destinations have long appointment wait times, so starting early protects your timeline.'],
            ['Can I skip the appointment step for every country?', 'No — appointment requirements vary by destination and visa category; your country\'s visa page will confirm whether one applies to you.'],
        ],
        'visa-fees' => [
            ['Does Videshia charge on top of the government visa fee?', 'Government visa fees are paid directly as set by the destination. Any service charge for our assistance is discussed and agreed with you upfront before you proceed.'],
            ['Are visa fees refunded if my application is rejected?', 'Government visa fees are governed by that country\'s own policy and are typically non-refundable once submitted, regardless of the outcome.'],
        ],
        'processing-time' => [
            ['Can I pay extra for faster processing?', 'Some destinations offer a premium or expedited service for an additional government fee — this is confirmed on a country-by-country basis, where available.'],
            ['What happens if my documents are incomplete?', 'Incomplete applications are a leading cause of delay or rejection — our document review is designed to catch gaps before you submit.'],
        ],
        'visa-appointment' => [
            ['Can Videshia book my appointment for me?', 'Our consultants guide you through the booking process and let you know the earliest realistic slots for your destination.'],
            ['What should I bring to my appointment?', 'Bring your passport, printed application form and every document on your confirmed checklist — your consultant will give you a final list before the appointment.'],
        ],
        'visa-faqs' => [
            ['How do I know which visa category I need?', 'It depends on your purpose of travel. Share your destination and purpose through our enquiry form and a consultant will confirm the right category.'],
            ['Can Videshia guarantee my visa will be approved?', 'No visa agency can guarantee approval — that decision rests entirely with the embassy or consulate. We help ensure your application is complete and well-documented.'],
            ['How do I check my application status?', 'Use your Videshia reference number (format VDH-YYYY-NNNNNN) on the Track Application page, along with the mobile number or email you applied with.'],
            ['Is my information kept confidential?', 'Yes — see our Privacy Policy for details on how your information and documents are handled.'],
        ],
    ];

    return $faqs[$slug] ?? [];
}
