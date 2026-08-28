<?php
$page_meta = [
    'title' => 'Support | Paynancial Help Center',
    'description' => 'Get help with Paynancial payment products. Browse FAQs or contact our support team.',
];
$faqs = [
    ['How do I get started with Paynancial?', 'Reach out through our contact form or create an account, and our team will guide you through onboarding and KYC.'],
    ['Which payment methods are supported?', 'Cards, UPI, netbanking and wallets are supported through the Payment Gateway product.'],
    ['How do refunds work?', 'Refunds can be initiated from your dashboard and are tracked through to settlement.'],
    ['How do I report a security concern?', 'Email hello@paynancial.in with details and our team will respond promptly.'],
    ['How can partners track commission?', 'Commission and settlement tracking are available in the Partner Portal.'],
];
?>
<section style="padding-top:56px;">
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">Support</span>
      <h1>We're here to help.</h1>
      <p class="lead">Reach out for assistance with your Paynancial integration, account or a general question.</p>
    </div>
  </div>
</section>

<section class="section-subtle">
  <div class="container grid grid-3">
    <div class="card reveal">
      <span class="card-icon">◆</span>
      <h3>Sales</h3>
      <p>Talk to our team about accepting payments with Paynancial.</p>
      <a class="card-link" href="/contact?intent=sales">Contact Sales →</a>
    </div>
    <div class="card reveal">
      <span class="card-icon">◆</span>
      <h3>Help &amp; Support</h3>
      <p>Get help with an existing account or integration issue.</p>
      <a class="card-link" href="/contact?intent=support">Get Support →</a>
    </div>
    <div class="card reveal">
      <span class="card-icon">◆</span>
      <h3>Articles &amp; News</h3>
      <p>Read the latest on payment technology and product updates.</p>
      <a class="card-link" href="/blog">Read Articles →</a>
    </div>
  </div>
</section>

<section id="faqs" aria-labelledby="faqs-heading">
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">FAQs</span>
      <h2 id="faqs-heading">Frequently asked questions</h2>
    </div>
    <div class="grid" style="gap:14px;">
      <?php foreach ($faqs as $i => [$q, $a]): ?>
        <details class="card reveal" style="cursor:pointer;">
          <summary style="font-weight:650;list-style:none;"><?= e($q) ?></summary>
          <p class="text-muted" style="margin-top:12px;"><?= e($a) ?></p>
        </details>
      <?php endforeach; ?>
    </div>
  </div>
</section>

<section class="section-subtle">
  <div class="container">
    <div class="cta-band reveal">
      <h2>Still need help?</h2>
      <div class="hero-actions" style="justify-content:center;margin-top:24px;">
        <a href="/contact" class="btn btn-primary">Contact Support</a>
      </div>
    </div>
  </div>
</section>
