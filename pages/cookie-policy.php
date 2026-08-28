<?php
declare(strict_types=1);

/**
 * /cookie-policy/ — Cookie Policy. Part of the Legal & Support Centre.
 * Confirmed by grep before writing this: there is no GA/GTM or any
 * other analytics/advertising script anywhere in this codebase, so
 * this page does NOT claim analytics, preference or marketing cookies
 * are used — only the real session/CSRF cookie this app actually sets
 * (see includes/security.php's csrf_field()/session handling). If
 * analytics is added later, this page (and the categories grid below)
 * is the one place that needs updating to match.
 */


$pageTitle = 'Cookie Policy | Visagiri';
$pageDescription = 'What cookies visagiri.com actually uses — and just as importantly, which categories we don\'t use.';
$canonicalUrl = APP_URL . '/cookie-policy/';
$structuredData = [[
    '@context' => 'https://schema.org',
    '@type' => 'BreadcrumbList',
    'itemListElement' => [
        ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => APP_URL . '/'],
        ['@type' => 'ListItem', 'position' => 2, 'name' => 'Legal & Support', 'item' => $canonicalUrl],
        ['@type' => 'ListItem', 'position' => 3, 'name' => 'Cookie Policy', 'item' => $canonicalUrl],
    ],
]];
require __DIR__ . '/../includes/header.php';

$sections = [
    'what-are-cookies' => 'What Cookies Are',
    'cookie-categories' => 'Cookie Categories',
    'third-party-cookies' => 'Third-Party Cookies',
    'cookie-duration' => 'Cookie Duration',
    'managing-cookies' => 'Managing Your Preferences',
    'contact' => 'Contact',
];

render_legal_hero(
    'cookie-policy',
    'Cookie Policy',
    'What cookies this website actually uses — nothing more.',
    'legal_cookie_policy_updated_at',
    $sections
);
?>
<section id="what-are-cookies">
    <h2>What Cookies Are</h2>
    <p>A cookie is a small piece of data a website stores in your browser to remember information between requests. We keep our use of cookies to the minimum needed to make the website work securely.</p>
</section>

<section id="cookie-categories">
    <h2>Cookie Categories</h2>
    <div class="admin-form-grid" style="margin:var(--space-4) 0">
        <div class="card">
            <div class="card-title">Essential</div>
            <p>A session cookie that keeps you signed in where relevant, and a CSRF-protection token that verifies form submissions genuinely came from our website rather than a malicious third-party site. These are required for the website to function and cannot be switched off.</p>
        </div>
        <div class="card">
            <div class="card-title">Analytics</div>
            <p>Not currently used. This website does not run Google Analytics, Google Tag Manager or any other analytics script.</p>
        </div>
        <div class="card">
            <div class="card-title">Preferences</div>
            <p>Not currently used. We don't store display or preference settings in a cookie today.</p>
        </div>
        <div class="card">
            <div class="card-title">Marketing</div>
            <p>Not currently used. This website does not run advertising or retargeting cookies of any kind.</p>
        </div>
    </div>
    <p>If this ever changes — for example, if we add analytics in the future — we'll update this page to accurately describe what's in use before it goes live.</p>
</section>

<section id="third-party-cookies">
    <h2>Third-Party Cookies</h2>
    <p>We don't set any third-party advertising or tracking cookies. Where our site links out to WhatsApp or another external service, that service's own cookie policy applies once you leave our website.</p>
</section>

<section id="cookie-duration">
    <h2>Cookie Duration</h2>
    <p>Our session and CSRF cookies last only for the duration of your browsing session (or, where you choose to stay signed in, for a limited remember-me period) and are cleared when you log out or when they expire.</p>
</section>

<section id="managing-cookies">
    <h2>Managing Your Preferences</h2>
    <p>Since this website only sets the essential cookies needed for it to function, there's no separate cookie-consent preference to manage here. You can still clear or block cookies at any time through your browser's own settings — doing so may prevent parts of the site (such as staying signed in) from working correctly.</p>
</section>

<section id="contact">
    <h2>Contact</h2>
    <p>Questions about this Cookie Policy? Contact us at <a href="mailto:<?= e(setting('contact_email', 'info@visagiri.com')) ?>"><?= e(setting('contact_email', 'info@visagiri.com')) ?></a> or through our <a href="/contact/">Contact Us</a> page.</p>
</section>
<?php
render_legal_hero_close();
require __DIR__ . '/../includes/footer.php';
