<?php
declare(strict_types=1);

/**
 * /documentation/ — "Visa & Travel Documentation Assistance". Replaces
 * the dead legacy-site/documentation.html (old Bootstrap template,
 * excluded from every deployment package — see AUDIT.md). No route
 * for documentation content existed anywhere in this app before this.
 *
 * Content here is deliberately general document-preparation guidance
 * (what a category of document is, why embassies ask for it, what to
 * double-check) — the same "real, reusable, not destination-specific"
 * standard already used by document-templates.php, not a claim about
 * any particular country's requirements. Document Translation and
 * Notarization are described only as concepts an applicant may need,
 * never as a Visagiri-provided service — no confirmed offering exists
 * for either, unlike Apostille/Attestation/Legalization (real, already
 * live at /attestation/, linked rather than duplicated here).
 *
 * The "technology-driven" framing in the intro section describes only
 * real, already-shipped platform mechanics (reference-number tracking,
 * access-controlled off-web-root document storage, encrypted PII
 * fields, audit-logged handling, CRM-tracked follow-through) — see
 * includes/documents.php, includes/encryption.php, includes/audit.php.
 * Nothing here claims a public self-upload portal or AI verification,
 * neither of which exist in this project.
 */

$faqs = faqs_general();

$pageTitle = 'Visa & Travel Documentation Assistance | Visagiri';
$pageDescription = 'Understand exactly what documents your visa application needs — passport, financial, employment, sponsorship, student, business and authentication documents — and get a personalised checklist from Visagiri.';
$canonicalUrl = APP_URL . '/documentation/';
$structuredData = [[
    '@context' => 'https://schema.org',
    '@type' => 'BreadcrumbList',
    'itemListElement' => [
        ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => APP_URL . '/'],
        ['@type' => 'ListItem', 'position' => 2, 'name' => 'Documentation Assistance', 'item' => $canonicalUrl],
    ],
]];
require __DIR__ . '/../includes/header.php';

/** @param list<array{title:string,body:string}> $items */
$renderCardGroup = static function (array $items): void {
    foreach ($items as $item) {
        echo '<div class="card service-card"><div class="card-title">' . e($item['title']) . '</div><p>' . e($item['body']) . '</p></div>';
    }
};
?>
<section class="visa-detail">
    <div class="container">
        <ul class="breadcrumb"><li><a href="/">Home</a></li><li>Documentation Assistance</li></ul>

        <div class="visa-detail__header">
            <div>
                <h1>Visa &amp; Travel Documentation Assistance</h1>
                <p style="margin-top:var(--space-3);max-width:70ch">
                    Most visa delays and rejections trace back to the same root cause: a document that was missing,
                    outdated, or in the wrong format. We help you identify exactly what your application needs,
                    prepare it correctly, and keep it tracked end-to-end — from your first enquiry to final submission.
                </p>
                <div class="button-group" style="margin-top:var(--space-4)">
                    <a href="/enquire/" class="btn btn-gold btn-lg">Check My Document Requirements</a>
                    <a href="<?= e(whatsapp_enquiry_href('Hi Visagiri, I need help understanding what documents I need for my visa application.')) ?>" class="btn btn-outline" target="_blank" rel="noopener noreferrer">Ask on WhatsApp</a>
                </div>
            </div>
        </div>

        <h2 class="country-directory__subheading" style="margin-top:var(--space-10)">Why Documentation Matters</h2>
        <p style="max-width:70ch">
            Every visa category has its own document logic, but the underlying test embassies and consulates apply
            is consistent: can you prove who you are, why you're travelling, how you'll support yourself, and that
            you intend to return. Getting each of those right the first time is the single biggest factor in how
            smoothly — and how quickly — your application moves.
        </p>

        <h2 class="country-directory__subheading" style="margin-top:var(--space-10)">How We Keep Your Documentation on Track</h2>
        <div class="card-grid">
            <div class="card feature-card">
                <div class="feature-card__icon">1</div>
                <div class="card-title">Reference-Number Tracking</div>
                <p>Every enquiry and application gets a unique reference number the moment you submit it, so nothing depends on a remembered email thread — check status anytime at <a href="/track-visa/">Track Your Application</a>.</p>
            </div>
            <div class="card feature-card">
                <div class="feature-card__icon">2</div>
                <div class="card-title">Access-Controlled Document Storage</div>
                <p>Documents your consultant collects are kept in access-controlled storage that's never publicly reachable, and are only ever handled by verified Visagiri staff — not left in an open inbox.</p>
            </div>
            <div class="card feature-card">
                <div class="feature-card__icon">3</div>
                <div class="card-title">Encrypted Sensitive Data</div>
                <p>Passport and identity details tied to your file are stored encrypted in our systems, not as plain, searchable text.</p>
            </div>
            <div class="card feature-card">
                <div class="feature-card__icon">4</div>
                <div class="card-title">Audit-Logged Handling</div>
                <p>Every action on your enquiry or application is logged internally, so there's always a clear record of what happened and when — for you and for us.</p>
            </div>
        </div>

        <h2 class="country-directory__subheading" style="margin-top:var(--space-10)">Identity &amp; Travel Documents</h2>
        <div class="card-grid">
            <?php $renderCardGroup([
                ['title' => 'Passport Requirements', 'body' => 'Most destinations require at least 6 months of validity beyond your travel dates and 2+ blank visa pages. We confirm the exact validity and blank-page rule for your destination before you apply.'],
                ['title' => 'Photograph Requirements', 'body' => 'Size, background colour, and how recent the photo must be all vary by destination and visa type — we confirm the exact specification so your photo isn\'t a reason for rejection.'],
                ['title' => 'Travel Itinerary', 'body' => 'A day-by-day plan of where you\'ll be and when — many embassies want this alongside your flight and hotel bookings. See our ready-to-use format.', ],
                ['title' => 'Flight Reservation', 'body' => 'A round-trip flight reservation (not necessarily a paid ticket) confirming your intended travel dates and return.'],
                ['title' => 'Hotel Reservation', 'body' => 'Proof of accommodation for your stay — a confirmed booking, or a formal invitation letter if you\'re staying with a host.'],
                ['title' => 'Travel Insurance', 'body' => 'Required for many destinations (mandatory for the entire Schengen Area) — coverage minimums and validity requirements vary, so we confirm what your destination expects.'],
            ]); ?>
        </div>
        <p style="margin-top:var(--space-4)"><a href="/document-templates/">Browse ready-to-use document formats &rarr;</a></p>

        <h2 class="country-directory__subheading" style="margin-top:var(--space-10)">Financial &amp; Sponsorship Documents</h2>
        <div class="card-grid">
            <?php $renderCardGroup([
                ['title' => 'Financial Documents', 'body' => 'Bank statements, salary slips, or income tax returns proving you can fund your trip. Most consulates want a recent, continuous statement — not a single large deposit right before applying.'],
                ['title' => 'Sponsorship Documents', 'body' => 'If someone else is funding your trip, their financial proof plus a formal sponsor letter and evidence of your relationship are typically required together, not separately.'],
            ]); ?>
        </div>
        <p style="margin-top:var(--space-4)"><a href="/document-templates/sponsor-letter/">Sponsor letter format &rarr;</a></p>

        <h2 class="country-directory__subheading" style="margin-top:var(--space-10)">Employment &amp; Business Documents</h2>
        <div class="card-grid">
            <?php $renderCardGroup([
                ['title' => 'Employment Documents', 'body' => 'An employer NOC or leave-approval letter confirming your job, leave dates, and intent to return to work.'],
                ['title' => 'Invitation Letters', 'body' => 'Required when you\'re visiting a person or organisation abroad — states the host\'s details, your relationship, and the purpose and duration of your visit.'],
                ['title' => 'Cover Letters', 'body' => 'A single letter tying your whole application together — purpose, dates, funding, and accommodation in one place, addressed directly to the visa officer.'],
                ['title' => 'Business Documentation', 'body' => 'For business visas: an invitation from the host company, your own company\'s letter confirming the trip\'s purpose, and often a company registration/incorporation proof.'],
                ['title' => 'Work Visa Documentation', 'body' => 'Typically the most document-heavy category — employment contract, educational and professional certificates, and often police clearance, in addition to standard financial and identity documents.'],
            ]); ?>
        </div>
        <p style="margin-top:var(--space-4)"><a href="/document-templates/cover-letter/">Cover letter format</a> &middot; <a href="/document-templates/noc/">NOC format</a> &middot; <a href="/document-templates/self-declaration/">Self-declaration format</a></p>

        <h2 class="country-directory__subheading" style="margin-top:var(--space-10)">Student &amp; Minor Applicant Documents</h2>
        <div class="card-grid">
            <?php $renderCardGroup([
                ['title' => 'Student Documentation', 'body' => 'Admission/offer letter, proof of tuition and living-cost funding, and academic transcripts — most study-destination consulates want all three together, not the admission letter alone.'],
                ['title' => 'Minor Applicant Documents', 'body' => 'Birth certificate, both parents\' ID, and — critically — a notarised consent letter if the minor is travelling with only one parent or unaccompanied.'],
            ]); ?>
        </div>
        <p style="margin-top:var(--space-4)"><a href="/document-templates/consent-letter-minor/">Minor travel consent letter format &rarr;</a></p>

        <h2 class="country-directory__subheading" style="margin-top:var(--space-10)">Document Authentication</h2>
        <p style="max-width:70ch">
            Some destinations only accept your certificates or personal documents once they've been formally
            authenticated. Depending on the destination, that can mean a certified <strong>translation</strong> into
            the local language, <strong>notarisation</strong> by a notary public, or a full
            <strong>apostille / attestation / legalisation</strong> — Visagiri's dedicated attestation service
            handles that last step for you.
        </p>
        <div class="card-grid">
            <a href="/attestation/" class="card service-card">
                <div class="card-title">Apostille, Attestation &amp; Legalization</div>
                <p>13 real, active services across MEA Apostille, Embassy/Consulate Attestation, and Document Legalization.</p>
            </a>
        </div>

        <?php if ($faqs): ?>
        <div style="margin-top:var(--space-10);max-width:760px">
            <h2 class="country-directory__subheading">Frequently Asked Questions</h2>
            <?php foreach ($faqs as $faq): ?>
            <div class="accordion-item">
                <details>
                    <summary><?= e($faq['question']) ?></summary>
                    <div class="accordion-body"><?= e($faq['answer']) ?></div>
                </details>
            </div>
            <?php endforeach; ?>
        </div>
        <?php endif; ?>

        <div class="final-cta" style="margin-top:var(--space-10)">
            <h2>Not sure which documents apply to you?</h2>
            <p style="color:var(--white);opacity:0.9">Tell us your destination and visa type — we'll confirm your exact document checklist.</p>
            <a href="/enquire/" class="btn btn-gold btn-lg">Check My Document Requirements</a>
        </div>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
