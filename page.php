<?php
/**
 * Generic controller for every content page defined in data/pages.php.
 *
 * Public URL:  /about, /privacy-policy, /global-mobility, …
 * Internally:  .htaccess rewrites to /page.php?p={slug}
 *
 * One template, 35 pages — adding a page means adding a data entry, not a file.
 */
declare(strict_types=1);
require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/includes/partials.php';
require_once __DIR__ . '/data/pages.php';
require_once __DIR__ . '/lib-php/auth.php';

// Must run before any output — see index.php for why.
auth_session_start();

$slug = (string) ($_GET['p'] ?? '');
$defs = page_definitions();
$def  = $defs[$slug] ?? null;

if (!$def) {
    require __DIR__ . '/404.php';
    exit;
}

$path  = '/' . $slug;
$crumb = [['label' => 'Home', 'href' => url('/')]];
if (!empty($def['nav_group']) && $def['nav_group'] !== 'Core') {
    $crumb[] = ['label' => $def['nav_group'], 'href' => url('/' . $slug)];
}
$crumb[] = ['label' => $def['h1']];

$jsonld = [breadcrumb_schema($crumb)];
if (!empty($def['faqs'])) {
    $jsonld[] = [
        '@context' => 'https://schema.org', '@type' => 'FAQPage',
        'mainEntity' => array_map(static fn($f) => [
            '@type' => 'Question', 'name' => $f[0],
            'acceptedAnswer' => ['@type' => 'Answer', 'text' => $f[1]],
        ], $def['faqs']),
    ];
}

$page = [
    'title'       => $def['title'],
    'short_title' => $def['h1'],
    'description' => $def['lede'],
    'path'        => $path,
    'jsonld'      => $jsonld,
];
$isVisaPage = in_array($def['nav_group'] ?? '', ['Resources', 'Visa Management', 'Global Mobility', 'Core'], true);
?><!DOCTYPE html>
<html lang="en">
<head><?php include __DIR__ . '/includes/head.php'; ?></head>
<body>
<?php include __DIR__ . '/includes/header.php'; ?>

<section class="page-hero">
  <div class="hero-bg" aria-hidden="true">
    <svg class="hero-blob hero-blob-1" viewBox="0 0 600 600" xmlns="http://www.w3.org/2000/svg"><path fill="url(#hgp)" d="M451.5,318.5Q447,387,388,428.5Q329,470,264.5,447Q200,424,144,384.5Q88,345,90.5,272.5Q93,200,148,155.5Q203,111,271.5,95Q340,79,391.5,127Q443,175,458.5,246.5Q474,318,451.5,318.5Z"/><defs><linearGradient id="hgp" x1="0" y1="0" x2="600" y2="600"><stop stop-color="#29b6f6"/><stop offset="1" stop-color="#0f1b3d"/></linearGradient></defs></svg>
  </div>
  <div class="container">
    <?= breadcrumbs($crumb) ?>
    <?php if (!empty($def['nav_group'])): ?><p class="eyebrow"><?= e($def['nav_group']) ?></p><?php endif; ?>
    <h1><?= e($def['h1']) ?></h1>
    <p class="page-hero-sub"><?= e($def['lede']) ?></p>
    <?php if (!empty($def['cta'])): [$l1, $h1u, $l2, $h2u] = $def['cta']; ?>
    <div class="quick-actions">
      <?php if ($l1): ?><a href="<?= url($h1u) ?>" class="btn btn-primary"><?= e($l1) ?></a><?php endif; ?>
      <?php if ($l2): ?><a href="<?= url($h2u) ?>" class="btn btn-outline"><?= e($l2) ?></a><?php endif; ?>
    </div>
    <?php endif; ?>
  </div>
</section>

<?php if ($isVisaPage) { echo sticky_search(); } ?>

<main>
<?php if (!empty($def['status_note'])): ?>
  <section class="section" style="padding-block:28px 0;">
    <div class="container"><p class="notice-inline"><?= e($def['status_note']) ?></p></div>
  </section>
<?php endif; ?>

<?php if (!empty($def['legal'])): ?>
  <section class="section" style="padding-block:28px 0;">
    <div class="container"><p class="notice-inline"><strong>Please note:</strong> this is a baseline policy prepared for review. It should be checked by a qualified legal adviser, and completed where marked, before being relied on.</p></div>
  </section>
<?php endif; ?>

<?php if (!empty($def['search_console'])) { include __DIR__ . '/includes/service-console.php'; } ?>

<?php if (!empty($def['track_form'])): ?>
  <section class="section">
    <div class="container">
      <div class="track-card">
        <h2>Enter your reference number</h2>
        <form id="trackForm" class="track-form">
          <label class="sr-only" for="trackRefInput">Reference number</label>
          <input type="text" id="trackRefInput" name="ref" placeholder="VISA-20260801-0001" pattern="[A-Za-z0-9\-]{6,32}" required>
          <button type="submit" class="btn btn-primary">Track application</button>
        </form>
        <p class="track-result" id="trackResult" role="status" aria-live="polite"></p>
      </div>
    </div>
  </section>
<?php endif; ?>

<?php foreach ($def['sections'] ?? [] as $sec): ?>
  <section class="section<?= (($secIndex = ($secIndex ?? 0) + 1) % 2 === 0) ? ' section-alt' : '' ?>">
    <div class="container">
      <div class="section-head center"><h2><?= e($sec['h2']) ?></h2></div>

      <?php if (!empty($sec['body'])): ?>
        <div class="prose">
          <?php foreach ($sec['body'] as $p): ?><p><?= e($p) ?></p><?php endforeach; ?>
        </div>
      <?php endif; ?>

      <?php if (!empty($sec['cards'])): ?>
        <div class="info-grid">
          <?php foreach ($sec['cards'] as [$h, $b]): ?>
          <div class="info-card"><h3><?= e($h) ?></h3><p><?= e($b) ?></p></div>
          <?php endforeach; ?>
        </div>
      <?php endif; ?>

      <?php if (!empty($sec['steps'])): ?>
        <div class="steps">
          <?php foreach ($sec['steps'] as $i => [$h, $b]): ?>
          <div class="step"><div class="step-num"><?= $i + 1 ?></div><h3><?= e($h) ?></h3><p><?= e($b) ?></p></div>
          <?php endforeach; ?>
        </div>
      <?php endif; ?>

      <?php if (!empty($sec['stages'])): ?>
        <ol class="stage-list">
          <?php foreach ($sec['stages'] as $i => $s): ?>
          <li><span class="stage-num"><?= $i + 1 ?></span><?= e($s) ?></li>
          <?php endforeach; ?>
        </ol>
      <?php endif; ?>

      <?php if (!empty($sec['office_block'])): ?>
        <div class="info-grid">
          <div class="info-card">
            <h3>Head office</h3>
            <p><?= e(SITE['address']['street']) ?><br><?= e(SITE['address']['locality']) ?>, <?= e(SITE['address']['region']) ?> &ndash; <?= e(SITE['address']['postcode']) ?></p>
            <p style="margin-top:10px;"><a href="tel:<?= e(SITE['phone_href']) ?>" style="color:var(--brand-blue);"><?= e(SITE['phone']) ?></a><br>
            <a href="mailto:<?= e(SITE['email']) ?>" style="color:var(--brand-blue);"><?= e(SITE['email']) ?></a></p>
          </div>
          <div class="info-card">
            <h3>Company</h3>
            <p><?= e(SITE['name']) ?>® is a unit of <?= e(SITE['parent']) ?>.<br>CIN: <?= e(SITE['cin']) ?></p>
          </div>
        </div>
      <?php endif; ?>
    </div>
  </section>
<?php endforeach; ?>

<?php if (!empty($def['faqs'])): ?>
  <section class="section section-alt">
    <div class="container">
      <div class="section-head center"><p class="kicker">Answers</p><h2>Common questions</h2></div>
      <div class="faq-list">
        <?php foreach ($def['faqs'] as [$q, $a]): ?>
        <div class="faq-item"><button type="button" class="faq-q" aria-expanded="false"><?= e($q) ?></button><div class="faq-a"><p><?= e($a) ?></p></div></div>
        <?php endforeach; ?>
      </div>
    </div>
  </section>
<?php endif; ?>

<?php if (!empty($def['guide_list'])): ?>
  <section class="section">
    <div class="container">
      <div class="info-grid">
        <?php foreach ([
          ['Preparing your documents', 'What a complete application looks like, and the document mistakes that cause avoidable delays.', '/countries'],
          ['Understanding visa fees', 'Which charges are government fees, which are centre fees, and which are ours.', '/visa-fees'],
          ['Planning around processing times', 'How to plan travel when the decision date is not in your control.', '/processing-times'],
          ['If your visa is refused', 'The common grounds for refusal and the sensible next step for each.', '/visa-rejection-guide'],
          ['Appointments and biometrics', 'How submission appointments work and how to prepare for them.', '/appointment-management'],
          ['Requirements by country', 'Requirements, documents and fees for 216 destinations.', '/countries'],
        ] as [$h, $b, $u]): ?>
        <a class="info-card guide-card" href="<?= url($u) ?>"><h3><?= e($h) ?></h3><p><?= e($b) ?></p><span class="link-arrow">Read more &rarr;</span></a>
        <?php endforeach; ?>
      </div>
    </div>
  </section>
<?php endif; ?>

<?php if (!empty($def['directory'])): ?>
  <section class="section">
    <div class="container">
      <div class="section-head center"><p class="kicker">Browse</p><h2>Popular destinations</h2></div>
      <div class="region-links" style="justify-content:center;">
        <?php foreach (['united-states','united-kingdom','canada','australia','france','germany','united-arab-emirates','singapore','japan','kenya'] as $s):
          $c = country_by_slug($s); if (!$c) continue; ?>
        <a href="<?= url('/visa/' . $c['slug']) ?>"><?= e($c['country']) ?></a>
        <?php endforeach; ?>
      </div>
      <p style="text-align:center;margin-top:24px;"><a class="btn btn-primary" href="<?= url('/countries') ?>">View all 216 countries</a></p>
    </div>
  </section>
<?php endif; ?>

<?php if (!empty($def['contact_block'])): ?>
  <section class="section">
    <div class="container">
      <div class="info-grid">
        <div class="info-card"><h3>Call us</h3><p><a href="tel:<?= e(SITE['phone_href']) ?>" style="color:var(--brand-blue);font-weight:700;"><?= e(SITE['phone']) ?></a></p></div>
        <div class="info-card"><h3>Email us</h3><p><a href="mailto:<?= e(SITE['email']) ?>" style="color:var(--brand-blue);font-weight:700;"><?= e(SITE['email']) ?></a></p></div>
        <div class="info-card"><h3>WhatsApp</h3><p><a href="https://wa.me/<?= e(ltrim(SITE['phone_href'], '+')) ?>" target="_blank" rel="noopener" style="color:var(--brand-blue);font-weight:700;">Message our team</a></p></div>
        <div class="info-card"><h3>Office</h3><p><?= e(SITE['address']['street']) ?><br><?= e(SITE['address']['locality']) ?>, <?= e(SITE['address']['region']) ?> &ndash; <?= e(SITE['address']['postcode']) ?></p></div>
      </div>
    </div>
  </section>
<?php endif; ?>

<?php if (!empty($def['needs_input'])): ?>
  <section class="section section-alt">
    <div class="container">
      <div class="needs-input">
        <h2>Content required from Convercession</h2>
        <?php if (!empty($def['needs_input_reason'])): ?><p class="needs-input-why"><?= e($def['needs_input_reason']) ?></p><?php endif; ?>
        <ul>
          <?php foreach ($def['needs_input'] as $item): ?><li><?= e($item) ?></li><?php endforeach; ?>
        </ul>
        <p class="needs-input-note">This block is visible so it cannot be forgotten. Remove the <code>needs_input</code> key for this page in <code>data/pages.php</code> once the content is supplied.</p>
      </div>
    </div>
  </section>
<?php endif; ?>

<?php if (!empty($def['enquiry'])) { echo enquiry_widget('', ''); } ?>
</main>

<?php include __DIR__ . '/includes/footer.php'; ?>
</body>
</html>
