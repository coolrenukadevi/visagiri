<?php
$page_meta = [
    'title'       => 'Solutions | AI-Powered Financial Infrastructure | Paynancial',
    'description' => 'Payment infrastructure for startups, SaaS, SMEs, marketplaces and enterprises — across e-commerce, travel, healthcare, FinTech and more.',
];
$businessTypes = [
    'startups'           => ['Startups & New Businesses', 'Launch fast with payment infrastructure that grows with you.', '/solutions/startups'],
    'saas'               => ['SaaS & Subscription Businesses', 'Recurring billing, automated collections and reconciliation, built in.', '/solutions/saas'],
    'sme'                => ['SMEs & Growing Businesses', 'Room to scale into new volume without switching providers.', '/contact?intent=sales&solution=sme'],
    'marketplaces'       => ['Marketplaces & Platforms', 'Collect from customers and split funds to sellers and partners automatically.', '/contact?intent=sales&solution=marketplaces'],
    'digital-businesses' => ['Digital Businesses', 'Payment infrastructure for products that live entirely online.', '/contact?intent=sales&solution=digital-businesses'],
    'agencies'           => ['Agencies & Professional Services', 'Simple invoicing and collection for client-based businesses.', '/contact?intent=sales&solution=agencies'],
];
$industries = [
    'ecommerce'             => ['E-Commerce', 'Fast, reliable checkout with support for the payment methods your customers already trust.', 'An online store uses the Payment Gateway for checkout and Payment Analytics to track conversion by payment method.'],
    'travel'                => ['Travel', 'Handle high-value, multi-currency bookings with confidence.', 'A travel agency uses Payment Links to collect booking deposits and Payouts to settle with hotel and airline partners.'],
    'healthcare'            => ['Healthcare', 'Secure, compliant billing flows for clinics and hospitals.', 'A clinic uses Payment Collection to bill patients for recurring treatment plans and reconcile insurance co-payments.'],
    'education'             => ['Education', 'Simplify fee collection for schools, colleges and training institutes.', 'A training institute uses Payment Collection to automate monthly fee billing across hundreds of students.'],
    'retail'                => ['Retail', 'Unified payment flows across online and in-store channels.', 'A retail chain uses the Payment Gateway online and Payment Analytics to reconcile sales across every store.'],
    'hospitality'           => ['Hospitality', 'Flexible collection for bookings, deposits and on-site payments.', 'A hotel uses Payment Links for advance booking deposits and the Payment Gateway for on-site guest payments.'],
    'professional-services' => ['Professional Services', 'Simple invoicing and collection for professional service businesses.', 'A consulting firm uses Payment Links to invoice clients and Payouts to pay freelance associates.'],
    'fintech'               => ['FinTech', 'Infrastructure for FinTech products that need payments without becoming a payments company.', 'A lending platform uses Payouts to disburse loans and Reconciliation to match repayments automatically.'],
    'logistics'             => ['Logistics & Transportation', 'Collect on delivery and pay fleet partners without manual reconciliation.', 'A logistics operator uses Payment Collection for cash-on-delivery orders and Payouts to settle with drivers weekly.'],
    'real-estate'           => ['Real Estate & PropTech', 'Handle large-ticket collections and vendor payouts for property businesses.', 'A property manager uses Payment Links for rent collection and Payouts to settle with maintenance vendors.'],
    'insurance'             => ['Insurance & InsurTech', 'Premium collection and claims payouts on one reconciled platform.', 'An insurer uses Recurring Payments for premium collection and Payouts to settle approved claims.'],
    'gaming'                => ['Gaming & Digital Services', 'Fast, high-volume payments for digital and in-app purchases.', 'A gaming platform uses the Payment Gateway for in-app purchases and Payment Analytics to track spend by title.'],
    'nonprofits'            => ['NGOs & Non-Profits', 'Transparent donation collection with clear reconciliation for donors and auditors.', 'An NGO uses Payment Pages for donation drives and Payment Analytics to report fund utilization.'],
    'enterprise'            => ['Enterprise', 'Custom infrastructure, dedicated support and volume-ready architecture.', 'A large enterprise uses the full platform — Gateway, Collection, Payouts and Analytics — behind its own finance systems via the API.'],
];
?>
<section style="padding-top:56px;">
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">Solutions</span>
      <h1>AI-powered financial infrastructure, shaped by your business.</h1>
      <p class="lead">Payments, payouts, billing, reconciliation and financial intelligence — connected through one platform, whichever business model or industry you run.</p>
    </div>
  </div>
</section>

<section class="section-subtle" id="business">
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">By Business Type</span>
      <h2>Built for how your business actually operates.</h2>
    </div>
    <div class="grid grid-3">
      <?php foreach ($businessTypes as $slug => [$title, $desc, $href]): ?>
        <a class="card reveal" id="<?= e($slug) ?>" href="<?= e($href) ?>">
          <span class="card-icon">◆</span>
          <h3><?= e($title) ?></h3>
          <p><?= e($desc) ?></p>
          <span class="card-link"><?= str_starts_with($href, '/solutions/') ? 'Explore this solution' : 'Talk to sales' ?> →</span>
        </a>
      <?php endforeach; ?>
    </div>
  </div>
</section>

<section id="industries">
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">By Industry</span>
      <h2>Solutions shaped by how your industry collects and manages payments.</h2>
    </div>
    <div class="grid grid-3">
      <?php foreach ($industries as $slug => [$title, $desc, $useCase]): ?>
        <div class="card reveal" id="<?= e($slug) ?>">
          <span class="card-icon">◆</span>
          <h3><?= e($title) ?></h3>
          <p><?= e($desc) ?></p>
          <p class="text-muted" style="margin-top:10px;font-size:0.85rem;"><?= e($useCase) ?></p>
          <a class="card-link" href="/contact?intent=sales&solution=<?= e($slug) ?>">Talk to sales →</a>
        </div>
      <?php endforeach; ?>
    </div>
  </div>
</section>

<section>
  <div class="container">
    <div class="cta-band reveal">
      <h2>Not sure which solution fits your business?</h2>
      <div class="hero-actions" style="justify-content:center;margin-top:24px;">
        <a href="/contact?intent=sales" class="btn btn-primary">Talk to Sales</a>
      </div>
    </div>
  </div>
</section>
