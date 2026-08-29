<?php
$page_meta = [
    'title'       => 'Products | Paynancial Payment Platform',
    'description' => 'Payment Gateway, Payment Links, Payment Collection, Payouts, Payment Analytics and APIs — the full Paynancial product suite.',
];
$products = [
    'payment-gateway'    => ['Payment Gateway', 'Accept cards, UPI, netbanking and wallets through a single, reliable integration.'],
    'payment-links'      => ['Payment Links', 'Collect payments without code — generate a secure, shareable link in seconds.'],
    'payment-collection' => ['Payment Collection', 'Automate recurring and bulk collections with reconciliation built in.'],
    'payouts'            => ['Payouts', 'Send payments to vendors, employees and partners from your dashboard or API.'],
    'payment-analytics'  => ['Payment Analytics', 'Track performance, settlements and reconciliation across every transaction.'],
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
  <div class="container grid grid-3">
    <?php foreach ($products as $slug => [$title, $desc]): ?>
      <a class="card reveal" href="/products/<?= e($slug) ?>">
        <span class="card-icon">◆</span>
        <h3><?= e($title) ?></h3>
        <p><?= e($desc) ?></p>
        <span class="card-link">Explore service →</span>
      </a>
    <?php endforeach; ?>
    <a class="card reveal" href="/developers">
      <span class="card-icon">◆</span>
      <h3>Payment APIs</h3>
      <p>Build custom payment experiences with developer-first APIs and webhooks.</p>
      <span class="card-link">Explore API documentation →</span>
    </a>
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
