<?php
$page_title = "Page Not Found &ndash; Visa Agency";
$page_description = "The page you are looking for could not be found. Visa Agency &ndash; Visa Consultant in Patna, Ranchi, Raipur & Bhopal.";
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
                    <h1 class="breadcrumb-title">Error 404</h1>
                    <ul class="breadcrumb-list">
                        <li>
                            <a href="/">Home</a>
                        </li>
                        <li>
                            <i class="fa-solid fa-chevron-right"></i>
                        </li>
                        <li>
                           Error 404
                        </li>
                    </ul>
                </div>
            </div>
        </section>

      <!--Error Section Start -->
       <section class="error-section section-padding fix">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-10">
                        <div class="error-item">
                            <div class="error-image">
                                <img src="assets/img/inner-page/404.png" alt="img">
                            </div>
                            <div class="error-content">
                                <h2>Page Not Found – Let’s Get You Back on Track</h2>
                                <p>
                                    Sorry, the page you’re looking for cannot be found. But don’t worry—we’re here to guide you back to the right path. Explore our services today!
                                </p>
                                <a href="/" class="theme-btn">
                                   back to home
                                    <i class="fa-solid fa-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
         </section>

         <!--Footer Section Start -->
<?php include __DIR__ . '/includes/footer.php'; ?>
