<?php
declare(strict_types=1);

/**
 * Handles /visa/{country}/ (overview) and /visa/{country}/{type}/
 * (detail). $segments is provided by public/index.php's dispatch
 * closure ($segments[0] === 'visa').
 *
 * No visa_requirements data is seeded anywhere in this project (see
 * database/schema.sql) — country+type combinations always render the
 * honest "not yet verified" state until Phase 7/8 data entry adds
 * real, sourced requirements. This file's job is the query logic and
 * template; it must never fabricate what it can't find.
 */

$countrySlug = $segments[1] ?? null;
$typeSlug = $segments[2] ?? null;

if ($countrySlug === null) {
    redirect('/countries/');
}

$pdo = db();

$stmt = $pdo->prepare('SELECT * FROM countries WHERE slug = :slug AND is_active = 1');
$stmt->execute(['slug' => $countrySlug]);
$country = $stmt->fetch();

if (!$country) {
    render_not_found("We couldn't find that destination.");
}

$searchContext = array_filter([
    'nationality' => $_GET['nationality'] ?? '',
    'travel_date' => $_GET['travel_date'] ?? '',
]);

if ($typeSlug !== null) {
    $stmt = $pdo->prepare('SELECT * FROM visa_types WHERE slug = :slug AND is_active = 1');
    $stmt->execute(['slug' => $typeSlug]);
    $visaType = $stmt->fetch();

    if (!$visaType) {
        render_not_found("We couldn't find that visa type for {$country['name']}.");
    }

    $stmt = $pdo->prepare(
        'SELECT vr.* FROM country_visa_types cvt
         JOIN visa_requirements vr ON vr.country_visa_type_id = cvt.id
         WHERE cvt.country_id = :country_id AND cvt.visa_type_id = :visa_type_id AND cvt.is_available = 1
         ORDER BY vr.updated_at DESC LIMIT 1'
    );
    $stmt->execute(['country_id' => $country['id'], 'visa_type_id' => $visaType['id']]);
    $requirement = $stmt->fetch();

    $contactPoints = fetch_country_contact_points($pdo, (int) $country['id']);
    $countryName = $country['name'];
    $faqs = fetch_relevant_faqs($pdo, (int) $country['id'], (int) $visaType['id']);

    $pageTitle = "{$visaType['name']} for {$country['name']} - Visagiri";
    $pageDescription = "{$visaType['name']} requirements, documents, fees, and processing time for {$country['name']}.";
    $canonicalUrl = APP_URL . "/visa/{$country['slug']}/{$visaType['slug']}/";
    require __DIR__ . '/../includes/header.php';
    ?>
    <section class="visa-detail">
        <div class="container">
            <ul class="breadcrumb">
                <li><a href="/">Home</a></li>
                <li><a href="/countries/">Countries</a></li>
                <li><a href="/visa/<?= e($country['slug']) ?>/"><?= e($country['name']) ?></a></li>
                <li><?= e($visaType['name']) ?></li>
            </ul>

            <div class="visa-detail__header">
                <span class="destination-card__flag"><?= flag_emoji($country['iso2']) ?></span>
                <div>
                    <h1><?= e($visaType['name']) ?> &mdash; <?= e($country['name']) ?></h1>
                    <p><?= e($visaType['description'] ?? '') ?></p>
                    <a href="/apply/?country=<?= e($country['slug']) ?>&amp;type=<?= e($visaType['slug']) ?>" class="btn btn-gold">Start Application</a>
                </div>
            </div>

            <?php if ($searchContext): ?>
            <div class="alert alert-info">
                Showing results for
                <?php if (!empty($searchContext['nationality'])): ?><strong><?= e($searchContext['nationality']) ?></strong> nationality<?php endif; ?>
                <?php if (!empty($searchContext['travel_date'])): ?>, travelling <strong><?= e($searchContext['travel_date']) ?></strong><?php endif; ?>.
            </div>
            <?php endif; ?>

            <?php if ($requirement): ?>
            <div class="visa-spec-grid">
                <div class="card"><div class="card-title">Eligibility</div><p><?= nl2br(e($requirement['eligibility'] ?? 'Not specified')) ?></p></div>
                <div class="card"><div class="card-title">Required Documents</div><p><?= nl2br(e($requirement['documents_required'] ?? 'Not specified')) ?></p></div>
                <div class="card"><div class="card-title">Application Process</div><p><?= nl2br(e($requirement['application_process'] ?? 'Not specified')) ?></p></div>
                <div class="card"><div class="card-title">Processing Time</div><p><?= e($requirement['processing_time'] ?? 'Not specified') ?></p></div>
                <div class="card"><div class="card-title">Fees</div><p>
                    <?php if ($requirement['government_fee']): ?>Government fee: <?= e(format_money((float) $requirement['government_fee'], $requirement['currency'])) ?><br><?php endif; ?>
                    <?php if ($requirement['service_fee']): ?>Service fee: <?= e(format_money((float) $requirement['service_fee'], $requirement['currency'])) ?><?php endif; ?>
                </p></div>
                <div class="card"><div class="card-title">Validity &amp; Stay</div><p>
                    Validity: <?= e($requirement['validity_period'] ?? 'Not specified') ?><br>
                    Stay duration: <?= e($requirement['stay_duration'] ?? 'Not specified') ?><br>
                    Entry type: <?= e($requirement['entry_type'] ?? 'Not specified') ?>
                </p></div>
                <div class="card"><div class="card-title">Biometrics &amp; Interview</div><p>
                    Biometrics required: <span class="badge <?= $requirement['biometrics_required'] ? 'badge-warning' : 'badge-neutral' ?>"><?= $requirement['biometrics_required'] ? 'Yes' : 'No' ?></span><br>
                    Interview required: <span class="badge <?= $requirement['interview_required'] ? 'badge-warning' : 'badge-neutral' ?>"><?= $requirement['interview_required'] ? 'Yes' : 'No' ?></span>
                </p></div>
                <?php if (!empty($requirement['notes'])): ?>
                <div class="card"><div class="card-title">Important Notes</div><p><?= nl2br(e($requirement['notes'])) ?></p></div>
                <?php endif; ?>
            </div>
            <p class="visa-detail__verified">
                Last verified: <?= e(date('d M Y', strtotime((string) $requirement['last_verified_at']))) ?>
                <?php if (!empty($requirement['source_url'])): ?> &middot; <a href="<?= e($requirement['source_url']) ?>" rel="nofollow noopener" target="_blank">Official source</a><?php endif; ?>
            </p>
            <?php else: ?>
            <div class="alert alert-warning">
                <div>
                    <strong>Requirements not yet verified.</strong>
                    We haven't published verified <?= e($visaType['name']) ?> requirements for <?= e($country['name']) ?> yet.
                    Contact our team for current requirements, or check back soon.
                </div>
            </div>
            <div class="button-group" style="margin-top:var(--space-5)">
                <a href="/contact/" class="btn btn-primary">Contact Us</a>
                <a href="/visa/<?= e($country['slug']) ?>/" class="btn btn-outline">See other visa types for <?= e($country['name']) ?></a>
            </div>
            <?php endif; ?>

            <div style="margin-top:var(--space-10)">
                <?php require __DIR__ . '/../includes/contact-points.php'; ?>
            </div>

            <?php if ($faqs): ?>
            <div style="margin-top:var(--space-10);max-width:760px">
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

// Country overview: no specific visa type requested — list the
// catalog of visa types to explore for this country.
$visaTypes = $pdo->query('SELECT * FROM visa_types WHERE is_active = 1 ORDER BY sort_order')->fetchAll();
$contactPoints = fetch_country_contact_points($pdo, (int) $country['id']);
$countryName = $country['name'];

$pageTitle = "{$country['name']} Visa Requirements - Visagiri";
$pageDescription = "Visa types, requirements, and application information for {$country['name']}.";
$canonicalUrl = APP_URL . "/visa/{$country['slug']}/";
require __DIR__ . '/../includes/header.php';
?>
<section class="visa-detail">
    <div class="container">
        <ul class="breadcrumb">
            <li><a href="/">Home</a></li>
            <li><a href="/countries/">Countries</a></li>
            <li><?= e($country['name']) ?></li>
        </ul>

        <div class="visa-detail__header">
            <span class="destination-card__flag"><?= flag_emoji($country['iso2']) ?></span>
            <div>
                <h1><?= e($country['name']) ?> Visa Requirements</h1>
                <?php if (!empty($country['region'])): ?><span class="badge badge-neutral"><?= e($country['region']) ?></span><?php endif; ?>
                <p style="margin-top:var(--space-3)">
                    Visa requirements for <?= e($country['name']) ?> vary by nationality, purpose of travel, and visa type.
                    Select a visa type below to check eligibility, required documents, fees, and processing time.
                </p>
            </div>
        </div>

        <div class="card-grid">
            <?php foreach ($visaTypes as $t): ?>
            <a href="/visa/<?= e($country['slug']) ?>/<?= e($t['slug']) ?>/" class="card service-card">
                <div class="service-card__icon">&#128196;</div>
                <div class="card-title"><?= e($t['name']) ?></div>
                <p><?= e($t['description']) ?></p>
            </a>
            <?php endforeach; ?>
        </div>

        <div style="margin-top:var(--space-10)">
            <?php require __DIR__ . '/../includes/contact-points.php'; ?>
        </div>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
