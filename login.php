<?php
/**
 * /login — provider picker.
 *
 * There is no password here by design: every credential lives with Google,
 * Facebook or X, so this site never stores, transmits or leaks one.
 */
declare(strict_types=1);

require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/includes/partials.php';
require_once __DIR__ . '/lib-php/auth.php';
require_once __DIR__ . '/lib-php/oauth.php';

$user = auth_user();
$next = auth_safe_next($_GET['next'] ?? null);

if ($user) {
    header('Location: ' . url($next), true, 302);
    exit;
}

$error = isset($_GET['error']) ? oauth_error_message((string) $_GET['error']) : '';
$providers = oauth_providers();
$anyConfigured = oauth_any_configured();

$crumb = [['label' => 'Home', 'href' => url('/')], ['label' => 'Sign in']];
$page = [
    'title'       => 'Sign in to Convercession',
    'short_title' => 'Sign in',
    'description' => 'Sign in to your Convercession account with Google, Facebook or X to track visa applications, manage documents and view invoices.',
    'path'        => '/login',
    // Indexable (it is a real, stable page people search for), but the sign-in
    // itself is per-user, so nothing here depends on being crawled.
    'jsonld'      => [breadcrumb_schema($crumb)],
];

// Provider button artwork. Inline SVG rather than remote logos: the pages must
// stay self-contained and must not phone home to a CDN before you sign in.
$marks = [
    'google' => '<svg viewBox="0 0 24 24" width="20" height="20" aria-hidden="true"><path fill="#4285F4" d="M23.5 12.3c0-.8-.1-1.6-.2-2.3H12v4.5h6.5a5.6 5.6 0 0 1-2.4 3.6v3h3.9c2.3-2.1 3.5-5.2 3.5-8.8z"/><path fill="#34A853" d="M12 24c3.2 0 5.9-1.1 7.9-2.9l-3.9-3c-1.1.7-2.4 1.2-4 1.2-3.1 0-5.7-2.1-6.6-4.9H1.4v3.1A12 12 0 0 0 12 24z"/><path fill="#FBBC05" d="M5.4 14.4a7.2 7.2 0 0 1 0-4.6V6.7H1.4a12 12 0 0 0 0 10.8l4-3.1z"/><path fill="#EA4335" d="M12 4.8c1.8 0 3.4.6 4.6 1.8l3.4-3.4A12 12 0 0 0 1.4 6.7l4 3.1C6.3 6.9 8.9 4.8 12 4.8z"/></svg>',
    'facebook' => '<svg viewBox="0 0 24 24" width="20" height="20" aria-hidden="true"><path fill="#1877F2" d="M24 12a12 12 0 1 0-13.9 11.9v-8.4H7.1V12h3V9.4c0-3 1.8-4.6 4.5-4.6 1.3 0 2.7.2 2.7.2v2.9h-1.5c-1.5 0-1.9.9-1.9 1.8V12h3.3l-.5 3.5h-2.8v8.4A12 12 0 0 0 24 12z"/></svg>',
    'x' => '<svg viewBox="0 0 24 24" width="18" height="18" aria-hidden="true"><path fill="currentColor" d="M18.2 2h3.3l-7.2 8.3L23 22h-6.7l-5.2-6.8L5.1 22H1.8l7.7-8.8L1 2h6.8l4.7 6.2L18.2 2zm-1.2 18h1.8L7.1 3.8H5.2L17 20z"/></svg>',
];
?><!DOCTYPE html>
<html lang="en">
<head><?php include __DIR__ . '/includes/head.php'; ?></head>
<body>
<?php include __DIR__ . '/includes/header.php'; ?>

<main>
  <section class="section auth-section">
    <div class="container">
      <?php // Outside .auth-container: it is a two-column grid, and a third
            // child would be laid out as a grid cell rather than a heading row. ?>
      <?= breadcrumbs($crumb) ?>
    </div>
    <div class="container auth-container">
      <div class="auth-card">
        <div class="auth-head">
          <h1>Sign in to Convercession</h1>
          <p>Track your applications, keep your documents in one place and pick up where you left off.</p>
        </div>

        <?php if ($error !== ''): ?>
        <p class="auth-error" role="alert"><?= e($error) ?></p>
        <?php endif; ?>

        <?php if (!$anyConfigured): ?>
        <p class="auth-error" role="status">
          <strong>Sign-in is not switched on yet.</strong>
          The three providers below are fully built and ready — each one needs its app
          credentials added to the server's <code>.env</code> file before it can be used.
          Until then, <a href="<?= url('/contact') ?>">contact us</a> and we will help directly.
        </p>
        <?php endif; ?>

        <div class="auth-providers">
          <?php foreach ($providers as $key => $prov):
            $ready = oauth_configured($prov); ?>
          <?php if ($ready): ?>
          <a class="auth-btn auth-btn-<?= e($key) ?>" href="<?= url('/auth/' . $key) ?>?next=<?= rawurlencode($next) ?>" rel="nofollow">
            <span class="auth-mark"><?= $marks[$key] ?></span>
            <span>Continue with <?= e($prov['label']) ?></span>
          </a>
          <?php else: ?>
          <span class="auth-btn auth-btn-off" aria-disabled="true" title="Awaiting app credentials">
            <span class="auth-mark"><?= $marks[$key] ?></span>
            <span>Continue with <?= e($prov['label']) ?></span>
            <span class="auth-badge">Not configured</span>
          </span>
          <?php endif; ?>
          <?php endforeach; ?>
        </div>

        <p class="auth-note">
          We never see or store your password — it stays with Google, Facebook or X.
          We receive only your name, profile picture and (where the provider shares it)
          your email address.
        </p>
        <p class="auth-note">
          By continuing you agree to our <a href="<?= url('/terms') ?>">Terms &amp; Conditions</a>
          and <a href="<?= url('/privacy-policy') ?>">Privacy Policy</a>.
        </p>
      </div>

      <div class="auth-aside">
        <h2>What an account gives you</h2>
        <ul class="auth-list">
          <li><strong>One place for every application</strong> — status, stage and history for each visa you have with us.</li>
          <li><strong>Documents that stay put</strong> — upload once, reuse across applications instead of re-sending files.</li>
          <li><strong>Invoices and payments</strong> — see what is due and what has been paid.</li>
          <li><strong>Faster enquiries</strong> — your details are already filled in.</li>
        </ul>
        <p class="auth-note">
          Signing in is optional. You can still
          <a href="<?= url('/visa-finder') ?>">check visa requirements</a>,
          <a href="<?= url('/track-visa') ?>">track an application by reference number</a>
          or <a href="<?= url('/contact') ?>">contact a consultant</a> without an account.
        </p>
        <p class="auth-note auth-note-x">
          <strong>A note on X:</strong> X does not share email addresses with
          applications on this tier, so an X-only account will have no email
          against it. Link Google or Facebook afterwards if you want email updates.
        </p>
      </div>
    </div>
  </section>
</main>

<?php include __DIR__ . '/includes/footer.php'; ?>
</body>
</html>
