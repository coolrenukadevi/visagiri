<?php
$page_title = "Refund Policy &ndash; Visa Agency";
$page_description = "How cancellations and refunds are handled for consultancy fees, government charges and third-party services booked through Visa Agency.";
include __DIR__ . '/includes/header.php';

$refund_toc = [
    ['id' => 'principle', 'n' => '01', 'label' => 'General principle'],
    ['id' => 'stages', 'n' => '02', 'label' => 'Refunds by application stage'],
    ['id' => 'non-refundable', 'n' => '03', 'label' => 'Non-refundable charges'],
    ['id' => 'third-party', 'n' => '04', 'label' => 'Third-party services'],
    ['id' => 'process', 'n' => '05', 'label' => 'How to request a refund'],
    ['id' => 'timelines', 'n' => '06', 'label' => 'Processing timelines'],
    ['id' => 'rejections', 'n' => '07', 'label' => 'Visa refusals'],
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
                    <h1 class="breadcrumb-title">Refund Policy</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Refund Policy</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="policy-meta-strip">
                    <div><span class="label">Effective Date</span><span class="value">19 August 2026</span></div>
                    <div><span class="label">Last Reviewed</span><span class="value">19 August 2026</span></div>
                    <div><span class="label">Applies To</span><span class="value">All Booked Services</span></div>
                    <div><span class="label">Request Via</span><span class="value">Email or Your Case Handler</span></div>
                </div>

                <div class="policy-layout">
                    <aside class="policy-index-rail" aria-label="Refund policy sections">
                        <p class="policy-index-title">In This Policy</p>
                        <ol id="policyToc">
                            <?php foreach ($refund_toc as $t): ?>
                            <li><a href="#<?php echo $t['id']; ?>"><span class="n"><?php echo $t['n']; ?></span><?php echo $t['label']; ?></a></li>
                            <?php endforeach; ?>
                        </ol>
                    </aside>

                    <div class="policy-content">

                        <section id="principle">
                            <div class="clause-head"><span class="clause-num">&sect;01</span><h2>General Principle</h2></div>
                            <p>We want you to feel confident booking with us. As a general principle: the earlier you cancel relative to when we begin substantive work or pay a third party on your behalf, the more of your payment can be refunded. Once fees have been paid to an embassy, consulate, attesting authority or other third party, those specific amounts become non-refundable to us, as they are outside our control.</p>
                            <div class="compliance-note">This policy covers our consultancy fee. It should be read together with Section 06 (Cancellation &amp; Refunds) of our <a href="terms-and-conditions">Terms &amp; Conditions</a>, which this page expands on.</div>
                        </section>

                        <section id="stages">
                            <div class="clause-head"><span class="clause-num">&sect;02</span><h2>Refunds by Application Stage</h2></div>
                            <div class="policy-table-wrap">
                                <table class="policy-table">
                                    <thead><tr><th>Stage at Cancellation</th><th>Consultancy Fee</th><th>Government / Third-Party Fees Already Paid</th></tr></thead>
                                    <tbody>
                                        <tr><td>Before document collection or drafting begins</td><td><span class="policy-pill ok">Refundable</span></td><td><span class="policy-pill ok">Not Yet Incurred</span></td></tr>
                                        <tr><td>After document review / application drafting has started</td><td><span class="policy-pill partial">Partial Refund</span></td><td><span class="policy-pill no">Non-Refundable</span> if already paid</td></tr>
                                        <tr><td>After filing with embassy, consulate or attesting authority</td><td><span class="policy-pill no">Non-Refundable</span></td><td><span class="policy-pill no">Non-Refundable</span></td></tr>
                                        <tr><td>After appointment, biometrics or interview completed</td><td><span class="policy-pill no">Non-Refundable</span></td><td><span class="policy-pill no">Non-Refundable</span></td></tr>
                                    </tbody>
                                </table>
                            </div>
                            <p>A partial refund reflects the work already completed on your file at the time of cancellation, assessed on a case-by-case basis by our team.</p>
                        </section>

                        <section id="non-refundable">
                            <div class="clause-head"><span class="clause-num">&sect;03</span><h2>Non-Refundable Charges</h2></div>
                            <p>The following are non-refundable once incurred, regardless of the outcome of your application:</p>
                            <ul class="policy-list">
                                <li>Embassy, consulate or visa application centre fees paid to the relevant authority.</li>
                                <li>Apostille, attestation or legalisation fees paid to the issuing or attesting body.</li>
                                <li>Courier charges once a shipment has been dispatched.</li>
                                <li>Travel insurance premiums once the policy has been issued, subject to the insurer's own free-look period, if any.</li>
                                <li>Forex conversion charges once a transaction has been executed at the quoted rate.</li>
                            </ul>
                        </section>

                        <section id="third-party">
                            <div class="clause-head"><span class="clause-num">&sect;04</span><h2>Third-Party Services</h2></div>
                            <p>Where we've booked a service on your behalf &mdash; flights, hotels, travel insurance, forex &mdash; refund eligibility for that specific booking is governed by the third-party provider's own cancellation and refund policy. We will assist you in submitting a cancellation request to the provider, but the provider's decision on the refund amount is final.</p>
                        </section>

                        <section id="process">
                            <div class="clause-head"><span class="clause-num">&sect;05</span><h2>How to Request a Refund</h2></div>
                            <ul class="policy-list">
                                <li>Contact your case handler directly, or write to <a href="mailto:info@visaagency.in">info@visaagency.in</a> with your name, application reference and reason for cancellation.</li>
                                <li>We will confirm what stage your application is at and what portion of your payment qualifies for a refund under Section 02.</li>
                                <li>Once agreed, refunds are processed to the original mode of payment, unless another mode is agreed in writing.</li>
                            </ul>
                        </section>

                        <section id="timelines">
                            <div class="clause-head"><span class="clause-num">&sect;06</span><h2>Processing Timelines</h2></div>
                            <p>Approved refunds are typically processed within 7&ndash;14 business days of confirmation, though the time for funds to reflect in your account depends on your bank or payment provider. Refunds involving a third-party provider (such as an insurer or airline) may take longer, as we depend on the provider's own processing timeline.</p>
                        </section>

                        <section id="rejections">
                            <div class="clause-head"><span class="clause-num">&sect;07</span><h2>Visa Refusals</h2></div>
                            <div class="compliance-note policy-note-warn">A visa refusal by an embassy or consulate does not entitle you to a refund of our consultancy fee or any government fee already paid, as these cover the work performed and the authority's own processing, regardless of the final decision.</div>
                            <p>If a refusal appears to be linked to an error on our part in preparing your application, please raise it with us &mdash; we review such cases individually and may offer a goodwill gesture such as a discounted reapplication fee, at our discretion.</p>
                        </section>

                        <section id="changes">
                            <div class="clause-head"><span class="clause-num">&sect;08</span><h2>Changes to This Policy</h2></div>
                            <p>We may update this Refund Policy from time to time. The "Last Reviewed" date at the top of this page shows when it was most recently updated. The policy in effect at the time you booked your service will generally apply to that booking.</p>
                        </section>

                        <section id="contact">
                            <div class="clause-head"><span class="clause-num">&sect;09</span><h2>Contact Us</h2></div>
                            <p>For a refund request or any question about a payment you've made:</p>
                            <div class="grievance-card">
                                <h3>Visa Agency &mdash; Billing &amp; Refunds</h3>
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
                <h2 class="mb-3">Not Sure What Stage Your File Is At?</h2>
                <p class="mb-4" style="max-width:640px;margin-left:auto;margin-right:auto;">
                    Reach out and our team will check your case status before you decide anything.
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
