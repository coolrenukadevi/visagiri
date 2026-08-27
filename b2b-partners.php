<?php
$page_title = "B2B Partners &ndash; Visa Agency";
$page_description = "Partner with VisaAgency.in &ndash; travel agents, corporates and consultants can refer visa, apostille and forex clients to our team in Patna.";
include __DIR__ . '/includes/header.php';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">B2B Partners</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>B2B Partners</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="console-intro">
            <div class="console-intro-inner">
                <div class="console-tag"><span class="blink"></span> partners.status() &middot; b2b &middot; Patna, Bihar</div>
                <p class="lede">If you run a travel agency, corporate travel desk, education consultancy or HR/mobility function and regularly need visa, apostille or forex support for your clients or employees, we'd like to work with you directly &mdash; a single point of contact instead of a different vendor for every case.</p>
                <div class="console-cta-row">
                    <a class="console-btn console-btn-primary" href="b2b-partner-register">Become a B2B Partner</a>
                    <a class="console-btn console-btn-outline-dark" href="<?php echo htmlspecialchars($site_whatsapp_url); ?>?text=<?php echo rawurlencode('Hello VisaAgency.in, I would like to discuss a B2B partnership.'); ?>" target="_blank" rel="noopener">WhatsApp Our Team</a>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="console-section-head">
                    <p class="console-eyebrow">Who this is for</p>
                    <h2>Built For Repeat, Referral &amp; Corporate Volume</h2>
                </div>
                <div class="console-card-grid">
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M3 9l9-6 9 6-9 6-9-6z"/><path d="M3 9v6l9 6 9-6V9"/></svg></div>
                        <h3>Travel Agents &amp; Consultants</h3>
                        <p>Refer your clients' visa, apostille or forex needs to us and stay in the loop as we handle the documentation and compliance.</p>
                    </div>
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="7" width="18" height="13" rx="2"/><path d="M8 7V5a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg></div>
                        <h3>Corporates &amp; HR Teams</h3>
                        <p>Business travel visas and employee relocation support handled as a standing arrangement, not a one-off request each time.</p>
                    </div>
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M22 12h-6l-2 3h-4l-2-3H2"/><path d="M5.5 5h13l3 7-3 7h-13l-3-7 3-7z"/></svg></div>
                        <h3>Education &amp; Migration Consultants</h3>
                        <p>Student and dependent visa documentation support for the applicants you're already advising.</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="console-section-head">
                    <p class="console-eyebrow">How it works</p>
                    <h2>A Simple, Direct Arrangement</h2>
                </div>
                <div class="console-card-grid">
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M4 4h16v16H4z"/><path d="M8 2v4M16 2v4M4 10h16"/></svg></div>
                        <h3>1. Register interest</h3>
                        <p>Tell us a bit about your business using the form below.</p>
                    </div>
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><circle cx="8" cy="8" r="3"/><circle cx="17" cy="9" r="2.5"/><path d="M2 21v-2a5 5 0 0 1 5-5h2a5 5 0 0 1 5 5v2"/></svg></div>
                        <h3>2. We get in touch</h3>
                        <p>Our team reaches out to understand your typical case volume and needs.</p>
                    </div>
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M4 12l5 5L20 6"/></svg></div>
                        <h3>3. Start referring cases</h3>
                        <p>Once terms are agreed, you get a direct line to our team for every case you send our way.</p>
                    </div>
                </div>
                <p class="console-fine" style="text-align:center; margin-top:22px;">We work with a small number of partners at a time so every case gets proper attention &mdash; commercial terms are discussed individually once we understand your volume and requirements.</p>
            </div>
        </section>

        <section class="section-padding fix" id="apply">
            <div class="container">
                <div class="console-section-head">
                    <p class="console-eyebrow">Register interest</p>
                    <h2>Tell Us About Your Business</h2>
                    <p>We'll get back to you to discuss how a partnership could work.</p>
                </div>

                <div class="console-tool-panel" style="max-width:760px; margin:0 auto;">
                    <div class="console-tool-panel-bar"><span class="dot"></span><span class="dot"></span><span class="dot"></span><span class="path">partners / register-interest</span></div>
                    <div class="console-tool-panel-body">
                        <form action="mail-handler.php" method="POST" id="b2bConsoleForm">
                            <div class="console-field-row">
                                <div class="console-field"><label for="bName">Your name</label><input id="bName" name="name" type="text" placeholder="Full name" required></div>
                                <div class="console-field"><label for="bEmail">Your email</label><input id="bEmail" name="email" type="email" placeholder="you@example.com" required></div>
                            </div>
                            <div class="console-field-row">
                                <div class="console-field"><label for="bCompany">Company / agency name</label><input id="bCompany" name="company" type="text" placeholder="Business name"></div>
                                <div class="console-field"><label for="bPhone">Phone</label><input id="bPhone" name="phone" type="tel" placeholder="+91"></div>
                            </div>
                            <div class="console-field" style="margin-bottom:18px;">
                                <label for="bMessage">About your business &amp; typical case volume</label>
                                <textarea id="bMessage" name="message" rows="3" placeholder="e.g. Corporate travel desk, ~10 business visas/month&hellip;"></textarea>
                            </div>
                            <button type="submit" class="console-btn console-btn-primary">Register Interest</button>
                            <p class="console-fine" style="margin-top:14px; margin-bottom:0;">Prefer email? Write to us directly at <a href="mailto:info@visaagency.in?subject=B2B%20Partnership%20Enquiry">info@visaagency.in</a>.</p>
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
                            <h3>Already A Partner?</h3>
                            <p>Reach your usual contact directly, or call our main line.</p>
                        </div>
                        <div class="console-cta-buttons">
                            <a class="console-btn console-btn-primary" href="mailto:info@visaagency.in">Email Us</a>
                            <a class="console-btn console-btn-outline-dark" href="tel:<?php echo htmlspecialchars($site_phone_e164); ?>">Call <?php echo htmlspecialchars($site_phone_display); ?></a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<script>
(function(){
  var form = document.getElementById('b2bConsoleForm');
  form.addEventListener('submit', function(){
    var company = document.getElementById('bCompany').value;
    var message = document.getElementById('bMessage');
    message.value = 'Company/Agency: ' + (company || 'Not specified') + '\n\n' + message.value;
  });
})();
</script>

<?php include __DIR__ . '/includes/footer.php'; ?>
