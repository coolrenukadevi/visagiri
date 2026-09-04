<?php
/**
 * Resource Hub articles — the real, admin-authored content behind the header
 * "Resources" mega menu's Updates column (Visa Updates / Embassy News /
 * Visa Alerts / Entry Requirements). Deliberately NOT seeded with any
 * placeholder/demo rows: every page reading this table must render an
 * honest empty state until a staff member actually publishes something
 * through admin/resource-articles.php, so nothing here is ever fabricated
 * "news". Shares the same SQLite connection as enquiry_db(), matching the
 * pattern already used by visa-content-db.php and location-db.php.
 */
require_once __DIR__ . '/enquiry-db.php';

const RESOURCE_ARTICLE_CATEGORIES = ['visa-update', 'embassy-news', 'visa-alert', 'entry-requirement'];

const RESOURCE_ARTICLE_CATEGORY_LABELS = [
    'visa-update' => 'Visa Update',
    'embassy-news' => 'Embassy News',
    'visa-alert' => 'Visa Alert',
    'entry-requirement' => 'Entry Requirement',
];

function resource_articles_db(): PDO
{
    static $migrated = false;
    $pdo = enquiry_db();
    if ($migrated) {
        return $pdo;
    }

    $pdo->exec("CREATE TABLE IF NOT EXISTS resource_articles (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category TEXT NOT NULL,
        title TEXT NOT NULL,
        slug TEXT UNIQUE NOT NULL,
        excerpt TEXT,
        body_html TEXT,
        source_name TEXT,
        source_url TEXT,
        status TEXT NOT NULL DEFAULT 'draft',
        published_at TEXT,
        expires_at TEXT,
        created_by TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
    )");

    $migrated = true;
    return $pdo;
}

function resource_article_slugify(string $text): string
{
    $slug = strtolower(trim($text));
    $slug = preg_replace('/[^a-z0-9]+/', '-', $slug);
    return trim($slug, '-');
}

function resource_article_category_label(string $category): string
{
    return RESOURCE_ARTICLE_CATEGORY_LABELS[$category] ?? ucfirst(str_replace('-', ' ', $category));
}

/** Published, not-yet-expired articles in a category, newest first. */
function resource_articles_published(PDO $pdo, string $category, int $limit = 50): array
{
    $today = gmdate('Y-m-d');
    $stmt = $pdo->prepare("SELECT * FROM resource_articles
        WHERE category = ? AND status = 'published'
        AND (expires_at IS NULL OR expires_at = '' OR expires_at >= ?)
        ORDER BY published_at DESC, id DESC LIMIT ?");
    $stmt->bindValue(1, $category);
    $stmt->bindValue(2, $today);
    $stmt->bindValue(3, $limit, PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

/** Latest published articles across all categories, for the Resources hub page. */
function resource_articles_latest(PDO $pdo, int $limit = 3): array
{
    $today = gmdate('Y-m-d');
    $stmt = $pdo->prepare("SELECT * FROM resource_articles
        WHERE status = 'published'
        AND (expires_at IS NULL OR expires_at = '' OR expires_at >= ?)
        ORDER BY published_at DESC, id DESC LIMIT ?");
    $stmt->bindValue(1, $today);
    $stmt->bindValue(2, $limit, PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

function resource_article_by_slug(PDO $pdo, string $slug): ?array
{
    $stmt = $pdo->prepare("SELECT * FROM resource_articles WHERE slug = ? AND status = 'published' LIMIT 1");
    $stmt->execute([$slug]);
    $row = $stmt->fetch(PDO::FETCH_ASSOC);
    return $row ?: null;
}

const RESOURCE_ARTICLE_CATEGORY_PAGES = [
    'visa-update' => 'visa-updates',
    'embassy-news' => 'embassy-news',
    'visa-alert' => 'visa-alerts',
    'entry-requirement' => 'entry-requirements',
];

function resource_article_public_url(string $category, string $slug): string
{
    $page = RESOURCE_ARTICLE_CATEGORY_PAGES[$category] ?? 'visa-updates';
    return $page . '?a=' . rawurlencode($slug);
}
