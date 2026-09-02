<?php
/**
 * /employee/ticket/{code} — the employee-side workspace for one support
 * ticket: full thread, a reply box, assignment and status.
 *
 * Same "any signed-in employee can act on any ticket" scope boundary as
 * employee-enquiry.php — see that file's docblock for why.
 */
declare(strict_types=1);

require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/includes/partials.php';
require_once __DIR__ . '/lib-php/auth.php';
require_once __DIR__ . '/lib-php/employee_auth.php';
require_once __DIR__ . '/lib-php/customer_auth.php';
require_once __DIR__ . '/lib-php/enquiries.php';
require_once __DIR__ . '/lib-php/support.php';

header('Cache-Control: no-store, private');
auth_session_start();

$code = trim((string) ($_GET['code'] ?? ''));
$employee = employee_current();
if (!$employee) {
    header('Location: ' . url('/employee-login') . '?next=' . rawurlencode(auth_safe_next('/employee/ticket/' . $code)), true, 302);
    exit;
}
$myName = (string) $employee['full_name'];

$ticket = $code !== '' ? ticket_find_by_code($code) : null;
if (!$ticket) {
    http_response_code(404);
    require __DIR__ . '/404.php';
    exit;
}
$customer = customer_find((int) $ticket['customer_id']);
$linkedEnquiry = $ticket['enquiry_id'] ? enquiry_find_by_id((int) $ticket['enquiry_id']) : null;

$actionMsg = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = (string) ($_POST['action'] ?? '');
    if (!auth_csrf_valid($_POST['csrf'] ?? null)) {
        $actionMsg = 'Your session expired — please try again.';
    } elseif ($action === 'assign_to_me') {
        ticket_assign((int) $ticket['id'], $myName, (string) $employee['role']);
        $ticket['assigned_employee'] = $myName;
        $ticket['assigned_department'] = $employee['role'];
        $actionMsg = 'Assigned to you.';
    } elseif ($action === 'unassign') {
        ticket_unassign((int) $ticket['id']);
        $ticket['assigned_employee'] = null;
        $ticket['assigned_department'] = null;
        $actionMsg = 'Unassigned.';
    } elseif ($action === 'set_status') {
        $status = (string) ($_POST['status'] ?? '');
        if (ticket_set_status((int) $ticket['id'], $status, $myName)) {
            $ticket['status'] = $status;
            $actionMsg = 'Status updated.';
        } else {
            $actionMsg = 'Choose a valid status.';
        }
    } elseif ($action === 'reply') {
        $message = trim((string) ($_POST['message'] ?? ''));
        if (strlen($message) > 2000) {
            $actionMsg = 'That message is too long (2000 characters max).';
        } elseif (ticket_message_add((int) $ticket['id'], 'employee', $myName, $message)) {
            $actionMsg = 'Reply sent.';
        } else {
            $actionMsg = 'Message can\'t be empty.';
        }
    }
}

$messages = ticket_messages_for((int) $ticket['id']);

$crumb = [['label' => 'Home', 'href' => url('/')], ['label' => 'Employee Console', 'href' => url('/employee')], ['label' => $ticket['ticket_code']]];
$page = [
    'title'       => $ticket['ticket_code'] . ' | Employee Console | Convercession',
    'short_title' => $ticket['ticket_code'],
    'description' => 'Employee workspace for a support ticket.',
    'path'        => '/employee/ticket/' . $ticket['ticket_code'],
    'noindex'     => true,
    'jsonld'      => [],
];
?><!DOCTYPE html>
<html lang="en">
<head><?php include __DIR__ . '/includes/head.php'; ?></head>
<body>
<?php include __DIR__ . '/includes/header.php'; ?>

<main>
  <section class="section auth-section">
    <div class="container"><?= breadcrumbs($crumb) ?></div>
    <div class="container">
      <div class="auth-card auth-card-wide">
        <div class="enq-detail-head">
          <div>
            <span class="mono enq-detail-code"><?= e($ticket['ticket_code']) ?></span>
            <h1><?= e($ticket['subject']) ?></h1>
          </div>
          <span class="enq-status-badge status-<?= e(strtolower(str_replace(' ', '-', $ticket['status']))) ?>"><?= e($ticket['status']) ?></span>
        </div>

        <?php $detailPairs = [
          ['Customer', $customer ? $customer['full_name'] . ' (' . $customer['customer_code'] . ')' : 'Unknown'],
          ['Customer Contact', $customer ? $customer['mobile'] . ' · ' . $customer['email'] : ''],
          ['Category', $ticket['category']],
          ['Raised', date('j F Y, g:i a', (int) $ticket['created_at'])],
        ]; if ($linkedEnquiry) $detailPairs[] = ['Related Enquiry', $linkedEnquiry['enquiry_code']];
        $detailPairs[] = ['Assigned To', $ticket['assigned_employee'] ? $ticket['assigned_employee'] . ($ticket['assigned_department'] ? ' (' . $ticket['assigned_department'] . ')' : '') : ''];
        ?>
        <div class="enq-detail-grid">
          <?php foreach ($detailPairs as [$label, $value]): ?>
          <div><span class="enq-detail-label"><?= e($label) ?></span><span><?= $value !== '' ? ($label === 'Related Enquiry' ? '<a href="' . url('/employee/enquiry/' . $value) . '">' . e($value) . '</a>' : e($value)) : '—' ?></span></div>
          <?php endforeach; ?>
        </div>

        <?php if ($actionMsg !== ''): ?><p class="notice-inline"><?= e($actionMsg) ?></p><?php endif; ?>

        <div class="wizard-actions" style="margin-top:14px">
          <span></span>
          <?php if ($ticket['assigned_employee'] === $myName): ?>
          <form method="post" action="<?= url('/employee/ticket/' . $ticket['ticket_code']) ?>">
            <input type="hidden" name="csrf" value="<?= e(auth_csrf_token()) ?>">
            <input type="hidden" name="action" value="unassign">
            <button type="submit" class="btn btn-outline-brand btn-sm">Unassign from me</button>
          </form>
          <?php else: ?>
          <form method="post" action="<?= url('/employee/ticket/' . $ticket['ticket_code']) ?>">
            <input type="hidden" name="csrf" value="<?= e(auth_csrf_token()) ?>">
            <input type="hidden" name="action" value="assign_to_me">
            <button type="submit" class="btn btn-primary btn-sm"><?= $ticket['assigned_employee'] ? 'Reassign to me' : 'Assign to me' ?></button>
          </form>
          <?php endif; ?>
        </div>

        <form method="post" action="<?= url('/employee/ticket/' . $ticket['ticket_code']) ?>" class="enquiry-grid" style="margin-top:14px">
          <input type="hidden" name="csrf" value="<?= e(auth_csrf_token()) ?>">
          <input type="hidden" name="action" value="set_status">
          <div class="enquiry-field">
            <label for="status">Status</label>
            <select id="status" name="status">
              <?php foreach (TICKET_STATUSES as $s): ?>
              <option value="<?= e($s) ?>" <?= $ticket['status'] === $s ? 'selected' : '' ?>><?= e($s) ?></option>
              <?php endforeach; ?>
            </select>
          </div>
          <div class="wizard-actions" style="grid-column:1/-1"><span></span><button type="submit" class="btn btn-outline-brand btn-sm">Update status</button></div>
        </form>

        <h2 class="account-section-title" style="margin-top:28px">Conversation</h2>
        <div class="enq-timeline">
          <?php foreach ($messages as $m): $isStaff = $m['author_type'] === 'employee'; $isSystem = $m['author_type'] === 'system'; ?>
          <div class="enq-tl-item <?= $isStaff ? 'is-staff' : ($isSystem ? 'is-system' : 'is-mine') ?>">
            <span class="enq-tl-dot"></span>
            <div class="enq-tl-body">
              <b><?= $isSystem ? '' : e($m['author_name']) . ($isStaff ? ' (you / staff)' : ' — customer') ?></b>
              <p><?= nl2br(e($m['message'])) ?></p>
              <span><?= e(date('j M Y, g:i a', (int) $m['created_at'])) ?></span>
            </div>
          </div>
          <?php endforeach; ?>
        </div>

        <form method="post" action="<?= url('/employee/ticket/' . $ticket['ticket_code']) ?>" style="margin-top:20px">
          <input type="hidden" name="csrf" value="<?= e(auth_csrf_token()) ?>">
          <input type="hidden" name="action" value="reply">
          <div class="field">
            <label for="message">Reply to the customer</label>
            <textarea id="message" name="message" rows="3" maxlength="2000" required></textarea>
          </div>
          <button type="submit" class="btn btn-primary btn-sm" style="margin-top:10px">Send reply</button>
        </form>

        <p class="auth-note account-note-wide" style="margin-top:28px">
          <a href="<?= url('/employee') ?>">&larr; Back to Employee Console</a>
        </p>
      </div>
    </div>
  </section>
</main>

<?php include __DIR__ . '/includes/footer.php'; ?>
</body>
</html>
