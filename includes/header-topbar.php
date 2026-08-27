<?php
/**
 * Shared topbar (utility bar) content for both header variants
 * (header.php's solid header and header-home.php's homepage variant)
 * — brand tagline, live currency ticker, 24x7 WhatsApp support and the
 * Login dropdown. Included from inside each variant's own
 * .header-top-section(-2) wrapper so the outer class names (and
 * therefore the existing gradient/positioning CSS) stay exactly as
 * before; only the inner content is now written once.
 */
require_once __DIR__ . '/exchange-rates.php';
// Cache-only read — never blocks the page on an outbound call. The
// live fetch (when the cache is missing/stale) happens asynchronously
// via currency-rate.js polling exchange-rate.php after page load.
$headerFx = exchange_rate_get_cached_only('USD_INR');
$headerWhatsappMsg = rawurlencode('Hello VisaAgency.in, I need assistance with my travel/visa requirement.');
?>
<span class="header-topbar-tagline">Smart Travel. Seamless Visas.</span>

<div class="header-fx-widget" id="headerFxWidget" data-pair="USD_INR">
    <?php if ($headerFx): ?>
    <span class="fx-pair"><?php echo $headerFx['label']; ?></span>
    <span class="fx-rate" id="fxRateValue">&#8377;<?php echo number_format((float) $headerFx['rate'], 2); ?></span>
    <span class="fx-live-dot <?php echo $headerFx['stale'] ? 'is-stale' : 'is-live'; ?>" id="fxLiveDot" aria-hidden="true"></span>
    <span class="fx-live-label" id="fxLiveLabel"><?php echo $headerFx['stale'] ? 'Updated' : 'Live'; ?></span>
    <?php else: ?>
    <span class="fx-rate" id="fxRateValue" hidden></span>
    <span class="fx-live-dot" id="fxLiveDot" hidden aria-hidden="true"></span>
    <span class="fx-live-label" id="fxLiveLabel" hidden></span>
    <span class="fx-pair" id="fxPairLabel">USD &rarr; INR</span>
    <?php endif; ?>
    <button type="button" class="fx-info-btn" id="fxInfoBtn" aria-label="About this exchange rate" data-tooltip="Indicative USD to INR exchange rate. Actual card/bank/forex rates may vary.">
        <i class="fa-solid fa-circle-info" aria-hidden="true"></i>
    </button>
</div>

<div class="header-support-login">
    <a class="header-support-link" href="<?php echo htmlspecialchars($site_whatsapp_url); ?>?text=<?php echo $headerWhatsappMsg; ?>" target="_blank" rel="noopener" aria-label="24 by 7 support &mdash; chat with us on WhatsApp">
        <i class="fa-brands fa-whatsapp" aria-hidden="true"></i>
        <span>24&times;7 Support</span>
    </a>
    <span class="header-topbar-divider" aria-hidden="true"></span>
    <div class="header-login-dropdown" id="headerLoginDropdown">
        <button type="button" class="header-login-toggle" id="headerLoginToggle" aria-haspopup="true" aria-expanded="false" aria-controls="headerLoginPanel">
            <i class="fa-solid fa-right-to-bracket" aria-hidden="true"></i>
            <span>Login</span>
            <i class="fa-solid fa-chevron-down header-login-caret" aria-hidden="true"></i>
        </button>
        <div class="header-login-panel" id="headerLoginPanel" role="menu" aria-label="Login options">
            <a href="customer-login" role="menuitem"><i class="fa-solid fa-user" aria-hidden="true"></i> Customer Login</a>
            <a href="employee-login" role="menuitem"><i class="fa-solid fa-briefcase" aria-hidden="true"></i> Employee Login</a>
            <a href="b2b-partners" role="menuitem"><i class="fa-solid fa-handshake" aria-hidden="true"></i> B2B Partners</a>
        </div>
    </div>
    <a href="contact" class="header-enquire-btn" data-open-quick-enquiry>Enquire Now</a>
</div>
