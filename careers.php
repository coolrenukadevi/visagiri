<?php
$page_title = "Careers &ndash; Visa Agency";
$page_description = "Careers at Visa Agency. Explore open positions and submit your resume.";
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

        <section class="contact-section-3 section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Join Us</span>
                    <h2 class="split-text-right split-text-in-right">Careers at Visa Agency</h2>
                </div>
                <p class="text text-center mb-5" style="max-width:720px;margin-left:auto;margin-right:auto;">
                    We're a small, growing technology-enabled visa consultancy based in Patna. There are no open
                    positions listed right now, but we're always glad to hear from people who share our focus on
                    professional visa assistance and customer-first service.
                </p>
                <div class="contact-from-wrapper" style="max-width:720px;margin:0 auto;">
                    <h5 class="text-center">Submit Your Resume</h5>
                    <form action="mail-handler.php" method="POST" class="contact-form-items">
                        <div class="row g-4">
                            <div class="col-lg-6">
                                <div class="form-clt">
                                    <span>Your Name</span>
                                    <input type="text" name="name" placeholder="Your name" required>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="form-clt">
                                    <span>Your Email</span>
                                    <input type="email" name="email" placeholder="Your email" required>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="form-clt">
                                    <span>Position of Interest</span>
                                    <input type="text" name="position" placeholder="e.g. Visa Consultant">
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="form-clt">
                                    <span>Phone</span>
                                    <input type="text" name="phone" placeholder="Phone Number">
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <div class="form-clt">
                                    <textarea name="message" placeholder="Tell us about yourself"></textarea>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <button type="submit" class="theme-btn style-2">
                                    Submit
                                    <i class="fa-solid fa-arrow-right"></i>
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
