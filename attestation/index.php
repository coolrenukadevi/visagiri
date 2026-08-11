<?php
declare(strict_types=1);

/**
 * Attestation Services — a distinct service line from visa
 * consultancy (document legalization: apostille/MEA/embassy/
 * commercial attestation). Only 4 fixed items, so kept as a static
 * array here rather than a new DB table — real content per service
 * still needs Phase 8-equivalent verified authoring before it ships;
 * these stubs describe what each service generically is, not a
 * Visagiri-specific claim.
 */

$services = [
    'apostille' => [
        'name' => 'Apostille',
        'description' => 'Apostille certification for documents to be used in countries that are part of the Hague Apostille Convention.',
    ],
    'mea-attestation' => [
        'name' => 'MEA Attestation',
        'description' => "Ministry of External Affairs (MEA) attestation for Indian documents used abroad, for countries outside the Hague Convention.",
    ],
    'embassy-attestation' => [
        'name' => 'Embassy Attestation',
        'description' => "Attestation of documents by the destination country's embassy or consulate.",
    ],
    'commercial-attestation' => [
        'name' => 'Commercial Attestation',
        'description' => 'Attestation of commercial documents such as invoices, certificates of origin, and business agreements.',
    ],
];

$slug = $segments[1] ?? null;

if ($slug !== null) {
    if (!isset($services[$slug])) {
        render_not_found("We couldn't find that attestation service.");
    }
    $service = $services[$slug];
    $pageTitle = "{$service['name']} - Visagiri";
    $pageDescription = $service['description'];
    $canonicalUrl = APP_URL . "/attestation/{$slug}/";
    require __DIR__ . '/../includes/header.php';
    ?>
    <section class="visa-detail">
        <div class="container">
            <ul class="breadcrumb">
                <li><a href="/">Home</a></li>
                <li><a href="/attestation/">Attestation Services</a></li>
                <li><?= e($service['name']) ?></li>
            </ul>
            <h1><?= e($service['name']) ?></h1>
            <p><?= e($service['description']) ?></p>
            <div class="alert alert-info">
                Detailed requirements and process information for this service are being finalized.
                <a href="/contact/">Contact us</a> for current guidance.
            </div>
        </div>
    </section>
    <?php
    require __DIR__ . '/../includes/footer.php';
    exit;
}

$pageTitle = 'Attestation Services - Visagiri';
$pageDescription = 'Apostille, MEA attestation, embassy attestation, and commercial document attestation services.';
$canonicalUrl = APP_URL . '/attestation/';
require __DIR__ . '/../includes/header.php';
?>
<section class="section">
    <div class="container">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">Document Services</span>
            <h1>Attestation Services</h1>
        </div>
        <div class="card-grid">
            <?php foreach ($services as $slug => $service): ?>
            <a href="/attestation/<?= e($slug) ?>/" class="card service-card">
                <div class="service-card__icon">&#128196;</div>
                <div class="card-title"><?= e($service['name']) ?></div>
                <p><?= e($service['description']) ?></p>
            </a>
            <?php endforeach; ?>
        </div>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
