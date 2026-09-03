<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';

$pageTitle = 'Videshia — AI-Powered Visa Management';
$pageDescription = 'Videshia routes visa applications with AI, hands off the paperwork to autonomous agents, and gives agencies and travellers one global view of every case.';
require __DIR__ . '/includes/header.php';
?>

<section class="hero">
    <div class="container hero-grid">
        <div>
            <span class="eyebrow" style="background:rgba(23,195,201,.15);color:#8fece9">AI-Powered Visa Management</span>
            <h1>Visa applications, <span class="accent">routed and resolved</span> by intelligent agents.</h1>
            <p class="lead">Videshia reads every application, matches it to the right pathway, and puts autonomous agents to work on documents, follow-ups and status checks — so your team focuses on people, not paperwork.</p>
            <div class="hero-actions">
                <a href="<?= url('signup.php') ?>" class="btn btn-primary btn-lg">Start free trial</a>
                <a href="<?= url('services.php') ?>" class="btn btn-outline-light btn-lg">Explore services</a>
            </div>
            <div class="hero-trust">
                <span>Trusted across</span>
                <strong style="color:#fff;font-family:var(--font-head)">190+ countries</strong>
                <span>&middot;</span>
                <strong style="color:#fff;font-family:var(--font-head)">50,000+ visas processed</strong>
            </div>
        </div>

        <div class="hero-visual">
            <div class="hero-card">
                <div class="hero-card-row">
                    <div>
                        <p style="margin:0;font-size:13px;color:var(--muted)">Application VDS-24817</p>
                        <p style="margin:2px 0 0;font-weight:600;color:var(--navy-900)">Work Visa &middot; Germany</p>
                    </div>
                    <span class="status-pill">AI Verified</span>
                </div>
                <div class="mini-progress"><span style="width:82%"></span></div>
            </div>
            <div class="hero-card">
                <div class="hero-card-row">
                    <div>
                        <p style="margin:0;font-size:13px;color:var(--muted)">Application VDS-24822</p>
                        <p style="margin:2px 0 0;font-weight:600;color:var(--navy-900)">Student Visa &middot; Canada</p>
                    </div>
                    <span class="status-pill" style="background:#fff3d6;color:#946200">Agent Reviewing</span>
                </div>
                <div class="mini-progress"><span style="width:54%"></span></div>
            </div>
            <div class="hero-card">
                <div class="hero-card-row">
                    <div>
                        <p style="margin:0;font-size:13px;color:var(--muted)">Application VDS-24799</p>
                        <p style="margin:2px 0 0;font-weight:600;color:var(--navy-900)">Business Visa &middot; UAE</p>
                    </div>
                    <span class="status-pill">Approved</span>
                </div>
                <div class="mini-progress"><span style="width:100%"></span></div>
            </div>
            <div class="hero-float">
                Routing accuracy
                <strong>98.4%</strong>
            </div>
        </div>
    </div>
</section>

<section class="stats-bar">
    <div class="container stats-grid">
        <div class="stat"><strong>190+</strong><span>Countries covered</span></div>
        <div class="stat"><strong>50K+</strong><span>Visas processed</span></div>
        <div class="stat"><strong>98%</strong><span>On-time approval rate</span></div>
        <div class="stat"><strong>24/7</strong><span>Autonomous agents</span></div>
    </div>
</section>

<section class="section" id="platform">
    <div class="container">
        <div class="section-head center">
            <span class="eyebrow">Platform</span>
            <h2>One platform, three ways of working</h2>
            <p>Videshia blends AI decisioning with human oversight so nothing slips through — from the first enquiry to visa in hand.</p>
        </div>
        <div class="grid-3">
            <div class="card">
                <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 12h13M13 6l6 6-6 6"/></svg></div>
                <h3>Intelligent routing</h3>
                <p>Every applicant is matched to the correct visa category, embassy rules and document checklist the moment they apply — no manual triage.</p>
            </div>
            <div class="card">
                <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="16" rx="2"/><path d="M3 9h18M8 3v4M16 3v4"/></svg></div>
                <h3>Autonomous agents</h3>
                <p>Purpose-built AI agents verify documents, flag gaps, chase embassies and keep applicants updated — around the clock, without human bottlenecks.</p>
            </div>
            <div class="card">
                <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M3 12h18M12 3c2.5 2.7 3.8 6 3.8 9s-1.3 6.3-3.8 9c-2.5-2.7-3.8-6-3.8-9s1.3-6.3 3.8-9z"/></svg></div>
                <h3>Global vision</h3>
                <p>Live embassy rule changes, processing-time benchmarks and success-rate analytics across 190+ destinations in one dashboard.</p>
            </div>
        </div>
    </div>
</section>

<section class="section section-alt" id="services">
    <div class="container">
        <div class="section-head center">
            <span class="eyebrow">Visa services</span>
            <h2>Every visa category, one workflow</h2>
            <p>Whether it's a single traveller or a partner agency managing thousands of cases, Videshia adapts to the visa type automatically.</p>
        </div>
        <div class="visa-grid">
            <div class="visa-chip" id="tourist">
                <div class="card-icon"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 2v20M2 12h20"/><circle cx="12" cy="12" r="9"/></svg></div>
                <h4>Tourist</h4>
            </div>
            <div class="visa-chip" id="business">
                <div class="card-icon"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="7" width="18" height="13" rx="2"/><path d="M8 7V5a2 2 0 012-2h4a2 2 0 012 2v2"/></svg></div>
                <h4>Business</h4>
            </div>
            <div class="visa-chip" id="work">
                <div class="card-icon"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 7h-9M14 17H5M5 7h1M18 17h1"/><circle cx="17" cy="7" r="2"/><circle cx="7" cy="17" r="2"/></svg></div>
                <h4>Work</h4>
            </div>
            <div class="visa-chip" id="student">
                <div class="card-icon"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 10L12 5 2 10l10 5 10-5z"/><path d="M6 12v5c0 1.5 3 3 6 3s6-1.5 6-3v-5"/></svg></div>
                <h4>Student</h4>
            </div>
            <div class="visa-chip">
                <div class="card-icon"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 00-3-3.87M16 3.13a4 4 0 010 7.75"/></svg></div>
                <h4>Family</h4>
            </div>
            <div class="visa-chip">
                <div class="card-icon"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 12h18M3 6h18M3 18h18"/></svg></div>
                <h4>Transit</h4>
            </div>
        </div>
    </div>
</section>

<section class="section" id="how-it-works">
    <div class="container">
        <div class="section-head center">
            <span class="eyebrow">How it works</span>
            <h2>From enquiry to visa, in four steps</h2>
        </div>
        <div class="steps">
            <div class="step">
                <h3>Tell us where you're headed</h3>
                <p>Share destination, purpose and travel dates — Videshia identifies the exact visa pathway.</p>
            </div>
            <div class="step">
                <h3>AI routes your case</h3>
                <p>Our routing engine matches you to the correct category, checklist and embassy requirements.</p>
            </div>
            <div class="step">
                <h3>Agents prepare & file</h3>
                <p>Autonomous agents verify documents, complete forms and submit your application on time.</p>
            </div>
            <div class="step">
                <h3>Track in real time</h3>
                <p>Get live status updates until your visa is approved, with a human specialist on standby.</p>
            </div>
        </div>
    </div>
</section>

<section class="section section-alt">
    <div class="container">
        <div class="section-head center">
            <span class="eyebrow">Trusted by</span>
            <h2>Agencies and travellers, in their words</h2>
        </div>
        <div class="grid-3">
            <div class="testimonial">
                <p class="quote">&ldquo;Videshia's routing engine cut our case-review time by 60%. Our team now handles triple the volume without adding headcount.&rdquo;</p>
                <div class="testimonial-person">
                    <div class="avatar">RA</div>
                    <div><strong>Ritika Anand</strong><span>Director, GlobalPath Visas</span></div>
                </div>
            </div>
            <div class="testimonial">
                <p class="quote">&ldquo;I tracked my work visa for Germany end-to-end from my phone. No agents to chase, no missed documents.&rdquo;</p>
                <div class="testimonial-person">
                    <div class="avatar">SK</div>
                    <div><strong>Sanjay Kumar</strong><span>Software Engineer</span></div>
                </div>
            </div>
            <div class="testimonial">
                <p class="quote">&ldquo;The autonomous agents caught a missing document 3 days before our deadline. That alone paid for the subscription.&rdquo;</p>
                <div class="testimonial-person">
                    <div class="avatar">MF</div>
                    <div><strong>Maria Fernandes</strong><span>Study Abroad Counsellor</span></div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="section">
    <div class="container">
        <div class="cta-band">
            <div>
                <h2>Ready to move visas at AI speed?</h2>
                <p>Create your free Videshia account and route your first application in minutes.</p>
            </div>
            <div class="cta-actions">
                <a href="<?= url('signup.php') ?>" class="btn btn-light btn-lg">Create free account</a>
                <a href="<?= url('contact.php') ?>" class="btn btn-outline-light btn-lg">Talk to sales</a>
            </div>
        </div>
    </div>
</section>

<?php require __DIR__ . '/includes/footer.php'; ?>
