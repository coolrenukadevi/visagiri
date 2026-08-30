<?php
/** Homepage / visa-finder service console — the six primary actions. */
require_once __DIR__ . '/config.php';
$actions = [
  ['Find My Visa', 'Search by destination and visa type', '/visa-finder', 'M15.5 14h-.79l-.28-.27a6.5 6.5 0 1 0-.7.7l.27.28v.79l5 5L20.49 19zm-6 0A4.5 4.5 0 1 1 14 9.5 4.5 4.5 0 0 1 9.5 14z', true],
  ['Check Requirements', 'Documents, eligibility and fees', '/visa-requirements', 'M20 3H4c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 7a2 2 0 1 1 0 4 2 2 0 0 1 0-4z', false],
  ['Track My Visa', 'See where your application is', '/track-visa', 'M12 2C8.1 2 5 5.1 5 9c0 5.2 7 13 7 13s7-7.8 7-13c0-3.9-3.1-7-7-7zm0 9.5A2.5 2.5 0 1 1 12 6.5a2.5 2.5 0 0 1 0 5z', false],
  ['Pay Invoice', 'Accepted payment methods', '/payments', 'M20 4H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 14H4v-6h16v6zm0-10H4V6h16v2z', false],
  ['Check Documents', 'What you need for your application', '/document-verification', 'M6 2c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V8l-6-6H6zm7 7V3.5L18.5 9H13z', false],
  ['Talk to a Consultant', 'Speak to a visa expert', '/contact', 'M6.6 10.8c1.4 2.8 3.8 5.1 6.6 6.6l2.2-2.2c.3-.3.7-.4 1-.2 1.1.4 2.3.6 3.6.6.6 0 1 .4 1 1V20c0 .6-.4 1-1 1-9.4 0-17-7.6-17-17 0-.6.4-1 1-1h3.5c.6 0 1 .4 1 1 0 1.2.2 2.5.6 3.6.1.4 0 .8-.2 1L6.6 10.8z', false],
];
?>
<?php /* Set $console_alt = true before including for the tinted band, so the
         console can sit between two plain sections without flattening the page. */ ?>
<section class="section console-section<?= !empty($console_alt) ? ' section-alt' : '' ?>">
  <div class="container">
    <div class="section-head center"><p class="kicker">Service console</p><h2>What would you like to do?</h2></div>
    <div class="console-grid">
      <?php
      // Drop the tile that points at the page currently being rendered — a
      // console on /visa-finder should not offer "Find My Visa" as a link to
      // itself.
      $here = $page['path'] ?? null;
      foreach ($actions as [$label, $desc, $href, $d, $primary]):
        if ($here !== null && $href === $here) continue; ?>
      <a class="console-tile<?= $primary ? ' is-primary' : '' ?>" href="<?= url($href) ?>">
        <span class="console-icon"><svg viewBox="0 0 24 24" width="22" height="22" aria-hidden="true"><path fill="currentColor" d="<?= $d ?>"/></svg></span>
        <span class="console-label"><?= e($label) ?></span>
        <span class="console-desc"><?= e($desc) ?></span>
      </a>
      <?php endforeach; ?>
    </div>
  </div>
</section>
