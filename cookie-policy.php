<?php
$page_title = "Cookie Policy &ndash; Visa Agency";
$page_description = "How visaagency.in uses cookies and similar technologies, and how you can control them.";
include __DIR__ . '/includes/header.php';

$cookie_toc = [
    ['id' => 'what-are-cookies', 'n' => '01', 'label' => 'What are cookies'],
    ['id' => 'why-we-use', 'n' => '02', 'label' => 'Why we use them'],
    ['id' => 'types', 'n' => '03', 'label' => 'Types we use'],
    ['id' => 'table', 'n' => '04', 'label' => 'Cookie details'],
    ['id' => 'third-party', 'n' => '05', 'label' => 'Third-party cookies'],
    ['id' => 'control', 'n' => '06', 'label' => 'Managing your preferences'],
    ['id' => 'browser', 'n' => '07', 'label' => 'Browser controls'],
    ['id' => 'changes', 'n' => '08', 'label' => 'Changes to this policy'],
    ['id' => 'contact', 'n' => '09', 'label' => 'Contact us'],
];
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Cookie Policy</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Cookie Policy</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="policy-meta-strip">
                    <div><span class="label">Effective Date</span><span class="value">19 August 2026</span></div>
                    <div><span class="label">Last Reviewed</span><span class="value">19 August 2026</span></div>
                    <div><span class="label">Applies To</span><span class="value">visaagency.in</span></div>
                    <div><span class="label">Read Alongside</span><span class="value"><a href="privacy-policy">Our Privacy Policy</a></span></div>
                </div>

                <div class="policy-layout">
                    <aside class="policy-index-rail" aria-label="Cookie policy sections">
                        <p class="policy-index-title">In This Policy</p>
                        <ol id="policyToc">
                            <?php foreach ($cookie_toc as $t): ?>
                            <li><a href="#<?php echo $t['id']; ?>"><span class="n"><?php echo $t['n']; ?></span><?php echo $t['label']; ?></a></li>
                            <?php endforeach; ?>
                        </ol>
                    </aside>

                    <div class="policy-content">

                        <section id="what-are-cookies">
                            <div class="clause-head"><span class="clause-num">&sect;01</span><h2>What Are Cookies</h2></div>
                            <p>Cookies are small text files placed on your device when you visit a website. They let a site remember information about your visit &mdash; such as your preferences or how you navigated the pages &mdash; so it can function properly and be improved over time. Similar technologies, such as local storage, work in comparable ways and are covered by this policy.</p>
                        </section>

                        <section id="why-we-use">
                            <div class="clause-head"><span class="clause-num">&sect;02</span><h2>Why We Use Them</h2></div>
                            <p>We use cookies on visaagency.in to:</p>
                            <ul class="policy-list">
                                <li>Keep the website secure and functioning correctly, including our enquiry, appointment and checklist tools.</li>
                                <li>Remember choices you've made, such as a country page you were viewing or a form you started.</li>
                                <li>Understand, in aggregate, how visitors use our site so we can improve navigation, content and load times.</li>
                                <li>Measure the effectiveness of our pages so we know which visa guides and services are most useful to visitors.</li>
                            </ul>
                            <p>We do not use cookies to build advertising profiles of you or sell your browsing data to third parties.</p>
                        </section>

                        <section id="types">
                            <div class="clause-head"><span class="clause-num">&sect;03</span><h2>Types We Use</h2></div>
                            <p><span class="policy-pill essential">Essential</span> Required for the site to work &mdash; these cannot be switched off, as core features like forms and secure browsing depend on them.</p>
                            <p><span class="policy-pill analytics">Analytics</span> Help us understand aggregate visitor behaviour so we can improve the site. These are optional.</p>
                            <p><span class="policy-pill preference">Preference</span> Remember choices such as previously viewed countries or dismissed banners. These are optional.</p>
                        </section>

                        <section id="table">
                            <div class="clause-head"><span class="clause-num">&sect;04</span><h2>Cookie Details</h2></div>
                            <p>The table below illustrates the categories of cookies used on our site and typical retention periods.</p>
                            <div class="policy-table-wrap">
                                <table class="policy-table">
                                    <thead><tr><th>Category</th><th>Purpose</th><th>Set By</th><th>Typical Duration</th></tr></thead>
                                    <tbody>
                                        <tr><td><span class="policy-pill essential">Essential</span></td><td>Maintains your session, secures form submissions, remembers cookie consent choice</td><td>visaagency.in</td><td>Session &ndash; 12 months</td></tr>
                                        <tr><td><span class="policy-pill analytics">Analytics</span></td><td>Measures page views and site usage in aggregate to improve content and performance</td><td>visaagency.in &amp; analytics providers</td><td>Up to 24 months</td></tr>
                                        <tr><td><span class="policy-pill preference">Preference</span></td><td>Remembers previously viewed country or service pages and interface preferences</td><td>visaagency.in</td><td>Up to 12 months</td></tr>
                                    </tbody>
                                </table>
                            </div>
                        </section>

                        <section id="third-party">
                            <div class="clause-head"><span class="clause-num">&sect;05</span><h2>Third-Party Cookies</h2></div>
                            <p>Some pages on our site embed third-party content or tools &mdash; such as maps, appointment widgets or payment gateways &mdash; which may set their own cookies. These are governed by the respective third party's own cookie and privacy policies, not this one. We choose reputable partners but do not control how they process data collected through their own cookies.</p>
                        </section>

                        <section id="control">
                            <div class="clause-head"><span class="clause-num">&sect;06</span><h2>Managing Your Preferences</h2></div>
                            <p>When you first visit visaagency.in, you'll see a cookie banner where you can accept all cookies or continue with essential cookies only. You can change your choice at any time by clearing your cookie consent in your browser and revisiting the site.</p>
                            <div class="compliance-note">Blocking essential cookies may prevent forms, appointment booking and secure areas of the site from working correctly.</div>
                        </section>

                        <section id="browser">
                            <div class="clause-head"><span class="clause-num">&sect;07</span><h2>Browser Controls</h2></div>
                            <p>Most browsers let you view, manage or delete cookies through their settings. General guidance for common browsers:</p>
                            <div class="policy-browser-grid">
                                <div class="policy-browser-card"><div class="name">Chrome</div><div class="path">Settings &rarr; Privacy and security &rarr; Cookies and other site data</div></div>
                                <div class="policy-browser-card"><div class="name">Safari</div><div class="path">Settings &rarr; Safari &rarr; Advanced &rarr; Website Data</div></div>
                                <div class="policy-browser-card"><div class="name">Firefox</div><div class="path">Settings &rarr; Privacy &amp; Security &rarr; Cookies and Site Data</div></div>
                                <div class="policy-browser-card"><div class="name">Edge</div><div class="path">Settings &rarr; Cookies and site permissions</div></div>
                            </div>
                            <p>Menu names change periodically as browsers update, so refer to your browser's help documentation for the current path.</p>
                        </section>

                        <section id="changes">
                            <div class="clause-head"><span class="clause-num">&sect;08</span><h2>Changes to This Policy</h2></div>
                            <p>We may update this Cookie Policy as our website and the tools we use evolve. The "Last Reviewed" date at the top of this page shows when it was most recently updated. We encourage you to check back periodically.</p>
                        </section>

                        <section id="contact">
                            <div class="clause-head"><span class="clause-num">&sect;09</span><h2>Contact Us</h2></div>
                            <p>If you have questions about our use of cookies, please reach out:</p>
                            <div class="grievance-card">
                                <h3>Visa Agency &mdash; Privacy Contact</h3>
                                <p>A unit of Tripgation Private Limited</p>
                                <div class="grievance-grid">
                                    <div><span class="label">Office</span><span class="value">#302, Sharda Mansion Apartment, Kailash Puri, Hanuman Nagar, Patna, Bihar 800020</span></div>
                                    <div><span class="label">Email</span><span class="value"><a href="mailto:info@visaagency.in">info@visaagency.in</a></span></div>
                                    <div><span class="label">Phone</span><span class="value"><a href="tel:+917844819819">+91 78448 19819</a></span></div>
                                    <div><span class="label">Hours</span><span class="value">Monday &ndash; Friday, 9:00 AM &ndash; 5:00 PM</span></div>
                                </div>
                            </div>
                        </section>

                    </div>
                </div>
            </div>
        </section>

        <section class="final-cta section-padding fix">
            <div class="container text-center">
                <h2 class="mb-3">Prefer to Talk It Through?</h2>
                <p class="mb-4" style="max-width:640px;margin-left:auto;margin-right:auto;">
                    Our team can explain how your data moves through the visa process, cookies included.
                </p>
                <div class="cta-buttons d-flex flex-wrap justify-content-center gap-3">
                    <a href="contact" class="theme-btn">Start Your Visa Enquiry <i class="fa-solid fa-arrow-right"></i></a>
                    <a href="tel:+917844819819" class="theme-btn style-outline">Talk to a Visa Expert <i class="fa-solid fa-phone"></i></a>
                </div>
            </div>
        </section>

        <div class="cookie-banner" id="cookieBanner" role="dialog" aria-live="polite" aria-label="Cookie preferences">
            <p>We use essential cookies to run this site, and optional analytics/preference cookies to improve it. See our <a href="cookie-policy#types">cookie types</a> above.</p>
            <div class="cookie-actions">
                <button class="cookie-accept" type="button" id="cookieAccept">Accept All</button>
                <button class="cookie-essential" type="button" id="cookieEssential">Essential Only</button>
            </div>
        </div>

        <script>
        (function () {
            var links = Array.prototype.slice.call(document.querySelectorAll('#policyToc a'));
            var sections = links.map(function (l) { return document.querySelector(l.getAttribute('href')); }).filter(Boolean);
            if (!('IntersectionObserver' in window) || !sections.length) return;
            var map = {};
            sections.forEach(function (sec, i) { map[sec.id] = links[i]; });
            var observer = new IntersectionObserver(function (entries) {
                entries.forEach(function (entry) {
                    var link = map[entry.target.id];
                    if (!link) return;
                    if (entry.isIntersecting) {
                        links.forEach(function (l) { l.classList.remove('active'); });
                        link.classList.add('active');
                    }
                });
            }, { rootMargin: '-15% 0px -70% 0px', threshold: 0 });
            sections.forEach(function (sec) { observer.observe(sec); });
        })();

        (function () {
            var banner = document.getElementById('cookieBanner');
            var acceptBtn = document.getElementById('cookieAccept');
            var essentialBtn = document.getElementById('cookieEssential');
            if (!banner) return;
            function dismiss() { banner.classList.add('is-hidden'); }
            if (acceptBtn) acceptBtn.addEventListener('click', dismiss);
            if (essentialBtn) essentialBtn.addEventListener('click', dismiss);
        })();
        </script>

<?php include __DIR__ . '/includes/footer.php'; ?>
