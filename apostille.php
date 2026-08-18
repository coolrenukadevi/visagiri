<?php
$page_title = "Apostille &amp; Attestation Services &ndash; Visa Agency";
$page_description = "Apostille, MEA attestation, embassy attestation, certificate attestation and translation services from Visa Agency, Patna.";
include __DIR__ . '/includes/header.php';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Apostille &amp; Attestation</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Apostille Services</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="service-section section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Document Legalisation</span>
                    <h2 class="split-text-right split-text-in-right">Apostille &amp; Attestation Services</h2>
                </div>
                <p class="text text-center mb-5" style="max-width:760px;margin-left:auto;margin-right:auto;">
                    Many countries require your Indian certificates to be apostilled or attested before they can be
                    used abroad — for education, employment, marriage or business. We guide you through the correct
                    process for each document type.
                </p>
                <div class="row g-4">
                    <?php
                    $apostille_services = [
                        ['icon' => 'fa-stamp', 'title' => 'MEA Apostille', 'desc' => 'Apostille from the Ministry of External Affairs for countries under the Hague Convention.'],
                        ['icon' => 'fa-building-columns', 'title' => 'Embassy Attestation', 'desc' => 'Attestation from the destination country\'s embassy or consulate where required.'],
                        ['icon' => 'fa-certificate', 'title' => 'Certificate Attestation', 'desc' => 'Educational, marriage, birth, commercial and personal document attestation.'],
                        ['icon' => 'fa-graduation-cap', 'title' => 'Educational Certificate Attestation', 'desc' => 'Degree, diploma and mark-sheet attestation for study or work abroad.'],
                        ['icon' => 'fa-house-user', 'title' => 'Marriage &amp; Birth Certificate Attestation', 'desc' => 'Attestation for family visa, dependent visa and residency applications.'],
                        ['icon' => 'fa-briefcase', 'title' => 'Commercial Document Attestation', 'desc' => 'Attestation of business and commercial documents for trade and corporate use.'],
                        ['icon' => 'fa-file-signature', 'title' => 'Power of Attorney Attestation', 'desc' => 'Attestation support for power of attorney documents.'],
                        ['icon' => 'fa-language', 'title' => 'Translation &amp; Notary Assistance', 'desc' => 'Certified translation and notary assistance for your documents.'],
                    ];
                    foreach ($apostille_services as $s): ?>
                    <div class="col-lg-3 col-md-6">
                        <div class="how-it-works-step">
                            <div class="step-num"><i class="fa-solid <?php echo $s['icon']; ?>" style="font-size:16px;"></i></div>
                            <h4><?php echo $s['title']; ?></h4>
                            <p><?php echo $s['desc']; ?></p>
                        </div>
                    </div>
                    <?php endforeach; ?>
                </div>
                <div class="text-center mt-5">
                    <a href="contact" class="theme-btn">Enquire About Apostille Services <i class="fa-solid fa-arrow-right"></i></a>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
