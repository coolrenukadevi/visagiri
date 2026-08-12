<?php
declare(strict_types=1);

/**
 * Real XML sitemap — Phase 15. Deliberately narrower than "every URL
 * the router will answer for": it lists only pages with genuine,
 * non-stub content. Per-country visa overview pages (/visa/{c}/) are
 * included since they always have real structure (visa-type list,
 * embassy/consulate info where published); the individual
 * /visa/{country}/{type}/ leaf pages are NOT included even though
 * they're real, reachable pages — most show the honest "requirements
 * not yet verified" state today, and submitting ~1,600 thin pages to
 * search engines at once is bad practice. They're still crawlable via
 * the country pages' own links; they just aren't force-submitted here
 * until real per-type content ships. Scaffold-stub pages (see
 * render_scaffold_page()) and /blog/ (genuinely empty, no fabricated
 * posts) are excluded and noindexed at the page level too.
 */

header('Content-Type: application/xml; charset=utf-8');

$countries = countries_all();
$visaTypes = visa_types_all();

$staticUrls = [
    ['loc' => '/', 'priority' => '1.0', 'changefreq' => 'weekly'],
    ['loc' => '/about/', 'priority' => '0.6', 'changefreq' => 'monthly'],
    ['loc' => '/leadership/', 'priority' => '0.4', 'changefreq' => 'monthly'],
    ['loc' => '/our-team/', 'priority' => '0.4', 'changefreq' => 'monthly'],
    ['loc' => '/countries/', 'priority' => '0.9', 'changefreq' => 'weekly'],
    ['loc' => '/visa-type/', 'priority' => '0.8', 'changefreq' => 'monthly'],
    ['loc' => '/visa-process/', 'priority' => '0.6', 'changefreq' => 'monthly'],
    ['loc' => '/faq/', 'priority' => '0.5', 'changefreq' => 'monthly'],
    ['loc' => '/contact/', 'priority' => '0.5', 'changefreq' => 'yearly'],
    ['loc' => '/enquire/', 'priority' => '0.5', 'changefreq' => 'yearly'],
    ['loc' => '/attestation/', 'priority' => '0.7', 'changefreq' => 'monthly'],
];
foreach (array_keys(attestation_services()) as $attestationSlug) {
    $staticUrls[] = ['loc' => "/attestation/{$attestationSlug}/", 'priority' => '0.6', 'changefreq' => 'monthly'];
}

echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n";
?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
<?php foreach ($staticUrls as $url): ?>
    <url>
        <loc><?= e(APP_URL . $url['loc']) ?></loc>
        <changefreq><?= e($url['changefreq']) ?></changefreq>
        <priority><?= e($url['priority']) ?></priority>
    </url>
<?php endforeach; ?>
<?php foreach ($visaTypes as $t): ?>
    <url>
        <loc><?= e(APP_URL . '/visa-type/' . $t['slug'] . '/') ?></loc>
        <changefreq>monthly</changefreq>
        <priority>0.6</priority>
    </url>
<?php endforeach; ?>
<?php foreach ($countries as $c): ?>
    <url>
        <loc><?= e(APP_URL . '/visa/' . $c['slug'] . '/') ?></loc>
        <changefreq>weekly</changefreq>
        <priority>0.7</priority>
    </url>
<?php endforeach; ?>
</urlset>
<?php exit; ?>
