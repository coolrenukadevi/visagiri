<?php
$page_title = "Data Security &ndash; Visa Agency";
$page_description = "How Visa Agency protects your passport, identity and financial documents across our digital systems and Patna office.";
include __DIR__ . '/includes/header.php';

$security_toc = [
    ['id' => 'approach', 'n' => '01', 'label' => 'Our approach'],
    ['id' => 'digital', 'n' => '02', 'label' => 'Digital safeguards'],
    ['id' => 'physical', 'n' => '03', 'label' => 'Physical document security'],
    ['id' => 'access', 'n' => '04', 'label' => 'Access control'],
    ['id' => 'payments', 'n' => '05', 'label' => 'Payment data'],
    ['id' => 'partners', 'n' => '06', 'label' => 'Partners & sub-processors'],
    ['id' => 'incident', 'n' => '07', 'label' => 'Incident response'],
    ['id' => 'your-part', 'n' => '08', 'label' => 'Your part in staying secure'],
    ['id' => 'contact', 'n' => '09', 'label' => 'Report a concern'],
];
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Data Security</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Data Security</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="policy-meta-strip">
                    <div><span class="label">Effective Date</span><span class="value">19 August 2026</span></div>
                    <div><span class="label">Last Reviewed</span><span class="value">19 August 2026</span></div>
                    <div><span class="label">Applies To</span><span class="value">All Client Documents</span></div>
                    <div><span class="label">Report An Issue</span><span class="value">info@visaagency.in</span></div>
                </div>

                <div class="policy-layout">
                    <aside class="policy-index-rail" aria-label="Data security sections">
                        <p class="policy-index-title">In This Policy</p>
                        <ol id="policyToc">
                            <?php foreach ($security_toc as $t): ?>
                            <li><a href="#<?php echo $t['id']; ?>"><span class="n"><?php echo $t['n']; ?></span><?php echo $t['label']; ?></a></li>
                            <?php endforeach; ?>
                        </ol>
                    </aside>

                    <div class="policy-content">

                        <section id="approach">
                            <div class="clause-head"><span class="clause-num">&sect;01</span><h2>Our Approach</h2></div>
                            <p>Every application we handle involves documents you couldn't easily replace &mdash; your passport, financial records, certificates and photographs. We treat the security of these documents, in both digital and physical form, as core to how we operate, not as an afterthought.</p>
                            <div class="compliance-note">This page describes the safeguards we apply. No system is completely immune to risk, and we encourage you to also follow the precautions in Section 08 when sharing documents with us.</div>
                        </section>

                        <section id="digital">
                            <div class="clause-head"><span class="clause-num">&sect;02</span><h2>Digital Safeguards</h2></div>
                            <div class="policy-safeguard-grid">
                                <div class="policy-safeguard-card">
                                    <div class="icon"><svg viewBox="0 0 24 24" fill="none" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"><rect x="4" y="10" width="16" height="10" rx="1.5"/><path d="M8 10V7a4 4 0 0 1 8 0v3"/></svg></div>
                                    <div class="name">Encryption in Transit</div>
                                    <div class="desc">Our website and client portals use HTTPS encryption to protect data as it travels between your device and our systems.</div>
                                </div>
                                <div class="policy-safeguard-card">
                                    <div class="icon"><svg viewBox="0 0 24 24" fill="none" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"><path d="M12 3l7 3v6c0 5-3.5 8-7 9-3.5-1-7-4-7-9V6l7-3z"/></svg></div>
                                    <div class="name">Encryption at Rest</div>
                                    <div class="desc">Document uploads and case files stored in our systems are encrypted, so that stored data isn't held or backed up in plain text.</div>
                                </div>
                                <div class="policy-safeguard-card">
                                    <div class="icon"><svg viewBox="0 0 24 24" fill="none" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg></div>
                                    <div class="name">Session Controls</div>
                                    <div class="desc">Staff accounts use timed sessions and login monitoring to reduce the risk of unauthorised access to client files.</div>
                                </div>
                                <div class="policy-safeguard-card">
                                    <div class="icon"><svg viewBox="0 0 24 24" fill="none" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg></div>
                                    <div class="name">Regular Backups</div>
                                    <div class="desc">Case data is backed up on a routine schedule to guard against accidental loss, with access to backups similarly restricted.</div>
                                </div>
                            </div>
                        </section>

                        <section id="physical">
                            <div class="clause-head"><span class="clause-num">&sect;03</span><h2>Physical Document Security</h2></div>
                            <p>Original passports, certificates and other physical documents handed to us at our Patna office are logged on receipt, stored in access-controlled areas, and returned or couriered back to you using trackable delivery once the relevant step of your application is complete. We do not retain original physical documents beyond what is needed for your active application.</p>
                        </section>

                        <section id="access">
                            <div class="clause-head"><span class="clause-num">&sect;04</span><h2>Access Control</h2></div>
                            <p>Access to client files &mdash; digital and physical &mdash; is limited to the team members handling your application and those directly supervising it. Staff are briefed on confidentiality expectations when handling passport, identity and financial documents, and access to case management systems is individually logged.</p>
                        </section>

                        <section id="payments">
                            <div class="clause-head"><span class="clause-num">&sect;05</span><h2>Payment Data</h2></div>
                            <p>We do not store full payment card numbers on our own systems. Card and online payments are processed through our payment gateway partners, who maintain their own industry-standard security certifications. We retain only the transaction records needed for invoicing, accounting and refund handling.</p>
                        </section>

                        <section id="partners">
                            <div class="clause-head"><span class="clause-num">&sect;06</span><h2>Partners &amp; Sub-Processors</h2></div>
                            <p>Where we work with courier companies, payment gateways, forex partners or insurance providers to deliver a service you've requested, we share only the information each partner needs to fulfil that specific task. These partners are responsible for securing the data once it reaches their systems, under their own policies.</p>
                        </section>

                        <section id="incident">
                            <div class="clause-head"><span class="clause-num">&sect;07</span><h2>Incident Response</h2></div>
                            <p>If we become aware of an incident that may have compromised your personal information, we will investigate promptly, take steps to contain and remediate it, and notify affected clients and, where legally required, the relevant regulatory authority, in line with our obligations under India's Digital Personal Data Protection Act, 2023.</p>
                        </section>

                        <section id="your-part">
                            <div class="clause-head"><span class="clause-num">&sect;08</span><h2>Your Part in Staying Secure</h2></div>
                            <ul class="policy-list">
                                <li>Share sensitive documents only through the secure upload channel or in person at our office, rather than over unencrypted email where avoidable.</li>
                                <li>Avoid sending full bank account or card numbers over WhatsApp or SMS.</li>
                                <li>Let us know promptly if you believe a document you shared with us may have been compromised elsewhere, or if you notice unexpected communication claiming to be from Visa Agency.</li>
                                <li>Keep your customer login credentials confidential and unique to our portal.</li>
                            </ul>
                        </section>

                        <section id="contact">
                            <div class="clause-head"><span class="clause-num">&sect;09</span><h2>Report a Concern</h2></div>
                            <p>If you have a security question, or want to report a suspected issue with how your data has been handled:</p>
                            <div class="grievance-card">
                                <h3>Visa Agency &mdash; Data Security Contact</h3>
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
                <h2 class="mb-3">Wondering How Your File Will Be Handled?</h2>
                <p class="mb-4" style="max-width:640px;margin-left:auto;margin-right:auto;">
                    Ask our team to walk you through document handling before you submit anything.
                </p>
                <div class="cta-buttons d-flex flex-wrap justify-content-center gap-3">
                    <a href="contact" class="theme-btn">Start Your Visa Enquiry <i class="fa-solid fa-arrow-right"></i></a>
                    <a href="tel:+917844819819" class="theme-btn style-outline">Talk to a Visa Expert <i class="fa-solid fa-phone"></i></a>
                </div>
            </div>
        </section>

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
        </script>

<?php include __DIR__ . '/includes/footer.php'; ?>
