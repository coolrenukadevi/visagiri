<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';

$pageTitle = 'Videshia — Global Travel, Visa, Forex & Corporate Travel Platform';
$pageDescription = 'Your trusted partner for global travel, visa & financial travel services. Visa, flights, hotels, tours, forex and travel insurance, backed by AI-powered routing and a real consultant on every case.';
require __DIR__ . '/includes/header.php';
require __DIR__ . '/includes/enquiry.php';

$allCountries = db()->query("SELECT slug, name, region FROM countries ORDER BY region, name")->fetchAll();
$countriesByRegion = [];
foreach ($allCountries as $c) {
    $countriesByRegion[$c['region']][] = $c;
}
$allCategories = db()->query("SELECT id, slug, name FROM visa_categories ORDER BY name")->fetchAll();

$enquiryError = flash_get('error');
?>

<section class="hero">
    <div class="container" style="text-align:center;max-width:820px;margin:0 auto">
        <span class="eyebrow" style="background:rgba(23,195,201,.15);color:#8fece9">AI-Powered Visa, Travel &amp; Forex Platform</span>
        <h1>Your trusted partner for <span class="accent">global travel, visa &amp; financial travel services</span></h1>
        <p class="lead" style="margin-left:auto;margin-right:auto">Visa &middot; Flights &middot; Hotels &middot; Tours &middot; Forex &middot; Travel Insurance &middot; Corporate Travel — one platform, one consultant, real tracking.</p>
        <div class="hero-trust" style="justify-content:center">
            <span>Visa support for</span>
            <strong style="color:#fff;font-family:var(--font-head)">190+ countries</strong>
            <span>&middot;</span>
            <strong style="color:#fff;font-family:var(--font-head)">7 travel services</strong>
        </div>
    </div>

    <div class="container">
        <div class="enquiry-widget" id="enquiry">
            <div class="enquiry-tabs" role="tablist">
                <button type="button" class="enquiry-tab active" data-tab="visa">Visa</button>
                <button type="button" class="enquiry-tab" data-tab="hotel">Hotel</button>
                <button type="button" class="enquiry-tab" data-tab="flight">Flight</button>
                <button type="button" class="enquiry-tab" data-tab="tour">Tour</button>
                <button type="button" class="enquiry-tab" data-tab="insurance">Travel Insurance</button>
                <button type="button" class="enquiry-tab" data-tab="forex">Forex</button>
                <button type="button" class="enquiry-tab" data-tab="general">General Enquiry</button>
            </div>

            <form class="enquiry-form" method="post" action="<?= url('enquiry-submit.php') ?>" data-validate novalidate>
                <input type="hidden" name="csrf_token" value="<?= e(csrf_token()) ?>">
                <input type="hidden" name="service_type" id="serviceTypeInput" value="visa">

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

                <div class="enquiry-fields" data-panel="hotel" hidden>
                    <div class="enquiry-field"><label for="ef-h-dest">Destination</label><input class="form-control" type="text" id="ef-h-dest" name="destination" placeholder="City or country"></div>
                    <div class="enquiry-field"><label for="ef-h-in">Check-in</label><input class="form-control" type="date" id="ef-h-in" name="check_in"></div>
                    <div class="enquiry-field"><label for="ef-h-out">Check-out</label><input class="form-control" type="date" id="ef-h-out" name="check_out"></div>
                    <div class="enquiry-field"><label for="ef-h-rooms">Rooms</label><input class="form-control" type="number" id="ef-h-rooms" name="rooms" min="1" value="1"></div>
                    <div class="enquiry-field"><label for="ef-h-adults">Adults</label><input class="form-control" type="number" id="ef-h-adults" name="adults" min="1" value="2"></div>
                    <div class="enquiry-field"><label for="ef-h-children">Children</label><input class="form-control" type="number" id="ef-h-children" name="children" min="0" value="0"></div>
                    <div class="enquiry-field">
                        <label for="ef-h-cat">Hotel Category</label>
                        <select class="form-control" id="ef-h-cat" name="hotel_category">
                            <option>3 Star</option><option>4 Star</option><option>5 Star</option><option>Boutique / Resort</option>
                        </select>
                    </div>
                </div>

                <div class="enquiry-fields" data-panel="flight" hidden>
                    <div class="enquiry-field"><label for="ef-f-from">From</label><input class="form-control" type="text" id="ef-f-from" name="from_city" placeholder="Departure city"></div>
                    <div class="enquiry-field"><label for="ef-f-to">To</label><input class="form-control" type="text" id="ef-f-to" name="to_city" placeholder="Destination city"></div>
                    <div class="enquiry-field"><label for="ef-f-dep">Departure</label><input class="form-control" type="date" id="ef-f-dep" name="departure_date"></div>
                    <div class="enquiry-field"><label for="ef-f-ret">Return</label><input class="form-control" type="date" id="ef-f-ret" name="return_date"></div>
                    <div class="enquiry-field">
                        <label for="ef-f-trip">Trip Type</label>
                        <select class="form-control" id="ef-f-trip" name="trip_type"><option>Round-trip</option><option>One-way</option><option>Multi-city</option></select>
                    </div>
                    <div class="enquiry-field"><label for="ef-f-adults">Adults</label><input class="form-control" type="number" id="ef-f-adults" name="adults" min="1" value="1"></div>
                    <div class="enquiry-field"><label for="ef-f-children">Children</label><input class="form-control" type="number" id="ef-f-children" name="children" min="0" value="0"></div>
                    <div class="enquiry-field">
                        <label for="ef-f-cabin">Cabin Class</label>
                        <select class="form-control" id="ef-f-cabin" name="cabin_class"><option>Economy</option><option>Premium Economy</option><option>Business</option><option>First</option></select>
                    </div>
                </div>

                <div class="enquiry-fields" data-panel="tour" hidden>
                    <div class="enquiry-field"><label for="ef-t-dest">Destination</label><input class="form-control" type="text" id="ef-t-dest" name="destination" placeholder="Where to?"></div>
                    <div class="enquiry-field"><label for="ef-t-date">Travel Date</label><input class="form-control" type="date" id="ef-t-date" name="travel_date"></div>
                    <div class="enquiry-field"><label for="ef-t-duration">Duration</label><input class="form-control" type="text" id="ef-t-duration" name="duration" placeholder="e.g. 5 nights"></div>
                    <div class="enquiry-field"><label for="ef-t-pax">Travellers</label><input class="form-control" type="number" id="ef-t-pax" name="travellers" min="1" value="2"></div>
                    <div class="enquiry-field"><label for="ef-t-budget">Budget (per person)</label><input class="form-control" type="text" id="ef-t-budget" name="budget" placeholder="e.g. ₹50,000"></div>
                </div>

                <div class="enquiry-fields" data-panel="insurance" hidden>
                    <div class="enquiry-field"><label for="ef-i-dest">Destination</label><input class="form-control" type="text" id="ef-i-dest" name="destination" placeholder="Country / region"></div>
                    <div class="enquiry-field"><label for="ef-i-start">Travel Start</label><input class="form-control" type="date" id="ef-i-start" name="travel_start"></div>
                    <div class="enquiry-field"><label for="ef-i-end">Travel End</label><input class="form-control" type="date" id="ef-i-end" name="travel_end"></div>
                    <div class="enquiry-field"><label for="ef-i-count">Travellers</label><input class="form-control" type="number" id="ef-i-count" name="traveller_count" min="1" value="1"></div>
                    <div class="enquiry-field"><label for="ef-i-ages">Traveller Age(s)</label><input class="form-control" type="text" id="ef-i-ages" name="traveller_ages" placeholder="e.g. 34, 30, 5"></div>
                    <div class="enquiry-field">
                        <label for="ef-i-type">Insurance Type</label>
                        <select class="form-control" id="ef-i-type" name="insurance_type"><option>International Travel</option><option>Schengen</option><option>USA Travel</option><option>Domestic</option><option>Family / Group</option></select>
                    </div>
                </div>

                <div class="enquiry-fields" data-panel="forex" hidden>
                    <div class="enquiry-field">
                        <label for="ef-fx-currency">Currency</label>
                        <select class="form-control" id="ef-fx-currency" name="currency"><option>USD</option><option>EUR</option><option>GBP</option><option>AED</option><option>SGD</option><option>THB</option><option>AUD</option><option>Other</option></select>
                    </div>
                    <div class="enquiry-field"><label for="ef-fx-amount">Amount</label><input class="form-control" type="text" id="ef-fx-amount" name="amount" placeholder="e.g. 2,000"></div>
                    <div class="enquiry-field"><label for="ef-fx-country">Travel Country</label><input class="form-control" type="text" id="ef-fx-country" name="travel_country"></div>
                    <div class="enquiry-field"><label for="ef-fx-date">Travel Date</label><input class="form-control" type="date" id="ef-fx-date" name="travel_date"></div>
                    <div class="enquiry-field">
                        <label for="ef-fx-type">Forex Requirement</label>
                        <select class="form-control" id="ef-fx-type" name="forex_type"><option>Currency Notes</option><option>Forex Card</option><option>Both</option></select>
                    </div>
                </div>

                <div class="enquiry-fields" data-panel="general" hidden>
                    <div class="enquiry-field">
                        <label for="ef-g-service">Service</label>
                        <select class="form-control" id="ef-g-service" name="subject"><option>Visa</option><option>Tours</option><option>Hotels</option><option>Flights</option><option>Forex</option><option>Travel Insurance</option><option>Corporate Travel</option><option>Other</option></select>
                    </div>
                    <div class="enquiry-field" style="grid-column:1/-1"><label for="ef-g-msg">Message</label><textarea class="form-control" id="ef-g-msg" name="message" rows="1" placeholder="How can we help?"></textarea></div>
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
        <div class="stat"><strong>7</strong><span>Services under one roof</span></div>
        <div class="stat"><strong>24/7</strong><span>Consultant &amp; agent support</span></div>
    </div>
</section>

<section class="section" id="platform">
    <div class="container">
        <div class="section-head center">
            <span class="eyebrow">Platform</span>
            <h2>One platform, three ways of working</h2>
            <p>Videshia blends AI decisioning with human oversight so nothing slips through — from the first enquiry to visa in hand.</p>
        </div>
        <div class="grid-3">
            <div class="card">
                <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 12h13M13 6l6 6-6 6"/></svg></div>
                <h3>Intelligent routing</h3>
                <p>Every applicant is matched to the correct visa category, embassy rules and document checklist the moment they apply — no manual triage.</p>
            </div>
            <div class="card">
                <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="16" rx="2"/><path d="M3 9h18M8 3v4M16 3v4"/></svg></div>
                <h3>Autonomous agents</h3>
                <p>Purpose-built AI agents verify documents, flag gaps, chase embassies and keep applicants updated — around the clock, without human bottlenecks.</p>
            </div>
            <div class="card">
                <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M3 12h18M12 3c2.5 2.7 3.8 6 3.8 9s-1.3 6.3-3.8 9c-2.5-2.7-3.8-6-3.8-9s1.3-6.3 3.8-9z"/></svg></div>
                <h3>Global vision</h3>
                <p>Live embassy rule changes, processing-time benchmarks and success-rate analytics across 190+ destinations in one dashboard.</p>
            </div>
        </div>
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
            <a class="visa-chip" href="<?= url('visa/type/' . $cat['slug'] . '/') ?>">
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
                <h3>AI routes your case</h3>
                <p>Our routing engine matches you to the correct category, checklist and embassy requirements.</p>
            </div>
            <div class="step">
                <h3>Agents prepare & file</h3>
                <p>Autonomous agents verify documents, complete forms and submit your application on time.</p>
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

<section class="section">
    <div class="container">
        <div class="cta-band">
            <div>
                <h2>Ready to move visas at AI speed?</h2>
                <p>Create your free Videshia account and route your first application in minutes.</p>
            </div>
            <div class="cta-actions">
                <a href="<?= url('signup.php') ?>" class="btn btn-light btn-lg">Create free account</a>
                <a href="<?= url('contact.php') ?>" class="btn btn-outline-light btn-lg">Talk to sales</a>
            </div>
        </div>
    </div>
</section>

<?php require __DIR__ . '/includes/footer.php'; ?>
