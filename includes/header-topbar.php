<?php
/**
 * Shared topbar (utility bar) content for both header variants
 * (header.php's solid header and header-home.php's homepage variant)
 * — brand tagline, 24x7 WhatsApp support and the Login dropdown.
 * Included from inside each variant's own .header-top-section(-2)
 * wrapper so the outer class names (and therefore the existing
 * gradient/positioning CSS) stay exactly as before; only the inner
 * content is now written once.
 */
$headerWhatsappMsg = rawurlencode('Hello VisaAgency.in, I need assistance with my travel/visa requirement.');
?>
<div class="header-topbar-left">
    <span class="header-topbar-tagline">Smart Travel. Seamless Visas.</span>
    <span class="header-topbar-divider header-topbar-divider-trust" aria-hidden="true"></span>
    <div class="header-trust-rotator" id="headerTrustRotator" aria-live="polite">
        <span class="header-trust-item is-active"><i class="fa-solid fa-earth-americas" aria-hidden="true"></i> 200+ Countries</span>
        <span class="header-trust-item"><i class="fa-solid fa-shield-halved" aria-hidden="true"></i> Trusted Visa Assistance</span>
        <span class="header-trust-item"><i class="fa-solid fa-bolt" aria-hidden="true"></i> Fast Processing Support</span>
    </div>
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
            <span>Login / Sign Up</span>
            <i class="fa-solid fa-chevron-down header-login-caret" aria-hidden="true"></i>
        </button>
        <div class="header-login-panel" id="headerLoginPanel" role="menu" aria-label="Login options">
            <a href="customer-login" role="menuitem"><i class="fa-solid fa-user" aria-hidden="true"></i> Customer Login</a>
            <?php if (!empty($forexCustomerLoggedIn)): ?>
            <a href="forex-my-requests" role="menuitem"><i class="fa-solid fa-money-bill-wave" aria-hidden="true"></i> My Forex Requests</a>
            <?php else: ?>
            <a href="forex-login" role="menuitem"><i class="fa-solid fa-money-bill-wave" aria-hidden="true"></i> Forex Login</a>
            <?php endif; ?>
            <a href="employee-login" role="menuitem"><i class="fa-solid fa-briefcase" aria-hidden="true"></i> Employee Login</a>
            <?php if (!empty($b2bPartnerLoggedIn)): ?>
            <a href="b2b-dashboard" role="menuitem"><i class="fa-solid fa-handshake" aria-hidden="true"></i> Partner Dashboard</a>
            <?php else: ?>
            <a href="b2b-partners" role="menuitem"><i class="fa-solid fa-handshake" aria-hidden="true"></i> B2B Partners</a>
            <?php endif; ?>
        </div>
    </div>
    <span class="header-topbar-divider header-topbar-divider-social" aria-hidden="true"></span>
    <div class="header-topbar-social" role="list" aria-label="Social media">
        <a href="<?php echo htmlspecialchars($site_social['facebook']); ?>" target="_blank" rel="noopener" aria-label="Visit our Facebook page"><i class="fa-brands fa-facebook-f" aria-hidden="true"></i></a>
        <a href="<?php echo htmlspecialchars($site_social['twitter']); ?>" target="_blank" rel="noopener" aria-label="Visit our X (Twitter) page"><i class="fa-brands fa-twitter" aria-hidden="true"></i></a>
        <a href="<?php echo htmlspecialchars($site_social['instagram']); ?>" target="_blank" rel="noopener" aria-label="Visit our Instagram page"><i class="fa-brands fa-instagram" aria-hidden="true"></i></a>
        <a href="<?php echo htmlspecialchars($site_social['linkedin']); ?>" target="_blank" rel="noopener" aria-label="Visit our LinkedIn page"><i class="fa-brands fa-linkedin-in" aria-hidden="true"></i></a>
    </div>
</div>
<script>
(function () {
    var items = document.querySelectorAll('#headerTrustRotator .header-trust-item');
    if (items.length < 2) { return; }
    var i = 0;
    setInterval(function () {
        items[i].classList.remove('is-active');
        i = (i + 1) % items.length;
        items[i].classList.add('is-active');
    }, 3200);
})();
</script>
