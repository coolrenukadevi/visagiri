<?php
declare(strict_types=1);

/**
 * Leadership page. Two real directors — names, titles, and LinkedIn
 * profiles confirmed directly by the client in chat. Their photos
 * were only shared inline in chat, not uploaded as real file
 * attachments (the same limitation that's blocked the real logo file
 * since Phase 6 — see AUDIT.md), so this uses initials avatars rather
 * than the photos until they arrive as actual uploads. No bios are
 * invented beyond the confirmed name/title/profile-link facts.
 */

$leaders = [
    ['name' => 'Anisha Bharti', 'title' => 'Director', 'linkedin' => 'https://www.linkedin.com/in/coolanishabharti'],
    ['name' => 'Renuka Devi', 'title' => 'Director', 'linkedin' => 'https://www.linkedin.com/in/coolrenukadevi/'],
];

$pageTitle = 'Leadership Team - Visagiri Directors';
$pageDescription = "Meet Visagiri's leadership team: Anisha Bharti and Renuka Devi, Directors at Visagiri, a visa consultancy under Tripgation Pvt Ltd.";
$canonicalUrl = APP_URL . '/leadership/';
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
            <?php
            $initials = '';
            foreach (explode(' ', $leader['name']) as $namePart) {
                $initials .= mb_substr($namePart, 0, 1);
            }
            ?>
            <div class="card leader-card">
                <div class="leader-card__avatar" aria-hidden="true"><?= e($initials) ?></div>
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
<?php require __DIR__ . '/../includes/footer.php'; ?>
