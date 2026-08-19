<?php include __DIR__ . '/head-meta.php'; ?>

        <?php include __DIR__ . '/header-preloader.php'; ?>

        <!-- Header-Top-Section Start -->
        <div class="header-top-section">
            <div class="container-fluid">
                <div class="header-top-wrapper">
                    <div class="header-left">
                        <ul class="list">
                            <li class="style-2">
                                <i class="fa-solid fa-phone"></i>
                                <a href="tel:<?php echo $site_phone_e164; ?>">Call Us: <?php echo $site_phone_display; ?></a>
                            </li>
                            <li>
                                <i class="fa-brands fa-whatsapp"></i>
                                <a href="<?php echo $site_whatsapp_url; ?>" target="_blank" rel="noopener">WhatsApp Us</a>
                            </li>
                            <li>
                                <i class="fa-solid fa-location-dot"></i>
                                <?php echo $site_city; ?>
                            </li>
                        </ul>
                    </div>
                    <div class="header-right">
                        <div class="topbar-auth-links">
                            <a href="customer-login">Customer Login</a>
                            <span class="divider">|</span>
                            <a href="employee-login">Employee Login</a>
                        </div>
                        <div class="social-item">
                            <a href="<?php echo $site_social['linkedin']; ?>"><i class="fa-brands fa-linkedin"></i></a>
                            <a href="<?php echo $site_social['twitter']; ?>"><i class="fa-brands fa-twitter"></i></a>
                            <a href="<?php echo $site_social['instagram']; ?>"><i class="fa-brands fa-instagram"></i></a>
                            <a href="<?php echo $site_social['youtube']; ?>"><i class="fa-brands fa-youtube"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <?php include __DIR__ . '/header-offcanvas.php'; ?>

        <!-- Header Section Start -->
         <header id="header-sticky" class="header-1">
            <div class="container-fluid">
                <div class="mega-menu-wrapper">
                    <div class="header-main">
                        <div class="header-left">
                            <div class="logo">
                                <a href="/" class="header-logo-2">
                                    <img src="<?php echo $site_logo_black; ?>" alt="logo-img">
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
