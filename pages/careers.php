<?php
$page_meta = [
    'title' => 'Careers | Paynancial Technology Pvt. Ltd.',
    'description' => 'Join Paynancial and help build the future of payment technology.',
];

$jobs = [];
try {
    $jobs = db()->query(
        "SELECT id, title, department, location, employment_type FROM job_posts WHERE status = 'open' ORDER BY created_at DESC LIMIT 20"
    )->fetchAll();
} catch (Throwable $e) {
    $jobs = [];
}
?>
<section style="padding-top:56px;">
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">Careers</span>
      <h1>Join our dynamic team at Paynancial.</h1>
      <p class="lead">We're a technology-first FinTech company looking for people who want to make digital payments simpler, faster and more secure. We offer competitive compensation, real ownership over projects, and a culture built on accountability and growth.</p>
    </div>
  </div>
</section>

<section class="section-subtle">
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">Open Positions</span>
      <h2>Current openings</h2>
    </div>
    <?php if (empty($jobs)): ?>
      <div class="module-stub reveal">
        <strong>No open positions listed right now</strong>
        Check back soon, or send your resume to hello@paynancial.in and we'll keep it on file.
      </div>
    <?php else: ?>
      <div class="grid grid-2">
        <?php foreach ($jobs as $job): ?>
          <div class="card reveal">
            <h3><?= e($job['title']) ?></h3>
            <p><?= e($job['department']) ?> · <?= e($job['location']) ?> · <?= e($job['employment_type']) ?></p>
            <a class="card-link" href="/contact?intent=career&job=<?= (int) $job['id'] ?>">Apply now →</a>
          </div>
        <?php endforeach; ?>
      </div>
    <?php endif; ?>
  </div>
</section>

<section>
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">Life at Paynancial</span>
      <h2>Departments we hire across</h2>
    </div>
    <div class="pill-list reveal">
      <?php foreach (['Software Development', 'Cybersecurity', 'Data Analysis', 'Customer Support', 'Sales', 'Marketing'] as $d): ?>
        <span class="pill"><?= e($d) ?></span>
      <?php endforeach; ?>
    </div>
  </div>
</section>
