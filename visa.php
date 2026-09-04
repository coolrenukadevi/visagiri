<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';
require __DIR__ . '/includes/db.php';
require __DIR__ . '/includes/seo.php';

$pdo = db();
$view = $_GET['view'] ?? 'services_hub';

switch ($view) {
    case 'country_hub':
        render_country_hub_view($pdo);
        break;
    case 'country':
        render_country_view($pdo, $_GET['country'] ?? '');
        break;
    case 'category':
        render_category_view($pdo, $_GET['country'] ?? '', $_GET['category'] ?? '');
        break;
    case 'services_type':
        render_type_view($pdo, $_GET['category'] ?? '');
        break;
    default:
        render_services_hub_view($pdo);
}

function render_services_hub_view(PDO $pdo): void
{
    $categories = $pdo->query('SELECT slug, name, description FROM visa_categories ORDER BY name')->fetchAll();
    $generalFaqs = general_visa_faqs();

    $breadcrumbs = [['Home', url('index.php')], ['Visa Services', null]];

    $pageTitle = 'Visa Services — Tourist, Business, Work & Family Visas | Videshia';
    $pageDescription = 'Browse Videshia visa services by type — tourist, business, work, transit, family and more. Document checklists, processing times and expert guidance for Indian travellers.';
    $schemaBlocks = [breadcrumb_schema($breadcrumbs), faq_schema(array_map(static fn($f) => ['question' => $f[0], 'answer' => $f[1]], $generalFaqs))];
    require __DIR__ . '/includes/header.php';
    ?>
    <section class="page-hero">
        <div class="container">
            <span class="eyebrow">Visa Services</span>
            <h1>Visa services, by type</h1>
            <p>Pick the visa type that matches your purpose of travel — every page includes real document checklists, process steps and current guidance across our supported destinations.</p>
        </div>
    </section>

    <div class="container"><?= render_breadcrumbs($breadcrumbs) ?></div>

    <section class="section" id="by-type">
        <div class="container">
            <div class="visa-grid">
                <?php foreach ($categories as $cat): ?>
                <a class="visa-chip" href="<?= url('visa-services/' . $cat['slug'] . '/') ?>"><h4><?= e($cat['name']) ?></h4></a>
                <?php endforeach; ?>
            </div>
            <p style="text-align:center;margin-top:24px"><a href="<?= url('visa-by-country/') ?>" style="color:var(--teal-500);font-weight:600">Prefer to browse by destination instead? View Visa by Country &rarr;</a></p>
        </div>
    </section>

    <section class="section section-alt" id="support-services">
        <div class="container">
            <div class="section-head center"><span class="eyebrow">Support Services</span><h2>Beyond the application itself</h2></div>
            <div class="grid-3">
                <?php foreach ([
                    ['Visa Documentation', 'Document review and preparation against your destination\'s exact checklist, before you submit.'],
                    ['Visa Appointment Assistance', 'Help booking and preparing for biometric or in-person appointments where your destination requires one.'],
                    ['Visa Application Support', 'End-to-end guidance completing and submitting your application correctly the first time.'],
                    ['Visa Extension', 'Guidance on extending an existing visa where the destination country permits it.'],
                    ['Visa Renewal', 'Support renewing a visa that\'s expired or approaching expiry, for eligible categories and destinations.'],
                ] as [$name, $desc]): ?>
                <div class="card">
                    <h3 style="font-size:15.5px"><?= e($name) ?></h3>
                    <p><?= e($desc) ?></p>
                </div>
                <?php endforeach; ?>
            </div>
            <p style="text-align:center;margin-top:24px"><a href="<?= url('contact/') ?>" class="btn btn-primary">Ask about a support service</a></p>
        </div>
    </section>

    <section class="section" id="requirements">
        <div class="container grid-2">
            <div>
                <span class="eyebrow">Requirements</span>
                <h2>What most visa applications need</h2>
                <p>Exact requirements vary by country and visa type — full details on each service page — but almost every application starts with:</p>
                <ul style="display:flex;flex-direction:column;gap:10px;margin-top:16px">
                    <?php foreach (['A passport valid 6+ months beyond travel', 'Passport-size photographs meeting the destination\'s spec', 'Proof of funds — bank statements or income proof', 'A clear travel itinerary or invitation letter', 'Supporting documents specific to your visa category'] as $req): ?>
                    <li style="display:flex;gap:10px;font-size:14.5px;color:var(--navy-800)"><svg style="flex-shrink:0;margin-top:3px" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#17c3c9" stroke-width="3"><path d="M4 12l5 5L20 6"/></svg><?= e($req) ?></li>
                    <?php endforeach; ?>
                </ul>
            </div>
            <div id="fees" class="card">
                <h3>Fees &amp; processing time</h3>
                <p id="processing-time">Government visa fees and processing times are set by each country and change without notice. Every visa service page on Videshia shows current indicative ranges, reviewed regularly — always confirm exact figures with your consultant before applying.</p>
                <a href="<?= url('contact/') ?>" class="btn btn-primary" style="margin-top:8px">Ask a consultant</a>
            </div>
        </div>
    </section>

    <section class="section" id="faqs">
        <div class="container" style="max-width:760px">
            <div class="section-head center"><span class="eyebrow">FAQs</span><h2>Visa FAQs</h2></div>
            <div style="display:flex;flex-direction:column;gap:14px">
                <?php foreach ($generalFaqs as [$q, $a]): ?>
                <div class="card"><h3 style="font-size:15.5px"><?= e($q) ?></h3><p style="margin:0"><?= e($a) ?></p></div>
                <?php endforeach; ?>
            </div>
        </div>
    </section>
    <?php
    require __DIR__ . '/includes/footer.php';
}

function render_country_hub_view(PDO $pdo): void
{
    $countries = $pdo->query('SELECT slug, name, region, indexable FROM countries ORDER BY region, name')->fetchAll();
    $byRegion = [];
    foreach ($countries as $c) {
        $byRegion[$c['region']][] = $c;
    }

    $breadcrumbs = [['Home', url('index.php')], ['Visa by Country', null]];
    $pageTitle = 'Visa by Country — 190+ Destinations from India | Videshia';
    $pageDescription = 'Find visa requirements, documents and processing times for your destination country. Browse Videshia\'s visa-by-country guides for Indian travellers.';
    $schemaBlocks = [breadcrumb_schema($breadcrumbs)];
    require __DIR__ . '/includes/header.php';
    ?>
    <section class="page-hero">
        <div class="container">
            <span class="eyebrow">Visa by Country</span>
            <h1>Visa services, by destination</h1>
            <p>Choose your destination country to see the visa types we support, along with requirements, fees and processing times.</p>
        </div>
    </section>

    <div class="container"><?= render_breadcrumbs($breadcrumbs) ?></div>

    <section class="section">
        <div class="container">
            <?php foreach ($byRegion as $region => $list): ?>
            <div style="margin-bottom:28px">
                <h4 style="font-size:13px;text-transform:uppercase;letter-spacing:.06em;color:var(--muted-soft);margin-bottom:12px"><?= e($region) ?></h4>
                <div style="display:flex;flex-wrap:wrap;gap:8px">
                    <?php foreach ($list as $c): ?>
                    <a href="<?= url('visa-by-country/' . $c['slug'] . '/') ?>" style="padding:7px 14px;border:1px solid var(--border);border-radius:var(--radius-full);font-size:13.5px;color:var(--navy-800);background:var(--surface)"><?= e($c['name']) ?></a>
                    <?php endforeach; ?>
                </div>
            </div>
            <?php endforeach; ?>
            <p style="text-align:center;margin-top:8px"><a href="<?= url('visa-services/') ?>" style="color:var(--teal-500);font-weight:600">Prefer to browse by visa type instead? View Visa Services &rarr;</a></p>
        </div>
    </section>
    <?php
    require __DIR__ . '/includes/footer.php';
}

function render_country_view(PDO $pdo, string $slug): void
{
    $stmt = $pdo->prepare('SELECT * FROM countries WHERE slug = ?');
    $stmt->execute([$slug]);
    $country = $stmt->fetch();

    if (!$country) {
        http_response_code(404);
        require __DIR__ . '/404.php';
        return;
    }

    $catStmt = $pdo->prepare(
        'SELECT vc.slug, vc.name, cvc.overview FROM country_visa_categories cvc
         JOIN visa_categories vc ON vc.id = cvc.visa_category_id
         WHERE cvc.country_id = ? AND cvc.indexable = 1 ORDER BY vc.name'
    );
    $catStmt->execute([$country['id']]);
    $categories = $catStmt->fetchAll();

    $relatedStmt = $pdo->prepare('SELECT slug, name FROM countries WHERE region = ? AND id != ? ORDER BY name LIMIT 6');
    $relatedStmt->execute([$country['region'], $country['id']]);
    $related = $relatedStmt->fetchAll();

    $isDeep = count($categories) > 0;
    $breadcrumbs = [['Home', url('index.php')], ['Visa by Country', url('visa-by-country/')], [$country['name'], null]];

    $pageTitle = $country['seo_title'] ?: ($country['name'] . ' Visa from India | Videshia');
    $pageDescription = $country['seo_description'];
    $robotsMeta = $country['indexable'] ? 'index, follow' : 'noindex, follow';
    $schemaBlocks = [breadcrumb_schema($breadcrumbs)];
    if ($isDeep) {
        $schemaBlocks[] = service_schema($country['name'] . ' Visa Services', $country['hero_summary'], SITE_URL . '/visa-by-country/' . $country['slug'] . '/');
    }
    require __DIR__ . '/includes/header.php';
    ?>
    <section class="page-hero">
        <div class="container">
            <span class="eyebrow"><?= e($country['region']) ?></span>
            <h1><?= e($country['name']) ?> Visa from India</h1>
            <p><?= e($country['hero_summary']) ?></p>
            <div class="hero-actions" style="justify-content:center;margin-top:22px">
                <a href="<?= url('index.php') ?>?service=visa#enquiry" class="btn btn-light btn-lg">Enquire about <?= e($country['name']) ?> visa</a>
            </div>
        </div>
    </section>

    <div class="container"><?= render_breadcrumbs($breadcrumbs) ?></div>

    <section class="section-tight">
        <div class="container">
            <div class="grid-4" style="margin-bottom:8px">
                <div class="card"><p style="font-size:12px;color:var(--muted);margin:0">Capital</p><p style="font-weight:600;color:var(--navy-900);margin:4px 0 0"><?= e($country['capital']) ?></p></div>
                <div class="card"><p style="font-size:12px;color:var(--muted);margin:0">Currency</p><p style="font-weight:600;color:var(--navy-900);margin:4px 0 0"><?= e($country['currency']) ?></p></div>
                <div class="card"><p style="font-size:12px;color:var(--muted);margin:0">Region</p><p style="font-weight:600;color:var(--navy-900);margin:4px 0 0"><?= e($country['region']) ?></p></div>
                <div class="card"><p style="font-size:12px;color:var(--muted);margin:0">ISO Code</p><p style="font-weight:600;color:var(--navy-900);margin:4px 0 0"><?= e($country['iso2']) ?></p></div>
            </div>
        </div>
    </section>

    <?php if ($isDeep): ?>
    <section class="section">
        <div class="container">
            <div class="section-head center"><span class="eyebrow">Visa Categories</span><h2>Visa types available for <?= e($country['name']) ?></h2></div>
            <div class="grid-3">
                <?php foreach ($categories as $cat): ?>
                <div class="card">
                    <h3><?= e($cat['name']) ?></h3>
                    <p><?= e(mb_strimwidth($cat['overview'], 0, 140, '…')) ?></p>
                    <a href="<?= url('visa-by-country/' . $slug . '/' . $cat['slug'] . '/') ?>" class="btn btn-ghost" style="margin-top:8px">View details &rarr;</a>
                </div>
                <?php endforeach; ?>
            </div>
        </div>
    </section>
    <?php else: ?>
    <section class="section">
        <div class="container" style="max-width:640px;text-align:center">
            <div class="card" style="padding:36px">
                <h3>Detailed visa guidance for <?= e($country['name']) ?> is being finalised</h3>
                <p>Our consultants can still help you today — share your travel purpose and we'll confirm the right visa category, documents and current fees directly.</p>
                <a href="<?= url('index.php') ?>?service=visa#enquiry" class="btn btn-primary">Enquire about <?= e($country['name']) ?></a>
            </div>
        </div>
    </section>
    <?php endif; ?>

    <?php if ($related): ?>
    <section class="section section-alt">
        <div class="container">
            <h4 style="font-size:13px;text-transform:uppercase;letter-spacing:.06em;color:var(--muted-soft);margin-bottom:14px">Other countries in <?= e($country['region']) ?></h4>
            <div style="display:flex;flex-wrap:wrap;gap:8px">
                <?php foreach ($related as $r): ?>
                <a href="<?= url('visa-by-country/' . $r['slug'] . '/') ?>" style="padding:7px 14px;border:1px solid var(--border);border-radius:var(--radius-full);font-size:13.5px;color:var(--navy-800);background:var(--surface)"><?= e($r['name']) ?></a>
                <?php endforeach; ?>
            </div>
        </div>
    </section>
    <?php endif; ?>
    <?php
    require __DIR__ . '/includes/footer.php';
}

function render_category_view(PDO $pdo, string $countrySlug, string $categorySlug): void
{
    $stmt = $pdo->prepare(
        'SELECT cvc.*, c.name AS country_name, c.slug AS country_slug, c.region, vc.name AS category_name, vc.slug AS category_slug, cvc.id AS cvc_id
         FROM country_visa_categories cvc
         JOIN countries c ON c.id = cvc.country_id
         JOIN visa_categories vc ON vc.id = cvc.visa_category_id
         WHERE c.slug = ? AND vc.slug = ? AND cvc.indexable = 1'
    );
    $stmt->execute([$countrySlug, $categorySlug]);
    $page = $stmt->fetch();

    if (!$page) {
        http_response_code(404);
        require __DIR__ . '/404.php';
        return;
    }

    $documents = json_decode($page['documents_required'], true) ?: [];
    $steps = json_decode($page['process_steps'], true) ?: [];

    $faqStmt = $pdo->prepare('SELECT question, answer FROM faqs WHERE scope_type = "country_visa" AND scope_id = ? ORDER BY sort_order');
    $faqStmt->execute([$page['cvc_id']]);
    $faqs = $faqStmt->fetchAll();

    $otherCatsStmt = $pdo->prepare(
        'SELECT vc.slug, vc.name FROM country_visa_categories cvc JOIN visa_categories vc ON vc.id = cvc.visa_category_id
         WHERE cvc.country_id = (SELECT id FROM countries WHERE slug = ?) AND vc.slug != ? AND cvc.indexable = 1 ORDER BY vc.name'
    );
    $otherCatsStmt->execute([$countrySlug, $categorySlug]);
    $otherCategories = $otherCatsStmt->fetchAll();

    $otherCountriesStmt = $pdo->prepare(
        'SELECT c.slug, c.name FROM country_visa_categories cvc JOIN countries c ON c.id = cvc.country_id
         WHERE cvc.visa_category_id = (SELECT id FROM visa_categories WHERE slug = ?) AND c.slug != ? AND cvc.indexable = 1 ORDER BY c.name LIMIT 8'
    );
    $otherCountriesStmt->execute([$categorySlug, $countrySlug]);
    $otherCountries = $otherCountriesStmt->fetchAll();

    $breadcrumbs = [
        ['Home', url('index.php')],
        ['Visa by Country', url('visa-by-country/')],
        [$page['country_name'], url('visa-by-country/' . $countrySlug . '/')],
        [$page['category_name'], null],
    ];

    $pageTitle = $page['seo_title'];
    $pageDescription = $page['seo_description'];
    $schemaBlocks = [
        breadcrumb_schema($breadcrumbs),
        service_schema($page['country_name'] . ' ' . $page['category_name'], $page['overview'], SITE_URL . '/visa-by-country/' . $countrySlug . '/' . $categorySlug . '/'),
    ];
    if ($faqs) {
        $schemaBlocks[] = faq_schema($faqs);
    }
    require __DIR__ . '/includes/header.php';
    ?>
    <section class="page-hero">
        <div class="container">
            <span class="eyebrow"><?= e($page['country_name']) ?></span>
            <h1><?= e($page['country_name']) ?> <?= e($page['category_name']) ?> from India</h1>
            <p><?= e($page['overview']) ?></p>
        </div>
    </section>

    <div class="container"><?= render_breadcrumbs($breadcrumbs) ?></div>

    <section class="section-tight">
        <div class="container grid-4">
            <div class="card"><p style="font-size:12px;color:var(--muted);margin:0">Processing Time</p><p style="font-weight:600;color:var(--navy-900);margin:4px 0 0;font-size:14px"><?= e($page['processing_time']) ?></p></div>
            <div class="card"><p style="font-size:12px;color:var(--muted);margin:0">Visa Fee (indicative)</p><p style="font-weight:600;color:var(--navy-900);margin:4px 0 0;font-size:14px"><?= e($page['visa_fee']) ?></p></div>
            <div class="card"><p style="font-size:12px;color:var(--muted);margin:0">Stay Duration</p><p style="font-weight:600;color:var(--navy-900);margin:4px 0 0;font-size:14px"><?= e($page['stay_duration']) ?></p></div>
            <div class="card"><p style="font-size:12px;color:var(--muted);margin:0">Last Reviewed</p><p style="font-weight:600;color:var(--navy-900);margin:4px 0 0;font-size:14px"><?= e(date('d M Y', strtotime($page['last_reviewed_at']))) ?></p></div>
        </div>
    </section>

    <section class="section">
        <div class="container grid-2" style="align-items:start">
            <div>
                <h2>Eligibility</h2>
                <p><?= e($page['eligibility']) ?></p>

                <h2 style="margin-top:32px">Documents Required</h2>
                <ul style="display:flex;flex-direction:column;gap:10px">
                    <?php foreach ($documents as $doc): ?>
                    <li style="display:flex;gap:10px;font-size:14.5px;color:var(--navy-800)"><svg style="flex-shrink:0;margin-top:3px" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#17c3c9" stroke-width="3"><path d="M4 12l5 5L20 6"/></svg><?= e($doc) ?></li>
                    <?php endforeach; ?>
                </ul>

                <h2 style="margin-top:32px">Entry &amp; Financial Requirements</h2>
                <p><?= e($page['entry_requirements']) ?></p>
                <p><?= e($page['financial_requirements']) ?></p>

                <h2 style="margin-top:32px">Common Rejection Reasons</h2>
                <ul style="display:flex;flex-direction:column;gap:10px">
                    <?php foreach (json_decode($page['common_rejection_reasons'], true) ?: [] as $reason): ?>
                    <li style="display:flex;gap:10px;font-size:14.5px;color:var(--navy-800)"><svg style="flex-shrink:0;margin-top:3px" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#e2564f" stroke-width="3"><path d="M12 8v5M12 16h.01M10.3 3.9L2.7 17a2 2 0 001.7 3h15.2a2 2 0 001.7-3L13.7 3.9a2 2 0 00-3.4 0z"/></svg><?= e($reason) ?></li>
                    <?php endforeach; ?>
                </ul>
            </div>

            <div>
                <div class="card" style="margin-bottom:20px">
                    <h3>Application Process</h3>
                    <div class="steps" style="grid-template-columns:1fr;gap:16px;margin-top:10px">
                        <?php foreach ($steps as $step): ?>
                        <div class="step"><p style="margin:0;font-size:14px;color:var(--navy-800)"><?= e($step) ?></p></div>
                        <?php endforeach; ?>
                    </div>
                </div>
                <div class="card card-dark">
                    <h3>Ready to apply?</h3>
                    <p>Start your <?= e($page['country_name']) ?> <?= e(strtolower($page['category_name'])) ?> enquiry — a consultant will confirm your document checklist within one business day.</p>
                    <a href="<?= url('index.php') ?>?service=visa#enquiry" class="btn btn-primary btn-block" style="margin-top:14px">Enquire Now</a>
                </div>
            </div>
        </div>
    </section>

    <?php if ($faqs): ?>
    <section class="section section-alt" id="faqs">
        <div class="container" style="max-width:760px">
            <h2>FAQs</h2>
            <div style="display:flex;flex-direction:column;gap:14px;margin-top:16px">
                <?php foreach ($faqs as $f): ?>
                <div class="card"><h3 style="font-size:15.5px"><?= e($f['question']) ?></h3><p style="margin:0"><?= e($f['answer']) ?></p></div>
                <?php endforeach; ?>
            </div>
        </div>
    </section>
    <?php endif; ?>

    <section class="section">
        <div class="container">
            <p style="text-align:center;font-size:12.5px;color:var(--muted-soft);max-width:640px;margin:0 auto 32px"><?= e($page['important_notes']) ?></p>

            <?php if ($otherCategories): ?>
            <h4 style="font-size:13px;text-transform:uppercase;letter-spacing:.06em;color:var(--muted-soft);margin-bottom:12px">Other visa types for <?= e($page['country_name']) ?></h4>
            <div style="display:flex;flex-wrap:wrap;gap:8px;margin-bottom:28px">
                <?php foreach ($otherCategories as $oc): ?>
                <a href="<?= url('visa-by-country/' . $countrySlug . '/' . $oc['slug'] . '/') ?>" style="padding:7px 14px;border:1px solid var(--border);border-radius:var(--radius-full);font-size:13.5px;color:var(--navy-800);background:var(--surface)"><?= e($oc['name']) ?></a>
                <?php endforeach; ?>
            </div>
            <?php endif; ?>

            <?php if ($otherCountries): ?>
            <h4 style="font-size:13px;text-transform:uppercase;letter-spacing:.06em;color:var(--muted-soft);margin-bottom:12px"><?= e($page['category_name']) ?> for other countries</h4>
            <div style="display:flex;flex-wrap:wrap;gap:8px">
                <?php foreach ($otherCountries as $oc): ?>
                <a href="<?= url('visa-by-country/' . $oc['slug'] . '/' . $categorySlug . '/') ?>" style="padding:7px 14px;border:1px solid var(--border);border-radius:var(--radius-full);font-size:13.5px;color:var(--navy-800);background:var(--surface)"><?= e($oc['name']) ?></a>
                <?php endforeach; ?>
            </div>
            <?php endif; ?>
        </div>
    </section>
    <?php
    require __DIR__ . '/includes/footer.php';
}

function render_type_view(PDO $pdo, string $categorySlug): void
{
    $catStmt = $pdo->prepare('SELECT * FROM visa_categories WHERE slug = ?');
    $catStmt->execute([$categorySlug]);
    $category = $catStmt->fetch();

    if (!$category) {
        http_response_code(404);
        require __DIR__ . '/404.php';
        return;
    }

    $countriesStmt = $pdo->prepare(
        'SELECT c.slug, c.name, c.region, cvc.overview FROM country_visa_categories cvc
         JOIN countries c ON c.id = cvc.country_id
         WHERE cvc.visa_category_id = ? AND cvc.indexable = 1 ORDER BY c.name'
    );
    $countriesStmt->execute([$category['id']]);
    $countries = $countriesStmt->fetchAll();

    $breadcrumbs = [['Home', url('index.php')], ['Visa Services', url('visa-services/')], [$category['name'], null]];
    $pageTitle = $category['name'] . ' — Countries &amp; Requirements | Videshia';
    $pageDescription = "Apply for a {$category['name']} to any of Videshia's supported destinations. Compare requirements, processing time and fees by country.";
    $schemaBlocks = [breadcrumb_schema($breadcrumbs)];
    require __DIR__ . '/includes/header.php';
    ?>
    <section class="page-hero">
        <div class="container">
            <span class="eyebrow">Visa Type</span>
            <h1><?= e($category['name']) ?></h1>
            <p>For <?= e($category['description']) ?></p>
        </div>
    </section>

    <div class="container"><?= render_breadcrumbs($breadcrumbs) ?></div>

    <section class="section">
        <div class="container">
            <?php if ($countries): ?>
            <div class="grid-3">
                <?php foreach ($countries as $c): ?>
                <div class="card">
                    <span class="eyebrow" style="margin-bottom:10px"><?= e($c['region']) ?></span>
                    <h3><?= e($c['name']) ?></h3>
                    <p><?= e(mb_strimwidth($c['overview'], 0, 120, '…')) ?></p>
                    <a href="<?= url('visa-by-country/' . $c['slug'] . '/' . $categorySlug . '/') ?>" class="btn btn-ghost">View details &rarr;</a>
                </div>
                <?php endforeach; ?>
            </div>
            <?php else: ?>
            <p style="text-align:center">Detailed guidance for this visa type is being added. <a href="<?= url('contact/') ?>" style="color:var(--teal-500)">Contact us</a> for help today.</p>
            <?php endif; ?>
        </div>
    </section>
    <?php
    require __DIR__ . '/includes/footer.php';
}

function general_visa_faqs(): array
{
    return [
        ['How do I know which visa category I need?', 'It depends on your purpose of travel — tourism, business, work, study or family visit. Use the visa search widget on our homepage and a consultant will confirm the right category for you.'],
        ['Can Videshia guarantee my visa will be approved?', 'No visa agency can guarantee approval — that decision rests entirely with the embassy or consulate. We help ensure your application is complete and well-documented to give you the best chance.'],
        ['How far in advance should I apply?', 'As early as possible. Processing times vary by country and can extend significantly during peak travel seasons — check the specific country page for current guidance.'],
        ['Do visa fees get refunded if my application is rejected?', 'Government visa fees are set and refunded according to that country\'s own policy, and are typically non-refundable once submitted, regardless of outcome.'],
    ];
}
