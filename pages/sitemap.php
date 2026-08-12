<?php
declare(strict_types=1);

/**
 * Human-readable sitemap. Lists the site's current static routes by
 * section; country/visa-type detail pages are omitted here since
 * they're already discoverable from /countries/ and /visa-type/, and
 * listing every combination would duplicate the XML sitemap's job
 * once that exists (Phase 15 — SEO).
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
    'Visa Services' => $visaServiceSection,
    'Attestation Services' => $attestationSection,
    'Explore' => [
        '/countries/' => 'Countries',
        '/visa-process/' => 'Visa Process',
        '/blog/' => 'Visa Updates',
        '/faq/' => 'FAQ',
    ],
    'Legal & Support' => [
        '/privacy/' => 'Privacy Policy',
        '/terms/' => 'Terms & Conditions',
        '/travel-terms/' => 'Travel Terms',
        '/payment-policy/' => 'Payment Policy',
        '/refund-policy/' => 'Refund Policy',
        '/cookie-policy/' => 'Cookie Policy',
        '/grievance/' => 'Grievance Redressal',
        '/disclaimer/' => 'Disclaimer',
    ],
];

$pageTitle = 'Website Sitemap - Browse All Visagiri Pages';
$pageDescription = 'Browse a full directory of Visagiri pages — visa services, attestation, country guides, account tools, and legal and support resources, all in one place.';
$canonicalUrl = APP_URL . '/sitemap/';
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
$sections['Company'] = $companyItems;
?>
<section class="section">
    <div class="container" style="max-width:900px">
        <div class="section-heading" style="text-align:left;margin-left:0">
            <h1>Sitemap</h1>
        </div>
        <div class="card-grid">
            <?php foreach ($sections as $heading => $links): ?>
            <div class="card">
                <div class="card-title"><?= e($heading) ?></div>
                <ul style="padding-left:var(--space-5)">
                    <?php foreach ($links as $href => $label): ?>
                    <li><a href="<?= e($href) ?>"><?= e($label) ?></a></li>
                    <?php endforeach; ?>
                </ul>
            </div>
            <?php endforeach; ?>
        </div>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
