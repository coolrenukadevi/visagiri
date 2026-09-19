<?php
declare(strict_types=1);

/**
 * Visa-type hub (/visa-type/) and per-type explainer (/visa-type/{slug}/)
 * — Phase 15. All content here comes straight from the real visa_types
 * table (seeded in Phase 2/5), never invented. There's no populated
 * country_visa_types mapping (that table exists in the schema but was
 * superseded early on by /visa/{country}/{type}/ treating every visa
 * type as explorable for every country — see visa/index.php), so this
 * page doesn't claim per-country availability; it links to popular
 * destinations (the real is_popular_destination flag) and to the full
 * country directory instead.
 */

$typeSlug = $segments[1] ?? null;

if ($typeSlug !== null) {
    $visaType = visa_type_by_slug($typeSlug);

    if (!$visaType) {
        render_not_found("We couldn't find that visa type.");
    }

    $popularCountries = array_values(array_filter(
        countries_all(),
        static fn(array $c): bool => $c['is_popular_destination']
    ));
    usort($popularCountries, static fn(array $a, array $b): int => $a['name'] <=> $b['name']);

    $faqs = faqs_general();

    $pageTitle = !empty($visaType['meta_title'])
        ? $visaType['meta_title']
        : "{$visaType['name']} Requirements & How to Apply | Visagiri";
    $pageDescription = !empty($visaType['meta_description'])
        ? $visaType['meta_description']
        : mb_substr($visaType['description'], 0, 110) . ' See popular destinations and enquire with Visagiri.';
    $canonicalUrl = APP_URL . "/visa-type/{$visaType['slug']}/";
    $breadcrumbItems = [
        ['name' => 'Home', 'url' => APP_URL . '/'],
        ['name' => 'Visa Services', 'url' => APP_URL . '/visa-type/'],
        ['name' => $visaType['name'], 'url' => $canonicalUrl],
    ];
    $structuredData = [breadcrumb_schema($breadcrumbItems)];
    if ($faqs) {
        $structuredData[] = [
            '@context' => 'https://schema.org',
            '@type' => 'FAQPage',
            'mainEntity' => array_map(static fn($f) => [
                '@type' => 'Question',
                'name' => $f['question'],
                'acceptedAnswer' => ['@type' => 'Answer', 'text' => $f['answer']],
            ], $faqs),
        ];
    }
    require __DIR__ . '/../includes/header.php';
    ?>
    <section class="visa-detail">
        <div class="container">
            <?= breadcrumb_html($breadcrumbItems) ?>
            <div class="visa-detail__header">
                <span class="destination-card__flag"><?= visa_type_icon($visaType['slug']) ?></span>
                <div>
                    <h1><?= e($visaType['name']) ?></h1>
                    <p><?= e($visaType['description']) ?></p>
                    <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to know more about {$visaType['name']}.")) ?>" class="btn btn-gold" target="_blank" rel="noopener noreferrer">Enquire Now</a>
                </div>
            </div>

            <?php if ($visaType['slug'] === 'work'): ?>
            <div class="alert alert-info" style="max-width:760px">
                <div>
                    <strong>Please note:</strong> Our work permit assistance covers sponsorship-letter-based applications for white-collar/professional roles only. We do not process blue-collar or labor recruitment visas.
                </div>
            </div>
            <?php endif; ?>

            <h2 class="country-directory__subheading">Popular Destinations</h2>
            <div class="card-grid">
                <?php foreach ($popularCountries as $c): ?>
                <a href="/visa/<?= e($c['slug']) ?>/<?= e($visaType['slug']) ?>/" class="card service-card">
                    <div class="service-card__icon"><?= flag_emoji($c['iso2']) ?></div>
                    <div class="card-title"><?= e($c['name']) ?></div>
                </a>
                <?php endforeach; ?>
            </div>
            <p style="margin-top:var(--space-5)"><a href="/countries/">Explore <?= e($visaType['name']) ?> for all 200+ destinations &rarr;</a></p>

            <?php if ($faqs): ?>
            <div style="margin-top:var(--space-10)">
                <h2 class="country-directory__subheading">Frequently Asked Questions</h2>
                <?php foreach ($faqs as $faq): ?>
                <div class="accordion-item">
                    <details>
                        <summary><?= e($faq['question']) ?></summary>
                        <div class="accordion-body"><?= e($faq['answer']) ?></div>
                    </details>
                </div>
                <?php endforeach; ?>
            </div>
            <?php endif; ?>
        </div>
    </section>
    <?php
    require __DIR__ . '/../includes/footer.php';
    exit;
}

// Hub: list every real visa type.
$visaTypes = visa_types_all();

$pageTitle = 'Visa Types & Categories Explained | Visagiri';
$pageDescription = 'Compare 9 visa categories — tourist, business, student, work, family visit, transit, medical, conference, and sports — and find the right one for your trip.';
$canonicalUrl = APP_URL . '/visa-type/';
$breadcrumbItems = [
    ['name' => 'Home', 'url' => APP_URL . '/'],
    ['name' => 'Visa Services', 'url' => $canonicalUrl],
];
$structuredData = [breadcrumb_schema($breadcrumbItems)];
require __DIR__ . '/../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container">
        <?= breadcrumb_html($breadcrumbItems) ?>
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">Visa Services</span>
            <h1>Visa Types We Assist With</h1>
        </div>
        <div class="card-grid">
            <?php foreach ($visaTypes as $t): ?>
            <a href="/visa-type/<?= e($t['slug']) ?>/" class="card service-card">
                <div class="service-card__icon"><?= visa_type_icon($t['slug']) ?></div>
                <div class="card-title"><?= e($t['name']) ?></div>
                <p><?= e($t['description']) ?></p>
            </a>
            <?php endforeach; ?>
        </div>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
