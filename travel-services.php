<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';

$pageTitle = 'Tours, Hotels, Flights, Forex & Travel Insurance — Videshia';
$pageDescription = 'Beyond visas: Videshia books tours, hotels and flights, arranges forex and travel insurance, and manages corporate travel programmes.';
require __DIR__ . '/includes/header.php';

$verticals = [
    ['id' => 'tours', 'name' => 'Tours', 'tag' => 'Domestic & International', 'desc' => 'Curated holiday packages — from weekend getaways to international itineraries — planned around your budget and travel dates.', 'items' => ['Domestic tours across India', 'International tours to 190+ destinations', 'Honeymoon & family holiday packages', 'Adventure, solo and luxury travel', 'Religious and pilgrimage tours', 'Custom weekend trips'], 'icon' => '<path d="M12 2v20M2 12h20"/><circle cx="12" cy="12" r="9"/>'],
    ['id' => 'hotels', 'name' => 'Hotels', 'tag' => 'Domestic & International', 'desc' => 'Hotel bookings across budget, business and luxury categories, with corporate-rate access for frequent travellers.', 'items' => ['Domestic hotel bookings', 'International hotel bookings', 'Corporate-rate hotel programmes', 'Group and event accommodation', 'Best-rate matching on request'], 'icon' => '<path d="M3 21h18M5 21V9l7-5 7 5v12M9 21v-6h6v6"/>'],
    ['id' => 'flights', 'name' => 'Flights', 'tag' => 'Domestic & International', 'desc' => 'Flight bookings and fare comparisons across airlines, with fare alerts and rebooking support.', 'items' => ['Domestic flight bookings', 'International flight bookings', 'Multi-city and group itineraries', 'Fare comparison across airlines', 'Rebooking & cancellation support'], 'icon' => '<path d="M2 16l20-8-8 20-3-8-8-4z"/>'],
    ['id' => 'forex', 'name' => 'Forex', 'tag' => 'Currency & Cards', 'desc' => 'Foreign exchange, forex cards and currency-rate guidance for outbound travel, backed by document-checklist support for RBI/FEMA compliance.', 'items' => ['Currency exchange for 30+ currencies', 'Multi-currency forex cards', 'Live currency rate guidance', 'Forex document checklist support', 'Home delivery or branch pickup'], 'icon' => '<path d="M12 1v22M17 5H9.5a3.5 3.5 0 000 7h5a3.5 3.5 0 010 7H6"/>'],
    ['id' => 'insurance', 'name' => 'Travel Insurance', 'tag' => 'Domestic & International', 'desc' => 'Travel insurance covering medical emergencies, trip cancellation and baggage loss — including Schengen-compliant policies.', 'items' => ['International travel insurance', 'Schengen-compliant policies', 'USA travel insurance', 'Domestic travel insurance', 'Family & group policies'], 'icon' => '<rect x="3" y="11" width="18" height="10" rx="2"/><path d="M7 11V7a5 5 0 0110 0v4"/>'],
    ['id' => 'corporate', 'name' => 'Corporate Travel', 'tag' => 'Business & Employee Travel', 'desc' => 'End-to-end corporate travel management — policy-compliant bookings, employee travel and MIS reporting for finance teams.', 'items' => ['Corporate travel management', 'Employee travel booking', 'Travel policy configuration', 'MIS & spend reporting', 'Dedicated account manager'], 'icon' => '<rect x="3" y="7" width="18" height="13" rx="2"/><path d="M8 7V5a2 2 0 012-2h4a2 2 0 012 2v2"/>'],
];
?>

<section class="page-hero">
    <div class="container">
        <span class="eyebrow">Beyond Visas</span>
        <h1>Tours, hotels, flights, forex & insurance — one desk.</h1>
        <p>Videshia's visa expertise is backed by a full travel desk, so your trip is planned end-to-end, not just documented.</p>
    </div>
</section>

<section class="section">
    <div class="container" style="display:flex;flex-direction:column;gap:64px">
        <?php foreach ($verticals as $i => $v): ?>
        <div id="<?= e($v['id']) ?>" class="grid-2" style="align-items:center;<?= $i % 2 ? 'direction:rtl' : '' ?>">
            <div style="<?= $i % 2 ? 'direction:ltr' : '' ?>">
                <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><?= $v['icon'] ?></svg></div>
                <span class="eyebrow" style="margin-top:14px"><?= e($v['tag']) ?></span>
                <h2 style="margin-top:12px"><?= e($v['name']) ?></h2>
                <p><?= e($v['desc']) ?></p>
                <a href="<?= url('index.php') ?>?service=<?= e($v['id'] === 'insurance' ? 'insurance' : ($v['id'] === 'corporate' ? 'general' : $v['id'])) ?>#enquiry" class="btn btn-primary">Enquire about <?= e($v['name']) ?></a>
            </div>
            <div style="<?= $i % 2 ? 'direction:ltr' : '' ?>" class="card">
                <ul style="display:flex;flex-direction:column;gap:12px">
                    <?php foreach ($v['items'] as $item): ?>
                    <li style="display:flex;align-items:flex-start;gap:10px;font-size:14.5px;color:var(--navy-800)">
                        <svg style="flex-shrink:0;margin-top:3px" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#17c3c9" stroke-width="3"><path d="M4 12l5 5L20 6"/></svg>
                        <?= e($item) ?>
                    </li>
                    <?php endforeach; ?>
                </ul>
            </div>
        </div>
        <?php endforeach; ?>
    </div>
</section>

<section class="section section-alt">
    <div class="container">
        <div class="cta-band">
            <div>
                <h2>Planning a trip with multiple moving parts?</h2>
                <p>Tell us once — visa, flights, hotels, forex and insurance, coordinated by one consultant.</p>
            </div>
            <div class="cta-actions">
                <a href="<?= url('index.php') ?>#enquiry" class="btn btn-light btn-lg">Start an enquiry</a>
            </div>
        </div>
    </div>
</section>

<?php require __DIR__ . '/includes/footer.php'; ?>
