<?php
/**
 * /employee/reports — real counts straight from the same tables every
 * other page reads, plus CSV/Excel exports of the full enquiry and ticket
 * records and a one-page PDF summary. Admin-gated like the rest of the
 * admin console (see employee-admin.php's docblock for the 404-not-redirect
 * reasoning) — reporting spans the whole business, not one consultant's
 * queue, so it sits alongside the other admin-only views.
 *
 * Every number on this page is a live COUNT/GROUP BY against real rows.
 * Nothing here is a projection, an estimate, or a placeholder — if a
 * bucket has zero rows, it shows 0, not omitted or invented.
 */
declare(strict_types=1);

require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/includes/partials.php';
require_once __DIR__ . '/lib-php/auth.php';
require_once __DIR__ . '/lib-php/employee_auth.php';
require_once __DIR__ . '/lib-php/customer_auth.php';
require_once __DIR__ . '/lib-php/enquiries.php';
require_once __DIR__ . '/lib-php/support.php';
require_once __DIR__ . '/lib-php/documents.php';

header('Cache-Control: no-store, private');
auth_session_start();

$employee = employee_current();
if (!$employee) {
    header('Location: ' . url('/employee-login') . '?next=' . rawurlencode(auth_safe_next('/employee/reports')), true, 302);
    exit;
}
if (!$employee['is_admin']) {
    http_response_code(404);
    require __DIR__ . '/404.php';
    exit;
}

$enqByStatus = enquiries_count_by_status();
$enqByService = enquiries_count_by_service();
$ticketByStatus = tickets_count_by_status();
$ticketByCategory = tickets_count_by_category();
$docByStatus = documents_count_by_status();
$custByStatus = customers_count_by_status();
$enqTotal = array_sum($enqByStatus);
$ticketTotal = array_sum($ticketByStatus);

/** A simple two-column count table — reused for every breakdown below. */
$countTable = static function (array $counts, string $emptyLabel): void {
    if (!$counts) { echo '<p class="account-empty">' . e($emptyLabel) . '</p>'; return; } ?>
    <table class="report-table">
      <?php foreach ($counts as $label => $n): ?>
      <tr><td><?= e((string) $label) ?></td><td class="report-table-num"><?= (int) $n ?></td></tr>
      <?php endforeach; ?>
    </table>
<?php };

$crumb = [['label' => 'Home', 'href' => url('/')], ['label' => 'Employee Console', 'href' => url('/employee')], ['label' => 'Reports']];
$page = [
    'title'       => 'Admin — Reports | Convercession',
    'short_title' => 'Reports',
    'description' => 'Convercession reports and exports.',
    'path'        => '/employee/reports',
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
          <h1>Reports</h1>
          <p class="account-sub">Live counts as of right now. Every export below pulls the same data these tables show.</p>
        </div>
      </div>

      <div class="fact-strip">
        <div class="fact-tile"><strong><?= $enqTotal ?></strong><span>Total Enquiries</span></div>
        <div class="fact-tile"><strong><?= $ticketTotal ?></strong><span>Total Tickets</span></div>
        <div class="fact-tile"><strong><?= array_sum($docByStatus) ?></strong><span>Total Documents</span></div>
        <div class="fact-tile"><strong><?= array_sum($custByStatus) ?></strong><span>Total Customers</span></div>
      </div>

      <div class="report-grid">
        <div class="account-panel">
          <h2>Enquiries by Status</h2>
          <?php $countTable($enqByStatus, 'No enquiries yet.'); ?>
        </div>
        <div class="account-panel">
          <h2>Enquiries by Service</h2>
          <?php $countTable($enqByService, 'No enquiries yet.'); ?>
        </div>
        <div class="account-panel">
          <h2>Tickets by Status</h2>
          <?php $countTable($ticketByStatus, 'No tickets yet.'); ?>
        </div>
        <div class="account-panel">
          <h2>Tickets by Category</h2>
          <?php $countTable($ticketByCategory, 'No tickets yet.'); ?>
        </div>
        <div class="account-panel">
          <h2>Documents by Status</h2>
          <?php $countTable($docByStatus, 'No documents uploaded yet.'); ?>
        </div>
        <div class="account-panel">
          <h2>Customers by Status</h2>
          <?php $countTable($custByStatus, 'No customers yet.'); ?>
        </div>
      </div>

      <h2 class="account-section-title" style="margin-top:32px">Exports</h2>
      <div class="report-export-row">
        <div class="account-panel">
          <h2>Enquiries (<?= $enqTotal ?> rows)</h2>
          <p class="account-empty">Every enquiry, with customer, service, country, status and assignment.</p>
          <div class="report-export-actions">
            <a class="btn btn-outline-brand btn-sm" href="<?= url('/employee/reports/export') ?>?type=enquiries&amp;format=csv">Export CSV</a>
            <a class="btn btn-outline-brand btn-sm" href="<?= url('/employee/reports/export') ?>?type=enquiries&amp;format=xlsx">Export Excel</a>
          </div>
        </div>
        <div class="account-panel">
          <h2>Support Tickets (<?= $ticketTotal ?> rows)</h2>
          <p class="account-empty">Every ticket, with customer, subject, category, status and assignment.</p>
          <div class="report-export-actions">
            <a class="btn btn-outline-brand btn-sm" href="<?= url('/employee/reports/export') ?>?type=tickets&amp;format=csv">Export CSV</a>
            <a class="btn btn-outline-brand btn-sm" href="<?= url('/employee/reports/export') ?>?type=tickets&amp;format=xlsx">Export Excel</a>
          </div>
        </div>
        <div class="account-panel">
          <h2>Summary Report (PDF)</h2>
          <p class="account-empty">One page: the totals and breakdowns above, for printing or sharing.</p>
          <div class="report-export-actions">
            <a class="btn btn-primary btn-sm" href="<?= url('/employee/reports/export') ?>?format=pdf">Download PDF</a>
          </div>
        </div>
      </div>

      <p class="auth-note account-note-wide" style="margin-top:28px">
        <a href="<?= url('/employee') ?>">&larr; Back to Employee Console</a>
      </p>
    </div>
  </section>
</main>

<?php include __DIR__ . '/includes/footer.php'; ?>
</body>
</html>
