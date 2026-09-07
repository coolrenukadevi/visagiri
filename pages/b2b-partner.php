<?php
declare(strict_types=1);

/**
 * Public landing page for the standalone B2B Travel Partner Portal
 * (b2b/pages/*, includes/b2b-partner*.php) — a deliberately separate
 * system from /partners/ (the existing referral partner program),
 * built alongside it per explicit instruction rather than merged in.
 */

$pageTitle = 'Partner With Visagiri - B2B Travel Partner Portal';
$pageDescription = 'Grow your visa business with Visagiri: dedicated B2B visa support, competitive partner pricing, real-time application tracking, and a dedicated partner dashboard for travel agencies, tour operators, DMCs and consultants.';
$canonicalUrl = APP_URL . '/b2b-partner/';
$structuredData = [[
    '@context' => 'https://schema.org',
    '@type' => 'BreadcrumbList',
    'itemListElement' => [
        ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => APP_URL . '/'],
        ['@type' => 'ListItem', 'position' => 2, 'name' => 'B2B Travel Partner Portal', 'item' => $canonicalUrl],
    ],
]];
require __DIR__ . '/../includes/header.php';

$benefits = [
    'Dedicated B2B Visa Support' => 'A named point of contact for every case you submit — not a generic support queue.',
    'Competitive Partner Pricing' => 'Service fees calculated against your partner tier, visible on every quotation before you commit.',
    'Multiple Visa Categories' => 'Tourist, business, employment, student, transit, medical, conference and more — one portal for every visa type you handle.',
    'Centralised Enquiry Management' => 'Every applicant, every country, every status — searchable in one place instead of scattered spreadsheets.',
    'Real-Time Application Tracking' => 'The same status pipeline our own consultants use internally, visible on your dashboard the moment it changes.',
    'Document Management' => 'Secure upload for both your business KYC and every applicant document, with verification status on each file.',
    'Dedicated Relationship Support' => 'Your account is reviewed by a real relationship manager, not an automated approval queue.',
    'Priority Processing Assistance' => 'Partner cases are flagged for priority handling wherever the destination authority\'s process allows it.',
    'Digital Quotations' => 'Itemized, downloadable quotations for every enquiry — service fee, government fee, and taxes broken out.',
    'Payment Tracking' => 'See exactly what\'s pending, paid, or refunded against every invoice, without chasing a finance inbox.',
    'Partner Dashboard' => 'One screen for enquiries, documents, payments and messages — built for daily use, not a one-time signup form.',
    'Enquiry History' => 'A permanent, searchable record of every case your business has ever submitted.',
    'Downloadable Documents' => 'Checklists, quotations, invoices and receipts, all downloadable as branded A4 PDFs.',
    'Transparent Status Updates' => 'No status change happens silently — every update reaches your dashboard and inbox.',
];
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:760px;text-align:center">
        <span class="section-eyebrow">B2B Travel Partner Portal</span>
        <h1>Grow Your Visa Business With Visagiri</h1>
        <p>Partner with Visagiri for professional visa processing, document support, transparent tracking and dedicated B2B assistance. Built for travel agencies, tour operators, corporate travel desks, DMCs, and independent visa/immigration consultants who need a reliable processing partner behind their own customer relationships.</p>
        <div style="display:flex;gap:var(--space-3);justify-content:center;flex-wrap:wrap;margin-top:var(--space-5)">
            <a href="/b2b/register/" class="btn btn-primary">Become a Partner</a>
            <a href="/b2b/login/" class="btn btn-outline">Already a Partner? Login</a>
        </div>
        <p style="margin-top:var(--space-5);color:var(--text-muted);font-size:var(--font-size-sm);letter-spacing:0.05em;text-transform:uppercase">Secure &middot; Professional &middot; Transparent &middot; B2B Focused</p>
    </div>
</section>

<section class="section" style="background:var(--bg-alt, #f7f8fa)">
    <div class="container">
        <div class="section-heading">
            <span class="section-eyebrow">Partner Benefits</span>
            <h2>Everything a Growing Travel Business Needs</h2>
        </div>
        <div class="card-grid">
            <?php foreach ($benefits as $title => $desc): ?>
            <div class="card service-card">
                <div class="card-title"><?= e($title) ?></div>
                <p><?= e($desc) ?></p>
            </div>
            <?php endforeach; ?>
        </div>
    </div>
</section>

<section class="section">
    <div class="container" style="max-width:680px;text-align:center">
        <div class="section-heading">
            <span class="section-eyebrow">Get Started</span>
            <h2>Registration Takes About 10 Minutes</h2>
            <p>Business information, an authorized contact with verified email and mobile, your KYC documents, the visa services and destination countries you work in, and billing details — six short steps, saved as you go.</p>
        </div>
        <a href="/b2b/register/" class="btn btn-primary">Become a Partner</a>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
