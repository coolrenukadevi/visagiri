<?php
$faqs = [
    ['How fast can we go live?', 'Sandbox access is instant on sign-up, and most teams complete a basic integration in a few days using the hosted checkout and Payment Links — no PCI infrastructure to build yourself.'],
    ['Do we need to commit to volume upfront?', 'No — pricing scales with what you actually process, so early-stage volume doesn\'t require a minimum commitment.'],
    ['Can we start with Payment Links and move to the full API later?', 'Yes — Payment Links, the hosted Payment Gateway and the full API all run on the same account and data, so switching later doesn\'t mean re-integrating from scratch.'],
    ['What happens as our transaction volume grows?', 'The same infrastructure carries you from first transaction to enterprise volume — Payouts, Reconciliation and Analytics scale with usage rather than requiring a new platform.'],
];
$page_meta = [
    'title'       => 'Startup Payment Infrastructure & Payment Gateway | Paynancial',
    'description' => 'Payment infrastructure for early-stage businesses — integrate fast, collect payments, pay vendors, and scale without switching providers.',
    'schema'      => [
        '@context' => 'https://schema.org',
        '@graph'   => [
            [
                '@type' => 'BreadcrumbList',
                'itemListElement' => [
                    ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => site_url('/')],
                    ['@type' => 'ListItem', 'position' => 2, 'name' => 'Solutions', 'item' => site_url('/solutions')],
                    ['@type' => 'ListItem', 'position' => 3, 'name' => 'Startups & New Businesses', 'item' => site_url('/solutions/startups')],
                ],
            ],
            [
                '@type'      => 'FAQPage',
                'mainEntity' => array_map(static fn($f) => [
                    '@type'          => 'Question',
                    'name'           => $f[0],
                    'acceptedAnswer' => ['@type' => 'Answer', 'text' => $f[1]],
                ], $faqs),
            ],
        ],
    ],
];
?>
<section style="padding-top:56px;">
  <div class="container">
    <nav class="breadcrumb reveal" aria-label="Breadcrumb">
      <a href="/">Home</a><span aria-hidden="true">/</span>
      <a href="/solutions">Solutions</a><span aria-hidden="true">/</span>
      <span class="current">Startups &amp; New Businesses</span>
    </nav>
    <div class="section-head reveal">
      <span class="eyebrow">Solutions · Startups &amp; New Businesses</span>
      <h1>From your first transaction to your next million.</h1>
      <p class="lead">Paynancial provides the financial infrastructure to help startups launch, collect, pay, reconcile and scale — without switching providers at every stage.</p>
      <div class="hero-actions" style="margin-top:24px;">
        <a href="/contact?intent=sales&solution=startups" class="btn btn-primary">Talk to a Solutions Specialist</a>
        <a href="/developers#sandbox" class="btn btn-outline">Get Sandbox Access</a>
      </div>
    </div>
  </div>
</section>

<section class="section-subtle">
  <div class="container">
    <div class="story">
      <p class="story-lead reveal">Early-stage teams don't have a fintech team, and shouldn't need one just to accept a payment. But most payment providers are built for businesses that already know their volume, their reconciliation process and their compliance needs.</p>
      <div class="reveal">
        <p>Paynancial is built to be integrated in days, not sprints: a sandbox to build against immediately, Payment Links if you don't have a checkout yet, and a full API when you do — all on the same account, so nothing needs re-integrating as you grow.</p>
        <p>The same platform that gets your first transaction through also handles vendor payouts, reconciliation and analytics once you're processing at scale — one provider from MVP to Series B and beyond.</p>
      </div>
    </div>
  </div>
</section>

<section>
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">Relevant Products</span>
      <h2>Start small, keep the same platform as you grow.</h2>
    </div>
    <div class="grid grid-4">
      <a class="card reveal" href="/products/payment-gateway">
        <span class="card-icon">◆</span>
        <h3>Payment Gateway</h3>
        <p>Accept cards, UPI, netbanking and wallets through one integration.</p>
        <span class="card-link">Explore service →</span>
      </a>
      <a class="card reveal" href="/products/payment-links">
        <span class="card-icon">◆</span>
        <h3>Payment Links</h3>
        <p>Collect your first payments before you've built a checkout.</p>
        <span class="card-link">Explore service →</span>
      </a>
      <a class="card reveal" href="/products/payouts">
        <span class="card-icon">◆</span>
        <h3>Payouts</h3>
        <p>Pay vendors, freelancers and early hires from day one.</p>
        <span class="card-link">Explore service →</span>
      </a>
      <a class="card reveal" href="/products/payment-analytics">
        <span class="card-icon">◆</span>
        <h3>Payment Analytics</h3>
        <p>Understand revenue and reconciliation as volume grows.</p>
        <span class="card-link">Explore service →</span>
      </a>
    </div>
  </div>
</section>

<section class="section-subtle" id="stages">
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">Built for Startups</span>
      <h2>Four stages, one platform.</h2>
    </div>
    <div class="journey reveal">
      <div class="journey-step">
        <div class="num">1</div>
        <strong>Build</strong>
        <span>Payment APIs + Sandbox — integrate and test before you're live.</span>
      </div>
      <div class="journey-step">
        <div class="num">2</div>
        <strong>Launch</strong>
        <span>Payment Gateway + Payment Links — start collecting real payments.</span>
      </div>
      <div class="journey-step">
        <div class="num">3</div>
        <strong>Scale</strong>
        <span>Subscriptions + Collections + Payouts — handle growing volume and vendors.</span>
      </div>
      <div class="journey-step">
        <div class="num">4</div>
        <strong>Optimize</strong>
        <span>AI + Analytics + Reconciliation — understand and improve what's already running.</span>
      </div>
    </div>
  </div>
</section>

<section id="api-integration">
  <div class="container">
    <div style="display:grid;gap:48px;grid-template-columns:1fr;align-items:center;" class="grid-2">
      <div class="reveal">
        <span class="eyebrow">API &amp; Integration</span>
        <h2>MVP-friendly, without staying that way.</h2>
        <p class="lead">A sandbox environment, clear error codes and a hosted checkout mean a working integration is usually a few days of engineering time, not a quarter-long project.</p>
        <a href="/developers" class="btn btn-primary" style="margin-top:24px;">Explore API Documentation</a>
      </div>
      <div class="code-panel reveal">
        <div class="code-tabs">
          <button class="code-tab is-active" data-lang="php">PHP</button>
          <button class="code-tab" data-lang="curl">cURL</button>
        </div>
        <div class="code-body">
          <button class="copy-btn" type="button">Copy</button>
          <pre data-code-block="php"><code>$client = new Paynancial\Client('YOUR_SANDBOX_KEY');

$payment = $client->payments->create([
    'amount'   => 50000, // in paise
    'currency' => 'INR',
    'receipt'  => 'first_order_001',
]);

echo $payment->id;</code></pre>
          <pre data-code-block="curl" style="display:none"><code>curl https://api.paynancial.com/v1/payments \
  -u YOUR_SANDBOX_KEY: \
  -d amount=50000 \
  -d currency=INR \
  -d receipt=first_order_001</code></pre>
        </div>
      </div>
    </div>
  </div>
</section>

<section class="section-subtle">
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">AI Capabilities</span>
      <h2>Intelligence that grows with your data.</h2>
      <p>AI Fraud Detection starts protecting transactions from day one, and AI Cash-Flow Intelligence becomes more useful as transaction history builds — no separate tooling to adopt later.</p>
    </div>
    <div class="compliance-note reveal">Paynancial's AI features assist with pattern detection and forecasting; they do not guarantee fraud prevention, approval rates, or revenue outcomes. Embedded finance, wallet and banking-adjacent capabilities referenced on this site are available subject to applicable regulatory requirements, licensing and partner arrangements, and are provided through Paynancial's technology layer in conjunction with regulated banking and payment partners — Paynancial does not act as a bank or licensed payment institution.</div>
  </div>
</section>

<section>
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">Use Cases</span>
      <h2>Where this shows up in practice.</h2>
    </div>
    <div class="grid grid-2">
      <div class="card reveal">
        <h3 style="font-size:1rem;">Pre-seed D2C brand</h3>
        <p style="margin-top:8px;">Launches with Payment Links before a storefront exists, then moves to the full Payment Gateway once the website ships.</p>
      </div>
      <div class="card reveal">
        <h3 style="font-size:1rem;">Two-sided marketplace MVP</h3>
        <p style="margin-top:8px;">Uses the sandbox to validate its matching model, then turns on Payouts to pay suppliers once the first real transactions land.</p>
      </div>
    </div>
  </div>
</section>

<section class="section-subtle" id="faqs" aria-labelledby="faqs-heading">
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">FAQs</span>
      <h2 id="faqs-heading">Common questions</h2>
    </div>
    <div class="grid" style="gap:14px;">
      <?php foreach ($faqs as [$q, $a]): ?>
        <details class="card reveal" style="cursor:pointer;">
          <summary style="font-weight:650;list-style:none;"><?= e($q) ?></summary>
          <p class="text-muted" style="margin-top:12px;"><?= e($a) ?></p>
        </details>
      <?php endforeach; ?>
    </div>
  </div>
</section>

<section>
  <div class="container">
    <div class="cta-band reveal">
      <h2>Building something new? Let's talk infrastructure.</h2>
      <div class="hero-actions" style="justify-content:center;margin-top:24px;">
        <a href="/contact?intent=sales&solution=startups" class="btn btn-primary">Talk to a Solutions Specialist</a>
        <a href="/solutions/saas" class="btn btn-outline">See SaaS Solutions</a>
      </div>
    </div>
  </div>
</section>
