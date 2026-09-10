<?php
declare(strict_types=1);

/**
 * Visa Updates / blog. No `blog_posts` table exists and no articles
 * have been authored anywhere in this project. Fabricating "visa
 * policy update" articles would be exactly the kind of invented visa/
 * government information the brief explicitly forbids, so this stays
 * honest — noindexed, since there's no article content here yet worth
 * a search engine ranking — but rather than a bare "nothing here"
 * message, it explains what this section is for and routes visitors to
 * the real, already-published resource pages that answer the same
 * questions today, until real, sourced articles are written and a real
 * content table backs them.
 */

$pageTitle = 'Visa Updates - Visagiri';
$pageDescription = 'Visa updates, embassy updates, visa guides, document guides, and travel alerts.';
$canonicalUrl = APP_URL . '/blog/';
$noindex = true;
require __DIR__ . '/../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:840px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">Visa Updates</span>
            <h1>Visa Updates &amp; News</h1>
        </div>
        <p style="font-size:var(--font-size-lg);color:var(--text-dark)">
            This is where we'll publish visa policy changes, embassy announcements, and travel guides as we author and verify them.
            We haven't published an article here yet, but the answers most visa updates cover — requirements, documents, process,
            and fees — are already available on these pages:
        </p>

        <div class="card-grid" style="margin-top:var(--space-6)">
            <a href="/visa-process/" class="card service-card">
                <div class="card-title">How Visagiri Works</div>
                <p>Our step-by-step visa consultancy and application process.</p>
            </a>
            <a href="/documentation/" class="card service-card">
                <div class="card-title">Documentation Assistance</div>
                <p>Understand exactly what documents your application needs.</p>
            </a>
            <a href="/document-templates/" class="card service-card">
                <div class="card-title">Document Templates</div>
                <p>Ready-made cover letters, NOCs, sponsor letters, and more.</p>
            </a>
            <a href="/faq/" class="card service-card">
                <div class="card-title">Visa FAQs</div>
                <p>Answers to common questions about visas and documents.</p>
            </a>
            <a href="/resources/" class="card service-card">
                <div class="card-title">Resource Hub</div>
                <p>All our visa guides, tools, and information in one place.</p>
            </a>
        </div>

        <p style="margin-top:var(--space-8)">
            Need current information about a specific destination or visa category?
            <a href="/contact/">Contact our team</a> — a consultant will confirm the latest requirements for your case.
        </p>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
