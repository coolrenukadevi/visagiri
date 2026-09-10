<?php
declare(strict_types=1);

/**
 * Admin notification bell. One row per recipient admin (admin_notifications
 * table, schema-admin-notifications.sql) — same "fan out at creation
 * time" design already used by customer_notifications/partner_notifications/
 * b2b_partner_notifications, so per-admin read state is a plain column
 * on their own row rather than a separate read-receipts table.
 *
 * A notification is never required for the action that triggered it to
 * succeed — every call site wraps notification creation so a failure
 * here can't block a real enquiry/customer action (see notify_admins_by_permission()).
 */

/** Creates one notification for one specific admin. */
function create_admin_notification(int $adminUserId, string $type, string $title, ?string $body = null, ?string $link = null): void
{
    db()->prepare(
        'INSERT INTO admin_notifications (admin_user_id, type, title, body, link) VALUES (:admin_id, :type, :title, :body, :link)'
    )->execute([
        'admin_id' => $adminUserId,
        'type' => $type,
        'title' => $title,
        'body' => $body,
        'link' => $link,
    ]);
}

/**
 * Fans a notification out to every active admin whose role holds the
 * given permission — the honest equivalent of "notify whoever can see
 * this," since nothing in this app auto-assigns a new enquiry to a
 * specific admin at creation time. Never throws: a notification
 * failure is logged to PHP's error log and swallowed, matching the
 * spec's own "must not fail the enquiry" requirement, rather than a
 * silent try/catch that could hide a real bug.
 */
function notify_admins_by_permission(string $permission, string $type, string $title, ?string $body = null, ?string $link = null): void
{
    try {
        $stmt = db()->prepare(
            'SELECT DISTINCT a.id FROM admin_users a
             JOIN role_permissions rp ON rp.role_id = a.role_id
             JOIN permissions p ON p.id = rp.permission_id
             WHERE p.permission_key = :permission AND a.status = "active"'
        );
        $stmt->execute(['permission' => $permission]);
        foreach ($stmt->fetchAll(PDO::FETCH_COLUMN) as $adminId) {
            create_admin_notification((int) $adminId, $type, $title, $body, $link);
        }
    } catch (Throwable $e) {
        error_log('notify_admins_by_permission failed: ' . $e->getMessage());
    }
}

function admin_unread_notification_count(int $adminUserId): int
{
    $stmt = db()->prepare('SELECT COUNT(*) FROM admin_notifications WHERE admin_user_id = :id AND is_read = 0');
    $stmt->execute(['id' => $adminUserId]);
    return (int) $stmt->fetchColumn();
}

/** @return array<int,array<string,mixed>> Most recent notifications, read and unread, newest first. */
function admin_recent_notifications(int $adminUserId, int $limit = 8): array
{
    $stmt = db()->prepare('SELECT * FROM admin_notifications WHERE admin_user_id = :id ORDER BY created_at DESC LIMIT ' . max(1, $limit));
    $stmt->execute(['id' => $adminUserId]);
    return $stmt->fetchAll();
}

/** Marks one notification read — scoped to its owner, so one admin can never mark another's notification. Returns the notification's own link, or null if not found/not owned. */
function mark_admin_notification_read(int $notificationId, int $adminUserId): ?string
{
    $stmt = db()->prepare('SELECT link FROM admin_notifications WHERE id = :id AND admin_user_id = :admin_id');
    $stmt->execute(['id' => $notificationId, 'admin_id' => $adminUserId]);
    $link = $stmt->fetchColumn();
    if ($link === false) {
        return null;
    }
    db()->prepare('UPDATE admin_notifications SET is_read = 1, read_at = NOW() WHERE id = :id AND admin_user_id = :admin_id')
        ->execute(['id' => $notificationId, 'admin_id' => $adminUserId]);
    return $link ?: null;
}

function mark_all_admin_notifications_read(int $adminUserId): void
{
    db()->prepare('UPDATE admin_notifications SET is_read = 1, read_at = NOW() WHERE admin_user_id = :id AND is_read = 0')
        ->execute(['id' => $adminUserId]);
}
