<?php
declare(strict_types=1);

/**
 * Shared partner-portal shell. Same two-function-scope caveat as
 * includes/dashboard-layout.php applies here: render_partner_end()
 * does NOT require includes/footer.php (it depends on variables set
 * inside includes/header.php's own function call, which doesn't
 * survive into a separate function's scope) — a minimal closing shell
 * instead, matching the customer dashboard's fix.
 */

const PARTNER_NAV = [
    'dashboard' => ['label' => 'Dashboard', 'href' => '/partner/dashboard/'],
    'profile' => ['label' => 'Profile', 'href' => '/partner/profile/'],
];

function render_partner_start(string $activeKey, string $title): void
{
    $pageTitle = "$title - Partner Portal - Visagiri";
    $pageDescription = 'Visagiri partner referral portal.';
    $canonicalUrl = APP_URL . (PARTNER_NAV[$activeKey]['href'] ?? '/partner/dashboard/');
    $noindex = true;
    require __DIR__ . '/header.php';
    $flashNotice = flash_get('notice');
    ?>
    <section class="section" style="padding-top:var(--space-6);padding-bottom:var(--space-10)">
    <div class="container dashboard-shell">
        <aside class="dashboard-shell__sidebar">
            <ul class="sidebar-nav">
                <?php foreach (PARTNER_NAV as $key => $item): ?>
                <li><a href="<?= e($item['href']) ?>" class="<?= $key === $activeKey ? 'is-active' : '' ?>"><?= e($item['label']) ?></a></li>
                <?php endforeach; ?>
                <li><form method="post" action="/partner/logout/" style="margin:0"><?= csrf_field() ?><button type="submit" class="sidebar-nav__logout">Logout</button></form></li>
            </ul>
        </aside>
        <div class="dashboard-shell__content">
            <?php if ($flashNotice): ?>
            <div class="alert alert-info"><?= e($flashNotice) ?></div>
            <?php endif; ?>
            <h1 class="dashboard-shell__title"><?= e($title) ?></h1>
    <?php
}

function render_partner_end(): void
{
    ?>
        </div>
    </div>
    </section>
    </main>
    <script src="<?= e(asset_url('/assets/js/site.js')) ?>"></script>
    </body>
    </html>
    <?php
}
