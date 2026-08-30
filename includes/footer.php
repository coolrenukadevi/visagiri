<?php
require_once __DIR__ . '/nav.php';
require_once __DIR__ . '/../data/pages.php';
require_once __DIR__ . '/../lib-php/customer_auth.php';
require_once __DIR__ . '/../lib-php/enquiries.php';
$FOOTER = nav_data()['footer'];
// Currency strip sits immediately above the footer, site-wide, from one include.
include __DIR__ . '/currency-widget.php';
?>
<section class="footer-cta">
  <div class="container footer-cta-inner">
    <h2>Your Visa Journey, Managed End-to-End.</h2>
    <p>Check requirements, prepare documents, submit your application and track your visa — all in one place.</p>
    <div class="footer-cta-actions">
      <a href="<?= url('/') ?>#search" class="btn btn-light">Check Visa Requirements</a>
      <a href="<?= url('/') ?>#search" class="btn btn-outline-light">Track My Visa</a>
    </div>
  </div>
</section>

<footer class="site-footer">
  <div class="container footer-grid">
    <div class="footer-brand">
      <a href="<?= url('/') ?>" class="footer-logo">
        <img class="footer-logo-mark" src="/images/logo-mark.png" width="546" height="269" alt="">
        conver<span>cession</span>
      </a>
      <p>AI-powered visa management and global mobility platform — visa intelligence, document management, application tracking and expert support in one place.</p>
      <div class="social-row">
        <?php foreach (SITE['social'] as $label => $href): ?>
        <a href="<?= e($href) ?>" target="_blank" rel="noopener" aria-label="<?= e($label) ?>" class="social-btn"><?= e($label === 'X / Twitter' ? 'X' : strtoupper(substr($label, 0, 2))) ?></a>
        <?php endforeach; ?>
      </div>
      <p style="font-size:0.8rem;margin-top:18px;text-align:left;">
        <a href="tel:<?= e(SITE['phone_href']) ?>"><?= e(SITE['phone']) ?></a><br>
        <a href="mailto:<?= e(SITE['email']) ?>"><?= e(SITE['email']) ?></a>
      </p>
    </div>
    <?php foreach ($FOOTER as $col): ?>
    <div class="footer-col"><h4><?= e($col['heading']) ?></h4>
      <?php foreach ($col['items'] as $item): ?>
        <?php if (!empty($item['todo'])): ?>
        <span class="is-todo" title="Coming soon"><?= e($item['label']) ?></span>
        <?php else: ?>
        <a href="<?= e(nav_href($item)) ?>"><?= e($item['label']) ?></a>
        <?php endif; ?>
      <?php endforeach; ?>
    </div>
    <?php endforeach; ?>
  </div>
  <div class="container footer-destinations">
    <span class="fd-label">Popular destinations</span>
    <div class="fd-links">
      <?php foreach (nav_data()['destinations'] ?? [] as $d): ?>
      <a href="<?= e(nav_href($d)) ?>"><?= e($d['label']) ?></a>
      <?php endforeach; ?>
      <a href="<?= url('/countries') ?>" class="fd-all">All 216 countries &rarr;</a>
    </div>
  </div>

  <div class="container footer-disclosure">
    <p><strong><?= e(SITE['name']) ?>®</strong> — a unit of <?= e(SITE['parent']) ?> &middot; CIN: <?= e(SITE['cin']) ?><br>
    <?= e(SITE['address']['locality']) ?>, <?= e(SITE['address']['region']) ?>, India &middot;
    <a href="tel:<?= e(SITE['phone_href']) ?>"><?= e(SITE['phone']) ?></a> &middot;
    <a href="mailto:<?= e(SITE['email']) ?>"><?= e(SITE['email']) ?></a></p>
    <p class="footer-disclaimer"><?= e(NOT_A_GOVERNMENT_BODY) ?></p>
  </div>

  <div class="container footer-bottom">
    <p>&copy; 2015&ndash;<?= date('Y') ?> Copyright, a unit of <?= e(SITE['parent']) ?> &middot; CIN: <?= e(SITE['cin']) ?></p>
    <p><?= e(SITE['tagline']) ?></p>
  </div>
</footer>

<?php
$cvCustomer = customer_current();
$cvCountries = json_decode((string) file_get_contents(ROOT_PATH . '/data/all-countries.json'), true) ?: [];
include __DIR__ . '/enquire-now.php';
?>

<script src="/js/data.js"></script>
<script src="/js/common.js" defer></script>
<?= $extraScripts ?? '' ?>
