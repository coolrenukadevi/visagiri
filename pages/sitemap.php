<?php
declare(strict_types=1);

/**
 * Human-readable sitemap. Every link here is checked against the real
 * route list in public/index.php before being added — no fabricated
 * routes (e.g. no standalone "Travel Services" landing page exists,
 * so that category links to the real travel-terms/forex-tracking/
 * contact-selector routes that do exist, not an invented page).
 * Country/visa-type detail pages are omitted here since they're
 * already discoverable from /countries/ and /visa-type/, and listing
 * every combination would duplicate the XML sitemap's job.
 */

// Pulled from the real visa_types table rather than hardcoded — a
// hardcoded copy of this list had already fallen out of sync with the
// DB once before (missing Medical/Conference/Sports Visa).
$visaServiceSection = ['/visa-type/' => 'All Visa Services'];
foreach (visa_types_all() as $t) {
    $visaServiceSection["/visa-type/{$t['slug']}/"] = $t['name'];
}

// Same shared source as the header mega-menu and /attestation/ routing —
// see includes/functions.php's attestation_services().
$attestationSection = ['/attestation/' => 'All Attestation Services'];
foreach (attestation_services() as $slug => $service) {
    $attestationSection["/attestation/{$slug}/"] = $service['name'];
}

$sections = [
    'Visa Services' => ['icon' => 'visa-services', 'links' => $visaServiceSection],
    'Visa by Country' => [
        'icon' => 'countries',
        'links' => [
            '/countries/' => 'All Countries',
            '/countries/#region-asia' => 'Asia',
            '/countries/#region-europe' => 'Europe',
            '/countries/#region-north-america' => 'North America',
            '/countries/#region-south-america' => 'South America',
            '/countries/#region-africa' => 'Africa',
            '/countries/#region-oceania' => 'Oceania',
        ],
    ],
    'Apostille & Attestation' => ['icon' => 'attestation', 'links' => $attestationSection],
    'Documents' => [
        'icon' => 'resources',
        'links' => [
            '/documentation/' => 'Documentation Assistance',
            '/document-checklists/' => 'Document Checklists',
            '/document-templates/' => 'Document Templates',
        ],
    ],
    'Travel & Forex' => [
        'icon' => 'visa-process',
        'links' => [
            '/travel-terms/' => 'Travel Terms',
            '/contact/?service=travel' => 'Travel Enquiry',
            '/forex/track/' => 'Track a Forex Request',
            '/contact/?service=forex' => 'Forex Enquiry',
        ],
    ],
    'Resources' => [
        'icon' => 'resources',
        'links' => [
            '/enquire/' => 'Submit a Visa Enquiry',
            '/faq/' => 'FAQ',
            '/visa-process/' => 'Visa Process',
            '/blog/' => 'Visa Updates',
            '/embassy-directory/' => 'Embassy Directory',
            '/visa-status/' => 'Visa Status Directory',
            '/track-visa/' => 'Track My Application',
        ],
    ],
    'Contact & Support' => [
        'icon' => 'company',
        'links' => [
            '/contact/' => 'Contact Us',
            '/grievance/' => 'Grievance Redressal',
            '/partner-program/' => 'Become a B2B Partner',
        ],
    ],
    'Legal & Policies' => [
        'icon' => null,
        'links' => [
            '/privacy/' => 'Privacy Policy',
            '/terms/' => 'Terms & Conditions',
            '/travel-terms/' => 'Travel Terms',
            '/payment-policy/' => 'Payment Policy',
            '/refund-policy/' => 'Refund Policy',
            '/cookie-policy/' => 'Cookie Policy',
            '/grievance/' => 'Grievance Redressal',
            '/disclaimer/' => 'Disclaimer',
            '/sitemap/' => 'Sitemap',
        ],
    ],
];

$pageTitle = 'Sitemap | Visagiri';
$pageDescription = 'A full directory of Visagiri pages — visa services, attestation, country guides, documents, travel and forex, resources, and legal and support pages, all in one place.';
$canonicalUrl = APP_URL . '/sitemap/';
$structuredData = [[
    '@context' => 'https://schema.org',
    '@type' => 'BreadcrumbList',
    'itemListElement' => [
        ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => APP_URL . '/'],
        ['@type' => 'ListItem', 'position' => 2, 'name' => 'Sitemap', 'item' => $canonicalUrl],
    ],
]];
require __DIR__ . '/../includes/header.php';

// $companyMenu is defined inside header.php (shared with the Company
// mega-menu and footer), so this section is only buildable after the
// require above — everything else in $sections is built up front.
$companyItems = [];
foreach ($companyMenu as $companyGroup) {
    foreach ($companyGroup as $companyItem) {
        $companyItems[$companyItem['href']] = $companyItem['label'];
    }
}
$sections['About Visagiri'] = ['icon' => 'company', 'links' => $companyItems];
?>
<section class="section">
    <div class="container" style="max-width:1100px">
        <ul class="breadcrumb"><li><a href="/">Home</a></li><li>Sitemap</li></ul>
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">Sitemap</span>
            <h1>Every Page, One Click Away</h1>
            <p style="max-width:70ch">A full directory of Visagiri's visa, attestation, travel, forex, resource and support pages.</p>
        </div>
        <div class="card-grid">
            <?php foreach ($sections as $heading => $section): ?>
            <div class="card">
                <div class="card-title">
                    <?php if ($section['icon']): ?><span style="margin-right:var(--space-2);vertical-align:middle"><?= primary_nav_icon($section['icon']) ?></span><?php endif; ?>
                    <?= e($heading) ?>
                </div>
                <ul style="padding-left:var(--space-5)">
                    <?php foreach ($section['links'] as $href => $label): ?>
                    <li><a href="<?= e($href) ?>"><?= e($label) ?></a></li>
                    <?php endforeach; ?>
                </ul>
            </div>
            <?php endforeach; ?>
        </div>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
