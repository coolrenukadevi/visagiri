<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';
require __DIR__ . '/includes/db.php';
require __DIR__ . '/includes/seo.php';

$pdo = db();
$view = $_GET['view'] ?? 'hub';

switch ($view) {
    case 'states_index':
        render_states_index_view($pdo);
        break;
    case 'state':
        render_state_view($pdo, $_GET['state'] ?? '');
        break;
    case 'cities_index':
        render_cities_index_view($pdo);
        break;
    case 'city':
        render_city_view($pdo, $_GET['city'] ?? '');
        break;
    default:
        render_national_hub_view($pdo);
}

function zone_order(): array
{
    return ['North', 'South', 'East', 'West', 'Central', 'Northeast'];
}

function group_states_by_zone(array $states): array
{
    $byZone = [];
    foreach ($states as $s) {
        $byZone[$s['zone']][] = $s;
    }
    $ordered = [];
    foreach (zone_order() as $zone) {
        if (isset($byZone[$zone])) {
            $ordered[$zone] = $byZone[$zone];
        }
    }
    return $ordered;
}

function render_national_hub_view(PDO $pdo): void
{
    $states = $pdo->query('SELECT slug, name, type, capital, zone FROM states WHERE indexable = 1 ORDER BY zone, name')->fetchAll();
    $byZone = group_states_by_zone($states);
    $categories = $pdo->query('SELECT slug, name FROM visa_categories ORDER BY name')->fetchAll();
    $cities = $pdo->query('SELECT slug, name FROM cities WHERE indexable = 1 ORDER BY name')->fetchAll();

    $breadcrumbs = [['Home', url('index.php')], ['Visa Consultants Across India', null]];
    $pageTitle = 'Visa Consultants Across India | Visa Agency & Consultancy Services | Videshia';
    $pageDescription = 'Videshia provides visa consultancy, documentation and application support to applicants across every Indian state and union territory, for 190+ destination countries.';
    $hubFaqs = national_hub_faqs();
    $schemaBlocks = [
        breadcrumb_schema($breadcrumbs),
        professional_service_schema('Videshia Visa Consultancy', $pageDescription, SITE_URL . '/visa-consultants-india/', ['India']),
        faq_schema(array_map(static fn($f) => ['question' => $f[0], 'answer' => $f[1]], $hubFaqs)),
    ];
    require __DIR__ . '/includes/header.php';
    ?>
    <section class="page-hero">
        <div class="container">
            <span class="eyebrow">Visa Consultants Across India</span>
            <h1>Visa consultant &amp; visa agency services, wherever you are in India</h1>
            <p>Videshia supports visa applicants across every Indian state and union territory through online consultation, document review and application support — no branch visit required.</p>
        </div>
    </section>

    <div class="container"><?= render_breadcrumbs($breadcrumbs) ?></div>

    <section class="section">
        <div class="container">
            <div class="section-head center"><span class="eyebrow">Browse by Location</span><h2>Find visa consultancy support in your state</h2></div>
            <?php foreach ($byZone as $zone => $list): ?>
            <div style="margin-bottom:28px">
                <h4 style="font-size:13px;text-transform:uppercase;letter-spacing:.06em;color:var(--muted-soft);margin-bottom:12px"><?= e($zone) ?> India</h4>
                <div style="display:flex;flex-wrap:wrap;gap:8px">
                    <?php foreach ($list as $s): ?>
                    <a href="<?= url('states/' . $s['slug'] . '/') ?>" style="padding:7px 14px;border:1px solid var(--border);border-radius:var(--radius-full);font-size:13.5px;color:var(--navy-800);background:var(--surface)"><?= e($s['name']) ?></a>
                    <?php endforeach; ?>
                </div>
            </div>
            <?php endforeach; ?>
        </div>
    </section>

    <section class="section section-alt">
        <div class="container">
            <div class="section-head center"><span class="eyebrow">Popular Cities</span><h2>Or find your city directly</h2></div>
            <div style="display:flex;flex-wrap:wrap;gap:8px;justify-content:center">
                <?php foreach ($cities as $c): ?>
                <a href="<?= url('cities/' . $c['slug'] . '/') ?>" style="padding:7px 14px;border:1px solid var(--border);border-radius:var(--radius-full);font-size:13.5px;color:var(--navy-800);background:var(--surface)"><?= e($c['name']) ?></a>
                <?php endforeach; ?>
            </div>
            <p style="text-align:center;margin-top:16px"><a href="<?= url('cities/') ?>" style="color:var(--teal-500);font-weight:600">View all cities &rarr;</a></p>
        </div>
    </section>

    <section class="section">
        <div class="container grid-2">
            <div class="card">
                <h3>Browse by Visa Type</h3>
                <p>Tourist, business, work, family and more.</p>
                <div style="display:flex;flex-wrap:wrap;gap:8px;margin-top:12px">
                    <?php foreach ($categories as $cat): ?>
                    <a href="<?= url('visa-services/' . $cat['slug'] . '/') ?>" style="padding:6px 12px;border:1px solid var(--border);border-radius:var(--radius-full);font-size:13px;color:var(--navy-800);background:var(--surface)"><?= e($cat['name']) ?></a>
                    <?php endforeach; ?>
                </div>
            </div>
            <div class="card">
                <h3>Browse by Visa Destination</h3>
                <p>190+ countries, with deep guidance for our most-requested destinations.</p>
                <a href="<?= url('visa-by-country/') ?>" class="btn btn-primary" style="margin-top:12px">View Visa by Country &rarr;</a>
            </div>
        </div>
    </section>

    <section class="section">
        <div class="container" style="max-width:760px">
            <div class="section-head center"><span class="eyebrow">FAQs</span><h2>Visa consultancy across India — FAQs</h2></div>
            <div style="display:flex;flex-direction:column;gap:14px">
                <?php foreach ($hubFaqs as [$q, $a]): ?>
                <div class="card"><h3 style="font-size:15.5px"><?= e($q) ?></h3><p style="margin:0"><?= e($a) ?></p></div>
                <?php endforeach; ?>
            </div>
        </div>
    </section>

    <section class="section section-alt">
        <div class="container" style="max-width:720px;text-align:center">
            <div class="card card-dark" style="padding:36px">
                <h3>Start your visa enquiry today</h3>
                <p>Wherever you're applying from in India, share your destination and purpose of travel — a consultant will take it from there.</p>
                <a href="<?= url('enquiry/') ?>" class="btn btn-primary" style="margin-top:10px">Start Your Visa Enquiry</a>
            </div>
        </div>
    </section>
    <?php
    require __DIR__ . '/includes/footer.php';
}

function render_states_index_view(PDO $pdo): void
{
    $states = $pdo->query('SELECT slug, name, type, capital, zone FROM states WHERE indexable = 1 ORDER BY zone, name')->fetchAll();
    $byZone = group_states_by_zone($states);

    $breadcrumbs = [['Home', url('index.php')], ['Visa Consultants Across India', url('visa-consultants-india/')], ['States & Union Territories', null]];
    $pageTitle = 'Visa Consultant by State — All Indian States & Union Territories | Videshia';
    $pageDescription = 'Browse Videshia visa consultancy and visa agency services by Indian state or union territory.';
    $schemaBlocks = [breadcrumb_schema($breadcrumbs)];
    require __DIR__ . '/includes/header.php';
    ?>
    <section class="page-hero">
        <div class="container">
            <span class="eyebrow">States &amp; Union Territories</span>
            <h1>Visa consultant services, by state</h1>
            <p>Select your state or union territory to see how Videshia supports applicants there.</p>
        </div>
    </section>

    <div class="container"><?= render_breadcrumbs($breadcrumbs) ?></div>

    <section class="section">
        <div class="container">
            <?php foreach ($byZone as $zone => $list): ?>
            <div style="margin-bottom:28px">
                <h4 style="font-size:13px;text-transform:uppercase;letter-spacing:.06em;color:var(--muted-soft);margin-bottom:12px"><?= e($zone) ?> India</h4>
                <div style="display:flex;flex-wrap:wrap;gap:8px">
                    <?php foreach ($list as $s): ?>
                    <a href="<?= url('states/' . $s['slug'] . '/') ?>" style="padding:7px 14px;border:1px solid var(--border);border-radius:var(--radius-full);font-size:13.5px;color:var(--navy-800);background:var(--surface)"><?= e($s['name']) ?><?= $s['type'] === 'Union Territory' ? ' (UT)' : '' ?></a>
                    <?php endforeach; ?>
                </div>
            </div>
            <?php endforeach; ?>
        </div>
    </section>
    <?php
    require __DIR__ . '/includes/footer.php';
}

function render_state_view(PDO $pdo, string $slug): void
{
    $stmt = $pdo->prepare('SELECT * FROM states WHERE slug = ?');
    $stmt->execute([$slug]);
    $state = $stmt->fetch();

    if (!$state) {
        http_response_code(404);
        require __DIR__ . '/404.php';
        return;
    }

    $cities = json_decode($state['major_cities'], true) ?: [];
    $categories = $pdo->query('SELECT slug, name FROM visa_categories ORDER BY name')->fetchAll();

    $cityPagesStmt = $pdo->prepare('SELECT slug, name FROM cities WHERE state_id = ? AND indexable = 1 ORDER BY name');
    $cityPagesStmt->execute([$state['id']]);
    $cityPageByName = array_column($cityPagesStmt->fetchAll(), 'slug', 'name');

    $relatedStmt = $pdo->prepare('SELECT slug, name FROM states WHERE zone = ? AND id != ? AND indexable = 1 ORDER BY name LIMIT 6');
    $relatedStmt->execute([$state['zone'], $state['id']]);
    $related = $relatedStmt->fetchAll();

    $breadcrumbs = [['Home', url('index.php')], ['Visa Consultants Across India', url('visa-consultants-india/')], [$state['name'], null]];
    $pageTitle = $state['seo_title'];
    $pageDescription = $state['seo_description'];
    $robotsMeta = $state['indexable'] ? 'index, follow' : 'noindex, follow';
    $stateFaqs = state_faqs($state['name']);
    $schemaBlocks = [
        breadcrumb_schema($breadcrumbs),
        professional_service_schema(
            'Videshia Visa Consultancy — ' . $state['name'],
            $pageDescription,
            SITE_URL . '/states/' . $state['slug'] . '/',
            [$state['name']]
        ),
        faq_schema(array_map(static fn($f) => ['question' => $f[0], 'answer' => $f[1]], $stateFaqs)),
    ];
    require __DIR__ . '/includes/header.php';
    ?>
    <section class="page-hero">
        <div class="container">
            <span class="eyebrow"><?= e($state['zone']) ?> India &middot; <?= e($state['type']) ?></span>
            <h1>Visa Consultant in <?= e($state['name']) ?></h1>
            <p>Videshia provides visa consultancy, documentation and application support to applicants across <?= e($state['name']) ?>, including <?= e(implode(', ', array_slice($cities, 0, 3))) ?> and surrounding areas — for 190+ destination countries, with a named consultant on every case.</p>
            <div class="hero-actions" style="justify-content:center;margin-top:22px">
                <a href="<?= url('enquiry/') ?>" class="btn btn-light btn-lg">Start Your Visa Enquiry</a>
            </div>
        </div>
    </section>

    <div class="container"><?= render_breadcrumbs($breadcrumbs) ?></div>

    <section class="section-tight">
        <div class="container">
            <div class="grid-4" style="margin-bottom:8px">
                <div class="card"><p style="font-size:12px;color:var(--muted);margin:0">Type</p><p style="font-weight:600;color:var(--navy-900);margin:4px 0 0"><?= e($state['type']) ?></p></div>
                <div class="card"><p style="font-size:12px;color:var(--muted);margin:0">Capital</p><p style="font-weight:600;color:var(--navy-900);margin:4px 0 0"><?= e($state['capital']) ?></p></div>
                <div class="card"><p style="font-size:12px;color:var(--muted);margin:0">Zone</p><p style="font-weight:600;color:var(--navy-900);margin:4px 0 0"><?= e($state['zone']) ?> India</p></div>
                <div class="card"><p style="font-size:12px;color:var(--muted);margin:0">Cities Served</p><p style="font-weight:600;color:var(--navy-900);margin:4px 0 0"><?= count($cities) ?>+</p></div>
            </div>
        </div>
    </section>

    <section class="section" id="services">
        <div class="container">
            <div class="section-head center"><span class="eyebrow">Support Services</span><h2>Visa services available in <?= e($state['name']) ?></h2></div>
            <div class="grid-3">
                <?php foreach ([
                    ['Visa Documentation', 'Document review and preparation against your destination\'s exact checklist, before you submit.'],
                    ['Visa Application Support', 'End-to-end guidance completing and submitting your application correctly the first time.'],
                    ['Visa Appointment Assistance', 'Help booking and preparing for biometric or in-person appointments where your destination requires one.'],
                    ['Visa Extension & Renewal', 'Guidance on extending or renewing an existing visa where the destination permits it.'],
                ] as [$name, $desc]): ?>
                <div class="card"><h3 style="font-size:15.5px"><?= e($name) ?></h3><p><?= e($desc) ?></p></div>
                <?php endforeach; ?>
            </div>
        </div>
    </section>

    <section class="section section-alt">
        <div class="container grid-2" style="align-items:start">
            <div>
                <h2>Visa categories we handle</h2>
                <p>The same visa categories, wherever you're applying from in <?= e($state['name']) ?>:</p>
                <div style="display:flex;flex-wrap:wrap;gap:8px;margin-top:14px">
                    <?php foreach ($categories as $cat): ?>
                    <a href="<?= url('visa-services/' . $cat['slug'] . '/') ?>" style="padding:7px 14px;border:1px solid var(--border);border-radius:var(--radius-full);font-size:13.5px;color:var(--navy-800);background:var(--surface)"><?= e($cat['name']) ?></a>
                    <?php endforeach; ?>
                </div>
                <p style="margin-top:16px"><a href="<?= url('visa-by-country/') ?>" style="color:var(--teal-500);font-weight:600">Browse all 190+ visa destinations &rarr;</a></p>
            </div>
            <div class="card">
                <h3>Cities we serve in <?= e($state['name']) ?></h3>
                <p>
                    <?php foreach ($cities as $i => $cityName): ?><?= $i > 0 ? ', ' : '' ?><?php if (isset($cityPageByName[$cityName])): ?><a href="<?= url('cities/' . $cityPageByName[$cityName] . '/') ?>" style="color:var(--teal-500);font-weight:600"><?= e($cityName) ?></a><?php else: ?><?= e($cityName) ?><?php endif; ?><?php endforeach; ?>
                    and surrounding areas.
                </p>
            </div>
        </div>
    </section>

    <section class="section">
        <div class="container grid-2" style="align-items:center">
            <div>
                <h2>How Videshia serves applicants in <?= e($state['name']) ?></h2>
                <p>Videshia does not require a branch visit — your entire application can be handled online, by phone or over WhatsApp, with documents exchanged digitally or by courier where originals are needed.</p>
                <p>Every enquiry is reviewed and assigned to a named consultant, who confirms your visa category, document checklist and next steps directly with you.</p>
            </div>
            <div class="card card-dark">
                <h3>Talk to a consultant</h3>
                <p>Share your destination and purpose of travel — we'll confirm exactly what you need.</p>
                <a href="<?= url('enquiry/') ?>" class="btn btn-primary btn-block" style="margin-top:14px">Start Your Visa Enquiry</a>
            </div>
        </div>
    </section>

    <section class="section section-alt" id="faqs">
        <div class="container" style="max-width:760px">
            <div class="section-head center"><span class="eyebrow">FAQs</span><h2>Visa consultant in <?= e($state['name']) ?> — FAQs</h2></div>
            <div style="display:flex;flex-direction:column;gap:14px">
                <?php foreach ($stateFaqs as [$q, $a]): ?>
                <div class="card"><h3 style="font-size:15.5px"><?= e($q) ?></h3><p style="margin:0"><?= e($a) ?></p></div>
                <?php endforeach; ?>
            </div>
        </div>
    </section>

    <?php if ($related): ?>
    <section class="section">
        <div class="container">
            <h4 style="font-size:13px;text-transform:uppercase;letter-spacing:.06em;color:var(--muted-soft);margin-bottom:14px">Other states in <?= e($state['zone']) ?> India</h4>
            <div style="display:flex;flex-wrap:wrap;gap:8px">
                <?php foreach ($related as $r): ?>
                <a href="<?= url('states/' . $r['slug'] . '/') ?>" style="padding:7px 14px;border:1px solid var(--border);border-radius:var(--radius-full);font-size:13.5px;color:var(--navy-800);background:var(--surface)"><?= e($r['name']) ?></a>
                <?php endforeach; ?>
            </div>
            <p style="margin-top:16px"><a href="<?= url('visa-consultants-india/') ?>" style="color:var(--teal-500);font-weight:600">View all states &amp; union territories &rarr;</a></p>
        </div>
    </section>
    <?php endif; ?>
    <?php
    require __DIR__ . '/includes/footer.php';
}

function render_cities_index_view(PDO $pdo): void
{
    $cities = $pdo->query(
        'SELECT c.slug, c.name, s.name AS state_name, s.slug AS state_slug, s.zone
         FROM cities c JOIN states s ON s.id = c.state_id
         WHERE c.indexable = 1 ORDER BY s.zone, c.name'
    )->fetchAll();
    $byZone = [];
    foreach ($cities as $c) {
        $byZone[$c['zone']][] = $c;
    }
    $ordered = [];
    foreach (zone_order() as $zone) {
        if (isset($byZone[$zone])) {
            $ordered[$zone] = $byZone[$zone];
        }
    }

    $breadcrumbs = [['Home', url('index.php')], ['Visa Consultants Across India', url('visa-consultants-india/')], ['Cities', null]];
    $pageTitle = 'Visa Consultant by City — Major Indian Cities | Videshia';
    $pageDescription = 'Browse Videshia visa consultancy and visa agency services by major Indian city.';
    $schemaBlocks = [breadcrumb_schema($breadcrumbs)];
    require __DIR__ . '/includes/header.php';
    ?>
    <section class="page-hero">
        <div class="container">
            <span class="eyebrow">Cities</span>
            <h1>Visa consultant services, by city</h1>
            <p>Select your city to see how Videshia supports applicants there — or browse the full state directory for other locations.</p>
        </div>
    </section>

    <div class="container"><?= render_breadcrumbs($breadcrumbs) ?></div>

    <section class="section">
        <div class="container">
            <?php foreach ($ordered as $zone => $list): ?>
            <div style="margin-bottom:28px">
                <h4 style="font-size:13px;text-transform:uppercase;letter-spacing:.06em;color:var(--muted-soft);margin-bottom:12px"><?= e($zone) ?> India</h4>
                <div style="display:flex;flex-wrap:wrap;gap:8px">
                    <?php foreach ($list as $c): ?>
                    <a href="<?= url('cities/' . $c['slug'] . '/') ?>" style="padding:7px 14px;border:1px solid var(--border);border-radius:var(--radius-full);font-size:13.5px;color:var(--navy-800);background:var(--surface)"><?= e($c['name']) ?></a>
                    <?php endforeach; ?>
                </div>
            </div>
            <?php endforeach; ?>
            <p style="text-align:center;margin-top:8px"><a href="<?= url('states/') ?>" style="color:var(--teal-500);font-weight:600">Don't see your city? Browse all states &amp; union territories &rarr;</a></p>
        </div>
    </section>
    <?php
    require __DIR__ . '/includes/footer.php';
}

function render_city_view(PDO $pdo, string $slug): void
{
    $stmt = $pdo->prepare(
        'SELECT c.*, s.name AS state_name, s.slug AS state_slug, s.zone, s.type AS state_type
         FROM cities c JOIN states s ON s.id = c.state_id WHERE c.slug = ?'
    );
    $stmt->execute([$slug]);
    $city = $stmt->fetch();

    if (!$city) {
        http_response_code(404);
        require __DIR__ . '/404.php';
        return;
    }

    $neighbourhoods = json_decode($city['neighbourhoods'], true) ?: [];
    $categories = $pdo->query('SELECT slug, name FROM visa_categories ORDER BY name')->fetchAll();

    $siblingStmt = $pdo->prepare('SELECT slug, name FROM cities WHERE state_id = ? AND id != ? AND indexable = 1 ORDER BY name');
    $siblingStmt->execute([$city['state_id'], $city['id']]);
    $siblings = $siblingStmt->fetchAll();

    $breadcrumbs = [
        ['Home', url('index.php')],
        ['Visa Consultants Across India', url('visa-consultants-india/')],
        [$city['state_name'], url('states/' . $city['state_slug'] . '/')],
        [$city['name'], null],
    ];
    $pageTitle = $city['seo_title'];
    $pageDescription = $city['seo_description'];
    $robotsMeta = $city['indexable'] ? 'index, follow' : 'noindex, follow';
    $cityFaqs = city_faqs($city['name'], $city['state_name']);
    $schemaBlocks = [
        breadcrumb_schema($breadcrumbs),
        professional_service_schema(
            'Videshia Visa Consultancy — ' . $city['name'],
            $pageDescription,
            SITE_URL . '/cities/' . $city['slug'] . '/',
            [$city['name'] . ', ' . $city['state_name']]
        ),
        faq_schema(array_map(static fn($f) => ['question' => $f[0], 'answer' => $f[1]], $cityFaqs)),
    ];
    require __DIR__ . '/includes/header.php';
    ?>
    <section class="page-hero">
        <div class="container">
            <span class="eyebrow"><?= e($city['state_name']) ?> &middot; <?= e($city['zone']) ?> India</span>
            <h1>Visa Consultant in <?= e($city['name']) ?></h1>
            <p>Videshia provides visa consultancy, documentation and application support to applicants in <?= e($city['name']) ?> and across <?= e($city['state_name']) ?>, for 190+ destination countries — with a named consultant on every case.</p>
            <div class="hero-actions" style="justify-content:center;margin-top:22px">
                <a href="<?= url('enquiry/') ?>" class="btn btn-light btn-lg">Start Your Visa Enquiry</a>
            </div>
        </div>
    </section>

    <div class="container"><?= render_breadcrumbs($breadcrumbs) ?></div>

    <section class="section-tight">
        <div class="container">
            <div class="grid-4" style="margin-bottom:8px">
                <div class="card"><p style="font-size:12px;color:var(--muted);margin:0">State</p><p style="font-weight:600;color:var(--navy-900);margin:4px 0 0"><a href="<?= url('states/' . $city['state_slug'] . '/') ?>" style="color:inherit"><?= e($city['state_name']) ?></a></p></div>
                <div class="card"><p style="font-size:12px;color:var(--muted);margin:0">Zone</p><p style="font-weight:600;color:var(--navy-900);margin:4px 0 0"><?= e($city['zone']) ?> India</p></div>
                <div class="card"><p style="font-size:12px;color:var(--muted);margin:0">Service Mode</p><p style="font-weight:600;color:var(--navy-900);margin:4px 0 0">Online Consultation</p></div>
                <div class="card"><p style="font-size:12px;color:var(--muted);margin:0">Support</p><p style="font-weight:600;color:var(--navy-900);margin:4px 0 0">24&times;7</p></div>
            </div>
        </div>
    </section>

    <section class="section" id="services">
        <div class="container">
            <div class="section-head center"><span class="eyebrow">Support Services</span><h2>Visa services available in <?= e($city['name']) ?></h2></div>
            <div class="grid-3">
                <?php foreach ([
                    ['Visa Documentation', 'Document review and preparation against your destination\'s exact checklist, before you submit.'],
                    ['Visa Application Support', 'End-to-end guidance completing and submitting your application correctly the first time.'],
                    ['Visa Appointment Assistance', 'Help booking and preparing for biometric or in-person appointments where your destination requires one.'],
                    ['Visa Extension & Renewal', 'Guidance on extending or renewing an existing visa where the destination permits it.'],
                ] as [$name, $desc]): ?>
                <div class="card"><h3 style="font-size:15.5px"><?= e($name) ?></h3><p><?= e($desc) ?></p></div>
                <?php endforeach; ?>
            </div>
        </div>
    </section>

    <section class="section section-alt">
        <div class="container grid-2" style="align-items:start">
            <div>
                <h2>Visa categories we handle</h2>
                <p>The same visa categories, wherever you're applying from in <?= e($city['name']) ?>:</p>
                <div style="display:flex;flex-wrap:wrap;gap:8px;margin-top:14px">
                    <?php foreach ($categories as $cat): ?>
                    <a href="<?= url('visa-services/' . $cat['slug'] . '/') ?>" style="padding:7px 14px;border:1px solid var(--border);border-radius:var(--radius-full);font-size:13.5px;color:var(--navy-800);background:var(--surface)"><?= e($cat['name']) ?></a>
                    <?php endforeach; ?>
                </div>
                <p style="margin-top:16px"><a href="<?= url('visa-by-country/') ?>" style="color:var(--teal-500);font-weight:600">Browse all 190+ visa destinations &rarr;</a></p>
            </div>
            <div class="card">
                <h3>Areas we serve in <?= e($city['name']) ?></h3>
                <p><?= e(implode(', ', $neighbourhoods)) ?> and surrounding areas.</p>
            </div>
        </div>
    </section>

    <section class="section">
        <div class="container grid-2" style="align-items:center">
            <div>
                <h2>How Videshia serves applicants in <?= e($city['name']) ?></h2>
                <p>Videshia does not require a branch visit in <?= e($city['name']) ?> — your entire application can be handled online, by phone or over WhatsApp, with documents exchanged digitally or by courier where originals are needed.</p>
                <p>Every enquiry is reviewed and assigned to a named consultant, who confirms your visa category, document checklist and next steps directly with you.</p>
            </div>
            <div class="card card-dark">
                <h3>Talk to a consultant</h3>
                <p>Share your destination and purpose of travel — we'll confirm exactly what you need.</p>
                <a href="<?= url('enquiry/') ?>" class="btn btn-primary btn-block" style="margin-top:14px">Start Your Visa Enquiry</a>
            </div>
        </div>
    </section>

    <section class="section section-alt" id="faqs">
        <div class="container" style="max-width:760px">
            <div class="section-head center"><span class="eyebrow">FAQs</span><h2>Visa consultant in <?= e($city['name']) ?> — FAQs</h2></div>
            <div style="display:flex;flex-direction:column;gap:14px">
                <?php foreach ($cityFaqs as [$q, $a]): ?>
                <div class="card"><h3 style="font-size:15.5px"><?= e($q) ?></h3><p style="margin:0"><?= e($a) ?></p></div>
                <?php endforeach; ?>
            </div>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <?php if ($siblings): ?>
            <h4 style="font-size:13px;text-transform:uppercase;letter-spacing:.06em;color:var(--muted-soft);margin-bottom:14px">Other cities we serve in <?= e($city['state_name']) ?></h4>
            <div style="display:flex;flex-wrap:wrap;gap:8px;margin-bottom:24px">
                <?php foreach ($siblings as $sib): ?>
                <a href="<?= url('cities/' . $sib['slug'] . '/') ?>" style="padding:7px 14px;border:1px solid var(--border);border-radius:var(--radius-full);font-size:13.5px;color:var(--navy-800);background:var(--surface)"><?= e($sib['name']) ?></a>
                <?php endforeach; ?>
            </div>
            <?php endif; ?>
            <p><a href="<?= url('states/' . $city['state_slug'] . '/') ?>" style="color:var(--teal-500);font-weight:600">View all of <?= e($city['state_name']) ?> &rarr;</a> &middot; <a href="<?= url('visa-consultants-india/') ?>" style="color:var(--teal-500);font-weight:600">View all states &amp; cities &rarr;</a></p>
        </div>
    </section>
    <?php
    require __DIR__ . '/includes/footer.php';
}

function city_faqs(string $cityName, string $stateName): array
{
    return [
        ["Does Videshia have a branch office in {$cityName}?", "Videshia serves applicants in {$cityName} through online consultation rather than a network of local branches — your consultant works with you by phone, WhatsApp and email, with documents exchanged digitally or by courier."],
        ["Can I apply for a visa from {$cityName} without visiting an office?", "Yes. The entire process — document review, application support and status updates — can be completed without an in-person visit."],
        ["How do I track my visa application from {$cityName}?", "Use your Videshia reference number (format VDH-YYYY-NNNNNN) on the Track Application page, along with the mobile number or email you applied with."],
        ["Which visa categories does Videshia support for applicants in {$cityName}?", "The same full range available across {$stateName} — tourist, business, employment, family, transit, medical, conference, dependent and official visas. See Visa Services for details."],
    ];
}

function national_hub_faqs(): array
{
    return [
        ['Does Videshia have an office in every state?', 'No — Videshia serves applicants across India through online consultation, phone and WhatsApp support, so you do not need a local office to apply. Documents are handled digitally or by courier where originals are required.'],
        ['Can I get visa help if I don\'t live in a major city?', 'Yes. Our process is designed to work the same way regardless of where you\'re applying from — share your details through our enquiry form and a consultant will take it from there.'],
        ['Which visa categories does Videshia support?', 'Tourist, business, employment, family, transit, medical, conference, dependent and official visas, across 190+ destination countries. See Visa Services for the full list.'],
        ['How do I start my visa application?', 'Use the Start Your Visa Enquiry button on this page, or the Visa Search Widget on our homepage, to share your destination and purpose of travel.'],
    ];
}

function state_faqs(string $stateName): array
{
    return [
        ["Does Videshia have a branch office in {$stateName}?", "Videshia serves applicants across {$stateName} through online consultation rather than a network of local branches — your consultant works with you by phone, WhatsApp and email, with documents exchanged digitally or by courier."],
        ["Can I apply for a visa from {$stateName} without visiting an office?", "Yes. The entire process — document review, application support and status updates — can be completed without an in-person visit."],
        ["How do I track my visa application from {$stateName}?", "Use your Videshia reference number (format VDH-YYYY-NNNNNN) on the Track Application page, along with the mobile number or email you applied with."],
        ["Which visa destinations are popular with applicants from {$stateName}?", "Applicants from {$stateName} apply for the same range of destinations as elsewhere in India — see Visa by Country for requirements, fees and processing times for each."],
    ];
}
