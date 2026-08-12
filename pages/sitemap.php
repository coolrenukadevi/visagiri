<?php
declare(strict_types=1);

/**
 * Human-readable sitemap. Lists the site's current static routes by
 * section; country/visa-type detail pages are omitted here since
 * they're already discoverable from /countries/ and /visa-type/, and
 * listing every combination would duplicate the XML sitemap's job
 * once that exists (Phase 15 — SEO).
 */

// Pulled from the real visa_types table rather than hardcoded — a
// hardcoded copy of this list had already fallen out of sync with the
// DB once before (missing Medical/Conference/Sports Visa).
$visaServiceSection = ['/visa-type/' => 'All Visa Services'];
foreach (db()->query('SELECT name, slug FROM visa_types WHERE is_active = 1 ORDER BY sort_order')->fetchAll() as $t) {
    $visaServiceSection["/visa-type/{$t['slug']}/"] = $t['name'];
}

$sections = [
    'Visa Services' => $visaServiceSection,
    'Explore' => [
        '/countries/' => 'Countries',
        '/visa-process/' => 'Visa Process',
        '/blog/' => 'Visa Updates',
        '/faq/' => 'FAQ',
        '/track-visa/' => 'Track Application',
    ],
    'Account' => [
        '/login/' => 'Login',
        '/register/' => 'Create Account',
        '/dashboard/' => 'Dashboard',
    ],
    'Company' => [
        '/about/' => 'About',
        '/contact/' => 'Contact',
        '/support/' => 'Contact Support',
    ],
    'Legal & Support' => [
        '/privacy/' => 'Privacy Policy',
        '/terms/' => 'Terms & Conditions',
        '/travel-terms/' => 'Travel Terms',
        '/payment-policy/' => 'Payment Policy',
        '/refund-policy/' => 'Refund Policy',
        '/cookie-policy/' => 'Cookie Policy',
        '/grievance/' => 'Grievance Redressal',
        '/disclaimer/' => 'Disclaimer',
        '/track-request/' => 'Track Support Request',
        '/payment-link/' => 'Payment Link',
    ],
];

$pageTitle = 'Website Sitemap - Browse All Visagiri Pages';
$pageDescription = 'Browse a full directory of Visagiri pages — visa services, attestation, country guides, account tools, and legal and support resources, all in one place.';
$canonicalUrl = APP_URL . '/sitemap/';
require __DIR__ . '/../includes/header.php';
?>
<section class="section">
    <div class="container" style="max-width:900px">
        <div class="section-heading" style="text-align:left;margin-left:0">
            <h1>Sitemap</h1>
        </div>
        <div class="card-grid">
            <?php foreach ($sections as $heading => $links): ?>
            <div class="card">
                <div class="card-title"><?= e($heading) ?></div>
                <ul style="padding-left:var(--space-5)">
                    <?php foreach ($links as $href => $label): ?>
                    <li><a href="<?= e($href) ?>"><?= e($label) ?></a></li>
                    <?php endforeach; ?>
                </ul>
            </div>
            <?php endforeach; ?>
        </div>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
