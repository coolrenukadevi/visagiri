<?php
$page_title = "Contact Us &ndash; Visa Agency";
$page_description = "Contact Visa Agency, Patna &ndash; send an enquiry, book an appointment, or reach us by phone or WhatsApp.";
include __DIR__ . '/includes/header.php';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Contact Us</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Contact Us</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="console-intro">
            <div class="console-intro-inner">
                <div class="console-tag"><span class="blink"></span> contact.reach() &middot; Patna &middot; Ranchi &middot; Raipur &middot; Bhopal</div>
                <p class="lede">Send us your case details and we'll respond with next steps &mdash; or reach out directly by phone or WhatsApp during office hours.</p>
                <div class="console-cta-row">
                    <a class="console-btn console-btn-primary" href="tel:+917844819819">Call +91 78448 19819</a>
                    <a class="console-btn console-btn-outline-dark" href="https://wa.me/917844819819">WhatsApp Us</a>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="console-section-head left">
                    <p class="console-eyebrow">Send an enquiry</p>
                    <h2>Tell Us About Your Case</h2>
                    <p>The more detail you share, the faster we can point you to the right next step.</p>
                </div>

                <div class="row g-4 align-items-start">
                    <div class="col-lg-7">
                        <div class="console-tool-panel">
                            <div class="console-tool-panel-bar"><span class="dot"></span><span class="dot"></span><span class="dot"></span><span class="path">contact / new-enquiry</span></div>
                            <div class="console-tool-panel-body">
                                <form action="mail-handler.php" method="POST" id="contactConsoleForm">
                                    <div class="console-field-row">
                                        <div class="console-field"><label for="ctName">Your name</label><input id="ctName" name="name" type="text" placeholder="Full name" required></div>
                                        <div class="console-field"><label for="ctPhone">Phone</label><input id="ctPhone" name="phone" type="tel" placeholder="+91"></div>
                                    </div>
                                    <div class="console-field-row">
                                        <div class="console-field"><label for="ctEmail">Email</label><input id="ctEmail" name="email" type="email" placeholder="you@example.com" required></div>
                                        <div class="console-field">
                                            <label for="ctService">What do you need help with?</label>
                                            <select id="ctService" name="service">
                                                <option>Tourist Visa</option>
                                                <option>Business Visa</option>
                                                <option>Work Visa</option>
                                                <option>Family Visa</option>
                                                <option>Medical Visa</option>
                                                <option>Transit Visa</option>
                                                <option>Apostille &amp; Attestation</option>
                                                <option>Visa Refusal Review</option>
                                                <option>Something else</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="console-field" style="margin-bottom:18px;">
                                        <label for="ctMessage">Your message</label>
                                        <textarea id="ctMessage" name="message" rows="4" placeholder="Tell us your destination, travel dates and any specific questions&hellip;" required></textarea>
                                    </div>
                                    <button type="submit" class="console-btn console-btn-primary">Send Message</button>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-5">
                        <div class="console-tool-panel">
                            <div class="console-tool-panel-bar"><span class="dot"></span><span class="dot"></span><span class="dot"></span><span class="path">contact / office-details</span></div>
                            <div class="console-tool-panel-body" style="display:grid; gap:20px;">
                                <div>
                                    <p style="font-family:monospace; font-size:11px; text-transform:uppercase; letter-spacing:0.08em; color:var(--text); margin:0 0 6px;">Office</p>
                                    <p style="margin:0; font-size:14.5px;">#302, Sharda Mansion Apartment,<br>Kailash Puri, Hanuman Nagar,<br>Patna, Bihar 800020</p>
                                </div>
                                <div>
                                    <p style="font-family:monospace; font-size:11px; text-transform:uppercase; letter-spacing:0.08em; color:var(--text); margin:0 0 6px;">Phone</p>
                                    <p style="margin:0; font-size:14.5px;"><a href="tel:+917844819819">+91 78448 19819</a></p>
                                </div>
                                <div>
                                    <p style="font-family:monospace; font-size:11px; text-transform:uppercase; letter-spacing:0.08em; color:var(--text); margin:0 0 6px;">Email</p>
                                    <p style="margin:0; font-size:14.5px;"><a href="mailto:info@visaagency.in">info@visaagency.in</a></p>
                                </div>
                                <div>
                                    <p style="font-family:monospace; font-size:11px; text-transform:uppercase; letter-spacing:0.08em; color:var(--text); margin:0 0 6px;">Hours</p>
                                    <p style="margin:0; font-size:14.5px;">Monday &ndash; Friday, 9:00 AM &ndash; 5:00 PM</p>
                                </div>
                                <div>
                                    <p style="font-family:monospace; font-size:11px; text-transform:uppercase; letter-spacing:0.08em; color:var(--text); margin:0 0 6px;">Cities we serve</p>
                                    <div class="console-chip-toggle-row" style="gap:6px;">
                                        <span class="console-chip-toggle" style="cursor:default;">Patna</span>
                                        <span class="console-chip-toggle" style="cursor:default;">Ranchi</span>
                                        <span class="console-chip-toggle" style="cursor:default;">Raipur</span>
                                        <span class="console-chip-toggle" style="cursor:default;">Bhopal</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="console-section-head">
                    <p class="console-eyebrow">Other ways to reach us</p>
                    <h2>Pick What's Easiest For You</h2>
                </div>
                <div class="console-card-grid">
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="5" width="18" height="16" rx="1.5"/><path d="M16 3v4M8 3v4M3 10h18"/></svg></div>
                        <h3>Book an appointment</h3>
                        <p>Pick a specific date and time for an in-person or phone consultation.</p>
                        <a class="tcard-link" href="visa-appointment">Open scheduler &rarr;</a>
                    </div>
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M21 11.5a8.4 8.4 0 0 1-1 4 8.5 8.5 0 0 1-7.5 4.5 8.4 8.4 0 0 1-4-1L3 21l2-5.5a8.4 8.4 0 0 1-1-4 8.5 8.5 0 0 1 4.5-7.5 8.4 8.4 0 0 1 4-1h.5A8.5 8.5 0 0 1 21 11v.5z"/></svg></div>
                        <h3>WhatsApp</h3>
                        <p>Send a message directly for a quick response during office hours.</p>
                        <a class="tcard-link" href="https://wa.me/917844819819">Message us &rarr;</a>
                    </div>
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><path d="M8 12l2.5 2.5L16 9"/></svg></div>
                        <h3>Visa FAQs</h3>
                        <p>Check if your question is already answered before reaching out.</p>
                        <a class="tcard-link" href="/#faq">Browse FAQs &rarr;</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- Map-section Start -->
        <div class="map-section section-padding pt-0">
            <div class="map-items">
                <div class="googpemap map-fixed-size">
                    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3598.438531084284!2d85.15988777456785!3d25.590340277459994!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x39ed597c852dfc31%3A0x21f24bd0607f87d0!2sVisa%20Agency!5e0!3m2!1sen!2sin!4v1787104153782!5m2!1sen!2sin" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="strict-origin-when-cross-origin"></iframe>
                </div>
            </div>
        </div>

<script>
(function(){
  var form = document.getElementById('contactConsoleForm');
  form.addEventListener('submit', function(){
    var service = document.getElementById('ctService').value;
    var message = document.getElementById('ctMessage');
    message.value = 'Enquiry type: ' + service + '\n\n' + message.value;
  });
})();
</script>

<?php include __DIR__ . '/includes/footer.php'; ?>
