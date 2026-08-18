<?php
$page_title = "Book Appointment &ndash; Visa Agency";
$page_description = "Book a free consultation with Visa Agency's visa experts in Patna, Ranchi, Raipur and Bhopal.";
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
                    <h1 class="breadcrumb-title">Make Appointment</h1>
                    <ul class="breadcrumb-list">
                        <li>
                            <a href="/">Home</a>
                        </li>
                        <li>
                            <i class="fa-solid fa-chevron-right"></i>
                        </li>
                        <li>
                           Make Appointment
                        </li>
                    </ul>
                </div>
            </div>
        </section>

        <!--Appointment Section Start -->
        <section class="appointment-section section-padding fix">
            <div class="container">
                <div class="appointment-wrapper">
                    <div class="row g-4">
                        <div class="col-lg-6">
                            <div class="appointment-content">
                                <div class="section-title mb-0">
                                    <span class="sub-title-2">About Our Consultancy</span>
                                    <h2 class="split-text-right split-text-in-right">
                                        Want to meet us for your need?
                                    </h2>
                                </div>
                                <h5>
                                    Have any questions?
                                </h5>
                                <p>
                                    24/7 customer support is always ready to answer all your questions
                                </p>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="calendar">
                                <div class="calendar-header">
                                <h2 id="month-year">August 2025</h2>
                                <div>
                                    <button id="prev">&lt;</button>
                                    <button id="next">&gt;</button>
                                </div>
                                </div>
                                <div class="days">
                                <div>Mon</div>
                                <div>Tue</div>
                                <div>Wed</div>
                                <div>Thu</div>
                                <div>Fri</div>
                                <div>Sat</div>
                                <div>Sun</div>
                                </div>
                                <div class="dates" id="dates"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!--Contact Section Start -->
        <div class="contact-section section-padding fix pt-0">
            <div class="container">
                <div class="contact-from-wrapper">
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
                                </div>
                            </form>
                            <div class="cheak-list-item">
                                <div class="cheak-list">
                                     <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault1">
                                        <label class="form-check-label" for="flexCheckDefault1">
                                            Canada Immigration
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault2">
                                        <label class="form-check-label" for="flexCheckDefault2">
                                           Tourist Visa
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault3">
                                        <label class="form-check-label" for="flexCheckDefault3">
                                           Medical Visa
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault4">
                                        <label class="form-check-label" for="flexCheckDefault4">
                                           Coaching
                                        </label>
                                    </div>
                                </div>
                                <div class="cheak-list mb-0">
                                     <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault5">
                                        <label class="form-check-label" for="flexCheckDefault5">
                                            Family Visa
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault6">
                                        <label class="form-check-label" for="flexCheckDefault6">
                                           Spouse Visa
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault7">
                                        <label class="form-check-label" for="flexCheckDefault7">
                                           Job Opportunity
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault8">
                                        <label class="form-check-label" for="flexCheckDefault8">
                                           Exam
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <button type="submit" class="theme-btn">
                               Request Appointment
                                <i class="fa-solid fa-arrow-right"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--Footer Section Start -->
<?php include __DIR__ . '/includes/footer.php'; ?>
