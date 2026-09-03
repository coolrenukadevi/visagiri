<?php include __DIR__ . '/head-meta.php'; ?>

        <?php include __DIR__ . '/cookie-gate.php'; ?>

        <?php include __DIR__ . '/header-preloader.php'; ?>

        <?php include __DIR__ . '/header-offcanvas.php'; ?>

        <div class="header-top-section-2 fix">
            <div class="container-fluid">
                <div class="header-top-wrapper-2 header-top-wrapper-unified">
                    <?php include __DIR__ . '/header-topbar.php'; ?>
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
                                    <img src="<?php echo $site_logo_white; ?>" alt="logo-img">
                                </a>
                                <a href="/" class="header-logo">
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
                            <a href="track-application" class="header-track-link">Track Application</a>
                            <?php include __DIR__ . '/header-search.php'; ?>
                            <div class="header-call-item">
                                <a href="contact" class="theme-btn" data-open-quick-enquiry>
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
