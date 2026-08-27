<?php
$page_title = "B2B Partners &ndash; Visa Agency";
$page_description = "Partner with VisaAgency.in &ndash; travel agents, tour operators and corporate travel desks get their own portal to submit visa cases, track quotations and invoices, and manage their team.";
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
                <p class="lede">If you run a travel agency, tour operator, corporate travel desk or education/migration consultancy and regularly need visa support for your clients or employees, get your own B2B Partner Portal &mdash; submit cases, track quotations and invoices, and manage your team, all in one place.</p>
                <div class="console-cta-row">
                    <?php if ($b2bPartnerLoggedIn): ?>
                    <a class="console-btn console-btn-primary" href="b2b-dashboard">Go to My Dashboard</a>
                    <?php else: ?>
                    <a class="console-btn console-btn-primary" href="b2b-partner-register">Become a B2B Partner</a>
                    <a class="console-btn console-btn-outline-dark" href="b2b-login">Partner Login</a>
                    <?php endif; ?>
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

        <section class="section-padding fix section-bg-1" id="benefits">
            <div class="container">
                <div class="console-section-head">
                    <p class="console-eyebrow">Why partner with us</p>
                    <h2>Benefits Of A B2B Partner Account</h2>
                </div>
                <div class="console-card-grid">
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M4 4h16v16H4z"/><path d="M8 2v4M16 2v4M4 10h16"/></svg></div>
                        <h3>Your Own Portal</h3>
                        <p>Submit visa cases, request quotations and track every application's status from a dashboard built for your team, not a shared inbox.</p>
                    </div>
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="16" rx="2"/><path d="M7 8h10M7 12h10M7 16h6"/></svg></div>
                        <h3>Transparent Quotations &amp; Invoices</h3>
                        <p>Itemised quotations you can accept, reject or request a revision on, and invoices you can pay online, by wallet credit or offline &mdash; no back-and-forth over email.</p>
                    </div>
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2l3 6 6 1-4.5 4.5L18 20l-6-3-6 3 1.5-6.5L3 9l6-1 3-6z"/></svg></div>
                        <h3>Tiered Pricing &amp; Credit</h3>
                        <p>Volume-based tiers unlock better pricing and an approved credit limit, so you're not always paying case-by-case upfront.</p>
                    </div>
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><circle cx="9" cy="7" r="4"/><path d="M2 21v-2a5 5 0 0 1 5-5h4a5 5 0 0 1 5 5v2"/><path d="M17 3.5a4 4 0 0 1 0 7.5"/><path d="M22 21v-2a5 5 0 0 0-3-4.5"/></svg></div>
                        <h3>A Team, Not Just An Account</h3>
                        <p>Add your colleagues as sub-users with their own logins and permissions &mdash; Visa Executives, Accounts and Managers each see only what they need.</p>
                    </div>
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg></div>
                        <h3>Direct Messaging</h3>
                        <p>A dedicated Relationship Manager and an in-portal message thread, instead of chasing a generic support line.</p>
                    </div>
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M3 3v18h18"/><path d="M7 15l4-4 3 3 5-6"/></svg></div>
                        <h3>Performance Reports</h3>
                        <p>Case volume, quotation conversion and invoice history in one report, exportable to CSV whenever you need it.</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="console-section-head">
                    <p class="console-eyebrow">How it works</p>
                    <h2>Get Set Up In Three Steps</h2>
                </div>
                <div class="console-card-grid">
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M4 4h16v16H4z"/><path d="M8 2v4M16 2v4M4 10h16"/></svg></div>
                        <h3>1. Register your business</h3>
                        <p>Complete the self-service enrollment form with your business, contact and KYC details, and verify your email with a one-time code.</p>
                    </div>
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M9 12l2 2 4-4"/><circle cx="12" cy="12" r="9"/></svg></div>
                        <h3>2. Get verified</h3>
                        <p>Upload your KYC documents and our B2B team reviews and approves your account &mdash; you'll be notified by email the moment you're approved.</p>
                    </div>
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M4 12l5 5L20 6"/></svg></div>
                        <h3>3. Log in and start</h3>
                        <p>Submit your first visa case, request a quotation, and manage everything &mdash; invoices, wallet, documents, your team &mdash; from your Partner Portal.</p>
                    </div>
                </div>
                <p class="console-fine" style="text-align:center; margin-top:22px;">Commercial terms (tier, credit limit) are set individually once we understand your typical volume and requirements.</p>
            </div>
        </section>

        <section id="faq" class="section-padding fix section-bg-1">
            <div class="container">
                <div class="console-section-head">
                    <p class="console-eyebrow">Common questions</p>
                    <h2>B2B Partner FAQs</h2>
                </div>
                <div class="faq-accordion" style="max-width:820px;margin:0 auto;">
                    <div class="faq-item active">
                        <div class="faq-question">Who can become a B2B partner? <i class="fa-solid fa-plus"></i></div>
                        <div class="faq-answer"><p>Travel agencies, tour operators, corporate travel desks and HR/mobility teams, and education or migration consultancies who regularly need visa support for their clients or employees.</p></div>
                    </div>
                    <div class="faq-item">
                        <div class="faq-question">How long does approval take? <i class="fa-solid fa-plus"></i></div>
                        <div class="faq-answer"><p>Once you submit your registration form and KYC documents, our B2B team typically reviews applications within a few business days. You'll receive an email the moment a decision is made, or if we need any additional documents.</p></div>
                    </div>
                    <div class="faq-item">
                        <div class="faq-question">What documents do I need to register? <i class="fa-solid fa-plus"></i></div>
                        <div class="faq-answer"><p>Basic KYC for your business (such as GST/PAN and IATA/TAFI registration where applicable) is requested during and after registration &mdash; the exact list is shown in your Partner Portal once your account is created.</p></div>
                    </div>
                    <div class="faq-item">
                        <div class="faq-question">Is there a minimum case volume to join? <i class="fa-solid fa-plus"></i></div>
                        <div class="faq-answer"><p>No fixed minimum, but your tier (and the pricing/credit that comes with it) is set based on your typical volume, so higher-volume partners generally unlock better terms.</p></div>
                    </div>
                    <div class="faq-item">
                        <div class="faq-question">Can more than one person from my company use the portal? <i class="fa-solid fa-plus"></i></div>
                        <div class="faq-answer"><p>Yes. Once approved, the account Owner can add team members (Visa Executive, Accounts Executive, Manager) from the Team Management page, each with their own login and permissions.</p></div>
                    </div>
                    <div class="faq-item">
                        <div class="faq-question">How do I pay for visa cases? <i class="fa-solid fa-plus"></i></div>
                        <div class="faq-answer"><p>Invoices are raised against accepted quotations. Payments are recorded by our Accounts team against your invoice, and can also be drawn against your approved wallet credit limit if one has been set for your account.</p></div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix" id="apply">
            <div class="container">
                <div class="console-section-head">
                    <p class="console-eyebrow">Ready to get started?</p>
                    <h2>Create Your B2B Partner Account</h2>
                    <p>Registration takes a few minutes &mdash; you'll verify your email with a one-time code and hear back from our team once your account is reviewed.</p>
                </div>
                <div class="console-cta-row" style="margin-bottom:36px;">
                    <a class="console-btn console-btn-primary" href="b2b-partner-register">Become a B2B Partner</a>
                    <a class="console-btn console-btn-outline-dark" href="b2b-login">Already Registered? Partner Login</a>
                </div>

                <div class="console-tool-panel" style="max-width:760px; margin:0 auto;">
                    <div class="console-tool-panel-bar"><span class="dot"></span><span class="dot"></span><span class="dot"></span><span class="path">partners / ask-a-question</span></div>
                    <div class="console-tool-panel-body">
                        <p class="console-fine" style="margin-top:0;">Have a question before you register? Tell us a bit about your business and we'll get back to you.</p>
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
                            <button type="submit" class="console-btn console-btn-primary">Send Question</button>
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
                            <p>Log in to your Partner Portal, or reach your Relationship Manager directly.</p>
                        </div>
                        <div class="console-cta-buttons">
                            <a class="console-btn console-btn-primary" href="b2b-login">Partner Login</a>
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
