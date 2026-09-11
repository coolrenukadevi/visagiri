<?php
declare(strict_types=1);

/**
 * Partial: renders a customer testimonials section. Expects
 * $testimonials (from fetch_testimonials()) in scope; $testimonialsHeading
 * optionally overrides the default heading. Every quote rendered here
 * is real, admin-entered content — with nothing published yet, this
 * says so honestly instead of inventing a customer name and quote to
 * look more "social-proofy" than the site actually has.
 */
$testimonialsHeading = $testimonialsHeading ?? 'What Our Customers Say';
?>
<div class="testimonials-section">
    <h2 class="country-directory__subheading"><?= e($testimonialsHeading) ?></h2>
    <?php if (!$testimonials): ?>
    <p class="empty-state">Customer testimonials are being added here soon.</p>
    <?php else: ?>
    <div class="testimonial-grid">
        <?php foreach ($testimonials as $t): ?>
        <div class="testimonial-card">
            <div class="testimonial-stars" aria-label="<?= e((string) $t['rating']) ?> out of 5 stars">
                <?php for ($i = 1; $i <= 5; $i++): ?><span class="<?= $i <= (int) $t['rating'] ? 'is-filled' : '' ?>">&#9733;</span><?php endfor; ?>
            </div>
            <p class="testimonial-quote">&ldquo;<?= e($t['quote']) ?>&rdquo;</p>
            <div class="testimonial-author">
                <span class="testimonial-author-name"><?= e($t['customer_name']) ?></span>
                <?php if (!empty($t['customer_location'])): ?><span class="testimonial-author-location"><?= e($t['customer_location']) ?></span><?php endif; ?>
            </div>
        </div>
        <?php endforeach; ?>
    </div>
    <?php endif; ?>
</div>
