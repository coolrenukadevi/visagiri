<?php
/**
 * /customer-login — password sign-in for the new customer accounts created at
 * /register. Kept separate from /login (Google/Facebook/X) rather than
 * merged into it, but offers a way across for people who'd rather use a
 * provider — see lib-php/customer_auth.php for why the two systems don't
 * share identities.
 */
declare(strict_types=1);

require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/includes/partials.php';
require_once __DIR__ . '/lib-php/auth.php';
require_once __DIR__ . '/lib-php/customer_auth.php';
require_once __DIR__ . '/lib-php/oauth.php';

header('Cache-Control: no-store, private');
auth_session_start();

if (customer_current()) {
    header('Location: ' . url('/account'), true, 302);
    exit;
}

$next = auth_safe_next($_GET['next'] ?? null);
$error = '';
$oldIdentifier = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!auth_csrf_valid($_POST['csrf'] ?? null)) {
        $error = 'Your session expired — please try again.';
    } else {
        $identifier = trim((string) ($_POST['identifier'] ?? ''));
        $password = (string) ($_POST['password'] ?? '');
        $oldIdentifier = $identifier;
        $customer = $identifier !== '' ? customer_find_by_login($identifier) : null;

        if (!$customer || !customer_verify_password($customer, $password)) {
            $error = 'That Customer ID/email and password don\'t match.';
        } elseif ($customer['status'] !== 'active') {
            $error = 'This account hasn\'t been verified yet. Check your email for a verification code, or ';
            $error .= 'start again from Create Account.';
        } else {
            customer_login((int) $customer['id']);
            header('Location: ' . url($next), true, 302);
            exit;
        }
    }
}

$providers = oauth_providers();
$anyConfigured = oauth_any_configured();
$marks = [
    'google' => '<svg viewBox="0 0 24 24" width="18" height="18" aria-hidden="true"><path fill="#4285F4" d="M23.5 12.3c0-.8-.1-1.6-.2-2.3H12v4.5h6.5a5.6 5.6 0 0 1-2.4 3.6v3h3.9c2.3-2.1 3.5-5.2 3.5-8.8z"/><path fill="#34A853" d="M12 24c3.2 0 5.9-1.1 7.9-2.9l-3.9-3c-1.1.7-2.4 1.2-4 1.2-3.1 0-5.7-2.1-6.6-4.9H1.4v3.1A12 12 0 0 0 12 24z"/><path fill="#FBBC05" d="M5.4 14.4a7.2 7.2 0 0 1 0-4.6V6.7H1.4a12 12 0 0 0 0 10.8l4-3.1z"/><path fill="#EA4335" d="M12 4.8c1.8 0 3.4.6 4.6 1.8l3.4-3.4A12 12 0 0 0 1.4 6.7l4 3.1C6.3 6.9 8.9 4.8 12 4.8z"/></svg>',
    'facebook' => '<svg viewBox="0 0 24 24" width="18" height="18" aria-hidden="true"><path fill="#1877F2" d="M24 12a12 12 0 1 0-13.9 11.9v-8.4H7.1V12h3V9.4c0-3 1.8-4.6 4.5-4.6 1.3 0 2.7.2 2.7.2v2.9h-1.5c-1.5 0-1.9.9-1.9 1.8V12h3.3l-.5 3.5h-2.8v8.4A12 12 0 0 0 24 12z"/></svg>',
    'x' => '<svg viewBox="0 0 24 24" width="16" height="16" aria-hidden="true"><path fill="currentColor" d="M18.2 2h3.3l-7.2 8.3L23 22h-6.7l-5.2-6.8L5.1 22H1.8l7.7-8.8L1 2h6.8l4.7 6.2L18.2 2zm-1.2 18h1.8L7.1 3.8H5.2L17 20z"/></svg>',
];

$crumb = [['label' => 'Home', 'href' => url('/')], ['label' => 'Sign in']];
$page = [
    'title'       => 'Customer Sign In | Convercession',
    'short_title' => 'Sign in',
    'description' => 'Sign in to your Convercession customer account.',
    'path'        => '/customer-login',
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
          <h1>Sign in to your account</h1>
          <p>Use your Customer ID or email address and the password you set when you registered.</p>
        </div>

        <?php if ($error !== ''): ?>
        <p class="auth-error" role="alert"><?= e($error) ?></p>
        <?php endif; ?>

        <form method="post" action="<?= url('/customer-login') ?>">
          <input type="hidden" name="csrf" value="<?= e(auth_csrf_token()) ?>">
          <div class="field" style="margin-bottom:14px">
            <label for="identifier">Customer ID or Email</label>
            <input type="text" id="identifier" name="identifier" value="<?= e($oldIdentifier) ?>" placeholder="CUST00045 or you@email.com" required autofocus>
          </div>
          <div class="field" style="margin-bottom:6px">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
          </div>
          <div class="auth-form-row" style="margin:10px 0 18px">
            <span class="auth-note" style="margin:0">Forgot password? <a href="<?= url('/contact') ?>">Contact support</a> — self-service reset is coming soon.</span>
          </div>
          <button type="submit" class="btn btn-primary" style="width:100%">Sign in</button>
        </form>

        <?php if ($anyConfigured): ?>
        <div class="auth-divider"><span>or continue with</span></div>
        <div class="auth-providers" style="margin-bottom:0">
          <?php foreach ($providers as $key => $prov): if (!oauth_configured($prov)) continue; ?>
          <a class="auth-btn auth-btn-<?= e($key) ?>" href="<?= url('/auth/' . $key) ?>?next=<?= rawurlencode($next) ?>" rel="nofollow">
            <span class="auth-mark"><?= $marks[$key] ?></span>
            <span>Continue with <?= e($prov['label']) ?></span>
          </a>
          <?php endforeach; ?>
        </div>
        <?php endif; ?>

        <p class="auth-note">New to Convercession? <a href="<?= url('/register') ?>">Create an account</a>.</p>
      </div>

      <div class="auth-aside">
        <h2>What an account gives you</h2>
        <ul class="auth-list">
          <li><strong>One place for every enquiry</strong> — visa and forex, status and history.</li>
          <li><strong>Documents that stay put</strong> — upload once, reuse across enquiries.</li>
          <li><strong>Faster follow-ups</strong> — your details are already on file.</li>
        </ul>
        <p class="auth-note">
          Signing in is optional. You can still <a href="<?= url('/visa-finder') ?>">check visa requirements</a>,
          <a href="<?= url('/track-visa') ?>">track an application by reference number</a> or
          <a href="<?= url('/contact') ?>">contact a consultant</a> without an account.
        </p>
      </div>
    </div>
  </section>
</main>

<?php include __DIR__ . '/includes/footer.php'; ?>
</body>
</html>
