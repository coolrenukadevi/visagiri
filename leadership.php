<?php
$page_title = "Leadership &ndash; Visa Agency";
$page_description = "The leadership team behind Visa Agency's case strategy, documentation standards and client experience across Patna, Ranchi, Raipur and Bhopal.";
include __DIR__ . '/includes/header.php';

$lead_placards = [
    ['title' => 'Standards set centrally',   'text' => 'Documentation checklists and quality standards are set once by our operations leadership and applied consistently across every office.', 'icon' => '<circle cx="12" cy="12" r="9"/><path d="M8 12l2.5 2.5L16 9"/>'],
    ['title' => 'Escalation when it matters','text' => 'If your case needs senior attention &mdash; a complex document issue or an embassy query &mdash; leadership is reachable, not several layers removed.', 'icon' => '<path d="M7 3h7l5 5v13a1 1 0 0 1-1 1H7a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1z"/><path d="M14 3v5h5"/>'],
    ['title' => 'Consistent across cities',  'text' => 'The same leadership team oversees Patna, Ranchi, Raipur and Bhopal, so the process you get does not depend on which office you walk into.', 'icon' => '<circle cx="12" cy="12" r="9"/><path d="M12 3a9 9 0 0 1 0 18M3 12h18"/>'],
];
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Leadership</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="about">About Us</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Leadership</li>
                    </ul>
                </div>
            </div>
        </section>

        <!-- ============ LEDE (navy band) ============ -->
        <section style="background:var(--theme-2); color:var(--white); padding:44px 0 40px;">
            <div class="container">
                <p class="ab-hero-lead" style="color:rgba(255,255,255,.82); font-size:1.05rem; max-width:70ch; margin:0;">Our leadership team oversees case strategy, documentation standards and client experience across every office we serve.</p>
            </div>
        </section>

        <!-- ============ TEAM TICKETS ============ -->
        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Who We Are</span>
                    <h2 class="split-text-right split-text-in-right">The People Behind The Process</h2>
                </div>
                <div class="ab2-ticket-grid-4">
                    <div class="ab2-ticket">
                        <span class="ab2-ticket-role">Case Strategy</span>
                        <h3 style="font-family:inherit; text-transform:none; font-size:1.05rem; font-weight:700; color:var(--header); margin:8px 0 8px;">Founder &amp; Director</h3>
                        <p>Sets overall case strategy and oversees relationships with embassy and consular partners.</p>
                    </div>
                    <div class="ab2-ticket">
                        <span class="ab2-ticket-role">Documentation Quality</span>
                        <h3 style="font-family:inherit; text-transform:none; font-size:1.05rem; font-weight:700; color:var(--header); margin:8px 0 8px;">Head of Visa Operations</h3>
                        <p>Leads documentation review and application quality across tourist, business, transit and family visa categories.</p>
                    </div>
                    <div class="ab2-ticket">
                        <span class="ab2-ticket-role">Document Legalisation</span>
                        <h3 style="font-family:inherit; text-transform:none; font-size:1.05rem; font-weight:700; color:var(--header); margin:8px 0 8px;">Head of Apostille &amp; Attestation</h3>
                        <p>Oversees document legalisation casework, including MEA apostille and embassy attestation chains.</p>
                    </div>
                    <div class="ab2-ticket">
                        <span class="ab2-ticket-role">Client Support</span>
                        <h3 style="font-family:inherit; text-transform:none; font-size:1.05rem; font-weight:700; color:var(--header); margin:8px 0 8px;">Client Experience Lead</h3>
                        <p>Coordinates appointments, communication and support for clients across all four cities we serve.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- ============ HOW WE WORK: PLACARDS ============ -->
        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">How We Work</span>
                    <h2 class="split-text-right split-text-in-right">One Caseworker Owns Your File, Top To Bottom</h2>
                    <p style="margin-top:10px;">Rather than passing your application between departments, leadership assigns one caseworker who stays with your case from intake to visa collection &mdash; while our operations leads set the documentation standards that caseworker follows.</p>
                </div>
                <div class="ab2-placards">
                    <?php foreach ($lead_placards as $t): ?>
                    <div class="ab2-placard">
                        <div class="tile"><svg viewBox="0 0 24 24"><?php echo $t['icon']; ?></svg></div>
                        <div>
                            <h3><?php echo htmlspecialchars($t['title']); ?></h3>
                            <p><?php echo $t['text']; ?></p>
                        </div>
                    </div>
                    <?php endforeach; ?>
                </div>
                <div class="faq-accordion" style="margin-top:36px;">
                    <div class="faq-item active">
                        <div class="faq-question">Can I speak with a senior team member directly? <i class="fa-solid fa-plus"></i></div>
                        <div class="faq-answer"><p>If your caseworker feels your situation needs it, they'll escalate to the relevant lead. You can also request this directly through your caseworker or our <a href="contact">contact page</a>.</p></div>
                    </div>
                    <div class="faq-item">
                        <div class="faq-question">Does the leadership team change per city? <i class="fa-solid fa-plus"></i></div>
                        <div class="faq-answer"><p>No &mdash; the same leadership team sets standards and oversees casework across all four cities we serve, so quality and process stay consistent.</p></div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="console-cta-band">
                    <div class="console-cta-inner">
                        <div>
                            <h3>Want To Talk To The Team Directly?</h3>
                            <p>Book a consultation or send us your case details &mdash; we'll get back to you promptly.</p>
                        </div>
                        <div class="console-cta-buttons">
                            <a class="console-btn console-btn-primary" href="contact">Start Your Visa Enquiry</a>
                            <a class="console-btn console-btn-outline-dark" href="tel:+917844819819">Call +91 78448 19819</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
