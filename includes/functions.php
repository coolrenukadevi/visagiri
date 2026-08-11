<?php
declare(strict_types=1);

/** Shorthand for htmlspecialchars() with sane defaults, used in every template. */
function e(?string $value): string
{
    return htmlspecialchars($value ?? '', ENT_QUOTES, 'UTF-8');
}

function redirect(string $path): never
{
    header('Location: ' . $path, true, 302);
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

function asset_url(string $path): string
{
    return '/assets/' . ltrim($path, '/');
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

    require __DIR__ . '/header.php';
    $flashNotice = flash_get('notice');
    ?>
    <section class="container" style="padding-top: var(--space-10); padding-bottom: var(--space-10);">
        <?php if ($flashNotice): ?>
        <div class="alert alert-warning" role="status"><?= e($flashNotice) ?></div>
        <?php endif; ?>
        <div class="alert alert-info" role="status">
            <div>
                <strong>Content pending.</strong>
                Handler: <code><?= e($handlerPath) ?></code> &middot;
                Scheduled for: <?= e($plannedInPhase) ?>
            </div>
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
