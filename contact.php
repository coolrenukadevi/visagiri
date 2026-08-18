<?php
$page_title = "Contact Us &ndash; Visa Agency";
$page_description = "Get in touch with Visa Agency for tourist, student, business and work visa assistance.";
include __DIR__ . '/includes/header.php';
?>
        <!-- Search Area Start -->
        <div class="search-popup">
            <div class="search-popup__overlay search-toggler"></div>
            <div class="search-popup__content">
                <form role="search" method="get" class="search-popup__form" action="#">
                    <input type="text" id="search" name="search" placeholder="Search Here...">
                    <button type="submit" aria-label="search submit" class="search-btn">
                        <span><i class="fa-regular fa-magnifying-glass"></i></span>
                    </button>
                </form>
            </div>
        </div>
        
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">CONTACT uS</h1>
                    <ul class="breadcrumb-list">
                        <li>
                            <a href="index.php">Home</a>
                        </li>
                        <li>
                            <i class="fa-solid fa-chevron-right"></i>
                        </li>
                        <li>
                          Contact Us
                        </li>
                    </ul>
                </div>
            </div>
        </section>

      <!--Error Section Start -->
       <section class="contact-us-section-3 section-padding fix">
        <div class="container">
            <div class="row g-4">
                <div class="col-xl-4 col-lg-6 col-md-6">
                    <div class="contact-icon-item">
                        <div class="icon">
                            <i class="fa-solid fa-location-dot"></i>
                        </div>
                        <div class="content">
                            <p>Location</p>
                            <h6>
                                #302, Sharda Mansion Apartment, Kailash Puri, <br> Hanuman Nagar, Patna, Bihar 800020
                            </h6>
                        </div>
                    </div>
                </div>
                <div class="col-xl-4 col-lg-6 col-md-6">
                    <div class="contact-icon-item">
                        <div class="icon">
                           <i class="fa-solid fa-envelope"></i>
                        </div>
                        <div class="content">
                            <p>Email Address</p>
                            <h6>
                                <a href="mailto:info@visaagency.in">info@visaagency.in</a>
                            </h6>
                        </div>
                    </div>
                </div>
                 <div class="col-xl-4 col-lg-6 col-md-6">
                    <div class="contact-icon-item">
                        <div class="icon">
                           <i class="fa-solid fa-phone"></i>
                        </div>
                        <div class="content">
                            <p>Phone Number</p>
                            <h6>
                                 <a href="tel:+917844819819">+91 78448 19819</a>
                            </h6>
                        </div>
                    </div>
                </div>
            </div>
        </div>
       </section>

        <!--Contact Section3 Start -->
        <section class="contact-section-3 section-padding fix pt-0">
            <div class="container">
                <div class="contact-from-wrapper">
                    <h5 class="text-center">Send Us Message</h5>
                    <p class="text-center mt-3 mb-5">"Have questions about visas or immigration? Send us a message today and our expert team will respond quickly."</p>
                    <div class="row g-4">
                        <div class="col-xl-12">
                             <form action="mail-handler.php" id="contact-form1" method="POST" class="contact-form-items">
                                <div class="row g-4">
                                    <div class="col-lg-4">
                                        <div class="form-clt">
                                            <span>Your Name</span>
                                            <input type="text" name="name" id="name331" placeholder="Your name">
                                        </div>
                                    </div>
                                    <div class="col-lg-4">
                                        <div class="form-clt">
                                            <span>Your Email</span>
                                            <input type="text" name="name" id="email11" placeholder="Your email">
                                        </div>
                                    </div>
                                    <div class="col-lg-4">
                                        <div class="form-clt">
                                            <span>Your Phone</span>
                                            <input type="text" name="name" id="name22" placeholder="Phone Number">
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-clt">
                                            <span>Your Address</span>
                                            <input type="text" name="name" id="name24" placeholder="Address Now">
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-clt">
                                            <span>Your Date</span>
                                            <input type="text" name="name" id="name25" placeholder="Date">
                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="form-clt">
                                            <textarea name="message" id="message1" placeholder="Type your message"></textarea>
                                        </div>
                                    </div>
                                    <div class="col-lg-4">
                                        <button type="submit" class="theme-btn style-2">
                                       SEND MESSAGE
                                            <i class="fa-solid fa-arrow-right"></i>
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>

           <!-- Map-section Start -->
        <div class="map-section section-padding pt-0">
            <div class="map-items">
                <div class="googpemap">
                    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d6678.7619084840835!2d144.9618311901502!3d-37.81450084255415!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x6ad642b4758afc1d%3A0x3119cc820fdfc62e!2sEnvato!5e0!3m2!1sen!2sbd!4v1641984054261!5m2!1sen!2sbd" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
                </div>
            </div>
        </div>

         <!--Footer Section Start -->
<?php include __DIR__ . '/includes/footer.php'; ?>
