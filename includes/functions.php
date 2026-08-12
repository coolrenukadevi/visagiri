<?php
declare(strict_types=1);

/** Shorthand for htmlspecialchars() with sane defaults, used in every template. */
function e(?string $value): string
{
    return htmlspecialchars($value ?? '', ENT_QUOTES, 'UTF-8');
}

/**
 * Appends a `?v=<mtime>` cache-buster to a static asset path. Pairs
 * with the year-long `immutable` Cache-Control set in
 * public/.htaccess (Phase 17) — without this, editing a CSS/JS file
 * after launch would leave returning visitors on a stale cached copy
 * for up to a year, since nothing else in the URL would change.
 */
function asset_url(string $path): string
{
    $diskPath = __DIR__ . '/../public' . $path;
    $version = is_file($diskPath) ? filemtime($diskPath) : time();
    return $path . '?v=' . $version;
}

function redirect(string $path, int $status = 302): never
{
    header('Location: ' . $path, true, $status);
    exit;
}

/** Where a logged-in user's "My Account"-type link should point, based on role. */
function account_home_href(string $roleName): string
{
    return match ($roleName) {
        'super_admin', 'admin' => '/admin/',
        'consultant' => '/consultant/',
        default => '/dashboard/',
    };
}

function slugify(string $text): string
{
    $text = trim($text);
    $text = strtolower($text);
    $text = preg_replace('/[^a-z0-9]+/', '-', $text) ?? '';
    return trim($text, '-');
}

function flash_set(string $key, string $message): void
{
    $_SESSION['flash'][$key] = $message;
}

function flash_get(string $key): ?string
{
    $message = $_SESSION['flash'][$key] ?? null;
    unset($_SESSION['flash'][$key]);
    return $message;
}

/** Formats a decimal amount with its currency code, e.g. "INR 12,500.00". */
function format_money(float $amount, string $currency = 'INR'): string
{
    return $currency . ' ' . number_format($amount, 2);
}

/** Renders a country's flag as a Unicode emoji from its ISO2 code (no image assets needed). */
function flag_emoji(?string $iso2): string
{
    if ($iso2 === null || strlen($iso2) !== 2) {
        return '🌐';
    }
    $codePoints = array_map(static fn($c) => 0x1F1E6 + (ord($c) - 65), str_split(strtoupper($iso2)));
    return mb_convert_encoding('&#' . $codePoints[0] . ';&#' . $codePoints[1] . ';', 'UTF-8', 'HTML-ENTITIES');
}

/**
 * Real, client-confirmed WhatsApp number (see includes/enquiry-widget.php
 * for sourcing) — the single existing enquiry/quotation channel on the
 * site. Any "Get a Quote"-style CTA should link here with a relevant
 * pre-filled message rather than standing up a duplicate contact form.
 */
const ENQUIRY_WHATSAPP_NUMBER = '917065819819';

function whatsapp_enquiry_href(string $message): string
{
    return 'https://wa.me/' . ENQUIRY_WHATSAPP_NUMBER . '?text=' . rawurlencode($message);
}

/** A distinctive icon per visa type (slug), used on the /visa-type/ hub and detail pages. */
function visa_type_icon(string $slug): string
{
    return match ($slug) {
        'tourist' => '🧳',
        'business' => '💼',
        'student' => '🎓',
        'work' => '🏢',
        'family' => '👨‍👩‍👧‍👦',
        'transit' => '✈️',
        'medical' => '🏥',
        'conference' => '🎤',
        'sports' => '🏅',
        default => '📄',
    };
}

/**
 * Single source of truth for every attestation service — used by
 * includes/header.php's mega-menu, attestation/index.php's hub +
 * detail routing, and includes/footer.php's Attestation column. This
 * exists to avoid a repeat of the stale-hardcoded-nav-array bug fixed
 * three times already for visa types (header, footer, sitemap): one
 * array, three consumers, never three copies. Fixed set of 13
 * industry-standard document-attestation service categories, not
 * fabricated per-service claims — same discipline already applied to
 * Sports Visa.
 */
function attestation_services(): array
{
    static $services = null;
    if ($services !== null) {
        return $services;
    }

    $services = [
        'mea-apostille' => [
            'menu_label' => 'MEA Apostille',
            'name' => 'MEA Apostille Services',
            'category' => 'Apostille',
            'icon' => '📜',
            'description' => 'Apostille certification via the Ministry of External Affairs for documents used in Hague Apostille Convention member countries.',
            'meta_description' => 'MEA apostille certification for Indian documents used in Hague Apostille Convention countries. Reliable apostille assistance from Visagiri.',
        ],
        'e-apostille' => [
            'menu_label' => 'E-Apostille',
            'name' => 'E-Apostille Services',
            'category' => 'Apostille',
            'icon' => '💻',
            'description' => 'Digital apostille issued electronically by the Ministry of External Affairs for eligible document categories.',
            'meta_description' => 'E-Apostille services for eligible documents — digital apostille issued electronically by the Ministry of External Affairs. Apply with Visagiri.',
        ],
        'mea-attestation' => [
            'menu_label' => 'MEA Attestation',
            'name' => 'MEA Attestation Services',
            'category' => 'Attestation',
            'icon' => '🏛️',
            'description' => 'Ministry of External Affairs attestation for Indian documents used abroad, for countries outside the Hague Convention.',
            'meta_description' => 'MEA attestation for Indian documents used abroad in non-Hague Convention countries. Trusted document attestation assistance from Visagiri.',
        ],
        'embassy-attestation' => [
            'menu_label' => 'Embassy Attestation',
            'name' => 'Embassy Attestation Services',
            'category' => 'Attestation',
            'icon' => '🏢',
            'description' => "Attestation of documents by the destination country's embassy or consulate in India.",
            'meta_description' => "Embassy attestation of your documents by the destination country's embassy or consulate, a required step for many visas. Assistance from Visagiri.",
        ],
        'consulate-attestation' => [
            'menu_label' => 'Consulate Attestation',
            'name' => 'Consulate Attestation Services',
            'category' => 'Attestation',
            'icon' => '🛂',
            'description' => 'Attestation of documents through the relevant consulate for destinations without direct embassy processing.',
            'meta_description' => 'Consulate attestation assistance for documents requiring consular authentication before use abroad. Apply online with Visagiri.',
        ],
        'educational-document-attestation' => [
            'menu_label' => 'Educational',
            'name' => 'Educational Document Attestation',
            'category' => 'Documents',
            'icon' => '🎓',
            'description' => 'Attestation of degree certificates, mark sheets, and other educational documents for study or work abroad.',
            'meta_description' => 'Educational document attestation for degree certificates and mark sheets, required for study or work visas abroad. Apply with Visagiri.',
        ],
        'commercial-document-attestation' => [
            'menu_label' => 'Commercial',
            'name' => 'Commercial Document Attestation',
            'category' => 'Documents',
            'icon' => '🧾',
            'description' => 'Attestation of commercial documents such as invoices, certificates of origin, and business agreements.',
            'meta_description' => 'Commercial document attestation for invoices, certificates of origin, and business agreements used internationally. Apply with Visagiri.',
        ],
        'personal-document-attestation' => [
            'menu_label' => 'Personal',
            'name' => 'Personal Document Attestation',
            'category' => 'Documents',
            'icon' => '🪪',
            'description' => 'Attestation of personal documents such as identity, address, and other individual records for use abroad.',
            'meta_description' => 'Personal document attestation for identity, address, and other individual records required for use abroad. Assistance from Visagiri.',
        ],
        'birth-certificate-attestation' => [
            'menu_label' => 'Birth Certificate',
            'name' => 'Birth Certificate Attestation',
            'category' => 'Documents',
            'icon' => '👶',
            'description' => 'Attestation of birth certificates for visa, immigration, and family visa applications abroad.',
            'meta_description' => 'Birth certificate attestation for visa, immigration, and family sponsorship applications abroad. Apply online with Visagiri.',
        ],
        'marriage-certificate-attestation' => [
            'menu_label' => 'Marriage Certificate',
            'name' => 'Marriage Certificate Attestation',
            'category' => 'Documents',
            'icon' => '💍',
            'description' => 'Attestation of marriage certificates for spouse visa, family visa, and residency applications abroad.',
            'meta_description' => 'Marriage certificate attestation for spouse visa, family visa, and residency applications abroad. Apply online with Visagiri.',
        ],
        'document-legalization' => [
            'menu_label' => 'Document Legalization',
            'name' => 'Document Legalization Services',
            'category' => 'Legalization',
            'icon' => '⚖️',
            'description' => 'End-to-end legalization of documents through notarization, government, and embassy stages for use abroad.',
            'meta_description' => 'Document legalization services covering notarization, government, and embassy stages for documents used abroad. Assistance from Visagiri.',
        ],
        'chamber-of-commerce-attestation' => [
            'menu_label' => 'Chamber of Commerce',
            'name' => 'Chamber of Commerce Attestation',
            'category' => 'Legalization',
            'icon' => '🤝',
            'description' => 'Attestation of commercial invoices and certificates of origin by the Chamber of Commerce.',
            'meta_description' => 'Chamber of Commerce attestation for commercial invoices and certificates of origin used in international trade. Apply with Visagiri.',
        ],
        'hrd-state-attestation' => [
            'menu_label' => 'HRD / State Attestation',
            'name' => 'HRD / State Attestation Services',
            'category' => 'Legalization',
            'icon' => '📋',
            'description' => 'State Human Resources Department attestation of educational certificates, a prerequisite step before MEA attestation in many states.',
            'meta_description' => 'HRD and State attestation of educational certificates, a required step before MEA attestation in many Indian states. Apply with Visagiri.',
        ],
    ];

    return $services;
}

/** Old attestation slugs that must 301-redirect to their current equivalents (renamed for clearer SEO labels). */
function attestation_service_redirects(): array
{
    return [
        'apostille' => 'mea-apostille',
        'commercial-attestation' => 'commercial-document-attestation',
    ];
}

/** Attestation services grouped by category, in menu display order — the single source both the header mega-menu and the hub page render from. */
function attestation_categories(): array
{
    $grouped = ['Apostille' => [], 'Attestation' => [], 'Documents' => [], 'Legalization' => []];
    foreach (attestation_services() as $slug => $service) {
        $grouped[$service['category']][] = ['slug' => $slug] + $service;
    }
    return $grouped;
}

/** A distinctive icon per attestation category, used as the mega-menu column heading icon. */
function attestation_category_icon(string $category): string
{
    return match ($category) {
        'Apostille' => '📜',
        'Attestation' => '🏛️',
        'Documents' => '📄',
        'Legalization' => '⚖️',
        default => '📄',
    };
}

/**
 * Phase 4+ scaffolding: same purpose as render_scaffold_stub(), but
 * rendered inside the real header/footer chrome instead of as plain
 * text, so header/footer can be verified against every route while
 * each page's actual body content is still pending its own phase.
 * The "content pending" block is deliberately plain/internal-sounding
 * (not marketing copy) so it can never be mistaken for shipped copy.
 */
function render_scaffold_page(
    string $title,
    string $description,
    string $canonicalPath,
    string $handlerPath,
    string $plannedInPhase,
    int $statusCode = 200
): void {
    http_response_code($statusCode);

    $pageTitle = $title . ' - Visagiri';
    $pageDescription = $description;
    $canonicalUrl = APP_URL . $canonicalPath;
    // Never indexable — this is a placeholder, not shipped content, and
    // search engines shouldn't be handed dev-only debug text as a real
    // page (see Phase 15 audit in AUDIT.md for the inventory of what's
    // still a stub at any given time).
    $noindex = true;

    require __DIR__ . '/header.php';
    $flashNotice = flash_get('notice');
    ?>
    <section class="container" style="padding-top: var(--space-10); padding-bottom: var(--space-10);">
        <?php if ($flashNotice): ?>
        <div class="alert alert-warning" role="status"><?= e($flashNotice) ?></div>
        <?php endif; ?>
        <div class="alert alert-info" role="status">
            <?php if (APP_DEBUG): ?>
            <div>
                <strong>Content pending.</strong>
                Handler: <code><?= e($handlerPath) ?></code> &middot;
                Scheduled for: <?= e($plannedInPhase) ?>
            </div>
            <?php else: ?>
            <div><strong>This page isn't ready yet.</strong> We're still building it — check back soon.</div>
            <?php endif; ?>
        </div>
    </section>
    <?php
    require __DIR__ . '/footer.php';
}

/** Shared "Why Visagiri" feature list — used on the homepage and the About page. */
function why_visagiri_features(): array
{
    return [
        ['title' => 'Expert Visa Guidance', 'desc' => 'Guidance from a team familiar with country-specific visa requirements.'],
        ['title' => 'Digital Application Management', 'desc' => 'Manage your entire application online, from documents to payment.'],
        ['title' => 'Secure Document Handling', 'desc' => 'Documents are stored privately and access is controlled and audited.'],
        ['title' => 'Transparent Process', 'desc' => 'Clear status updates at every stage of your application.'],
        ['title' => 'Application Tracking', 'desc' => 'Check your application status anytime with your reference number.'],
        ['title' => 'Human Support', 'desc' => 'Reach a consultant when you have questions about your application.'],
    ];
}

/**
 * Fetches embassy/consulate/VAC rows for a country. Phase 8 — used by
 * both the country overview and visa detail pages so the query lives
 * in one place. Returns empty arrays if none are published yet;
 * callers must render an honest empty state, never invent an address.
 */
function fetch_country_contact_points(PDO $pdo, int $countryId): array
{
    $embassies = $pdo->prepare('SELECT * FROM embassies WHERE country_id = :id ORDER BY name');
    $embassies->execute(['id' => $countryId]);

    $consulates = $pdo->prepare('SELECT * FROM consulates WHERE country_id = :id ORDER BY name');
    $consulates->execute(['id' => $countryId]);

    $vacs = $pdo->prepare('SELECT * FROM vac_centers WHERE country_id = :id ORDER BY name');
    $vacs->execute(['id' => $countryId]);

    return [
        'embassies' => $embassies->fetchAll(),
        'consulates' => $consulates->fetchAll(),
        'vac_centers' => $vacs->fetchAll(),
    ];
}

/**
 * Fetches FAQs relevant to a page: general (no country/visa-type tag)
 * plus any tagged specifically for this country or visa type.
 */
function fetch_relevant_faqs(PDO $pdo, ?int $countryId = null, ?int $visaTypeId = null): array
{
    $stmt = $pdo->prepare(
        'SELECT question, answer FROM faqs
         WHERE is_active = 1 AND (
             (country_id IS NULL AND visa_type_id IS NULL)
             OR country_id = :country_id
             OR visa_type_id = :visa_type_id
         )
         ORDER BY sort_order'
    );
    $stmt->execute(['country_id' => $countryId, 'visa_type_id' => $visaTypeId]);
    return $stmt->fetchAll();
}

function is_valid_email(string $value): bool
{
    return filter_var($value, FILTER_VALIDATE_EMAIL) !== false;
}

/** Accepts an optional leading + and 7-15 digits — deliberately loose to cover international formats. */
function is_valid_mobile(string $value): bool
{
    return (bool) preg_match('/^\+?[0-9]{7,15}$/', trim($value));
}

/** Renders a real 404 inside the shared chrome with a specific, honest message. */
function render_not_found(string $message = "The page you're looking for doesn't exist."): never
{
    http_response_code(404);
    $pageTitle = 'Page Not Found - Visagiri';
    $pageDescription = $message;
    $canonicalUrl = APP_URL . ($_SERVER['REQUEST_URI'] ?? '/');
    // The static 404 stub (pages/404.php) already noindexes via
    // render_scaffold_page(); this dynamic one (used for real 404s
    // like an unknown country/visa-type slug) needs the same explicit
    // signal rather than relying solely on the 404 status code.
    $noindex = true;
    require __DIR__ . '/header.php';
    ?>
    <section class="container" style="padding-top: var(--space-10); padding-bottom: var(--space-10); text-align:center;">
        <h1>Page Not Found</h1>
        <p><?= e($message) ?></p>
        <a href="/countries/" class="btn btn-primary">Browse Countries</a>
    </section>
    <?php
    require __DIR__ . '/footer.php';
    exit;
}

/** Generates a Visagiri application reference number, e.g. VIS-2026-000001. */
function generate_application_number(PDO $pdo): string
{
    $year = date('Y');
    $stmt = $pdo->prepare(
        "SELECT COUNT(*) FROM applications WHERE application_number LIKE :prefix"
    );
    $stmt->execute(['prefix' => "VIS-$year-%"]);
    $count = (int) $stmt->fetchColumn() + 1;
    return sprintf('VIS-%s-%06d', $year, $count);
}
