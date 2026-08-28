<?php
$page_meta = [
    'title' => 'Solutions by Industry | Paynancial',
    'description' => 'Payment solutions tailored for e-commerce, travel, education, healthcare, retail, hospitality, services and enterprise businesses.',
];
$industries = [
    'ecommerce'  => ['E-Commerce', 'Fast, reliable checkout with support for the payment methods your customers already trust.'],
    'travel'     => ['Travel', 'Handle high-value, multi-currency bookings with confidence.'],
    'education'  => ['Education', 'Simplify fee collection for schools, colleges and training institutes.'],
    'healthcare' => ['Healthcare', 'Secure, compliant billing flows for clinics and hospitals.'],
    'retail'     => ['Retail', 'Unified payment flows across online and in-store channels.'],
    'hospitality'=> ['Hospitality', 'Flexible collection for bookings, deposits and on-site payments.'],
    'services'   => ['Services', 'Simple invoicing and collection for professional service businesses.'],
    'enterprise' => ['Enterprise', 'Custom infrastructure, dedicated support and volume-ready architecture.'],
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
    <?php foreach ($industries as $slug => [$title, $desc]): ?>
      <div class="card reveal" id="<?= e($slug) ?>">
        <span class="card-icon">◆</span>
        <h3><?= e($title) ?></h3>
        <p><?= e($desc) ?></p>
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
