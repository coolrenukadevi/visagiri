<?php
$page_meta = [
    'title' => 'Paynancial | Smarter Payment Infrastructure for Modern Businesses',
    'description' => 'Paynancial helps businesses accept, manage and analyze payments through secure, intelligent and scalable technology.',
    'schema' => organization_schema(),
];
?>
<section class="hero">
  <div class="container">
    <div class="hero-copy reveal">
      <span class="eyebrow">Paynancial Technology Pvt. Ltd.</span>
      <h1>Powering Smarter Payments.<br>Built for the Future.</h1>
      <p class="lead">Secure, intelligent and seamless payment technology designed to help businesses collect, manage and grow.</p>
      <div class="hero-actions">
        <a href="/contact" class="btn btn-primary">Get Started</a>
        <a href="/contact?intent=sales" class="btn btn-outline">Talk to Sales</a>
      </div>
    </div>

    <div class="reveal">
      <div class="dash-card" aria-hidden="true">
        <span class="badge-float top">⚡ Real-time processing</span>
        <div class="dash-card-head">
          <strong>Business Dashboard</strong>
          <span class="dash-live">Live preview</span>
        </div>
        <div class="dash-grid">
          <div class="dash-stat"><span>Total Transactions</span><strong data-counter="18420" data-suffix="">0</strong></div>
          <div class="dash-stat accent"><span>Successful Payments</span><strong data-counter="97.6" data-decimals="1" data-suffix="%">0%</strong></div>
          <div class="dash-stat"><span>Today's Collection</span><strong data-counter="4.8" data-decimals="1" data-suffix=" L">0 L</strong></div>
          <div class="dash-stat"><span>Pending Settlements</span><strong data-counter="12" data-suffix="">0</strong></div>
        </div>
        <div class="dash-bars">
          <span style="height:40%"></span><span style="height:65%"></span><span style="height:52%"></span>
          <span style="height:80%"></span><span style="height:58%"></span><span style="height:90%"></span>
          <span style="height:70%"></span><span style="height:100%"></span>
        </div>
        <div class="dash-list">
          <div class="dash-row"><span>UPI · Retail order #8823</span><span class="status success">Success</span></div>
          <div class="dash-row"><span>Card · Subscription renewal</span><span class="status success">Success</span></div>
          <div class="dash-row"><span>Netbanking · Vendor payout</span><span class="status pending">Pending</span></div>
        </div>
        <span class="badge-float bottom">✔ Success Rate 97.6%</span>
      </div>
    </div>
  </div>
</section>

<section id="products" aria-labelledby="products-heading">
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">Platform</span>
      <h2 id="products-heading">Everything You Need to Move Money</h2>
      <p>A modular payments stack — use one product or the entire platform.</p>
    </div>
    <div class="grid grid-3">
      <?php
      $products = [
          ['Payment Gateway', 'Accept cards, UPI, netbanking and wallets through a single, reliable integration.', '/products#payment-gateway'],
          ['Payment Links', 'Create a shareable link and collect payments without any code.', '/products#payment-links'],
          ['Payment Collection', 'Automate recurring and bulk collections with reconciliation built in.', '/products#payment-collection'],
          ['Payouts', 'Send money to vendors, employees and partners in a few clicks.', '/products#payouts'],
          ['Payment Analytics', 'Track performance, spot trends and understand every transaction.', '/products#analytics'],
          ['Payment APIs', 'Build custom payment experiences with developer-first APIs.', '/developers'],
      ];
      foreach ($products as [$title, $desc, $href]): ?>
        <a class="card reveal" href="<?= e($href) ?>">
          <span class="card-icon">◆</span>
          <h3><?= e($title) ?></h3>
          <p><?= e($desc) ?></p>
          <span class="card-link">Learn more →</span>
        </a>
      <?php endforeach; ?>
    </div>
  </div>
</section>

<section class="section-subtle" aria-labelledby="industries-heading">
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">Solutions</span>
      <h2 id="industries-heading">Built for Every Business</h2>
      <p>Payment infrastructure shaped around how your industry actually works.</p>
    </div>
    <div class="pill-list reveal">
      <?php
      $industries = ['E-Commerce', 'Travel', 'Healthcare', 'Education', 'Retail', 'Hospitality', 'Services', 'Enterprise'];
      foreach ($industries as $i): ?>
        <a class="pill" href="/solutions#<?= e(strtolower($i)) ?>"><?= e($i) ?></a>
      <?php endforeach; ?>
    </div>
  </div>
</section>

<section aria-labelledby="visibility-heading">
  <div class="container">
    <div class="section-head center reveal">
      <span class="eyebrow">Visibility</span>
      <h2 id="visibility-heading">One Platform. Complete Payment Visibility.</h2>
      <p>Collections, transactions, settlements, refunds, analytics and reports — in one console.</p>
    </div>
    <div class="dash-card reveal" style="max-width:920px;margin-inline:auto;" aria-hidden="true">
      <div class="dash-card-head"><strong>Payment Operations</strong><span class="dash-live">Live preview</span></div>
      <div class="dash-grid" style="grid-template-columns:repeat(3,1fr);">
        <div class="dash-stat"><span>Collections</span><strong>₹4.8L</strong></div>
        <div class="dash-stat"><span>Settlements</span><strong>₹4.2L</strong></div>
        <div class="dash-stat"><span>Refunds</span><strong>₹6.1K</strong></div>
        <div class="dash-stat accent"><span>Transactions</span><strong>18,420</strong></div>
        <div class="dash-stat"><span>Analytics events</span><strong>2.3K/hr</strong></div>
        <div class="dash-stat"><span>Reports generated</span><strong>36</strong></div>
      </div>
      <div class="dash-bars"><span style="height:30%"></span><span style="height:55%"></span><span style="height:48%"></span><span style="height:72%"></span><span style="height:60%"></span><span style="height:88%"></span><span style="height:66%"></span><span style="height:95%"></span><span style="height:80%"></span><span style="height:100%"></span></div>
    </div>
  </div>
</section>

<section class="section-dark" aria-labelledby="tech-heading">
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">Technology</span>
      <h2 id="tech-heading">Technology That Works Behind Every Transaction</h2>
      <p>Infrastructure engineered for reliability, speed and clarity.</p>
    </div>
    <div class="grid grid-3">
      <?php
      $tech = [
          ['Secure Infrastructure', 'Encrypted data in transit and at rest, with strict access controls.'],
          ['Real-Time Processing', 'Transactions and status updates reflected as they happen.'],
          ['API Integration', 'REST APIs and webhooks designed for developers.'],
          ['AI-Powered Insights', 'Pattern recognition that surfaces useful signals from your data.'],
          ['Fraud Monitoring', 'Continuous monitoring for unusual transaction behaviour.'],
          ['Scalable Architecture', 'Built to grow with your transaction volume.'],
      ];
      foreach ($tech as [$title, $desc]): ?>
        <div class="card dark reveal">
          <span class="card-icon">▣</span>
          <h3><?= e($title) ?></h3>
          <p><?= e($desc) ?></p>
        </div>
      <?php endforeach; ?>
    </div>
  </div>
</section>

<section aria-labelledby="developers-heading">
  <div class="container">
    <div style="display:grid;gap:48px;grid-template-columns:1fr;align-items:center;" class="grid-2">
      <div class="reveal">
        <span class="eyebrow">Developers</span>
        <h2 id="developers-heading">Built for Developers</h2>
        <p class="lead">Integrate payments in minutes with clear documentation, sandbox testing and libraries for the languages you already use.</p>
        <a href="/developers" class="btn btn-primary" style="margin-top:24px;">Explore Developer APIs</a>
      </div>
      <div class="code-panel reveal">
        <div class="code-tabs">
          <button class="code-tab is-active" data-lang="php">PHP</button>
          <button class="code-tab" data-lang="js">JavaScript</button>
          <button class="code-tab" data-lang="curl">cURL</button>
        </div>
        <div class="code-body">
          <button class="copy-btn" type="button">Copy</button>
          <pre data-code-block="php"><code>$client = new Paynancial\Client('YOUR_API_KEY');

$payment = $client->payments->create([
    'amount'   =&gt; 50000, // in paise
    'currency' =&gt; 'INR',
    'receipt'  =&gt; 'order_rcpt_101',
]);

echo $payment->id;</code></pre>
          <pre data-code-block="js" style="display:none"><code>const client = new Paynancial({ key: 'YOUR_API_KEY' });

const payment = await client.payments.create({
  amount: 50000,
  currency: 'INR',
  receipt: 'order_rcpt_101',
});

console.log(payment.id);</code></pre>
          <pre data-code-block="curl" style="display:none"><code>curl https://api.paynancial.com/v1/payments \
  -u YOUR_API_KEY: \
  -d amount=50000 \
  -d currency=INR \
  -d receipt=order_rcpt_101</code></pre>
        </div>
      </div>
    </div>
  </div>
</section>

<section class="section-subtle" aria-labelledby="ai-heading">
  <div class="container">
    <div class="section-head center reveal">
      <span class="eyebrow">Intelligence</span>
      <h2 id="ai-heading">Payments, Powered by Intelligence.</h2>
      <p>We apply data science to payment operations so your team spends less time reconciling and more time growing.</p>
    </div>
    <div class="grid grid-3">
      <?php
      $ai = [
          ['Payment Analytics', 'Understand transaction trends across methods, time and geography.'],
          ['Anomaly Detection', 'Surface unusual transaction patterns for review.'],
          ['Risk Signals', 'Contextual signals to support risk and fraud decisions.'],
          ['Business Intelligence', 'Dashboards that turn raw payment data into decisions.'],
          ['Predictive Insights', 'Forward-looking views on collection and settlement trends.'],
          ['Automated Reporting', 'Scheduled reports delivered without manual effort.'],
      ];
      foreach ($ai as [$title, $desc]): ?>
        <div class="card reveal">
          <span class="card-icon">✦</span>
          <h3><?= e($title) ?></h3>
          <p><?= e($desc) ?></p>
        </div>
      <?php endforeach; ?>
    </div>
  </div>
</section>

<section aria-labelledby="security-heading">
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">Security</span>
      <h2 id="security-heading">Security Built Into Every Transaction</h2>
      <p>Protecting customer data and payment integrity is foundational to how we build.</p>
    </div>
    <div class="grid grid-3">
      <?php
      $sec = [
          ['Data Protection', 'Sensitive data is encrypted and access is tightly controlled.'],
          ['Secure Authentication', 'Password hashing, session protection and login monitoring by default.'],
          ['Encrypted Communication', 'All traffic is served over HTTPS/TLS.'],
          ['Access Control', 'Role-based permissions across every portal.'],
          ['Transaction Monitoring', 'Ongoing monitoring of platform activity.'],
          ['Fraud Prevention', 'Layered controls designed to reduce fraudulent activity.'],
      ];
      foreach ($sec as [$title, $desc]): ?>
        <div class="card reveal">
          <span class="card-icon">🛡</span>
          <h3><?= e($title) ?></h3>
          <p><?= e($desc) ?></p>
        </div>
      <?php endforeach; ?>
    </div>
    <p class="text-muted reveal" style="margin-top:24px;font-size:0.85rem;">Certification and regulatory status will be published on our <a href="/security">Security &amp; Compliance</a> page as they are formally verified.</p>
  </div>
</section>

<section class="section-subtle" aria-labelledby="why-heading">
  <div class="container">
    <div class="section-head center reveal">
      <span class="eyebrow">Why Paynancial</span>
      <h2 id="why-heading">Why Businesses Choose Paynancial</h2>
    </div>
    <div class="pill-list reveal" style="justify-content:center;">
      <?php foreach (['Secure', 'Fast', 'Scalable', 'Intelligent', 'Transparent', 'Reliable'] as $w): ?>
        <span class="pill"><?= e($w) ?></span>
      <?php endforeach; ?>
    </div>
  </div>
</section>

<section aria-labelledby="journey-heading">
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">Getting Started</span>
      <h2 id="journey-heading">From First Payment to Business Growth</h2>
    </div>
    <div class="journey reveal">
      <?php
      $journey = ['Sign Up', 'KYC', 'Integrate', 'Accept Payments', 'Monitor', 'Settle', 'Grow'];
      foreach ($journey as $i => $step): ?>
        <div class="journey-step">
          <div class="num"><?= $i + 1 ?></div>
          <strong><?= e($step) ?></strong>
        </div>
      <?php endforeach; ?>
    </div>
  </div>
</section>

<section class="section-subtle" aria-labelledby="testimonials-heading">
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">Testimonials</span>
      <h2 id="testimonials-heading">What Businesses Say</h2>
    </div>
    <div class="grid grid-3">
      <?php for ($i = 1; $i <= 3; $i++): ?>
        <div class="testimonial-card reveal">
          <p class="quote">"Placeholder testimonial content — replace with a verified customer quote once available."</p>
          <div class="testimonial-who">
            <div class="testimonial-avatar">?</div>
            <div><strong>Business Name</strong><div class="text-muted" style="font-size:0.8rem;">Role, Company</div></div>
          </div>
          <span class="placeholder-tag">Placeholder content</span>
        </div>
      <?php endfor; ?>
    </div>
  </div>
</section>

<section aria-labelledby="cta-heading">
  <div class="container">
    <div class="cta-band reveal">
      <h2 id="cta-heading">Ready to Build Smarter Payment Experiences?</h2>
      <p class="lead" style="color:rgba(255,255,255,0.85);max-width:560px;margin-inline:auto;margin-top:14px;">Talk to our team or get started with a Paynancial account today.</p>
      <div class="hero-actions" style="justify-content:center;margin-top:28px;">
        <a href="/contact" class="btn btn-primary">Get Started</a>
        <a href="/contact?intent=sales" class="btn btn-outline">Talk to Sales</a>
      </div>
    </div>
  </div>
</section>
