<?php
$page_meta = [
    'title' => 'Leadership | Paynancial',
    'description' => 'Meet the leadership team at Paynancial Technology Pvt. Ltd.',
    'schema' => organization_schema(),
];

function paynancial_initials(string $name): string
{
    $initials = '';
    foreach (explode(' ', trim($name)) as $part) {
        if ($part !== '') {
            $initials .= strtoupper($part[0]);
        }
    }
    return $initials;
}

$leaders = [
    [
        'number'   => '01',
        'name'     => 'Renuka Devi',
        'title'    => 'Director',
        'linkedin' => 'https://www.linkedin.com/in/coolrenukadevi/',
    ],
    [
        'number'   => '02',
        'name'     => 'Anisha Bharti',
        'title'    => 'Director',
        'linkedin' => 'https://www.linkedin.com/in/anishabharti',
    ],
];
?>
<section class="hero" style="padding-top:72px;">
  <div class="container">
    <div class="hero-copy reveal">
      <span class="eyebrow">Leadership</span>
      <h1>The people accountable for how Paynancial is run.</h1>
      <p class="lead">Governance, strategy and oversight at Paynancial Technology Pvt. Ltd.</p>
    </div>
  </div>
</section>

<section>
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">Leadership</span>
      <h2>Board of Directors</h2>
    </div>
    <div class="leaders reveal">
      <?php foreach ($leaders as $leader): ?>
        <div class="leader-row">
          <span class="leader-num"><?= e($leader['number']) ?></span>
          <span class="avatar"><?= e(paynancial_initials($leader['name'])) ?></span>
          <div class="leader-name-title">
            <h3><?= e($leader['name']) ?></h3>
            <span class="role"><?= e($leader['title']) ?></span>
          </div>
          <div class="leader-bio">
            <a class="li-link" href="<?= e($leader['linkedin']) ?>" target="_blank" rel="noopener noreferrer">
              <svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M20.45 20.45h-3.55v-5.57c0-1.33-.02-3.03-1.85-3.03-1.85 0-2.14 1.45-2.14 2.94v5.66H9.36V9h3.41v1.56h.05c.48-.9 1.64-1.85 3.37-1.85 3.6 0 4.27 2.37 4.27 5.46v6.28zM5.34 7.43a2.06 2.06 0 1 1 0-4.12 2.06 2.06 0 0 1 0 4.12zM7.12 20.45H3.56V9h3.56v11.45z"/></svg>
              View LinkedIn profile
            </a>
          </div>
        </div>
      <?php endforeach; ?>
    </div>
  </div>
</section>

<div class="registry-strip cta-only">
  <div class="container">
    <div class="reveal">
      <h2>Get in touch</h2>
      <p>Questions for the leadership team or the company at large — reach out and someone will get back to you.</p>
      <div class="hero-actions" style="margin-top:24px;">
        <a href="/contact" class="btn btn-primary">Contact Us</a>
      </div>
    </div>
  </div>
</div>
