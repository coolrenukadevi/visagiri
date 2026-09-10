<?php
declare(strict_types=1);

/**
 * Leadership page. Two real directors — names, titles, LinkedIn
 * profiles, and photos confirmed/supplied directly by the client. No
 * bios are invented beyond the confirmed name/title/profile-link
 * facts.
 */

$leaders = [
    ['name' => 'Anisha Bharti', 'title' => 'Director', 'linkedin' => 'https://www.linkedin.com/in/coolanishabharti', 'photo' => '/assets/images/leadership/anisha-bharti.jpg'],
    ['name' => 'Renuka Devi', 'title' => 'Director', 'linkedin' => 'https://www.linkedin.com/in/coolrenukadevi/', 'photo' => '/assets/images/leadership/renuka-devi.jpg'],
];

$pageTitle = 'Leadership Team - Visagiri Directors';
$pageDescription = "Meet Visagiri's leadership team: Anisha Bharti and Renuka Devi, Directors at Visagiri, a visa consultancy under Tripgation Pvt Ltd.";
$canonicalUrl = APP_URL . '/leadership/';
$structuredData = [breadcrumb_schema([
    ['name' => 'Home', 'url' => APP_URL . '/'],
    ['name' => 'Leadership', 'url' => $canonicalUrl],
])];
require __DIR__ . '/../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8);padding-bottom:var(--space-6)">
    <div class="container" style="max-width:760px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">Leadership</span>
            <h1>Our Leadership</h1>
        </div>
        <p style="font-size:var(--font-size-lg);color:var(--text-dark)">
            Visagiri is led by a team of directors committed to technology-driven visa consultancy and
            transparent, dependable service for travellers, students, professionals, and businesses.
        </p>
    </div>
</section>

<section class="section" style="padding-top:0">
    <div class="container">
        <div class="card-grid" style="max-width:680px;margin:0 auto">
            <?php foreach ($leaders as $leader): ?>
            <div class="card leader-card">
                <img class="leader-card__avatar" src="<?= e(asset_url($leader['photo'])) ?>" alt="<?= e($leader['name']) ?>" width="88" height="88" loading="lazy">
                <div class="card-title"><?= e($leader['name']) ?></div>
                <p class="leader-card__title"><?= e($leader['title']) ?></p>
                <a href="<?= e($leader['linkedin']) ?>" target="_blank" rel="noopener noreferrer" class="leader-card__social">
                    <svg width="15" height="15" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M8.3 11.7 15.7 4.3"/><path d="M11 4h5v5"/><path d="M15.5 11v4.5a1.5 1.5 0 0 1-1.5 1.5H5.5A1.5 1.5 0 0 1 4 15.5V6.5A1.5 1.5 0 0 1 5.5 5H10"/></svg>
                    LinkedIn Profile
                </a>
            </div>
            <?php endforeach; ?>
        </div>
    </div>
</section>

<section class="section" style="background:var(--bg-alt, #f7f8fa)">
    <div class="container" style="max-width:760px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <h2>How leadership shapes Visagiri</h2>
        </div>
        <p>
            Under Anisha Bharti and Renuka Devi's direction, Visagiri has been built as a technology-driven visa
            consultancy under Tripgation Pvt Ltd — one that pairs an online system for checking requirements and
            tracking application status with hands-on consultant support, rather than choosing one over the other.
        </p>
        <p>
            That leadership focus carries through to how the company handles document attestation and legalization
            work as well: apostille, MEA, embassy, and consulate attestation, delivered with the same emphasis on
            transparent, dependable service that the visa consultancy side runs on.
        </p>
    </div>
</section>

<section class="section">
    <div class="container" style="max-width:760px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <h2>Connect with the wider team</h2>
        </div>
        <p>
            Directors set the direction, but day-to-day case work runs through a broader team of visa consultants,
            document and attestation specialists, and application support staff.
        </p>
        <div style="display:flex;gap:var(--space-3);flex-wrap:wrap;margin-top:var(--space-4)">
            <a href="/our-team/" class="btn btn-outline">Meet Our Team &rarr;</a>
            <a href="/about/#our-story" class="btn btn-outline">Our Story &rarr;</a>
            <a href="/contact/" class="btn btn-outline">Contact Us &rarr;</a>
        </div>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
