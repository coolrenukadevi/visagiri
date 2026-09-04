<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';

// Read before header.php, which also drains a generic 'error' flash for pages
// that don't handle it themselves — this page shows it inline instead.
$enquiryError = flash_get('error');

$pageTitle = 'Videshia — Premium Visa Consultancy for Indian Travellers';
$pageDescription = 'Videshia is a premium visa consultancy for Indian travellers, covering 190+ destinations across tourist, business, work, family and other visa categories — with document review and a named consultant on every case.';
require __DIR__ . '/includes/header.php';
require __DIR__ . '/includes/enquiry.php';

$allCountries = db()->query("SELECT slug, name, region FROM countries ORDER BY region, name")->fetchAll();
$countriesByRegion = [];
foreach ($allCountries as $c) {
    $countriesByRegion[$c['region']][] = $c;
}
$allCategories = db()->query("SELECT id, slug, name FROM visa_categories ORDER BY name")->fetchAll();
?>

<section class="hero">
    <div class="container" style="text-align:center;max-width:820px;margin:0 auto">
        <span class="eyebrow" style="background:rgba(23,195,201,.15);color:#8fece9">Premium Visa Consultancy</span>
        <h1>Your visa, <span class="accent">handled by real consultants</span></h1>
        <p class="lead" style="margin-left:auto;margin-right:auto">Tourist, business, work, family and more — document review, application support and a named consultant on every case.</p>
        <div class="hero-trust" style="justify-content:center">
            <span>Visa support for</span>
            <strong style="color:#fff;font-family:var(--font-head)">190+ countries</strong>
            <span>&middot;</span>
            <strong style="color:#fff;font-family:var(--font-head)">9 visa categories</strong>
        </div>
    </div>

    <div class="container">
        <div class="enquiry-widget" id="visa-search">
            <form class="enquiry-form" method="get" action="<?= url('visa-search.php') ?>">
                <h2 style="font-size:17px;margin:0 0 4px">Check your visa requirements</h2>
                <p style="font-size:13.5px;color:var(--muted);margin:0 0 18px">Tell us your destination and purpose of travel — we'll take you straight to the right visa guide.</p>
                <div class="enquiry-fields">
                    <div class="enquiry-field">
                        <label for="vs-country">Country</label>
                        <select class="form-control" id="vs-country" name="country" required>
                            <option value="">Select destination</option>
                            <?php foreach ($countriesByRegion as $region => $countries): ?>
                            <optgroup label="<?= e($region) ?>">
                                <?php foreach ($countries as $c): ?>
                                <option value="<?= e($c['slug']) ?>"><?= e($c['name']) ?></option>
                                <?php endforeach; ?>
                            </optgroup>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="enquiry-field">
                        <label for="vs-type">Visa Type</label>
                        <select class="form-control" id="vs-type" name="visa_type" required>
                            <option value="">Select visa type</option>
                            <?php foreach ($allCategories as $cat): ?>
                            <option value="<?= e($cat['slug']) ?>"><?= e($cat['name']) ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="enquiry-field">
                        <label for="vs-city">Applicant City</label>
                        <input class="form-control" type="text" id="vs-city" name="applicant_city" list="vs-city-list" placeholder="e.g. Delhi, Mumbai">
                        <datalist id="vs-city-list">
                            <?php foreach (['Delhi', 'Mumbai', 'Bengaluru', 'Chennai', 'Kolkata', 'Hyderabad', 'Pune', 'Ahmedabad', 'Jaipur', 'Chandigarh'] as $city): ?>
                            <option value="<?= e($city) ?>">
                            <?php endforeach; ?>
                        </datalist>
                    </div>
                    <div class="enquiry-field">
                        <label for="vs-purpose">Purpose of Travel</label>
                        <select class="form-control" id="vs-purpose" name="purpose">
                            <option>Tourism / Holiday</option>
                            <option>Business</option>
                            <option>Employment / Work</option>
                            <option>Family Visit</option>
                            <option>Medical Treatment</option>
                            <option>Conference / Event</option>
                            <option>Education / Study</option>
                            <option>Transit</option>
                            <option>Official / Government</option>
                        </select>
                    </div>
                    <div class="enquiry-field"><label for="vs-date">Travel Date</label><input class="form-control" type="date" id="vs-date" name="travel_date"></div>
                </div>
                <div class="enquiry-submit-row">
                    <button type="submit" class="btn btn-primary btn-lg">Check Visa Requirements</button>
                    <p>We'll take you straight to your destination's visa guide.</p>
                </div>
            </form>
        </div>
    </div>
</section>

<section class="section" id="enquiry">
    <div class="container" style="max-width:720px">
        <div class="section-head center">
            <span class="eyebrow">Start Your Application</span>
            <h2>Start your visa enquiry</h2>
            <p>Share a few details and a consultant will confirm your requirements and next steps.</p>
        </div>
        <div class="enquiry-widget">
            <form class="enquiry-form" method="post" action="<?= url('enquiry-submit.php') ?>" data-validate novalidate>
                <input type="hidden" name="csrf_token" value="<?= e(csrf_token()) ?>">
                <input type="hidden" name="service_type" value="visa">

                <?php if ($enquiryError): ?>
                    <div class="alert alert-error"><?= e($enquiryError) ?></div>
                <?php endif; ?>

                <div class="enquiry-fields" data-panel="visa">
                    <div class="enquiry-field">
                        <label for="ef-country">Country</label>
                        <select class="form-control" id="ef-country" name="country">
                            <?php foreach ($countriesByRegion as $region => $countries): ?>
                            <optgroup label="<?= e($region) ?>">
                                <?php foreach ($countries as $c): ?>
                                <option value="<?= e($c['slug']) ?>" <?= $c['slug'] === 'usa' ? 'selected' : '' ?>><?= e($c['name']) ?></option>
                                <?php endforeach; ?>
                            </optgroup>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="enquiry-field">
                        <label for="ef-visa-type">Visa Type</label>
                        <select class="form-control" id="ef-visa-type" name="visa_category_id">
                            <?php foreach ($allCategories as $cat): ?>
                            <option value="<?= (int) $cat['id'] ?>"><?= e($cat['name']) ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="enquiry-field"><label for="ef-visa-date">Travel Date</label><input class="form-control" type="date" id="ef-visa-date" name="travel_date"></div>
                    <div class="enquiry-field"><label for="ef-visa-pax">Travellers</label><input class="form-control" type="number" id="ef-visa-pax" name="travellers_count" min="1" value="1"></div>
                    <div class="enquiry-field"><label for="ef-nationality">Nationality</label><input class="form-control" type="text" id="ef-nationality" name="nationality" value="Indian"></div>
                </div>

                <div class="enquiry-contact-row">
                    <div class="enquiry-field"><label for="ef-name">Full Name</label><input class="form-control" type="text" id="ef-name" name="name" required></div>
                    <div class="enquiry-field"><label for="ef-mobile">Mobile</label><input class="form-control" type="tel" id="ef-mobile" name="mobile" placeholder="+91"></div>
                    <div class="enquiry-field"><label for="ef-email">Email</label><input class="form-control" type="email" id="ef-email" name="email"></div>
                </div>

                <div class="enquiry-submit-row">
                    <button type="submit" class="btn btn-primary btn-lg">Submit Enquiry</button>
                    <p>You'll get a reference number instantly — no spam, ever.</p>
                </div>
            </form>
        </div>
    </div>
</section>

<section class="stats-bar">
    <div class="container stats-grid">
        <div class="stat"><strong>190+</strong><span>Countries covered</span></div>
        <div class="stat"><strong>9</strong><span>Visa categories supported</span></div>
        <div class="stat"><strong>1:1</strong><span>Named consultant per case</span></div>
        <div class="stat"><strong>24/7</strong><span>Consultant &amp; agent support</span></div>
    </div>
</section>

<section class="section section-alt" id="services">
    <div class="container">
        <div class="section-head center">
            <span class="eyebrow">Visa services</span>
            <h2>Every visa category, one workflow</h2>
            <p>Whether it's a single traveller or a partner agency managing thousands of cases, Videshia adapts to the visa type automatically.</p>
        </div>
        <?php
        $categoryIcons = [
            'tourist' => '<path d="M12 2v20M2 12h20"/><circle cx="12" cy="12" r="9"/>',
            'business' => '<rect x="3" y="7" width="18" height="13" rx="2"/><path d="M8 7V5a2 2 0 012-2h4a2 2 0 012 2v2"/>',
            'transit' => '<path d="M3 12h18M3 6h18M3 18h18"/>',
            'medical' => '<path d="M12 2v20M2 12h20"/>',
            'family' => '<path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 00-3-3.87M16 3.13a4 4 0 010 7.75"/>',
            'conference' => '<path d="M20 7h-9M14 17H5M5 7h1M18 17h1"/><circle cx="17" cy="7" r="2"/><circle cx="7" cy="17" r="2"/>',
            'employment' => '<path d="M22 10L12 5 2 10l10 5 10-5z"/><path d="M6 12v5c0 1.5 3 3 6 3s6-1.5 6-3v-5"/>',
            'dependent' => '<path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/>',
            'official' => '<rect x="3" y="4" width="18" height="16" rx="2"/><path d="M3 9h18"/>',
        ];
        ?>
        <div class="visa-grid">
            <?php foreach ($allCategories as $cat): ?>
            <a class="visa-chip" href="<?= url('visa-services/' . $cat['slug'] . '/') ?>">
                <div class="card-icon"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><?= $categoryIcons[$cat['slug']] ?? '<circle cx="12" cy="12" r="9"/>' ?></svg></div>
                <h4><?= e($cat['name']) ?></h4>
            </a>
            <?php endforeach; ?>
        </div>
    </div>
</section>

<section class="section" id="how-it-works">
    <div class="container">
        <div class="section-head center">
            <span class="eyebrow">How it works</span>
            <h2>From enquiry to visa, in four steps</h2>
        </div>
        <div class="steps">
            <div class="step">
                <h3>Tell us where you're headed</h3>
                <p>Share destination, purpose and travel dates — Videshia identifies the exact visa pathway.</p>
            </div>
            <div class="step">
                <h3>We match your case</h3>
                <p>Your consultant confirms the correct visa category, checklist and embassy requirements for your trip.</p>
            </div>
            <div class="step">
                <h3>We prepare & file</h3>
                <p>Our team reviews your documents, helps complete your forms and supports your application through to submission.</p>
            </div>
            <div class="step">
                <h3>Track in real time</h3>
                <p>Get live status updates until your visa is approved, with a human specialist on standby.</p>
            </div>
        </div>
    </div>
</section>

<section class="section section-alt">
    <div class="container">
        <div class="section-head center">
            <span class="eyebrow">Why Videshia</span>
            <h2>What you get that a search engine can't offer</h2>
        </div>
        <div class="grid-3">
            <div class="card">
                <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/></svg></div>
                <h3>A named consultant, not a queue</h3>
                <p>Every enquiry is assigned to a consultant who owns your case end-to-end — not a rotating support inbox.</p>
            </div>
            <div class="card">
                <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 11l3 3L22 4"/><path d="M21 12v7a2 2 0 01-2 2H5a2 2 0 01-2-2V5a2 2 0 012-2h11"/></svg></div>
                <h3>A checklist before you apply, not after rejection</h3>
                <p>Documents are reviewed against the destination's actual requirements before submission, to catch gaps early.</p>
            </div>
            <div class="card">
                <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="16" rx="2"/><path d="M3 9h18M8 3v4M16 3v4"/></svg></div>
                <h3>One reference number, full visibility</h3>
                <p>Every enquiry gets a tracked reference number the moment you submit it — visa, hotel, flight, forex or insurance.</p>
            </div>
        </div>
        <p style="text-align:center;font-size:12.5px;color:var(--muted-soft);margin-top:32px">Videshia does not guarantee visa approval or specific processing times — those decisions rest with the relevant embassy, consulate or government authority.</p>
    </div>
</section>

<section class="section section-alt">
    <div class="container">
        <div class="section-head center">
            <span class="eyebrow">Nationwide Coverage</span>
            <h2>Visa consultancy support, wherever you are in India</h2>
            <p>No branch visit required — Videshia supports applicants across every Indian state and union territory through online consultation.</p>
        </div>
        <?php
        $homepageStateSlugs = ['delhi', 'maharashtra', 'karnataka', 'tamil-nadu', 'west-bengal', 'telangana', 'gujarat', 'uttar-pradesh', 'punjab', 'bihar', 'rajasthan', 'kerala'];
        $placeholders = implode(',', array_fill(0, count($homepageStateSlugs), '?'));
        $homepageStatesStmt = db()->prepare("SELECT slug, name FROM states WHERE indexable = 1 AND slug IN ($placeholders) ORDER BY name");
        $homepageStatesStmt->execute($homepageStateSlugs);
        $homepageStates = $homepageStatesStmt->fetchAll();
        ?>
        <div style="display:flex;flex-wrap:wrap;gap:8px;justify-content:center">
            <?php foreach ($homepageStates as $s): ?>
            <a href="<?= url('states/' . $s['slug'] . '/') ?>" style="padding:8px 16px;border:1px solid var(--border);border-radius:var(--radius-full);font-size:13.5px;color:var(--navy-800);background:var(--surface)"><?= e($s['name']) ?></a>
            <?php endforeach; ?>
        </div>
        <p style="text-align:center;margin-top:20px"><a href="<?= url('visa-consultants-india/') ?>" style="color:var(--teal-500);font-weight:600">View all states &amp; union territories &rarr;</a></p>
    </div>
</section>

<section class="section">
    <div class="container">
        <div class="cta-band">
            <div>
                <h2>Ready to start your visa application?</h2>
                <p>Create your free Videshia account to submit enquiries and track your application in one place.</p>
            </div>
            <div class="cta-actions">
                <a href="<?= url('signup.php') ?>" class="btn btn-light btn-lg">Create free account</a>
                <a href="<?= url('contact/') ?>" class="btn btn-outline-light btn-lg">Talk to a consultant</a>
            </div>
        </div>
    </div>
</section>

<?php require __DIR__ . '/includes/footer.php'; ?>
