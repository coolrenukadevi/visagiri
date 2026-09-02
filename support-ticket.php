<?php
/**
 * /support/{code} — one ticket's thread: every customer/employee/system
 * message in order, a reply box, and a "Mark as Resolved" action.
 *
 * Owner-only, same posture as enquiry.php: the code is unique but not
 * secret, so ownership is re-checked here rather than trusted from the URL.
 */
declare(strict_types=1);

require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/includes/partials.php';
require_once __DIR__ . '/lib-php/auth.php';
require_once __DIR__ . '/lib-php/customer_auth.php';
require_once __DIR__ . '/lib-php/enquiries.php';
require_once __DIR__ . '/lib-php/support.php';

header('Cache-Control: no-store, private');
auth_session_start();

$code = trim((string) ($_GET['code'] ?? ''));
$customer = customer_current();
if (!$customer) {
    header('Location: ' . url('/customer-login') . '?next=' . rawurlencode(auth_safe_next('/support/' . $code)), true, 302);
    exit;
}

$ticket = $code !== '' ? ticket_find_by_code($code) : null;
if (!$ticket || (int) $ticket['customer_id'] !== (int) $customer['id']) {
    http_response_code(404);
    require __DIR__ . '/404.php';
    exit;
}

$actionMsg = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = (string) ($_POST['action'] ?? '');
    if (!auth_csrf_valid($_POST['csrf'] ?? null)) {
        $actionMsg = 'Your session expired — please try again.';
    } elseif ($action === 'reply') {
        $message = trim((string) ($_POST['message'] ?? ''));
        if (strlen($message) > 2000) {
            $actionMsg = 'That message is too long (2000 characters max).';
        } elseif (ticket_message_add((int) $ticket['id'], 'customer', (string) $customer['full_name'], $message)) {
            $ticket = ticket_find_by_code($code); // status may have just reopened
            $actionMsg = 'Message sent.';
        } else {
            $actionMsg = 'Message can\'t be empty.';
        }
    } elseif ($action === 'mark_resolved' && ticket_is_active($ticket)) {
        ticket_set_status((int) $ticket['id'], 'Resolved', (string) $customer['full_name']);
        $ticket['status'] = 'Resolved';
        $actionMsg = 'Marked as resolved. Thanks for letting us know.';
    }
}

$linkedEnquiry = $ticket['enquiry_id'] ? enquiry_find_by_code((static function () use ($ticket) {
    $pdo = enquiry_db();
    $st = $pdo->prepare('SELECT enquiry_code FROM enquiries WHERE id = ?');
    $st->execute([$ticket['enquiry_id']]);
    return (string) $st->fetchColumn();
})()) : null;
$messages = ticket_messages_for((int) $ticket['id']);

$crumb = [['label' => 'Home', 'href' => url('/')], ['label' => 'Support', 'href' => url('/support')], ['label' => $ticket['ticket_code']]];
$page = [
    'title'       => $ticket['ticket_code'] . ' | Support | Convercession',
    'short_title' => $ticket['ticket_code'],
    'description' => 'Track your Convercession support ticket.',
    'path'        => '/support/' . $ticket['ticket_code'],
    'noindex'     => true,
    'jsonld'      => [breadcrumb_schema($crumb)],
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

        <div class="enq-detail-grid">
          <div><span class="enq-detail-label">Category</span><span><?= e($ticket['category']) ?></span></div>
          <div><span class="enq-detail-label">Raised</span><span><?= e(date('j F Y, g:i a', (int) $ticket['created_at'])) ?></span></div>
          <?php if ($linkedEnquiry): ?>
          <div><span class="enq-detail-label">Related Enquiry</span><span><a href="<?= url('/enquiry/' . $linkedEnquiry['enquiry_code']) ?>"><?= e($linkedEnquiry['enquiry_code']) ?></a></span></div>
          <?php endif; ?>
          <div><span class="enq-detail-label">Assigned Consultant</span><span><?= $ticket['assigned_employee'] ? e($ticket['assigned_employee']) : 'Not yet assigned' ?></span></div>
        </div>

        <?php if ($actionMsg !== ''): ?><p class="notice-inline"><?= e($actionMsg) ?></p><?php endif; ?>

        <h2 class="account-section-title" style="margin-top:28px">Conversation</h2>
        <div class="enq-timeline">
          <?php foreach ($messages as $m): $isMine = $m['author_type'] === 'customer'; $isSystem = $m['author_type'] === 'system'; ?>
          <div class="enq-tl-item <?= $isMine ? 'is-mine' : ($isSystem ? 'is-system' : 'is-staff') ?>">
            <span class="enq-tl-dot"></span>
            <div class="enq-tl-body">
              <b><?= $isSystem ? '' : e($m['author_name']) . ($isMine ? ' (you)' : ' — Convercession') ?></b>
              <p><?= nl2br(e($m['message'])) ?></p>
              <span><?= e(date('j M Y, g:i a', (int) $m['created_at'])) ?></span>
            </div>
          </div>
          <?php endforeach; ?>
        </div>

        <form method="post" action="<?= url('/support/' . $ticket['ticket_code']) ?>" style="margin-top:20px">
          <input type="hidden" name="csrf" value="<?= e(auth_csrf_token()) ?>">
          <input type="hidden" name="action" value="reply">
          <div class="field">
            <label for="message">Add a message</label>
            <textarea id="message" name="message" rows="3" maxlength="2000" required></textarea>
          </div>
          <div class="wizard-actions" style="margin-top:10px">
            <?php if (ticket_is_active($ticket)): ?>
            <button type="submit" formaction="<?= url('/support/' . $ticket['ticket_code']) ?>" name="action" value="mark_resolved" class="btn btn-outline-brand btn-sm" formnovalidate>Mark as Resolved</button>
            <?php else: ?>
            <span></span>
            <?php endif; ?>
            <button type="submit" class="btn btn-primary btn-sm">Send message</button>
          </div>
        </form>

        <p class="auth-note account-note-wide" style="margin-top:28px">
          <a href="<?= url('/support') ?>">&larr; Back to Support Tickets</a>
        </p>
      </div>
    </div>
  </section>
</main>

<?php include __DIR__ . '/includes/footer.php'; ?>
</body>
</html>
