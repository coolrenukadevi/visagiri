<?php
declare(strict_types=1);

/**
 * General FAQ page — Phase 15. Pulls the real general FAQs seeded in
 * Phase 5 (faqs.country_id AND visa_type_id both NULL); nothing here
 * is invented copy.
 */

$pdo = db();
$faqs = $pdo->query(
    'SELECT question, answer FROM faqs WHERE is_active = 1 AND country_id IS NULL AND visa_type_id IS NULL ORDER BY sort_order'
)->fetchAll();

$pageTitle = 'Frequently Asked Questions - Visagiri';
$pageDescription = 'Answers to common questions about visa applications, documents, and processing with Visagiri.';
$canonicalUrl = APP_URL . '/faq/';
$structuredData = $faqs ? [[
    '@context' => 'https://schema.org',
    '@type' => 'FAQPage',
    'mainEntity' => array_map(static fn($f) => [
        '@type' => 'Question',
        'name' => $f['question'],
        'acceptedAnswer' => ['@type' => 'Answer', 'text' => $f['answer']],
    ], $faqs),
]] : [];
require __DIR__ . '/../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:760px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">FAQ</span>
            <h1>Frequently Asked Questions</h1>
        </div>
        <?php if ($faqs): ?>
        <?php foreach ($faqs as $faq): ?>
        <div class="accordion-item">
            <details>
                <summary><?= e($faq['question']) ?></summary>
                <div class="accordion-body"><?= e($faq['answer']) ?></div>
            </details>
        </div>
        <?php endforeach; ?>
        <p style="margin-top:var(--space-8)">Have a different question? <a href="/contact/">Contact our team</a>.</p>
        <?php else: ?>
        <p class="empty-state">FAQs haven't been published yet. <a href="/contact/">Contact us</a> with any questions.</p>
        <?php endif; ?>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
