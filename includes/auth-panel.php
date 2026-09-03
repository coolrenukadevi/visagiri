<?php
/**
 * Shared left-hand brand panel for login / signup / forgot-password.
 * Expects (optional) before include: $authHeadline, $authSubtext
 */
$authHeadline = $authHeadline ?? 'Visa operations, run by AI.';
$authSubtext = $authSubtext ?? 'Sign in to route applications, track approvals and manage your global visa pipeline from one dashboard.';
?>
<aside class="auth-brand">
    <div class="auth-brand-top">
        <a href="<?= url('index.php') ?>"><?= videshia_logo('sm', 'dark') ?></a>
    </div>

    <div class="auth-brand-body">
        <h1><?= e($authHeadline) ?></h1>
        <p><?= e($authSubtext) ?></p>

        <div class="auth-feature-list">
            <div class="auth-feature">
                <span class="auth-feature-icon"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 12h13M13 6l6 6-6 6"/></svg></span>
                <div><strong>Intelligent routing</strong><span>Every application matched to the right visa pathway automatically.</span></div>
            </div>
            <div class="auth-feature">
                <span class="auth-feature-icon"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="16" rx="2"/><path d="M3 9h18M8 3v4M16 3v4"/></svg></span>
                <div><strong>Autonomous agents</strong><span>AI agents check documents and chase updates around the clock.</span></div>
            </div>
            <div class="auth-feature">
                <span class="auth-feature-icon"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M3 12h18M12 3c2.5 2.7 3.8 6 3.8 9s-1.3 6.3-3.8 9c-2.5-2.7-3.8-6-3.8-9s1.3-6.3 3.8-9z"/></svg></span>
                <div><strong>Global vision</strong><span>Live coverage across 190+ destinations and embassy rule changes.</span></div>
            </div>
        </div>
    </div>

    <p class="auth-brand-quote">&ldquo;Videshia cut our visa turnaround time by more than half.&rdquo; — Partner agency, Bengaluru</p>
</aside>
