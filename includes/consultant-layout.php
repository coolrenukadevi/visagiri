<?php
declare(strict_types=1);

/**
 * Shared consultant shell — sidebar + content wrapper, same pattern as
 * includes/admin-layout.php and includes/dashboard-layout.php. Scope
 * is deliberately narrow: the `consultant` role's whole job, per its
 * own row in the `roles` table, is "View assigned applications,
 * review documents, update status" — nothing here lets a consultant
 * see or touch an application that isn't assigned to them (that
 * boundary is enforced per-query in consultant/pages/*.php, not just
 * by hiding links), and nothing here duplicates admin-only powers
 * like reassigning consultants or suspending accounts.
 */

const CONSULTANT_NAV = [
    'overview' => ['label' => 'Overview', 'href' => '/consultant/'],
    'applications' => ['label' => 'My Applications', 'href' => '/consultant/applications/'],
    'documents' => ['label' => 'Document Review', 'href' => '/consultant/documents/'],
];

function render_consultant_start(string $activeKey, string $title): void
{
    $pageTitle = "$title - Consultant";
    $pageDescription = 'Visagiri consultant panel.';
    $canonicalUrl = APP_URL . (CONSULTANT_NAV[$activeKey]['href'] ?? '/consultant/');
    $noindex = true;
    require __DIR__ . '/header.php';
    $flashNotice = flash_get('notice');
    ?>
    <div class="container dashboard-shell">
        <aside class="dashboard-shell__sidebar">
            <ul class="sidebar-nav">
                <?php foreach (CONSULTANT_NAV as $key => $item): ?>
                <li><a href="<?= e($item['href']) ?>" class="<?= $key === $activeKey ? 'is-active' : '' ?>"><?= e($item['label']) ?></a></li>
                <?php endforeach; ?>
                <li><form method="post" action="/logout/" style="margin:0"><?= csrf_field() ?><button type="submit">Logout</button></form></li>
            </ul>
        </aside>
        <div class="dashboard-shell__content">
            <?php if ($flashNotice): ?>
            <div class="alert alert-info"><?= e($flashNotice) ?></div>
            <?php endif; ?>
            <h1 class="dashboard-shell__title"><?= e($title) ?></h1>
    <?php
}

function render_consultant_end(): void
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
