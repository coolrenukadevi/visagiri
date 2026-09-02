<?php
/**
 * /forex-guidelines — FEMA & RBI guidance for customers.
 *
 * Every figure starts as "To be configured by administrator" (see
 * lib-php/compliance.php) — this file only renders whatever is in that
 * table, it never states a number itself. Phase 8 builds the admin editor
 * that lets someone replace a placeholder with a real, source-checked
 * figure; until then this page says plainly that nothing has been
 * confirmed, which is the honest state, not a bug to hide.
 */
declare(strict_types=1);

require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/includes/partials.php';
require_once __DIR__ . '/lib-php/compliance.php';
require_once __DIR__ . '/lib-php/auth.php';

// Must run before any output — see index.php for why.
auth_session_start();

$guidelines = compliance_guidelines_all();

$crumb = [['label' => 'Home', 'href' => url('/')], ['label' => 'FEMA & RBI Forex Guidelines']];
$page = [
    'title'       => 'FEMA & RBI Forex Guidelines | Convercession',
    'short_title' => 'Forex Guidelines',
    'description' => 'What to know about foreign exchange rules before you travel — reviewed and kept current by Convercession.',
    'path'        => '/forex-guidelines',
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
        <div class="auth-head">
          <h1>FEMA &amp; RBI Forex Guidelines</h1>
          <p>General guidance on foreign exchange rules for outbound travel. Read the disclaimer below before relying on anything here.</p>
        </div>

        <p class="auth-error" role="alert" style="background:rgba(245,166,35,0.12); border-color:rgba(245,166,35,0.4)">
          <strong>Disclaimer:</strong> <?= e(FEMA_DISCLAIMER) ?>
        </p>

        <div class="guideline-list">
          <?php foreach ($guidelines as $g): $isPlaceholder = compliance_is_placeholder($g); ?>
          <div class="guideline-card">
            <div class="guideline-head">
              <h2><?= e($g['title']) ?></h2>
              <span class="enq-status-badge <?= $isPlaceholder ? 'status-cancelled' : 'status-completed' ?>"><?= $isPlaceholder ? 'Not yet confirmed' : 'Confirmed' ?></span>
            </div>
            <p><?= e($g['summary']) ?></p>
            <div class="guideline-meta">
              <span>Source: <?= e($g['source'] ?: 'Not yet sourced') ?></span>
              <?php if ($g['last_reviewed_at']): ?><span>Last reviewed: <?= e(date('j M Y', (int) $g['last_reviewed_at'])) ?></span><?php endif; ?>
            </div>
          </div>
          <?php endforeach; ?>
        </div>

        <p class="auth-note account-note-wide" style="margin-top:28px">
          Have a specific transaction in mind? <a href="<?= url('/contact') ?>">Talk to a consultant</a> — figures here are general guidance, not a substitute for confirming your exact case.
        </p>
      </div>
    </div>
  </section>
</main>

<?php include __DIR__ . '/includes/footer.php'; ?>
</body>
</html>
