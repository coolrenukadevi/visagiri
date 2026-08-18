<!DOCTYPE html>
<html lang="en">
    <!--<< Header Area >>-->
    <head>
       <!-- ========== Meta Tags ========== -->
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="author" content="Visa Agency">
        <meta name="description" content="<?php echo $page_description; ?>">
        <!-- ======== Page title ============ -->
        <title><?php echo $page_title; ?></title>
        <!--<< Favcion >>-->
         <link rel="shortcut icon" href="assets/img/favicon.png">
        <!--<< Bootstrap min.css >>-->
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <!--<< All Min Css >>-->
        <link rel="stylesheet" href="assets/css/all.min.css">
        <!--<< Animate.css >>-->
        <link rel="stylesheet" href="assets/css/animate.css">
        <!--<< Magnific Popup.css >>-->
        <link rel="stylesheet" href="assets/css/magnific-popup.css">
        <!--<< MeanMenu.css >>-->
        <link rel="stylesheet" href="assets/css/meanmenu.css">
         <!--<< Odometer.css >>-->
        <link rel="stylesheet" href="assets/css/odometer.css">
        <!--<< Swiper Bundle.css >>-->
        <link rel="stylesheet" href="assets/css/swiper-bundle.min.css">
        <!--<< Nice Select.css >>-->
        <link rel="stylesheet" href="assets/css/nice-select.css">
        <!--<< Main.css >>-->
        <link rel="stylesheet" href="assets/css/main.css">
        <link rel="stylesheet" href="assets/css/custom.css">
                            
        <?php include __DIR__ . '/schema.php'; ?>
    </head>
    <body class="smooth-scroll-yes">

       
        <!-- Preloader Start -->
        <div id="preloader" class="preloader">
            <div class="animation-preloader">
                <div class="spinner">                
                </div>
                <div class="txt-loading">
                    <span data-text-preloader="V" class="letters-loading">
                        V
                    </span>
                     <span data-text-preloader="I" class="letters-loading">
                        I
                    </span>
                     <span data-text-preloader="S" class="letters-loading">
                        S
                    </span>
                    <span data-text-preloader="A" class="letters-loading">
                        A
                    </span>
                </div>
                <p class="text-center">Loading</p>
            </div>
            <div class="loader">
                <div class="row">
                    <div class="col-3 loader-section section-left">
                        <div class="bg"></div>
                    </div>
                    <div class="col-3 loader-section section-left">
                        <div class="bg"></div>
                    </div>
                    <div class="col-3 loader-section section-right">
                        <div class="bg"></div>
                    </div>
                    <div class="col-3 loader-section section-right">
                        <div class="bg"></div>
                    </div>
                </div>
            </div>
        </div>  

        <!-- GT Back To Top Start -->
        <button id="back-top" class="back-to-top show">
            <i class="fa-regular fa-arrow-up"></i>
        </button>

        <!-- GT MouseCursor Start -->
        <div class="mouseCursor cursor-outer"></div>
        <div class="mouseCursor cursor-inner"></div>

       <!-- Offcanvas Area Start -->
        <div class="fix-area">
            <div class="offcanvas__info">
                <div class="offcanvas__wrapper">
                    <div class="offcanvas__content">
                        <div class="offcanvas__top mb-5 d-flex justify-content-between align-items-center">
                            <div class="offcanvas__logo">
                                <a href="/">
                                    <img src="assets/img/logo/black-logo.svg" alt="logo-img">
                                </a>
                            </div>
                            <div class="offcanvas__close">
                                <button>
                                <i class="fas fa-times"></i>
                                </button>
                            </div>
                        </div>
                        <p class="text d-none d-xl-block">
                            Ministry of Tourism recognised visa consultancy offering fast, reliable and hassle-free visa solutions across Patna, Ranchi, Raipur and Bhopal.
                        </p>
                        <div class="mobile-menu fix mb-3"></div>
                        <div class="offcanvas__contact d-xl-block">
                            <h4 class="d-xl-block">Contact Info</h4>
                            <ul class="d-xl-block">
                                <li class="d-flex align-items-center">
                                    <div class="offcanvas__contact-icon">
                                        <i class="fal fa-map-marker-alt"></i>
                                    </div>
                                    <div class="offcanvas__contact-text">
                                        <a target="_blank" href="#">Patna, Bihar, India</a>
                                    </div>
                                </li>
                                <li class="d-flex align-items-center">
                                    <div class="offcanvas__contact-icon mr-15">
                                        <i class="fal fa-envelope"></i>
                                    </div>
                                    <div class="offcanvas__contact-text">
                                        <a href="mailto:info@visaagency.in"><span class="mailto:info@visaagency.in">info@visaagency.in</span></a>
                                    </div>
                                </li>
                                <li class="d-flex align-items-center">
                                    <div class="offcanvas__contact-icon mr-15">
                                        <i class="fal fa-clock"></i>
                                    </div>
                                    <div class="offcanvas__contact-text">
                                        <a target="_blank" href="#">Mod-friday, 09am -05pm</a>
                                    </div>
                                </li>
                                <li class="d-flex align-items-center">
                                    <div class="offcanvas__contact-icon mr-15">
                                        <i class="far fa-phone"></i>
                                    </div>
                                    <div class="offcanvas__contact-text">
                                        <a href="tel:+917844819819">+91 78448 19819</a>
                                    </div>
                                </li>
                            </ul>
                            <div class="social-icon d-flex align-items-center">
                                <a href="#"><i class="fab fa-facebook-f"></i></a>
                                <a href="#"><i class="fab fa-twitter"></i></a>
                                <a href="#"><i class="fab fa-youtube"></i></a>
                                <a href="#"><i class="fab fa-linkedin-in"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="offcanvas__overlay"></div> 

        <div class="header-top-section-2 fix">
            <div class="container-fluid">
                <div class="header-top-wrapper-2">
                    <div class="header-left">
                        <span>
                            <i class="fa-solid fa-phone"></i>
                            <a href="tel:+917844819819">Call Us: +91 78448 19819</a>
                        </span>
                        <span>
                            <i class="fa-brands fa-whatsapp"></i>
                            <a href="https://wa.me/917844819819" target="_blank" rel="noopener">WhatsApp Us</a>
                        </span>
                        <span>
                            <i class="fa-solid fa-location-dot"></i>
                            Patna, Bihar
                        </span>
                    </div>
                    <div class="header-right d-flex align-items-center gap-3">
                        <div class="topbar-auth-links">
                            <a href="customer-login">Customer Login</a>
                            <span class="divider">|</span>
                            <a href="employee-login">Employee Login</a>
                        </div>
                        <div class="social-item">
                            <a href="#"><i class="fa-brands fa-linkedin"></i></a>
                            <a href="#"><i class="fa-brands fa-twitter"></i></a>
                            <a href="#"><i class="fa-brands fa-instagram"></i></a>
                            <a href="#"><i class="fa-brands fa-youtube"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

         <!-- Header Section Start -->
        <header id="header-sticky" class="header-1 header-2">
            <div class="container-fluid">
                <div class="mega-menu-wrapper">
                    <div class="header-main">
                        <div class="header-left">
                            <div class="logo">
                                <a href="/" class="header-logo-2">
                                    <img src="assets/img/logo/white-logo.svg" alt="logo-img">
                                </a>
                                <a href="/" class="header-logo">
                                    <img src="assets/img/logo/black-logo.svg" alt="logo-img">
                                </a>
                            </div>
                            <div class="mean__menu-wrapper">
                                <div class="main-menu">
                                    <?php include __DIR__ . '/nav.php'; ?>
                                </div>
                            </div>
                        </div>
                        <div class="header-right d-flex align-items-center mt-0">
                            <div class="header-call-item">
                                <a href="contact" class="theme-btn">
                                    Enquire Now
                                    <i class="fa-solid fa-arrow-right"></i>
                                </a>
                                <div class="header__hamburger my-auto">
                                <div class="sidebar__toggle">
                                    <i class="fa-solid fa-bars-staggered"></i>
                                </div>
                            </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </header> 
