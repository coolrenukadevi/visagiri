<?php
/**
 * /enquiry/{code} — a single enquiry's detail + status timeline.
 *
 * Owner-only: an enquiry belongs to exactly one customer, and this checks
 * that the signed-in customer_id matches rather than trusting the code alone
 * — the code is unique but not secret (it's shown in the URL and probably
 * emailed/printed), so it must never double as an access token.
 */
declare(strict_types=1);

require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/includes/partials.php';
require_once __DIR__ . '/lib-php/auth.php';
require_once __DIR__ . '/lib-php/customer_auth.php';
require_once __DIR__ . '/lib-php/enquiries.php';

header('Cache-Control: no-store, private');
auth_session_start();

$code = trim((string) ($_GET['code'] ?? ''));
$customer = customer_current();
if (!$customer) {
    header('Location: ' . url('/customer-login') . '?next=' . rawurlencode(auth_safe_next('/enquiry/' . $code)), true, 302);
    exit;
}

$enquiry = $code !== '' ? enquiry_find_by_code($code) : null;
if (!$enquiry || (int) $enquiry['customer_id'] !== (int) $customer['id']) {
    http_response_code(404);
    require __DIR__ . '/404.php';
    exit;
}

$notesSaved = false;
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'save_notes') {
    if (auth_csrf_valid($_POST['csrf'] ?? null)) {
        $notes = trim((string) ($_POST['customer_notes'] ?? ''));
        if (strlen($notes) <= 2000) {
            enquiry_set_customer_notes((int) $enquiry['id'], $notes);
            $enquiry['customer_notes'] = $notes;
            $notesSaved = true;
        }
    }
}

$history = enquiry_status_history_for((int) $enquiry['id']);

// Customer-facing labels only — see includes/enquire-now.php's note on why
// there's no internal-notes/assignment UI yet. Everything shown here is a
// real column on a real row; nothing is invented for display.
$statusLabels = [
    'New' => 'Received',
    'In Progress' => 'In Progress',
    'Completed' => 'Completed',
    'Cancelled' => 'Cancelled',
];
$statusLabel = $statusLabels[$enquiry['status']] ?? $enquiry['status'];

$crumb = [
    ['label' => 'Home', 'href' => url('/')],
    ['label' => 'My account', 'href' => url('/account')],
    ['label' => $enquiry['enquiry_code']],
];
$page = [
    'title'       => $enquiry['enquiry_code'] . ' | Convercession',
    'short_title' => $enquiry['enquiry_code'],
    'description' => 'Track your Convercession enquiry.',
    'path'        => '/enquiry/' . $enquiry['enquiry_code'],
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
            <span class="mono enq-detail-code"><?= e($enquiry['enquiry_code']) ?></span>
            <h1><?= e($enquiry['service_label']) ?> — <?= e($enquiry['country']) ?></h1>
          </div>
          <span class="enq-status-badge status-<?= e(strtolower(str_replace(' ', '-', $enquiry['status']))) ?>"><?= e($statusLabel) ?></span>
        </div>

        <div class="enq-detail-grid">
          <div><span class="enq-detail-label">Travel Purpose</span><span><?= e($enquiry['travel_purpose']) ?></span></div>
          <div><span class="enq-detail-label">Preferred Travel Date</span><span><?= $enquiry['travel_date'] ? e(date('j F Y', strtotime($enquiry['travel_date']))) : 'Not specified' ?></span></div>
          <div><span class="enq-detail-label">Submitted</span><span><?= e(date('j F Y, g:i a', (int) $enquiry['created_at'])) ?></span></div>
          <div><span class="enq-detail-label">Assigned Consultant</span><span><?= $enquiry['assigned_employee'] ? e($enquiry['assigned_employee']) : 'Not yet assigned' ?></span></div>
        </div>

        <?php if ($enquiry['message']): ?>
        <div class="enq-detail-message"><span class="enq-detail-label">Your message</span><p><?= nl2br(e($enquiry['message'])) ?></p></div>
        <?php endif; ?>

        <h2 class="account-section-title" style="margin-top:32px">Status</h2>
        <div class="enq-timeline">
          <?php foreach ($history as $h): ?>
          <div class="enq-tl-item"><span class="enq-tl-dot"></span>
            <div class="enq-tl-body"><b><?= e($h['status']) ?></b><?= $h['note'] ? '<p>' . e($h['note']) . '</p>' : '' ?><span><?= e(date('j M Y, g:i a', (int) $h['created_at'])) ?></span></div>
          </div>
          <?php endforeach; ?>
          <div class="enq-tl-item"><span class="enq-tl-dot is-pending"></span>
            <div class="enq-tl-body"><b class="is-pending">Consultant review</b><span>Once a consultant is assigned, further updates appear here.</span></div>
          </div>
        </div>

        <h2 class="account-section-title" style="margin-top:32px">Your notes</h2>
        <?php if ($notesSaved): ?><p class="notice-inline">Saved.</p><?php endif; ?>
        <form method="post" action="<?= url('/enquiry/' . $enquiry['enquiry_code']) ?>">
          <input type="hidden" name="csrf" value="<?= e(auth_csrf_token()) ?>">
          <input type="hidden" name="action" value="save_notes">
          <div class="field">
            <label for="customer_notes">Add anything else the consultant should know — this is visible to you and your consultant, not a public comment.</label>
            <textarea id="customer_notes" name="customer_notes" rows="3"><?= e($enquiry['customer_notes']) ?></textarea>
          </div>
          <button type="submit" class="btn btn-sm btn-outline-brand" style="margin-top:10px">Save note</button>
        </form>

        <p class="auth-note account-note-wide" style="margin-top:28px">
          <a href="<?= url('/account') ?>">&larr; Back to My Account</a>
        </p>
      </div>
    </div>
  </section>
</main>

<?php include __DIR__ . '/includes/footer.php'; ?>
</body>
</html>
