<?php
/**
 * Visa category page — /visa/tourist, /visa/business, …
 * One controller for all categories; countries offering that category are
 * listed from the same data the country guides use.
 */
declare(strict_types=1);
require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/includes/partials.php';
require_once __DIR__ . '/data/documents.php';

/** slug => [display name, lede, who it's for, typical documents note] */
const VISA_TYPE_PAGES = [
  'tourist' => ['Tourist Visa', 'For holidays, sightseeing and visiting friends or family.',
    ['Leisure travel and holidays', 'Sightseeing and organised tours', 'Visiting friends or relatives', 'Short personal trips'],
    'Proof of accommodation and return travel, evidence of funds for the trip, and evidence you intend to return home are central to most tourist applications.'],
  'business' => ['Business Visa', 'For meetings, conferences, negotiations and short corporate travel.',
    ['Client and supplier meetings', 'Conferences and trade fairs', 'Contract negotiations', 'Site visits and inspections'],
    'An invitation letter from the host organisation and a letter from your employer confirming the purpose of travel are usually required. A business visa does not permit taking up local employment.'],
  'student' => ['Student Visa', 'For enrolment on a course of study abroad.',
    ['University and college programmes', 'Language courses', 'Exchange programmes', 'Research placements'],
    'An acceptance or enrolment confirmation from the institution, evidence of tuition and living funds, and often proof of language ability are required. Financial evidence frequently must be held for a minimum period before applying.'],
  'employment' => ['Employment / Work Visa', 'For taking up paid work or an assignment abroad.',
    ['Employer-sponsored roles', 'Skilled worker categories', 'Intra-company transfers', 'Project assignments'],
    'Usually requires a job offer or sponsorship, evidence of qualifications, and in many countries a skills assessment or labour-market step. These are typically the slowest and most document-heavy categories.'],
  'family-dependent' => ['Family & Dependent Visa', 'For joining a spouse, parent or family member abroad.',
    ['Joining a spouse or partner', 'Dependent children', 'Family reunification', 'Accompanying a work or student visa holder'],
    'Proof of the family relationship (marriage or birth certificates, often officially attested) and evidence that the sponsor can support you are central. Document attestation requirements catch many applicants out.'],
  'transit' => ['Transit Visa', 'For passing through a country en route to your destination.',
    ['Airport transfers between flights', 'Changing airport within a city', 'Short stopovers', 'Onward travel by land or sea'],
    'Whether you need one depends on your nationality, the airport, whether you leave the sterile area and how long the layover is. Check before booking a connection — this is a common cause of denied boarding.'],
  'medical' => ['Medical Visa', 'For treatment at a hospital or clinic abroad.',
    ['Planned medical treatment', 'Specialist consultations', 'Surgery and follow-up care', 'Accompanying attendant travel'],
    'A letter from the treating hospital abroad, a referral from your doctor at home, and evidence you can meet the treatment costs are typically required. Many countries issue an accompanying attendant visa alongside.'],
  'conference' => ['Conference Visa', 'For attending a conference, seminar or official event.',
    ['Academic conferences', 'Industry seminars', 'Workshops and symposiums', 'Official events'],
    'An invitation from the conference organiser and, in some countries, clearance from a government department are required. These often have longer lead times than a standard business visa.'],
  'official-diplomatic' => ['Official / Diplomatic Visa', 'For government officials travelling on official duty.',
    ['Government delegations', 'Official state business', 'Diplomatic postings', 'International organisation travel'],
    'Applications are normally routed through the relevant ministry or mission using a note verbale, rather than submitted by the individual traveller.'],
  'schengen' => ['Schengen Visa', 'One visa for short stays across the Schengen area.',
    ['Tourism and holidays across multiple Schengen countries', 'Business meetings and trade fairs', 'Visiting friends and family', 'Short courses, conferences and cultural events'],
    'Apply at the mission of your MAIN destination — where you spend the most nights. If nights are equal, apply where you enter first. Applying at the wrong mission is the most common reason a Schengen file is returned unopened. Travel medical insurance covering the whole area is a standard requirement for this category, and the itinerary you submit should match the country you applied through.'],
  'renewal' => ['Visa Renewal & Extension', 'For extending a stay or renewing a visa before it expires.',
    ['Extending a current stay', 'Renewing a work permit', 'Renewing a residence visa', 'Changing visa category in-country'],
    'Timing matters more than anything else here — most countries require the application before the current visa expires, and overstaying can affect future applications. Start well before the expiry date.'],
];

$slug = (string) ($_GET['type'] ?? '');
$def  = VISA_TYPE_PAGES[$slug] ?? null;
if (!$def) { require __DIR__ . '/404.php'; exit; }
[$name, $lede, $useCases, $docNote] = $def;

// Same checklist model the country guides use, so a visitor sees one
// consistent list whether they arrive by destination or by visa type.
$checklist = checklist_for(['visaTypeSlug' => $slug, 'visaType' => $name]);

/*
 * The Schengen area, as it stands at the time of writing. Membership does
 * change — Croatia joined in 2023, and Bulgaria and Romania completed their
 * accession in 2025 — so treat this as a list to review, not a constant.
 *
 * Worth stating on the page because they are the two things people most often
 * get wrong: Ireland is in the EU but NOT in Schengen, and Cyprus is in the EU
 * but not yet in Schengen.
 */
const SCHENGEN_MEMBERS = [
  'Austria', 'Belgium', 'Bulgaria', 'Croatia', 'Czechia', 'Denmark', 'Estonia',
  'Finland', 'France', 'Germany', 'Greece', 'Hungary', 'Iceland', 'Italy',
  'Latvia', 'Liechtenstein', 'Lithuania', 'Luxembourg', 'Malta', 'Netherlands',
  'Norway', 'Poland', 'Portugal', 'Romania', 'Slovakia', 'Slovenia', 'Spain',
  'Sweden', 'Switzerland',
];

// Countries whose data actually contains this category.
$needle = strtolower(str_replace(['-', '/'], [' ', ' '], $slug));
$matches = [];
if ($slug === 'schengen') {
    // Schengen is an area, not a visa type any single country's data carries,
    // so the destination list is its actual membership.
    $bySlugAll = [];
    foreach (all_countries() as $c) { $bySlugAll[$c['slug']] = $c; }
    foreach (SCHENGEN_MEMBERS as $m) {
        $k = cv_slug($m);
        if (isset($bySlugAll[$k])) { $matches[] = $bySlugAll[$k]; }
    }
} else {
foreach (all_countries() as $c) {
    foreach ($c['visaTypes'] as $v) {
        $vt = strtolower($v['visaType']);
        if (str_contains($vt, explode(' ', $needle)[0])) { $matches[] = $c; break; }
    }
}
}

$path  = '/visa/' . $slug;
$crumb = [
  ['label' => 'Home', 'href' => url('/')],
  ['label' => 'Visa Services', 'href' => url('/visa-finder')],
  ['label' => $name],
];
$page = [
  'title' => $name . ' — Requirements, Documents & Countries | ' . SITE['name'],
  'short_title' => $name,
  'description' => $lede . ' Requirements, documents and country guides for the ' . strtolower($name) . '.',
  'path' => $path,
  'og_type' => 'article',
  'jsonld' => [breadcrumb_schema($crumb)],
];
?><!DOCTYPE html>
<html lang="en">
<head><?php include __DIR__ . '/includes/head.php'; ?></head>
<body>
<?php include __DIR__ . '/includes/header.php'; ?>
<section class="page-hero">
  <div class="hero-bg" aria-hidden="true">
    <svg class="hero-blob hero-blob-1" viewBox="0 0 600 600" xmlns="http://www.w3.org/2000/svg"><path fill="url(#hgv)" d="M451.5,318.5Q447,387,388,428.5Q329,470,264.5,447Q200,424,144,384.5Q88,345,90.5,272.5Q93,200,148,155.5Q203,111,271.5,95Q340,79,391.5,127Q443,175,458.5,246.5Q474,318,451.5,318.5Z"/><defs><linearGradient id="hgv" x1="0" y1="0" x2="600" y2="600"><stop stop-color="#29b6f6"/><stop offset="1" stop-color="#0f1b3d"/></linearGradient></defs></svg>
  </div>
  <div class="container">
    <?= breadcrumbs($crumb) ?>
    <p class="eyebrow">Visa Services</p>
    <h1><?= e($name) ?></h1>
    <p class="page-hero-sub"><?= e($lede) ?></p>
    <div class="quick-actions">
      <a href="<?= url('/visa-finder') ?>" class="btn btn-primary">Find my visa</a>
      <a href="<?= url('/contact') ?>" class="btn btn-outline">Talk to a consultant</a>
    </div>
  </div>
</section>
<?= sticky_search() ?>
<main>
  <section class="section">
    <div class="container">
      <div class="section-head center"><p class="kicker">Who it's for</p><h2>Typical reasons for a <?= e($name) ?></h2></div>
      <div class="info-grid">
        <?php foreach ($useCases as $u): ?><div class="info-card"><h3><?= e($u) ?></h3></div><?php endforeach; ?>
      </div>
      <div class="prose" style="margin-top:28px;"><p><?= e($docNote) ?></p></div>
    </div>
  </section>

  <section class="section section-alt checklist-section" id="documents">
    <div class="container">
      <div class="section-head"><div><p class="kicker">Documents</p><h2><?= e($name) ?> checklist</h2></div></div>

      <p class="checklist-banner">
        <strong>A preparation checklist, not a legal requirement list.</strong>
        This is what a <?= e(strtolower($name)) ?> application is built from, wherever you are going, so you
        can start gathering now. The definitive list depends on your destination and your nationality —
        open the country guide below, or <a href="<?= url('/contact') ?>">ask us</a> and we will confirm yours.
      </p>

      <div class="checklist" data-checklist="type:<?= e($slug) ?>">
        <div class="checklist-toolbar">
          <div class="checklist-profile">
            <label for="nat-<?= e($slug) ?>">Applying with</label>
            <select id="nat-<?= e($slug) ?>" data-checklist-nationality>
              <?php foreach (checklist_nationalities() as $key => $label): ?>
              <option value="<?= e($key) ?>"><?= e($label) ?></option>
              <?php endforeach; ?>
            </select>
          </div>
          <div class="checklist-profile">
            <label for="profile-<?= e($slug) ?>">Tailor to</label>
            <select id="profile-<?= e($slug) ?>" data-checklist-profile>
              <option value="">Not sure yet — show the common list</option>
              <?php foreach (checklist_profiles() as $key => $label): ?>
              <option value="<?= e($key) ?>"><?= e($label) ?></option>
              <?php endforeach; ?>
            </select>
          </div>
          <div class="checklist-progress">
            <div class="progress-track"><span class="progress-bar" data-checklist-bar style="width:0%"></span></div>
            <span class="progress-text" data-checklist-count aria-live="polite">0 of <?= checklist_base_count($checklist) ?> gathered</span>
          </div>
          <div class="checklist-actions">
            <button type="button" class="btn btn-sm btn-outline" data-checklist-reset>Reset</button>
            <button type="button" class="btn btn-sm btn-primary" data-action="print-page">Print</button>
          </div>
        </div>

        <div class="checklist-groups">
          <?php foreach ($checklist['sections'] as $sec): ?>
          <?php
            $secAttrs = '';
            if ($sec['profile']) $secAttrs .= ' data-profile-section="' . e($sec['profile']) . '" hidden';
            if (!empty($sec['nationality'])) {
                $secAttrs .= ' data-nationality-section="' . e($sec['nationality']) . '"';
                if ($sec['nationality'] !== 'india') $secAttrs .= ' hidden';
            }
          ?>
          <section class="doc-section<?= $sec['kind'] === 'profile' ? ' is-profile' : '' ?><?= $sec['kind'] === 'india' ? ' is-india' : '' ?>"<?= $secAttrs ?>>
            <h3><?= e($sec['title']) ?><?php if ($sec['kind'] === 'purpose'): ?><span class="doc-tag">Specific to this visa</span><?php endif; ?><?php if ($sec['kind'] === 'india'): ?><span class="doc-tag doc-tag-india">India</span><?php endif; ?></h3>
            <ul class="doc-items">
              <?php foreach ($sec['items'] as [$id, $label, $why, $essential]): ?>
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
          Your ticks stay in this browser — nothing is uploaded and we cannot see them.
        </p>
      </div>

      <p class="glance-note" style="margin-top:22px;"><?= e($docNote) ?></p>
    </div>
  </section>

  <section class="section section-alt">
    <div class="container">
      <div class="section-head"><div><p class="kicker">Other categories</p><h2>Not the right visa?</h2></div></div>
      <div class="related-links">
        <?php foreach (VISA_TYPE_PAGES as $k => $d): if ($k === $slug) continue; ?>
        <a class="related-link" href="<?= url('/visa/' . $k) ?>"><?= e($d[0]) ?></a>
        <?php endforeach; ?>
      </div>
    </div>
  </section>

  <section class="section">
    <div class="container">
      <div class="section-head"><div><p class="kicker">By destination</p><h2><?= $slug === 'schengen' ? 'The ' . count($matches) . ' Schengen countries' : e($name) . ' by country' ?></h2></div><a class="link-arrow" href="<?= url('/countries') ?>">All 216 countries &rarr;</a></div>
      <?php if ($slug === 'schengen'): ?>
      <p class="glance-note" style="margin-bottom:20px;">
        Apply at the mission of the country where you will spend the most nights. Membership changes
        from time to time — Croatia joined in 2023, Bulgaria and Romania completed accession in 2025.
        Two that catch people out: <strong>Ireland is in the EU but not in Schengen</strong>, and
        Cyprus is in the EU but not yet in Schengen — both need their own visa.
      </p>
      <?php endif; ?>
      <?php if ($matches): ?>
      <div class="region-links">
        <?php foreach (array_slice($matches, 0, 60) as $c): ?>
        <a href="<?= url('/visa/' . $c['slug']) ?>"><?= country_flag($c) ?> <?= e($c['country']) ?></a>
        <?php endforeach; ?>
      </div>
      <?php else: ?>
      <p class="prose">We publish this category on request. <a href="<?= url('/contact') ?>" style="color:var(--brand-blue);">Tell us your destination</a> and a consultant will confirm the requirements.</p>
      <?php endif; ?>
    </div>
  </section>

  <?= enquiry_widget('', $name) ?>
</main>
<?php include __DIR__ . '/includes/footer.php'; ?>
</body>
</html>
