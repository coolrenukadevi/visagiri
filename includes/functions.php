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
    ?>
    <section class="container" style="padding-top: var(--space-10); padding-bottom: var(--space-10);">
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
