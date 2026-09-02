<?php
/**
 * In-app notifications — the one channel in this phase that is fully real
 * and always works, independent of whether any outbound provider is ever
 * configured (see notify_channels.php for those, and their honesty rule).
 *
 * A notification targets either a customer or an employee, never both —
 * recipient_type/recipient_id, the same shape ticket_messages.author_type
 * already uses rather than two nullable FK columns fighting each other.
 * Employee-targeted notifications are created by name (matching how
 * assignment itself is name-keyed — see enquiries.php's docblock) via
 * notification_notify_employee_by_name(), which is why this file, unlike
 * enquiries.php/documents.php/support.php, is allowed to depend on
 * employee_auth.php: it owns the one place that name-to-id lookup happens.
 *
 * Pure data layer only — creating a notification and best-effort emailing
 * about it are two different concerns kept in two different files; see
 * notify_channels.php for the orchestration (and for why it, not this
 * file, owns that to avoid a require_once cycle).
 */
declare(strict_types=1);

require_once __DIR__ . '/auth.php';
require_once __DIR__ . '/employee_auth.php';

function notification_migrate(PDO $pdo): void
{
    $pdo->exec("
        CREATE TABLE IF NOT EXISTS notifications (
            id              INTEGER PRIMARY KEY AUTOINCREMENT,
            recipient_type  TEXT NOT NULL,
            recipient_id    INTEGER NOT NULL,
            type            TEXT NOT NULL,
            title           TEXT NOT NULL,
            body            TEXT NOT NULL,
            link            TEXT,
            read_at         INTEGER,
            created_at      INTEGER NOT NULL
        )");
    $pdo->exec('CREATE INDEX IF NOT EXISTS idx_notifications_recipient ON notifications(recipient_type, recipient_id, created_at)');
}

function notification_db(): ?PDO
{
    static $migrated = false;
    $pdo = auth_db();
    if (!$pdo) return null;
    if (!$migrated) {
        notification_migrate($pdo);
        $migrated = true;
    }
    return $pdo;
}

function notification_create(string $recipientType, int $recipientId, string $type, string $title, string $body, ?string $link = null): void
{
    $pdo = notification_db();
    if (!$pdo || !in_array($recipientType, ['customer', 'employee'], true)) return;
    $pdo->prepare('
        INSERT INTO notifications (recipient_type, recipient_id, type, title, body, link, created_at)
        VALUES (?, ?, ?, ?, ?, ?, ?)')
        ->execute([$recipientType, $recipientId, $type, $title, $body, $link, time()]);
}

/** Resolves the employee by name (see this file's docblock) and no-ops
 *  quietly if nobody matches — a stale or since-renamed assigned_employee
 *  string shouldn't fatal a status change or a reply. */
function notification_notify_employee_by_name(string $employeeName, string $type, string $title, string $body, ?string $link = null): void
{
    $employee = employee_find_by_name($employeeName);
    if ($employee) {
        notification_create('employee', (int) $employee['id'], $type, $title, $body, $link);
    }
}

function notifications_for(string $recipientType, int $recipientId, int $limit = 15): array
{
    $pdo = notification_db();
    if (!$pdo) return [];
    $st = $pdo->prepare('SELECT * FROM notifications WHERE recipient_type = ? AND recipient_id = ? ORDER BY created_at DESC, id DESC LIMIT ?');
    $st->execute([$recipientType, $recipientId, $limit]);
    return $st->fetchAll();
}

function notifications_unread_count(string $recipientType, int $recipientId): int
{
    $pdo = notification_db();
    if (!$pdo) return 0;
    $st = $pdo->prepare('SELECT COUNT(*) FROM notifications WHERE recipient_type = ? AND recipient_id = ? AND read_at IS NULL');
    $st->execute([$recipientType, $recipientId]);
    return (int) $st->fetchColumn();
}

function notifications_mark_all_read(string $recipientType, int $recipientId): void
{
    $pdo = notification_db();
    if (!$pdo) return;
    $pdo->prepare('UPDATE notifications SET read_at = ? WHERE recipient_type = ? AND recipient_id = ? AND read_at IS NULL')
        ->execute([time(), $recipientType, $recipientId]);
}
