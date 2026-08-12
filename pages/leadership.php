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

$pageTitle = 'Leadership - Visagiri';
$pageDescription = "Meet Visagiri's leadership: Anisha Bharti and Renuka Devi, Directors at Visagiri, a unit of Tripgation Pvt Ltd.";
$canonicalUrl = APP_URL . '/leadership/';
require __DIR__ . '/../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">Leadership</span>
            <h1>Our Leadership</h1>
        </div>
        <div class="card-grid">
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
                <a href="<?= e($leader['linkedin']) ?>" target="_blank" rel="noopener noreferrer" class="leader-card__linkedin">View LinkedIn Profile &rarr;</a>
            </div>
            <?php endforeach; ?>
        </div>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
