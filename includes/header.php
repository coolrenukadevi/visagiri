<?php include __DIR__ . '/head-meta.php'; ?>

        <?php include __DIR__ . '/cookie-gate.php'; ?>

        <?php include __DIR__ . '/header-preloader.php'; ?>

        <!-- Header-Top-Section Start -->
        <div class="header-top-section">
            <div class="container-fluid">
                <div class="header-top-wrapper header-top-wrapper-unified">
                    <?php include __DIR__ . '/header-topbar.php'; ?>
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
                            <?php include __DIR__ . '/header-search.php'; ?>
                            <div class="header-call-item">
                                <a href="contact" class="theme-btn" data-open-quick-enquiry>
                                    Get Assistance
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
