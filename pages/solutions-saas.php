<?php
$faqs = [
    ['Can I migrate existing subscriptions from another billing provider?', 'Yes — subscriptions, plans and payment methods can be imported via API or a guided migration with the integration team.'],
    ['Does this support usage-based or metered billing?', 'Metered and hybrid (seat + usage) billing models are supported alongside flat-rate subscriptions.'],
    ['What happens when a renewal payment fails?', 'Smart Collections retries on a configurable schedule and triggers dunning communication before a subscription lapses.'],
    ['Can multiple team members access billing and reconciliation data?', 'Yes — role-based dashboard access lets finance, support and engineering see only what they need.'],
];
$page_meta = [
    'title'       => 'SaaS Payment Infrastructure & Subscription Billing | Paynancial',
    'description' => 'Subscription billing, recurring payments and automated reconciliation for SaaS companies — one platform, connected end to end.',
    'schema'      => [
        '@context' => 'https://schema.org',
        '@graph'   => [
            [
                '@type' => 'BreadcrumbList',
                'itemListElement' => [
                    ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => site_url('/')],
                    ['@type' => 'ListItem', 'position' => 2, 'name' => 'Solutions', 'item' => site_url('/solutions')],
                    ['@type' => 'ListItem', 'position' => 3, 'name' => 'SaaS & Subscription Businesses', 'item' => site_url('/solutions/saas')],
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
      <span class="current">SaaS &amp; Subscription Businesses</span>
    </nav>
    <div class="section-head reveal">
      <span class="eyebrow">Solutions · SaaS &amp; Subscription Businesses</span>
      <h1>Financial infrastructure for the businesses building what's next.</h1>
      <p class="lead">Subscription billing, recurring collection, payouts and reconciliation — connected through one platform, so your team spends less time reconciling spreadsheets and more time shipping product.</p>
      <div class="hero-actions" style="margin-top:24px;">
        <a href="/contact?intent=sales&solution=saas" class="btn btn-primary">Talk to a Solutions Specialist</a>
        <a href="/developers" class="btn btn-outline">Read the API Docs</a>
      </div>
    </div>
  </div>
</section>

<section class="section-subtle">
  <div class="container">
    <div class="story">
      <p class="story-lead reveal">Most SaaS teams start recurring billing with a cron job and a prayer: manual retries on failed cards, revenue recognized by hand, and a support inbox full of "why was I charged twice." It works until it doesn't — usually right when growth starts to matter.</p>
      <div class="reveal">
        <p>Paynancial handles the full subscription lifecycle — plan changes, proration, failed-payment retries, dunning communication and revenue reconciliation — so what reaches your finance team is already matched, not a CSV to untangle.</p>
        <p>The result: fewer involuntary cancellations from failed renewals, a finance team that trusts the numbers in the dashboard, and an engineering team that isn't maintaining billing logic as a side project.</p>
      </div>
    </div>
  </div>
</section>

<section>
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">Relevant Products</span>
      <h2>Everything a subscription business needs, connected.</h2>
    </div>
    <div class="grid grid-4">
      <a class="card reveal" href="/contact?intent=sales&product=subscription-billing">
        <span class="card-icon">◆</span>
        <h3>Subscription Billing</h3>
        <p>Plans, proration, upgrades and downgrades handled automatically.</p>
        <span class="card-link">Explore →</span>
      </a>
      <a class="card reveal" href="/contact?intent=sales&product=recurring-payments">
        <span class="card-icon">◆</span>
        <h3>Recurring Payments</h3>
        <p>Card, UPI Autopay and netbanking mandates in one flow.</p>
        <span class="card-link">Explore →</span>
      </a>
      <a class="card reveal" href="/products/payment-collection">
        <span class="card-icon">◆</span>
        <h3>Smart Collections</h3>
        <p>Failed-payment retry logic tuned to reduce involuntary churn.</p>
        <span class="card-link">Explore service →</span>
      </a>
      <a class="card reveal" href="/products/payment-analytics">
        <span class="card-icon">◆</span>
        <h3>Payment Analytics</h3>
        <p>MRR, churn and reconciliation views without a BI project.</p>
        <span class="card-link">Explore service →</span>
      </a>
    </div>
  </div>
</section>

<section class="section-subtle">
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">Workflow</span>
      <h2>The SaaS payment lifecycle.</h2>
    </div>
    <div class="lifecycle-strip reveal">
      <div class="step"><b>01</b> Sign Up</div>
      <div class="step"><b>02</b> Subscribe</div>
      <div class="step"><b>03</b> Bill</div>
      <div class="step"><b>04</b> Collect</div>
      <div class="step"><b>05</b> Retry</div>
      <div class="step"><b>06</b> Reconcile</div>
      <div class="step"><b>07</b> Analyze</div>
    </div>
  </div>
</section>

<section id="api-integration">
  <div class="container">
    <div style="display:grid;gap:48px;grid-template-columns:1fr;align-items:center;" class="grid-2">
      <div class="reveal">
        <span class="eyebrow">API &amp; Integration</span>
        <h2>Built for the way SaaS teams ship.</h2>
        <p class="lead">Subscription, billing and reconciliation APIs alongside webhooks for every lifecycle event, with a sandbox for testing your billing logic before it touches a real customer.</p>
        <a href="/developers" class="btn btn-primary" style="margin-top:24px;">Explore API Documentation</a>
      </div>
      <div class="code-panel reveal">
        <div class="code-tabs">
          <button class="code-tab is-active" data-lang="php">PHP</button>
          <button class="code-tab" data-lang="curl">cURL</button>
        </div>
        <div class="code-body">
          <button class="copy-btn" type="button">Copy</button>
          <pre data-code-block="php"><code>$client = new Paynancial\Client('YOUR_API_KEY');

$subscription = $client->subscriptions->create([
    'customer_id' => 'cust_7Fk21',
    'plan_id'     => 'plan_pro_monthly',
    'start_at'    => 'now',
]);

echo $subscription->id;</code></pre>
          <pre data-code-block="curl" style="display:none"><code>curl https://api.paynancial.com/v1/subscriptions \
  -u YOUR_API_KEY: \
  -d customer_id=cust_7Fk21 \
  -d plan_id=plan_pro_monthly \
  -d start_at=now</code></pre>
        </div>
      </div>
    </div>
  </div>
</section>

<section class="section-subtle">
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">AI Capabilities</span>
      <h2>Fewer surprises in monthly revenue.</h2>
      <p>AI Reconciliation matches settlements against subscriptions automatically; AI Revenue Forecasting flags likely churn and expected MRR shifts before they show up in the board deck.</p>
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
        <h3 style="font-size:1rem;">Project-management SaaS</h3>
        <p style="margin-top:8px;">Uses Subscription Billing for three pricing tiers and Smart Collections to recover roughly 18% of failed renewal attempts automatically.</p>
      </div>
      <div class="card reveal">
        <h3 style="font-size:1rem;">Vertical SaaS for clinics</h3>
        <p style="margin-top:8px;">Bills practices monthly via Recurring Payments while reconciling against per-seat usage with Payment Analytics.</p>
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
      <h2>Ready to move your billing off spreadsheets?</h2>
      <div class="hero-actions" style="justify-content:center;margin-top:24px;">
        <a href="/contact?intent=sales&solution=saas" class="btn btn-primary">Talk to a Solutions Specialist</a>
        <a href="/solutions/startups" class="btn btn-outline">See Startup Solutions</a>
      </div>
    </div>
  </div>
</section>
