<?php
$page_meta = [
    'title'       => 'Solutions by Industry | Paynancial',
    'description' => 'Payment solutions tailored for e-commerce, travel, education, healthcare, retail, hospitality, professional services and enterprise businesses.',
];
$industries = [
    'ecommerce'             => ['E-Commerce', 'Fast, reliable checkout with support for the payment methods your customers already trust.', 'An online store uses the Payment Gateway for checkout and Payment Analytics to track conversion by payment method.'],
    'travel'                => ['Travel', 'Handle high-value, multi-currency bookings with confidence.', 'A travel agency uses Payment Links to collect booking deposits and Payouts to settle with hotel and airline partners.'],
    'healthcare'            => ['Healthcare', 'Secure, compliant billing flows for clinics and hospitals.', 'A clinic uses Payment Collection to bill patients for recurring treatment plans and reconcile insurance co-payments.'],
    'education'             => ['Education', 'Simplify fee collection for schools, colleges and training institutes.', 'A training institute uses Payment Collection to automate monthly fee billing across hundreds of students.'],
    'retail'                => ['Retail', 'Unified payment flows across online and in-store channels.', 'A retail chain uses the Payment Gateway online and Payment Analytics to reconcile sales across every store.'],
    'hospitality'           => ['Hospitality', 'Flexible collection for bookings, deposits and on-site payments.', 'A hotel uses Payment Links for advance booking deposits and the Payment Gateway for on-site guest payments.'],
    'professional-services' => ['Professional Services', 'Simple invoicing and collection for professional service businesses.', 'A consulting firm uses Payment Links to invoice clients and Payouts to pay freelance associates.'],
    'enterprise'            => ['Enterprise', 'Custom infrastructure, dedicated support and volume-ready architecture.', 'A large enterprise uses the full platform — Gateway, Collection, Payouts and Analytics — behind its own finance systems via the API.'],
];
?>
<section style="padding-top:56px;">
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">Solutions</span>
      <h1>Built for every business, shaped by industry.</h1>
      <p class="lead">Paynancial adapts to how your industry collects and manages payments.</p>
    </div>
  </div>
</section>

<section class="section-subtle">
  <div class="container grid grid-3">
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
