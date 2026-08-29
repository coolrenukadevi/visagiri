<?php
$page_meta = [
    'title'       => 'Products | Paynancial Payment Platform',
    'description' => 'Payment Gateway, Payouts, Financial Operations, AI & Intelligence, Embedded Finance and a full Developer Platform — the complete Paynancial product suite.',
];
$featured = [
    'payment-gateway'    => ['Payment Gateway', 'Accept cards, UPI, netbanking and wallets through a single, reliable integration.'],
    'payment-links'      => ['Payment Links', 'Collect payments without code — generate a secure, shareable link in seconds.'],
    'payment-collection' => ['Smart Collections', 'Automate recurring and bulk collections with reconciliation built in.'],
    'payouts'            => ['Payouts', 'Send payments to vendors, employees and partners from your dashboard or API.'],
    'payment-analytics'  => ['Payment Analytics', 'Track performance, settlements and reconciliation across every transaction.'],
];
$catalog = [
    'Accept & Collect' => [
        ['Payment Gateway', '/products/payment-gateway'],
        ['Payment Links', '/products/payment-links'],
        ['Payment Pages', '/contact?intent=sales&product=payment-pages'],
        ['UPI Payments', '/contact?intent=sales&product=upi-payments'],
        ['Recurring Payments', '/contact?intent=sales&product=recurring-payments'],
        ['Subscription Billing', '/contact?intent=sales&product=subscription-billing'],
        ['Smart Collections', '/products/payment-collection'],
    ],
    'Pay & Move Money' => [
        ['Payouts', '/products/payouts'],
        ['Bulk Payouts', '/contact?intent=sales&product=bulk-payouts'],
        ['Vendor Payments', '/contact?intent=sales&product=vendor-payments'],
        ['Employee Payments', '/contact?intent=sales&product=employee-payments'],
        ['Partner Payments', '/contact?intent=sales&product=partner-payments'],
        ['International Payments', '/contact?intent=sales&product=international-payments'],
    ],
    'Financial Operations' => [
        ['Reconciliation', '/products/payment-analytics'],
        ['Settlements', '/products/payment-analytics'],
        ['Refunds', '/products/payment-analytics'],
        ['Chargebacks', '/contact?intent=sales&product=chargebacks'],
        ['Invoice Management', '/contact?intent=sales&product=invoice-management'],
        ['Expense Management', '/contact?intent=sales&product=expense-management'],
        ['Finance Analytics', '/products/payment-analytics'],
        ['MIS & Reports', '/contact?intent=sales&product=mis-reports'],
    ],
    'AI & Intelligence' => [
        ['Paynancial AI', '/contact?intent=sales&product=paynancial-ai'],
        ['AI Fraud Detection', '/contact?intent=sales&product=ai-fraud-detection'],
        ['AI Reconciliation', '/contact?intent=sales&product=ai-reconciliation'],
        ['AI Financial Assistant', '/contact?intent=sales&product=ai-financial-assistant'],
        ['AI Cash-Flow Intelligence', '/contact?intent=sales&product=ai-cash-flow-intelligence'],
        ['AI Revenue Forecasting', '/contact?intent=sales&product=ai-revenue-forecasting'],
    ],
    'Embedded Finance' => [
        ['Embedded Payments', '/contact?intent=sales&product=embedded-payments'],
        ['Embedded Payouts', '/contact?intent=sales&product=embedded-payouts'],
        ['Embedded Billing', '/contact?intent=sales&product=embedded-billing'],
        ['Wallet Infrastructure', '/contact?intent=sales&product=wallet-infrastructure'],
        ['Split Payments', '/contact?intent=sales&product=split-payments'],
        ['White-Label Payments', '/contact?intent=sales&product=white-label-payments'],
    ],
    'Developer Platform' => [
        ['Payment APIs', '/developers#docs'],
        ['Payout APIs', '/developers#docs'],
        ['SDKs', '/developers#sdks'],
        ['Webhooks', '/developers#webhooks'],
        ['Sandbox', '/developers#sandbox'],
        ['API Dashboard', '/developers'],
    ],
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
    <?php foreach ($featured as $slug => [$title, $desc]): ?>
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
    <div class="section-head reveal">
      <span class="eyebrow">Full Catalog</span>
      <h2>Every product, by category.</h2>
    </div>
    <div class="ledger reveal catalog-list">
      <?php foreach ($catalog as $category => $items): ?>
        <div class="ledger-row catalog-row">
          <span class="ledger-tag"><?= e($category) ?></span>
          <div class="pill-list">
            <?php foreach ($items as [$label, $href]): ?>
              <a class="pill" href="<?= e($href) ?>"><?= e($label) ?></a>
            <?php endforeach; ?>
          </div>
        </div>
      <?php endforeach; ?>
    </div>
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
