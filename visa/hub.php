<?php
declare(strict_types=1);

/**
 * /visa/ — the Main Visa Hub. Previously this bare path just
 * redirected to /countries/; this replaces that redirect with a real
 * landing page tying together everything Phase A built (continent
 * hubs, visa-status directories, document templates, tracking) behind
 * one instant-search widget. No internal link anywhere in the
 * codebase pointed at bare /visa/ before this (checked), so nothing
 * depended on the old redirect behavior.
 */

$continentCounts = [];
foreach (CONTINENT_HUBS as $slug => $hub) {
    $continentCounts[$slug] = count(countries_by_continent_slug($slug));
}

$popularCountries = array_values(array_filter(countries_all(), static fn($c) => $c['is_popular_destination']));

$recentlyUpdated = db()->query(
    "SELECT vr.processing_time, vr.last_verified_at, vr.updated_at, c.name AS country_name, c.slug AS country_slug, c.iso2,
            vt.name AS visa_type_name, vt.slug AS visa_type_slug
     FROM visa_requirements vr
     JOIN countries c ON c.id = vr.country_id
     JOIN visa_types vt ON vt.id = vr.visa_type_id
     ORDER BY vr.updated_at DESC
     LIMIT 6"
)->fetchAll();

$pageTitle = 'Visa Requirements for 200+ Countries - Visagiri';
$pageDescription = 'Search visa requirements, document checklists, fees, and processing times for 200+ countries, by continent or visa status — for Indian passport holders.';
$canonicalUrl = APP_URL . '/visa/';
$structuredData = [[
    '@context' => 'https://schema.org',
    '@type' => 'BreadcrumbList',
    'itemListElement' => [
        ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => APP_URL . '/'],
        ['@type' => 'ListItem', 'position' => 2, 'name' => 'Visa Requirements', 'item' => $canonicalUrl],
    ],
]];
require __DIR__ . '/../includes/header.php';
?>
<section class="visa-detail" style="padding-top:var(--space-8)">
    <div class="container">
        <ul class="breadcrumb"><li><a href="/">Home</a></li><li>Visa Requirements</li></ul>

        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">200+ Destinations</span>
            <h1>Find Visa Requirements for Any Destination</h1>
            <p>Search by country, visa type, or continent — or browse by visa status below.</p>
        </div>

        <div class="card" style="max-width:640px;margin-bottom:var(--space-10)">
            <?php render_visa_search_widget('hub', 'Search country, visa type, or continent…'); ?>
        </div>

        <h2 class="country-directory__subheading">Browse by Continent</h2>
        <div class="card-grid" style="margin-bottom:var(--space-10)">
            <?php foreach (CONTINENT_HUBS as $slug => $hub): ?>
            <a href="/visa/<?= e($slug) ?>/" class="card service-card">
                <div class="card-title"><?= e($hub['label']) ?></div>
                <p><?= $continentCounts[$slug] ?> destination<?= $continentCounts[$slug] === 1 ? '' : 's' ?></p>
            </a>
            <?php endforeach; ?>
        </div>

        <h2 class="country-directory__subheading">Browse by Visa Status</h2>
        <div class="card-grid" style="margin-bottom:var(--space-10)">
            <?php foreach (VISA_STATUS_DIRECTORIES as $slug => $dir): ?>
            <a href="/visa-status/<?= e($slug) ?>/" class="card service-card">
                <div class="card-title"><?= e($dir['label']) ?></div>
            </a>
            <?php endforeach; ?>
        </div>

        <?php if ($popularCountries): ?>
        <h2 class="country-directory__subheading">Popular Destinations</h2>
        <div class="card-grid" style="margin-bottom:var(--space-10)">
            <?php foreach ($popularCountries as $c): ?>
            <a href="/visa/<?= e($c['slug']) ?>/" class="card destination-card">
                <span class="destination-card__flag"><?= flag_emoji($c['iso2']) ?></span>
                <span>
                    <span class="destination-card__name"><?= e($c['name']) ?></span><br>
                    <span class="destination-card__link">View requirements &rarr;</span>
                </span>
            </a>
            <?php endforeach; ?>
        </div>
        <?php endif; ?>

        <?php if ($recentlyUpdated): ?>
        <h2 class="country-directory__subheading">Recently Updated</h2>
        <div class="card-grid" style="margin-bottom:var(--space-10)">
            <?php foreach ($recentlyUpdated as $r): ?>
            <a href="/visa/<?= e($r['country_slug']) ?>/<?= e($r['visa_type_slug']) ?>/" class="card service-card">
                <div class="service-card__icon"><?= flag_emoji($r['iso2']) ?></div>
                <div class="card-title"><?= e($r['visa_type_name']) ?> &mdash; <?= e($r['country_name']) ?></div>
                <p>Updated <?= e(date('d M Y', strtotime((string) $r['updated_at']))) ?></p>
            </a>
            <?php endforeach; ?>
        </div>
        <?php endif; ?>

        <h2 class="country-directory__subheading">More Tools</h2>
        <div class="card-grid">
            <a href="/documentation/" class="card service-card">
                <div class="card-title">Documentation Assistance</div>
                <p>What documents you need and why, by category.</p>
            </a>
            <a href="/document-templates/" class="card service-card">
                <div class="card-title">Document Templates</div>
                <p>Cover letters, NOC, consent letters, and other formats.</p>
            </a>
            <a href="/track-visa/" class="card service-card">
                <div class="card-title">Track Your Application</div>
                <p>Check your visa application status.</p>
            </a>
            <a href="/embassy-directory/" class="card service-card">
                <div class="card-title">Embassy Directory</div>
                <p>Embassy, consulate, and VAC contact information.</p>
            </a>
        </div>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
