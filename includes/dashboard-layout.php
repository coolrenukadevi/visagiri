<?php
declare(strict_types=1);

/**
 * Shared customer dashboard shell. Every dashboard/pages/*.php file
 * calls require_customer_login() then render_dashboard_start() before
 * any output, and render_dashboard_end() at the bottom. Reuses the
 * site header for brand consistency but skips the full marketing
 * footer — not appropriate inside a logged-in app shell.
 */

const DASHBOARD_NAV = [
    'overview' => ['label' => 'Dashboard', 'href' => '/dashboard/'],
    'applications' => ['label' => 'My Applications', 'href' => '/dashboard/applications/'],
    'documents' => ['label' => 'Documents', 'href' => '/dashboard/documents/'],
    'appointments' => ['label' => 'Appointments', 'href' => '/dashboard/appointments/'],
    'payments' => ['label' => 'Payments', 'href' => '/dashboard/payments/'],
    'messages' => ['label' => 'Messages', 'href' => '/dashboard/messages/'],
    'notifications' => ['label' => 'Notifications', 'href' => '/dashboard/notifications/'],
    'profile' => ['label' => 'Profile', 'href' => '/dashboard/profile/'],
];

/** Canonical status sequence, matching visa_applications.status in schema-crm.sql, in order. */
function application_status_stages(): array
{
    return [
        'draft' => 'Draft',
        'documents_pending' => 'Documents Pending',
        'submitted' => 'Submitted',
        'under_review' => 'Under Review',
        'approved' => 'Approved',
        'completed' => 'Completed',
    ];
}

/** 0-100 progress based on where the status sits in the normal sequence — rejected/cancelled render their own state, not a percent. */
function application_progress_percent(string $status): int
{
    $stages = array_keys(application_status_stages());
    $index = array_search($status, $stages, true);
    if ($index === false) {
        return 0;
    }
    return (int) round((($index + 1) / count($stages)) * 100);
}

function application_status_badge_class(string $status): string
{
    return match ($status) {
        'approved', 'completed' => 'badge-success',
        'rejected', 'cancelled' => 'badge-danger',
        default => 'badge-info',
    };
}

function render_dashboard_start(string $activeKey, string $title): void
{
    $pageTitle = "$title - My Account - Visagiri";
    $pageDescription = 'Manage your Visagiri visa applications, documents, and messages.';
    $canonicalUrl = APP_URL . (DASHBOARD_NAV[$activeKey]['href'] ?? '/dashboard/');
    $noindex = true;
    require __DIR__ . '/header.php';
    $flashNotice = flash_get('notice');
    $stmt = db()->prepare('SELECT COUNT(*) FROM customer_notifications WHERE customer_id = :id AND is_read = 0');
    $stmt->execute(['id' => current_customer_id()]);
    $unreadCount = (int) $stmt->fetchColumn();
    ?>
    <section class="section" style="padding-top:var(--space-6);padding-bottom:var(--space-10)">
    <div class="container dashboard-shell">
        <aside class="dashboard-shell__sidebar">
            <ul class="sidebar-nav">
                <?php foreach (DASHBOARD_NAV as $key => $item): ?>
                <li>
                    <a href="<?= e($item['href']) ?>" class="<?= $key === $activeKey ? 'is-active' : '' ?>">
                        <?= e($item['label']) ?>
                        <?php if ($key === 'notifications' && $unreadCount > 0): ?>
                        <span class="badge badge-danger" style="margin-left:var(--space-2)"><?= $unreadCount ?></span>
                        <?php endif; ?>
                    </a>
                </li>
                <?php endforeach; ?>
                <li><form method="post" action="/logout/" style="margin:0"><?= csrf_field() ?><button type="submit" class="sidebar-nav__logout">Logout</button></form></li>
            </ul>
        </aside>
        <div class="dashboard-shell__content">
            <?php if ($flashNotice): ?>
            <div class="alert alert-info"><?= e($flashNotice) ?></div>
            <?php endif; ?>
            <h1 class="dashboard-shell__title"><?= e($title) ?></h1>
    <?php
}

/**
 * Deliberately does NOT require includes/footer.php: the full
 * marketing footer (6 link columns, legal row) reads $visaServiceLinks
 * / $attestationCategories / $companyMenu — local variables set inside
 * includes/header.php's own execution, not available here since
 * render_dashboard_start() and render_dashboard_end() are two separate
 * function scopes (PHP's `require` only inherits its immediate calling
 * scope, not a sibling function call's locals). A full marketing
 * footer isn't appropriate inside a logged-in app shell anyway — same
 * call the pre-existing customer dashboard made before it was removed
 * (see the recovered includes/dashboard-layout.php in git history).
 */
function render_dashboard_end(): void
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
