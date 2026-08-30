<?php
/**
 * /employee-login — password sign-in for staff accounts.
 *
 * No self-registration and no OAuth here, deliberately: employee accounts
 * are created out-of-band by tools/create-employee.php (see
 * lib-php/employee_auth.php's docblock for why), so there is nothing for
 * this page to offer beyond "sign in with what you were given."
 */
declare(strict_types=1);

require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/includes/partials.php';
require_once __DIR__ . '/lib-php/auth.php';
require_once __DIR__ . '/lib-php/employee_auth.php';

header('Cache-Control: no-store, private');
auth_session_start();

if (employee_current()) {
    header('Location: ' . url('/employee'), true, 302);
    exit;
}

$next = auth_safe_next($_GET['next'] ?? '/employee');
$error = '';
$oldIdentifier = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!auth_csrf_valid($_POST['csrf'] ?? null)) {
        $error = 'Your session expired — please try again.';
    } else {
        $identifier = trim((string) ($_POST['identifier'] ?? ''));
        $password = (string) ($_POST['password'] ?? '');
        $oldIdentifier = $identifier;
        $employee = $identifier !== '' ? employee_find_by_login($identifier) : null;

        if (!$employee || !employee_verify_password($employee, $password)) {
            $error = 'That Employee ID/email and password don\'t match.';
        } elseif ($employee['status'] !== 'active') {
            $error = 'This account is not active. Contact the admin team.';
        } else {
            employee_login((int) $employee['id']);
            header('Location: ' . url($next === '/account' ? '/employee' : $next), true, 302);
            exit;
        }
    }
}

$crumb = [['label' => 'Home', 'href' => url('/')], ['label' => 'Employee Sign In']];
$page = [
    'title'       => 'Employee Sign In | Convercession',
    'short_title' => 'Employee Sign In',
    'description' => 'Sign in to the Convercession employee console.',
    'path'        => '/employee-login',
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
    <div class="container auth-container">
      <div class="auth-card">
        <div class="auth-head">
          <h1>Employee Sign In</h1>
          <p>Use the Employee ID or email and the password an administrator gave you.</p>
        </div>

        <?php if ($error !== ''): ?>
        <p class="auth-error" role="alert"><?= e($error) ?></p>
        <?php endif; ?>

        <form method="post" action="<?= url('/employee-login') ?>?next=<?= rawurlencode($next) ?>">
          <input type="hidden" name="csrf" value="<?= e(auth_csrf_token()) ?>">
          <div class="field" style="margin-bottom:14px">
            <label for="identifier">Employee ID or Email</label>
            <input type="text" id="identifier" name="identifier" value="<?= e($oldIdentifier) ?>" placeholder="EMP00007 or you@convercession.com" required autofocus>
          </div>
          <div class="field" style="margin-bottom:6px">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
          </div>
          <div class="auth-form-row" style="margin:10px 0 18px">
            <span class="auth-note" style="margin:0">Forgot password? Ask an administrator to issue a new one.</span>
          </div>
          <button type="submit" class="btn btn-primary" style="width:100%">Sign in</button>
        </form>

        <p class="auth-note">Looking for your customer account instead? <a href="<?= url('/customer-login') ?>">Customer Sign In</a>.</p>
      </div>

      <div class="auth-aside">
        <h2>Employee Console</h2>
        <ul class="auth-list">
          <li><strong>One queue for every enquiry</strong> — unassigned work and what's already yours.</li>
          <li><strong>Document verification</strong> — accept, reject or request a replacement, with a reason the customer can see.</li>
          <li><strong>A shared status timeline</strong> — updates here appear on the customer's own tracking page immediately.</li>
        </ul>
        <p class="auth-note">Don't have an account yet? Ask an administrator to create one for you.</p>
      </div>
    </div>
  </section>
</main>

<?php include __DIR__ . '/includes/footer.php'; ?>
</body>
</html>
