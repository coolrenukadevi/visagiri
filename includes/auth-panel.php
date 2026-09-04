<?php
/**
 * Shared left-hand brand panel for login / signup / forgot-password.
 * Expects (optional) before include: $authHeadline, $authSubtext
 */
$authHeadline = $authHeadline ?? 'Your visa journey, handled by experts.';
$authSubtext = $authSubtext ?? 'Sign in to track your applications, manage documents and stay updated on your visa progress.';
?>
<aside class="auth-brand">
    <div class="auth-brand-top">
        <a href="<?= url('index.php') ?>"><?= videshia_logo('sm', 'dark', true) ?></a>
    </div>

    <div class="auth-brand-body">
        <h1><?= e($authHeadline) ?></h1>
        <p><?= e($authSubtext) ?></p>

        <div class="auth-feature-list">
            <div class="auth-feature">
                <span class="auth-feature-icon"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 12h13M13 6l6 6-6 6"/></svg></span>
                <div><strong>Named consultant</strong><span>Every application matched to the right visa pathway by a consultant who owns your case.</span></div>
            </div>
            <div class="auth-feature">
                <span class="auth-feature-icon"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="16" rx="2"/><path d="M3 9h18M8 3v4M16 3v4"/></svg></span>
                <div><strong>Document support</strong><span>Our team checks your documents and chases updates on your behalf.</span></div>
            </div>
            <div class="auth-feature">
                <span class="auth-feature-icon"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M3 12h18M12 3c2.5 2.7 3.8 6 3.8 9s-1.3 6.3-3.8 9c-2.5-2.7-3.8-6-3.8-9s1.3-6.3 3.8-9z"/></svg></span>
                <div><strong>Global coverage</strong><span>Visa guidance across 190+ destinations, kept current by our consultants.</span></div>
            </div>
        </div>
    </div>
</aside>
