<?php
declare(strict_types=1);

/**
 * /visa-status/ (hub) and /visa-status/{slug}/ (directory) — groups
 * real countries by a verifiable status flag (VISA_STATUS_DIRECTORIES,
 * includes/data.php). The visa_policy_for_indians-backed directories
 * (visa-free, visa-on-arrival, evisa) only list countries a staff
 * member has actually verified and set that field for — an empty
 * list here is the honest state, not a placeholder to fill with
 * guesses.
 */

$statusSlug = $segments[1] ?? null;

if ($statusSlug === null) {
    $pageTitle = 'Visa Status Directory - Visagiri';
    $pageDescription = 'Browse destinations by visa status: visa-free, visa on arrival, eVisa, Schengen, GCC, ASEAN, and SAARC countries — for Indian passport holders.';
    $canonicalUrl = APP_URL . '/visa-status/';
    require __DIR__ . '/../includes/header.php';
    ?>
    <section class="visa-detail">
        <div class="container">
            <ul class="breadcrumb"><li><a href="/">Home</a></li><li>Visa Status Directory</li></ul>
            <div class="visa-detail__header"><div><h1>Visa Status Directory</h1><p style="margin-top:var(--space-3)">Browse destinations grouped by visa status.</p></div></div>
            <div class="card-grid">
                <?php foreach (VISA_STATUS_DIRECTORIES as $slug => $dir): ?>
                <a href="/visa-status/<?= e($slug) ?>/" class="card service-card">
                    <div class="card-title"><?= e($dir['label']) ?></div>
                </a>
                <?php endforeach; ?>
            </div>
        </div>
    </section>
    <?php
    require __DIR__ . '/../includes/footer.php';
    exit;
}

if (!isset(VISA_STATUS_DIRECTORIES[$statusSlug])) {
    render_not_found("We couldn't find that visa status directory.");
}

$dir = VISA_STATUS_DIRECTORIES[$statusSlug];
$countries = countries_by_visa_status_slug($statusSlug);

$pageTitle = "{$dir['label']} - Visagiri";
$pageDescription = "{$dir['label']}: the full list of destinations, for Indian passport holders — from Visagiri.";
$canonicalUrl = APP_URL . "/visa-status/{$statusSlug}/";
$structuredData = [[
    '@context' => 'https://schema.org',
    '@type' => 'BreadcrumbList',
    'itemListElement' => [
        ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => APP_URL . '/'],
        ['@type' => 'ListItem', 'position' => 2, 'name' => 'Visa Status Directory', 'item' => APP_URL . '/visa-status/'],
        ['@type' => 'ListItem', 'position' => 3, 'name' => $dir['label'], 'item' => $canonicalUrl],
    ],
]];
require __DIR__ . '/../includes/header.php';
?>
<section class="visa-detail">
    <div class="container">
        <ul class="breadcrumb">
            <li><a href="/">Home</a></li>
            <li><a href="/visa-status/">Visa Status Directory</a></li>
            <li><?= e($dir['label']) ?></li>
        </ul>

        <div class="visa-detail__header">
            <div>
                <h1><?= e($dir['label']) ?></h1>
                <p style="margin-top:var(--space-3)">
                    <?= count($countries) ?> destination<?= count($countries) === 1 ? '' : 's' ?> currently listed.
                </p>
            </div>
        </div>

        <?php if ($countries): ?>
        <div class="card-grid">
            <?php foreach ($countries as $c): ?>
            <a href="/visa/<?= e($c['slug']) ?>/" class="card service-card">
                <div class="service-card__icon"><?= flag_emoji($c['iso2']) ?></div>
                <div class="card-title"><?= e($c['name']) ?></div>
                <?php if (!empty($c['region'])): ?><span class="badge badge-neutral"><?= e($c['region']) ?></span><?php endif; ?>
            </a>
            <?php endforeach; ?>
        </div>
        <?php else: ?>
        <div class="alert alert-warning">
            <div>
                <strong>Not yet published.</strong>
                We haven't verified and listed any destinations for "<?= e($dir['label']) ?>" yet.
                <a href="/countries/">Browse all destinations</a> or <a href="/contact/">contact our team</a> for current status.
            </div>
        </div>
        <?php endif; ?>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
