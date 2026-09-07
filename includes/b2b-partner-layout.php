<?php
declare(strict_types=1);

/**
 * Shared B2B Travel Partner Portal shell (Phase B8). Mirrors
 * includes/partner-layout.php's sidebar-nav pattern for the old
 * referral partner system — introduced now rather than in Phase B1
 * because the portal only had 2 real pages back then; with
 * enquiries/notifications/support now real, a shared nav is what
 * makes them discoverable instead of orphaned URLs nobody can find.
 * Same two-function-scope caveat as partner-layout.php:
 * render_b2b_partner_end() does not require includes/footer.php.
 */

const B2B_PARTNER_NAV = [
    'dashboard' => ['label' => 'Dashboard', 'href' => '/b2b/dashboard/'],
    'enquiries' => ['label' => 'Visa Enquiries', 'href' => '/b2b/enquiries/'],
    'notifications' => ['label' => 'Notifications', 'href' => '/b2b/notifications/'],
    'support' => ['label' => 'Support', 'href' => '/b2b/support/'],
    'documents' => ['label' => 'KYC Documents', 'href' => '/b2b/register-documents/'],
];

function render_b2b_partner_start(string $activeKey, string $title): void
{
    $pageTitle = "$title - Visagiri B2B Travel Partner Portal";
    $pageDescription = 'Visagiri B2B Travel Partner Portal.';
    $canonicalUrl = APP_URL . (B2B_PARTNER_NAV[$activeKey]['href'] ?? '/b2b/dashboard/');
    $noindex = true;
    require __DIR__ . '/header.php';
    $flashNotice = flash_get('b2b_notice');
    $flashError = flash_get('b2b_error');
    $partnerForNav = current_b2b_partner();
    $unreadCount = 0;
    if ($partnerForNav) {
        $stmt = db()->prepare('SELECT COUNT(*) FROM b2b_partner_notifications WHERE b2b_partner_id = :id AND is_read = 0');
        $stmt->execute(['id' => $partnerForNav['id']]);
        $unreadCount = (int) $stmt->fetchColumn();
    }
    ?>
    <section class="section" style="padding-top:var(--space-6);padding-bottom:var(--space-10)">
    <div class="container dashboard-shell">
        <aside class="dashboard-shell__sidebar">
            <ul class="sidebar-nav">
                <?php foreach (B2B_PARTNER_NAV as $key => $item): ?>
                <li>
                    <a href="<?= e($item['href']) ?>" class="<?= $key === $activeKey ? 'is-active' : '' ?>">
                        <?= e($item['label']) ?>
                        <?php if ($key === 'notifications' && $unreadCount > 0): ?>
                        <span class="badge badge-danger" style="margin-left:var(--space-2)"><?= $unreadCount ?></span>
                        <?php endif; ?>
                    </a>
                </li>
                <?php endforeach; ?>
                <li><form method="post" action="/b2b/logout/" style="margin:0"><?= csrf_field() ?><button type="submit" class="sidebar-nav__logout">Logout</button></form></li>
            </ul>
        </aside>
        <div class="dashboard-shell__content">
            <?php if ($flashNotice): ?>
            <div class="alert alert-success"><?= e($flashNotice) ?></div>
            <?php endif; ?>
            <?php if ($flashError): ?>
            <div class="alert alert-danger"><?= e($flashError) ?></div>
            <?php endif; ?>
            <h1 class="dashboard-shell__title"><?= e($title) ?></h1>
    <?php
}

function render_b2b_partner_end(): void
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
