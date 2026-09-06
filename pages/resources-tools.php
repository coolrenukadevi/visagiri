<?php
declare(strict_types=1);

/**
 * /resources/tools/ — honest "coming soon" placeholder. Interactive
 * visa tools (fee calculators, eligibility checkers) don't exist yet;
 * this states that plainly rather than fabricating tool names, and
 * points to the two real tools already live (track/status lookup).
 * Noindexed like every other content-pending stub (see
 * render_scaffold_page() in includes/functions.php).
 */

$pageTitle = 'Visa Tools (Coming Soon) - Visagiri';
$pageDescription = 'Interactive visa tools are in development. In the meantime, track your application or check your visa status online.';
$canonicalUrl = APP_URL . '/resources/tools/';
$noindex = true;
require __DIR__ . '/../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:640px;text-align:center">
        <span class="section-eyebrow">Resources</span>
        <h1>Visa Tools — Coming Soon</h1>
        <p class="empty-state">We're building interactive tools to make preparing your visa application easier. In the meantime, here's what's already available:</p>
        <div class="card-grid" style="margin-top:var(--space-6);text-align:left">
            <a href="/track-visa/" class="card service-card">
                <div class="card-title">Track Your Application</div>
                <p>Check the status of an existing visa application.</p>
            </a>
            <a href="/visa-status/" class="card service-card">
                <div class="card-title">Check Visa Status</div>
                <p>Look up the current status of your visa.</p>
            </a>
        </div>
        <p style="margin-top:var(--space-6)"><a href="/resources/">&larr; Back to Resources</a></p>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
