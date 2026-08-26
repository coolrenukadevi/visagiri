<?php
declare(strict_types=1);

/**
 * /visa/{continent-slug}/ — a directory of real countries grouped by
 * a stable geographic membership (CONTINENT_HUBS, includes/data.php),
 * never a per-country visa policy claim. Required from visa/index.php
 * when $segments[1] matches a known continent slug, before it's
 * treated as a country slug.
 */

$continentSlug = $segments[1];
$hub = CONTINENT_HUBS[$continentSlug];
$countries = countries_by_continent_slug($continentSlug);

$pageTitle = "{$hub['label']} Visa Guide - Visagiri";
$pageDescription = "Visa requirements, document checklists, and application guidance for {$hub['label']} destinations — for Indian passport holders, from Visagiri.";
$canonicalUrl = APP_URL . "/visa/{$continentSlug}/";
$structuredData = [[
    '@context' => 'https://schema.org',
    '@type' => 'BreadcrumbList',
    'itemListElement' => [
        ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => APP_URL . '/'],
        ['@type' => 'ListItem', 'position' => 2, 'name' => 'Countries', 'item' => APP_URL . '/countries/'],
        ['@type' => 'ListItem', 'position' => 3, 'name' => $hub['label'], 'item' => $canonicalUrl],
    ],
]];
require __DIR__ . '/../includes/header.php';
?>
<section class="visa-detail">
    <div class="container">
        <ul class="breadcrumb">
            <li><a href="/">Home</a></li>
            <li><a href="/countries/">Countries</a></li>
            <li><?= e($hub['label']) ?></li>
        </ul>

        <div class="visa-detail__header">
            <div>
                <h1><?= e($hub['label']) ?> Visa Guide</h1>
                <p style="margin-top:var(--space-3)">
                    <?= count($countries) ?> destination<?= count($countries) === 1 ? '' : 's' ?> in <?= e($hub['label']) ?>.
                    Select a country to see visa types, requirements, and how to apply.
                </p>
            </div>
        </div>

        <?php if ($countries): ?>
        <div class="card-grid">
            <?php foreach ($countries as $c): ?>
            <a href="/visa/<?= e($c['slug']) ?>/" class="card service-card">
                <div class="service-card__icon"><?= flag_emoji($c['iso2']) ?></div>
                <div class="card-title"><?= e($c['name']) ?></div>
                <?php if (!empty($c['is_popular_destination'])): ?><span class="badge badge-gold">Popular</span><?php endif; ?>
                <?php if (!empty($c['is_schengen'])): ?><span class="badge badge-neutral">Schengen</span><?php endif; ?>
            </a>
            <?php endforeach; ?>
        </div>
        <?php else: ?>
        <p class="empty-state">No destinations published for <?= e($hub['label']) ?> yet.</p>
        <?php endif; ?>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
