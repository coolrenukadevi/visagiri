<?php
$page_meta = [
    'title' => 'Products | Paynancial Payment Platform',
    'description' => 'Payment Gateway, Payment Links, Payment Pages, Payment Collection, Payouts, Analytics and APIs — the full Paynancial product suite.',
];
$products = [
    'payment-gateway'    => ['Payment Gateway', 'Accept cards, UPI, netbanking and wallets through a single, reliable integration with clear settlement reporting.'],
    'payment-links'      => ['Payment Links', 'Generate a secure, shareable payment link in seconds — no code or website required.'],
    'payment-pages'      => ['Payment Pages', 'Branded, no-code checkout pages you can launch for campaigns or one-off collections.'],
    'payment-collection' => ['Payment Collection', 'Automate recurring and bulk collections with built-in reconciliation.'],
    'payouts'            => ['Payouts', 'Send payments to vendors, employees and partners directly from your dashboard or API.'],
    'analytics'          => ['Payment Analytics', 'Understand transaction performance with real-time dashboards and exportable reports.'],
    'dashboard'          => ['Business Dashboard', 'A single console for collections, settlements, refunds and analytics.'],
];
?>
<section style="padding-top:56px;">
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">Products</span>
      <h1>A complete, modular payments platform.</h1>
      <p class="lead">Adopt one product or the full Paynancial stack — every module is built to work together.</p>
    </div>
  </div>
</section>

<section class="section-subtle">
  <div class="container">
    <?php foreach ($products as $slug => [$title, $desc]): ?>
      <div class="card reveal" id="<?= e($slug) ?>" style="margin-bottom:20px;">
        <div class="grid" style="grid-template-columns: 2fr 1fr; align-items:center; gap:24px;">
          <div>
            <h3><?= e($title) ?></h3>
            <p style="margin-top:8px;"><?= e($desc) ?></p>
          </div>
          <div style="text-align:right;">
            <a href="/contact?intent=sales&product=<?= e($slug) ?>" class="btn btn-outline btn-sm">Talk to Sales</a>
          </div>
        </div>
      </div>
    <?php endforeach; ?>
  </div>
</section>

<section>
  <div class="container">
    <div class="cta-band reveal">
      <h2>Ready to start accepting payments?</h2>
      <div class="hero-actions" style="justify-content:center;margin-top:24px;">
        <a href="/contact" class="btn btn-primary">Get Started</a>
        <a href="/developers" class="btn btn-outline">Explore APIs</a>
      </div>
    </div>
  </div>
</section>
