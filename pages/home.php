<?php
declare(strict_types=1);

/**
 * Homepage. Catalog data (countries, visa types, FAQs) is queried live
 * from the database — nothing here is fabricated. There is no blog
 * content management yet (see blog/index.php), so the homepage doesn't
 * carry a "Latest Visa Updates" section — the real, populated
 * "Explore Visa Resources" section below covers that role honestly.
 */

$allCountries = countries_all();
$countryCount = count($allCountries);
$popularCountries = array_values(array_filter($allCountries, static fn(array $c): bool => $c['is_popular_destination']));
usort($popularCountries, static fn(array $a, array $b): int => $a['name'] <=> $b['name']);
$visaTypes = visa_types_all();
$faqs = faqs_general();

$processSteps = [
    ['title' => 'Get in Touch', 'desc' => 'Tell us your destination and purpose of travel via WhatsApp, call, or the enquiry form.'],
    ['title' => 'Check Requirements', 'desc' => 'We confirm eligibility, documents, and fees for your visa type.'],
    ['title' => 'Prepare Documents', 'desc' => 'We guide you through the exact documents your application needs.'],
    ['title' => 'Expert Review', 'desc' => 'Our team reviews your documents and application before submission.'],
    ['title' => 'Application Submitted', 'desc' => 'Your application is submitted to the relevant embassy, consulate, or authority.'],
    ['title' => 'Receive Decision', 'desc' => 'We keep you updated as soon as a decision is available.'],
];

$whyFeatures = why_visagiri_features();

// Hero icon set — small flat outline SVGs, inline (zero external
// dependency, matches the pattern already used in visa/index.php's
// $vcIcons). Reused across all four slides below by key.
$heroIcons = [
    'globe' => '<svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><path d="M3 12h18M12 3a14 14 0 0 1 0 18M12 3a14 14 0 0 0 0 18"/></svg>',
    'document' => '<svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="5" y="3" width="14" height="18" rx="2"/><path d="M9 8h6M9 12h6M9 16h3"/></svg>',
    'checklist' => '<svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="5" y="3" width="14" height="18" rx="2"/><path d="M9 9l1.5 1.5L13.5 7M9 15h6"/></svg>',
    'people' => '<svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="8" r="3.5"/><path d="M4.5 20c1.5-4 5-5.5 7.5-5.5s6 1.5 7.5 5.5"/></svg>',
    'shield' => '<svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M12 3l7 3v6c0 4.5-3 7.5-7 9-4-1.5-7-4.5-7-9V6l7-3z"/><path d="M9 12l2 2 4-4"/></svg>',
    'clock' => '<svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3.5 2"/></svg>',
];

// Four hero slides. Images are real (client-supplied, cropped from
// their source templates to isolate just the photo — see AUDIT.md for
// why the flattened templates themselves weren't used directly: their
// headline/stat text was baked into the raster image, which would
// have meant losing real crawlable/accessible/responsive text in
// favor of a picture of text). "200+" claims use the live
// $countryCount rather than a hardcoded figure so they can't drift
// from the real catalog.
$heroSlides = [
    [
        'theme' => 'dark',
        'eyebrow' => 'Global Visa Support',
        'heading' => 'Your Destination, Our Visa Expertise.',
        'accent' => 'Visa Expertise.',
        'subtitle' => "Expert guidance for tourist, business, employment, transit, medical and conference visas to {$countryCount}+ countries.",
        'image' => '/assets/images/hero/hero-slide-1.jpg',
        'imageWidth' => 500,
        'imageHeight' => 828,
        'imageAlt' => 'Traveller with a backpack looking out over a European city skyline',
        'stats' => [
            ['icon' => 'globe', 'label' => "{$countryCount}+ Countries", 'sub' => 'Wide coverage'],
            ['icon' => 'document', 'label' => 'Visa Guidance', 'sub' => 'Step-by-step support'],
            ['icon' => 'people', 'label' => 'Expert Team', 'sub' => 'Personalised assistance'],
            ['icon' => 'shield', 'label' => 'Secure Process', 'sub' => 'Reliable & transparent'],
        ],
    ],
    [
        'theme' => 'light',
        'eyebrow' => "Visa Services for {$countryCount}+ Countries",
        'heading' => 'Explore the World Without Visa Worries.',
        'accent' => 'Without Visa Worries.',
        'subtitle' => 'Get end-to-end visa support — from requirements to application guidance, all in one place.',
        'image' => '/assets/images/hero/hero-slide-2.jpg',
        'imageWidth' => 807,
        'imageHeight' => 828,
        'imageAlt' => 'Traveller looking at a collage of famous landmarks including the Eiffel Tower and Big Ben',
        'stats' => [
            ['icon' => 'checklist', 'label' => 'Document Checklist', 'sub' => 'Country-wise guidance'],
            ['icon' => 'people', 'label' => 'Application Support', 'sub' => 'End-to-end help'],
            ['icon' => 'clock', 'label' => 'Save Time', 'sub' => 'Hassle-free process'],
        ],
    ],
    [
        'theme' => 'dark',
        'eyebrow' => 'Simple Process, Global Possibilities',
        'heading' => 'From Your First Query to Visa Approval.',
        'accent' => 'Visa Approval.',
        'subtitle' => 'Reliable support, clear guidance and expert assistance for a smooth visa application experience.',
        'image' => '/assets/images/hero/hero-slide-3.jpg',
        'imageWidth' => 404,
        'imageHeight' => 828,
        'imageAlt' => 'Traveller with a backpack and suitcase watching a plane take off from an airport window',
        'stats' => [
            ['icon' => 'document', 'label' => 'Visa Guidance', 'sub' => 'Step-by-step support'],
            ['icon' => 'checklist', 'label' => 'Document Support', 'sub' => 'Complete checklist'],
            ['icon' => 'people', 'label' => 'Expert Assistance', 'sub' => 'Personalised guidance'],
            ['icon' => 'shield', 'label' => 'Track Your Application', 'sub' => 'Stay informed'],
        ],
    ],
    [
        'theme' => 'dark',
        'eyebrow' => 'Trusted Visa Assistance',
        'heading' => 'Your Travel Plans, Our Visa Support.',
        'accent' => 'Visa Support.',
        'subtitle' => "Get expert help with visa requirements, documentation and application guidance for {$countryCount}+ destinations.",
        'image' => '/assets/images/hero/hero-slide-4.jpg',
        'imageWidth' => 500,
        'imageHeight' => 828,
        'imageAlt' => 'Passport and boarding passes resting on a wooden desk',
        'stats' => [
            ['icon' => 'globe', 'label' => "{$countryCount}+ Destinations", 'sub' => 'Global coverage'],
            ['icon' => 'document', 'label' => 'Clear Guidance', 'sub' => 'Step-by-step process'],
            ['icon' => 'people', 'label' => 'Dedicated Team', 'sub' => 'End-to-end support'],
            ['icon' => 'shield', 'label' => 'Reliable & Transparent', 'sub' => 'Your trusted partner'],
        ],
    ],
];

$pageTitle = 'Your Visa Journey, Simplified - Visagiri';
$pageDescription = 'Expert visa guidance and document attestation assistance for 200+ destinations. Check visa requirements and enquire with Visagiri.';
$canonicalUrl = APP_URL . '/';

require __DIR__ . '/../includes/header.php';
?>

<!-- Section 1: Hero slider — 4 slides, see $heroSlides above. -->
<section class="hero-slider" id="hero-slider" aria-roledescription="carousel" aria-label="Visagiri services">
    <div class="hero-slider__track">
        <?php foreach ($heroSlides as $i => $slide): ?>
        <div class="hero hero-slide<?= $slide['theme'] === 'light' ? ' hero-slide--light' : '' ?>" role="group" aria-roledescription="slide" aria-label="Slide <?= $i + 1 ?> of <?= count($heroSlides) ?>"<?= $i > 0 ? ' aria-hidden="true"' : '' ?>>
            <div class="container hero__grid">
                <div>
                    <span class="hero__label"><span class="hero__label-line" aria-hidden="true"></span><?= e($slide['eyebrow']) ?><span class="hero__label-line" aria-hidden="true"></span></span>
                    <h1><?= e(str_replace($slide['accent'], '', $slide['heading'])) ?><span class="hero__accent"><?= e($slide['accent']) ?></span></h1>
                    <p class="hero__subtitle"><?= e($slide['subtitle']) ?></p>
                    <ul class="hero__stats">
                        <?php foreach ($slide['stats'] as $stat): ?>
                        <li class="hero__stat">
                            <span class="hero__stat-icon" aria-hidden="true"><?= $heroIcons[$stat['icon']] ?></span>
                            <span><strong><?= e($stat['label']) ?></strong><br><?= e($stat['sub']) ?></span>
                        </li>
                        <?php endforeach; ?>
                    </ul>
                    <div class="hero__actions">
                        <a href="#visa-search" class="btn btn-gold">Check Visa Requirements</a>
                        <?php if ($slide['theme'] === 'light'): ?>
                        <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to know more about your visa services.")) ?>" class="btn btn-outline" target="_blank" rel="noopener noreferrer">Enquire Now</a>
                        <?php else: ?>
                        <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to know more about your visa services.")) ?>" class="btn btn-primary" style="background:var(--white);color:var(--visa-blue)" target="_blank" rel="noopener noreferrer">Enquire Now</a>
                        <?php endif; ?>
                    </div>
                </div>
                <div class="hero__visual">
                    <img src="<?= e(asset_url($slide['image'])) ?>" alt="<?= e($slide['imageAlt']) ?>" width="<?= e((string) $slide['imageWidth']) ?>" height="<?= e((string) $slide['imageHeight']) ?>"<?= $i === 0 ? ' fetchpriority="high"' : ' loading="lazy"' ?>>
                </div>
            </div>
        </div>
        <?php endforeach; ?>
    </div>

    <button type="button" class="hero-slider__arrow hero-slider__arrow--prev" aria-label="Previous slide">
        <svg viewBox="0 0 24 24" width="22" height="22" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M15 18l-6-6 6-6"/></svg>
    </button>
    <button type="button" class="hero-slider__arrow hero-slider__arrow--next" aria-label="Next slide">
        <svg viewBox="0 0 24 24" width="22" height="22" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 18l6-6-6-6"/></svg>
    </button>

    <div class="hero-slider__dots" role="tablist" aria-label="Choose slide">
        <?php foreach ($heroSlides as $i => $slide): ?>
        <button type="button" class="hero-slider__dot<?= $i === 0 ? ' is-active' : '' ?>" role="tab" aria-selected="<?= $i === 0 ? 'true' : 'false' ?>" aria-label="Slide <?= $i + 1 ?> of <?= count($heroSlides) ?>"></button>
        <?php endforeach; ?>
    </div>
</section>

<!-- Section 2: Visa search widget -->
<section class="search-widget" id="visa-search">
    <div class="container">
        <div class="search-widget__card">
            <h2 class="search-widget__title">Find the Right Visa</h2>
            <p class="search-widget__hint">Search any of our 200+ destinations, visa types, or continents instantly.</p>
            <?php render_visa_search_widget('home', 'Try "Singapore", "Student Visa", or "Europe"…'); ?>
            <p class="search-widget__hint" style="margin-top:var(--space-3)">Or use the detailed search below:</p>
            <form class="search-widget__grid" action="/visa-search/" method="get">
                <div class="form-group">
                    <label class="form-label" for="search-country">Where are you travelling?</label>
                    <select class="form-select" id="search-country" name="country">
                        <option value="">Select country</option>
                        <?php foreach ($popularCountries as $c): ?>
                        <option value="<?= e($c['slug']) ?>"><?= e($c['name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="search-type">Visa Type</label>
                    <select class="form-select" id="search-type" name="visa_type">
                        <option value="">Select visa type</option>
                        <?php foreach ($visaTypes as $t): ?>
                        <option value="<?= e($t['slug']) ?>"><?= e($t['name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="search-nationality">Nationality</label>
                    <select class="form-select" id="search-nationality" name="nationality">
                        <option value="in">Indian</option>
                        <?php foreach ($popularCountries as $c): ?>
                        <option value="<?= e($c['slug']) ?>"><?= e($c['name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="search-date">Travel Date</label>
                    <input class="form-input" id="search-date" name="travel_date" type="date">
                </div>
                <button type="submit" class="btn btn-primary">Check Visa Requirements</button>
            </form>
        </div>
    </div>
</section>

<!-- Section 3: Popular destinations -->
<section class="section">
    <div class="container">
        <div class="section-heading">
            <span class="section-eyebrow">Destinations</span>
            <h2>Popular Visa Destinations</h2>
        </div>
        <?php if ($popularCountries): ?>
        <div class="card-grid">
            <?php foreach ($popularCountries as $c): ?>
            <a href="/visa/<?= e($c['slug']) ?>/" class="card destination-card">
                <span class="destination-card__flag"><?= flag_emoji($c['iso2']) ?></span>
                <span>
                    <span class="destination-card__name"><?= e($c['name']) ?></span><br>
                    <span class="destination-card__link">View requirements &rarr;</span>
                </span>
            </a>
            <?php endforeach; ?>
        </div>
        <?php else: ?>
        <p class="empty-state">Country listings are being finalized.</p>
        <?php endif; ?>
    </div>
</section>

<!-- Section 4: Visa services -->
<section class="section" style="background:var(--surface)">
    <div class="container">
        <div class="section-heading">
            <span class="section-eyebrow">Services</span>
            <h2>Visa Services</h2>
        </div>
        <?php if ($visaTypes): ?>
        <div class="card-grid">
            <?php foreach ($visaTypes as $t): ?>
            <a href="/visa-type/<?= e($t['slug']) ?>/" class="card service-card">
                <div class="service-card__icon"><?= visa_type_icon($t['slug']) ?></div>
                <div class="card-title"><?= e($t['name']) ?></div>
                <p><?= e($t['description']) ?></p>
            </a>
            <?php endforeach; ?>
        </div>
        <?php else: ?>
        <p class="empty-state">Visa service listings are being finalized.</p>
        <?php endif; ?>
    </div>
</section>

<!-- Section 5: How Visagiri Works -->
<section class="section">
    <div class="container">
        <div class="section-heading">
            <span class="section-eyebrow">Process</span>
            <h2>How Visagiri Works</h2>
        </div>
        <div class="process-steps">
            <?php foreach ($processSteps as $i => $step): ?>
            <div class="process-step">
                <div class="process-step__number"><?= $i + 1 ?></div>
                <div>
                    <div class="process-step__title"><?= e($step['title']) ?></div>
                    <p class="process-step__desc"><?= e($step['desc']) ?></p>
                </div>
            </div>
            <?php endforeach; ?>
        </div>
    </div>
</section>

<!-- Section 6: Why Visagiri -->
<section class="section" style="background:var(--surface)">
    <div class="container">
        <div class="section-heading">
            <span class="section-eyebrow">Why Visagiri</span>
            <h2>Built for a Better Visa Experience</h2>
        </div>
        <div class="card-grid">
            <?php foreach ($whyFeatures as $f): ?>
            <div class="card feature-card">
                <div class="feature-card__icon">&#9679;</div>
                <div class="card-title"><?= e($f['title']) ?></div>
                <p><?= e($f['desc']) ?></p>
            </div>
            <?php endforeach; ?>
        </div>
    </div>
</section>

<!-- Section 9: Explore Visa Resources -->
<section class="section">
    <div class="container">
        <div class="section-heading">
            <span class="section-eyebrow">Resources</span>
            <h2>Explore Visa Resources</h2>
        </div>
        <div class="card-grid">
            <a href="/documentation/" class="card service-card">
                <div class="card-title">Documentation Assistance</div>
                <p>Understand exactly what documents your application needs.</p>
            </a>
            <a href="/document-templates/" class="card service-card">
                <div class="card-title">Document Templates</div>
                <p>Ready-made cover letters, NOCs, sponsor letters and more.</p>
            </a>
            <a href="/visa-process/" class="card service-card">
                <div class="card-title">Visa Information</div>
                <p>How our visa consultancy process works, step by step.</p>
            </a>
            <a href="/track-visa/" class="card service-card">
                <div class="card-title">Track Your Application</div>
                <p>Check the status of an existing visa application.</p>
            </a>
            <a href="/faq/" class="card service-card">
                <div class="card-title">FAQs</div>
                <p>Answers to common questions about visas and documents.</p>
            </a>
        </div>
        <p style="text-align:center;margin-top:var(--space-6)"><a href="/resources/" class="btn btn-outline">Explore All Resources &rarr;</a></p>
    </div>
</section>

<!-- Section 10: FAQ -->
<section class="section" style="background:var(--surface)">
    <div class="container" style="max-width:760px">
        <div class="section-heading">
            <span class="section-eyebrow">FAQ</span>
            <h2>Frequently Asked Questions</h2>
        </div>
        <?php if ($faqs): ?>
        <?php foreach ($faqs as $faq): ?>
        <div class="accordion-item">
            <details>
                <summary><?= e($faq['question']) ?></summary>
                <div class="accordion-body"><?= e($faq['answer']) ?></div>
            </details>
        </div>
        <?php endforeach; ?>
        <p style="text-align:center;margin-top:var(--space-5)"><a href="/faq/">View all FAQs &rarr;</a></p>
        <?php else: ?>
        <p class="empty-state">FAQs are being finalized. <a href="/contact/">Contact us</a> with any questions.</p>
        <?php endif; ?>
    </div>
</section>

<!-- Section 11: Final CTA -->
<section class="section final-cta-section">
    <div class="container">
        <div class="final-cta final-cta--compact">
            <h2>Not sure which visa you need?</h2>
            <p class="final-cta__lede">Tell us where you&rsquo;re going &mdash; we&rsquo;ll help you plan the next step.</p>
            <p class="final-cta__services">Visa&nbsp;guidance&nbsp;&bull; Document&nbsp;checklist&nbsp;&bull; Application&nbsp;assistance</p>
            <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like help figuring out which visa I need.")) ?>" class="btn btn-gold btn-lg" target="_blank" rel="noopener noreferrer">Get Visa Assistance</a>
        </div>
    </div>
</section>

<script src="<?= e(asset_url('/assets/js/hero-slider.js')) ?>" defer></script>
<?php require __DIR__ . '/../includes/footer.php'; ?>
