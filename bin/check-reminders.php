<?php
declare(strict_types=1);

/**
 * Optional CLI entrypoint for notify_due_reminders() (includes/reminders.php).
 * Reminders already surface without this — notify_due_reminders() is
 * also called on every admin dashboard load (admin/pages/dashboard.php),
 * so nothing breaks if this script is never run. It exists only for a
 * client whose cPanel plan does offer Cron Jobs and wants reminders to
 * notify even on a day nobody happens to open the dashboard.
 *
 * cPanel Cron Jobs example (adjust the PHP binary path per MultiPHP
 * Manager, and the path to wherever this script landed after the
 * cPanel package was extracted):
 *   /usr/local/bin/php /home/USER/public_html/bin/check-reminders.php
 * Once a day is enough — reminders are date-granular (due_date is a
 * DATE, not a timestamp), so running this more than once a day has no
 * additional effect.
 *
 * Run manually to test: php bin/check-reminders.php
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(403);
    exit("This script is CLI-only.\n");
}

$root = __DIR__ . '/..';

require_once "$root/includes/config.php";
require_once "$root/includes/database.php";
require_once "$root/includes/settings.php";
require_once "$root/includes/functions.php";
require_once "$root/includes/data.php";
require_once "$root/includes/security.php";
require_once "$root/includes/auth.php";
require_once "$root/includes/rbac.php";
require_once "$root/includes/audit.php";
require_once "$root/includes/admin-notifications.php";
require_once "$root/includes/reminders.php";

$before = (int) db()->query("SELECT COUNT(*) FROM reminders WHERE status = 'pending' AND due_date <= CURDATE() AND notified_at IS NULL")->fetchColumn();
notify_due_reminders();
$after = (int) db()->query("SELECT COUNT(*) FROM reminders WHERE status = 'pending' AND due_date <= CURDATE() AND notified_at IS NULL")->fetchColumn();

echo date('Y-m-d H:i:s') . " check-reminders: {$before} due reminder(s) found, " . ($before - $after) . " notified.\n";
