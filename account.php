<?php
/**
 * /account — the signed-in dashboard.
 *
 * Deliberately honest: it shows what the platform actually knows about you
 * today (your profile, which providers are linked, when you joined) and gives
 * real next actions. It does NOT invent applications, documents or invoices.
 * Those sections show a true empty state until the case-management backend
 * behind them exists; a dashboard that displays fabricated application
 * statuses would be worse than no dashboard at all.
 */
declare(strict_types=1);

require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/includes/partials.php';
require_once __DIR__ . '/lib-php/auth.php';
require_once __DIR__ . '/lib-php/oauth.php';
require_once __DIR__ . '/lib-php/customer_auth.php';
require_once __DIR__ . '/lib-php/enquiries.php';

header('Cache-Control: no-store, private');
auth_session_start();

/* Two independent sign-in systems can each land you here (see
   lib-php/customer_auth.php for why they're separate) — check both rather
   than assuming OAuth. If someone somehow has both active in one browser
   session, the password-based one wins for display; there's no merged
   identity to fall back to. */
$cvUser     = auth_user();
$cvCustomer = customer_current();
if (!$cvUser && !$cvCustomer) {
    header('Location: ' . url('/customer-login') . '?next=' . rawurlencode(auth_safe_next('/account')), true, 302);
    exit;
}
$isCustomer = (bool) $cvCustomer;

// ---- Actions (before any output) ----
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'customer_logout') {
    if (auth_csrf_valid($_POST['csrf'] ?? null)) {
        customer_logout();
    }
    header('Location: ' . url('/'), true, 302);
    exit;
}
$passwordError = '';
$passwordSaved = false;
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'change_password' && $isCustomer) {
    if (!auth_csrf_valid($_POST['csrf'] ?? null)) {
        $passwordError = 'Your session expired — please try again.';
    } elseif (!customer_verify_password($cvCustomer, (string) ($_POST['current_password'] ?? ''))) {
        $passwordError = 'Current password is incorrect.';
    } elseif (strlen((string) ($_POST['new_password'] ?? '')) < 8) {
        $passwordError = 'New password must be at least 8 characters.';
    } elseif (($_POST['new_password'] ?? '') !== ($_POST['new_password_confirm'] ?? '')) {
        $passwordError = 'New passwords do not match.';
    } else {
        $pdo = customer_db();
        $pdo->prepare('UPDATE customers SET password_hash = ? WHERE id = ?')
            ->execute([password_hash((string) $_POST['new_password'], PASSWORD_DEFAULT), $cvCustomer['id']]);
        $passwordSaved = true;
    }
}

$identities = $cvUser ? auth_user_identities((int) $cvUser['id']) : [];
$linked     = array_column($identities, 'provider');
$providers  = oauth_providers();
$isNew      = isset($_GET['welcome']);

// ---- Unified display fields, whichever system this session came from ----
if ($isCustomer) {
    $displayName  = explode(' ', trim((string) $cvCustomer['full_name']))[0] ?: 'Account';
    $displayEmail = (string) $cvCustomer['email'];
    $avatarUrl    = '';
    $memberSince  = (int) $cvCustomer['created_at'];
    $customerCode = (string) $cvCustomer['customer_code'];
} else {
    $displayName  = auth_display_name($cvUser);
    $displayEmail = (string) ($cvUser['email'] ?? '');
    $avatarUrl    = (string) ($cvUser['avatar_url'] ?? '');
    $memberSince  = (int) $cvUser['created_at'];
    $customerCode = '';
}

$crumb = [['label' => 'Home', 'href' => url('/')], ['label' => 'My account']];
$page = [
    'title'       => 'My account | ' . SITE['name'],
    'short_title' => 'My account',
    'description' => 'Your Convercession account.',
    'path'        => '/account',
    'noindex'     => true,   // per-user page; must never be indexed
    'jsonld'      => [],
];

$actions = [
    ['Track an application', 'Enter a reference number to see its current stage.', '/track-visa'],
    ['Find a visa', 'Check requirements for any of 216 countries.', '/visa-finder'],
    ['Check documents', 'See what you need before you apply.', '/document-verification'],
    ['View payment methods', 'How to settle an invoice with us.', '/payments'],
    ['Talk to a consultant', 'Get a person on your specific case.', '/contact'],
    ['Visa FAQs', 'Common questions, answered.', '/visa-faqs'],
];

// Enquiries are tied to a customers row (see enquiries.php's docblock) — an
// OAuth-only session has none yet, so it sees the empty state with a nudge
// toward getting a Customer ID rather than a query against an id it doesn't have.
$enquiries = $isCustomer ? enquiries_for_customer((int) $cvCustomer['id']) : [];
$activeCount = count(array_filter($enquiries, 'enquiry_is_active'));
$completedCount = count($enquiries) - $activeCount;
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
        <?php $cvInitial = mb_strtoupper(mb_substr($displayName, 0, 1)); ?>
        <?php if ($avatarUrl): ?>
        <?php // data-initial lets common.js swap in the lettered circle if the
              // provider's image 404s later — remote avatars do rot. ?>
        <img class="account-avatar js-avatar" src="<?= e($avatarUrl) ?>" alt=""
             width="64" height="64" referrerpolicy="no-referrer"
             data-initial="<?= e($cvInitial) ?>" data-fallback-class="account-avatar account-avatar-initial">
        <?php else: ?>
        <span class="account-avatar account-avatar-initial" aria-hidden="true"><?= e($cvInitial) ?></span>
        <?php endif; ?>
        <div>
          <h1><?= $isNew ? 'Welcome, ' : 'Welcome back, ' ?><?= e($displayName) ?>.</h1>
          <p class="account-sub">
            <?php if ($customerCode): ?><span class="mono"><?= e($customerCode) ?></span> ·<?php endif; ?>
            <?php if ($displayEmail): ?><?= e($displayEmail) ?> ·<?php endif; ?>
            Member since <?= e(date('j F Y', $memberSince)) ?>
          </p>
        </div>
        <?php if ($isCustomer): ?>
        <form method="post" action="<?= url('/account') ?>" class="account-signout">
          <input type="hidden" name="csrf" value="<?= e(auth_csrf_token()) ?>">
          <input type="hidden" name="action" value="customer_logout">
          <button type="submit" class="btn btn-sm btn-outline-brand">Sign out</button>
        </form>
        <?php else: ?>
        <form method="post" action="<?= url('/logout') ?>" class="account-signout">
          <input type="hidden" name="csrf" value="<?= e(auth_csrf_token()) ?>">
          <button type="submit" class="btn btn-sm btn-outline-brand">Sign out</button>
        </form>
        <?php endif; ?>
      </div>

      <?php if ($isNew): ?>
      <p class="notice-inline">Your account is ready. Nothing is linked to it yet — start by tracking an application or checking a visa requirement below.</p>
      <?php endif; ?>

      <?php /* Active/Completed Enquiries are now real counts from the
               enquiries table (Phase 4). Pending Documents and Notifications
               stay honestly zero — there is still no document-upload or
               notification backend to count from (later phases). */ ?>
      <div class="fact-strip">
        <div class="fact-tile"><strong><?= $activeCount ?></strong><span>Active Enquiries</span></div>
        <div class="fact-tile"><strong>0</strong><span>Pending Documents</span></div>
        <div class="fact-tile"><strong><?= $completedCount ?></strong><span>Completed Services</span></div>
        <div class="fact-tile"><strong>0</strong><span>Notifications</span></div>
      </div>

      <h2 class="account-section-title" style="margin-top:32px">My Enquiries</h2>
      <?php if ($enquiries): ?>
      <div class="enquiry-card-row">
        <?php foreach ($enquiries as $enq): ?>
        <a class="enquiry-card" href="<?= url('/enquiry/' . $enq['enquiry_code']) ?>">
          <div class="enquiry-card-main">
            <span class="enquiry-card-code"><?= e($enq['enquiry_code']) ?></span>
            <div class="enquiry-card-title"><?= e($enq['service_label']) ?> — <?= e($enq['country']) ?></div>
            <div class="enquiry-card-meta">Submitted <?= e(date('j M Y', (int) $enq['created_at'])) ?><?= $enq['assigned_employee'] ? ' · ' . e($enq['assigned_employee']) : '' ?></div>
          </div>
          <span class="enq-status-badge status-<?= e(strtolower(str_replace(' ', '-', $enq['status']))) ?>"><?= $enq['status'] === 'New' ? 'Received' : e($enq['status']) ?></span>
        </a>
        <?php endforeach; ?>
      </div>
      <p class="auth-note" style="margin-top:2px">Need to submit another? Use the <strong>Enquire Now</strong> button, bottom-right of any page.</p>
      <?php else: ?>
      <div class="enquiries-panel">
        <div class="enquiries-empty">
          <svg class="enquiries-empty-icon" viewBox="0 0 48 48" width="40" height="40" aria-hidden="true">
            <path fill="none" stroke="currentColor" stroke-width="2" stroke-linejoin="round" d="M8 16h32v24a2 2 0 0 1-2 2H10a2 2 0 0 1-2-2V16Z"/>
            <path fill="none" stroke="currentColor" stroke-width="2" stroke-linejoin="round" d="M8 16 12 6h24l4 10"/>
            <path fill="none" stroke="currentColor" stroke-width="2" d="M18 24h12"/>
          </svg>
          <?php if ($isCustomer): ?>
          <h3>No enquiries yet</h3>
          <p>Use the <strong>Enquire Now</strong> button (bottom-right of any page) to start a visa or forex enquiry — it'll show up here with live status, your assigned consultant and what's still needed from you.</p>
          <div class="enquiries-empty-actions">
            <a href="<?= url('/visa-finder') ?>" class="btn btn-primary btn-sm">Find a Visa</a>
            <a href="<?= url('/track-visa') ?>" class="btn btn-outline-brand btn-sm">Track an existing application</a>
          </div>
          <?php else: ?>
          <h3>No enquiries yet</h3>
          <p>Enquiries need a Convercession Customer ID. You're signed in with Google/Facebook/X — create a customer account to submit and track enquiries here.</p>
          <div class="enquiries-empty-actions">
            <a href="<?= url('/register') ?>" class="btn btn-primary btn-sm">Create a Customer ID</a>
          </div>
          <?php endif; ?>
        </div>
      </div>
      <?php endif; ?>

      <div class="account-grid">
        <!-- Documents -->
        <div class="account-panel">
          <h2>Your documents</h2>
          <p class="account-empty">
            Document storage is not switched on for this account yet. Until it
            is, send documents through your consultant — never by unencrypted
            email attachment to an address you were not given directly by us.
          </p>
        </div>

        <!-- Sign-in methods -->
        <div class="account-panel">
          <?php if ($isCustomer): ?>
          <h2>Password &amp; security</h2>
          <?php if ($passwordSaved): ?>
          <p class="notice-inline">Password updated.</p>
          <?php endif; ?>
          <?php if ($passwordError): ?>
          <p class="auth-error" role="alert"><?= e($passwordError) ?></p>
          <?php endif; ?>
          <form method="post" action="<?= url('/account') ?>" class="account-password-form">
            <input type="hidden" name="csrf" value="<?= e(auth_csrf_token()) ?>">
            <input type="hidden" name="action" value="change_password">
            <div class="field"><label for="current_password">Current password</label><input type="password" id="current_password" name="current_password" required></div>
            <div class="field"><label for="new_password">New password</label><input type="password" id="new_password" name="new_password" minlength="8" required></div>
            <div class="field"><label for="new_password_confirm">Confirm new password</label><input type="password" id="new_password_confirm" name="new_password_confirm" minlength="8" required></div>
            <button type="submit" class="btn btn-sm btn-outline-brand">Change password</button>
          </form>
          <?php else: ?>
          <h2>Sign-in methods</h2>
          <ul class="account-identities">
            <?php foreach ($providers as $key => $prov):
              $isLinked = in_array($key, $linked, true); ?>
            <li>
              <span class="ai-name"><?= e($prov['label']) ?></span>
              <?php if ($isLinked): ?>
                <span class="ai-state ai-on">Linked</span>
              <?php elseif (oauth_configured($prov)): ?>
                <a class="ai-state ai-link" href="<?= url('/auth/' . $key) ?>?next=/account" rel="nofollow">Link</a>
              <?php else: ?>
                <span class="ai-state ai-off">Not configured</span>
              <?php endif; ?>
            </li>
            <?php endforeach; ?>
          </ul>
          <p class="account-note">
            Linking a second provider that shares the same verified email address
            signs you into this same account rather than creating a new one.
          </p>
          <?php endif; ?>
        </div>
      </div>

      <h2 class="account-section-title">What would you like to do?</h2>
      <div class="console-grid">
        <?php foreach ($actions as [$label, $desc, $href]): ?>
        <a class="console-tile" href="<?= url($href) ?>">
          <span class="console-label"><?= e($label) ?></span>
          <span class="console-desc"><?= e($desc) ?></span>
        </a>
        <?php endforeach; ?>
      </div>

      <p class="account-note account-note-wide">
        <?php if ($isCustomer): ?>
        Your password is stored as a salted hash — we can't read it, and neither can anyone who
        gets access to the database. See the <a href="<?= url('/privacy-policy') ?>">Privacy Policy</a>,
        or <a href="<?= url('/contact') ?>">contact us</a> to have this account deleted.
        <?php else: ?>
        We hold only what the sign-in provider gave us: your name, profile
        picture and (where shared) your email address. No password of yours is
        ever stored here. See the <a href="<?= url('/privacy-policy') ?>">Privacy Policy</a>,
        or <a href="<?= url('/contact') ?>">contact us</a> to have this account deleted.
        <?php endif; ?>
      </p>
    </div>
  </section>
</main>

<?php include __DIR__ . '/includes/footer.php'; ?>
</body>
</html>
