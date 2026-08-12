<?php
declare(strict_types=1);

/**
 * Homepage — Phase 5, re-platformed to static data (see AUDIT.md,
 * "Single-folder no-database rebuild"). Catalog data (countries, visa
 * types, FAQs) is a real, one-time export of what was seeded into the
 * database across earlier phases — nothing here is fabricated. There
 * is no blog content management anymore; "Latest Visa Updates" always
 * renders its honest empty state.
 */

$popularCountries = array_values(array_filter(countries_all(), static fn(array $c): bool => $c['is_popular_destination']));
usort($popularCountries, static fn(array $a, array $b): int => $a['name'] <=> $b['name']);
$visaTypes = visa_types_all();
$faqs = faqs_general();
$updates = [];

$processSteps = [
    ['title' => 'Get in Touch', 'desc' => 'Tell us your destination and purpose of travel via WhatsApp, call, or the enquiry form.'],
    ['title' => 'Check Requirements', 'desc' => 'We confirm eligibility, documents, and fees for your visa type.'],
    ['title' => 'Prepare Documents', 'desc' => 'We guide you through the exact documents your application needs.'],
    ['title' => 'Expert Review', 'desc' => 'Our team reviews your documents and application before submission.'],
    ['title' => 'Application Submitted', 'desc' => 'Your application is submitted to the relevant embassy, consulate, or authority.'],
    ['title' => 'Receive Decision', 'desc' => 'We keep you updated as soon as a decision is available.'],
];

$whyFeatures = why_visagiri_features();

$pageTitle = 'Your Visa Journey, Simplified - Visagiri';
$pageDescription = 'Expert visa guidance and document attestation assistance for 200+ destinations. Check visa requirements and enquire with Visagiri.';
$canonicalUrl = APP_URL . '/';

require __DIR__ . '/../includes/header.php';
?>

<!-- Section 1: Hero -->
<section class="hero">
    <div class="container hero__grid">
        <div>
            <span class="hero__label">Smart Visa Management</span>
            <h1>Your Visa Journey,<br>Simplified.</h1>
            <p class="hero__subtitle">Expert visa guidance and document attestation assistance.</p>
            <div class="hero__actions">
                <a href="#visa-search" class="btn btn-gold">Check Visa Requirements</a>
                <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to know more about your visa services.")) ?>" class="btn btn-primary" style="background:var(--white);color:var(--visa-blue)" target="_blank" rel="noopener noreferrer">Enquire Now</a>
            </div>
        </div>
        <div class="hero__visual" aria-hidden="true">
            <svg viewBox="0 0 360 320" fill="none" xmlns="http://www.w3.org/2000/svg">
                <circle cx="180" cy="160" r="120" stroke="#EAF2FF" stroke-width="1.5" opacity="0.4"/>
                <circle cx="180" cy="160" r="90" stroke="#EAF2FF" stroke-width="1.5" opacity="0.4"/>
                <path d="M60 160a120 120 0 0 1 240 0" stroke="#F4B400" stroke-width="2" stroke-dasharray="4 8" opacity="0.7"/>
                <rect x="120" y="90" width="120" height="160" rx="12" fill="#0B3B91" stroke="#F4B400" stroke-width="2"/>
                <circle cx="180" cy="150" r="26" fill="none" stroke="#F4B400" stroke-width="2"/>
                <path d="M180 124v52M154 150h52" stroke="#F4B400" stroke-width="2"/>
                <rect x="140" y="196" width="80" height="8" rx="4" fill="#EAF2FF" opacity="0.6"/>
                <rect x="140" y="212" width="56" height="8" rx="4" fill="#EAF2FF" opacity="0.4"/>
                <path d="M255 95l25-14 8 27-27 8-6-21z" fill="#F4B400"/>
            </svg>
        </div>
    </div>
</section>

<!-- Section 2: Visa search widget -->
<section class="search-widget" id="visa-search">
    <div class="container">
        <div class="search-widget__card">
            <h2 class="search-widget__title">Find the Right Visa</h2>
            <p class="search-widget__hint">Search by destination, visa type, and nationality to check requirements.</p>
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

<!-- Section 9: Latest visa updates -->
<section class="section">
    <div class="container">
        <div class="section-heading">
            <span class="section-eyebrow">Visa Updates</span>
            <h2>Latest Visa Updates</h2>
        </div>
        <?php if ($updates): ?>
        <div class="updates-grid">
            <?php foreach ($updates as $u): ?>
            <a href="/blog/<?= e($u['slug']) ?>/" class="card">
                <div class="update-card__meta">
                    Published <?= e(date('d M Y', strtotime((string) $u['published_at']))) ?>
                    <?php if ($u['updated_at']): ?> &middot; Updated <?= e(date('d M Y', strtotime((string) $u['updated_at']))) ?><?php endif; ?>
                </div>
                <div class="card-title"><?= e($u['title']) ?></div>
            </a>
            <?php endforeach; ?>
        </div>
        <?php else: ?>
        <p class="empty-state">No visa updates have been published yet. Check back soon.</p>
        <?php endif; ?>
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
<section class="section">
    <div class="container">
        <div class="final-cta">
            <h2>Ready to start your visa journey?</h2>
            <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to start my visa journey.")) ?>" class="btn btn-gold btn-lg" target="_blank" rel="noopener noreferrer">Enquire Now</a>
        </div>
    </div>
</section>

<?php require __DIR__ . '/../includes/footer.php'; ?>
