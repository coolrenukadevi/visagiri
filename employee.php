<?php
/**
 * /employee — the employee console dashboard: KPIs, the unassigned queue,
 * and "my" queue. Verification, status changes and internal notes all
 * happen one enquiry at a time on /employee/enquiry/{code}
 * (employee-enquiry.php) — this page is deliberately just a queue, not a
 * place actions happen, so it stays fast to scan.
 */
declare(strict_types=1);

require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/includes/partials.php';
require_once __DIR__ . '/lib-php/auth.php';
require_once __DIR__ . '/lib-php/employee_auth.php';
require_once __DIR__ . '/lib-php/enquiries.php';
require_once __DIR__ . '/lib-php/documents.php';

header('Cache-Control: no-store, private');
auth_session_start();

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'employee_logout') {
    if (auth_csrf_valid($_POST['csrf'] ?? null)) {
        employee_logout();
    }
    header('Location: ' . url('/'), true, 302);
    exit;
}

$employee = employee_current();
if (!$employee) {
    header('Location: ' . url('/employee-login') . '?next=' . rawurlencode(auth_safe_next('/employee')), true, 302);
    exit;
}

$myName = (string) $employee['full_name'];
$unassigned = enquiries_unassigned();
$myQueue = enquiries_assigned_to($myName);
$myActiveCount = count(array_filter($myQueue, 'enquiry_is_active'));
$myCompletedCount = count($myQueue) - $myActiveCount;
$awaitingReview = documents_awaiting_review_count_for($myName);

$crumb = [['label' => 'Home', 'href' => url('/')], ['label' => 'Employee Console']];
$page = [
    'title'       => 'Employee Console | Convercession',
    'short_title' => 'Employee Console',
    'description' => 'Convercession employee console.',
    'path'        => '/employee',
    'noindex'     => true,
    'jsonld'      => [],
];

/** Renders one queue's rows using the exact same enquiry-card markup the
 *  customer's My Enquiries list already uses (account.php) — same CSS,
 *  no new classes needed. Quick actions live on the detail page, not here,
 *  so a card can stay a plain link rather than a form-inside-a-link. */
$empQueueRow = static function (array $enq): void { ?>
  <a class="enquiry-card" href="<?= url('/employee/enquiry/' . $enq['enquiry_code']) ?>">
    <div class="enquiry-card-main">
      <span class="enquiry-card-code"><?= e($enq['enquiry_code']) ?></span>
      <div class="enquiry-card-title"><?= e($enq['service_label']) ?> — <?= e($enq['country']) ?></div>
      <div class="enquiry-card-meta"><?= e($enq['customer_name']) ?> (<?= e($enq['customer_code']) ?>) · Submitted <?= e(date('j M Y', (int) $enq['created_at'])) ?></div>
    </div>
    <span class="enq-status-badge status-<?= e(strtolower(str_replace(' ', '-', $enq['status']))) ?>"><?= $enq['status'] === 'New' ? 'Received' : e($enq['status']) ?></span>
  </a>
<?php };
?><!DOCTYPE html>
<html lang="en">
<head><?php include __DIR__ . '/includes/head.php'; ?></head>
<body>
<?php include __DIR__ . '/includes/header.php'; ?>

<main>
  <section class="section auth-section">
    <div class="container">
      <?= breadcrumbs($crumb) ?>

      <div class="account-head">
        <span class="account-avatar account-avatar-initial" aria-hidden="true"><?= e(mb_strtoupper(mb_substr($myName, 0, 1))) ?></span>
        <div>
          <h1>Employee Console</h1>
          <p class="account-sub">
            <?= e($myName) ?> · <span class="mono"><?= e($employee['employee_code']) ?></span> · <?= e($employee['role']) ?>
          </p>
        </div>
        <form method="post" action="<?= url('/employee') ?>" class="account-signout">
          <input type="hidden" name="csrf" value="<?= e(auth_csrf_token()) ?>">
          <input type="hidden" name="action" value="employee_logout">
          <button type="submit" class="btn btn-sm btn-outline-brand">Sign out</button>
        </form>
      </div>

      <div class="fact-strip">
        <div class="fact-tile"><strong><?= count($unassigned) ?></strong><span>Unassigned Enquiries</span></div>
        <div class="fact-tile"><strong><?= $myActiveCount ?></strong><span>My Active Enquiries</span></div>
        <div class="fact-tile"><strong><?= $awaitingReview ?></strong><span>My Docs Awaiting Review</span></div>
        <div class="fact-tile"><strong><?= $myCompletedCount ?></strong><span>My Completed</span></div>
      </div>

      <h2 class="account-section-title" style="margin-top:32px">Unassigned Queue</h2>
      <?php if ($unassigned): ?>
      <div class="enquiry-card-row"><?php foreach ($unassigned as $enq) $empQueueRow($enq); ?></div>
      <?php else: ?>
      <div class="enquiries-panel"><div class="enquiries-empty">
        <h3>Nothing unassigned</h3>
        <p>Every open enquiry currently has a consultant. Check back later, or see your own queue below.</p>
      </div></div>
      <?php endif; ?>

      <h2 class="account-section-title" style="margin-top:32px">My Queue</h2>
      <?php if ($myQueue): ?>
      <div class="enquiry-card-row"><?php foreach ($myQueue as $enq) $empQueueRow($enq); ?></div>
      <?php else: ?>
      <div class="enquiries-panel"><div class="enquiries-empty">
        <h3>Nothing assigned to you yet</h3>
        <p>Open an enquiry from the Unassigned Queue above and assign it to yourself to start working it.</p>
      </div></div>
      <?php endif; ?>
    </div>
  </section>
</main>

<?php include __DIR__ . '/includes/footer.php'; ?>
</body>
</html>
