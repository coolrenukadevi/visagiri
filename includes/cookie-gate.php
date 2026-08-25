<?php require_once __DIR__ . '/site-contact.php'; ?>
<script>
(function () {
    try {
        if (localStorage.getItem('va_cookie_consent') === 'declined') {
            document.documentElement.classList.add('va-cookie-blocked');
        }
    } catch (e) {}
})();
</script>
<div class="cookie-gate" id="cookieGate" role="dialog" aria-modal="true" aria-labelledby="cookieGateTitle">
    <div class="cookie-gate-box">
        <div class="cookie-gate-state" id="cookieGateAsk">
            <div class="cookie-gate-icon"><i class="fa-solid fa-cookie-bite"></i></div>
            <h2 id="cookieGateTitle">This Site Uses Cookies</h2>
            <p>VisaAgency.in uses essential and functional cookies to run this website &mdash; including keeping you signed in, remembering your preferences and supporting core features such as document checklists and the visa requirements checker. Accepting cookies is required to use this website. See our <a href="cookie-policy">Cookie Policy</a> for details.</p>
            <div class="cookie-gate-actions">
                <button type="button" class="cookie-gate-accept" id="cookieGateAccept">Accept Cookies &amp; Continue</button>
                <button type="button" class="cookie-gate-decline" id="cookieGateDecline">Decline</button>
            </div>
        </div>
        <div class="cookie-gate-state" id="cookieGateDenied" hidden>
            <div class="cookie-gate-icon cookie-gate-icon-denied"><i class="fa-solid fa-ban"></i></div>
            <h2>Access Not Authorised</h2>
            <p>You've declined cookies, which are required to use VisaAgency.in. We're unable to give you access to the website without your consent.</p>
            <div class="cookie-gate-actions">
                <button type="button" class="cookie-gate-accept" id="cookieGateReconsider">Accept Cookies &amp; Continue</button>
            </div>
            <p class="cookie-gate-fine">You can also reach us directly at <a href="tel:<?php echo $site_phone_e164; ?>"><?php echo $site_phone_display; ?></a> or <a href="mailto:<?php echo $site_email; ?>"><?php echo $site_email; ?></a>.</p>
        </div>
    </div>
</div>
<script>
(function () {
    var gate = document.getElementById('cookieGate');
    var askState = document.getElementById('cookieGateAsk');
    var deniedState = document.getElementById('cookieGateDenied');
    var acceptBtn = document.getElementById('cookieGateAccept');
    var declineBtn = document.getElementById('cookieGateDecline');
    var reconsiderBtn = document.getElementById('cookieGateReconsider');
    if (!gate) { return; }

    function setConsent(value) {
        try { localStorage.setItem('va_cookie_consent', value); } catch (e) {}
    }
    function getConsent() {
        try { return localStorage.getItem('va_cookie_consent'); } catch (e) { return null; }
    }
    function showAsk() {
        askState.hidden = false;
        deniedState.hidden = true;
        gate.classList.add('is-open');
        document.documentElement.classList.remove('va-cookie-blocked');
        document.documentElement.classList.add('va-cookie-gate-open');
    }
    function showDenied() {
        askState.hidden = true;
        deniedState.hidden = false;
        gate.classList.add('is-open');
        document.documentElement.classList.add('va-cookie-blocked');
        document.documentElement.classList.add('va-cookie-gate-open');
    }
    function grantAccess() {
        gate.classList.remove('is-open');
        document.documentElement.classList.remove('va-cookie-blocked');
        document.documentElement.classList.remove('va-cookie-gate-open');
    }

    var consent = getConsent();
    if (consent === 'accepted') {
        grantAccess();
    } else if (consent === 'declined') {
        showDenied();
    } else {
        showAsk();
    }

    acceptBtn.addEventListener('click', function () { setConsent('accepted'); grantAccess(); });
    reconsiderBtn.addEventListener('click', function () { setConsent('accepted'); grantAccess(); });
    declineBtn.addEventListener('click', function () { setConsent('declined'); showDenied(); });

    // Exposed so a "Cookie Settings" link (e.g. in the footer) can let
    // visitors reopen this dialog and change a previously given choice.
    window.vaOpenCookieSettings = showAsk;
})();
</script>
