<?php
declare(strict_types=1);

/**
 * Attestation Services — a distinct service line from visa
 * consultancy (document legalization: apostille/attestation/
 * document-category/legalization services). Routes and hub grid
 * both read from attestation_services()/attestation_categories() in
 * includes/functions.php — the single source of truth also used by
 * the header mega-menu, so this can never drift out of sync with the
 * nav the way the old hardcoded visa-type arrays did. Only 13 fixed
 * categories, so kept as a static array rather than a DB table; real
 * content per service still needs Phase 8-equivalent verified
 * authoring before it ships — these stubs describe what each service
 * generically is, not a Visagiri-specific claim.
 */

require __DIR__ . '/../includes/google-sheets.php';

$slug = $segments[1] ?? null;

if ($slug !== null) {
    $redirects = attestation_service_redirects();
    if (isset($redirects[$slug])) {
        redirect("/attestation/{$redirects[$slug]}/", 301);
    }

    $services = attestation_services();
    if (!isset($services[$slug])) {
        render_not_found("We couldn't find that attestation service.");
    }
    $service = $services[$slug];

    $submitted = false;
    $success = false;
    $referenceNumber = null;
    $errors = [];
    $values = ['name' => '', 'email' => '', 'phone' => '', 'message' => ''];

    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        csrf_require();

        if (trim((string) ($_POST['website'] ?? '')) !== '') {
            redirect("/attestation/{$slug}/");
        }

        $values['name'] = trim((string) ($_POST['name'] ?? ''));
        $values['email'] = trim((string) ($_POST['email'] ?? ''));
        $values['phone'] = trim((string) ($_POST['phone'] ?? ''));
        $values['message'] = trim((string) ($_POST['message'] ?? ''));

        if (!rate_limit_check('attestation:' . ($_SERVER['REMOTE_ADDR'] ?? ''), 5, 900)) {
            $errors[] = 'Too many submissions. Please try again later, or reach us directly on WhatsApp.';
        }
        if ($values['name'] === '') {
            $errors[] = 'Please enter your name.';
        }
        if (!is_valid_email($values['email'])) {
            $errors[] = 'Please enter a valid email address.';
        }
        if ($values['phone'] !== '' && !is_valid_mobile($values['phone'])) {
            $errors[] = 'Please enter a valid phone number, or leave it blank.';
        }

        if (!$errors) {
            $submitted = true;
            try {
                for ($attempt = 0; $attempt < 2; $attempt++) {
                    $referenceNumber = generate_reference_number('GEN', 'general_enquiries', 'enquiry_reference_no');
                    try {
                        $stmt = db()->prepare(
                            'INSERT INTO general_enquiries (enquiry_reference_no, service_type, name, email, phone, description, source_page, ip_address)
                             VALUES (:ref, :service_type, :name, :email, :phone, :description, :source_page, :ip)'
                        );
                        $stmt->execute([
                            'ref' => $referenceNumber,
                            'service_type' => $slug,
                            'name' => $values['name'],
                            'email' => $values['email'],
                            'phone' => $values['phone'] !== '' ? $values['phone'] : null,
                            'description' => $values['message'] !== '' ? $values['message'] : "Enquiry about {$service['name']}.",
                            'source_page' => "/attestation/{$slug}/",
                            'ip' => $_SERVER['REMOTE_ADDR'] ?? null,
                        ]);
                        break;
                    } catch (PDOException $e) {
                        if ($e->getCode() === '23000' && $attempt === 0) {
                            continue;
                        }
                        throw $e;
                    }
                }
                $success = true;

                notify_enquiry_channels([
                    'reference_number' => $referenceNumber,
                    'name' => $values['name'],
                    'email' => $values['email'],
                    'phone' => $values['phone'],
                    'destination' => $service['name'],
                    'message' => $values['message'],
                    'submitted_at' => date('c'),
                ]);

                $values = ['name' => '', 'email' => '', 'phone' => '', 'message' => ''];
            } catch (Throwable $e) {
                if (APP_DEBUG) {
                    error_log('[attestation/index.php] failed to save enquiry: ' . $e->getMessage());
                }
                $success = false;
            }
        }
    }
    $pageTitle = "{$service['name']} | Visagiri";
    $pageDescription = $service['meta_description'];
    $canonicalUrl = APP_URL . "/attestation/{$slug}/";
    $structuredData = [[
        '@context' => 'https://schema.org',
        '@type' => 'BreadcrumbList',
        'itemListElement' => [
            ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => APP_URL . '/'],
            ['@type' => 'ListItem', 'position' => 2, 'name' => 'Attestation Services', 'item' => APP_URL . '/attestation/'],
            ['@type' => 'ListItem', 'position' => 3, 'name' => $service['name'], 'item' => $canonicalUrl],
        ],
    ]];
    require __DIR__ . '/../includes/header.php';
    ?>
    <section class="visa-detail">
        <div class="container">
            <ul class="breadcrumb">
                <li><a href="/">Home</a></li>
                <li><a href="/attestation/">Attestation Services</a></li>
                <li><?= e($service['name']) ?></li>
            </ul>
            <div class="visa-detail__header">
                <span class="destination-card__flag"><?= $service['icon'] ?></span>
                <div>
                    <h1><?= e($service['name']) ?></h1>
                    <p><?= e($service['description']) ?></p>
                    <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to get a quote for {$service['name']}.")) ?>" class="btn btn-gold" target="_blank" rel="noopener noreferrer">Get Attestation Quote</a>
                </div>
            </div>
            <div class="visa-spec-grid">
                <div class="card"><div class="card-title">Overview</div><p><?= e($service['overview']) ?></p></div>
                <div class="card"><div class="card-title">When You Need This</div><p><?= e($service['when_needed']) ?></p></div>
                <div class="card">
                    <div class="card-title">Typical Process</div>
                    <ol style="padding-left:var(--space-5);margin:0">
                        <?php foreach ($service['process_steps'] as $step): ?>
                        <li style="margin-bottom:var(--space-2)"><?= e($step) ?></li>
                        <?php endforeach; ?>
                    </ol>
                </div>
                <div class="card">
                    <div class="card-title">Documents This Typically Covers</div>
                    <p><?= e(implode(', ', $service['typical_documents'])) ?></p>
                </div>
            </div>

            <div class="alert alert-info" style="margin-top:var(--space-6)">
                Exact fees, processing time, and the exact combination of stages needed depend on your document type and destination country — our team confirms these with you directly.
                <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to get a quote for {$service['name']}.")) ?>" target="_blank" rel="noopener noreferrer">Chat with us on WhatsApp</a> for current guidance.
            </div>

            <div class="card" style="margin-top:var(--space-8);max-width:560px">
                <div class="card-title">Enquire About <?= e($service['name']) ?></div>
                <?php if ($submitted && $success): ?>
                <div class="alert alert-success" role="status">
                    <strong>Thank you.</strong> Your enquiry has been received — reference number <strong><?= e($referenceNumber) ?></strong>. Our team will get back to you soon.
                </div>
                <?php elseif ($submitted && !$success): ?>
                <div class="alert alert-danger" role="alert">
                    <strong>Something went wrong sending your enquiry.</strong> Please try again, or reach us directly on WhatsApp.
                </div>
                <?php else: ?>
                <?php foreach ($errors as $error): ?>
                <div class="alert alert-danger"><?= e($error) ?></div>
                <?php endforeach; ?>
                <form method="post" action="/attestation/<?= e($slug) ?>/" novalidate>
                    <?= csrf_field() ?>
                    <div class="form-group" style="position:absolute;left:-9999px" aria-hidden="true">
                        <label for="website">Leave this field blank</label>
                        <input type="text" id="website" name="website" tabindex="-1" autocomplete="off">
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="name">Full Name</label>
                        <input class="form-input" type="text" id="name" name="name" value="<?= e($values['name']) ?>" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="email">Email Address</label>
                        <input class="form-input" type="email" id="email" name="email" value="<?= e($values['email']) ?>" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="phone">Phone Number (optional)</label>
                        <input class="form-input" type="tel" id="phone" name="phone" value="<?= e($values['phone']) ?>" placeholder="e.g. +91 98765 43210">
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="message">Message (optional)</label>
                        <textarea class="form-input" id="message" name="message" rows="4"><?= e($values['message']) ?></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary" style="width:100%">Submit Enquiry</button>
                </form>
                <?php endif; ?>
            </div>

            <?php
            $relatedServices = array_filter(
                attestation_categories()[$service['category']],
                static fn(array $s) => $s['slug'] !== $slug
            );
            ?>
            <?php if ($relatedServices): ?>
            <div style="margin-top:var(--space-10)">
                <h2 class="country-directory__subheading">Other <?= e($service['category']) ?> Services</h2>
                <div class="card-grid">
                    <?php foreach ($relatedServices as $related): ?>
                    <a href="/attestation/<?= e($related['slug']) ?>/" class="card service-card">
                        <div class="service-card__icon"><?= $related['icon'] ?></div>
                        <div class="card-title"><?= e($related['name']) ?></div>
                        <p><?= e($related['description']) ?></p>
                    </a>
                    <?php endforeach; ?>
                </div>
            </div>
            <?php endif; ?>
        </div>
    </section>
    <?php
    require __DIR__ . '/../includes/footer.php';
    exit;
}

$categories = attestation_categories();

$pageTitle = 'Document Attestation Services | Visagiri';
$pageDescription = 'Apostille, attestation, document-category, and legalization services for documents used abroad — apply online with Visagiri.';
$canonicalUrl = APP_URL . '/attestation/';
require __DIR__ . '/../includes/header.php';
?>
<section class="section">
    <div class="container">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">Document Services</span>
            <h1>Attestation Services</h1>
        </div>
        <?php foreach ($categories as $categoryName => $categoryServices): ?>
        <h2 class="country-directory__subheading"><?= attestation_category_icon($categoryName) ?> <?= e($categoryName) ?></h2>
        <div class="card-grid" style="margin-bottom:var(--space-8)">
            <?php foreach ($categoryServices as $service): ?>
            <a href="/attestation/<?= e($service['slug']) ?>/" class="card service-card">
                <div class="service-card__icon"><?= $service['icon'] ?></div>
                <div class="card-title"><?= e($service['name']) ?></div>
                <p><?= e($service['description']) ?></p>
            </a>
            <?php endforeach; ?>
        </div>
        <?php endforeach; ?>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
