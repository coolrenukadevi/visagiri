<?php
declare(strict_types=1);

/**
 * /disclaimer/ — the last of the 8 Legal & Support Centre pages to get
 * real content (its 7 siblings — privacy/terms/travel-terms/payment-
 * policy/refund-policy/cookie-policy/grievance — already have it). Not
 * new legal copy: the exact wording already lives, verbatim, in the
 * site-wide footer disclaimer bar (includes/footer.php) — this just
 * gives it its own indexable page alongside its siblings.
 */

$pageTitle = 'Disclaimer - Visagiri';
$pageDescription = "Visagiri's visa services disclaimer — visa decisions are made solely by the relevant embassy, consulate, or government authority.";
$canonicalUrl = APP_URL . '/disclaimer/';
$structuredData = [breadcrumb_schema([
    ['name' => 'Home', 'url' => APP_URL . '/'],
    ['name' => 'Legal & Support', 'url' => $canonicalUrl],
    ['name' => 'Disclaimer', 'url' => $canonicalUrl],
])];
require __DIR__ . '/../includes/header.php';

$sections = [
    'no-guarantee' => 'No Guarantee of Approval',
    'our-role' => 'Our Role',
    'accuracy' => 'Information Accuracy',
    'contact' => 'Contact',
];

render_legal_hero(
    'disclaimer',
    'Disclaimer',
    'Please read this before relying on any visa or immigration information on this website.',
    'disclaimer_last_updated',
    $sections
);
?>
<section id="no-guarantee">
    <h2>No Guarantee of Approval</h2>
    <p>Visa decisions are made solely by the relevant embassy, consulate, or government immigration authority. Visagiri provides visa consultancy and application-management assistance and does not guarantee visa approval.</p>
</section>

<section id="our-role">
    <h2>Our Role</h2>
    <p>We act as a consultancy and service facilitator — we help you understand requirements, prepare and submit applications, and coordinate with the relevant authorities and service providers on your behalf. We are not a government body, embassy, consulate, or immigration authority, and we do not represent one.</p>
</section>

<section id="accuracy">
    <h2>Information Accuracy</h2>
    <p>Visa requirements, fees, and processing times change and can vary by individual case. Where this website shows destination-specific information, we aim to keep it current, but you should always confirm final requirements with your assigned consultant before relying on them.</p>
</section>

<section id="contact">
    <h2>Contact</h2>
    <p>Questions about this disclaimer or your specific application? <a href="/contact/">Contact our team</a>.</p>
</section>
<?php
render_legal_hero_close();
require __DIR__ . '/../includes/footer.php';
