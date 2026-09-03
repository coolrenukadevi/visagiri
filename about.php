<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';

$pageTitle = 'About Videshia — AI-Powered Visa Management';
require __DIR__ . '/includes/header.php';
?>

<section class="page-hero">
    <div class="container">
        <span class="eyebrow">About Videshia</span>
        <h1>Built to make borders feel smaller.</h1>
        <p>Videshia pairs AI decisioning with real immigration expertise so visa applications move at the speed of software, not paperwork.</p>
    </div>
</section>

<section class="section">
    <div class="container grid-2" style="align-items:center">
        <div>
            <span class="eyebrow">Our story</span>
            <h2>From manual case files to autonomous agents</h2>
            <p>Videshia started with a simple observation: visa processing hasn't changed in decades, even as the world got more mobile. Case officers were still cross-checking documents by hand and chasing embassies by phone.</p>
            <p>We rebuilt the workflow around AI — an intelligent router that classifies every application on arrival, and autonomous agents that handle the repetitive verification and follow-up work, escalating to human specialists only when judgement is needed.</p>
            <p>Today, agencies and independent travellers use Videshia to move applications through 190+ destinations with far less friction, and far fewer surprises.</p>
        </div>
        <div class="grid-2">
            <div class="card"><h3>2021</h3><p>Videshia founded to automate visa routing for partner agencies.</p></div>
            <div class="card"><h3>190+</h3><p>Countries with live embassy rules and processing benchmarks.</p></div>
            <div class="card"><h3>50K+</h3><p>Applications routed and tracked through the platform.</p></div>
            <div class="card"><h3>24/7</h3><p>Autonomous agents monitoring documents and deadlines.</p></div>
        </div>
    </div>
</section>

<section class="section section-alt">
    <div class="container">
        <div class="section-head center">
            <span class="eyebrow">What we stand for</span>
            <h2>The principles behind the platform</h2>
        </div>
        <div class="grid-3">
            <div class="card">
                <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 2l3 7h7l-5.5 4.5L18 21l-6-4-6 4 1.5-7.5L2 9h7z"/></svg></div>
                <h3>Accuracy first</h3>
                <p>Every routing decision is explainable and auditable — no black-box rejections.</p>
            </div>
            <div class="card">
                <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="10" rx="2"/><path d="M7 11V7a5 5 0 0110 0v4"/></svg></div>
                <h3>Privacy by design</h3>
                <p>Documents are encrypted end-to-end and only ever used to process your case.</p>
            </div>
            <div class="card">
                <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 00-3-3.87M16 3.13a4 4 0 010 7.75"/></svg></div>
                <h3>Human in the loop</h3>
                <p>Agents handle the repetitive work; licensed specialists make the judgement calls.</p>
            </div>
        </div>
    </div>
</section>

<section class="section">
    <div class="container">
        <div class="cta-band">
            <div>
                <h2>Want to see Videshia in action?</h2>
                <p>Talk to our team about routing your agency's visa pipeline through Videshia.</p>
            </div>
            <div class="cta-actions">
                <a href="<?= url('contact.php') ?>" class="btn btn-light btn-lg">Contact us</a>
            </div>
        </div>
    </div>
</section>

<?php require __DIR__ . '/includes/footer.php'; ?>
