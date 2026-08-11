<?php
declare(strict_types=1);

/**
 * Partial: renders the embassy/consulate/VAC section. Expects
 * $contactPoints (from fetch_country_contact_points()) and
 * $countryName in scope. Shared by visa/index.php's overview and
 * detail views so the markup isn't duplicated.
 */
$hasAnyContactPoints = $contactPoints['embassies'] || $contactPoints['consulates'] || $contactPoints['vac_centers'];
?>
<div class="contact-points">
    <h2 class="country-directory__subheading">Embassy, Consulate &amp; VAC Information</h2>
    <?php if (!$hasAnyContactPoints): ?>
    <p class="empty-state">Embassy, consulate, and VAC information for <?= e($countryName) ?> hasn't been published yet. <a href="/contact/">Contact us</a> for current details.</p>
    <?php else: ?>
    <div class="card-grid">
        <?php foreach ($contactPoints['embassies'] as $e): ?>
        <div class="card">
            <span class="badge badge-info">Embassy</span>
            <div class="card-title" style="margin-top:var(--space-2)"><?= e($e['name']) ?></div>
            <p>
                <?= e($e['city'] ?? '') ?><br>
                <?= nl2br(e($e['address'] ?? '')) ?>
                <?php if (!empty($e['phone'])): ?><br>Phone: <?= e($e['phone']) ?><?php endif; ?>
                <?php if (!empty($e['website'])): ?><br><a href="<?= e($e['website']) ?>" rel="nofollow noopener" target="_blank">Website</a><?php endif; ?>
            </p>
        </div>
        <?php endforeach; ?>
        <?php foreach ($contactPoints['consulates'] as $c): ?>
        <div class="card">
            <span class="badge badge-info">Consulate</span>
            <div class="card-title" style="margin-top:var(--space-2)"><?= e($c['name']) ?></div>
            <p>
                <?= e($c['city'] ?? '') ?><br>
                <?= nl2br(e($c['address'] ?? '')) ?>
                <?php if (!empty($c['phone'])): ?><br>Phone: <?= e($c['phone']) ?><?php endif; ?>
                <?php if (!empty($c['website'])): ?><br><a href="<?= e($c['website']) ?>" rel="nofollow noopener" target="_blank">Website</a><?php endif; ?>
            </p>
        </div>
        <?php endforeach; ?>
        <?php foreach ($contactPoints['vac_centers'] as $v): ?>
        <div class="card">
            <span class="badge badge-neutral">VAC</span>
            <div class="card-title" style="margin-top:var(--space-2)"><?= e($v['name']) ?></div>
            <p>
                <?= e($v['city'] ?? '') ?><br>
                <?= nl2br(e($v['address'] ?? '')) ?>
                <?php if (!empty($v['operating_hours'])): ?><br>Hours: <?= e($v['operating_hours']) ?><?php endif; ?>
                <?php if (!empty($v['website'])): ?><br><a href="<?= e($v['website']) ?>" rel="nofollow noopener" target="_blank">Website</a><?php endif; ?>
            </p>
        </div>
        <?php endforeach; ?>
    </div>
    <?php endif; ?>
</div>
