<?php
declare(strict_types=1);

/**
 * Shared hero + table-of-contents chrome for the Legal & Support
 * Centre pages (privacy/terms/travel-terms/payment-policy/refund-
 * policy/cookie-policy/grievance). Deliberately NOT a two-function
 * page-lifecycle wrapper like includes/partner-layout.php's
 * render_partner_start()/render_partner_end() — that pattern's second
 * function can't require includes/footer.php (footer.php reads
 * $visaServiceLinks/$attestationCategories/$companyMenu, which are set
 * as local variables inside header.php's own require, and don't
 * survive across a function-call boundary). These are public marketing
 * pages, not a logged-in app shell, so they should keep the real
 * sitewide footer — each page file instead requires header.php and
 * footer.php itself, directly, at its own top level (the same simple
 * pattern pages/documentation.php already uses), and only borrows
 * these two functions for the reusable hero/breadcrumb/TOC markup in
 * between.
 */

/**
 * Shared between pages/grievance.php (the public form) and
 * admin/pages/grievances.php (the CRM) so the category label shown to
 * a customer and the one shown to staff can never drift apart.
 */
const GRIEVANCE_CATEGORIES = [
    'visa_service' => 'Visa Service',
    'attestation_service' => 'Attestation Service',
    'forex' => 'Forex',
    'payment' => 'Payment',
    'staff_conduct' => 'Staff Conduct',
    'other' => 'Other',
];

const GRIEVANCE_CONTACT_METHODS = [
    'email' => 'Email',
    'phone' => 'Phone',
    'whatsapp' => 'WhatsApp',
];

/**
 * @param array<string,string> $sections section-slug => heading, in
 *                                        display order — drives both
 *                                        the TOC link list and the
 *                                        anchor ids the calling page's
 *                                        own <section id="..."> blocks
 *                                        must use.
 */
function render_legal_hero(string $slug, string $title, string $description, string $lastUpdatedSetting, array $sections): void
{
    $lastUpdated = setting($lastUpdatedSetting, '');
    $lastUpdatedDisplay = $lastUpdated !== '' ? date('F j, Y', strtotime($lastUpdated)) : '';
    ?>
    <section class="section" style="padding-top:var(--space-8);padding-bottom:0">
        <div class="container">
            <ul class="breadcrumb">
                <li><a href="/">Home</a></li>
                <li>Legal &amp; Support</li>
                <li><?= e($title) ?></li>
            </ul>
            <div class="legal-hero">
                <span class="section-eyebrow">Legal &amp; Support</span>
                <h1><?= e($title) ?></h1>
                <p class="legal-hero__description"><?= e($description) ?></p>
                <?php if ($lastUpdatedDisplay !== ''): ?>
                <p class="legal-hero__updated">Last updated: <?= e($lastUpdatedDisplay) ?></p>
                <?php endif; ?>
            </div>

            <?php if ($sections): ?>
            <details class="accordion-item legal-toc-mobile">
                <summary>On This Page</summary>
                <div class="accordion-body">
                    <ul class="legal-toc-list">
                        <?php foreach ($sections as $sectionSlug => $heading): ?>
                        <li><a href="#<?= e($sectionSlug) ?>"><?= e($heading) ?></a></li>
                        <?php endforeach; ?>
                    </ul>
                </div>
            </details>
            <?php endif; ?>

            <div class="legal-shell">
                <?php if ($sections): ?>
                <aside class="legal-shell__sidebar">
                    <nav aria-label="Table of contents">
                        <p class="legal-shell__toc-title">On This Page</p>
                        <ul class="legal-toc-list">
                            <?php foreach ($sections as $sectionSlug => $heading): ?>
                            <li><a href="#<?= e($sectionSlug) ?>"><?= e($heading) ?></a></li>
                            <?php endforeach; ?>
                        </ul>
                    </nav>
                </aside>
                <?php endif; ?>
                <div class="legal-shell__content">
    <?php
}

function render_legal_hero_close(): void
{
    ?>
                </div>
            </div>
        </div>
    </section>
    <?php
}
