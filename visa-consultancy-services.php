<?php
$page_title = "Visa Consultancy Services &ndash; Visa Agency, Patna";
$page_description = "Expert visa consultancy in Patna, Bihar: eligibility guidance, document checklists, application assistance and interview preparation for popular international destinations.";
require_once __DIR__ . '/includes/countries-data.php';
include __DIR__ . '/includes/header.php';

$visa_categories = [
    ['icon' => 'fa-umbrella-beach', 'title' => 'Tourist Visa', 'desc' => 'Leisure travel, sightseeing and visiting family or friends abroad.', 'slug' => 'visa-tourist'],
    ['icon' => 'fa-briefcase', 'title' => 'Business Visa', 'desc' => 'Meetings, conferences, trade fairs and commercial visits.', 'slug' => 'visa-business'],
    ['icon' => 'fa-house-user', 'title' => 'Family / Dependent Visa', 'desc' => 'Joining or visiting family members settled abroad.', 'slug' => 'visa-family'],
    ['icon' => 'fa-user-tie', 'title' => 'Work Visa', 'desc' => 'Employment-sponsored visas for professionals moving abroad.', 'slug' => 'visa-work'],
    ['icon' => 'fa-house-medical', 'title' => 'Medical Visa', 'desc' => 'Travel for medical treatment, with an attendant visa where needed.', 'slug' => 'visa-medical'],
    ['icon' => 'fa-plane-departure', 'title' => 'Transit Visa', 'desc' => 'Short stopovers en route to a final destination.', 'slug' => 'visa-transit'],
    ['icon' => 'fa-place-of-worship', 'title' => 'Pilgrimage Visa', 'desc' => 'Religious travel to pilgrimage destinations.', 'slug' => 'contact'],
    ['icon' => 'fa-earth-americas', 'title' => 'Immigration / PR', 'desc' => 'Guidance on permanent residency and long-stay pathways.', 'slug' => 'contact'],
];

$vcs_faqs = [
    ['q' => 'What documents are required for a tourist visa?', 'a' => 'Typically your passport, photographs, travel itinerary, accommodation proof and financial documents — the exact list depends on the destination and is confirmed once you use our document checklist.'],
    ['q' => 'How long does visa processing take?', 'a' => "Processing time varies by embassy/consulate and visa category. Your consultant will share an estimated timeline once your case is reviewed."],
    ['q' => 'Can I apply if my previous visa was refused?', 'a' => 'Yes. We review the refusal reason and help you prepare a stronger reapplication.'],
    ['q' => 'Do I need an interview?', 'a' => "Some embassies require an interview and others don't — this depends on the destination and visa category. We'll confirm this for your specific case."],
    ['q' => 'Can you help with visa appointments?', 'a' => 'Yes, we guide you through booking your visa appointment and biometrics where required.'],
];
?>
<script type="application/ld+json">
<?php echo json_encode([
    "@context" => "https://schema.org",
    "@graph" => [
        [
            "@type" => "BreadcrumbList",
            "itemListElement" => [
                ["@type" => "ListItem", "position" => 1, "name" => "Home", "item" => "https://visaagency.in/"],
                ["@type" => "ListItem", "position" => 2, "name" => "Visa Consultancy Services", "item" => "https://visaagency.in/visa-consultancy-services"],
            ],
        ],
        [
            "@type" => "FAQPage",
            "mainEntity" => array_map(function ($f) {
                return [
                    "@type" => "Question",
                    "name" => $f['q'],
                    "acceptedAnswer" => ["@type" => "Answer", "text" => $f['a']],
                ];
            }, $vcs_faqs),
        ],
    ],
], JSON_UNESCAPED_SLASHES); ?>
</script>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Visa Consultancy Services</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Visa Consultancy Services</li>
                    </ul>
                </div>
            </div>
        </section>

        <!-- Trust Section -->
        <section class="trust-strip section-padding pb-0">
            <div class="container">
                <div class="section-title text-center mb-4">
                    <span class="sub-title wow fadeInUp">Your Journey. Our Expertise.</span>
                    <h2 class="split-text-right split-text-in-right">Visa Consultancy You Can Rely On</h2>
                    <p class="text mt-3" style="max-width:760px;margin:0 auto;">
                        Visa Agency is a technology-enabled visa consultancy based in Patna, Bihar, guiding
                        applicants across tourist, business, work, family and medical visa categories for
                        popular international destinations.
                    </p>
                </div>
                <div class="trust-strip-inner" style="border-bottom:none;">
                    <div class="trust-item"><i class="fa-solid fa-circle-check"></i> Expert Visa Guidance</div>
                    <div class="trust-item"><i class="fa-solid fa-circle-check"></i> Country-Specific Checklists</div>
                    <div class="trust-item"><i class="fa-solid fa-circle-check"></i> Document Review Assistance</div>
                    <div class="trust-item"><i class="fa-solid fa-circle-check"></i> End-to-End Application Support</div>
                </div>
            </div>
        </section>

        <!-- Visa Category Section -->
        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Explore Visa Services</span>
                    <h2 class="split-text-right split-text-in-right">Choose Your Visa Category</h2>
                </div>
                <div class="visa-category-grid">
                    <?php foreach ($visa_categories as $c): ?>
                    <div class="visa-category-card">
                        <div class="vc-icon"><i class="fa-solid <?php echo $c['icon']; ?>"></i></div>
                        <h4><?php echo $c['title']; ?></h4>
                        <p><?php echo $c['desc']; ?></p>
                        <a href="<?php echo $c['slug']; ?>" class="vc-link">Explore &rarr;</a>
                    </div>
                    <?php endforeach; ?>
                </div>
            </div>
        </section>

        <!-- Country Discovery -->
        <section class="section-padding fix section-bg-1 country-explorer-section">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title wow fadeInUp">Popular Destinations</span>
                    <h2 class="split-text-right split-text-in-right">Explore Visa Requirements by Country</h2>
                    <p class="text mt-3" style="max-width:700px;margin:0 auto;">
                        We currently guide applicants across the destinations below, with more added regularly.
                    </p>
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
                    <a href="country-<?php echo $c['slug']; ?>" class="country-chip" data-name="<?php echo strtolower($c['name']); ?>" data-region="<?php echo $c['region']; ?>">
                        <span class="flag"><?php echo $c['flag']; ?></span>
                        <span><?php echo $c['name']; ?></span>
                    </a>
                    <?php endforeach; ?>
                </div>
                <div class="text-center mt-4">
                    <a href="country-list" class="theme-btn style-2">Explore All Countries</a>
                </div>
            </div>
        </section>

        <!-- Process Timeline -->
        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">How We Work</span>
                    <h2 class="split-text-right split-text-in-right">Your Visa Application Journey</h2>
                </div>
                <div class="process-timeline">
                    <div class="process-step">
                        <div class="ps-num">01</div>
                        <div class="ps-body"><h4>Eligibility Check</h4><p>We review your profile and travel purpose to recommend the right visa category.</p></div>
                    </div>
                    <div class="process-step">
                        <div class="ps-num">02</div>
                        <div class="ps-body"><h4>Document Checklist</h4><p>A personalised checklist so you know exactly what to prepare.</p></div>
                    </div>
                    <div class="process-step">
                        <div class="ps-num">03</div>
                        <div class="ps-body"><h4>Application Preparation</h4><p>We help you complete and review the application accurately.</p></div>
                    </div>
                    <div class="process-step">
                        <div class="ps-num">04</div>
                        <div class="ps-body"><h4>Appointment &amp; Biometrics</h4><p>Guidance on booking your appointment and biometrics, where required.</p></div>
                    </div>
                    <div class="process-step optional">
                        <div class="ps-num">05</div>
                        <div class="ps-body"><span class="ps-tag">If applicable</span><h4>Interview Preparation</h4><p>Practical guidance to help you prepare for a visa interview.</p></div>
                    </div>
                    <div class="process-step">
                        <div class="ps-num">06</div>
                        <div class="ps-body"><h4>Application Processing</h4><p>Your application moves to the embassy/consulate for processing.</p></div>
                    </div>
                    <div class="process-step">
                        <div class="ps-num">07</div>
                        <div class="ps-body"><h4>Decision</h4><p>The relevant embassy, consulate or immigration authority makes the final decision.</p></div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Visa Refusal Support Teaser -->
        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="row align-items-center g-4">
                    <div class="col-lg-7">
                        <div class="section-title mb-3">
                            <span class="sub-title wow fadeInUp">Already Refused?</span>
                            <h2 class="split-text-right split-text-in-right">Don't Just Reapply — Understand What Went Wrong</h2>
                        </div>
                        <p class="text">
                            If a previous application was refused, we review the refusal reason, identify
                            documentation gaps and help you prepare a stronger, clearer reapplication.
                        </p>
                        <a href="visa-refusal" class="theme-btn mt-3">Request a Visa Refusal Review <i class="fa-solid fa-arrow-right"></i></a>
                    </div>
                    <div class="col-lg-5">
                        <div class="data-pending">
                            <i class="fa-solid fa-circle-info"></i>
                            <div>
                                <h4>No guaranteed outcomes</h4>
                                <p>We cannot guarantee visa approval. The final decision always rests with the relevant embassy, consulate or immigration authority.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Consultation CTA -->
        <section class="section-padding fix">
            <div class="container">
                <div class="final-cta">
                    <h2>Not Sure Which Visa You Need?</h2>
                    <p>Speak with a visa consultant and understand your options before you apply.</p>
                    <div class="cta-buttons">
                        <a href="contact" class="theme-btn">Book Consultation <i class="fa-solid fa-arrow-right"></i></a>
                        <a href="contact" class="theme-btn style-2">Request a Callback</a>
                        <a href="https://wa.me/917844819819" target="_blank" rel="noopener" class="theme-btn style-2">WhatsApp an Expert</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- FAQ -->
        <section id="vcs-faq" class="section-padding fix section-bg-1">
            <div class="container">
                <div class="row g-5 align-items-start">
                    <div class="col-lg-4">
                        <div class="section-title mb-0">
                            <span class="sub-title-2 wow fadeInUp">Common Questions</span>
                            <h2 class="split-text-right split-text-in-right">Visa Consultancy FAQs</h2>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="faq-accordion">
                            <div class="faq-item active">
                                <div class="faq-question">What documents are required for a tourist visa? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Typically your passport, photographs, travel itinerary, accommodation proof and financial documents — the exact list depends on the destination and is confirmed once you use our document checklist.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">How long does visa processing take? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Processing time varies by embassy/consulate and visa category. Your consultant will share an estimated timeline once your case is reviewed.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Can I apply if my previous visa was refused? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Yes. We review the refusal reason and help you prepare a stronger reapplication — see our <a href="visa-refusal">Visa Refusal &amp; Reapplication Guidance</a>.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Do I need an interview? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Some embassies require an interview and others don't — this depends on the destination and visa category. We'll confirm this for your specific case.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Can you help with visa appointments? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Yes, we guide you through booking your visa appointment and biometrics where required.</p></div>
                            </div>
                        </div>
                    </div>
                </div>
                <p class="compliance-note mt-5">
                    Visa Agency provides visa consultancy and documentation assistance. Visa decisions are made
                    solely by the relevant embassy, consulate, immigration authority or government department.
                    Visa approval is not guaranteed. Requirements, fees and processing times may change without
                    notice. Applicants should verify current requirements before submission.
                </p>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
