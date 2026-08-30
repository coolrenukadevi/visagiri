<?php
/**
 * Country visa guide — ONE controller for all 216 countries.
 *
 * Public URL:  /visa/kenya      (clean, no .php, no query string)
 * Internally:  .htaccess rewrites to /visa.php?country=kenya
 *
 * Visa types render as tabs within the page, not as separate URLs.
 *
 * The page is built around the document checklist, because that is the part a
 * visitor can act on before they have spoken to anybody. Figures that depend
 * on nationality — fee, processing time, validity — show as "confirmed for
 * your nationality" unless the country's data has been source-verified
 * through data/import/. See visa_fact() in lib-php/data.php for why an honest
 * blank beats a plausible guess here.
 */
declare(strict_types=1);
require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/includes/partials.php';
require_once __DIR__ . '/data/documents.php';

$slug    = (string) ($_GET['country'] ?? '');
$country = $slug !== '' ? country_by_slug($slug) : null;

if (!$country) {
    // Unknown country: a real 404, not a soft-200 empty page (soft-404s get
    // indexed and dilute the site).
    http_response_code(404);
    require __DIR__ . '/404.php';
    exit;
}

$cities     = content()['embassyCities'];
$visaTypes  = $country['visaTypes'];
$names      = array_column($visaTypes, 'visaType');
$isGeneric  = country_is_generic($country);
$profiles   = checklist_profiles();

$path  = '/visa/' . $country['slug'];
$crumb = [
    ['label' => 'Home',      'href' => url('/')],
    ['label' => 'Countries', 'href' => url('/countries')],
    ['label' => $country['country']],
];

$faqs = [];
foreach ($visaTypes as $v) {
    foreach ($v['faqs'] ?? [] as $f) { $faqs[] = $f; }
}

$jsonld = [breadcrumb_schema($crumb)];
if ($faqs) {
    $jsonld[] = [
        '@context'   => 'https://schema.org',
        '@type'      => 'FAQPage',
        'mainEntity' => array_map(static fn($f) => [
            '@type'          => 'Question',
            'name'           => $f['q'],
            'acceptedAnswer' => ['@type' => 'Answer', 'text' => $f['a']],
        ], $faqs),
    ];
}
// HowTo describes the preparation process, which is genuinely what this page
// documents. It deliberately asserts no fee or duration we have not verified.
$steps = $visaTypes[0]['procedureSteps'] ?? [];
if ($steps) {
    $jsonld[] = [
        '@context' => 'https://schema.org',
        '@type'    => 'HowTo',
        'name'     => 'How to prepare a ' . $country['country'] . ' visa application',
        'step'     => array_map(static fn($s, $i) => [
            '@type'    => 'HowToStep',
            'position' => $i + 1,
            'name'     => $s,
        ], $steps, array_keys($steps)),
    ];
}

$page = [
    'title'       => $country['country'] . ' Visa Requirements & Document Checklist | ' . SITE['name'],
    'short_title' => $country['country'] . ' Visa Guide',
    'description' => 'What you need for a ' . $country['country'] . ' visa: a document checklist you can tick off '
                     . 'and print, covering ' . implode(', ', $names) . ' — prepared with '
                     . SITE['name'] . ' consultants.',
    'path'        => $path,
    'og_type'     => 'article',
    'jsonld'      => $jsonld,
];

/** One at-a-glance tile. Renders an honest unknown rather than a fake figure. */
function fact_tile(array $v, string $field, string $label, string $fallback): string
{
    $f = visa_fact($v, $field, $fallback);
    return '<div class="glance-tile' . ($f['known'] ? ' is-known' : '') . '">'
         . '<span class="glance-label">' . e($label) . '</span>'
         . '<strong class="glance-value">' . e($f['value']) . '</strong>'
         . ($f['known'] ? '<span class="glance-flag">Verified</span>' : '')
         . '</div>';
}
?><!DOCTYPE html>
<html lang="en">
<head><?php include __DIR__ . '/includes/head.php'; ?></head>
<body>
<?php include __DIR__ . '/includes/header.php'; ?>

<section class="page-hero country-hero">
  <div class="hero-bg" aria-hidden="true">
    <svg class="hero-blob hero-blob-1" viewBox="0 0 600 600" xmlns="http://www.w3.org/2000/svg"><path fill="url(#hg1)" d="M451.5,318.5Q447,387,388,428.5Q329,470,264.5,447Q200,424,144,384.5Q88,345,90.5,272.5Q93,200,148,155.5Q203,111,271.5,95Q340,79,391.5,127Q443,175,458.5,246.5Q474,318,451.5,318.5Z"/><defs><linearGradient id="hg1" x1="0" y1="0" x2="600" y2="600"><stop stop-color="#29b6f6"/><stop offset="1" stop-color="#0f1b3d"/></linearGradient></defs></svg>
  </div>
  <div class="container">
    <?= breadcrumbs($crumb) ?>
    <div class="country-title">
      <?= country_flag($country, 'country-flag') ?>
      <div>
        <p class="eyebrow">Visa guide</p>
        <h1><?= e($country['country']) ?> visa requirements &amp; document checklist</h1>
      </div>
    </div>
    <p class="page-hero-sub">
      Work through the checklist below, tick items off as you gather them, then print or save the
      list. Choose your visa type first — the checklist changes with it.
    </p>

    <div class="quick-actions">
      <a href="#documents" class="btn btn-primary">Go to the checklist</a>
      <a href="#enquiry" class="btn btn-outline">Ask a consultant</a>
      <button type="button" class="btn btn-outline" data-action="share-page">Share</button>
      <button type="button" class="btn btn-outline" data-action="save-page">Save</button>
    </div>
  </div>
</section>

<div class="visatype-bar">
  <div class="container">
    <span class="visatype-bar-label">Visa type</span>
    <div class="visatabs" role="tablist" aria-label="Visa type">
      <?php foreach ($visaTypes as $i => $v): ?>
      <button type="button" class="visatab<?= $i === 0 ? ' active' : '' ?>" role="tab"
              aria-selected="<?= $i === 0 ? 'true' : 'false' ?>"
              aria-controls="panel-<?= e($v['visaTypeSlug']) ?>"
              data-visatab="<?= e($v['visaTypeSlug']) ?>"><?= e($v['visaType']) ?></button>
      <?php endforeach; ?>
    </div>
  </div>
</div>

<?= sticky_search() ?>

<main>
<?php foreach ($visaTypes as $i => $v):
  $checklist = checklist_for($v);
  $baseCount = checklist_base_count($checklist);
  $storeKey  = $country['slug'] . ':' . $v['visaTypeSlug'];
?>
  <div class="visatab-panel" id="panel-<?= e($v['visaTypeSlug']) ?>"
       data-visatab-panel="<?= e($v['visaTypeSlug']) ?>" role="tabpanel"<?= $i === 0 ? '' : ' hidden' ?>>

    <!-- ---------- At a glance ---------- -->
    <section class="section glance-section">
      <div class="container">
        <div class="glance-grid">
          <?= fact_tile($v, 'processingTime', 'Processing time', 'Confirmed for your nationality') ?>
          <?= fact_tile($v, 'visaFee',        'Visa fee',        'Quoted before you apply') ?>
          <?= fact_tile($v, 'validity',       'Validity',        'Set by the mission on approval') ?>
          <?= fact_tile($v, 'entryType',      'Entry type',      'Depends on the category granted') ?>
        </div>
        <?php if ($isGeneric): ?>
        <p class="glance-note">
          Fees, processing times and validity for <?= e($country['country']) ?> depend on your
          nationality, the category you apply under and the mission handling it — and they change.
          Rather than print a figure we have not confirmed, we give you the real one for your
          passport when you enquire. The checklist below is useful to you right now.
        </p>
        <?php endif; ?>
      </div>
    </section>

    <!-- ---------- Overview ---------- -->
    <section class="section">
      <div class="container">
        <div class="guide-split">
          <div class="guide-main">
            <h2>About the <?= e($country['country']) ?> <?= e($v['visaType']) ?></h2>
            <p class="guide-lede"><?= e($v['overview']) ?></p>

            <?php if (!empty($v['categories'])): ?>
            <h3>Categories under this visa</h3>
            <ul class="tick-list">
              <?php foreach ($v['categories'] as $c): ?><li><?= e($c) ?></li><?php endforeach; ?>
            </ul>
            <?php endif; ?>

            <?php if (!empty($v['eligibility'])): ?>
            <h3>Who can apply</h3>
            <ul class="tick-list">
              <?php foreach ($v['eligibility'] as $x): ?><li><?= e($x) ?></li><?php endforeach; ?>
            </ul>
            <?php endif; ?>
          </div>

          <aside class="guide-aside">
            <div class="aside-card">
              <h3>Where you apply</h3>
              <p><?= e($v['appointmentInfo']) ?></p>
              <p class="aside-sub"><strong><?= e($v['embassyName']) ?></strong></p>
              <h4>Centres we file through</h4>
              <ul class="aside-list">
                <?php foreach ($cities as $c): ?><li><?= e($c) ?></li><?php endforeach; ?>
              </ul>
              <p class="aside-note">
                We are a private visa consultancy, not a government body or an embassy. Addresses and
                counter hours change — we confirm the current one for your case.
              </p>
              <a href="#enquiry" class="btn btn-primary btn-block">Get my requirements</a>
            </div>
          </aside>
        </div>
      </div>
    </section>

    <!-- ---------- Document checklist ---------- -->
    <?php /* Only the first (default-visible) panel owns the plain #documents
             anchor — every panel carrying that id would be a duplicate id and
             would send the no-JS "Go to the checklist" link into a hidden
             panel. common.js retargets the link to whichever tab is open. */ ?>
    <section class="section section-alt checklist-section"
             id="documents<?= $i === 0 ? '' : '-' . e($v['visaTypeSlug']) ?>">
      <div class="container">
        <div class="section-head">
          <div>
            <p class="kicker"><?= e($v['visaType']) ?></p>
            <h2>Document checklist</h2>
          </div>
        </div>

        <?php if ($checklist['verified']): ?>
        <p class="checklist-banner is-verified">
          <strong>Confirmed list.</strong> Verified against
          <?= e($checklist['source'] ?? 'the official source') ?><?php if ($checklist['updated']): ?>
          on <?= e($checklist['updated']) ?><?php endif; ?>. Check again before you travel — rules change.
        </p>
        <?php else: ?>
        <p class="checklist-banner">
          <strong>A preparation checklist, not a legal requirement list.</strong>
          It covers what a <?= e(strtolower($v['visaType'])) ?> application is built from, so you can start
          gathering today. The definitive list — exact photo specifications, financial thresholds, and
          what must be original, translated or apostilled — comes from the mission handling your
          nationality. <a href="#enquiry">Ask us and we will confirm yours.</a>
        </p>
        <?php endif; ?>

        <div class="checklist" data-checklist="<?= e($storeKey) ?>">
          <div class="checklist-toolbar">
            <div class="checklist-profile">
              <label for="nat-<?= e($v['visaTypeSlug']) ?>">Applying with</label>
              <select id="nat-<?= e($v['visaTypeSlug']) ?>" data-checklist-nationality>
                <?php foreach (checklist_nationalities() as $key => $label): ?>
                <option value="<?= e($key) ?>"><?= e($label) ?></option>
                <?php endforeach; ?>
              </select>
            </div>
            <div class="checklist-profile">
              <label for="profile-<?= e($v['visaTypeSlug']) ?>">Tailor to</label>
              <select id="profile-<?= e($v['visaTypeSlug']) ?>" data-checklist-profile>
                <option value="">Not sure yet — show the common list</option>
                <?php foreach ($profiles as $key => $label): ?>
                <option value="<?= e($key) ?>"><?= e($label) ?></option>
                <?php endforeach; ?>
              </select>
            </div>
            <div class="checklist-progress">
              <div class="progress-track"><span class="progress-bar" data-checklist-bar style="width:0%"></span></div>
              <span class="progress-text" data-checklist-count aria-live="polite">0 of <?= $baseCount ?> gathered</span>
            </div>
            <div class="checklist-actions">
              <button type="button" class="btn btn-sm btn-outline" data-checklist-reset>Reset</button>
              <button type="button" class="btn btn-sm btn-primary" data-action="print-page">Print</button>
            </div>
          </div>

          <div class="checklist-groups">
            <?php foreach ($checklist['sections'] as $s): ?>
            <?php
              $secAttrs = '';
              if ($s['profile']) $secAttrs .= ' data-profile-section="' . e($s['profile']) . '" hidden';
              if (!empty($s['nationality'])) {
                  $secAttrs .= ' data-nationality-section="' . e($s['nationality']) . '"';
                  // India is the default, so the "other passport" variant starts hidden.
                  if ($s['nationality'] !== 'india') $secAttrs .= ' hidden';
              }
            ?>
            <section class="doc-section<?= $s['kind'] === 'profile' ? ' is-profile' : '' ?><?= $s['kind'] === 'india' ? ' is-india' : '' ?>"<?= $secAttrs ?>>
              <h3><?= e($s['title']) ?><?php if ($s['kind'] === 'purpose'): ?><span class="doc-tag">Specific to this visa</span><?php endif; ?><?php if ($s['kind'] === 'india'): ?><span class="doc-tag doc-tag-india">India</span><?php endif; ?></h3>
              <ul class="doc-items">
                <?php foreach ($s['items'] as [$id, $label, $why, $essential]): ?>
                <li class="doc-item<?= $essential ? '' : ' is-optional' ?>">
                  <label>
                    <input type="checkbox" data-doc="<?= e($id) ?>">
                    <span class="doc-body">
                      <span class="doc-label"><?= e($label) ?><?php if (!$essential): ?><span class="doc-tag doc-tag-soft">Often requested</span><?php endif; ?></span>
                      <?php if ($why !== ''): ?><span class="doc-why"><?= e($why) ?></span><?php endif; ?>
                    </span>
                  </label>
                </li>
                <?php endforeach; ?>
              </ul>
            </section>
            <?php endforeach; ?>
          </div>

          <p class="checklist-foot">
            Your ticks stay in this browser — nothing is uploaded and we cannot see them. Clearing
            your browser data clears the list.
          </p>
        </div>

        <div class="checklist-help">
          <h3>Before you submit</h3>
          <ul class="tick-list">
            <li>Names and dates must match across every document, including the spelling in your passport.</li>
            <li>Keep a full copy of what you submit — you will need it for renewals and later applications.</li>
            <li>Do not book non-refundable travel until the visa is in your passport.</li>
            <li>Never submit a document you know to be false. A refusal for deception follows you across countries for years.</li>
          </ul>
        </div>
      </div>
    </section>

    <!-- ---------- How to apply ---------- -->
    <section class="section">
      <div class="container">
        <div class="section-head"><div><p class="kicker">Step by step</p><h2>How the application runs</h2></div></div>
        <ol class="process-list">
          <?php foreach ($v['procedureSteps'] as $n => $s): ?>
          <li><span class="process-num"><?= $n + 1 ?></span><span><?= e($s) ?></span></li>
          <?php endforeach; ?>
        </ol>
      </div>
    </section>

    <!-- ---------- Notes + FAQs ---------- -->
    <section class="section section-alt">
      <div class="container">
        <div class="guide-split">
          <div class="guide-main">
            <?php if (!empty($v['faqs'])): ?>
            <h2><?= e($v['visaType']) ?> questions</h2>
            <div class="faq-list">
              <?php foreach ($v['faqs'] as $f): ?>
              <div class="faq-item">
                <button type="button" class="faq-q" aria-expanded="false"><?= e($f['q']) ?></button>
                <div class="faq-a"><p><?= e($f['a']) ?></p></div>
              </div>
              <?php endforeach; ?>
            </div>
            <?php endif; ?>
          </div>
          <aside class="guide-aside">
            <div class="aside-card">
              <h3>Worth knowing</h3>
              <ul class="aside-list">
                <?php foreach ($v['importantNotes'] as $n): ?><li><?= e($n) ?></li><?php endforeach; ?>
              </ul>
              <h4>Travel advisory</h4>
              <p class="aside-sub"><?= e($v['travelAdvisory']) ?></p>
              <a href="<?= url('/travel-advisories') ?>" class="aside-link">Travel advisories &rarr;</a>
            </div>
          </aside>
        </div>
      </div>
    </section>
  </div>
<?php endforeach; ?>

  <!-- ---------- Related ---------- -->
  <section class="section">
    <div class="container">
      <div class="section-head"><div><p class="kicker">Nearby destinations</p><h2>Other guides in this region</h2></div></div>
      <div class="related-links">
        <?php foreach (related_countries($country['slug'], 8) as $rc): ?>
        <a class="related-link" href="<?= url('/visa/' . $rc['slug']) ?>"><?= country_flag($rc) ?> <?= e($rc['country']) ?></a>
        <?php endforeach; ?>
        <a class="related-link related-all" href="<?= url('/countries') ?>">All countries &rarr;</a>
      </div>
      <div data-section="recently-viewed" hidden>
        <div class="section-head" style="margin-top:36px;"><div><h2>Recently viewed</h2></div></div>
        <div class="related-links" data-render="recently-viewed"></div>
      </div>
    </div>
  </section>

  <?= enquiry_widget($country['country'], $visaTypes[0]['visaType'] ?? '') ?>
</main>

<?php include __DIR__ . '/includes/footer.php'; ?>
</body>
</html>
