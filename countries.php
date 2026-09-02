<?php
declare(strict_types=1);
require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/includes/partials.php';
require_once __DIR__ . '/lib-php/auth.php';

// Must run before any output — see index.php for why.
auth_session_start();

$countries = all_countries();
$total = count($countries);
$regions = regions_data();
$bySlug = [];
foreach ($countries as $c) { $bySlug[$c['slug']] = $c; }

$crumb = [['label' => 'Home', 'href' => url('/')], ['label' => 'Countries']];
$page = [
  'title' => "All {$total} Countries & Territories — Visa Requirements | " . SITE['name'],
  'short_title' => 'All Countries',
  'description' => "Browse visa requirements, documents, fees and processing times for {$total} countries and territories — grouped by region and listed A–Z.",
  'path' => '/countries',
  'jsonld' => [breadcrumb_schema($crumb)],
];

$letters = [];
foreach ($countries as $c) { $letters[mb_strtoupper(mb_substr($c['country'], 0, 1))][] = $c; }
ksort($letters);
?><!DOCTYPE html>
<html lang="en">
<head><?php include __DIR__ . '/includes/head.php'; ?></head>
<body>
<?php include __DIR__ . '/includes/header.php'; ?>
<section class="page-hero">
  <div class="container">
    <?= breadcrumbs($crumb) ?>
    <p class="eyebrow">Visa destinations</p>
    <h1>All <?= $total ?> Countries &amp; Territories</h1>
    <p class="page-hero-sub">Every destination has a guide with a document checklist you can tick off and print. Filter below, browse by region, or jump to the A–Z.</p>
    <?php /* Filters the region and A–Z lists in place. Progressive enhancement:
             without JS the box is hidden and every link is still on the page. */ ?>
    <div class="country-filter" hidden>
      <label class="sr-only" for="countryFilter">Filter countries</label>
      <svg viewBox="0 0 24 24" width="18" height="18" aria-hidden="true"><path fill="currentColor" d="M15.5 14h-.79l-.28-.27a6.5 6.5 0 1 0-.7.7l.27.28v.79l5 5L20.49 19zm-6 0A4.5 4.5 0 1 1 14 9.5 4.5 4.5 0 0 1 9.5 14z"/></svg>
      <input type="search" id="countryFilter" placeholder="Start typing a country&hellip;" autocomplete="off" spellcheck="false">
      <span class="country-filter-count" data-filter-count aria-live="polite"><?= $total ?> destinations</span>
    </div>
  </div>
</section>
<?= sticky_search() ?>
<main>
  <section class="section">
    <div class="container">
      <div class="section-head center"><p class="kicker">Browse by region</p><h2>Where are you travelling?</h2></div>
      <div class="region-grid">
        <?php foreach ($regions as $name => $list):
          $present = array_values(array_filter($list, static fn($n) => isset($bySlug[cv_slug($n)]))); ?>
        <div class="region-card" id="region-<?= e(cv_slug($name)) ?>">
          <h3><?= e($name) ?> <span class="region-count"><?= count($present) ?></span></h3>
          <p>Visa guides for <?= count($present) ?> destination<?= count($present) === 1 ? '' : 's' ?>.</p>
          <div class="region-links">
            <?php foreach ($present as $n): $c = $bySlug[cv_slug($n)]; ?>
            <a href="<?= url('/visa/' . $c['slug']) ?>" data-country="<?= e(mb_strtolower($c['country'])) ?>"><?= country_flag($c) ?> <?= e($c['country']) ?></a>
            <?php endforeach; ?>
          </div>
        </div>
        <?php endforeach; ?>
      </div>
    </div>
  </section>
  <section class="section section-alt">
    <div class="container">
      <div class="section-head center"><p class="kicker">Full index</p><h2>All countries A–Z</h2></div>
      <p class="filter-empty" data-filter-empty hidden>No destination matches that. Check the spelling, or <a href="<?= url('/contact') ?>">ask us</a> — we handle territories that are not on this list.</p>
      <div class="az-jump"><?php foreach (array_keys($letters) as $L): ?><a href="#az-<?= e($L) ?>"><?= e($L) ?></a><?php endforeach; ?></div>
      <?php foreach ($letters as $L => $list): ?>
      <div class="az-block" id="az-<?= e($L) ?>">
        <h3><?= e($L) ?></h3>
        <div class="region-links"><?php foreach ($list as $c): ?><a href="<?= url('/visa/' . $c['slug']) ?>" data-country="<?= e(mb_strtolower($c['country'])) ?>"><?= country_flag($c) ?> <?= e($c['country']) ?></a><?php endforeach; ?></div>
      </div>
      <?php endforeach; ?>
    </div>
  </section>
</main>
<?php include __DIR__ . '/includes/footer.php'; ?>
</body>
</html>
