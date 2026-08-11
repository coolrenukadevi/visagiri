<?php
declare(strict_types=1);

/**
 * Shared customer dashboard shell — sidebar + content wrapper. Every
 * dashboard/*.php page calls render_dashboard_start() right after
 * require_login(), then render_dashboard_end() at the bottom. Uses
 * the site header for brand/nav consistency but skips the full
 * marketing footer (legal links, etc.) — not appropriate inside an
 * authenticated app shell.
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
    'support' => ['label' => 'Support', 'href' => '/dashboard/support/'],
];

function render_dashboard_start(string $activeKey, string $title): void
{
    $pageTitle = "$title - Dashboard";
    $pageDescription = 'Manage your Visagiri visa applications, documents, and payments.';
    $canonicalUrl = APP_URL . (DASHBOARD_NAV[$activeKey]['href'] ?? '/dashboard/');
    require __DIR__ . '/header.php';
    $flashNotice = flash_get('notice');
    ?>
    <div class="container dashboard-shell">
        <aside class="dashboard-shell__sidebar">
            <ul class="sidebar-nav">
                <?php foreach (DASHBOARD_NAV as $key => $item): ?>
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

/** Canonical status sequence, matching the applications.status ENUM in schema.sql, in order. */
function application_status_stages(): array
{
    return [
        'created' => 'Application Created',
        'documents_pending' => 'Documents Submitted',
        'documents_verified' => 'Documents Verified',
        'payment_completed' => 'Payment Completed',
        'appointment_scheduled' => 'Appointment Scheduled',
        'submitted' => 'Application Submitted',
        'under_processing' => 'Under Processing',
        'decision_received' => 'Decision Received',
        'completed' => 'Completed',
    ];
}

/** Renders one application summary card. Shared by the overview and applications-list pages. */
function render_application_card(array $app): void
{
    ?>
    <a href="/dashboard/applications/<?= (int) $app['id'] ?>/" class="card application-card">
        <div class="application-card__top">
            <div>
                <span class="application-card__id"><?= e($app['application_number']) ?></span>
                <div class="card-title"><?= flag_emoji($app['iso2']) ?> <?= e($app['visa_type_name']) ?> &mdash; <?= e($app['country_name']) ?></div>
            </div>
            <span class="badge badge-info"><?= e(str_replace('_', ' ', $app['status'])) ?></span>
        </div>
        <div class="application-card__meta">
            <span>Applied: <?= e(date('d M Y', strtotime((string) $app['created_at']))) ?></span>
            <span>Progress: <?= (int) $app['progress_percent'] ?>%</span>
        </div>
        <div class="application-card__progress">
            <div class="application-card__progress-bar" style="width:<?= (int) $app['progress_percent'] ?>%"></div>
        </div>
    </a>
    <?php
}

function render_dashboard_end(): void
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
