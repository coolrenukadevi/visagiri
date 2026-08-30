<?php
require_once __DIR__ . '/nav.php';
require_once __DIR__ . '/../lib-php/auth.php';
$NAV = nav_data()['nav'];
$REGIONS = regions_data();
$cvUser = auth_user();
// Send an anonymous visitor back to the page they were on after signing in.
$cvNext = auth_safe_next($_SERVER['REQUEST_URI'] ?? '/');
?>
<div class="utility-bar">
  <div class="container utility-bar-inner">
    <div class="utility-left">
      <a href="tel:<?= e(SITE['phone_href']) ?>"><svg viewBox="0 0 24 24" width="14" height="14"><path fill="currentColor" d="M6.6 10.8c1.4 2.8 3.8 5.1 6.6 6.6l2.2-2.2c.3-.3.7-.4 1-.2 1.1.4 2.3.6 3.6.6.6 0 1 .4 1 1V20c0 .6-.4 1-1 1-9.4 0-17-7.6-17-17 0-.6.4-1 1-1h3.5c.6 0 1 .4 1 1 0 1.2.2 2.5.6 3.6.1.4 0 .8-.2 1L6.6 10.8z"/></svg><?= e(SITE['phone']) ?></a>
      <span class="hide-sm"><svg viewBox="0 0 24 24" width="14" height="14"><path fill="currentColor" d="M20 4H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 4-8 5-8-5V6l8 5 8-5v2z"/></svg><?= e(SITE['email']) ?></span>
      <span class="hide-sm"><svg viewBox="0 0 24 24" width="14" height="14"><path fill="currentColor" d="M12 2C8.1 2 5 5.1 5 9c0 5.2 7 13 7 13s7-7.8 7-13c0-3.9-3.1-7-7-7zm0 9.5A2.5 2.5 0 1 1 12 6.5a2.5 2.5 0 0 1 0 5z"/></svg><?= e(SITE['address']['locality'] . ', ' . SITE['address']['region']) ?></span>
    </div>
    <div class="utility-right">
      <?php /* Sign-in lives in the utility bar, not the main header row: that
               row already needs every pixel for six mega tabs plus two CTAs
               (see the container note in site.css), and adding an account
               control there reintroduced the horizontal overflow. */ ?>
      <div class="utility-login-group">
        <button type="button" class="utility-pill" id="customerLoginBtn" aria-haspopup="dialog" aria-expanded="false" aria-controls="customerLoginDialog"
                aria-label="<?= $cvUser ? e(auth_display_name($cvUser) . ' — customer account') : 'Customer Login' ?>">
          <?php if ($cvUser): ?>
            <?php $cvInitial = mb_strtoupper(mb_substr(auth_display_name($cvUser), 0, 1)); ?>
            <?php if ($cvUser['avatar_url']): ?>
            <img class="js-avatar" src="<?= e($cvUser['avatar_url']) ?>" alt="" width="18" height="18"
                 referrerpolicy="no-referrer" data-initial="<?= e($cvInitial) ?>"
                 data-fallback-class="utility-account-initial">
            <?php else: ?>
            <span class="utility-account-initial" aria-hidden="true"><?= e($cvInitial) ?></span>
            <?php endif; ?>
            <span class="pill-label"><?= e(auth_display_name($cvUser)) ?></span>
          <?php else: ?>
            <svg viewBox="0 0 24 24" width="14" height="14" aria-hidden="true"><path fill="currentColor" d="M12 12a5 5 0 1 0 0-10 5 5 0 0 0 0 10zm0 2c-4 0-9 2-9 5v3h18v-3c0-3-5-5-9-5z"/></svg>
            <span class="pill-label">Customer<span class="hide-xs"> Login</span></span>
          <?php endif; ?>
        </button>
        <button type="button" class="utility-pill" id="employeeLoginBtn" aria-haspopup="dialog" aria-expanded="false" aria-controls="employeeLoginDialog" aria-label="Employee Login">
          <svg viewBox="0 0 24 24" width="14" height="14" aria-hidden="true"><path fill="currentColor" d="M12 12.75c-2.5 0-7.5 1.25-7.5 3.75V19h15v-2.5c0-2.5-5-3.75-7.5-3.75z"/><circle cx="12" cy="7" r="3.5" fill="currentColor"/></svg>
          <span class="pill-label">Employee<span class="hide-xs"> Login</span></span>
        </button>
      </div>
      <div class="utility-social">
        <?php foreach (SITE['social'] as $label => $href): ?>
        <a href="<?= e($href) ?>" target="_blank" rel="noopener" aria-label="<?= e($label) ?>"><?= e($label === 'X / Twitter' ? 'X' : strtoupper(substr($label, 0, 2))) ?></a>
        <?php endforeach; ?>
      </div>
    </div>
  </div>
</div>

<header class="site-header" id="top">
  <div class="container header-inner">
    <a href="<?= url('/') ?>" class="logo" aria-label="<?= e(SITE['name']) ?> home">
      <img class="logo-mark" src="/images/logo-mark.png" width="546" height="269" alt="">
      <span class="logo-word">conver<span>cession</span></span>
    </a>

    <ul class="main-nav" id="mainNav" aria-label="Primary">
      <?php // No "Home" tab: the logo is the home link, and dropping it buys the
            // ~60px the six mega tabs need to sit beside the CTAs.
      foreach ($NAV as $i => $entry):
        // Right-align the trailing panels so a 620px menu opening near the end
        // of the nav does not run off-screen. A closed panel still has layout
        // (visibility:hidden, not display:none), so a mis-aligned one causes a
        // real horizontal scrollbar. js/common.js re-checks this on load and
        // resize; this is the correct starting state before JS runs.
        $isLast = $i >= count($NAV) - 3; ?>
      <li class="has-mega">
        <button type="button" class="nav-trigger<?= !empty($entry['flagship']) ? ' is-flagship' : '' ?>" aria-expanded="false" aria-haspopup="true">
          <?= e($entry['label']) ?>
          <svg class="nav-caret" viewBox="0 0 24 24"><path fill="currentColor" d="M7 10l5 5 5-5z"/></svg>
        </button>
        <div class="mega<?= $isLast ? ' mega-right' : '' ?>">
          <p class="mega-summary"><?= e($entry['summary']) ?></p>
          <?php if (!empty($entry['regionMenu'])):
            $names = array_keys($REGIONS);
            $per = (int) ceil(count($names) / 3);
            $groups = array_chunk($names, max(1, $per)); ?>
          <div class="mega-cols">
            <?php foreach ($groups as $g): ?>
            <div class="mega-col"><ul>
              <?php foreach ($g as $rname): ?>
              <li><a class="mega-link" href="<?= url('/countries') ?>#region-<?= e(cv_slug($rname)) ?>"><?= e($rname) ?> <span style="color:var(--ink-500);font-weight:500;">(<?= count($REGIONS[$rname]) ?>)</span></a></li>
              <?php endforeach; ?>
            </ul></div>
            <?php endforeach; ?>
          </div>
          <div class="mega-foot"><a href="<?= url('/countries') ?>"><?= e($entry['footerLink']['label']) ?> &rarr;</a></div>
          <?php else: ?>
          <div class="mega-cols<?= count($entry['columns']) === 2 ? ' cols-2' : '' ?>">
            <?php foreach ($entry['columns'] as $col): ?>
            <div class="mega-col"><h4><?= e($col['heading']) ?></h4><ul>
              <?php foreach ($col['items'] as $item): ?>
                <?php if (!empty($item['todo'])): ?>
                <li><span class="mega-link is-todo" title="Coming soon"><?= e($item['label']) ?></span></li>
                <?php else: ?>
                <li><a class="mega-link" href="<?= e(nav_href($item)) ?>"><?= e($item['label']) ?></a></li>
                <?php endif; ?>
              <?php endforeach; ?>
            </ul></div>
            <?php endforeach; ?>
          </div>
          <?php endif; ?>
        </div>
      </li>
      <?php endforeach; ?>
    </ul>

    <div class="header-actions">
      <button type="button" class="header-search-btn" id="headerSearchBtn" aria-label="Search countries, visa types and pages" aria-haspopup="dialog" aria-expanded="false" aria-controls="siteSearch" title="Search (press /)">
        <svg viewBox="0 0 24 24" width="17" height="17"><path fill="currentColor" d="M15.5 14h-.79l-.28-.27a6.5 6.5 0 1 0-.7.7l.27.28v.79l5 5L20.49 19zm-6 0A4.5 4.5 0 1 1 14 9.5 4.5 4.5 0 0 1 9.5 14z"/></svg>
      </button>
      <a href="<?= url('/track-visa') ?>" class="btn btn-sm btn-outline-brand">Track Visa</a>
      <a href="<?= url('/visa-finder') ?>" class="btn btn-sm btn-primary">Check Visa</a>
      <button class="nav-toggle" id="navToggle" aria-label="Toggle menu" aria-expanded="false"><span></span><span></span><span></span></button>
    </div>
  </div>
</header>
<nav id="mobileNav" class="mobile-nav" aria-label="Mobile" hidden></nav>

<?php /* Smart site search. Server-rendered so it exists before JS runs; the
         index itself is built in common.js from the nav/footer links plus the
         country and visa-type data, so it can never list a page that isn't
         actually linked. Without JS the form still submits to /visa-finder. */ ?>
<div class="site-search" id="siteSearch" role="dialog" aria-modal="true" aria-label="Search Convercession" hidden>
  <div class="site-search-panel">
    <form class="site-search-form" action="<?= url('/visa-finder') ?>" method="get" role="search">
      <svg class="site-search-icon" viewBox="0 0 24 24" width="20" height="20" aria-hidden="true"><path fill="currentColor" d="M15.5 14h-.79l-.28-.27a6.5 6.5 0 1 0-.7.7l.27.28v.79l5 5L20.49 19zm-6 0A4.5 4.5 0 1 1 14 9.5 4.5 4.5 0 0 1 9.5 14z"/></svg>
      <input type="search" id="siteSearchInput" name="q" autocomplete="off" spellcheck="false"
             placeholder="Search country, visa type, embassy or requirement&hellip;"
             role="combobox" aria-expanded="false" aria-autocomplete="list" aria-controls="siteSearchResults">
      <button type="button" class="site-search-close" id="siteSearchClose" aria-label="Close search">Esc</button>
    </form>
    <ul class="site-search-results" id="siteSearchResults" role="listbox" aria-label="Search results"></ul>
    <p class="site-search-hint">Try &ldquo;Kenya&rdquo;, &ldquo;student visa&rdquo;, &ldquo;Mumbai embassy&rdquo; or &ldquo;processing times&rdquo;. Use &uarr;&darr; to move, Enter to open.</p>
  </div>
</div>

<?php /* Customer account dialog. The menu adapts to sign-in state, but every
         item routes somewhere real today: existing OAuth sign-in, the
         existing /track-visa and /contact pages, or an honest "Coming soon"
         placeholder (same convention as .mega-link.is-todo) for the pieces
         that need the CRM backend from a later phase. Nothing here fakes a
         working feature. */ ?>
<div class="auth-dialog" id="customerLoginDialog" role="dialog" aria-modal="true" aria-label="Customer account" hidden>
  <div class="auth-dialog-panel">
    <div class="auth-dialog-head">
      <h2>Customer Account</h2>
      <button type="button" class="auth-dialog-close" data-close-dialog aria-label="Close">
        <svg viewBox="0 0 24 24" width="16" height="16"><path fill="currentColor" d="M6.4 5 5 6.4 10.6 12 5 17.6 6.4 19 12 13.4 17.6 19 19 17.6 13.4 12 19 6.4 17.6 5 12 10.6z"/></svg>
      </button>
    </div>
    <ul class="auth-menu">
      <?php if ($cvUser): ?>
      <li><a class="auth-menu-item" href="<?= url('/account') ?>">My Account</a></li>
      <?php else: ?>
      <li><a class="auth-menu-item" href="<?= url('/login') ?>?next=<?= rawurlencode($cvNext) ?>" rel="nofollow">Customer Sign In</a></li>
      <?php endif; ?>
      <li><span class="auth-menu-item is-todo" title="Coming soon">New Customer Registration</span></li>
      <li><a class="auth-menu-item" href="<?= url('/track-visa') ?>">Track Enquiry</a></li>
      <li><span class="auth-menu-item is-todo" title="Coming soon">Upload Additional Documents</span></li>
      <li><span class="auth-menu-item is-todo" title="Coming soon">View Enquiry Status</span></li>
      <li><span class="auth-menu-item is-todo" title="Coming soon">Download Documents / Receipts</span></li>
      <li><a class="auth-menu-item" href="<?= url('/contact') ?>">Contact Consultant</a></li>
      <?php if ($cvUser): ?>
      <li>
        <form method="post" action="<?= url('/logout') ?>" class="auth-menu-form">
          <input type="hidden" name="csrf" value="<?= e(auth_csrf_token()) ?>">
          <button type="submit" class="auth-menu-item auth-menu-danger">Logout</button>
        </form>
      </li>
      <?php endif; ?>
    </ul>
    <p class="auth-dialog-note">New here? Signing in with Google, Facebook or X creates your account automatically — a dedicated registration form is coming in a later phase.</p>
  </div>
</div>

<?php /* Employee console has no backend yet — no table, no credentials, no
         session. Showing a form that silently failed (or worse, faked
         success) would be worse than showing nothing, so the status note is
         permanent and the fields stay disabled until Phase 7/8 wire this up. */ ?>
<div class="auth-dialog" id="employeeLoginDialog" role="dialog" aria-modal="true" aria-label="Employee login" hidden>
  <div class="auth-dialog-panel">
    <div class="auth-dialog-head">
      <h2>Employee Login</h2>
      <button type="button" class="auth-dialog-close" data-close-dialog aria-label="Close">
        <svg viewBox="0 0 24 24" width="16" height="16"><path fill="currentColor" d="M6.4 5 5 6.4 10.6 12 5 17.6 6.4 19 12 13.4 17.6 19 19 17.6 13.4 12 19 6.4 17.6 5 12 10.6z"/></svg>
      </button>
    </div>
    <div class="auth-dialog-body">
      <p class="auth-dialog-status">
        <strong>Employee accounts are not switched on yet.</strong>
        The console ships later in the CRM rollout. If you're on the Convercession team and need interim access, <a href="<?= url('/contact') ?>">contact the admin team</a>.
      </p>
      <form class="auth-form">
        <div class="field"><label for="empId">Employee ID or Email</label><input type="text" id="empId" name="empId" disabled placeholder="EMP102 or you@convercession.com"></div>
        <div class="field"><label for="empPass">Password</label><input type="password" id="empPass" name="empPass" disabled placeholder="&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;"></div>
        <div class="auth-form-row">
          <span class="auth-forgot">Forgot password?</span>
          <button type="submit" class="btn btn-primary btn-sm" disabled title="Coming soon">Sign in</button>
        </div>
      </form>
    </div>
  </div>
</div>
