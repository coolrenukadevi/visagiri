<?php
declare(strict_types=1);

/**
 * Follow-up reminders on enquiries (database/schema-reminders.sql).
 * Deliberately admin-triggered rather than cron-driven — see the
 * schema file's own comment and AUDIT.md's document-expiry/tier-
 * recalculation entries for the same prior decision: no cron
 * infrastructure exists anywhere in this project, and cPanel Cron Jobs
 * availability on the client's actual hosting plan has never been
 * confirmed. notify_due_reminders() is cheap (a handful of indexed
 * queries) and idempotent (notified_at guards against re-notifying), so
 * calling it opportunistically on every dashboard load gives reminders
 * a "just happens" feel without depending on an unconfirmed scheduler.
 * bin/check-reminders.php exposes the same function as an optional CLI
 * entrypoint if the client's plan does support cron.
 */

function create_reminder(?int $enquiryId, string $title, ?string $note, string $dueDate, ?int $assignedAdminId, int $createdBy): int
{
    db()->prepare(
        'INSERT INTO reminders (enquiry_id, title, note, due_date, assigned_admin_id, created_by)
         VALUES (:enquiry_id, :title, :note, :due_date, :assigned, :created_by)'
    )->execute([
        'enquiry_id' => $enquiryId,
        'title' => $title,
        'note' => $note !== '' ? $note : null,
        'due_date' => $dueDate,
        'assigned' => $assignedAdminId,
        'created_by' => $createdBy,
    ]);
    return (int) db()->lastInsertId();
}

/** @return array<int,array<string,mixed>> Reminders for one enquiry, soonest-due first. */
function reminders_for_enquiry(int $enquiryId): array
{
    $stmt = db()->prepare(
        'SELECT r.*, a.full_name AS assigned_name FROM reminders r
         LEFT JOIN admin_users a ON a.id = r.assigned_admin_id
         WHERE r.enquiry_id = :id ORDER BY r.status = "done", r.due_date ASC'
    );
    $stmt->execute(['id' => $enquiryId]);
    return $stmt->fetchAll();
}

/**
 * Reminders list for the /admin/reminders/ page. $filter is one of
 * 'overdue', 'today', 'upcoming', 'done', 'mine', or 'all'.
 * $scopedToAdminId restricts to one admin's own reminders regardless of
 * filter when set (matches current_admin_scoped_to_assigned() usage
 * elsewhere) — pass null for an unscoped role.
 */
function list_reminders(string $filter, ?int $scopedToAdminId = null, ?int $currentAdminId = null): array
{
    $where = [];
    $params = [];

    if ($scopedToAdminId !== null) {
        $where[] = 'r.assigned_admin_id = :scoped';
        $params['scoped'] = $scopedToAdminId;
    }

    switch ($filter) {
        case 'overdue':
            $where[] = "r.status = 'pending' AND r.due_date < CURDATE()";
            break;
        case 'today':
            $where[] = "r.status = 'pending' AND r.due_date = CURDATE()";
            break;
        case 'upcoming':
            $where[] = "r.status = 'pending' AND r.due_date > CURDATE()";
            break;
        case 'done':
            $where[] = "r.status = 'done'";
            break;
        case 'mine':
            $where[] = 'r.assigned_admin_id = :mine';
            $params['mine'] = $currentAdminId;
            break;
        default:
            break;
    }

    $whereSql = $where ? ('WHERE ' . implode(' AND ', $where)) : '';
    $stmt = db()->prepare(
        "SELECT r.*, a.full_name AS assigned_name, e.enquiry_number, e.name AS enquiry_customer_name
         FROM reminders r
         LEFT JOIN admin_users a ON a.id = r.assigned_admin_id
         LEFT JOIN enquiries e ON e.id = r.enquiry_id
         $whereSql
         ORDER BY r.status = 'done', r.due_date ASC LIMIT 200"
    );
    $stmt->execute($params);
    return $stmt->fetchAll();
}

/** @return array{overdue:int,today:int,upcoming:int} Counts for the dashboard widget, optionally scoped to one admin. */
function reminder_due_counts(?int $scopedToAdminId = null): array
{
    $scopeSql = $scopedToAdminId !== null ? ' AND assigned_admin_id = :scoped' : '';
    $params = $scopedToAdminId !== null ? ['scoped' => $scopedToAdminId] : [];

    $stmt = db()->prepare("SELECT COUNT(*) FROM reminders WHERE status = 'pending' AND due_date < CURDATE()$scopeSql");
    $stmt->execute($params);
    $overdue = (int) $stmt->fetchColumn();

    $stmt = db()->prepare("SELECT COUNT(*) FROM reminders WHERE status = 'pending' AND due_date = CURDATE()$scopeSql");
    $stmt->execute($params);
    $today = (int) $stmt->fetchColumn();

    $stmt = db()->prepare("SELECT COUNT(*) FROM reminders WHERE status = 'pending' AND due_date > CURDATE()$scopeSql");
    $stmt->execute($params);
    $upcoming = (int) $stmt->fetchColumn();

    return ['overdue' => $overdue, 'today' => $today, 'upcoming' => $upcoming];
}

function mark_reminder_done(int $reminderId): void
{
    db()->prepare("UPDATE reminders SET status = 'done', completed_at = NOW() WHERE id = :id")->execute(['id' => $reminderId]);
}

/** Pushes a pending reminder's due_date forward by $days (default 1) and clears any prior notification so it re-notifies when it comes due again. */
function snooze_reminder(int $reminderId, int $days = 1): void
{
    db()->prepare(
        "UPDATE reminders SET due_date = DATE_ADD(GREATEST(due_date, CURDATE()), INTERVAL :days DAY), notified_at = NULL
         WHERE id = :id AND status = 'pending'"
    )->execute(['days' => $days, 'id' => $reminderId]);
}

/**
 * Fans out one admin_notifications row per due-and-not-yet-notified
 * reminder — to its assigned admin, or (if unassigned) to every admin
 * holding reminders.manage via notify_admins_by_permission(). Safe to
 * call on every dashboard load: notified_at is set in the same pass
 * that creates the notification, so a reminder is only ever announced
 * once per due date (snoozing clears notified_at, so a re-snoozed
 * reminder notifies again when its new date arrives). Never throws —
 * matches notify_admins_by_permission()'s own "must not break the page
 * that triggered it" contract.
 */
function notify_due_reminders(): void
{
    try {
        $pdo = db();
        $stmt = $pdo->query(
            "SELECT r.id, r.title, r.enquiry_id, r.assigned_admin_id, e.enquiry_number
             FROM reminders r
             LEFT JOIN enquiries e ON e.id = r.enquiry_id
             WHERE r.status = 'pending' AND r.due_date <= CURDATE() AND r.notified_at IS NULL"
        );
        $due = $stmt->fetchAll();

        foreach ($due as $reminder) {
            $link = $reminder['enquiry_id'] ? '/admin/enquiries/?id=' . (int) $reminder['enquiry_id'] : '/admin/reminders/';
            $body = $reminder['enquiry_number'] ? 'Enquiry: ' . $reminder['enquiry_number'] : null;

            if ($reminder['assigned_admin_id']) {
                create_admin_notification((int) $reminder['assigned_admin_id'], 'reminder_due', 'Reminder: ' . $reminder['title'], $body, $link);
            } else {
                notify_admins_by_permission('reminders.manage', 'reminder_due', 'Reminder: ' . $reminder['title'], $body, $link);
            }

            $pdo->prepare('UPDATE reminders SET notified_at = NOW() WHERE id = :id')->execute(['id' => $reminder['id']]);
        }
    } catch (Throwable $e) {
        error_log('notify_due_reminders failed: ' . $e->getMessage());
    }
}
