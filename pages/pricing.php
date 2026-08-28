<?php
$page_meta = [
    'title' => 'Pricing | Paynancial',
    'description' => 'Paynancial pricing is tailored to your business. Talk to our sales team for a plan that fits your volume and needs.',
];

// Pricing is configurable via the settings table / admin panel — no invented figures.
try {
    $stmt = db()->prepare('SELECT setting_value FROM settings WHERE setting_key = :k');
    $stmt->execute(['k' => 'pricing_mode']);
    $pricingMode = $stmt->fetchColumn() ?: 'talk_to_sales';
} catch (Throwable $e) {
    $pricingMode = 'talk_to_sales';
}
?>
<section style="padding-top:56px;">
  <div class="container">
    <div class="section-head center reveal">
      <span class="eyebrow">Pricing</span>
      <h1>Pricing built around your business.</h1>
      <p class="lead">Transaction pricing depends on your industry, volume and payment mix. Our team will help you find the right plan.</p>
    </div>
  </div>
</section>

<section class="section-subtle">
  <div class="container grid grid-3">
    <?php foreach (['Starter', 'Growth', 'Enterprise'] as $plan): ?>
      <div class="card reveal">
        <h3><?= e($plan) ?></h3>
        <p style="margin-top:6px;">Custom pricing based on your transaction volume and requirements.</p>
        <p style="font-size:1.6rem;font-weight:700;margin-top:18px;color:var(--navy-900);">Talk to Sales</p>
        <a href="/contact?intent=sales&plan=<?= e(strtolower($plan)) ?>" class="btn btn-primary btn-block" style="margin-top:16px;">Contact Sales</a>
      </div>
    <?php endforeach; ?>
  </div>
</section>

<section>
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">FAQ</span>
      <h2>Pricing questions</h2>
    </div>
    <div class="grid grid-2">
      <div class="card reveal">
        <h3>Why isn't pricing published?</h3>
        <p>Payment processing rates vary by industry, ticket size and payment method mix, so we tailor pricing per business rather than publish a one-size-fits-all rate.</p>
      </div>
      <div class="card reveal">
        <h3>How do I get a quote?</h3>
        <p>Share a few details about your business through our contact form and our sales team will follow up with a tailored proposal.</p>
      </div>
    </div>
  </div>
</section>
