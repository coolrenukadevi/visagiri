<?php
declare(strict_types=1);

/**
 * /embassy-directory/ — lists countries that have at least one
 * published embassy/consulate/VAC entry. Per Phase 8's own discipline
 * (see AUDIT.md), the embassies/consulates/visa_application_centres
 * tables ship empty until a staff member enters a real, confirmed
 * address — this page reflects that honestly rather than listing all
 * 208 countries as if they all had contact info on file.
 */

$countriesWithContacts = db()->query(
    "SELECT DISTINCT c.id, c.name, c.slug, c.iso2, r.name AS region
     FROM countries c
     LEFT JOIN regions r ON r.id = c.region_id
     WHERE c.is_active = 1 AND (
         EXISTS (SELECT 1 FROM embassies e WHERE e.country_id = c.id)
         OR EXISTS (SELECT 1 FROM consulates co WHERE co.country_id = c.id)
         OR EXISTS (SELECT 1 FROM visa_application_centres v WHERE v.country_id = c.id)
     )
     ORDER BY c.name"
)->fetchAll();

$pageTitle = 'Embassy Directory - Visagiri';
$pageDescription = 'Embassy, consulate, and visa application centre contact information by country.';
$canonicalUrl = APP_URL . '/embassy-directory/';
require __DIR__ . '/../includes/header.php';
?>
<section class="visa-detail">
    <div class="container">
        <ul class="breadcrumb"><li><a href="/">Home</a></li><li>Embassy Directory</li></ul>
        <div class="visa-detail__header">
            <div>
                <h1>Embassy Directory</h1>
                <p style="margin-top:var(--space-3)">Embassy, consulate, and visa application centre contact information for destinations we've published.</p>
            </div>
        </div>

        <?php if ($countriesWithContacts): ?>
        <div class="card-grid">
            <?php foreach ($countriesWithContacts as $c): ?>
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
                We haven't added embassy or consulate contact details for any destination yet.
                <a href="/countries/">Browse all destinations</a> or <a href="/contact/">contact our team</a> for embassy information.
            </div>
        </div>
        <?php endif; ?>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
