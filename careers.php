<?php
$page_title = "Careers &ndash; Visa Agency";
$page_description = "Careers at Visa Agency, Patna &ndash; a small, growing technology-enabled visa consultancy. Submit your resume for future openings.";
include __DIR__ . '/includes/header.php';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Careers</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Careers</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="console-intro">
            <div class="console-intro-inner">
                <div class="console-tag"><span class="blink"></span> careers.status() &middot; team &middot; Patna, Bihar</div>
                <p class="lede">We're a small, growing technology-enabled visa consultancy based in Patna. There are no open roles listed right now, but we're always glad to hear from people who care about clear, honest client service.</p>
                <div class="console-cta-row">
                    <a class="console-btn console-btn-primary" href="careers#apply">Submit Your Resume</a>
                    <a class="console-btn console-btn-outline-dark" href="about#leadership">Meet the Team</a>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="console-section-head">
                    <p class="console-eyebrow">Open positions</p>
                    <h2>Current Openings</h2>
                </div>

                <div class="console-tool-panel">
                    <div class="console-tool-panel-bar"><span class="dot"></span><span class="dot"></span><span class="dot"></span><span class="path">careers / open-roles.json</span></div>
                    <div class="console-tool-panel-body" style="text-align:center; padding:48px 24px;">
                        <div style="width:44px; height:44px; margin:0 auto 16px; border-radius:50%; background:var(--bg); display:flex; align-items:center; justify-content:center;">
                            <svg viewBox="0 0 24 24" width="22" height="22" stroke="var(--text)" stroke-width="1.6" fill="none" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="7"/><path d="M21 21l-4.3-4.3"/></svg>
                        </div>
                        <h3 style="font-size:18px; color:var(--header); margin:0 0 8px;">No open positions right now</h3>
                        <p style="color:var(--text); font-size:14.5px; max-width:48ch; margin:0 auto;">We'll post here as soon as a role opens up. In the meantime, submit your resume below and we'll reach out if something matches.</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="console-section-head">
                    <p class="console-eyebrow">Why work here</p>
                    <h2>What We Look For</h2>
                </div>
                <div class="console-card-grid">
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M4 12l5 5L20 6"/></svg></div>
                        <h3>Attention to detail</h3>
                        <p>Small documentation errors can hold up a client's application &mdash; we value people who catch them early.</p>
                    </div>
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><circle cx="8" cy="8" r="3"/><circle cx="17" cy="9" r="2.5"/><path d="M2 21v-2a5 5 0 0 1 5-5h2a5 5 0 0 1 5 5v2"/></svg></div>
                        <h3>Client-first communication</h3>
                        <p>Clear, honest updates matter more to us than saying what a client wants to hear.</p>
                    </div>
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><path d="M12 3a9 9 0 0 1 0 18M3 12h18"/></svg></div>
                        <h3>Comfort with process</h3>
                        <p>Visa and attestation work runs on checklists and sequences &mdash; we look for people who like structure.</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix" id="apply">
            <div class="container">
                <div class="console-section-head">
                    <p class="console-eyebrow">Submit your resume</p>
                    <h2>Get On Our Radar</h2>
                    <p>We keep resumes on file and reach out when a role matching your interest opens up.</p>
                </div>

                <div class="console-tool-panel" style="max-width:760px; margin:0 auto;">
                    <div class="console-tool-panel-bar"><span class="dot"></span><span class="dot"></span><span class="dot"></span><span class="path">careers / submit-resume</span></div>
                    <div class="console-tool-panel-body">
                        <form action="mail-handler.php" method="POST" id="careersConsoleForm">
                            <div class="console-field-row">
                                <div class="console-field"><label for="cName">Your name</label><input id="cName" name="name" type="text" placeholder="Full name" required></div>
                                <div class="console-field"><label for="cEmail">Your email</label><input id="cEmail" name="email" type="email" placeholder="you@example.com" required></div>
                            </div>
                            <div class="console-field-row">
                                <div class="console-field"><label for="cPosition">Position of interest</label><input id="cPosition" name="position" type="text" placeholder="e.g. Visa Documentation Associate"></div>
                                <div class="console-field"><label for="cPhone">Phone</label><input id="cPhone" name="phone" type="tel" placeholder="+91"></div>
                            </div>
                            <div class="console-field" style="margin-bottom:18px;">
                                <label for="cMessage">A little about you</label>
                                <textarea id="cMessage" name="message" rows="3" placeholder="Briefly tell us about your experience&hellip;"></textarea>
                            </div>
                            <button type="submit" class="console-btn console-btn-primary">Submit Resume Details</button>
                            <p class="console-fine" style="margin-top:14px; margin-bottom:0;">Prefer email? Send your resume directly to <a href="mailto:info@visaagency.in?subject=Career%20Enquiry">info@visaagency.in</a>.</p>
                        </form>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="console-cta-band">
                    <div class="console-cta-inner">
                        <div>
                            <h3>Questions About Working With Us?</h3>
                            <p>Reach out directly and we'll get back to you.</p>
                        </div>
                        <div class="console-cta-buttons">
                            <a class="console-btn console-btn-primary" href="mailto:info@visaagency.in">Email Us</a>
                            <a class="console-btn console-btn-outline-dark" href="tel:+917844819819">Call +91 78448 19819</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<script>
(function(){
  var form = document.getElementById('careersConsoleForm');
  form.addEventListener('submit', function(){
    var position = document.getElementById('cPosition').value;
    var message = document.getElementById('cMessage');
    message.value = 'Position of interest: ' + (position || 'Not specified') + '\n\n' + message.value;
  });
})();
</script>

<?php include __DIR__ . '/includes/footer.php'; ?>
