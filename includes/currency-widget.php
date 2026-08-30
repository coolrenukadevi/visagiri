<?php
/**
 * Live exchange-rate strip. Included once, immediately above the footer, on
 * every page (see includes/footer.php) — never pasted per-page.
 *
 * Deliberately compact: it sits above the footer as a utility strip, not as a
 * hero element.
 */
require_once __DIR__ . '/../lib-php/currency.php';
$cur = currency_rates();
?>
<section class="fx-strip" aria-label="Live exchange rates">
  <div class="container fx-inner">
    <span class="fx-title">
      <svg viewBox="0 0 24 24" width="15" height="15" aria-hidden="true"><path fill="currentColor" d="M12 2a10 10 0 1 0 0 20 10 10 0 0 0 0-20zm1 15.9V19h-2v-1.05c-1.5-.2-2.7-1.1-2.9-2.7h1.9c.1.7.7 1.3 1.9 1.3 1.1 0 1.6-.5 1.6-1.1 0-.6-.4-1-1.9-1.4-1.9-.4-3.2-1.1-3.2-2.7 0-1.4 1.1-2.4 2.6-2.7V7h2v1.1c1.5.3 2.4 1.3 2.5 2.6h-1.9c-.1-.7-.5-1.2-1.5-1.2-1 0-1.5.4-1.5 1 0 .6.5.9 2 1.3 1.9.4 3.1 1.1 3.1 2.8 0 1.5-1.1 2.5-2.7 2.8z"/></svg>
      Live Exchange Rates
    </span>

    <?php if ($cur['available']): ?>
      <div class="fx-rates">
        <?php foreach (CURRENCY_PAIRS as $code): ?>
          <?php if (isset($cur['rates'][$code])): ?>
          <span class="fx-rate">
            <span class="fx-pair"><?= e($code) ?> &rarr; <?= e(CURRENCY_QUOTE) ?></span>
            <strong>&#8377;<?= e(number_format((float) $cur['rates'][$code], 2)) ?></strong>
          </span>
          <?php endif; ?>
        <?php endforeach; ?>
      </div>
      <span class="fx-meta">
        Updated: <?= e(currency_timestamp($cur['fetched_at'])) ?><?= $cur['stale'] ? ' (last available)' : '' ?>
        &middot; Rates provided via XE
      </span>
    <?php else: ?>
      <div class="fx-rates"><span class="fx-unavailable">Live rates are temporarily unavailable.</span></div>
      <span class="fx-meta">Indicative rates only &middot; confirm with your bank before transacting</span>
    <?php endif; ?>
  </div>
</section>
