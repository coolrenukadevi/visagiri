<?php
declare(strict_types=1);

/**
 * Global country directory — Phase 7. Grouped by region with a
 * client-side live search filter (vanilla JS, no backend search
 * endpoint needed for a simple substring match over ~200 rows).
 */

$pdo = db();
$countries = $pdo->query(
    'SELECT name, slug, iso2, region, is_popular_destination FROM countries WHERE is_active = 1 ORDER BY region, name'
)->fetchAll();

$byRegion = [];
foreach ($countries as $c) {
    $byRegion[$c['region']][] = $c;
}
ksort($byRegion);

$popular = array_values(array_filter($countries, static fn($c) => (int) $c['is_popular_destination'] === 1));

$pageTitle = 'Countries - Visagiri';
$pageDescription = 'Explore visa requirements for ' . count($countries) . ' countries and territories worldwide.';
$canonicalUrl = APP_URL . '/countries/';
require __DIR__ . '/../includes/header.php';
$flashNotice = flash_get('notice');
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container">
        <?php if ($flashNotice): ?>
        <div class="alert alert-warning"><?= e($flashNotice) ?></div>
        <?php endif; ?>

        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">Global Directory</span>
            <h1>Explore Visa Requirements by Country</h1>
            <p>Browse <?= count($countries) ?> countries and territories, organized by region.</p>
        </div>

        <div class="country-directory__search">
            <input type="search" id="country-filter" class="form-input" placeholder="Search for a country&hellip;" aria-label="Search countries">
        </div>

        <?php if ($popular): ?>
        <h2 class="country-directory__subheading">Popular Destinations</h2>
        <div class="card-grid" style="margin-bottom:var(--space-8)">
            <?php foreach ($popular as $c): ?>
            <a href="/visa/<?= e($c['slug']) ?>/" class="card destination-card">
                <span class="destination-card__flag"><?= flag_emoji($c['iso2']) ?></span>
                <span class="destination-card__name"><?= e($c['name']) ?></span>
            </a>
            <?php endforeach; ?>
        </div>
        <?php endif; ?>

        <nav class="country-directory__jump" aria-label="Jump to region">
            <?php foreach (array_keys($byRegion) as $region): ?>
            <a href="#region-<?= e(slugify($region)) ?>"><?= e($region) ?> (<?= count($byRegion[$region]) ?>)</a>
            <?php endforeach; ?>
        </nav>

        <div id="country-directory__list">
            <?php foreach ($byRegion as $region => $items): ?>
            <div class="country-directory__region" id="region-<?= e(slugify($region)) ?>">
                <h2 class="country-directory__subheading"><?= e($region) ?></h2>
                <ul class="country-directory__grid">
                    <?php foreach ($items as $c): ?>
                    <li class="country-directory__item" data-name="<?= e(strtolower($c['name'])) ?>">
                        <a href="/visa/<?= e($c['slug']) ?>/">
                            <span><?= flag_emoji($c['iso2']) ?></span> <?= e($c['name']) ?>
                        </a>
                    </li>
                    <?php endforeach; ?>
                </ul>
            </div>
            <?php endforeach; ?>
        </div>

        <p id="country-directory__empty" class="empty-state" hidden>No countries match your search.</p>
    </div>
</section>

<script src="/assets/js/countries.js"></script>

<?php require __DIR__ . '/../includes/footer.php'; ?>
