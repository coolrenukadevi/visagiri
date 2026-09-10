<?php
declare(strict_types=1);

/**
 * Follow-up reminders list — general task reminders here, or ones
 * created from a specific enquiry's detail page (admin/pages/enquiries.php).
 * See includes/reminders.php for why this is admin-triggered rather
 * than cron-driven.
 */

require_permission('reminders.manage');

$pdo = db();
$scopedToAssigned = current_admin_scoped_to_assigned();
$myId = current_admin_id();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $postAction = $_POST['action'] ?? '';

    if ($postAction === 'create') {
        $title = trim((string) ($_POST['title'] ?? ''));
        $note = trim((string) ($_POST['note'] ?? ''));
        $dueDate = trim((string) ($_POST['due_date'] ?? ''));
        $assignedAdminId = (int) ($_POST['assigned_admin_id'] ?? 0) ?: $myId;
        $enquiryId = (int) ($_POST['enquiry_id'] ?? 0) ?: null;
        $redirectTo = $enquiryId ? '/admin/enquiries/?id=' . $enquiryId : '/admin/reminders/';

        if ($title !== '' && $dueDate !== '' && preg_match('/^\d{4}-\d{2}-\d{2}$/', $dueDate)) {
            create_reminder($enquiryId, $title, $note, $dueDate, $assignedAdminId, $myId);
            flash_set('admin_notice', 'Reminder created.');
        } else {
            flash_set('admin_error', 'Title and a valid due date are required.');
        }
        redirect($redirectTo);
    }

    if ($postAction === 'mark_done') {
        mark_reminder_done((int) ($_POST['reminder_id'] ?? 0));
        flash_set('admin_notice', 'Reminder marked done.');
        redirect('/admin/reminders/?filter=' . urlencode((string) ($_POST['filter'] ?? '')));
    }

    if ($postAction === 'snooze') {
        $days = max(1, (int) ($_POST['days'] ?? 1));
        snooze_reminder((int) ($_POST['reminder_id'] ?? 0), $days);
        flash_set('admin_notice', 'Reminder snoozed ' . $days . ' day' . ($days === 1 ? '' : 's') . '.');
        redirect('/admin/reminders/?filter=' . urlencode((string) ($_POST['filter'] ?? '')));
    }
}

$filter = in_array($_GET['filter'] ?? '', ['overdue', 'today', 'upcoming', 'done', 'mine', 'all'], true) ? $_GET['filter'] : 'overdue';
$reminders = list_reminders($filter, $scopedToAssigned ? $myId : null, $myId);
$counts = reminder_due_counts($scopedToAssigned ? $myId : null);
$admins = $pdo->query('SELECT id, full_name FROM admin_users WHERE status = "active" ORDER BY full_name')->fetchAll();

$tabs = [
    'overdue' => 'Overdue (' . $counts['overdue'] . ')',
    'today' => 'Due Today (' . $counts['today'] . ')',
    'upcoming' => 'Upcoming (' . $counts['upcoming'] . ')',
    'mine' => 'Mine',
    'all' => 'All',
    'done' => 'Done',
];

admin_header_start('Reminders', 'reminders');
admin_subnav('leads', 'reminders');
?>
<div class="admin-form-card" style="margin-bottom:var(--space-5)">
    <h3>Create a Reminder</h3>
    <form method="post" action="/admin/reminders/">
        <?= csrf_field() ?>
        <input type="hidden" name="action" value="create">
        <div class="admin-form-grid">
            <div class="form-group">
                <label class="form-label" for="title">Title <span class="required-mark">*</span></label>
                <input class="form-input" type="text" id="title" name="title" required placeholder="e.g. Call customer about pending passport copy">
            </div>
            <div class="form-group">
                <label class="form-label" for="due_date">Due Date <span class="required-mark">*</span></label>
                <input class="form-input" type="date" id="due_date" name="due_date" required>
            </div>
            <div class="form-group">
                <label class="form-label" for="assigned_admin_id">Assign To</label>
                <select class="form-select" id="assigned_admin_id" name="assigned_admin_id">
                    <?php foreach ($admins as $adm): ?>
                    <option value="<?= (int) $adm['id'] ?>"<?= (int) $adm['id'] === $myId ? ' selected' : '' ?>><?= e($adm['full_name']) ?><?= (int) $adm['id'] === $myId ? ' (Me)' : '' ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="form-label" for="note">Note</label>
            <input class="form-input" type="text" id="note" name="note" placeholder="Optional details">
        </div>
        <button type="submit" class="btn btn-primary">Create Reminder</button>
    </form>
</div>

<div class="admin-tabs" style="margin-bottom:var(--space-4)">
    <?php foreach ($tabs as $key => $label): ?>
    <a href="/admin/reminders/?filter=<?= $key ?>" class="btn btn-sm <?= $filter === $key ? 'btn-primary' : 'btn-outline' ?>"><?= e($label) ?></a>
    <?php endforeach; ?>
</div>

<?php if (!$reminders): ?>
<p class="empty-state">No reminders in this view.</p>
<?php else: ?>
<div class="admin-table-scroll">
<table class="admin-table">
    <thead><tr><th>Title</th><th>Enquiry</th><th>Assigned To</th><th>Due Date</th><th>Status</th><th></th></tr></thead>
    <tbody>
    <?php foreach ($reminders as $r):
        $daysLeft = (int) floor((strtotime((string) $r['due_date']) - strtotime(date('Y-m-d'))) / 86400);
        if ($r['status'] === 'done') {
            $badgeClass = 'badge-success';
            $statusText = 'Done';
        } elseif ($daysLeft < 0) {
            $badgeClass = 'badge-danger';
            $statusText = 'Overdue ' . abs($daysLeft) . ' day' . (abs($daysLeft) === 1 ? '' : 's');
        } elseif ($daysLeft === 0) {
            $badgeClass = 'badge-warning';
            $statusText = 'Due Today';
        } else {
            $badgeClass = 'badge-info';
            $statusText = 'In ' . $daysLeft . ' day' . ($daysLeft === 1 ? '' : 's');
        }
    ?>
        <tr>
            <td><?= e($r['title']) ?><?php if ($r['note']): ?><br><small style="color:var(--text-muted)"><?= e($r['note']) ?></small><?php endif; ?></td>
            <td><?= $r['enquiry_id'] ? '<a href="/admin/enquiries/?id=' . (int) $r['enquiry_id'] . '">' . e($r['enquiry_number']) . '</a>' : '—' ?></td>
            <td><?= $r['assigned_name'] ? e($r['assigned_name']) : '— Unassigned —' ?></td>
            <td><?= e(date('d M Y', strtotime((string) $r['due_date']))) ?></td>
            <td><span class="badge <?= $badgeClass ?>"><?= e($statusText) ?></span></td>
            <td class="actions">
                <?php if ($r['status'] === 'pending'): ?>
                <form method="post" action="/admin/reminders/" style="display:inline">
                    <?= csrf_field() ?>
                    <input type="hidden" name="action" value="mark_done">
                    <input type="hidden" name="reminder_id" value="<?= (int) $r['id'] ?>">
                    <input type="hidden" name="filter" value="<?= e($filter) ?>">
                    <button type="submit" class="btn btn-outline btn-sm">Mark Done</button>
                </form>
                <form method="post" action="/admin/reminders/" style="display:inline">
                    <?= csrf_field() ?>
                    <input type="hidden" name="action" value="snooze">
                    <input type="hidden" name="reminder_id" value="<?= (int) $r['id'] ?>">
                    <input type="hidden" name="days" value="1">
                    <input type="hidden" name="filter" value="<?= e($filter) ?>">
                    <button type="submit" class="btn btn-outline btn-sm">+1 Day</button>
                </form>
                <?php endif; ?>
            </td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
</div>
<?php endif; ?>
<?php
admin_header_end();
