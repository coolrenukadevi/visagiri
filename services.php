<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';

$pageTitle = 'Services — Videshia';
require __DIR__ . '/includes/header.php';

$services = [
    ['id' => 'tourist', 'name' => 'Tourist visa', 'desc' => 'Short-stay leisure travel, routed against the fastest-approving pathway for your nationality.', 'points' => ['Auto-filled application forms', 'Itinerary & funds document checks', 'Average 6-day routing time'], 'icon' => '<path d="M12 2v20M2 12h20"/><circle cx="12" cy="12" r="9"/>'],
    ['id' => 'business', 'name' => 'Business visa', 'desc' => 'Conferences, client visits and short-term assignments handled with corporate document workflows.', 'points' => ['Invitation letter verification', 'Multi-entry eligibility checks', 'Priority queue for repeat travellers'], 'icon' => '<rect x="3" y="7" width="18" height="13" rx="2"/><path d="M8 7V5a2 2 0 012-2h4a2 2 0 012 2v2"/>'],
    ['id' => 'work', 'name' => 'Work visa', 'desc' => 'Employment-sponsored visas with employer and role-eligibility cross-checks built in.', 'points' => ['Sponsor & contract validation', 'Skill-category matching', 'Renewal reminders before expiry'], 'icon' => '<path d="M20 7h-9M14 17H5M5 7h1M18 17h1"/><circle cx="17" cy="7" r="2"/><circle cx="7" cy="17" r="2"/>'],
    ['id' => 'student', 'name' => 'Student visa', 'desc' => 'University offer letters, funding proof and study-permit rules, matched automatically.', 'points' => ['Institution accreditation checks', 'Financial proof calculator', 'Dependent visa add-ons'], 'icon' => '<path d="M22 10L12 5 2 10l10 5 10-5z"/><path d="M6 12v5c0 1.5 3 3 6 3s6-1.5 6-3v-5"/>'],
    ['id' => 'family', 'name' => 'Family visa', 'desc' => 'Reunification and dependent visas with relationship-evidence guidance built into the flow.', 'points' => ['Relationship document checklist', 'Sponsor income verification', 'Joint household case tracking'], 'icon' => '<path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 00-3-3.87M16 3.13a4 4 0 010 7.75"/>'],
    ['id' => 'transit', 'name' => 'Transit visa', 'desc' => 'Layover and connection visas resolved fast, with airport-specific transit rules applied.', 'points' => ['Layover-duration eligibility', 'Airport-specific rule engine', 'Same-day routing where possible'], 'icon' => '<path d="M3 12h18M3 6h18M3 18h18"/>'],
];
?>

<section class="page-hero">
    <div class="container">
        <span class="eyebrow">Services</span>
        <h1>Every visa category, handled the same intelligent way.</h1>
        <p>Pick a category below to see how Videshia routes and manages that specific visa type.</p>
    </div>
</section>

<section class="section">
    <div class="container">
        <div class="grid-3">
            <?php foreach ($services as $svc): ?>
            <div class="card" id="<?= e($svc['id']) ?>">
                <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><?= $svc['icon'] ?></svg></div>
                <h3><?= e($svc['name']) ?></h3>
                <p><?= e($svc['desc']) ?></p>
                <ul style="margin-top:14px;display:flex;flex-direction:column;gap:8px">
                    <?php foreach ($svc['points'] as $point): ?>
                    <li style="display:flex;align-items:flex-start;gap:8px;font-size:13.5px;color:var(--muted)">
                        <svg style="flex-shrink:0;margin-top:3px" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#17c3c9" stroke-width="3"><path d="M4 12l5 5L20 6"/></svg>
                        <?= e($point) ?>
                    </li>
                    <?php endforeach; ?>
                </ul>
            </div>
            <?php endforeach; ?>
        </div>
    </div>
</section>

<section class="section section-dark">
    <div class="container">
        <div class="section-head center">
            <span class="eyebrow" style="background:rgba(23,195,201,.15);color:#8fece9">For agencies</span>
            <h2>Run your whole visa desk through one console</h2>
            <p>Bulk case intake, team assignment, commission tracking and client-facing status pages — built for agencies managing hundreds of applications a month.</p>
        </div>
        <div class="grid-3">
            <div class="card card-dark">
                <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/></svg></div>
                <h3>Team workspaces</h3>
                <p>Assign cases, set SLAs and see every agent's workload in one queue.</p>
            </div>
            <div class="card card-dark">
                <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="16" rx="2"/><path d="M3 9h18"/></svg></div>
                <h3>Bulk intake</h3>
                <p>Import applications in bulk and let the router triage them instantly.</p>
            </div>
            <div class="card card-dark">
                <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 1v22M17 5H9.5a3.5 3.5 0 000 7h5a3.5 3.5 0 010 7H6"/></svg></div>
                <h3>Commission tracking</h3>
                <p>Automatic payout calculations per case, per partner, per month.</p>
            </div>
        </div>
    </div>
</section>

<section class="section">
    <div class="container">
        <div class="cta-band">
            <div>
                <h2>Not sure which visa fits?</h2>
                <p>Tell us your destination and purpose — we'll route you to the right pathway.</p>
            </div>
            <div class="cta-actions">
                <a href="<?= url('signup.php') ?>" class="btn btn-light btn-lg">Start free trial</a>
            </div>
        </div>
    </div>
</section>

<?php require __DIR__ . '/includes/footer.php'; ?>
