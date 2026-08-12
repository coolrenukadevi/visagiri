<?php
declare(strict_types=1);

/**
 * Visa Updates / blog — Phase 15. No `blog_posts` table exists and no
 * articles have been authored anywhere in this project. Fabricating
 * "visa policy update" articles would be exactly the kind of invented
 * visa/government information the brief explicitly forbids, so this
 * stays an honest empty state — noindexed, since there's nothing here
 * yet worth a search engine ranking — until real, sourced articles
 * are written and a real content table backs them.
 */

$pageTitle = 'Visa Updates - Visagiri';
$pageDescription = 'Visa updates, embassy updates, visa guides, document guides, and travel alerts.';
$canonicalUrl = APP_URL . '/blog/';
$noindex = true;
require __DIR__ . '/../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:760px;text-align:center">
        <span class="section-eyebrow">Visa Updates</span>
        <h1>No Updates Published Yet</h1>
        <p class="empty-state">We haven't published any visa updates or guides yet. Check back soon, or <a href="/contact/">contact us</a> for current information about your destination.</p>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
