<?php
$page_title = "Visa Agency &ndash; Trusted Visa Consultant in Patna, Ranchi, Raipur & Bhopal";
$page_description = "Visa Agency is a Ministry of Tourism recognised visa consultancy offering fast, reliable and hassle-free visa solutions in Patna, Ranchi, Raipur and Bhopal.";
include __DIR__ . '/includes/header-home.php';
?>
        <!--Hero Section Start -->
        <section class="hero-section hero-2 va-hero fix">
            <div class="va-hero-glow"></div>
            <div class="container-fluid">
                <div class="row g-4 align-items-center">
                    <div class="col-lg-6 order-2 order-lg-1">
                        <div class="hero-image va-hero-image">
                            <img src="assets/img/home-2/hero/hero-illustration.svg" alt="Passport, boarding pass and visa approval illustration">
                        </div>
                    </div>
                    <div class="col-lg-6 order-1 order-lg-2">
                        <div class="hero-content">
                            <h6 class="wow fadeInUp" data-wow-delay=".3s">Smart Visa Assistance. Human Expertise.</h6>
                            <h1 class="split-text-right split-text-in-right">
                                Your Visa Journey, Simplified.
                            </h1>
                            <p>
                                Smart visa assistance powered by technology and backed by experienced consultants —
                                from application to approval, across 20+ destinations.
                            </p>
                            <div class="hero-button wow fadeInUp" data-wow-delay=".5s">
                                <a href="#visa-search" class="theme-btn">
                                Check Visa Requirements
                                    <i class="fa-solid fa-arrow-right"></i>
                                </a>
                                <a href="contact" class="theme-btn style-2">
                                    Talk to a Consultant
                                    <i class="fa-solid fa-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Visa Search Widget Start -->
        <section id="visa-search" class="visa-search-section">
            <div class="container">
                <div class="visa-search-widget">
                    <div class="vsw-title">Find Your Visa Requirements</div>
                    <div class="vsw-sub">Tell us where you're travelling and we'll guide you through the visa process.</div>
                    <form id="visa-search-form" class="vsw-grid">
                        <div class="vsw-field">
                            <label for="vsw-country">Where are you travelling?</label>
                            <select id="vsw-country" required>
                                <option value="">Search country</option>
                                <?php require_once __DIR__ . '/includes/countries-data.php'; ?>
                                <?php foreach ($VISA_AGENCY_COUNTRIES as $c): ?>
                                <option value="<?php echo htmlspecialchars($c['name']); ?>"><?php echo $c['flag'] . ' ' . htmlspecialchars($c['name']); ?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                        <div class="vsw-field">
                            <label for="vsw-purpose">Purpose of Travel</label>
                            <select id="vsw-purpose">
                                <option>Tourism</option>
                                <option>Business</option>
                                <option>Visit Family/Friends</option>
                                <option>Medical</option>
                                <option>Work</option>
                                <option>Transit</option>
                                <option>Other</option>
                            </select>
                        </div>
                        <div class="vsw-field">
                            <label for="vsw-passport">Passport Country</label>
                            <select id="vsw-passport">
                                <option>India 🇮🇳</option>
                            </select>
                        </div>
                        <div class="vsw-field">
                            <label for="vsw-name">Your Mobile Number</label>
                            <input type="tel" id="vsw-name" placeholder="10-digit mobile number" pattern="[6-9][0-9]{9}" maxlength="10">
                        </div>
                        <button type="submit" class="vsw-submit">Check Visa Requirements</button>
                    </form>
                    <div id="vsw-result" class="vsw-result"></div>
                </div>
            </div>
        </section>

        <!-- Trust Strip Start -->
        <section class="trust-strip">
            <div class="container">
                <div class="trust-strip-inner">
                    <div class="trust-item"><i class="fa-solid fa-user-tie"></i> Professional Assistance</div>
                    <div class="trust-item"><i class="fa-solid fa-earth-asia"></i> 20+ Countries Covered</div>
                    <div class="trust-item"><i class="fa-solid fa-shield-alt"></i> Digital Document Guidance</div>
                    <div class="trust-item"><i class="fa-solid fa-headset"></i> Customer Support</div>
                    <div class="trust-item"><i class="fa-solid fa-microchip"></i> Technology Enabled</div>
                </div>
            </div>
        </section>

       <!-- Service Section Start -->
       <section class="service-section-2 section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title wow fadeInUp">Services We Provide</span>
                    <h2 class="split-text-right split-text-in-right">
                       Explore Our Visa Assistance
                    </h2>
                </div>
                <div class="service-wrapper-2">
                    <div class="swiper service-slider">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide">
                                <div class="service-box-item">
                                    <div class="service-image">
                                        <img src="assets/img/home-2/service.jpg" alt="img">
                                    </div>
                                    <h2>01</h2>
                                    <h3>
                                        <a href="service-details">Tourist Visa <br> Assistance</a>
                                    </h3>
                                </div>
                            </div>
                            <div class="swiper-slide">
                                <div class="service-box-item">
                                    <div class="service-image">
                                        <img src="assets/img/home-2/service.jpg" alt="img">
                                    </div>
                                    <h2>02</h2>
                                    <h3>
                                        <a href="service-details">Family Visit <br> Visa</a>
                                    </h3>
                                </div>
                            </div>
                            <div class="swiper-slide">
                                <div class="service-box-item">
                                    <div class="service-image">
                                        <img src="assets/img/home-2/service.jpg" alt="img">
                                    </div>
                                    <h2>03</h2>
                                    <h3>
                                        <a href="service-details">Business Visa <br> Services</a>
                                    </h3>
                                </div>
                            </div>
                            <div class="swiper-slide">
                                <div class="service-box-item">
                                    <div class="service-image">
                                        <img src="assets/img/home-2/service.jpg" alt="img">
                                    </div>
                                    <h2>04</h2>
                                    <h3>
                                        <a href="service-details">Work Visa  <br> Consulting</a>
                                    </h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="service-bottom">
                    <div class="service-pagi-items">
                        <div class="service-dot"></div>
                    </div>
                    <div class="array-buttons-3">
                        <button class="array-prev"><i class="fa-solid fa-arrow-left"></i></button>
                        <button class="array-next"><i class="fa-solid fa-arrow-right"></i></button>
                    </div>
                </div>
            </div>
       </section>

       <!-- Feature Section Start -->
       <section class="feature-section section-padding fix section-bg-1">
            <div class="container">
                <div class="feature-wrapper-2">
                    <div class="row g-4">
                        <div class="col-lg-6">
                            <div class="feature-image tp-clip-anim p-relative">
                                <img src="assets/img/home-2/feature/01.png" alt="img" class="tp-anim-img" data-animate="true">
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="feature-content">
                                <div class="section-title mb-0">
                                    <span class="sub-title-2 wow fadeInUp">Who We Are</span>
                                    <h2 class="split-text-right split-text-in-right">
                                        Trusted Guidance for Every Visa Journey
                                    </h2>
                                </div>
                                <p class="text">
                                    We provide expert guidance for every visa application, ensuring smooth processing, personalized support, and reliable assistance to make your travel experience seamless and stress-free.”
                                </p>
                                <div class="feature-count">
                                    <div class="content">
                                        <div class="count-image">
                                            <img src="assets/img/home-2/feature/Years.png" alt="img">
                                        </div>
                                        <h5>Years of Experience</h5>
                                    </div>
                                    <ul class="list">
                                        <li>
                                            <i class="fa-solid fa-chevrons-right"></i>
                                            Experienced Visa Consultants
                                        </li>
                                        <li>
                                            <i class="fa-solid fa-chevrons-right"></i>
                                            Fast & Reliable Processing
                                        </li>
                                        <li>
                                            <i class="fa-solid fa-chevrons-right"></i>
                                            Personalized Travel Assistance
                                        </li>
                                        <li>
                                            <i class="fa-solid fa-chevrons-right"></i>
                                            Global Reach and Support
                                        </li>
                                    </ul>
                                </div>
                                <a href="contact" class="theme-btn">
                                    Get Your Visa
                                    <i class="fa-solid fa-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
       </section>

       <!-- Choose-us-section-2 Start -->
       <section class="choose-us-section-2 section-padding fix bg-cover" style="background-image: url(assets/img/home-2/feature/bg-shape.png);">
            <div class="container">
                <div class="choose-us-wrapper-2">
                    <div class="row g-4">
                        <div class="col-lg-6">
                            <div class="feature-content">
                                 <div class="section-title mb-0">
                                    <span class="sub-title-2 wow fadeInUp">Your Travel Made Easy</span>
                                    <h2 class="split-text-right split-text-in-right">
                                        Smooth Visa Journey Guaranteed
                                    </h2>
                                </div>
                                <p class="text">
                                    We provide expert guidance for every visa application, ensuring smooth processing, personalized support, and reliable assistance 
                                </p>
                                <div class="choose-us-box">
                                    <div class="icon">
                                        <img src="assets/img/home-2/icon/01.png" alt="img">
                                    </div>
                                    <div class="content">
                                        <h5>Expert Consultants</h5>
                                        <p>
                                            Skilled and knowledgeable visa advisors. Skilled and knowled geable visa advisors.
                                        </p>
                                    </div>
                                </div>
                                <div class="choose-us-box">
                                    <div class="icon">
                                        <img src="assets/img/home-2/icon/01.png" alt="img">
                                    </div>
                                    <div class="content">
                                        <h5>Personalized Support</h5>
                                        <p>
                                            Skilled and knowledgeable visa advisors. Skilled and knowled geable visa advisors.
                                        </p>
                                    </div>
                                </div>
                                <div class="choose-us-box">
                                    <div class="icon">
                                        <img src="assets/img/home-2/icon/01.png" alt="img">
                                    </div>
                                    <div class="content">
                                        <h5>Transparent Process</h5>
                                        <p>
                                            Skilled and knowledgeable visa advisors. Skilled and knowled geable visa advisors.
                                        </p>
                                    </div>
                                </div>
                                 <a href="contact" class="theme-btn">
                                    Get Started Today
                                    <i class="fa-solid fa-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="choose-us-image tp-clip-anim p-relative">
                                <img src="assets/img/home-2/feature/02.png" alt="img" class="tp-anim-img" data-animate="true">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
       </section>

        <!-- How It Works Start -->
        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title wow fadeInUp">The Process</span>
                    <h2 class="split-text-right split-text-in-right">How It Works</h2>
                </div>
                <div class="how-it-works-steps">
                    <div class="how-it-works-step">
                        <div class="step-num">1</div>
                        <h4>Choose Destination</h4>
                        <p>Tell us where you're travelling and why.</p>
                    </div>
                    <div class="how-it-works-step">
                        <div class="step-num">2</div>
                        <h4>Check Requirements</h4>
                        <p>See the visa category and a sample document checklist.</p>
                    </div>
                    <div class="how-it-works-step">
                        <div class="step-num">3</div>
                        <h4>Submit Documents</h4>
                        <p>Share your documents with our consultants for review.</p>
                    </div>
                    <div class="how-it-works-step">
                        <div class="step-num">4</div>
                        <h4>Expert Review</h4>
                        <p>Our consultants verify your application for accuracy.</p>
                    </div>
                    <div class="how-it-works-step">
                        <div class="step-num">5</div>
                        <h4>Application Support</h4>
                        <p>We guide you through appointment and submission steps.</p>
                    </div>
                    <div class="how-it-works-step">
                        <div class="step-num">6</div>
                        <h4>Track Progress</h4>
                        <p>Stay updated at every stage of your application.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Document Checklist Widget Start -->
        <section id="checklist" class="section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Get Prepared</span>
                    <h2 class="split-text-right split-text-in-right">Visa Document Checklist</h2>
                </div>
                <div class="checklist-widget">
                    <form id="checklist-form" class="checklist-controls">
                        <select id="cl-country" required>
                            <option value="">Select Country</option>
                            <?php foreach ($VISA_AGENCY_COUNTRIES as $c): ?>
                            <option value="<?php echo htmlspecialchars($c['name']); ?>"><?php echo $c['flag'] . ' ' . htmlspecialchars($c['name']); ?></option>
                            <?php endforeach; ?>
                        </select>
                        <select id="cl-visa-type">
                            <option value="tourist">Tourist Visa</option>
                            <option value="business">Business Visa</option>
                            <option value="work">Work Visa</option>
                            <option value="family">Family Visa</option>
                            <option value="transit">Transit Visa</option>
                            <option value="medical">Medical Visa</option>
                        </select>
                        <select id="cl-profile">
                            <option>Indian Passport</option>
                            <option>NRI / Foreign Resident</option>
                            <option>First-time Applicant</option>
                            <option>Previous Visa Holder</option>
                        </select>
                        <button type="submit">Create My Checklist</button>
                    </form>
                    <div id="checklist-output" class="checklist-output">
                        <h4 id="checklist-heading">Your Checklist</h4>
                        <ul id="checklist-items" class="checklist-items"></ul>
                        <div class="checklist-actions">
                            <a href="contact"><i class="fa-solid fa-paper-plane"></i> Start Enquiry</a>
                            <a href="https://wa.me/917844819819" target="_blank" rel="noopener"><i class="fa-brands fa-whatsapp"></i> Send on WhatsApp</a>
                            <button type="button" onclick="window.print()"><i class="fa-solid fa-download"></i> Download / Print</button>
                        </div>
                    </div>
                </div>
            </div>
        </section>

       <!-- Visa-provide-section-2 Start -->
       <section class="visa-provide-section section-padding fix header-bg">
           <div class="container">
              <div class="section-title text-center">
                    <span class="sub-title-2 theme">Services We Provide</span>
                    <h2 class="text-white">
                       Explore Our Visa Assistance
                    </h2>
                </div>
           </div>
           <div class="swiper visa-slider">
            <div class="swiper-wrapper">
                <div class="swiper-slide">
                    <div class="visa-provide-box">
                        <div class="visa-top-item">
                            <div class="visa-left">
                                <div class="icon">
                                    <img src="assets/img/home-2/visa/01.png" alt="img">
                                </div>
                                <div class="content">
                                    <p>Visa Service</p>
                                    <h3>
                                        <a href="country-details">Japan</a>
                                    </h3>
                                </div>
                            </div>
                            <a href="country-details" class="theme-btn">
                                Read More
                                <i class="fa-solid fa-arrow-right"></i>
                            </a>
                        </div>
                        <div class="visa-list-item">
                            <ul class="list">
                                <li>
                                    <i class="fa-regular fa-arrow-right"></i>
                                    Family Visit Visa Assistance
                                </li>
                                <li>
                                    <i class="fa-regular fa-arrow-right"></i>
                                    Work Visa – H1B
                                </li>
                            </ul>
                            <ul class="list">
                                <li>
                                    <i class="fa-regular fa-arrow-right"></i>
                                    Work permit for Canada
                                </li>
                                <li>
                                    <i class="fa-regular fa-arrow-right"></i>
                                    Work Visa for Canada
                                </li>
                            </ul>
                        </div>
                </div>
                </div>
                <div class="swiper-slide">
                    <div class="visa-provide-box">
                        <div class="visa-top-item">
                            <div class="visa-left">
                                <div class="icon">
                                    <img src="assets/img/home-2/visa/01.png" alt="img">
                                </div>
                                <div class="content">
                                    <p>Visa Service</p>
                                    <h3>
                                        <a href="country-details">Japan</a>
                                    </h3>
                                </div>
                            </div>
                            <a href="country-details" class="theme-btn">
                                Read More
                                <i class="fa-solid fa-arrow-right"></i>
                            </a>
                        </div>
                        <div class="visa-list-item">
                            <ul class="list">
                                <li>
                                    <i class="fa-regular fa-arrow-right"></i>
                                    Family Visit Visa Assistance
                                </li>
                                <li>
                                    <i class="fa-regular fa-arrow-right"></i>
                                    Work Visa – H1B
                                </li>
                            </ul>
                            <ul class="list">
                                <li>
                                    <i class="fa-regular fa-arrow-right"></i>
                                    Work permit for Canada
                                </li>
                                <li>
                                    <i class="fa-regular fa-arrow-right"></i>
                                    Work Visa for Canada
                                </li>
                            </ul>
                        </div>
                </div>
                </div>
                <div class="swiper-slide">
                    <div class="visa-provide-box">
                        <div class="visa-top-item">
                            <div class="visa-left">
                                <div class="icon">
                                    <img src="assets/img/home-2/visa/02.png" alt="img">
                                </div>
                                <div class="content">
                                    <p>Visa Service</p>
                                    <h3>
                                        <a href="country-details">Canada</a>
                                    </h3>
                                </div>
                            </div>
                            <a href="country-details" class="theme-btn">
                                Read More
                                <i class="fa-solid fa-arrow-right"></i>
                            </a>
                        </div>
                        <div class="visa-list-item">
                            <ul class="list">
                                <li>
                                    <i class="fa-regular fa-arrow-right"></i>
                                    Family Visit Visa Assistance
                                </li>
                                <li>
                                    <i class="fa-regular fa-arrow-right"></i>
                                    Work Visa – H1B
                                </li>
                            </ul>
                            <ul class="list">
                                <li>
                                    <i class="fa-regular fa-arrow-right"></i>
                                    Work permit for Canada
                                </li>
                                <li>
                                    <i class="fa-regular fa-arrow-right"></i>
                                    Work Visa for Canada
                                </li>
                            </ul>
                        </div>
                   </div>
                </div>
                <div class="swiper-slide">
                   <div class="visa-provide-box">
                        <div class="visa-top-item">
                            <div class="visa-left">
                                <div class="icon">
                                    <img src="assets/img/home-2/visa/03.png" alt="img">
                                </div>
                                <div class="content">
                                    <p>Visa Service</p>
                                    <h3>
                                        <a href="country-details">France</a>
                                    </h3>
                                </div>
                            </div>
                            <a href="country-details" class="theme-btn">
                                Read More
                                <i class="fa-solid fa-arrow-right"></i>
                            </a>
                        </div>
                        <div class="visa-list-item">
                            <ul class="list">
                                <li>
                                    <i class="fa-regular fa-arrow-right"></i>
                                    Family Visit Visa Assistance
                                </li>
                                <li>
                                    <i class="fa-regular fa-arrow-right"></i>
                                    Work Visa – H1B
                                </li>
                            </ul>
                            <ul class="list">
                                <li>
                                    <i class="fa-regular fa-arrow-right"></i>
                                    Work permit for Canada
                                </li>
                                <li>
                                    <i class="fa-regular fa-arrow-right"></i>
                                    Work Visa for Canada
                                </li>
                            </ul>
                        </div>
                   </div>
                </div>
            </div>
           </div>
           <div class="visa-bottom">
              <div class="container">
                  <div class="visa-arrow-item">
                      <button class="array-prev">
                        <i class="fa-solid fa-arrow-left"></i>
                    </button>
                    <div class="flag-item">
                        <div class="flag-thumb">
                            <img src="assets/img/home-2/visa/04.png" alt="img">
                            <div class="country-name">
                                <h4>bangladesh</h4>
                            </div>
                        </div>
                        <div class="flag-thumb">
                            <img src="assets/img/home-2/visa/05.png" alt="img">
                            <div class="country-name">
                                <h4>Usa</h4>
                            </div>
                        </div>
                        <div class="flag-thumb">
                            <img src="assets/img/home-2/visa/06.png" alt="img">
                            <div class="country-name">
                                <h4>Rwanda</h4>
                            </div>
                        </div>
                        <div class="flag-thumb">
                            <img src="assets/img/home-2/visa/07.png" alt="img">
                            <div class="country-name">
                                <h4>Kanada</h4>
                            </div>
                        </div>
                        <div class="flag-thumb">
                            <img src="assets/img/home-2/visa/08.png" alt="img">
                            <div class="country-name">
                                <h4>australia</h4>
                            </div>
                        </div>
                        <div class="flag-thumb">
                            <img src="assets/img/home-2/visa/09.png" alt="img">
                            <div class="country-name">
                                <h4>Netherlands</h4>
                            </div>
                        </div>
                        <div class="flag-thumb">
                            <img src="assets/img/home-2/visa/10.png" alt="img">
                            <div class="country-name">
                                <h4>Germany</h4>
                            </div>
                        </div>
                    </div>
                    <button class="array-next">
                        <i class="fa-solid fa-arrow-right"></i>
                    </button>
                  </div>
              </div>
           </div>
       </section>

        <!-- Apostille Services Start -->
        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="row align-items-center g-4">
                    <div class="col-lg-6">
                        <div class="section-title mb-3">
                            <span class="sub-title-2 wow fadeInUp">Document Legalisation</span>
                            <h2 class="split-text-right split-text-in-right">Apostille &amp; Attestation Services</h2>
                        </div>
                        <p class="text">
                            Beyond visas, we help you get your documents ready for use abroad — apostille, embassy
                            attestation, certificate attestation and translation, handled with the same
                            technology-enabled, transparent process.
                        </p>
                        <div class="how-it-works-steps" style="grid-template-columns:repeat(2,1fr);gap:16px;margin-top:20px;">
                            <div class="trust-item"><i class="fa-solid fa-stamp"></i> MEA Apostille</div>
                            <div class="trust-item"><i class="fa-solid fa-building-columns"></i> Embassy Attestation</div>
                            <div class="trust-item"><i class="fa-solid fa-certificate"></i> Certificate Attestation</div>
                            <div class="trust-item"><i class="fa-solid fa-language"></i> Translation Services</div>
                        </div>
                        <a href="apostille" class="theme-btn mt-4">
                            Explore Apostille Services
                            <i class="fa-solid fa-arrow-right"></i>
                        </a>
                    </div>
                    <div class="col-lg-6">
                        <div class="thumb">
                            <img src="assets/img/inner-page/service-details/details-1.jpg" alt="img" style="border-radius:20px;">
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Country Explorer Start -->
        <section class="section-padding fix country-explorer-section">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title wow fadeInUp">200+ Country Ready</span>
                    <h2 class="split-text-right split-text-in-right">Explore Visa Destinations</h2>
                </div>
                <div class="country-explorer-search">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <input type="text" class="country-nav-search" placeholder="Search country or visa destination...">
                </div>
                <div class="country-explorer-filters country-nav-filters">
                    <button type="button" class="active" data-region="all">All</button>
                    <button type="button" data-region="Asia">Asia</button>
                    <button type="button" data-region="Europe">Europe</button>
                    <button type="button" data-region="North America">North America</button>
                    <button type="button" data-region="Middle East">Middle East</button>
                    <button type="button" data-region="Oceania">Oceania</button>
                </div>
                <div class="country-explorer-grid country-nav-grid">
                    <?php foreach ($VISA_AGENCY_COUNTRIES as $c): ?>
                    <a href="country-list" class="country-chip" data-name="<?php echo strtolower($c['name']); ?>" data-region="<?php echo $c['region']; ?>">
                        <span class="flag"><?php echo $c['flag']; ?></span>
                        <span><?php echo $c['name']; ?></span>
                    </a>
                    <?php endforeach; ?>
                </div>
                <div class="text-center mt-4">
                    <a href="country-list" class="theme-btn style-2">View All Countries</a>
                </div>
            </div>
        </section>

        <!-- Pricing Section Start -->
        <section class="pricing-section-2 section-padding fix section-bg-1">
            <div class="container">
                <div class="pricing-wrapper-2">
                    <div class="row g-4 align-items-center">
                        <div class="col-xl-6 col-lg-5">
                            <div class="pricing-content">
                                <div class="section-title mb-0">
                                    <span class="sub-title-2 wow fadeInUp">pricing plan</span>
                                    <h2 class="split-text-right split-text-in-right">
                                        Flexible Plans to Suit Every Traveler
                                    </h2>
                                </div>
                                <p class="pricing-text wow fadeInUp" data-wow-delay=".5s">
                                    Choose the plan that fits your visa needs and enjoy expert guidance every step of the way.
                                </p>
                                <div class="d-flex mt-3 mt-md-0 wow fadeInUp" data-wow-delay=".5s">
                                    <div class="pricing-two__tab">
                                        <nav>
                                            <div class="nav nav-tabs" id="nav-tab" role="tablist">
                                                <button class="nav-link active" id="pt-1-tab" data-bs-toggle="tab" data-bs-target="#pt-1" type="button" role="tab" aria-controls="pt-1" aria-selected="true">Monthly</button>
                                                <button class="nav-link" id="pt-2-tab" data-bs-toggle="tab" data-bs-target="#pt-2" type="button" role="tab" aria-controls="pt-2" aria-selected="false" tabindex="-1">Yearly</button>
                                            </div>
                                        </nav>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-6 col-lg-7">
                            <div class="pricing__tab-content">
                                <div class="tab-content" id="nav-tabContent">
                                    <div class="tab-pane fade active show" id="pt-1" role="tabpanel" aria-labelledby="pt-1-tab">
                                        <div class="pricing-right-items">
                                            <div class="pricing-box-items">
                                                <div class="pricing-header">
                                                    <h2>
                                                        <sup>$</sup>
                                                        32
                                                        <sub>/mo</sub>
                                                    </h2>
                                                    <span class="sub-texts">Basic Plan</span>
                                                </div>
                                                <a href="pricing" class="theme-btn">
                                                    Get Started Today
                                                    <i class="fa-solid fa-arrow-right"></i>
                                                </a>
                                                <ul class="pricing-list">
                                                    <li><i class="fa-solid fa-chevrons-right"></i> Everything in Basic Plan</li>
                                                    <li><i class="fa-solid fa-chevrons-right"></i> Visa Interview Preparation</li>
                                                    <li>
                                                        <i class="fa-solid fa-chevrons-right"></i> Priority Processing Support
                                                    </li>
                                                    <li><i class="fa-solid fa-chevrons-right"></i> Phone & Email Assistance</li>
                                                    <li><i class="fa-solid fa-chevrons-right"></i> Step-by-Step Application Support</li>
                                                </ul>
                                            </div>
                                            <div class="pricing-box-items style-2">
                                                <div class="pricing-header">
                                                    <h2>
                                                        <sup>$</sup>
                                                        32
                                                        <sub>/mo</sub>
                                                    </h2>
                                                    <span class="sub-texts">Premium Plan</span>
                                                </div>
                                                <a href="pricing" class="theme-btn style-2">
                                                    Get Started Today
                                                    <i class="fa-solid fa-arrow-right"></i>
                                                </a>
                                                 <ul class="pricing-list">
                                                    <li><i class="fa-solid fa-chevrons-right"></i> Everything in Basic Plan</li>
                                                    <li><i class="fa-solid fa-chevrons-right"></i> Visa Interview Preparation</li>
                                                    <li>
                                                        <i class="fa-solid fa-chevrons-right"></i> Priority Processing Support
                                                    </li>
                                                    <li><i class="fa-solid fa-chevrons-right"></i> Phone & Email Assistance</li>
                                                    <li><i class="fa-solid fa-chevrons-right"></i> Step-by-Step Application Support</li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="pt-2" role="tabpanel" aria-labelledby="pt-2-tab">
                                        <div class="pricing-right-items">
                                            <div class="pricing-box-items">
                                                <div class="pricing-header">
                                                    <h2>
                                                        <sup>$</sup>
                                                        32
                                                        <sub>/mo</sub>
                                                    </h2>
                                                    <span class="sub-texts">Basic Plan</span>
                                                </div>
                                                <a href="pricing" class="theme-btn">
                                                    Get Started Today
                                                    <i class="fa-solid fa-arrow-right"></i>
                                                </a>
                                                <ul class="pricing-list">
                                                    <li><i class="fa-solid fa-chevrons-right"></i> Everything in Basic Plan</li>
                                                    <li><i class="fa-solid fa-chevrons-right"></i> Visa Interview Preparation</li>
                                                    <li>
                                                        <i class="fa-solid fa-chevrons-right"></i> Priority Processing Support
                                                    </li>
                                                    <li><i class="fa-solid fa-chevrons-right"></i> Phone & Email Assistance</li>
                                                    <li><i class="fa-solid fa-chevrons-right"></i> Step-by-Step Application Support</li>
                                                </ul>
                                            </div>
                                            <div class="pricing-box-items style-2">
                                                <div class="pricing-header">
                                                    <h2>
                                                        <sup>$</sup>
                                                        32
                                                        <sub>/mo</sub>
                                                    </h2>
                                                    <span class="sub-texts">Premium Plan</span>
                                                </div>
                                                <a href="pricing" class="theme-btn style-2">
                                                    Get Started Today
                                                    <i class="fa-solid fa-arrow-right"></i>
                                                </a>
                                                 <ul class="pricing-list">
                                                    <li><i class="fa-solid fa-chevrons-right"></i> Everything in Basic Plan</li>
                                                    <li><i class="fa-solid fa-chevrons-right"></i> Visa Interview Preparation</li>
                                                    <li>
                                                        <i class="fa-solid fa-chevrons-right"></i> Priority Processing Support
                                                    </li>
                                                    <li><i class="fa-solid fa-chevrons-right"></i> Phone & Email Assistance</li>
                                                    <li><i class="fa-solid fa-chevrons-right"></i> Step-by-Step Application Support</li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Contact-section-2 Start -->
       <section class="contact-section-2 section-padding fix section-padding bg-cover" style="background-image: url(assets/img/home-2/bg.jpg);">
        <div class="container">
            <div class="contact-wrapper-2">
                <div class="contact-from-box">
                    <h3 class="split-text-right split-text-in-right">BOOK AN APPOINTMENT</h3>
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-clt">
                                <div class="form">
                                    <select class="single-select w-100">
                                        <option>Select Country</option>
                                        <option> Australia</option>
                                        <option> Kanada</option>
                                        <option> Russia</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-clt">
                                <div class="form">
                                    <select class="single-select w-100">
                                        <option>Select Service</option>
                                        <option> Tourist Visa</option>
                                        <option> Family Visa</option>
                                        <option> Work Visa</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-clt">
                               <input type="text" name="Name" id="Name2" placeholder="Name">
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-clt">
                                <input type="text" name="Number" id="Number" placeholder="Phone Number">
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-clt">
                                <div class="form">
                                    <select class="single-select w-100">
                                        <option>Select Date</option>
                                        <option> 01</option>
                                        <option> 02</option>
                                        <option> 03</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-clt">
                                <div class="form">
                                    <select class="single-select w-100">
                                        <option>Select Time</option>
                                        <option> 09:00 AM</option>
                                        <option> 09:30 AM</option>
                                        <option> 10:00</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="contact-btn">
                        <button type="submit" class="theme-btn">
                            Contact-Us
                            <i class="fa-solid fa-arrow-right"></i>
                        </button>
                    </div>
                    <h5>Help Line Anytime</h5>
                    <h2> <a href="tel:+917844819819">+91 78448 19819</a></h2>
                    <p>The Support Centre is abailable 24/7</p>
                </div>
                <a href="https://www.youtube.com/watch?v=Cn4G2lZ_g2I" class="video-btn video-popup">
                    <i class="fa-duotone fa-play"></i>
                </a>
            </div>
        </div>
       </section>

       <!-- Testimonial-section-2 Start -->
       <section class="testimonial-section section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2">Why Clients Trust Us</span>
                    <h2 class="split-text-right split-text-in-right">
                        Stories of Successful Journeys
                    </h2>
                </div>
                <div class="testimonial-wrapper-2">
                    <div class="row g-4">
                        <div class="col-lg-5">
                            <div class="testimonial-image image-scale-animation">
                                <img src="assets/img/home-2/testimonial/01.jpg" alt="img" class="image-scale-animation-item">
                            </div>
                        </div>
                        <div class="col-lg-7">
                            <div class="testimonial-item">
                                <div class="swiper testimonial-slider-2">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide">
                                            <div class="testimonial-left">
                                                <div class="testimonial-box">
                                                    <div class="star">
                                                        <i class="fa-solid fa-star"></i>
                                                        <i class="fa-solid fa-star"></i>
                                                        <i class="fa-solid fa-star"></i>
                                                        <i class="fa-solid fa-star"></i>
                                                        <i class="fa-solid fa-star"></i>
                                                    </div>
                                                    <p>
                                                        Excellent service! The team guided me through every step, managed documents perfectly, and ensured my visa approval quickly. Truly reliable and professional consultancy service.”
                                                    </p>
                                                </div>
                                                <div class="info-item">
                                                    <img src="assets/img/home-2/testimonial/client-1.png" alt="img">
                                                    <div class="content">
                                                        <h5>David Lee</h5>
                                                        <span>David Lee</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide">
                                            <div class="testimonial-left">
                                                <div class="testimonial-box">
                                                    <div class="star">
                                                        <i class="fa-solid fa-star"></i>
                                                        <i class="fa-solid fa-star"></i>
                                                        <i class="fa-solid fa-star"></i>
                                                        <i class="fa-solid fa-star"></i>
                                                        <i class="fa-solid fa-star"></i>
                                                    </div>
                                                    <p>
                                                        Excellent service! The team guided me through every step, managed documents perfectly, and ensured my visa approval quickly. Truly reliable and professional consultancy service.”
                                                    </p>
                                                </div>
                                                <div class="info-item">
                                                    <img src="assets/img/home-2/testimonial/client-1.png" alt="img">
                                                    <div class="content">
                                                        <h5>David Lee</h5>
                                                        <span>David Lee</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-slide">
                                            <div class="testimonial-left">
                                                <div class="testimonial-box">
                                                    <div class="star">
                                                        <i class="fa-solid fa-star"></i>
                                                        <i class="fa-solid fa-star"></i>
                                                        <i class="fa-solid fa-star"></i>
                                                        <i class="fa-solid fa-star"></i>
                                                        <i class="fa-solid fa-star"></i>
                                                    </div>
                                                    <p>
                                                        Excellent service! The team guided me through every step, managed documents perfectly, and ensured my visa approval quickly. Truly reliable and professional consultancy service.”
                                                    </p>
                                                </div>
                                                <div class="info-item">
                                                    <img src="assets/img/home-2/testimonial/client-1.png" alt="img">
                                                    <div class="content">
                                                        <h5>David Lee</h5>
                                                        <span>David Lee</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="right-item">
                                    <div class="swiper test-slider">
                                        <div class="swiper-wrapper">
                                            <div class="swiper-slide">
                                                <div class="client-image">
                                                    <img src="assets/img/home-2/testimonial/client-2.png" alt="img">
                                                </div>
                                            </div>
                                            <div class="swiper-slide">
                                                <div class="client-image">
                                                    <img src="assets/img/home-2/testimonial/client-3.jpg" alt="img">
                                                </div>
                                            </div>
                                            <div class="swiper-slide">
                                                <div class="client-image">
                                                    <img src="assets/img/home-2/testimonial/client-4.jpg" alt="img">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
       </section>

        <!-- Visa-Certification-section-2 Start -->
       <section class="visa-certification-section fix section-bg-1">
        <div class="container">
            <div class="visa-certification-wrapper">
                <div class="row g-4 align-items-center">
                    <div class="col-lg-4">
                        <div class="visa-image">
                            <img src="assets/img/home-2/feature/03.png" alt="img">
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="visa-certification-content">
                            <div class="section-title mb-0">
                                <span class="sub-title-2">CERTIFICATION</span>
                                <h2 class="split-text-right split-text-in-right">
                                    Globally Recognized Credentials
                                </h2>
                            </div>
                            <div class="visa-item">
                                <ul class="nav" role="tablist">
                                    <li class="nav-item">
                                        <a href="#technical" data-bs-toggle="tab" class="nav-link" aria-selected="false" role="tab" tabindex="-1">
                                            <i class="fa-regular fa-arrow-right"></i>
                                           British Council
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#work" data-bs-toggle="tab" class="nav-link active" aria-selected="true" role="tab">
                                            <i class="fa-regular fa-arrow-right"></i>
                                            Aus Embassy
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#ambition" data-bs-toggle="tab" class="nav-link" aria-selected="false" role="tab" tabindex="-1">
                                            <i class="fa-regular fa-arrow-right"></i>
                                            UK Embassy
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#skill" data-bs-toggle="tab" class="nav-link" aria-selected="false" role="tab" tabindex="-1">
                                            <i class="fa-regular fa-arrow-right"></i>
                                            USA Embassy
                                        </a>
                                    </li>
                                </ul>
                                <div class="tab-content">
                                    <div id="technical" class="tab-pane fade" role="tabpanel">
                                        <div class="content">
                                            <div class="icon">
                                                <img src="assets/img/home-2/feature/Icon.png" alt="img">
                                            </div>
                                            <h3>
                                                Dedicated to Delivering the Best <br> Visa Services
                                            </h3>
                                            <p>
                                                We provide expert visa guidance, personalized support, and trusted solutions to ensure a smooth, stress-free, and successful travel journey.
                                            </p>
                                            <a href="contact" class="theme-btn">
                                                Get Services
                                                <i class="fa-solid fa-arrow-right"></i>
                                            </a>
                                        </div>
                                    </div>
                                    <div id="work" class="tab-pane fade active show" role="tabpanel">
                                        <div class="content">
                                            <div class="icon">
                                                <img src="assets/img/home-2/feature/Icon.png" alt="img">
                                            </div>
                                            <h3>
                                                Dedicated to Delivering the Best <br> Visa Services
                                            </h3>
                                            <p>
                                                We provide expert visa guidance, personalized support, and trusted solutions to ensure a smooth, stress-free, and successful travel journey.
                                            </p>
                                            <a href="contact" class="theme-btn">
                                                Get Services
                                                <i class="fa-solid fa-arrow-right"></i>
                                            </a>
                                        </div>
                                    </div>
                                    <div id="ambition" class="tab-pane fade" role="tabpanel">
                                        <div class="content">
                                            <div class="icon">
                                                <img src="assets/img/home-2/feature/Icon.png" alt="img">
                                            </div>
                                            <h3>
                                                Dedicated to Delivering the Best <br> Visa Services
                                            </h3>
                                            <p>
                                                We provide expert visa guidance, personalized support, and trusted solutions to ensure a smooth, stress-free, and successful travel journey.
                                            </p>
                                            <a href="contact" class="theme-btn">
                                                Get Services
                                                <i class="fa-solid fa-arrow-right"></i>
                                            </a>
                                        </div>
                                    </div>
                                    <div id="skill" class="tab-pane fade" role="tabpanel">
                                        <div class="content">
                                            <div class="icon">
                                                <img src="assets/img/home-2/feature/Icon.png" alt="img">
                                            </div>
                                            <h3>
                                                Dedicated to Delivering the Best <br> Visa Services
                                            </h3>
                                            <p>
                                                We provide expert visa guidance, personalized support, and trusted solutions to ensure a smooth, stress-free, and successful travel journey.
                                            </p>
                                            <a href="contact" class="theme-btn">
                                                Get Services
                                                <i class="fa-solid fa-arrow-right"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
       </section>

       <!-- News-section-2 Start -->
       <section class="news-section section-padding fix">
        <div class="container">
            <div class="section-title-area">
                 <div class="section-title">
                        <span class="sub-title wow fadeInUp">Visa Tips & Guides</span>
                        <h2 class="split-text-right split-text-in-right">
                           Latest Travel & Visa Insights
                        </h2>
                    </div>
                <a href="news" class="theme-btn">
                    View Article
                    <i class="fa-solid fa-arrow-right"></i>
                </a>
            </div>
            <div class="row">
                <div class="col-xl-12">
                    <div class="news-main-item fade-up-anim">
                        <div class="news-left-content">
                            <h2><sup>25</sup> <span>August,2025</span></h2>
                            <h3>
                                <a href="news-details">
                                    Business Visa vs. Tourist Visa Which One is <br> Right for You?
                                </a>
                            </h3>
                            <div class="news-post">
                                <span>by admin</span>
                                <span>Business Visa</span>
                            </div>
                        </div>
                        <div class="news-right-content">
                            <div class="news-image">
                                <img src="assets/img/home-2/news/01.jpg" alt="img">
                            </div>
                            <div class="content">
                                <p>
                                    Choosing between a business visa and a tourist visa depends on your purpose of travel. Understand the differences, requirements, and opportunities to select the right category for your trip.”
                                </p>
                                <a href="contact" class="theme-btn">
                                    View Article
                                    <i class="fa-solid fa-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="news-main-item fade-up-anim">
                        <div class="news-left-content">
                            <h2><sup>25</sup> <span>August,2025</span></h2>
                            <h3>
                                <a href="news-details">
                                   Common Mistakes Applicants Make <br> During Visa Processing
                                </a>
                            </h3>
                            <div class="news-post">
                                <span>by admin</span>
                                <span>VisaTips</span>
                            </div>
                        </div>
                        <div class="news-right-content">
                            <div class="news-image">
                                <img src="assets/img/home-2/news/02.jpg" alt="img">
                            </div>
                            <div class="content">
                                <p>
                                    Many applicants face delays due to incomplete documents, missed deadlines, or incorrect details. Avoiding these common mistakes ensures a smoother, faster
                                </p>
                                <a href="contact" class="theme-btn">
                                    View Article
                                    <i class="fa-solid fa-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="news-main-item fade-up-anim">
                        <div class="news-left-content">
                            <h2><sup>25</sup> <span>August,2025</span></h2>
                            <h3>
                                <a href="news-details">
                                   Latest Visa Policy Updates Every <br> Traveler Should Know
                                </a>
                            </h3>
                            <div class="news-post">
                                <span>by admin</span>
                                <span>VisaUpdates</span>
                            </div>
                        </div>
                        <div class="news-right-content">
                            <div class="news-image">
                                <img src="assets/img/home-2/news/03.jpg" alt="img">
                            </div>
                            <div class="content">
                                <p>
                                    Stay informed with the latest visa policy updates, including travel restrictions, document requirements, and processing changes, to ensure a smooth, hassle-free journey abroad.
                                </p>
                                <a href="contact" class="theme-btn">
                                    View Article
                                    <i class="fa-solid fa-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
       </section>

        <!-- FAQ Start -->
        <section id="faq" class="section-padding fix section-bg-1">
            <div class="container">
                <div class="row g-5 align-items-start">
                    <div class="col-lg-4">
                        <div class="section-title mb-0">
                            <span class="sub-title-2 wow fadeInUp">Got Questions?</span>
                            <h2 class="split-text-right split-text-in-right">Frequently Asked Questions</h2>
                        </div>
                        <p class="text mt-3">
                            Answers to common questions about visa assistance from Visa Agency. Still have a
                            question? <a href="contact">Talk to a consultant</a>.
                        </p>
                    </div>
                    <div class="col-lg-8">
                        <div class="faq-accordion">
                            <div class="faq-item active">
                                <div class="faq-question">Do you guarantee visa approval? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>No. Visa Agency provides professional guidance, documentation support and application assistance — the final decision always rests with the relevant embassy, consulate or immigration authority.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Which countries do you cover? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>We currently provide guidance for 20+ popular visa destinations across Asia, Europe, North America, the Middle East and Oceania, with plans to expand our coverage further.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Do you offer apostille and attestation services? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Yes. Alongside visa assistance, we help with MEA apostille, embassy attestation, certificate attestation and translation services.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">How do I start my application? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Use the visa search widget above or the "Enquire Now" button to share your travel details — a consultant will get in touch to guide you through the next steps.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Is Visa Agency a technology-enabled consultancy? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Yes. Visa Agency combines experienced visa consultants with a centralised visa search, digital document checklists and online enquiry management to make the process simpler.</p></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Final CTA Start -->
        <section class="section-padding fix">
            <div class="container">
                <div class="final-cta">
                    <h2>Ready to Start Your Visa Journey?</h2>
                    <p>Smart visa assistance, backed by human expertise — talk to a consultant today.</p>
                    <div class="cta-buttons">
                        <a href="#visa-search" class="theme-btn">Check Visa Requirements <i class="fa-solid fa-arrow-right"></i></a>
                        <a href="contact" class="theme-btn style-2">Talk to a Visa Consultant</a>
                    </div>
                </div>
                <p class="compliance-note mt-4">
                    Visa Agency provides visa consultancy and documentation assistance. Visa decisions are made
                    solely by the relevant embassy, consulate, immigration authority or government department.
                    Visa approval is not guaranteed. Requirements, fees and processing times may change without
                    notice. Applicants should verify current requirements before submission. Visa Agency is a
                    technology-enabled visa consultancy and a unit of Tripgation Private Limited.
                </p>
            </div>
        </section>

        <!--Footer Section Start -->
<?php include __DIR__ . '/includes/footer.php'; ?>
