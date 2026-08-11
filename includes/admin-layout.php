<?php
declare(strict_types=1);

/**
 * Shared admin shell — sidebar + content wrapper, same pattern as
 * includes/dashboard-layout.php. Every admin/pages/*.php page calls
 * render_admin_start() right after the router's require_role() check,
 * then render_admin_end() at the bottom.
 */

const ADMIN_NAV = [
    'overview' => ['label' => 'Overview', 'href' => '/admin/'],
    'applications' => ['label' => 'Applications', 'href' => '/admin/applications/'],
    'documents' => ['label' => 'Document Review', 'href' => '/admin/documents/'],
    'users' => ['label' => 'Users', 'href' => '/admin/users/'],
    'support' => ['label' => 'Support Tickets', 'href' => '/admin/support/'],
];

function render_admin_start(string $activeKey, string $title): void
{
    $pageTitle = "$title - Admin";
    $pageDescription = 'Visagiri admin panel.';
    $canonicalUrl = APP_URL . (ADMIN_NAV[$activeKey]['href'] ?? '/admin/');
    require __DIR__ . '/header.php';
    $flashNotice = flash_get('notice');
    ?>
    <div class="container dashboard-shell">
        <aside class="dashboard-shell__sidebar">
            <ul class="sidebar-nav">
                <?php foreach (ADMIN_NAV as $key => $item): ?>
                <li><a href="<?= e($item['href']) ?>" class="<?= $key === $activeKey ? 'is-active' : '' ?>"><?= e($item['label']) ?></a></li>
                <?php endforeach; ?>
                <li><a href="/logout/">Logout</a></li>
            </ul>
        </aside>
        <div class="dashboard-shell__content">
            <?php if ($flashNotice): ?>
            <div class="alert alert-info"><?= e($flashNotice) ?></div>
            <?php endif; ?>
            <h1 class="dashboard-shell__title"><?= e($title) ?></h1>
    <?php
}

function render_admin_end(): void
{
    ?>
        </div>
    </div>
    </main>
    <script src="/assets/js/site.js"></script>
    </body>
    </html>
    <?php
}
