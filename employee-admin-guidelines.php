<?php
/**
 * /employee/admin/guidelines — the editor that finally lets an admin
 * replace a "To be configured by administrator" placeholder with a real,
 * source-checked FEMA/RBI figure.
 *
 * This page does not know what the right numbers are and must never guess
 * — see lib-php/compliance.php's docblock for why that's the one rule in
 * this project that can't be worked around. It only saves what the signed-
 * in admin actually typed. compliance_is_placeholder() already flips the
 * public /forex-guidelines badge from "Not yet confirmed" to "Confirmed"
 * the moment the summary text no longer contains the placeholder phrase —
 * that wiring shipped in Phase 6, this page is just its editor.
 */
declare(strict_types=1);

require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/includes/partials.php';
require_once __DIR__ . '/lib-php/auth.php';
require_once __DIR__ . '/lib-php/employee_auth.php';
require_once __DIR__ . '/lib-php/enquiries.php';
require_once __DIR__ . '/lib-php/compliance.php';

header('Cache-Control: no-store, private');
auth_session_start();

$employee = employee_current();
if (!$employee) {
    header('Location: ' . url('/employee-login') . '?next=' . rawurlencode(auth_safe_next('/employee/admin/guidelines')), true, 302);
    exit;
}
if (!$employee['is_admin']) {
    http_response_code(404);
    require __DIR__ . '/404.php';
    exit;
}

$actionMsg = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'update_guideline') {
    if (!auth_csrf_valid($_POST['csrf'] ?? null)) {
        $actionMsg = 'Your session expired — please try again.';
    } else {
        $code = (string) ($_POST['code'] ?? '');
        $title = trim((string) ($_POST['title'] ?? ''));
        $summary = trim((string) ($_POST['summary'] ?? ''));
        $source = trim((string) ($_POST['source'] ?? ''));
        $reviewedRaw = trim((string) ($_POST['last_reviewed_at'] ?? ''));
        $reviewedAt = $reviewedRaw !== '' ? strtotime($reviewedRaw) ?: null : null;
        if (compliance_guideline_update($code, $title, $summary, $source, $reviewedAt)) {
            $actionMsg = 'Saved.';
        } else {
            $actionMsg = 'Title and summary can\'t be empty.';
        }
    }
}

$guidelines = compliance_guidelines_all();

$crumb = [['label' => 'Home', 'href' => url('/')], ['label' => 'Employee Console', 'href' => url('/employee')], ['label' => 'Admin', 'href' => url('/employee/admin')], ['label' => 'Guidelines']];
$page = [
    'title'       => 'Admin — FEMA/RBI Guidelines | Convercession',
    'short_title' => 'Guideline Editor',
    'description' => 'Edit the FEMA/RBI forex guidance shown to customers.',
    'path'        => '/employee/admin/guidelines',
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
    <div class="container">
      <?= breadcrumbs($crumb) ?>

      <div class="account-head">
        <div>
          <h1>Admin — FEMA/RBI Guidelines</h1>
          <p class="account-sub">Shown live at <a href="<?= url('/forex-guidelines') ?>" target="_blank"><?= url('/forex-guidelines') ?></a>. Only enter a figure you have personally verified against the current RBI/FEMA source.</p>
        </div>
      </div>

      <?php if ($actionMsg !== ''): ?><p class="notice-inline"><?= e($actionMsg) ?></p><?php endif; ?>

      <p class="auth-error" role="alert" style="background:rgba(245,166,35,0.12); border-color:rgba(245,166,35,0.4)">
        <strong>Before you save:</strong> <?= e(FEMA_DISCLAIMER) ?>
      </p>

      <?php foreach ($guidelines as $g): $isPlaceholder = compliance_is_placeholder($g); ?>
      <div class="guideline-card" style="margin-bottom:16px">
        <div class="guideline-head">
          <h2><?= e($g['title']) ?></h2>
          <span class="enq-status-badge <?= $isPlaceholder ? 'status-cancelled' : 'status-completed' ?>"><?= $isPlaceholder ? 'Not yet confirmed' : 'Confirmed' ?></span>
        </div>
        <form method="post" action="<?= url('/employee/admin/guidelines') ?>" class="enquiry-grid">
          <input type="hidden" name="csrf" value="<?= e(auth_csrf_token()) ?>">
          <input type="hidden" name="action" value="update_guideline">
          <input type="hidden" name="code" value="<?= e($g['code']) ?>">
          <div class="enquiry-field full"><label for="title_<?= e($g['code']) ?>">Title *</label><input type="text" id="title_<?= e($g['code']) ?>" name="title" value="<?= e($g['title']) ?>" required></div>
          <div class="enquiry-field full"><label for="summary_<?= e($g['code']) ?>">Summary *</label><textarea id="summary_<?= e($g['code']) ?>" name="summary" rows="3" required><?= e($g['summary']) ?></textarea></div>
          <div class="enquiry-field"><label for="source_<?= e($g['code']) ?>">Source</label><input type="text" id="source_<?= e($g['code']) ?>" name="source" value="<?= e($g['source']) ?>" placeholder="e.g. RBI Master Direction, dated&hellip;"></div>
          <div class="enquiry-field"><label for="reviewed_<?= e($g['code']) ?>">Last Reviewed</label><input type="date" id="reviewed_<?= e($g['code']) ?>" name="last_reviewed_at" value="<?= $g['last_reviewed_at'] ? e(date('Y-m-d', (int) $g['last_reviewed_at'])) : '' ?>"></div>
          <div class="wizard-actions" style="grid-column:1/-1"><span></span><button type="submit" class="btn btn-primary btn-sm">Save</button></div>
        </form>
      </div>
      <?php endforeach; ?>

      <p class="auth-note account-note-wide" style="margin-top:12px">
        <a href="<?= url('/employee/admin') ?>">&larr; Back to Admin</a>
      </p>
    </div>
  </section>
</main>

<?php include __DIR__ . '/includes/footer.php'; ?>
</body>
</html>
