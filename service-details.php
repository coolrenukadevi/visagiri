<?php
/**
 * Generic, non-parameterized service detail template — every link into
 * this page shows the exact same content regardless of which service was
 * clicked, so it can't carry unique per-service metadata. Noindexed until
 * each service gets its own dedicated page (see visa-work.php etc.).
 */
$page_title = "Service Details &ndash; Visa Agency";
$page_description = "Detailed visa services offered by Visa Agency.";
$page_noindex = true;
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
                    <h1 class="breadcrumb-title">Service Details</h1>
                    <ul class="breadcrumb-list">
                        <li>
                            <a href="/">Home</a>
                        </li>
                        <li>
                            <i class="fa-solid fa-chevron-right"></i>
                        </li>
                        <li>
                           Service Details
                        </li>
                    </ul>
                </div>
            </div>
        </section>

       <!--Service-details Section Start -->
       <section class="service-details-section section-padding fix">
        <div class="container">
            <div class="service-details-wrapper">
                <div class="row">
                    <div class="col-xl-12">
                        <div class="service-details-post">
                            <h2>Work Visa Consultancy</h2>
                            <p class="mt-2">
                                We help professionals unlock overseas job opportunities with the right documentation and guidance. Our expert advisors guide you through eligibility checks, employer/sponsor requirements, and the documents needed for your chosen destination. From preparing a strong application to meeting embassy requirements, we help you present your case clearly.
                            </p>
                            <div class="details-image">
                                <img src="assets/img/inner-page/service-details/details-1.jpg" alt="img">
                            </div>
                            <h3 class="text">Service Overview</h3>
                            <p class="mt-3 mb-3">
                                Our Work Visa Consultancy is dedicated to guiding professionals toward their overseas career goals. We provide complete support including eligibility checks, application assistance, documentation guidance and interview preparation. With our experienced consultants and technology-enabled process, we help make the transition abroad smoother.
                            </p>
                            <p class="mb-4">
                                From start to finish, we are committed to turning your career move into a successful international experience.
                            </p>
                            <div class="row g-4">
                                <div class="col-lg-6">
                                    <div class="service-left-content">
                                        <h3>Key Features</h3>
                                        <ul class="list-item">
                                            <li>
                                                <i class="fa-solid fa-chevrons-right"></i>
                                                <span>Personalized Guidance -</span>Tailored support for each applicant's goals and requirements.
                                            </li>
                                            <li>
                                                <i class="fa-solid fa-chevrons-right"></i>
                                                <span>Experienced Consultants -</span> Team with global work visa and immigration knowledge.
                                            </li>
                                            <li>
                                                <i class="fa-solid fa-chevrons-right"></i>
                                                <span>Eligibility & Employer Checks - </span>  Helping you confirm eligibility and sponsor requirements.
                                            </li>
                                             <li>
                                                <i class="fa-solid fa-chevrons-right"></i>
                                                <span>Visa Application Support -</span>   Step-by-step guidance for smooth visa processing.   
                                            </li>
                                            <li>
                                                <i class="fa-solid fa-chevrons-right"></i>
                                                <span>Interview Preparation – </span>   Coaching for successful visa interviews.
                                            </li>
                                            <li>
                                                <i class="fa-solid fa-chevrons-right"></i>
                                                <span>Documentation Assistance – </span>   Accurate and complete paperwork for faster approvals.
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="thumb">
                                        <img src="assets/img/inner-page/service-details/details-2.jpg" alt="img">
                                    </div>
                                </div>
                            </div>
                            <div class="row mt-4 mt-xl-0 g-4">
                                <div class="col-lg-6">
                                    <div class="thumb">
                                        <img src="assets/img/inner-page/service-details/details-3.jpg" alt="img">
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="faq-items">
                                        <h3 class="mb-3">Frequently Asked Question</h3>
                                        <div class="accordion" id="accordionExample">
                                            <div class="accordion-item wow fadeInUp" data-wow-delay=".2s">
                                                <h5 class="accordion-header" id="headingTwo">
                                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                                        data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                                        01. Do you check eligibility before I apply?
                                                    </button>
                                                </h5>
                                                <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo"
                                                    data-bs-parent="#accordionExample">
                                                    <div class="accordion-body">
                                                        <p>
                                                        Yes. We review your profile, the destination country's requirements and your sponsor/employer details before recommending a visa category.
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="accordion-item wow fadeInUp" data-wow-delay=".8s">
                                                <h5 class="accordion-header" id="headingOne">
                                                    <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                                        data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                                        02. Can you help with documentation?
                                                    </button>
                                                </h5>
                                                <div id="collapseOne" class="accordion-collapse collapse show"
                                                    aria-labelledby="headingOne" data-bs-parent="#accordionExample">
                                                    <div class="accordion-body">
                                                        <p>
                                                            Yes. Our consultants help you compile, verify and organise the documents required for your application, so nothing is missing at submission.
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="accordion-item wow fadeInUp" data-wow-delay=".4s">
                                                <h5 class="accordion-header" id="headingthree">
                                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                                        data-bs-target="#collapsethree" aria-expanded="false"
                                                        aria-controls="collapsethree">
                                                   03. How long does the visa process take?
                                                    </button>
                                                </h5>
                                                <div id="collapsethree" class="accordion-collapse collapse"
                                                    aria-labelledby="headingthree" data-bs-parent="#accordionExample">
                                                    <div class="accordion-body">
                                                        <p>
                                                        Processing time varies by embassy/consulate and visa category. Your consultant will share an estimated timeline once your case is reviewed.
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="accordion-item wow fadeInUp" data-wow-delay=".6s">
                                                <h5 class="accordion-header" id="headingfour">
                                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                                        data-bs-target="#collapsefour" aria-expanded="false"
                                                        aria-controls="collapsefour">
                                                04. Is support available after my visa is approved?
                                                    </button>
                                                </h5>
                                                <div id="collapsefour" class="accordion-collapse collapse" aria-labelledby="headingfour"
                                                    data-bs-parent="#accordionExample">
                                                    <div class="accordion-body">
                                                        <p>
                                                        Yes. We remain available for guidance on next steps such as travel arrangements and any follow-up requirements after your visa is approved.
                                                        </p>
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
            </div>
        </div>
       </section>

         <!--Footer Section Start -->
<?php include __DIR__ . '/includes/footer.php'; ?>
