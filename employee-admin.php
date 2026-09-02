<?php
/**
 * /employee/admin — employee directory: create accounts, activate or
 * deactivate them, grant or remove admin access.
 *
 * Admin-gated with a 404, not a redirect with an explanation — same
 * "don't confirm the resource exists to someone who can't have it" posture
 * document.php and enquiry.php already use for ownership checks. The risk
 * model here is an internal one (a curious non-admin colleague poking at a
 * URL), but the pattern costs nothing to reuse and keeps the codebase
 * consistent.
 *
 * "Settings" in the Phase 8 plan turned out to mean this and the guideline
 * editor (employee-admin-guidelines.php) — there is no separate site-wide
 * settings table. Things like the company phone number and address are
 * still plain constants in includes/config.php; nothing in this codebase
 * reads them from a database, so building an editor for them now would be
 * a form with no real consumer, which is exactly what this project has
 * avoided everywhere else.
 */
declare(strict_types=1);

require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/includes/partials.php';
require_once __DIR__ . '/lib-php/auth.php';
require_once __DIR__ . '/lib-php/employee_auth.php';

header('Cache-Control: no-store, private');
auth_session_start();

$employee = employee_current();
if (!$employee) {
    header('Location: ' . url('/employee-login') . '?next=' . rawurlencode(auth_safe_next('/employee/admin')), true, 302);
    exit;
}
if (!$employee['is_admin']) {
    http_response_code(404);
    require __DIR__ . '/404.php';
    exit;
}

$actionMsg = '';
$newPassword = null;
$newEmployeeCode = null;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $csrfOk = auth_csrf_valid($_POST['csrf'] ?? null);
    $action = (string) ($_POST['action'] ?? '');

    if (!$csrfOk) {
        $actionMsg = 'Your session expired — please try again.';
    } elseif ($action === 'create_employee') {
        $fullName = trim((string) ($_POST['full_name'] ?? ''));
        $email = trim((string) ($_POST['email'] ?? ''));
        $role = trim((string) ($_POST['role'] ?? 'Consultant')) ?: 'Consultant';
        $grantAdmin = ($_POST['is_admin'] ?? '') === '1';
        if ($fullName === '' || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $actionMsg = 'Enter a name and a valid email address.';
        } else {
            [$id, $password, $error] = employee_create($fullName, $email, $role, $grantAdmin);
            if ($id === null) {
                $actionMsg = $error;
            } else {
                $created = employee_find($id);
                $newPassword = $password;
                $newEmployeeCode = $created['employee_code'];
                $actionMsg = 'Employee created.';
            }
        }
    } elseif ($action === 'set_status') {
        $id = (int) ($_POST['employee_id'] ?? 0);
        $status = (string) ($_POST['status'] ?? '');
        if ($id === (int) $employee['id'] && $status === 'inactive') {
            $actionMsg = "You can't deactivate your own account.";
        } else {
            employee_set_status($id, $status);
            $actionMsg = 'Status updated.';
        }
    } elseif ($action === 'set_admin') {
        $id = (int) ($_POST['employee_id'] ?? 0);
        $grant = ($_POST['grant'] ?? '') === '1';
        if (!$grant && $id === (int) $employee['id'] && employee_count_admins() <= 1) {
            $actionMsg = "Can't remove admin access — you're the last active admin.";
        } else {
            employee_set_admin($id, $grant);
            $actionMsg = $grant ? 'Admin access granted.' : 'Admin access removed.';
        }
    }
}

$employees = employees_all();

$crumb = [['label' => 'Home', 'href' => url('/')], ['label' => 'Employee Console', 'href' => url('/employee')], ['label' => 'Admin']];
$page = [
    'title'       => 'Admin — Employees | Convercession',
    'short_title' => 'Admin',
    'description' => 'Convercession employee administration.',
    'path'        => '/employee/admin',
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
          <h1>Admin — Employees</h1>
          <p class="account-sub">Create staff accounts, and control who's active and who has admin access.</p>
        </div>
        <div style="display:flex; gap:8px; flex-wrap:wrap">
          <a href="<?= url('/employee/reports') ?>" class="btn btn-sm btn-outline-brand">Reports &rarr;</a>
          <a href="<?= url('/employee/admin/guidelines') ?>" class="btn btn-sm btn-outline-brand">FEMA/RBI Guideline Editor &rarr;</a>
        </div>
      </div>

      <?php if ($actionMsg !== ''): ?><p class="notice-inline"><?= e($actionMsg) ?></p><?php endif; ?>

      <?php if ($newPassword !== null): ?>
      <p class="auth-error" role="alert" style="background:rgba(26,138,95,0.1); border-color:rgba(26,138,95,0.4); color:#1a8a5f">
        <strong><?= e($newEmployeeCode) ?> created.</strong> One-time password: <span class="mono" style="font-weight:800"><?= e($newPassword) ?></span>
        — share it securely now; it will not be shown again.
      </p>
      <?php endif; ?>

      <h2 class="account-section-title" style="margin-top:24px">Employees (<?= count($employees) ?>)</h2>
      <div class="enquiry-card-row">
        <?php foreach ($employees as $emp): ?>
        <div class="enquiry-card">
          <div class="enquiry-card-main">
            <span class="enquiry-card-code"><?= e($emp['employee_code']) ?></span>
            <div class="enquiry-card-title"><?= e($emp['full_name']) ?><?= $emp['is_admin'] ? ' &middot; Admin' : '' ?></div>
            <div class="enquiry-card-meta"><?= e($emp['email']) ?> &middot; <?= e($emp['role']) ?></div>
          </div>
          <span class="enq-status-badge <?= $emp['status'] === 'active' ? 'status-completed' : 'status-cancelled' ?>"><?= $emp['status'] === 'active' ? 'Active' : 'Inactive' ?></span>
          <form method="post" action="<?= url('/employee/admin') ?>">
            <input type="hidden" name="csrf" value="<?= e(auth_csrf_token()) ?>">
            <input type="hidden" name="action" value="set_status">
            <input type="hidden" name="employee_id" value="<?= (int) $emp['id'] ?>">
            <input type="hidden" name="status" value="<?= $emp['status'] === 'active' ? 'inactive' : 'active' ?>">
            <button type="submit" class="btn btn-outline-brand btn-sm"><?= $emp['status'] === 'active' ? 'Deactivate' : 'Activate' ?></button>
          </form>
          <form method="post" action="<?= url('/employee/admin') ?>">
            <input type="hidden" name="csrf" value="<?= e(auth_csrf_token()) ?>">
            <input type="hidden" name="action" value="set_admin">
            <input type="hidden" name="employee_id" value="<?= (int) $emp['id'] ?>">
            <input type="hidden" name="grant" value="<?= $emp['is_admin'] ? '0' : '1' ?>">
            <button type="submit" class="btn btn-outline-brand btn-sm"><?= $emp['is_admin'] ? 'Remove admin' : 'Make admin' ?></button>
          </form>
        </div>
        <?php endforeach; ?>
      </div>

      <h2 class="account-section-title" style="margin-top:32px">Create Employee</h2>
      <form method="post" action="<?= url('/employee/admin') ?>" class="enquiry-grid">
        <input type="hidden" name="csrf" value="<?= e(auth_csrf_token()) ?>">
        <input type="hidden" name="action" value="create_employee">
        <div class="enquiry-field"><label for="full_name">Full Name *</label><input type="text" id="full_name" name="full_name" required></div>
        <div class="enquiry-field"><label for="email">Email *</label><input type="email" id="email" name="email" required></div>
        <div class="enquiry-field"><label for="role">Role / Title</label><input type="text" id="role" name="role" placeholder="e.g. Visa Consultant" value="Consultant"></div>
        <div class="enquiry-field">
          <label for="is_admin">Admin access</label>
          <select id="is_admin" name="is_admin">
            <option value="0">No</option>
            <option value="1">Yes — can manage employees and guidelines</option>
          </select>
        </div>
        <div class="wizard-actions" style="grid-column:1/-1"><span></span><button type="submit" class="btn btn-primary btn-sm">Create employee</button></div>
      </form>
      <p class="auth-note">A one-time password is generated automatically and shown once, above — the same way <span class="mono">tools/create-employee.php</span> works from the command line.</p>

      <p class="auth-note account-note-wide" style="margin-top:28px">
        <a href="<?= url('/employee') ?>">&larr; Back to Employee Console</a>
      </p>
    </div>
  </section>
</main>

<?php include __DIR__ . '/includes/footer.php'; ?>
</body>
</html>
