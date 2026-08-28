<?php
$page_meta = [
    'title' => 'Partners | Paynancial Partner Program',
    'description' => 'Grow with Paynancial as a reseller, referral or technology partner.',
];
?>
<section style="padding-top:56px;">
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">Partners</span>
      <h1>Grow your business with the Paynancial Partner Program.</h1>
      <p class="lead">Partner with us as a reseller, referral or technology partner and unlock commission on every business you bring onboard.</p>
      <div class="hero-actions">
        <button type="button" class="btn btn-primary" data-login-open="partner">Partner Login</button>
        <a href="/contact?intent=partner" class="btn btn-outline">Become a Partner</a>
      </div>
    </div>
  </div>
</section>

<section class="section-subtle">
  <div class="container grid grid-3">
    <div class="card reveal"><span class="card-icon">◆</span><h3>Reseller Partners</h3><p>Resell Paynancial products under your own commercial relationship with merchants.</p></div>
    <div class="card reveal"><span class="card-icon">◆</span><h3>Referral Partners</h3><p>Refer businesses to Paynancial and earn commission on successful onboarding.</p></div>
    <div class="card reveal"><span class="card-icon">◆</span><h3>Technology Partners</h3><p>Integrate Paynancial into your own software platform or marketplace.</p></div>
  </div>
</section>

<section>
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">Partner Portal</span>
      <h2>Everything a partner needs, in one dashboard.</h2>
      <p>Track customers, transactions, settlements and commission from your dedicated Partner Portal.</p>
    </div>
    <div class="pill-list reveal">
      <?php foreach (['KYC onboarding', 'Commission tracking', 'Settlement tracking', 'API keys & webhooks', 'Downloadable reports'] as $f): ?>
        <span class="pill"><?= e($f) ?></span>
      <?php endforeach; ?>
    </div>
  </div>
</section>

<section class="section-subtle">
  <div class="container">
    <div class="cta-band reveal" style="background:linear-gradient(120deg, var(--orange-600), var(--navy-900));">
      <h2>Ready to become a Paynancial partner?</h2>
      <div class="hero-actions" style="justify-content:center;margin-top:24px;">
        <a href="/contact?intent=partner" class="btn btn-primary">Apply Now</a>
      </div>
    </div>
  </div>
</section>
